Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4B435C1A1
	for <linux-mmc@vger.kernel.org>; Fri, 31 Jul 2026 06:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785478155; cv=none; b=GUMoWYvuJ6jSbTa+AmkB2NjpWC8XsQIPNzFSChXBXY9XP/8HL4XYF7SfkYghmr+RXkC560FwH+vkGcFn9atMissauY/siw1zOrD3hZ1v96fCWKATl93m9JcPHNrHhPvG7UyQn+rb3ssuUuQCIkMMflWAQduDV03CpMSkMLJtZkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785478155; c=relaxed/simple;
	bh=tvrYn5wX1UnORDJ7FWyP+7p9fMUkHJi6cXF4SbQKZ38=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CUrysEvV2+rNFGYDV2HNPrn35IDPKm/WNTy2J/6DwpcnhdQsVSRhutdeB7+gS9IMbrF0UWAfNybXxzGW/FKQOK3aB2t5IBJqKYMOjZNKqpHYvpMF1duuRDwN6TV34neKNO6kKC4HzvN0ZK4PDolzNbc+WiRUdb31PuGgneGvCas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dIkislgW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eSha3qkk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dIkislgW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eSha3qkk"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66V68vZi3639726
	for <linux-mmc@vger.kernel.org>; Fri, 31 Jul 2026 06:09:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	F4w8brG0L6gKtlFJJHYc8QCc452g7vG2q2FYJlGrt7U=; b=dIkislgW/YQBtUpm
	I2LX60GScJ9+66xqDJymVWCRKf4itp5fVPp1iFfsz9PMG10TNnkUTh0f2cL9koLa
	TPCqn1dqWpfiQmBP/DpaRotvDGyuykaN3FCarjR09jUdjBPDQVAlKBWqT71DC26M
	VrUW0HY6nkaOciatISZsQI8Cwt1Esk/ND1p3yv54S9TzxRZUyzhz5cncaebZw79u
	/1HvHQZxQwLQ0cFnx2Lb8rRFcj1CAsK9AR+M1GDStpVzy5ndcYfziSYG0TpBrOAf
	gxC7a7q7mmLTWxk2yvrQvUNnEGSbCcVIv/9lcWk78kcxHrGDPHR9aoeZi/8qsAZ7
	/+yr/g==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4frp68r027-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 31 Jul 2026 06:09:13 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-385d2703b64so1457932a91.1
        for <linux-mmc@vger.kernel.org>; Thu, 30 Jul 2026 23:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785478153; x=1786082953; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F4w8brG0L6gKtlFJJHYc8QCc452g7vG2q2FYJlGrt7U=;
        b=eSha3qkkkg/WvXhl692HbClQVGEsjDz18QToVqg1Ej4GNegg4NO7OvYTHTwo1bj9yR
         a36/51GXtbVcGbOVw/Az6uNHWB3NZH1OFLzw7EJDwglFafbJ2Qq1Ui8dFlHMUK+AzBOz
         TjiMRDWaIY30DsPz+4vQ6VaGVOUIRWiV28fPLcJPKJGVQ3U/6h60j2hRpuN/UaAB+nE+
         CT2Uj9w3+vjyywdFuKQQYgPMVp2H/Y1pkv5sk4Ek1pX//yKA/i4Sa63cTC9hTKHSf+Al
         2zlvVllTlkWYbXlaXY8gR6vNQpsPLNIYoLVitpkwwxhzBpXI0LkYSL7VHztQocbEL6MK
         WkxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785478153; x=1786082953;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F4w8brG0L6gKtlFJJHYc8QCc452g7vG2q2FYJlGrt7U=;
        b=QSB3U4hF2grpA/+OsV0uH7ASEzSfXImZb6NGtoyfQmiJ1Z2wuMyM3Pb9vJEvQXYYgS
         cQmfcKCjAbWLX6pLrQT3VO1cAp6ALlTMAesbqZ0PFE8kZpIvzKwQFNKGks8msejhGMX4
         Ov/jxOKnHm2gdYjENxQqjsG61VdHlqOqamf1hCPQ3tFlPInioGMVKmJoCi4uAfLeaabH
         TzXjPcBFUslBeHwLi6tJCvC3ZZMcxjFIy1o8yzid43lEQsh8nibVNb+QkdGJsW10/O3B
         H7eZjTBrW6m1RcDC4qOlLUiu06qc1/Z66ATxpAZVlhY3TW2Le3IZBQntEPTkMg7EHiR8
         7wQA==
X-Forwarded-Encrypted: i=1; AHgh+Rq7ZrMO1T2BSJ2taq6JyyhONvpBJhocExi0x17KnpYBsR9Ip3lj1WKgxnxDvHXLWrJ4rEAvV7w4qgo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhMBoCloQCs5odI1Av1yDhMacstCC6UjWRAYihZVhbiBxTl6Xm
	K9aaHY95usoeaBb1OAkY9qmmW//OqXoaMrz4+e/onALhUpTaBpZwxaBivy2oP2aDVI4S3py4FFy
	OhpFe+pvIJRR6JDT5OwFJR5qWiluUDN7xb1BqeX1EEjcfcq/dhv3ObU2LzzjNwqs=
