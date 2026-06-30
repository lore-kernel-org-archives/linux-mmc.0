Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C083D3ED3CA
	for <linux-mmc@vger.kernel.org>; Tue, 30 Jun 2026 11:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782818721; cv=none; b=KEzhab+E4aix8JG/oxqr+5Yk/anzxuF9QhyMTHmhuGcEnZf+ib/wUpI0aN+8Aw8mv53xAZJeF50J4HfXTUBpPW/tMttmCqiwrZSvllDTQ6vQMzPN+M6mtDtzflySAOi8i7/RkleetGP3uLGyf2nMPvj5lI+LGc9bdukYd3sCuuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782818721; c=relaxed/simple;
	bh=VHv0DUGnwaDZhACPYMMQ4MZL7D26mlLGcb12H916HAA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SUEEuG1lC6DLyfxehJkT3QJxLjhmZQeWXvJ4zZClXXMsecDDRec64nz1T42KzwNtl7emLje9xs+LwzJirg/eVY9sQDMtDNpvMBH5Mpbz/p3KxQq10ZeX2UFFTnEnI/SGXyzFfPvHcUDsReDLJ5CCHIUvnqe+b8B4LyABerroyH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bOj97r4D; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OiGumuPQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bOj97r4D";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OiGumuPQ"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U9moCl1542046
	for <linux-mmc@vger.kernel.org>; Tue, 30 Jun 2026 11:25:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	32IH0+GhcMxvvSV3B8uT8krSKLLsXFNv3zLVkf5JJcY=; b=bOj97r4Dh5TpRPBn
	DFQIXdaZxi6EC5Q4QGYGKi7PgfD4SVY4G12bQxCCkwWx/uGwWY8P/HwfqfK9WcKS
	hAccou7nNNcDqcIpiDO2s9kz7r23Ao1UpOYTqQYc1zncDCtGrVY4Tswn7RcJl9P8
	rfKsDiVBSilIz3/ZEz9gzvQdOOtyEiPqSS3yjWInS18sfDLcO9tWQMAfbVc7QtAS
	9ey4eXvXuuafL0GCzIfPFeqAeKQB1TD+MA5EK8PtY6AR1N7s7+YSfRc843GyKNOi
	C9yiX4giO8rgKkuxS4OBz/zzq4ulAh+4OD2YsCHQ5jaMYWl/gU+rWtxyMdR8f3oL
	cA+F9Q==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f44v4j5vf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 30 Jun 2026 11:25:19 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51c069f73e4so3246241cf.1
        for <linux-mmc@vger.kernel.org>; Tue, 30 Jun 2026 04:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782818718; x=1783423518; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=32IH0+GhcMxvvSV3B8uT8krSKLLsXFNv3zLVkf5JJcY=;
        b=OiGumuPQRFxPXG8mNMQxWTFnM2bi/li7D+HqaGXqnEWQSwSO4OR/fhTLB3T/elJhbP
         li6ZNbYc/1uVkHWqGFQ5PwMQx0sFX3/5uf8RJxzQS5zt04O0cZWhcDRFLqgHu/04XwXj
         JRkwzeS1rtvVjD2yuE9CxQv1cDdg3OwyD+WLlOcX36meCFcNONOb6VZofn3EgNvaynCP
         7r4kMSsY5JLmEsjyTAf0ohyErps9UTR+TW9hbHDbGL0KHWevjkl5O2hbJPO3MoC2pDZ8
         7bqUN+7IQmL/iLpiMs0L9sWKvRyVies+eZ1tzNS75B2tZXo4LugkIRE7JAG8pDoL3DQk
         +iqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782818718; x=1783423518;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=32IH0+GhcMxvvSV3B8uT8krSKLLsXFNv3zLVkf5JJcY=;
        b=e4hWmINFA4uwRZvwCv5tLvyr53CVCytb+7kjyCBwm+aYkqUo2WmO6Zj6WE8AWenExg
         4N5dyBKawokk4q96hP7+BOSg0MgxlWHhWmTQ3tgFNkkb7Jh6iAtXd11P5xW58j1nvwsv
         fYNtOAHsiEPbWySE8eWPUY2wXAECsysM0hxXUnlUIYkZnOEOlhC0D/KqCDTW+WwsomQl
         vWb7n7IXvLnlzSWkTVHWc7LTHJQx5JkM/uPbkEQkCalaHXHrRIwcdDNezOjSMabjZoVh
         vQZ6+oGfdVNqzxf+h8jAHircII2tMmWtOaabfZSrlZw+6AO0Hoe07m5Zphe7DL48zHny
         Gykw==
X-Forwarded-Encrypted: i=1; AFNElJ/NV7SugTu9grfe2D2MaU+WoKKdAePbReIZh+qAq1f1rjgSty5wB9JvSSkQWxXcXxRdXeAmyKoruJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRzqq+IaWrWOf/wYefL2hqGdi4oriXWEr5xuUGnnHJRu7s7+OA
	GPLWuYmnxzVYa8wjdTYgevPpUJUHncN0FHex2gteUtR5ONgXghsTuL0fWNNXNPLAHAGkXuM5Vvf
	KVHHcLFWV+ur4dlG/qIqGjWS23EohTpYEVlX6YESKTNxXdEcaM/AUOQY6j0+or9U=
