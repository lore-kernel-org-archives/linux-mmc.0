Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA97C3F5BD4
	for <linux-mmc@vger.kernel.org>; Thu, 18 Jun 2026 12:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781787549; cv=none; b=GCltLspLyn6Jo73wGJvxWapSuT08cnyaD/gNsgBuZbiTqp2uVKpzrTIdwZouAnTwqMRRbhnBLHvOTGrfWk9DSJ1cp/jY77sfgWrM5ad3jkncfnox32QD3NGG+m9afVxZ4LA61LqLwupbUVELjy8ijeDctnt8HWswfbpKjbKWJL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781787549; c=relaxed/simple;
	bh=PNtWWUZnOoeuRuQvHHH8ESeBdiXIxik44bljZe73FdQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sp9Sd2XxNtx1zSZ485nAtKnoj/5DTTvHHbFeqNo6cLRrGPSEt2NaQHikBAyg78lwhQEU5DzOe4YSz5BcrKRL+P9ResAUh9ObxqATzJ3qUipoAxvBO8269LSPeZ3kPpJcpOuOu8ty3E8Yaa1L0ST1k1lhdJcug9vPznNuYFtvRwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=opW2ZeLZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jAOaLxhf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="opW2ZeLZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jAOaLxhf"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65ICttb51599999
	for <linux-mmc@vger.kernel.org>; Thu, 18 Jun 2026 12:59:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PMYW4I9dC9wuzE1yOpLwjXPmFQ01enmrDtWrZvFEzpU=; b=opW2ZeLZpjprwV8g
	8F6I8NDeMHvWwODi4f5Rwck5vmlqhPcEzKgamVFo0mmVZHdREVUd+jSf+ii2L+il
	64zFJOOGpKEtnyGCadV3m1HFZjHzUd4R84lkPtdGyO2pZVhEaCtie9lcF4FRx5a8
	+AzP2KNPIm1ATPoOz7LGHV7Fx13m35Fa7rfL+vzhmovAkg0hjBXEX+NcjinmmPLT
	J/+l7pjwHpuAuAyavW5MfNArfBHGXUjRNLPQHgo0eb9uC6ACT/laUbmWe7QzB/TW
	ghXtj3zHKsdmN7J/X3ZX3003CJhU0fVc66iLgg1Wzw8F1RTX7dy7ccFzl9Gr2NS9
	8FspRA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ev1wc36kh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 18 Jun 2026 12:59:06 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-915737aaf0bso17718385a.3
        for <linux-mmc@vger.kernel.org>; Thu, 18 Jun 2026 05:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781787546; x=1782392346; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PMYW4I9dC9wuzE1yOpLwjXPmFQ01enmrDtWrZvFEzpU=;
        b=jAOaLxhf5xHaILHMYrndKw3LDZcmjDTc/yiz8Gyc/wm+Wdeq5votWFaP0CFPgBxXSE
         rIh2AceTzI3w/14NVQ420FNaQjqqsEGZClyWmCw3ThrZY5FGIp4HVKEACYBpwguMf7FT
         TBvt4IiZOoIqlEbUGr894AQaxWvHy6iWyLVg6czWB1MZjq55NWRtnbTZXlX0Ay8ivVBi
         DOuhlJm4ftGVNdHCfNPtPHnAmFP8UC51Mf7eOcsIzbsa7x3VR0lQlFxmUP3/RppLu4Zw
         mCHl3DTnM4tGQpE4qhejWe8kSFkhV6UMF206/kA/M6d9hSQpOuaVNh7M24zc+S5k3WcE
         HwtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781787546; x=1782392346;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PMYW4I9dC9wuzE1yOpLwjXPmFQ01enmrDtWrZvFEzpU=;
        b=szUJyfNyBilpJVUUcdkXfR7xMqiDtEIazmSVTKe90GQrzWQuSCubwKPCaidm422S4W
         M8Rwg2/Axb9JgvfKopO8uzpkPGQdYxsVOBjNpOyzV+7P3gdveKCNwlVj2bg3hBDuAscQ
         TjXtU3h14aX6dj5tBtfAc5AhXptYxJZPiJTQC1MbR0p379VWq69apsghWoJqIluSae3s
         AScgoO/9f+Nc9PG0cEIUp+8ttzoJThdIwurURMS5re6dyvM9KiUMZqu70L/+vm1EZKiv
         vMDA6chRleeWUBz14z+2T73pf9S/0CzxmBCEkAEYsDl736tw0W4GzVj91z3uh/vTWBSl
         5yTw==
X-Forwarded-Encrypted: i=1; AFNElJ98ASsB0o59ml7qDcl/g350u+tMzvi3fivzfLnyB6DJ3DwQbDpe5yj5VK/10sEO/k3YigkMkQ6kAKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3aNyp6+4gFYHtPRB4aCS2pEEeu5doMfavzlKXOpwtI9qkKmFj
	Ui7IgTtNwuhGJlIRbvZ5a/avh5j5oEVwc6a2Uo619oicU/F4wtWs9GtL0/eZDEtLFOfQeZgnhxH
	ZsvnhUAkB01oBndjf2HQW+IYRJXF1K0Shykw5+1mUg61E1Hbzj06rng+ULyJYSn4=
