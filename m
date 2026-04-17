Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9D335F607
	for <linux-mmc@vger.kernel.org>; Fri, 17 Apr 2026 13:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776432730; cv=none; b=cPdME9FMqrpTwPO+ecMTq47QiY3zebJmW3DAU/Hkz2hX7gnp0EP6gMVmUCRcjozpqRtaG05k8JI21Eq1IioIxDdoBejkoGHJ2mrYxn76VdgfYUymnJL6GIzJezPgvz48wokZ+XsAvdYBVkarzEvRdBcimUHD7ehtqe/WjBDrDqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776432730; c=relaxed/simple;
	bh=RFvWEcHs09Ac7BQ/P1ahsX/rY3bcE0CJB0jwJ6qDepU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DWRo14GlkMYAdy0AV6zhuqb18tqDN/CgFX9NZufvqQLz4HOJySyDS15yX2Ww4PuszFXZvSmY+PHNDnNjNWYF3YNgleyAsdRKEBym/MSpudgZkudyLpuOxuXAdy1Ac+g6wZjw2f+/0PPlzUIUqJN9iLao2mYqZ/pHZm5vkBuZG98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=d37InmBs; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=E603tFxi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="d37InmBs";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="E603tFxi"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63H9kdFX1042269
	for <linux-mmc@vger.kernel.org>; Fri, 17 Apr 2026 13:32:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/evtMQvA7PUd4sSb8YH73FDCN+57LuBUVGM3HCz06NI=; b=d37InmBsPomDCzSM
	ZYZXfMvHTOTytDN1t+lwSMuU99e3aSTq1U7Ay0qJETDRPlEZXEhivd9f05Bflkn9
	EotbJBH60D7i6u+VIoWu/404y7iDQLdR+KKoEu62CDw2XwKdVE1lKC3anMlSsY16
	D8gy+UJwaTRNAzss0UdEg3zYdKIUuY1vP9Dqyisiiuc1xt0LJD866Y5eQtWPFiFC
	RNcDJiw7Y321zOTskc9TukPKqRCIbEzrA0yewDLqp14ADJfdlsUYHjajXIKXlWfk
	gJjw5pYRemmKQ2dAjJ6HOm+ERi7TkkOlfxKMWRfYyyAMpE4IT+T4bLx4ooPofYy9
	pP7Y5w==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dkjhdrs6y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 17 Apr 2026 13:32:09 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-82f6b0a7164so1102127b3a.0
        for <linux-mmc@vger.kernel.org>; Fri, 17 Apr 2026 06:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776432728; x=1777037528; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/evtMQvA7PUd4sSb8YH73FDCN+57LuBUVGM3HCz06NI=;
        b=E603tFxikMSp9hnNnl5YMGR1ua428BD3FQM7M9J292C6jp68jlx9JoRG8uPcffR1Pz
         UizhG/HVoyBU+tmGzjs1OGp5v8h9+WMoMucL225R8vbu0LAj9Y4YGT8Pr0IqBw1ZoKYE
         XznV/CGRmsS6dM4MXQTNxMVVeLb+W2fxMt1P8IgCPqqQj8BVgpQNii0tzXotz1nwtLja
         dZcrVzKCAwoxwAeZcBHhPvbkvjuy2vbyjlFdDVzFQVUyeEkw7lP3zMaDDZ0UmW5p1y2h
         JsgcNBAvMutVrpxP2iMD0pUEUOH24sL5CYE/gHVLymKb22SgAA2YZRqsDXBYxXgM4yT9
         cg/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776432728; x=1777037528;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/evtMQvA7PUd4sSb8YH73FDCN+57LuBUVGM3HCz06NI=;
        b=PQGVdhDBVYCHubr1cdaD0NP3tUgND9NnEC7ENnjq/RehlootBhgdABM2TBhSJ8o21V
         ft+FOJ17nX3q5eZFSmEKbK5bLbkerKwp7X73RwKixsIyvs55tRXD2yYjjFdFVCC7+ApS
         nu8zqWlpqb7DyPbrq3vYFxBKKhzC8quRnCXmGhfSgJbczyr3xPkt0x3P6pKiRMKNzT/V
         N72kud2/nfiNaUtEkpQjLuUFX6H8gW5KXMvB1DOZLZtrjAjiKRaYT+y18FFeffIRJsAH
         oRw5RBN+TiJk+qS1KMJnCAIEzp3ctZzzNZv9THWqWPY9JLy6vz09uxrDZa3dm0SC+hTh
         Bukg==
X-Forwarded-Encrypted: i=1; AFNElJ8JcUsctrGels9nQwR6VA8BEVNtFgwJOCLIvcLC5U3ckRt1Om03mrdb5Eip6ULbESmk7fK2MyNRHOI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkTAv6+ExMPMwuiUPSH02cmXLxWbxQMGuxMo2U8UqcaVI1MTMM
	EiulvhP2ebkLZro75nLzum0A7OX3cASb/yUv5Xbss0ccRBUADrZ4RN2TxntEObFJ69ikEJr3JRX
	sjmhYouZH9pJW5z5T+btOphkulhf1sumL2JER4g65g5YS0zeA9+bB+D7299WqPg0=