X-Gm-Gg: AfdE7ckQLljI8xZegzLLkb9A/y0HJTJKrF3FdXn9L9tqIoh4vmfuhbkAcs5of8rgY7j
	SxuJutOF/k4WfOCZtrn+QE1PoUgZS8xpviVT9LY2R92T3r7SDZskmzbsm9spgmEJ2dQTNVhcXz7
	zZ64oMbMENZOQuQSx12SPlMhGL4Gb1uaiY+h6+dpiEeLT2lQ1swPwl0zg76jbNjjm6+Vbd2SOU0
	Uo1lWM3kLd+mg9000oGhcmmWtai/a16ijAYbnPW8SP2HJBMieynMHPX8aFUSBqmWiWtPPLbYAK1
	i41VPixSFN7td8PfejdFjkURgtwKRENnsptuQlHSduow5EKQX7+h+ucfiXTyPS4blysRapftMPS
	xmadsgpMvsHD+lwqLfz3Dueltur/PT4lifeg=
X-Received: by 2002:a05:622a:2d2:b0:51b:ff1a:3d80 with SMTP id d75a77b69052e-51c108c0a75mr26146291cf.7.1782818717975;
        Tue, 30 Jun 2026 04:25:17 -0700 (PDT)
X-Received: by 2002:a05:622a:2d2:b0:51b:ff1a:3d80 with SMTP id d75a77b69052e-51c108c0a75mr26145891cf.7.1782818717294;
        Tue, 30 Jun 2026 04:25:17 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1288d16b06sm108856866b.8.2026.06.30.04.25.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 04:25:16 -0700 (PDT)
Message-ID: <56ab63c3-4288-45f7-bfea-d40046437a9f@oss.qualcomm.com>
Date: Tue, 30 Jun 2026 13:25:13 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/3] arm64: dts: qcom: kodiak: enable inline crypto
 engine for SDHC
To: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>,
        Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neeraj Soni <neeraj.soni@oss.qualcomm.com>
References: <20260629-ice_emmc_support-v8-0-1a26e1717b85@oss.qualcomm.com>
 <20260629-ice_emmc_support-v8-2-1a26e1717b85@oss.qualcomm.com>
 <ba96f5e3-6b6e-40b6-b6c1-300e862e8ee4@oss.qualcomm.com>
 <d3be45ab-0390-4d0e-8d5b-330a48c529a1@oss.qualcomm.com>
 <1a0b91c6-5e17-4330-a8ab-ac14d3339024@oss.qualcomm.com>
 <ffca92db-a3ac-4345-8477-1f53ec61ef16@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <ffca92db-a3ac-4345-8477-1f53ec61ef16@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: -khMPq5XNMuYWQqcKYzZ0vGv0sYW_6tJ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDEwNSBTYWx0ZWRfX84+J1ssOAJeP
 4wZL6g7jC7yecOcHaWwxsLjmeDNHP220s9eqh1S/W2MDuNVI+CtJ6ZBq+hgz7nkTa387y6+f4kg
 Q6r+x15Wcwj4Z0n+esoRHi/BSpS+pDM=
X-Authority-Analysis: v=2.4 cv=JI0LdcKb c=1 sm=1 tr=0 ts=6a43a79f cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=YUSBgXEUuFXLcjEF3eYA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: -khMPq5XNMuYWQqcKYzZ0vGv0sYW_6tJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDEwNSBTYWx0ZWRfX7d9KfVIY/wq6
 t/uNVTSScHdOHaWkFRbnGtxwzMDlMztihqe6/xNp5Mj4Vz+0IEbW7VNiBDz8qlz+fOFoqzmaE7L
 CS8uJvnFX1cUd00cavEtKAlHDJV+CMfq3J3OlWCZzSsLVEpQ0cl9bGUVq3e8nWJ0JgHtbqcUSQR
 y9o0zAJSwhMalniE0hOZikWb9TvhD6eLp1lHY9ZDpseqmCXuPpk1iZHXJYDHQa2zhB5kNlIdOWD
 n2TrYgd9vsZlf/56teTu/tj9stIsNnA6+Ci4qYG7F1ykIxw8AtQwjRthZ+b3dJwMYzO+yEZdWQj
 pCI/HzKhu44/SyE6G39bCqol1roF3Dnq9kDxxq3W/adrf1nlyVcTXK3Sp/jgCSrTXhkB9H438kx
 ZoOavzwx70HjUvAlU4XIBOD5ioyIHvhf4TLt9UwNyXtQGj9Qaj2jpc1sXwK52hi5y46PGb6S27i
 QKGLKMaVaZpJ2iyFw0Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 lowpriorityscore=0
 spamscore=0 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606300105

On 6/30/26 12:23 PM, Kuldeep Singh wrote:
>> qcom_ice_probe()
>>   -> qcom_ice_create()
>>     -> devm_clk_get_optional_enabled()
>>
>> If we remove the _enabled suffix and put a ice_resume() in ice_get(),
>> I believe this is no longer an issue
> 
> I see your point.
> devm_clk_get_optional_enabled turns clocks on, whereas using
> devm_clk_get_optioanl will only get handle but don't enable clock.
> Please note, clocks are needed at probe to read ice hw version 

Right, but we don't need them afterwards in the probe function. We
can simply gate them. There's a parallel effort to enable runtime PM
in the driver:

https://lore.kernel.org/linux-arm-msm/20260512033750.3393050-3-linlin.zhang@oss.qualcomm.com/

and with that all you'd need after getting the clock is a
pm_runtime_resume_and_get() before the version check, followed by a
pm_runtime_put() right after it


> and then
> later ufs/sdhc fetch ice instance using of_qcom_ice_get() and control
> suspend/resume path.
> 
> But my idea is, if storage itself isn't there(like sdhc on
> qcs6490-rb3gen2) then why sdhc-ice should even probe and check hardware
> version? as there's no significance in even probing ice.

On the developer/customer experience side, would you expect having to
manually enable what's essentially a sub-feature of the storage media
on every single board?

Konrad
