load('CVE591 Bridge Labeling.mat');
disp(fieldnames(gTruth));

fileNames = gTruth.DataSource;
correctPrefix ='c:/Users/robot/Desktop/BridgeLabelingJQ/JQ Photos/0-99/';
wrongPrefix = '/Users/christinaducharme/Downloads/drive-download-20241030T131254Z-001/';
for i = 1:length(fileNames)
    fileNames{i} = strrep(fileNames{i}, wrongPrefix, correctPrefix);
end
disp(fileNames);

labelData = gTruth.LabelData;
categories = labelData.Properties.VariableNames;

imgWidth = 3000;
imgHeight = 4000;

outputFolder = 'output_labels';
if ~exist(outputFolder, 'dir')
    mkdir(outputFolder);
end

for imgIdx = 1:size(labelData, 1)
    imgFile = fileNames{imgIdx};
    [~, name, ext] = fileparts(imgFile);
    outputFileName = fullfile(outputFolder, [name, '.xml']);
   
    docNode = com.mathworks.xml.XMLUtils.createDocument('annotation');
    annotationNode = docNode.getDocumentElement;
   
    folderNode = docNode.createElement('folder');
    folderNode.appendChild(docNode.createTextNode('images'));
    annotationNode.appendChild(folderNode);
   
    filenameNode = docNode.createElement('filename');
    filenameNode.appendChild(docNode.createTextNode([name, ext]));
    annotationNode.appendChild(filenameNode);
   
    pathNode = docNode.createElement('path');
    pathNode.appendChild(docNode.createTextNode(imgFile));
    annotationNode.appendChild(pathNode);
   
    sourceNode = docNode.createElement('source');
    databaseNode = docNode.createElement('database');
    databaseNode.appendChild(docNode.createTextNode('Unknown'));
    sourceNode.appendChild(databaseNode);
    annotationNode.appendChild(sourceNode);
   
    sizeNode = docNode.createElement('size');
    widthNode = docNode.createElement('width');
    widthNode.appendChild(docNode.createTextNode(num2str(imgWidth)));
    heightNode = docNode.createElement('height');
    heightNode.appendChild(docNode.createTextNode(num2str(imgHeight)));
    depthNode = docNode.createElement('depth');
    depthNode.appendChild(docNode.createTextNode('3'));
    sizeNode.appendChild(widthNode);
    sizeNode.appendChild(heightNode);
    sizeNode.appendChild(depthNode);
    annotationNode.appendChild(sizeNode);
   
    segmentedNode = docNode.createElement('segmented');
    segmentedNode.appendChild(docNode.createTextNode('0'));
    annotationNode.appendChild(segmentedNode);
   
    for colIdx = 1:size(labelData, 2)
        categoryName = categories{colIdx};
        bboxes = labelData.(categoryName){imgIdx};
        if isempty(bboxes)
            continue;
        end
    
        for boxIdx = 1:size(bboxes, 1)
            x_min = bboxes(boxIdx, 1);
            y_min = bboxes(boxIdx, 2);
            x_max = bboxes(boxIdx, 3);
            y_max = bboxes(boxIdx, 4);
        
            objectNode = docNode.createElement('object');
            nameNode = docNode.createElement('name');
            nameNode.appendChild(docNode.createTextNode(categoryName));
            objectNode.appendChild(nameNode);
           
            poseNode = docNode.createElement('pose');
            poseNode.appendChild(docNode.createTextNode('Unspecified'));
            objectNode.appendChild(poseNode);
           
            truncatedNode = docNode.createElement('truncated');
            truncatedNode.appendChild(docNode.createTextNode('0'));
            objectNode.appendChild(truncatedNode);
           
            difficultNode = docNode.createElement('difficult');
            difficultNode.appendChild(docNode.createTextNode('0'));
            objectNode.appendChild(difficultNode);
           
            bndboxNode = docNode.createElement('bndbox');
            xminNode = docNode.createElement('xmin');
            xminNode.appendChild(docNode.createTextNode(num2str(x_min)));
            bndboxNode.appendChild(xminNode);
           
            yminNode = docNode.createElement('ymin');
            yminNode.appendChild(docNode.createTextNode(num2str(y_min)));
            bndboxNode.appendChild(yminNode);
           
            xmaxNode = docNode.createElement('xmax');
            xmaxNode.appendChild(docNode.createTextNode(num2str(x_max)));
            bndboxNode.appendChild(xmaxNode);
           
            ymaxNode = docNode.createElement('ymax');
            ymaxNode.appendChild(docNode.createTextNode(num2str(y_max)));
            bndboxNode.appendChild(ymaxNode);
           
            objectNode.appendChild(bndboxNode);
            annotationNode.appendChild(objectNode);
        end
    end
   
    xmlwrite(outputFileName, docNode);
end

disp('XML files generated successfully!');