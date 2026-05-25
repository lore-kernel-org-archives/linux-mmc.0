Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61A73A543F
	for <linux-mmc@vger.kernel.org>; Mon, 25 May 2026 07:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779692815; cv=none; b=Evb4Bn9fMNYiCE8DMGxGQE35J0JWUo26w7/AqXD43OS2S5LDVIj8FiHe4MLGft/uyjjPPvGUfTqNoKcfcjWyL2iXSajSamBwYuEUDjyP+cuLH4r+Q2VTiRWZl4ASWK1oB8K2Gk4YdaDM6tMQlH2/L2uMDVo4wPgjvJIGoUxOZbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779692815; c=relaxed/simple;
	bh=hCe5dnACuZOm1TDNzmixfuaE5fDBmOyedweHcK1ETPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SyCHaVA9U9yrLzHqRDPZuGba847cRTfxyVIQ6nPYIpygkd87Xpn7CxsOouZ34zeK9yQ37Pj3GOKRlS+Q/vC7i/w16Pt+MoE8477kiSF6n0xPIktUJjnF8oiwWdT8fKjgIRJ1ersHdFk4XvMarsXG+15igUwrGbfeYTDclq+WPI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EZ+zGwlg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PZ1PJxPy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EZ+zGwlg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PZ1PJxPy"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64ON6BTL419389
	for <linux-mmc@vger.kernel.org>; Mon, 25 May 2026 07:06:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ImreOJpx9nKlDyipy+6af8Xk5D5pUnY1RTxb+3tQZ9s=; b=EZ+zGwlgzjBnZdA4
	23+pDezy28tPuCjH/sHywCOmQsClDyS1zvTUx2S9rHgEteLJ7EEpJj5ZlBIZXrtW
	tXpJF0egqDsf8wtUoDfqhUoMYqTz7m1HRmHUgHKQ6dHa0goyDEDvNG92agy6zK2d
	MA7chArHwYn3G75OI2qzM+9MdsJt4XtbnNCXaiZXGMRRzSzUu3vP1P+1T+LW4cIs
	vdFY8xMJFBXXbr0C4y3w/VrIOhjLUh65h0l7uRgCeI/YKx2/bWPDo2LxkRXk8Ngt
	EPrKidbfUURfq99MyfCHQbdjx/fUlpFQeriGG4NJuw+cvFM6paJCkeagjpIDbvCw
	RcI4rQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eb386npcf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 25 May 2026 07:06:52 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2babc42244aso218614495ad.3
        for <linux-mmc@vger.kernel.org>; Mon, 25 May 2026 00:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779692811; x=1780297611; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ImreOJpx9nKlDyipy+6af8Xk5D5pUnY1RTxb+3tQZ9s=;
        b=PZ1PJxPyzJQup9ETn4Mthq3BE4BofzQpoMA7PlVbWBvwOyzY1jEGCklEe0Wz7vVNui
         pZcMj/PbBG4YeQhz1iC9oJ0MQhtUN7+yB56ZRR2XqVlkbFQEg05bzSH+/ZCmS4CtcVpX
         P7zqB5/U3lXa3JpPisI8OiuQ2oTx7ID4fCSEDA0uRtrdsYJK/1JqDrocTQjvcGT6zUZS
         7iJGpyYgwN3MO3u9jlnNifCWPNivbKRKtN22jA0nvy0KhGHn49m0hk7RvuGA8zQKWPoO
         cdP+NUQAjcqO6fYh29SmirjfvsLagKgSQSLKSWHAu3D1/khUcDVOGLuArTUFbv0xCIDl
         Xkgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779692811; x=1780297611;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ImreOJpx9nKlDyipy+6af8Xk5D5pUnY1RTxb+3tQZ9s=;
        b=L+132+gmPZ2cPvD6T27KG5xUhLu8WAGA61CzeryLz1yuFjgdtTN2+JUHmPrY0lz//+
         n7+BDTlsD8gf64L4sr7LaQ13szmDbyOjmKUgdthvy1PwKT64tTwxnGZjwRQQjBpN74DR
         tYUZPPtC2enJFej/In2UYusSlPWL55ieKRAD+52uAt1AmpY1Xo/jxiMbf5EErJypB967
         B2OsurgBQZwn3jRLxlDVHTDpIn26rtpPZqojoI9aGyN78bofewy1VlX0EMuoYFeLf+yO
         imPfryIi1xVQ9W6BQAkUPGOon7aN5XGUirz3XKVKtuXlEdPGvuzyKtQy9wovTA1W9QsG
         YWFQ==
X-Forwarded-Encrypted: i=1; AFNElJ9hyr/nZJkgUtBLV/6dVX519MIwSn22zKwonIIuyxBPDUisHFSFX7urzsggOIbVLOG0g04wgjK0qrc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvxhlLpiRXvEDUIKdpdnZ1gRwuA+gSTHGZu6NyR0gggj7Iar+i
	UKQfqwg6o1dMJ05QcFy2iX3+Qhstyl0lqdV1A5lFfpbgsG2wpOPMrn+jrXRBmuAnm/VsstssqN7
	jrt0HWbmv6KMJCbnw6fd0gKgPHi8YMg7f6Tm04vx3d3VtVmzY8lYaR4MaYXVS4D4=
