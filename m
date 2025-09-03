Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B848A2FD1D5
	for <linux-mmc@vger.kernel.org>; Wed,  3 Sep 2025 12:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756902559; cv=none; b=D9Wv/qn+oQxeDjjM0NhAPtcFRWrKmF+7FtZjkzOhfWd913vD0ORXU/oiguzlO8XCkSLeIgZ6gfcH1Ub7tcnNuvS+Dr2Ar9yXSigD0Pd1B7ze7RypHdfKD8a1SeOArNNc+Kwm5kO9QUYRroXiKibYyN4JXP4spJ0iorW7f0tRRO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756902559; c=relaxed/simple;
	bh=A9dV9MzzRS7f7sUmnjGGXBEY4rJvJ9sPSX+m6Kb3Hy8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zkc+S+/d1cZ9tFlO6t4zIN/HR6eev5sLSZ2jb4H1LLn/50yGK3gkO3H68VaTZH3CxiprFYbtxvYwI0hYgqJEP/aLfQn1jBV93iab7exHl4tMp70pP75aVS4jbzUed94kcMQS4VFoM9kR0lmFiWsChqQTzZjvN03fI/HQXIE+E1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ktaQ4/hw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ktaQ4/hw"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583BFF6C023480
	for <linux-mmc@vger.kernel.org>; Wed, 3 Sep 2025 12:29:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iJkiE1eASptH+38OuzSM8e8j/YvwckD1P++seiOH/6E=; b=ktaQ4/hw0RXqJQcW
	orKU/NIKtA4oz1uuQ/u9nH7pzROaaeOEWbG+RGzd+5H73sRS7NP9Gqn3I2n8OYnl
	Kb5bq7DQgsB8nihYtM2dfpuRxu1f4O2hcjzBqWkMKin+h6LjZgQQghKP7CuMY3jo
	RUr/HTRWT9TRs2Wu8Jbxl0Oz8ZDiPtFV2nhUEMSYDbgsJMP81Ob4MvNqRWfR63Uu
	CGkyhNi02mDwa12V/cCT93voqHAzt6Asi6Lu3Ss/fwfn3d2b/I/Vyk9rAi8ytaGS
	GWCHOpOnrW4jPCWboawHPqL7rrnxUlIUgRPd4+spMEk7JxFBxAgKPVeheE+2flm+
	zVPlEg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48uq0ekrnu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 03 Sep 2025 12:29:16 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b4bcb1e32dso625811cf.1
        for <linux-mmc@vger.kernel.org>; Wed, 03 Sep 2025 05:29:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756902555; x=1757507355;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iJkiE1eASptH+38OuzSM8e8j/YvwckD1P++seiOH/6E=;
        b=lwNA/xQIC3IvRWSh10i+iOtZSQwKXsoaybuzgq+AToDRYtj5WcyDkiQCZN7yNYb4Ef
         OE6lvIwh29V5iqud6P/HXaNdGyhE7Hnd7zXi2d1a+KTEMBsGoM1up3s6Uxloj1I2RaFk
         IGeTxmYd3sVmfsssU/MsB+0pmvzaznzSJrj4UwKlp+8QoMWwIguL+7BFnI1r5Axs4oOo
         fQumwv4LyutuTpPOqkRa6awkRG+cWULDAwChvtjCkNSkoWZ/2p6WBgLHF7AFcmKZvsva
         lQnPN8P3wmRbHwsgf6zU3V1bvE3MCBnM4JKqymm2SPzT4HuK2cL4bNFzTxzq/CfvWYO2
         Bbng==
X-Forwarded-Encrypted: i=1; AJvYcCVdE9ZLvzmc7pkDvkK6e0LkELSmc7cDV5eDU0HfryaMRFObLcgFmMQ4dM638tBhaZ5YXgu+BtuEwFA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJIMdbMk0v6licv5FvHe/iHSOzYr96bYI/JD3i82r8uMMiOYLd
	edlkXy81z+4IEKgiqYhJDJx3KoIqRP5rOUIri8hhK5MhDxsNytt1R+uJGUWSwCI4sBa+1dakEoe
	VedFfylC/RZ66J8jEvdgk94u+ELvRoWrRBw/SQzfuOo/7Spr90LO7rSzZViwNKhY=
