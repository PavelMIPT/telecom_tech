function [Data_By_Frame_With_Header] = FrameStruct(Data, Header, Amount_of_Frame)
    
    Data_By_Frame = reshape(Data, Amount_of_Frame, []);
    Copy_header = zeros(Amount_of_Frame, length(Header));
    for i = 1 : Amount_of_Frame
        Copy_header(i,:) = Header;
    end
    Data_By_Frame_With_Header = [Copy_header, Data_By_Frame];
end

