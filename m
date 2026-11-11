Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794424959;
	b=R4E8YeeMypbN4E1SJLm9xhn6WxsAGuUTUZCJeAFUVwc8v12vm8tgjH1k+jFQ+o7TiJ6P
	 Ndpmo/dkRxFS8k/mIS9cwLhS/gIV79dYI7dimmQsAw6F0Plj8+PyvQoUOWK/64YWyUh9q
	 YV1dQYk+wwcSRa+O3zoIReEMI9MhFMRATr15WQ2/xpEYF15HfOMpFHckNJQxdkNdMK9Ub
	 XTwDTvOwO7+rLky+qFp9vdwnVSFPmojtey0mO7tJt9No0poYrI+kzHPnbbrwzhOTysQ1P
	 mqIIyDchh6l9nyVgDBxdoZb0Y2TmU3bBZ6Z1/wK9cMYUCAGUkZcbrs+vNtgPuutneTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794424959;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=ReekrPpGktMFuSDQYs4o53/ZO85RZPgLvI6NpbtxPhc=;
	b=adZvC6C+ChOy33AFgSEHNu94AcqDUETurYVH/8xXJha62f6oRrUKgRDMKEJReaw49pyV
	 JcYiicz7XTf8EmpqAo0l3778ZvY9o99EpyS01IFxagEIXjExu7IuSo3GCA4swjKkaokk4
	 HiJa1MtTuoP/PlDH9IMZXLr/086yyc0d1qZYRRpVONNXwLRcUPcLBnv82QAOpGPIsg0Zi
	 nHkBZpZUf0e4rlGInbPpzfo2P82WyCSHgld22uwd3l/E0INUiipoYNW0MgHwAQIx5r63Z
	 Hb2qTs18n0qvzM7qlRNsLO0NOG2CnTyRnmlER4hGenXXVYBHCHr8MjXwbmqOah8JHUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=a6cnb6rt;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gwPKPIay;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30C7606A327
	for <linux-mmc@vger.kernel.org>; Wed, 11 Nov 2026 19:22:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B30C7606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=a6cnb6rt;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gwPKPIay
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABJFdS03220408
	for <linux-mmc@vger.kernel.org>; Wed, 11 Nov 2026 19:22:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ReekrPpGktMFuSDQYs4o53/ZO85RZPgLvI6NpbtxPhc=; b=a6cnb6rtjgtl9v5k
	zwR8A7DkvUbAkut5S7wJvi8kO4xkz7knxYDT1LfMk8y33eE4Ip1dh0ufrudEFW7S
	UEAgl/+waZYamYSv/1vNP87MnWieZVH6sJHzayXjf81wM3SyuP8hF/OXnF3GtfgV
	c6RUbaupg9tfyaPFjJFVO3eN0TCuuo2XD8WGZo2YekeSEQc9IehNGDaHD3gzF0Kf
	nBEkl4zkEvaLE4/emMURa3So9/KiwroM2gkPwUm4oUVUIlk49vQl6RMVuuXQdr/Q
	LT4EgY/TAIimtftkQavM+XsX6SB/JZ+vxoehs89OUisn05V2iC7S0NElPjjf/Lw8
	NI9ReA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvxc600uk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 11 Nov 2026 19:22:37 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-36a3451ea93so4912239eec.1
        for <linux-mmc@vger.kernel.org>; Wed, 11 Nov 2026 11:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794424957; x=1795029757; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ReekrPpGktMFuSDQYs4o53/ZO85RZPgLvI6NpbtxPhc=;
        b=gwPKPIayP4tlurdE6bKoRAf0yWHwf6bPts3+foXWrYuPofxU7YrJqYuxdPWDkuVgDK
         a4qzvR8Wum0bAlRYf3UgiPavOeBGgf2fp6SgI5pIZShzhRflkG7LT/UN9MyXHfNUdrZo
         hNstLmUKb/lsHq/AJN/rPSY8sG3iSTkla7tR+MTvjRbirQ0CF+2AQ9CONkbnXwb2POrW
         kMLkcNU/NT/ZuhDFjiV7LukysmZbPhQ2z4F/5CVrUwR2qzOQ0g5g7ocWEqWwV9FaTPcS
         hD/SeIP5MpSYdClmhd/w+1CUY3M90eRvTore2vhwvO/Jy8mL0W2P3oRF1+rLQ+3H85og
         G2Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794424957; x=1795029757;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ReekrPpGktMFuSDQYs4o53/ZO85RZPgLvI6NpbtxPhc=;
        b=cauU0EQx+1bp6Pt/fBnHM6XrlWJypT28anxLL5YUHnFHSvGD/zz5eCZbFWrYEk9CcM
         arWxsq9EXignY9sSshtBNDPI3uEer3MFUqFjccIViS2yHrPEqmIT5RL/bDJkfVSjJxlE
         z8Em1H0Rq8eOH7p2aX3nkd1ky7cQPJ2ITh9oaN8k+t0hZ6cM7KhW0ns2AnAmWg8DskpX
         fvgkkw2yT4LDlAI6CuKvC3v4icsAecFPswMVuZPGxt2DRAP2gpf8MvI6K69WBKPfLouR
         v/dxSw6cmIgwWJxvvBjfVpYO5gnvByuuhbOzE4gICkX0NTNzYihfLdGhPDiowg+02Oo4
         cxgQ==