X-Gm-Gg: Acq92OF0it9LmDc4zGAt8dxRr9U4Qn8waA2p1VBONwkikqT4z6f115Fx4zMdA8tVMBw
	q2EIcWq0me4Y8f7+bBwV4z2IIKHR1s7CDrm1xPmtyi6Wd7YIyXlhyGB2i51/gbjRKqE9TeKZQdm
	aDv34ddzQA76gwztiN6AuC/UaD3F6FZVLdyTpIWuvj2ZVbae5qRVrjU1uiOFe/yAqK/B0Ig+m+p
	QKuYa+ZdRDzhXXqmxqlqe06moA/o2SpJKXoKB4D11UBJKCYdO7Ml507GLZLlW85aoTbLeXQxQqf
	4rOrGoFPbONjc5CvxDXK3QrfXCDYsYWxxdq00li6NYylszex4g2eDD5pBBuyFCoYKmdfy834SpQ
	jHYpx2U4s/wiUNZrrRGi2ggDUzx8dUQiVln40GnCXX0PxkmZft9wN6TMScXT/P2LihkFm4w==
X-Received: by 2002:a17:903:1212:b0:2bd:4d9e:ab27 with SMTP id d9443c01a7336-2beb05822d6mr148296965ad.17.1779692811472;
        Mon, 25 May 2026 00:06:51 -0700 (PDT)
X-Received: by 2002:a17:903:1212:b0:2bd:4d9e:ab27 with SMTP id d9443c01a7336-2beb05822d6mr148296545ad.17.1779692810948;
        Mon, 25 May 2026 00:06:50 -0700 (PDT)
Received: from hu-arakshit-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58b387dsm87575635ad.50.2026.05.25.00.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 00:06:50 -0700 (PDT)
Date: Mon, 25 May 2026 12:36:43 +0530
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
Subject: Re: [PATCH v9 0/5] Enable ICE clock scaling
Message-ID: <ahP1A1K/EXujoFuB@hu-arakshit-hyd.qualcomm.com>
References: <20260525-enable-ice-clock-scaling-v9-0-c84613e9ce47@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260525-enable-ice-clock-scaling-v9-0-c84613e9ce47@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: PJX0CYbfmyk6YKkY9Mp634WAgoIIPKig
X-Proofpoint-GUID: PJX0CYbfmyk6YKkY9Mp634WAgoIIPKig
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDA2OSBTYWx0ZWRfX6PvW7SCH42/0
 WdNmwaLtXfw+QMqtaVKu3hhTYjgG18MScT+0gwSE+RkE37pHf1JxnZA8M1T2AuDZqq3WgDarirZ
 7o4setwUIPyiqZkfVyIhdkhKfItXZoaTXd5h5HG8+Gz9gWi1RQ/FImJJGuNpgkPSCZlnQ9Ta++p
 f+lbXBjLjXX0ta847KwvUOtJQAntEDO2a0Xx8zrh2PGa0tYMowu3rm7VATXTyoGlQ5p5+m41Kp8
 Nb7jPNa/I43T2M513QBkwcZtj76LjyqLmmTdZYlfi5jY0+C+S8MOYZTtSi2IPT4z51DTKU5eV1d
 YowyuKDV1y4wAYg6LCBHi70mHP5cC0zZ4TimFY/TVTdwQ2/AsPBwLkU4zFq9xURFVZL4iLVnl25
 2RfHlxFPwU2z0orcJhlPVgGKthgkHExBEndTCPt/WCvVmOapW3ne1xSlCjF4Jwn4Yd6L2kjt1y7
 kB2zPB6+6hAOgEZBZiA==
X-Authority-Analysis: v=2.4 cv=PJY/P/qC c=1 sm=1 tr=0 ts=6a13f50c cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=p6yxZNB5brmi-_xxTTcA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605250069

On Mon, May 25, 2026 at 12:55:47AM +0530, Abhinaba Rakshit wrote:
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
> * Validated on Rb3Gen2 and qcs8300-ride-sx
> 
> Merge Order and Dependencies
> ============================
> 
> Patch 2 is dependent on patch 1 for the qcom_ice_scale_clk API to be available.
> Patch 3 is dependent on patch 1 for the qcom_ice_scale_clk API to be available.
> 
> Due to dependency, all patches should go through Qcom SoC tree.
> 
> This patchset supersedes earlier ICE clock scaling series (v1–v8) with updated dependencies.
> Hence, this patchset also *Depends-On* the following patchseries:
> 
> [1] Add explicit clock vote and enable power-domain for QCOM-ICE
>     https://lore.kernel.org/all/20260416-qcom_ice_power_and_clk_vote-v5-0-5ccf5d7e2846@oss.qualcomm.com/
> 
> [2] Enable Inline crypto engine for kodiak and monaco
>     https://lore.kernel.org/all/20260310113557.348502-1-neeraj.soni@oss.qualcomm.com/
> 
> [3] Enable iface clock and power domain for kodiak and monaco ice sdhc
>     https://lore.kernel.org/linux-arm-msm/20260409-ice_emmc_clock_addition-v2-0-90bbcc057361@oss.qualcomm.com/
> 
> Signed-off-by: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
> ---
> Changes in v9: 
> - Kodiak ICE eMMC OPP-table entry corresponding to 300MHz is updated with SVS_L1.
> - Add 75MHz for Monaco ICE eMMC OPP-table.
> - Fix error handling and initialization of has_opp variable.
> - Pass ULONG_MAX as target freq instead of INT_MAX from sdhci_ice_init as it better adjusts the data-type of
>   the function qcom_ice_scale_clk.
> - Link to v8: https://lore.kernel.org/r/20260409-enable-ice-clock-scaling-v8-0-ca1129798606@oss.qualcomm.com

Hello,

It appears that some of the dependencies for this patch series have already been picked,
and there have also been recent changes in the ICE driver that conflict with my patches.

Please avoid picking this patch series for now. I will post a new version based on the
tip of linux-next, with the ICE driver conflicts resolved.

Abhinaba Rakshit