X-Gm-Gg: AR+sD12DpoHS5TL/Nip84jw0SnsmpqeBwOB1phHihqH2o7JG3jFRVTnV51+K93yf3jJ
	IblTmdX7HJv9jbmb0PLOwVqrvZp/MqgcH5dyhN0YcUhWe6FzWgWO/xmGaPLBpMmJSZUkzEwzqa1
	4VtWnYveteqafpYqQ6nlJmUYMDA+lfUUhmeXKAUaMRAiRRGXQu/LCCv3ocXLq1SRxrrDxGtko4X
	OUW/WB8UxGADXUXsdBPZBVTBM7WVa6qkXYtjLc0xEYMgYY80KG3LFCUEgDPHgyDjQml3jcpaY+z
	zfKMnAMQqmPW8x/V5/W0kGn5xeZWmvz0C7AAx38NXQ52LLk3RRZbELAwOcyH7M+Nx7aXJlC44BM
	UiMsX11IHdd7Vj+vXDQEC7RqIXbsovT4SfPrOkVh4OcLXbv+9yU5F3qreOmcaOprpex3wBw==
X-Received: by 2002:a17:90b:2d87:b0:38e:7f22:f674 with SMTP id 98e67ed59e1d1-38fb2b7a1demr458747a91.11.1785478153017;
        Thu, 30 Jul 2026 23:09:13 -0700 (PDT)
X-Received: by 2002:a17:90b:2d87:b0:38e:7f22:f674 with SMTP id 98e67ed59e1d1-38fb2b7a1demr458713a91.11.1785478152449;
        Thu, 30 Jul 2026 23:09:12 -0700 (PDT)
Received: from [10.133.33.15] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38fb29ca1f7sm225091a91.6.2026.07.30.23.09.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2026 23:09:12 -0700 (PDT)
Message-ID: <714d2d25-a37b-4529-8a21-74669af62b18@oss.qualcomm.com>
Date: Fri, 31 Jul 2026 14:09:07 +0800
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] dt-bindings: mmc: sdhci-msm: Document the Maili
 compatible
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Nitin Rawat <nitin.rawat@oss.qualcomm.com>, krzk+dt@kernel.org,
        robh@kernel.org, ulfh@kernel.org, conor+dt@kernel.org,
        andersson@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mmc@vger.kernel.org
References: <20260720215645.1464901-1-nitin.rawat@oss.qualcomm.com>
 <92179b39-a6fb-4210-b41b-424f128c1b05@kernel.org>
Content-Language: en-US
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
In-Reply-To: <92179b39-a6fb-4210-b41b-424f128c1b05@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA0MCBTYWx0ZWRfXxeSeIRiqf5qj
 q9642geHVA1nRzPpciaq9dFue49WC4IWCDAIxu+uA1wb+zLDEktYAgKz2HLNPy6tiIBJK14YfjF
 n7c42NXsaXnZe0axYel86hT+Df+LTVo=
X-Authority-Analysis: v=2.4 cv=fojsol4f c=1 sm=1 tr=0 ts=6a6c3c09 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=wqKslviXCvpl4bgw-KgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: 1nCbvji7qkBF8dRlhXgxn2AnGc0xYWue
X-Proofpoint-ORIG-GUID: 1nCbvji7qkBF8dRlhXgxn2AnGc0xYWue
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA0MCBTYWx0ZWRfX8HtyfnnWz3OS
 XUHxtLiQtszqX6eVSc/Vy1c+7KS1Rex7gkkxUFKvYGhXu+315Pa8dwq9zef4SFsCqeCNE09INRS
 nbWH260oTz/eIXdBKLFvB7nowXxLtxVh1gZYGFcTDxesVjQwLxHXETXp1Z/7rk3P2gC58d1ANwv
 LslVCQFqGaVbxiAzrwhdIx8EumH4zo0AT4P/IFf39uxG43Xwoz7E999ReHw+hXDYLicKG5o11Pt
 UrU3Z0JI0BrtXuNtceZOuaOqdumZ441jTezX3L2yIfhFhvJ7VIBQbtPvgIFJETVez7yGwzyONUZ
 rMOxtIBRiADrdLYun0UYTofgrNxwuDfWNQ+gfAfz9cOUziP2g4OAXVzes6CnJBHvDC5cgYe/TRV
 LNgxXXYMTXJ4YjIMJSLFKIXtokigfCFLqol38ioFmmaJiuXTD0AjCCndaxiMCZ3nNRnsPZMnIfx
 9VXEuNmW8CxTMeFrs/w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_02,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1011 malwarescore=0
 phishscore=0 adultscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310040



On 7/21/2026 4:39 PM, Krzysztof Kozlowski wrote:
> On 20/07/2026 23:56, Nitin Rawat wrote:
>> Document the compatible for SDHCI on Qualcomm Maili SoC.
>>
>> Signed-off-by: Nitin Rawat <nitin.rawat@oss.qualcomm.com>
>> ---
> 
> 
> Please postpone posting anything from Maili, because there is no DTS
> available and previous Kaanapali, Glymur, Maili and Hawi postings
> without DTS came with easy to spot issues if DTS was available.
> Contributor did not spot them even though they had DTS internally. I
> cannot spot them, because DTS is not available to me easily.
> 
> Best regards,
> Krzysztof
> 

Hi Krzysztof，

This patch has passed the dtb check on the Maili device tree.

Thanks,
Jingyi

