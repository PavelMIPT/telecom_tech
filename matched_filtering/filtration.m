% ����������
% > @file filtration.m
% =========================================================================
% > @brief ����������
% > @param sign ������� ������
% > @param coeff ����������� �������
% > @param nsamp ����� ������� �� ������
% > @param UpSempFlag [1] -  ������ � ������������������,[0] - ������ ��� ����������������� 
% > @return filtsign ��������������� ������ 
% =========================================================================


% sign - IQ ����� �������� ������� �� ����������
% coeff - �� �������
function filtsign = filtration(sign, coeff, nsamp, UpSampFlag)
    %> @todo ����� ��� ������ ����
    if UpSampFlag
        newsign = upsample(sign, nsamp);
        res = conv(newsign, coeff);
        filtsign = res(1 : length(newsign));
    else
        res = conv(sign, coeff);
        filtsign = res(1 : length(res) - length(coeff) + 1);
    end
    
end 