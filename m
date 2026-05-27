Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13B939182D
	for <linux-mmc@vger.kernel.org>; Wed, 27 May 2026 07:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779865950; cv=none; b=Q0IMyxQIrtLdcxF5b3Zm8c3UKVNvlJw5yVHzO5CniG11nOOyR4fsZxp9nKvVfbL0BKzj2AD//UQCMIfGKwF+TdV/RoNoM2xM+6oiKq4weoXc/SnYx9Jia5II9WDBepmaBjBR5ay/tbqkX3HHHvZCc2gNeyvmFne1an5012wyRcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779865950; c=relaxed/simple;
	bh=9UBpA1DlKaw0Ic22nYrKTCD1TparHCSI0WO2XRA1lYE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ROSy3PW5J3Dh0wjBoeNwWf7mpzAzhUeaG075izpUvf0FaaPM0ZAhdMm7YCKZ666yfu4ZKsDo5NMMINYY5Cf4dteO8g1iXgNi1Qm8uhVUdoVe0WzjDq8FLB/9qZqDDjIKg0dw9uTYYCNmjXpnxHjfQEdB1aP1x1lQcGAlG3jZAmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kdjzTCAj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BZxkWs1D; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kdjzTCAj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BZxkWs1D"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64R2WkpH3396961
	for <linux-mmc@vger.kernel.org>; Wed, 27 May 2026 07:12:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sFqDIrJjKC2IJFbPzvKdfW/q7cLOEJE24hhamOrvPj0=; b=kdjzTCAj4p7g6NBv
	6dhNZ8mo6TNx4IxOtjBmPyr6UHpoXl3t9pwDzBtzVU8abDJDEQZvPQlNRaixvcqW
	NNMW9hZDVWlIpipChxJkLQyakIJbm4BJsEJK4cZoQpCsFHHqhO8BHiHGBP+bkUgo
	jsFF39Q9Rg8msD3ACKNWkeNfEFwgqgBiA7Oq6TD9MQ59pl1cR3K1trjNTaoKbRvY
	tw4y5S+R7pdibCy+25RinBAJcR+/BLgmsAQN7ywDPFS9Bkq5MpJ87qxc57KCJ1uI
	GJWeRs3jl4aLOL23fJwvgoqqLnYS+jsIoI8h/N6dPZx6kH+/2YDekOKh8NR3tvYN
	XMK7CQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4edg5pabqb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 27 May 2026 07:12:27 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2bc977e6aedso122613505ad.2
        for <linux-mmc@vger.kernel.org>; Wed, 27 May 2026 00:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779865947; x=1780470747; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sFqDIrJjKC2IJFbPzvKdfW/q7cLOEJE24hhamOrvPj0=;
        b=BZxkWs1DM64B0VnenPPV7IOQxIdnjTl6wlWMtKmDvug09FW/8mSxkJZJpCblOc5/ij
         EF0ygFhhK/hUzkEpFRgl0QusPvgwGU0lF0MKD+jeuTodJyeP+JrMdrP6m9G1ggzZjwm5
         PQw/OUXejOXkk7XNiKDsrN6UH0HnSf7FEXFUjybfj/Ds8j5GfOBBRqlnDos9Pg8KbipR
         f0VeF5xuv8ovU2pjPRvRJKUYmx7g/wX4UdtrnhEWKgpEOS7hgzBUDntsVbqefALYfajK
         boxKsgAJadtxEk2vAye7XGvb4OdlPT8+B4iXVKXK3zgtiSDi274IlnPO3mJQEZmm2Dxc
         nG4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779865947; x=1780470747;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sFqDIrJjKC2IJFbPzvKdfW/q7cLOEJE24hhamOrvPj0=;
        b=ebiF/enrOZbKgJPMU95kiRKN2rjGw7EMDGyoiofOk+XPuFRqZHtNRtNCo6tK9tKort
         4A2ajfpG38tSnhnzpq8mvScUsZ614Yb4KgXkMVyIr/QPz9oJG0Ex4tyvUmWrMxMNfzOu
         VdTEw0Ps8+ssdxE022K466JhBNviI9n/DfS8aXn8EkbgUU836pUtxujuOfuHe/wWvzmP
         hdyBnITI/dpPLNf6FbckmBKBUhLqaWbqNf+F0CeoWsAapCFAu2UFEiKYsgqXVY5Ga9no
         ZD6GGvU/sqX2gPbH82gBuNo7Ee3bGURRbben2nTosIZLgz8keBZR5ub87WZOjYT0c/PJ
         9vXQ==
X-Forwarded-Encrypted: i=1; AFNElJ8khB6XPpkR43lyiDHxiF+ttoQRG6bpXzNfZEhFfHgrt7UQiWbdJlkOSzzfQ/0ahyY56Y7RZgbhYcE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8xDmwU1ho3wYAtaB3gQtBjtGLYFuqqaEAHbn8ViTIuG442u9J
	fbrvSVAEIqcayxIVq4/LVsepSQRCYL+Jn7IPIfhDLoSaw26UnJjvNE1/GrW0m9CdRxphryXdgaA
	uzvhWv4uqa7Ryief34/XCB5JZaAzuJsnffk1lDM8KgXPtUyjh5m0IbKru3nJpxA0=
