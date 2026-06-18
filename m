Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE0E3F788D
	for <linux-mmc@vger.kernel.org>; Thu, 18 Jun 2026 13:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781787724; cv=none; b=r3ryRC4YyViX2fRxtN6jXhW9v+jfbFOMC/bK7OJqZdB0IBzSHQP/5iAwDA9fHwXdV5o7Ayq6Y+U1D1kTHiMwVsaQGxpINVJysvXl2K4kAJubgoe+c24BWxonX8RRG9AZ1inZIYBwH/AFCap/L1Q0zfBdulHMJN8jS+PPSEkWqwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781787724; c=relaxed/simple;
	bh=OiBvJGA3rcBVkwv/W5Exjcj+7CrWvutuFaR7iOPWQ6c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YBUVJCLz77PhZZ089fdb0JhzrKIXK7tU4FuZun3YaR5LmJ4CpxCBiWl7qc8WadOmXrHbLXG/x00bAbnAvDBm3BlbxOatvXdFqsjw1NvOxAOMrQWuKdcGGy3hRAyF6MTOUfxN8Y8xF9xKSc16vMikdwTOvfEROwamQqkFMivoNPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NHVLGIPg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iVz2LprO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NHVLGIPg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iVz2LprO"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65ICunj01780594
	for <linux-mmc@vger.kernel.org>; Thu, 18 Jun 2026 13:02:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	drBtdZI1GgQ6oz1Wq7kAcWt1WrFzuxR5m4b03USirw4=; b=NHVLGIPgdZ+BBsyb
	fGjwFfMjLWbk4ynHrjgQJju4rivyvZp2sPxy50Y7WPlE9XIKqnAGhfgtnO8nY062
	++GAlMsL1C1fcy/FR3HdyYSYeR5Vmr8XIdnts4/h7j/GHJG1nr7dRQmTe/jYliC7
	cUJcTvh+XBy4xosXU+35p1rqdLIDJVx1mpBkgrd7mtwPf2RYK2sL9dsXbjyv+R4X
	Icy3Je4RAjq7BaTbdJvy34+5GyeORQY6O61cOZdHpVlDUZqysQ8qbZNtv9koFZz2
	OGSl043JFByRmP1BO+Jo+i52+a+YlVLH2fIO/De46CJ7EQcUOVupin4Ma7x8pkcW
	RrXjWg==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ev19a3dy7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 18 Jun 2026 13:02:02 +0000 (GMT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7e6f5350426so352081a34.1
        for <linux-mmc@vger.kernel.org>; Thu, 18 Jun 2026 06:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781787722; x=1782392522; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=drBtdZI1GgQ6oz1Wq7kAcWt1WrFzuxR5m4b03USirw4=;
        b=iVz2LprOEI+6RmbJQUuC7ng+gjU3AZqst5kxkc7Ki4QLdLdy8TzAD/r/c7Pzk/5I4r
         UO+h5oRDrygvACFfaJpzlBW69bDkJjEjoEjQZQQnOy848HfZJ8Z0HeyVAhV7nwGhQyXs
         Lu5AuBztfb6sqIU+MUCpqGw6h+QMgCxISyaE7Dru89BSLpaH6FvAHsPdGs15p42vrwRi
         k/eVbXxoBWsuKzeqX/oZuGhDzhsV3g7WrU83CGKl1vXUsa+HOGCxq4qP9+6OrGVgVX+I
         2O+H3qz1S4VWPa8i0l6Kid7f9mmRqyZmzoOIluqgl4i66dt+ZeIuCWiWbbRrIri8AvBK
         BvMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781787722; x=1782392522;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=drBtdZI1GgQ6oz1Wq7kAcWt1WrFzuxR5m4b03USirw4=;
        b=a1MSh9asLipc8VVfygUbB/62lJ+vzrInYeEdjAANY4OzflVMKZyVcASdDkWeziBxMI
         HxX8VrF6P1ZVWgjR5Bq+hlGGry0HHifRBROg/hLaMf7MjiHbkkFhaV1UTtUnj16Lnm9x
         VNcYIQPQ7uE8XkGpYUO0SdaIgFYej4LN6aNZdFynKKHJBDCfGOQ20b/t9Pg+xf5A3EDT
         3XNvvsWJwIuioKFsJjNdQF+xvDTjo/FGrM7R7oircQ6ylVY4q1djbzxnpb5QiG6HSyLt
         iN5ej2xix74bd1bJwbQblMxYc+Lfsh2ZxLJZXu8ChGnTqViB/SMKP4U6kF/BhN1UPyfZ
         GdJQ==
X-Forwarded-Encrypted: i=1; AFNElJ//7e8l7LevLDVQ1YdEqCM3L8gIuFLMwveWrgRubN7ecmL9gQ+r+0gf+aJIjhZo4gO2jIPK9x0NXn0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyH0Nn4FmwanMOumfU71XVic8gJzH0jCpy/EkFNj/FK9yoOCxr
	W9G+vQCp9HxkILYG5ABB8K/4z4/YgWqII9L3Bo3rIk65F4K/igfkp2FGLadzBtTo91+iUzN+cIt
	9y4JL2V73SJcNjnkDsw21edMUdVO0IGgqDYjvBpjXpALQ2LDIP8vTSA0xMC5kcpA=
X-Gm-Gg: Acq92OGqhSLfCBt6AngFUYRds+G0pGfuyw0zWbbA6GSk9KgGcxOqb2TqBo2ynQBxmqu
	lfnVxv9EVWzXw95VdfOlYc/xXgFHPd3gXwjgcCvhVdml6zYmvJDKafCxUHi+q9OpJJOMRFoWo13
	yQefRrcAcPrtyNG5+gBwjNa4PTvH1MJ0hRgR+d3KS31tzBwJeI9Q2kMMmOdsNzL2/JTpShSSTNV
	U2b8o6d9aiCpKGNxaMo3e1i51ZjzInhFXZcwkg8BnJH05novLpoFCYd7+60YCF3laJjJ48/+ZoS
	lzm05xGwbwgK3mbG1JYREReYnF0aimaIu2NH/AOe5qJvDs+rWwZjONQIz1U1hD0Bk1NWdFwyNa7
	q2pGCWAslr6HU7QFyi9xqKTjgtMlqSIOUht8=
X-Received: by 2002:a05:6830:8383:b0:7d7:ea6e:322b with SMTP id 46e09a7af769-7e91be85760mr1719038a34.0.1781787721254;
        Thu, 18 Jun 2026 06:02:01 -0700 (PDT)
X-Received: by 2002:a05:6830:8383:b0:7d7:ea6e:322b with SMTP id 46e09a7af769-7e91be85760mr1718455a34.0.1781787717537;
        Thu, 18 Jun 2026 06:01:57 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfdb4420570sm954142466b.11.2026.06.18.06.01.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2026 06:01:56 -0700 (PDT)
Message-ID: <d1232243-2f23-423b-84ac-4463eac79f9a@oss.qualcomm.com>
Date: Thu, 18 Jun 2026 15:01:54 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 1/6] soc: qcom: ice: Add OPP-based clock scaling
 support for ICE