X-Forwarded-Encrypted: i=1; AL+hErH4goq/WCMhaL8DnNAjKTyXfVeRffWn9ENWEQdQgjxfd3qT3xA/Ws3slk6R45W10XK55TXczJEh50Y=@vger.kernel.org
X-Gm-Message-State: APuU4Z8NWRRhwKysbvJ8hxL6oD6oljmFS7GzvE/5rbLPx+MAxwzE+ewK
	GpmCc0pKZ4N2PGNAo3adj6EID8ykV+IpDRN6Dp7g2OvNpiPvCCmD8bOWkoCtft1GkEuTBZX+L59
	mA24+yqGg/oGZObnFdaItcVb0KowbHVHlKGGVM0AcO7YoKAqgK1TeHTnMdiHS6VI=
X-Gm-Gg: AYBFou1q2WCNZS4XbN32x0xSBk3dnZpU4wyBNZEv0pyqdE+BtuEivIefrhIwGFst5/T
	4H16w/mdSSoUCqVHZ2a40Lj816pGwoEE0cEjhBjVCOWEmd2ME8BJiKL5oSw95GaTVyp3MU5fwUc
	ve/+zop0upYxOtn3AhV2l5Ow1JkTQcpY7JBir76YDpxS5JjYItnrFVCW9VKN/WAPR0Cjjr3Elah
	ly7wMM0m20saPSq6/s+naZ2Q+yz4vAhXSkhkjoWLMW/RM9ygPHHO49qu+4mHhi3rAyuUlhVrToI
	ZP+T0Zz8OTfZbyXp4O80Cc3PqXjmY4GYJwpSAGghEyTOMoO2vzJFRyTrPRATgxB/NSE/KFyEs0k
	Kw7mtJJsd+7Gq25YwL94xDAHRTbUVvZqSWxT3N+6AbZZVFQv3vcT6vY26G2a6/OpYFqKJx/qAdZ
	2AqgSjFrkZB3Y=
X-Received: by 2002:a05:693c:87c4:10b0:36f:9d8:4a33 with SMTP id 5a478bee46e88-376867551b7mr3870117eec.31.1794424956330;
        Wed, 11 Nov 2026 11:22:36 -0800 (PST)
X-Received: by 2002:a05:693c:87c4:10b0:36f:9d8:4a33 with SMTP id 5a478bee46e88-376867551b7mr3870085eec.31.1794424955755;
        Wed, 11 Nov 2026 11:22:35 -0800 (PST)