X-Gm-Gg: AeBDieumBUu3arbbc/2bwMIejuOzkQ8uc2XsWuaCvocLSh5dfU5ZPxSyml07vAZGyHk
	11muKWuLSsMueo7BHC4QnOOwWWNJD2sOUHQUrkoDGVvEec+WGaCBd1wEhMo3eIvtznJWVsGw/Or
	98pke51zh20eVaZQqpJXg6yoIhKWX9HTB3xLcZ+HnAeTtci4AcQvA3Yc0bsg4tm1ZMQeXK//qPa
	p0PAnvlQBN34bKXWFZD8aUD6mg3WSeUghaLFFfV40vyqveeC0OI1K299Ys/PCoLUo4xhV3FPCk+
	KViftrrgbhpgR0L8WnqNWkvdFmox1su2MWwtrBQyrFRMXR0A4DQ/Gr0CRzW0+vMj0RC2ZJxVvxg
	C3BpitkY3p9m8WFT6WJWTivvyrw8avJyN65L26GVAaym4nQDpVua5GxgWJBcIUg==
X-Received: by 2002:a05:6a00:3498:b0:82c:20be:57e6 with SMTP id d2e1a72fcca58-82f8c81273emr3064747b3a.11.1776432728101;
        Fri, 17 Apr 2026 06:32:08 -0700 (PDT)
X-Received: by 2002:a05:6a00:3498:b0:82c:20be:57e6 with SMTP id d2e1a72fcca58-82f8c81273emr3064679b3a.11.1776432727437;
        Fri, 17 Apr 2026 06:32:07 -0700 (PDT)
Received: from [10.217.223.121] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e984f20sm2306640b3a.8.2026.04.17.06.32.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Apr 2026 06:32:06 -0700 (PDT)
Message-ID: <a2f1112b-86c3-46ac-9520-bf49a399a98c@oss.qualcomm.com>
Date: Fri, 17 Apr 2026 19:02:00 +0530
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/5] ufs: host: Add ICE clock scaling during UFS clock
 changes
To: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson
 <ulf.hansson@linaro.org>,
        Neeraj Soni <neeraj.soni@oss.qualcomm.com>,
        Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>,
        Rob Herring
 <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20260409-enable-ice-clock-scaling-v8-0-ca1129798606@oss.qualcomm.com>
 <20260409-enable-ice-clock-scaling-v8-2-ca1129798606@oss.qualcomm.com>
Content-Language: en-US
From: Harshal Dev <harshal.dev@oss.qualcomm.com>
In-Reply-To: <20260409-enable-ice-clock-scaling-v8-2-ca1129798606@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: zMDiK-dJCUVhSdm46qtjjYJ2FLRt0UaU
X-Authority-Analysis: v=2.4 cv=YpQ/gYYX c=1 sm=1 tr=0 ts=69e23659 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=moC-RjrLiBHrLYWkWSAA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDEzNiBTYWx0ZWRfX5HoAqRiLSQI5
 0ImgqssV8LUZLsR3i6nRcAvJysc2DvCdLEXTzGyH33DT1VaB8gQHwnEhF8s5+TX5M8m0DQucyYH
 em7Sr0pWOeFgI+8ix6X28V+qMAu7sH74S9i+dSL6EEhF1kdiWVxIsszgkPLotjYnvdJxeiqVhBD
 SwndeJGzdDhff3NcCoFAh1etsoeYh1if4FSsdBMF3lYm1CCvUPv1dQr59dzwCKH3rX8781afrsJ
 lCk9sFE6wAhqCKaS5qVc0nX0adoB8YFoIAQJATW2PctFkB4UEiz4cZybTWrtJkN89jhRS2moCuP
 q9agBr86iekK679wT20twBypTuP+4ZW/A2bMZCvpt25c16SsGen/id72j9HtWmiEvRL11sC1J6e
 Kw7sMvkYhxJDjO7pMd5BMiIKdxUuxzEuwHmMDoUQdlQDXEFJTjItLqtoGY4R3k6GDRmKbnyHDNg
 eolNk9dqujN7sFoxe9g==
X-Proofpoint-ORIG-GUID: zMDiK-dJCUVhSdm46qtjjYJ2FLRt0UaU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-17_01,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 malwarescore=0 lowpriorityscore=0
 phishscore=0 spamscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604170136



On 4/9/2026 5:14 PM, Abhinaba Rakshit wrote:
> Implement ICE (Inline Crypto Engine) clock scaling in sync with
> UFS controller clock scaling. This ensures that the ICE operates at
> an appropriate frequency when the UFS clocks are scaled up or down,
> improving performance and maintaining stability for crypto operations.
> 
> For scale_up operation ensure to pass ~round_ceil (round_floor)
> and vice-versa for scale_down operations.
> 
> Incase of OPP scaling is not supported by ICE, ensure to not prevent
> devfreq for UFS, as ICE OPP-table is optional.
> 
> Acked-by: Manivannan Sadhasivam <mani@kernel.org>
> Signed-off-by: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
> ---
Whoops, I mistakenly replied to v7 of this patch with a Reviewed-by, please
ignore that one.

Reviewed-by: Harshal Dev <harshal.dev@oss.qualcomm.com>

Regards,
Harshal
