Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280E134FF41
	for <linux-mmc@vger.kernel.org>; Sun, 31 May 2026 17:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780248287; cv=none; b=O2x/3mdpLUXOijwyem5LPgIXRLr2CeROswxnCiIcy7LXULI/tB7UDzPXZDGNyejt69hi4/wqy1vZzvuWlxu3bHlgnY9CzB4u6QatXLptufYf7GQiMbML/gUCN7nktB8qrbAGoDnTEBPcQLz5MpYaTptjSa+Izk6UgvZjlKwZkcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780248287; c=relaxed/simple;
	bh=ky3L5cRsLB+b8CxvBfdtboA2OUoWuWGplH03HCAsw88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lNvkqAklms9+hJCejEHK5CVk5j2YW1+9XtQxxmkRjAhkg2DjECMURaP5Z/Rf0irHjKD3oxYU3Rg/ZDi/RA+yTU7L2OHf1FVbnmSWTv1R3XYhJ63o7rBeeO4RGYxpEsg2jWXPyx7OErPzOiyvKTMNQCtuP3XmSNzVp7OO57HJfMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QScKu/TI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Zd6NpnrD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QScKu/TI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Zd6NpnrD"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64VB9oqM2753261
	for <linux-mmc@vger.kernel.org>; Sun, 31 May 2026 17:24:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=ljfg8GLQiAYFLZevBkHWq2Ge
	6r6LCF8k5rc/boN+Qf8=; b=QScKu/TIj1K0knnLG1Yg4AqkaKgcfVQc1Tjf/vZh
	6UcXzTMVKq+yl0YhNSZOzhPIB3QbGAO513Tcg6Bf88uxxtiFsH3i0x8RN7u6M+Cw
	yxYhuebox5vDkPrbiw3/Whki1ZyJKaVo8lT86aWI4RfwqQxrO+D6bDEZSMhrn1Sd
	Czt5PKCEtusbpozPPu/mYhuZu2YL5YpJZGs2wdFBr+0LCnLAJ1Ks8Zvlpct61COq
	8hpMgdGSc+veTVMjgMIDIIqj+0xwjz+kN8KqofTzJ6nWtd4sPQmgrENr2/Dj3v6T
	2d5tpNVi2+6Nw9Vz08jxlwdlZ0yxPn7KJswQDwLEGTUBmw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efux53nnv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Sun, 31 May 2026 17:24:45 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-36d99629fd6so919801a91.1
        for <linux-mmc@vger.kernel.org>; Sun, 31 May 2026 10:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780248285; x=1780853085; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ljfg8GLQiAYFLZevBkHWq2Ge6r6LCF8k5rc/boN+Qf8=;
        b=Zd6NpnrDTatCChSxSlW3pRWo8SBBghVCGCNS0++Bj823dvZS6o9HlcyntNEswUhX7W
         IURfZQC9ds4rMOKOABe3J39xemBwRGVoWbVEAXsCTmxRY20XnDCmeldQSe9NKwBhN8GT
         vGzHlGVjulq+XXFZJWK4ZEqxAbNYKBoHn62BIiPSURsBirUtwmj8ZWZEwUV891eOZqaz
         Y6IrsE7SWfGvV0bAil0OApViT4cSGCG3CpBxHdZ3xpqIboJbqo1uEsSDTXBJbU8i5dr8
         bXaX02fbrVOA85qwdoK0y+9IQq5IJU1nSfDYr4v5pqJVvNjQy+/DZcfeteXDXacw63G5
         3KjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780248285; x=1780853085;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ljfg8GLQiAYFLZevBkHWq2Ge6r6LCF8k5rc/boN+Qf8=;
        b=BDZPV/9UZdPEq0WRnm631LtLzxDpOPNO2XeaXrTBRgykUQm5C+TAfsngDphfce8fvt
         rqYaF4tdG5DC10OEpKzSFjTuhTSCEPpozk+WvXyrhZotRsRetyyRy7tKFEPrVVqJKL2g
         rn9Y7J4oDRKAW9I67mMtuhVoRjsnKMa1eWdBYNlF0hV/gPdHFHd4XK3SAwziDzuzSHUH
         HHyEBMUuQeIZNLC/vdNXR+VfWMs669AIykKCMFvTFfY0tbD715umNXH+oGja2rExla/P
         RifNtKzIg7Ib/+E7UBfIsycbMxevmOHGg2hzBmIXX28bNHBfZpi/pXXXOPX5NWegsblg
         yjqw==
X-Forwarded-Encrypted: i=1; AFNElJ+aOOkuX/crfQGcFlj4FfgSUrBOn9i9Zu8Ep1u9uzBRPd5M+g1a6kf9yd/K01k/JEKizPyjmxqbJ8U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZvRbGrD0E/QoDRdx8nHKHtpAYmi52WngXeFzHG2IVGG5g5UKb
	y2Unfldlt3xY5kJg4tbpDpkGBo/7qonCp1Q0l4tWQfTiZ4pU1hS6iM3G59HtuOsCqMRVpg2NE/N
	ENIgp0hyB7Oo1SjKlH10qUG4no8UV59KwnI+ND4YvGssIgusavSVxGUs6+gXGPLA=