Received: from hu-arakshit-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37520512ec1sm17793328eec.12.2026.11.11.11.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 11:22:35 -0800 (PST)
Date: Thu, 12 Nov 2026 00:52:27 +0530
From: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
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
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v12 0/6] Enable ICE clock scaling
Message-ID: <avTAcw+DZtJ7bSTG@hu-arakshit-hyd.qualcomm.com>
References: <20260824-enable-ice-clock-scaling-v12-0-09271f583dc6@oss.qualcomm.com>
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260824-enable-ice-clock-scaling-v12-0-09271f583dc6@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: SkuCBmSXa-LYpIJ8XnUgAB7r2oJ_H4QJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA3NyBTYWx0ZWRfX4GPWXQCf2xeI
 eyfPJG56IRSE2P9kRuijIYVIbkh0Dly5prJrPYpg3dG0FpouFKrI859UAIZ4XdVVoVI1+Z+O08/
 qTvBIowcc5gSdbOlgOUJH+qyXjYKDsnVKWMOQsgVwZQNfGERKfUrOTpdYBGivZv+DB+vjHl+hqK
 JY2yaS9t1h1rNNkOODxDfYvAGzyA0jtbP6cymfTUFOE5sP3blqlNIUu1abGNOvcrueLPBkhoA2r
 ErSM/sTsq8NIe2haKFc93I8GpRbxANsr/vIQKyzxz/ARB0AygBU9lfnI+p3BjlrYIHWKXyBG3Oq
 VKCEzOz5t22suQcWH6wEAVg8BNAAEMy/1UiB4eD2p01du+R7fZn4KEeln/NNdyjlF/9gEhTlfPw
 pp/XLdVVxV1gwumhV4Q2OI7ruKGx+VEgRae1DtVjTV8M7+3Uhgvfip9e/AKuW3kqvGYrZJa3U8M
 XIsnJy5MLmMZMlJyxWQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA3NyBTYWx0ZWRfX+mBVekmgCaWi
 7634S2l4XXTvhBZHPeb0YgfLD/aL3KjCaIIIQUf/s6PhrvadPLlTLDh23NRJkTbv1K30ClpQGQG
 O7y16iTzFmVteaZnopU+wmVMb7uTox8=
X-Proofpoint-GUID: SkuCBmSXa-LYpIJ8XnUgAB7r2oJ_H4QJ
X-Authority-Analysis: v=2.4 cv=O/ysLx9W c=1 sm=1 tr=0 ts=6af4c07d cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=FeIq2xlXlOKQ0BwA5tkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_05,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 adultscore=0 malwarescore=0 impostorscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611110077

On Mon, Aug 24, 2026 at 01:17:37AM +0530, Abhinaba Rakshit wrote:
> Introduce support for dynamic clock scaling of the ICE (Inline Crypto Engine)
> using the OPP framework. During ICE device probe, the driver now attempts to
> parse an optional OPP table from the ICE-specific device tree node for 
> DVFS-aware operations. API qcom_ice_scale_clk is exposed by ICE driver
> and is invoked by UFS host controller driver in response to clock scaling
> requests, ensuring coordination between ICE and host controller.
> 
> For MMC controllers that do not support clock scaling, the ICE clock frequency
> is kept aligned with the MMC controller’s clock rate (TURBO) to ensure
> consistent operation.
> 
> Dynamic clock scaling based on OPP tables enables better power-performance
> trade-offs. By adjusting ICE clock frequencies according to workload and power
> constraints, the system can achieve higher throughput when needed and 
> reduce power consumption during idle or low-load conditions.
> 
> The OPP table remains optional, absence of the table will not cause
> probe failure. However, in the absence of an OPP table, ICE clocks will
> remain at their default rates, which may limit performance under
> high-load scenarios or prevent performance optimizations during idle periods.
> 
> Testing:
> * dtbs_check
> * Validated on Rb3Gen2, qcs8300-ride-sx and LeMans-evk
> 
> Merge Order and Dependencies
> ============================
> 
> Patch 2 is dependent on patch 1 for the qcom_ice_scale_clk() API to be available.
> Patch 3 is dependent on patch 1 for the qcom_ice_scale_clk() API to be available.
> 
> Due to dependency, all patches should go through Qcom SoC tree.
> 
> This patchset supersedes earlier ICE clock scaling series (v1–v11) with updated dependencies.
> Hence, this patchset also *Depends-On* the following patchseries:
> 
> [1] Enable sdhc inline crypto engine for kodiak and monaco
>     https://lore.kernel.org/all/20260707-ice_emmc_support-v9-0-701c86f3c25b@oss.qualcomm.com/
> 
> Similar to patchset v11, patchset v12 is rebased on top of latest changes picked onto linux-next.
> 
> Signed-off-by: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>

Hello Bjorn,

This series has been posted for a while now and I don't see any outstanding review comments on it.
Could you pick it up into your tree for next RC?

Although the series reads as a feature enablement, it's addressing a real regression: on several chipsets,
turning on the Inline Crypto Engine today causes a significant storage throughput drop without this
series applied.

For example:
Without ICE:         Sequential Read:  220 MB/s,     Sequential Write: 310 MB/s
With ICE enabled:    Sequential Read:  143.717 MB/s, Sequential Write: 126.762 MB/s

That's roughly a 35-60% drop in throughput (averaging ~50%). This series is what makes ICE usable without
that penalty, so merging it would let anyone enabling ICE today actually get the performance it's meant
to provide.

Abhinaba Rakshit