X-Gm-Gg: AfdE7clxuL6Kx0QNGFG4LnNsJzyMoi5GWFSCwGrMyIKKouqZtlRLRVvmiMgFWv9FLkl
	QtSMsdiW44m+5ICNUBpTQ2SqzCwr0dotpxRBCN+y0P33gL2gyqOUUc+6ujw/9/ZYwacQ5WoQ2mm
	1KY+HmDEcC18Aoc7zCjicOlHXOc7oG+zDLuV/NhKlPVo+lDXEtjytssEdb6ttzhOB0IS3WqyWl2
	QSHYDgxQkQNJluAK95znYVVd0lI/SPl4fl55H3gh+/3I7tWOStzV2eP9EuPE/XN/vDYFu/dj7J4
	+J+GfLrPLb1BW3RrC53ywJNznTYFeUC4HfHTHLjvM2v4Ry7HoG49cYcY4+HrWigWojvRgKsnUSF
	bOvDNXWVgTILOvOgqNIHxNR4LOQor0LAn+Cg=
X-Received: by 2002:a05:620a:d8b:b0:90f:7ce2:3019 with SMTP id af79cd13be357-91dbd008667mr777219385a.7.1781787546055;
        Thu, 18 Jun 2026 05:59:06 -0700 (PDT)
X-Received: by 2002:a05:620a:d8b:b0:90f:7ce2:3019 with SMTP id af79cd13be357-91dbd008667mr777214485a.7.1781787545637;
        Thu, 18 Jun 2026 05:59:05 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c01d667f63asm676768266b.19.2026.06.18.05.59.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2026 05:59:04 -0700 (PDT)
Message-ID: <06999033-1c2f-4203-bdcc-d8e94ed281b7@oss.qualcomm.com>
Date: Thu, 18 Jun 2026 14:59:02 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 3/6] mmc: sdhci-msm: Set ICE clk to TURBO at sdhci ICE
 init
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
 <20260609-enable-ice-clock-scaling-v11-3-1cebc8b3275b@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260609-enable-ice-clock-scaling-v11-3-1cebc8b3275b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=TMt1jVla c=1 sm=1 tr=0 ts=6a33eb9a cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=QyXUC8HyAAAA:8 a=kiQjUq8FSzjVjtPiR3oA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: SVucHDN_tqOFmw68_gbnPOchiBK7Eb0I
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDEyMSBTYWx0ZWRfX4yIaneBswCpq
 jEaNN41I+Fk4avDj8FQeL+bu9nk2xBogi/+i1AztT/9rUoS3eQNOPgG88B84FvpInPu46g2BVOm
 isIjEJvsZotXKOvKKv/yTtDnYL5n8fg=
X-Proofpoint-ORIG-GUID: SVucHDN_tqOFmw68_gbnPOchiBK7Eb0I
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDEyMSBTYWx0ZWRfXyzhaXGJO6BRY
 UXzCbNhlYoqxIpPZUDwB+4XTVsZ4zNXLGGmrXTHmNC1OIXk+5N5tGCyHSXA5vptAaDHrM2n6g2j
 n5CsGa2sFfsc+8EiZgLjMnip/6X1fDD0XKJZp6KwMonvrDMeV2/5VWKHu2LqqE67CemexFdCW5i
 RYt4S2X9h7obE6P+gE5IIwhRvQnN5+aOZy0AlBOJHiNH5njvivMedMMSiQlvsT20RMQicg8R6Ty
 nt5/ML3cTXq2EFqFXHtinOXzBbd2Qerke+Tbkaala/Npiv09B4skVWDcOIbGZcVzxbo1aZj6riM
 /h1utm2/ywvTC+tuSEtx3Ndqy+bVzhEVaikXQl3q5JUeHskywi+dcdnN7V0zhmKdRjgwTaQctYO
 XZAfV+8hDu8ADoiS1IQP9fwvLpfMttUPZYGLtzSTHu7jR03fDeN3pNLZuH8HCb1cNXT8SvTkJe6
 xtFf2gRVj1qVrK79+qg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_01,2026-06-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 suspectscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180121

On 6/8/26 11:47 PM, Abhinaba Rakshit wrote:
> MMC controller lacks a clock scaling mechanism, unlike the UFS
> controller. By default, the MMC controller is set to TURBO mode
> during probe, but the ICE clock remains at XO frequency,
> leading to read/write performance degradation on eMMC.
> 
> To address this, set the ICE clock to TURBO during sdhci_msm_ice_init
> to align it with the controller clock. This ensures consistent
> performance and avoids mismatches between the controller
> and ICE clock frequencies.
> 
> For platforms where ICE is represented as a separate device,
> use the OPP framework to vote for TURBO mode, maintaining
> proper voltage and power domain constraints.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
> Signed-off-by: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
> ---
>  drivers/mmc/host/sdhci-msm.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index 0882ce74e0c9bdddd98341a67b97bcef74078e0c..b655bcb5b90c0677bbe3dc6140de488038fe5ee8 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -1901,6 +1901,8 @@ static void sdhci_msm_set_clock(struct sdhci_host *host, unsigned int clock)
>  #ifdef CONFIG_MMC_CRYPTO
>  
>  static const struct blk_crypto_ll_ops sdhci_msm_crypto_ops; /* forward decl */
> +static int sdhci_msm_ice_scale_clk(struct sdhci_msm_host *msm_host, unsigned long target_freq,
> +				   bool round_ceil); /* forward decl */

Can the definition simply be moved upwards?

Konrad