X-Gm-Gg: Acq92OFXo4fcGcy+1fPwfKctkjIBQ49iYSIC+5/54OjA/b9NnLCBBWYpIB4HlE51lYc
	k/cl1PoKXVkj/OjVYMSPVUba145xodsyCqTPyHIF5cdruECIhHmymcyyTJ44zOAh6K5QoROTfZs
	ctuBseBglBvij4BEHob4NFQF3zoiVaIkLWkfIvvrEH88c+GskmHOeoQc67A8kMD6HN64bS3y1z+
	tB7mtaMo9kQpha7wBsGxDQ8klP2ilBOusPQvVmXOmwWA2FKGfMNmHFZRCS2ot4idmBS+jyJjR+P
	UXfgd5atNvhYEexYrpy6hxfc3OwNVVA3ZOAmIeCBS0SZ457HM2g0SYocQTkCp7S/e7RVPHEQR5r
	z7E+MNoavqRMy6tneO/2mG7oCV/Pxr7BjaaVO3vjw3MBmDGPb
X-Received: by 2002:a17:902:ceca:b0:2b4:604c:ec6f with SMTP id d9443c01a7336-2beb069853bmr239368705ad.32.1779865947233;
        Wed, 27 May 2026 00:12:27 -0700 (PDT)
X-Received: by 2002:a17:902:ceca:b0:2b4:604c:ec6f with SMTP id d9443c01a7336-2beb069853bmr239368465ad.32.1779865946736;
        Wed, 27 May 2026 00:12:26 -0700 (PDT)
Received: from [10.219.57.29] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb56ce4easm134672025ad.30.2026.05.27.00.12.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 May 2026 00:12:26 -0700 (PDT)
Message-ID: <951c9b8f-4513-47ca-afb6-481dedd3eff9@oss.qualcomm.com>
Date: Wed, 27 May 2026 12:42:20 +0530
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] dt-bindings: arm: qcom: Document Shikra and its
 EVK boards
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>, Ulf Hansson <ulfh@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-mmc@vger.kernel.org, monish.chunara@oss.qualcomm.com
References: <20260522-shikra-dt-v3-0-80ffde8a3dc4@oss.qualcomm.com>
 <20260522-shikra-dt-v3-1-80ffde8a3dc4@oss.qualcomm.com>
 <20260526-quantum-funny-gorilla-cfc983@quoll>
Content-Language: en-US
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
In-Reply-To: <20260526-quantum-funny-gorilla-cfc983@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: ywYd7qMuRTQFSXnRpQGHAVelFYBjGYh5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDA2OCBTYWx0ZWRfXyVjaVEw2RE+z
 Dejwx7dzZ+7UrA5ZOgyjuPbVjmVaYk6QyO8dVmtAXU5Nw43fkgRjo1xpeL0bTSAn4hEh416YBEF
 c/h4nMg0e/lKd5O3pv10jg7sUtE0JadBJ6XPfGckxPpiaLTmtj3MxwoQGA7J13qDRl9GulkzyN/
 pT8b0LkuQXhJ/PR4fBm8dEjZPvFQ+wJirZLv6BDKxhFT4NOmv/VnVqnPzwkFr91BAMTB3G4sutn
 Q+ea7kL/XXSEHtqLOB6uNHPn2H5vs1Ec8fdyNexqDQnIskY4bYqT77sw6DOTPWEuwhtJFoMnPxx
 cOvTxSIiHp4TB/mKQslJFO73P0yv0fF+1mnDl2E0+xcklwdf3N3SKV/v1uyjdBWMTGB8tPdLcHh
 PW55UCcgoj0Ih44TzRlAbl3jnTpwHYDe34zrGyrcBD+79+TLC64Z/TfZm1XGI/KsW4xIEEqO3JF
 DersLsS0WGSERKvAQWQ==
X-Authority-Analysis: v=2.4 cv=I95Vgtgg c=1 sm=1 tr=0 ts=6a16995b cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=kjqM9UcslzgJvOEO4JEA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: ywYd7qMuRTQFSXnRpQGHAVelFYBjGYh5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_05,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 suspectscore=0
 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605270068

On 5/26/2026 9:15 PM, Krzysztof Kozlowski wrote:
> On Fri, May 22, 2026 at 11:32:24PM +0530, Komal Bajaj wrote:
>> Shikra is a Qualcomm IoT SoC available in a System-on-Module (SoM)
>> form factor. The SoM integrates the Shikra SoC, PMICs, and essential
>> passives, and is designed to be mounted on carrier boards.
>>
>> Three eSoM variant are introduced:
>>    - CQM: retail variant with integrated modem
>>    - CQS: retail variant without modem
>>    - IQS: industrial-grade variant without modem
> Industrial/consumer variants differ often only with thermal, so how is
> it here? Thermal difference does not make them incompatible. Honestly,
> usually industrial one does not even receive dedicated compatibles.

The IQS variant uses a PM8150 PMIC, while CQS/CQM use PM4125 + PM8005. 
These have different regulator topologies and RPM regulator bindings, 
making the DTBs genuinely incompatible, IQS SoM cannot boot with CQS 
DTB. Thus, a separate compatible is required and not merely a thermal 
distinction.

Thanks
Komal

> Best regards,
> Krzysztof
>