To: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulfh@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neeraj Soni <neeraj.soni@oss.qualcomm.com>,
        Harshal Dev <harshal.dev@oss.qualcomm.com>,
        Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20260609-enable-ice-clock-scaling-v11-0-1cebc8b3275b@oss.qualcomm.com>
 <20260609-enable-ice-clock-scaling-v11-1-1cebc8b3275b@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260609-enable-ice-clock-scaling-v11-1-1cebc8b3275b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=YbmNIQRf c=1 sm=1 tr=0 ts=6a33ec4a cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=nM57NVUx0yqqE4FGInsA:9 a=QEXdDO2ut3YA:10
 a=eYe2g0i6gJ5uXG_o6N4q:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDEyMSBTYWx0ZWRfX7FPzPbDeh/+w
 Xm0SvQADKNm3ol3XUb/z9xKoxZAY04XRyEap+vHM7vjePHJ78jOPilAHy4PfJfA29expThxglmp
 kc/jar9neHxw31YGRulS0ripwSAN6v0=
X-Proofpoint-GUID: 0nB4VedVOO2SlieigHohaD8uT0kz9rfx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDEyMSBTYWx0ZWRfX1uKkTpWJVjxj
 b8c5OxmtuKABeR4SkHA+fFBJs2KGwm9ZEu6/HV2P/UkNueGDaUMElrsV8aP+DOEYl1Xm/MXEkPO
 8fQWe/lHkuqmwHAPLxvkwdvQVtTYxUYctIgwfOQL+K3SctFrR9eC48dZB8aTkEFSZ4G4P+YnW+T
 KPhVLIgNPuhgh09mMAUvx9VREwTsZlM+ermAxcBXQKl2fUJAX51mZD01wdRooEtIt7RAt3OAA3T
 XtlKpXGyMOiYwThs4vq3nFmC8dzl/inxWcvNcfLbRJgyTTdOTuCxvbpyrpN9iD659Y197403W3B
 yFUBNatQefrLkfhdc5hBDONFTYgXZH50JlHCI4BSoCEAojaQBTcoPD7782YA/QwY3gHT8WsjQ8j
 P4kMLgE3wAFRnXPnsaT65tKWL9hC4Gi9zU4xTsMFzyX2L4f3yO6Eo23eUxCIEpRjPZ+Ym3uYhv8
 /bfRyE0mMYv2j4O5MFA==
X-Proofpoint-ORIG-GUID: 0nB4VedVOO2SlieigHohaD8uT0kz9rfx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_01,2026-06-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180121

On 6/8/26 11:47 PM, Abhinaba Rakshit wrote:
> Register optional operation-points-v2 table for ICE device
> during device probe. Attach the OPP-table with only the ICE
> core clock. Since, dtbinding is on a transition phase to include
> iface clock and clock-names, attaching the opp-table to core clock
> remains optional such that it does not cause probe failures.
> 
> Introduce clock scaling API qcom_ice_scale_clk which scale ICE
> core clock based on the target frequency provided and if a valid
> OPP-table is registered. Use round_ceil passed to decide on the
> rounding of the clock freq against OPP-table. Clock scaling is
> disabled when a valid OPP-table is not registered.
> 
> This ensures when an ICE-device specific OPP table is available,
> use the PM OPP framework to manage frequency scaling and maintain
> proper power-domain constraints.
> 
> Also, ensure to drop the votes in suspend to prevent power/thermal
> retention. Subsequently restore the frequency in resume from
> core_clk_freq which stores the last ICE core clock operating frequency.
> 
> Reviewed-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
> Signed-off-by: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
> ---

[...]

> @@ -335,6 +342,11 @@ int qcom_ice_suspend(struct qcom_ice *ice)
>  {
>  	clk_disable_unprepare(ice->iface_clk);
>  	clk_disable_unprepare(ice->core_clk);
> +
> +	/* Drop the clock votes while suspend */
> +	if (ice->has_opp)
> +		dev_pm_opp_set_rate(ice->dev, 0);

The PM core will quiesce the vote as the device suspends, this is
unnecessary. Similarly, the rate restore logic will become unnecessary.
Especially since dev_pm_opp_set_rate(0) does not actually do any rate
setting.

Konrad