X-Gm-Gg: ASbGncui3DOvYKQIzh7aFQXfitl/DuipofeoF4pdsCZ0GLpN3ReBg1mAR/Uh55eYodY
	Rrygjx6FqZB5SLt5zquaUpuIDLXjlHyv0fDiIzzHtcTTDmEiewzvKFHOxx/HNsg6gd+V4oPRSv6
	/4smCaRhBOa1LXdJuSdsExSrJdBkbnTNQ9a6GpU6Si8z+ncK91T9fAmmWDcdwwGgtMmbSpXnvAw
	bRyO7sfN8QNeBK0ZUN/37Q9iJyWQ6EfGgKbEhWJqdUaQebloRWxsII/VpvGuUkHfk+TqGjklqp8
	9Dqif+nO5Bdco72/+ueGTok26qJBnBtvc5TPA4aFut0QjhFgCLUxCaYMOFi9RgQVcMNXEH41R1I
	TfI52yf1JPirfuv24j8UkKg==
X-Received: by 2002:ac8:5d87:0:b0:4ab:5c58:bb25 with SMTP id d75a77b69052e-4b313dd02a0mr130174081cf.1.1756902555296;
        Wed, 03 Sep 2025 05:29:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJ1Zwf24euReXChwxJjl+rksidozMJsPEhiBEXPVc2h9t0ygR1jUfMZwAeRpN+DG+rD3vmEw==
X-Received: by 2002:ac8:5d87:0:b0:4ab:5c58:bb25 with SMTP id d75a77b69052e-4b313dd02a0mr130173701cf.1.1756902554729;
        Wed, 03 Sep 2025 05:29:14 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b046cd5c274sm117531466b.98.2025.09.03.05.29.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 05:29:14 -0700 (PDT)
Message-ID: <39c258b4-cd1f-4fc7-a871-7d2298389bf8@oss.qualcomm.com>
Date: Wed, 3 Sep 2025 14:29:11 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/13] arm64: dts: qcom: lemans-evk: Add nvmem-layout
 for EEPROM
To: Wasim Nazir <wasim.nazir@oss.qualcomm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>
Cc: kernel@oss.qualcomm.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        Monish Chunara <quic_mchunara@quicinc.com>
References: <20250903-lemans-evk-bu-v2-0-bfa381bf8ba2@oss.qualcomm.com>
 <20250903-lemans-evk-bu-v2-4-bfa381bf8ba2@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250903-lemans-evk-bu-v2-4-bfa381bf8ba2@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: KG4_r1rRiv7qA5kTWEoYx7RT4wsaW7uD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAwNCBTYWx0ZWRfX3ymHncOa4RWL
 r0+Cq51bQuw99sdXJ19IOLP5Cn1HZXc5McbAWwq2dFjnSZ5gAS1ELEO6mrGxSOga4SHrFbzuHu4
 5KR9TEO7HHeNtppFIuSuKAyzMYhR5fP5pYbrT1Z+gSeFvQlOjpm497+r5Ig93mPOhdXCdAx86qf
 9TcFosvefF/w2WVlSanAzS9JcJbkgewfMmTtDtgCNJuxAd8tQhihC4vzeNNHwm/nlFW7UoyZ5Eu
 M3jDaTZiNr1XYod5I8HMUgMP+JJqS0wPpPSgt5PLt0vIpsyOn1P4jCWC9B/F0JI8moxVP8tGN1m
 5r7Aw4IIB1DDoiTLv7etiErgtYv9GnNr0js4+3WlVSf8tu9YzzdfI23ksBis1Hfu9DXDSdh3DUz
 tSitM4VX
X-Proofpoint-ORIG-GUID: KG4_r1rRiv7qA5kTWEoYx7RT4wsaW7uD
X-Authority-Analysis: v=2.4 cv=ea09f6EH c=1 sm=1 tr=0 ts=68b8349c cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=UjL6BNg2kQWBM-km_-QA:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=a_PwQJl-kcHnX1M80qC6:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_06,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0 phishscore=0
 bulkscore=0 spamscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300004

On 9/3/25 1:47 PM, Wasim Nazir wrote:
> From: Monish Chunara <quic_mchunara@quicinc.com>
> 
> Define the nvmem layout on the EEPROM connected via I2C to enable
> structured storage and access to board-specific configuration data,
> such as MAC addresses for Ethernet.

The commit subject should emphasize the introduction of the EEPROM
itself, with the layout being a minor detail, yet the description of
its use which you provided is important and welcome

Konrad