X-Gm-Gg: Acq92OERA0RK3Jptfpl2ITQ8IOJsoN9ETaGfKTMxhDHW57fbxHCcmJqRshiTgoVghSU
	Dj2hqeO8xE0TxD7xLpJChRLL2qbspI12CfYqKuhVvKfuggoRSTFtkHRu+DSGVk0dmDx52P9EDwy
	+bdnwaMiLhgl88qeGjPiRk34IZg64dO8ZiCK6TskK5QVYmpqQHBaLB3SrdJnSORiOByuxhIimpx
	AepZ8BsWJEpzkOtu6t8Niw00VR1Eo/fkmAjkLwd7UafDnng0L0ijBBCyWw3p+f3ZhCpH4+rqNeb
	r/+vYq9D8gASIU9Wry+DuKnbqTYlNhP2DautF0iE+k4eG3jVZCN0O0TAaueY7S5h8+QI4RIsWhp
	X+oirMZhjOSQtY9iLDLI3hhRxnNSjWjEWzy9OKPzQ/rrGFOkcGMTIeE0Xl1kvuvm5hI91kw==
X-Received: by 2002:a17:90b:574e:b0:36d:635a:ac1b with SMTP id 98e67ed59e1d1-36d635ab5e9mr5465218a91.22.1780248284758;
        Sun, 31 May 2026 10:24:44 -0700 (PDT)
X-Received: by 2002:a17:90b:574e:b0:36d:635a:ac1b with SMTP id 98e67ed59e1d1-36d635ab5e9mr5465215a91.22.1780248284278;
        Sun, 31 May 2026 10:24:44 -0700 (PDT)
Received: from hu-arakshit-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36bc6b50edesm8030762a91.14.2026.05.31.10.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 10:24:43 -0700 (PDT)
Date: Sun, 31 May 2026 22:54:38 +0530
From: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
To: Ram Prakash Gupta <ram.gupta@oss.qualcomm.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, konrad.dybcio@oss.qualcomm.com,
        linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, pradeep.pragallapati@oss.qualcomm.com,
        manivannan.sadhasivam@oss.qualcomm.com
Subject: Re: [PATCH v1 1/1] mmc: sdhci-msm: Set ice clk rate
Message-ID: <ahxu1rm14pbwQFXK@hu-arakshit-hyd.qualcomm.com>
References: <20260529081045.2877910-1-ram.gupta@oss.qualcomm.com>
 <20260529081045.2877910-2-ram.gupta@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529081045.2877910-2-ram.gupta@oss.qualcomm.com>
X-Proofpoint-GUID: iKj-xOjKMs5T06hNhSCmPB6idItk-52-
X-Proofpoint-ORIG-GUID: iKj-xOjKMs5T06hNhSCmPB6idItk-52-
X-Authority-Analysis: v=2.4 cv=BdnoFLt2 c=1 sm=1 tr=0 ts=6a1c6edd cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=pPzFWFYw7oQxx3fYbUYA:9 a=CjuIK1q_8ugA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTMxMDE4OCBTYWx0ZWRfX4mOn9CEvZIXs
 MC59d2FJVTAgCSfNAYa/fiWy3ELLjhblk6kTCCVU+Kg5ZE9uqyB91MbzC3pwPwFzHCY0hO3kxhX
 4bgC9qC0fj35GcVasxRGUKj3jOTA0LkDuFHFHfAKr4SzBlwNRWKUTuhe9o2ACyPEHHoCIU2Tc2/
 ANayXSnQgaScF5vDOAyB5uPW1pE6ugLYL1nBADrqUPO6urs29D7fZzyPwoR/tpo9jooLfaLOe2O
 LgWsK/ncEx3JWg6ySTpjWfHmanFKSn3m/XSDO24SxRm+ni4xCNs6HcQDotU+fX/VX0i8dggEgYs
 0IPlOo/P5WM3RgZ7jhQUXHxjejSjeyg/d7/VuqYLiCrKeUNL8FRfCZDTHMCss58dJ6Zpg4OYCrG
 NGD1HIxoQrj75XebWCtWxm/ikJnFNLI/+wMBqfD1UONvQ8ylDRAvJ57w2s+bAMJ/zJFSTwx0oc7
 yHIvtEFua++F254otsw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-31_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 phishscore=0 bulkscore=0
 clxscore=1015 malwarescore=0 adultscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605310188

On Fri, May 29, 2026 at 01:40:45PM +0530, Ram Prakash Gupta wrote:
> Set ice clk rate from sdhci msm platform driver, needed for
> target which are having legacy ice support, and need sdhci msm
> platform driver to set rate.
> 
> Signed-off-by: Ram Prakash Gupta <ram.gupta@oss.qualcomm.com>
> ---
>  drivers/mmc/host/sdhci-msm.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index b4131b12df56..c6a073718aa4 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -286,6 +286,7 @@ struct sdhci_msm_host {
>  	/* core, iface, cal and sleep clocks */
>  	struct clk_bulk_data bulk_clks[4];
>  #ifdef CONFIG_MMC_CRYPTO
> +	struct clk *ice_clk;	/* ICE clock */
>  	struct qcom_ice *ice;
>  #endif
>  	unsigned long clk_rate;
> @@ -2708,6 +2709,17 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>  			return ret;
>  	}
>  
> +#ifdef CONFIG_MMC_CRYPTO
> +	/* Setup ICE clock */
> +	msm_host->ice_clk = devm_clk_get(&pdev->dev, "ice");
> +	if (!IS_ERR(msm_host->ice_clk)) {
> +		/* Vote for max. clk rate for max. performance */
> +		ret = clk_set_rate(msm_host->ice_clk, INT_MAX);
> +		if (ret)
> +			dev_err(&pdev->dev, "ice clk set rate failed (%d)\n", ret);

If we keep dev_err(), the failure path should probably go to bus_clk_disable.
However, since boosting the core clock to max is kept optional,
I think dev_warn() is more appropriate here and avoids making this a fatal error.

Abhinaba Rakshit 
