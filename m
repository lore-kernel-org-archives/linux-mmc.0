Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36442E719B
	for <linux-mmc@vger.kernel.org>; Fri, 29 May 2026 14:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780065922; cv=pass; b=JNX+axwlTcb20DS4FJ4jS/HUSEplMkR3M/jdk5jqd9EpC22s1o9JFBcvvE1lFXqRyGSPfGVF2z2LkDsO9WWxP+AbR1pxvboBKcRoiv+ArhVhOHiHt51vT3K8npCQaRbgtSPUYEbm9BfTIZEbcS6BZ7WT5xxLIp3rX2GdXr+Iw6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780065922; c=relaxed/simple;
	bh=RPt2Pbs4OIJEMjW3wYQoU+hrwxerOUV9T3Q8W4uhmfA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e0w3otHZn/URRznUtcdg1L+BjNLSgR28GoPZkjDI2X2RdO953TquRylaGUfdnlkDRq2BxS4zjdWeBkl6PyRNTr/I4AgYKfGERILogGEgsAlHEkbGvCglXCGMXPStcaLF9YbiGxtQ208o4Y+Kc4PwQT+ppjL3n6e2kzyojGr2dPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JoAg9die; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eg0ORdiY; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JoAg9die";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eg0ORdiY"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64TDLBpE3656473
	for <linux-mmc@vger.kernel.org>; Fri, 29 May 2026 14:45:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3WZeV+R7vtJjx8VN7aIoLifIi5r+G9G/jzToPnLZE3g=; b=JoAg9dieNzftTzNX
	KcUsiaO5TjHj5rD4g3iM2LLUQpQxnZ4beBrS9O1EOZ6FiPCC9t6Tp73TrwwnMkH/
	GNhPYtpZ38oxD4gWvuSeVJgLRt/+NZUH0IgL02a9ALNCXrKmLoEEut4ws6XdnGcL
	WqkPpqMpEhT54rBNgLlv2G5EjvJ5r/SBcLorYs2YDYm0BSSh50kbmSnZ5XXOpnFX
	bIiQRXzbtorpUYDIuXOs3QtsU2OI8D/JYFvZM8aPL1osazaUfXPcEhOJXFWkjr/N
	4vmyELZtHfb5j3II7ZX7AbEZDgY8ITGhowzTgfJUKeJNXYoAJjI/G6pJBFTONswV
	U6D9qQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eety5vqmk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 29 May 2026 14:45:18 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8badccc9194so106039206d6.1
        for <linux-mmc@vger.kernel.org>; Fri, 29 May 2026 07:45:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780065918; cv=none;
        d=google.com; s=arc-20240605;
        b=OaXAk2AVrM7Abx91L87MM+i3NEYdWMiWyQNsv/+ckJlewMuAqlz/dniGeiLKn6vqnH
         v2GonjQHwyxLr4qY3qUdyo4rdoyeWlCcKjpsujEeSsPS9gI6dnpeDBEErnC7c3er9adH
         Tc70/D4fMWinRUULIQZYqAOC5x4JQ2a0P23AdLcYADGNwXJO/5pgFOFKBSRXzQsiUKlw
         AkMxlyt6xWzWLBYr9hkzb1PNAAq1z0IaUJRl2H04uSSPilVIwp9vBMTtpqGv5YNScjpD
         8zO/o1stFf2h9kY4Frl/cSFS4ryLSlocFKiJgZkElGVwZS/2ts3cwKc4B6ItP+xK3Leq
         q7yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3WZeV+R7vtJjx8VN7aIoLifIi5r+G9G/jzToPnLZE3g=;
        fh=CtqJKoowT1zYwz7H53eeQjYEtzFL0cp2bcHALadWtx4=;
        b=Ejvg3EGlcpK2OQvvaNIC3D1JKtUgiY/iRdJw8odxYLg6kyU7eSr9MrxQ9eF3/O8r0d
         wY/rUI2yrjoY4MlFKt1fxIkjZHY7B4SFPJFuv+2xk3dEKtnDz6iu6QYNC0SWp3JGbG0D
         zSGcXt/7VZ/a3ouon3iTLYyjaTqH6p7YZL89XASOS02n8Gt0kBYpoK9DRWEqIZmjf/sB
         6wGXWRFiHvd7ARGw42lm3AB1DNiMIOtFrQK/UimIwj+ZcDuBbOFy5IwZ8Uq4MMlmc38t
         ZbhNBzaxHBZdpJzRPXQeYM14Yt1n0JLE60SkJ5htnmVfPP+SnTWOjQ0c4w/djsZRyiMG
         ULaQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780065918; x=1780670718; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3WZeV+R7vtJjx8VN7aIoLifIi5r+G9G/jzToPnLZE3g=;
        b=eg0ORdiYMCXAnXRWwau4RVk6DkL0zCukkTuvkQmb8/MIPyh6igqngbox/78jXcxaH/
         JvM3G1F6sL0a4rgnh9JKQXRAQ8AoRppWIZufnD0tvB+0YSDIw5nk+4x7HEXr5LJYlkyZ
         Z8xwk7y+RVGhTtb7jKxLVMs3wSevIqII6OMXM0sjQtBJ/m00sUyZAEXJVcbfKrcC1sNa
         ftxJg/sCx9kENFK7YNrFSf/nCW3ITS5DlJyG7UKdnOTZsm7bgGvi1bFgnzpyVRBektCG
         wnLiGR+ypgNkleACY+ykZqg6sj8AelBUW6J/iBNHVFwefOQf0YsE0iV310K+rXNOO2T4
         mrxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780065918; x=1780670718;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3WZeV+R7vtJjx8VN7aIoLifIi5r+G9G/jzToPnLZE3g=;
        b=AmKkE6EItDbyts6CBkdFtmm9+brgvC4dG1szYFnpEqPUkh/BXx5fnF7sVhBM7fCHMm
         CsLbDn1ki9mWF9UaqOPnTcKYj2wXo2v4PzqXeNVvqD5MAb9XQAxQnZKnh43V8/MT+HIM
         jnITVe7oymeELZCsdvhpLzpVh+vqAP8iJfq5d+PDmmru9G7NP3RcYqsNWo/lLt1d0hkk
         0boRTCRGXBvQ+oeyolxlshDDBwtWgQM1b4qCGRX8xFwj+X3SZCr6vPsGAAw1BgZ3Sa02
         LKkIrKXl235+H/ANi3SFyXP26lPdAVFoxfOiA0Ou6ju6jNHjuI1Pw5iAHD+ip43j1hmt
         N/qw==
X-Forwarded-Encrypted: i=1; AFNElJ8D4QaUIUBkgOyWtLGE3WQq2g4TR+V821dOA+Psdwx46Yt86+tW2GSzsCMQaWzxXZQQ4jJJ2bK2mlM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE47aGdWciw8GV4paeoEFGuPcuLA92KeiznVPP4IpdLLXarZrH
	WHb1DzePr+EgIiENsGdptzjc2uhGTzBSqzjlZI1mgdJlB/vqXbc+eE+vA0h/GvKsDQj3lIerb+K
	C3vtrBF7tvZkaIN5wfgmPhkpDmXFM39uEot7dW9f98Agtu+YTTv+M3V7h92yfNFWpco2Cv7RuTI
	gH9ajqLAfXlkHmud2JASmpoDdzpRp3cSXe+L0m6A==
X-Gm-Gg: Acq92OH+GmQzmP5/8z2EDU1RBIp6rEpRbOn2R9iNx4wuFcFVY429MakT+NbhPHw5jbl
	PqPs6sijfLk7AW9yzZeiK6jgBN0RfigSvlK1EAO1V1N4/qHFCJXp4vf/FIRAT0yy7pTBfJUzMDt
	7P9Xn5nFCJm8FzgkH9L5EGfKFbtoVmH528hDg3UWfF6OHNvtrQB0+h6sY83h6COHPCzCf5oEO53
	WTFsmiMCF2NLWePKQ==
X-Received: by 2002:a0c:f110:0:b0:8cc:ea7f:d3c0 with SMTP id 6a1803df08f44-8ccea7fd6bfmr21570476d6.37.1780065917002;
        Fri, 29 May 2026 07:45:17 -0700 (PDT)
X-Received: by 2002:a0c:f110:0:b0:8cc:ea7f:d3c0 with SMTP id
 6a1803df08f44-8ccea7fd6bfmr21568916d6.37.1780065916152; Fri, 29 May 2026
 07:45:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260509084907.779-1-hehuan1@eswincomputing.com>
In-Reply-To: <20260509084907.779-1-hehuan1@eswincomputing.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 29 May 2026 16:45:05 +0200
X-Gm-Features: AVHnY4L9f0kSzarnC3fpmMQu8TfTMuOIiThSrOxCb2TlTn_xjwTPaBTtIpn8mDc
Message-ID: <CAPx+jO9J1bmk+qmwLSvJmHwWddWOrMj-2LVa+5C-zZR4WVf-eg@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: sdhci-of-dwcmshc: Fix reset, clk, and SDIO
 support for Eswin EIC7700
To: hehuan1@eswincomputing.com
Cc: adrian.hunter@intel.com, ulfh@kernel.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, ningyu@eswincomputing.com,
        linmin@eswincomputing.com, pinkesh.vaghela@einfochips.com,
        xuxiang@eswincomputing.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: UG9OyyQQUmxbyJiTDA0GcFJfxvRegePj
X-Authority-Analysis: v=2.4 cv=TeqmcxQh c=1 sm=1 tr=0 ts=6a19a67e cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8 a=h4SL0BZ7AAAA:8
 a=WOJ3oqUSjRAtkc8_nNwA:9 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
 a=Cfupvnr7wbb3QRzVG_cV:22
X-Proofpoint-GUID: UG9OyyQQUmxbyJiTDA0GcFJfxvRegePj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDE0NyBTYWx0ZWRfXx1MdEL427hSP
 0d9SNnLAXlkjsKAMmBxmqgCxHFhKmNip4hdgEbyZqvt5zDxyJBxQMsevEnuJJUBwyNqRxpzNDED
 +qsgyeCLPdmnQjz9qmOBNoVwhe5AMjF+gh7NQoaRw3xN53vZZCq4ZVZrmT2UbDShaOLnvrdW0hh
 +hbxprPg9lFxgNHNG8tqmsM/ZpjLW8s2dbsxsFB/xTpGZuuWTuz6rm0zAqow2jPmjC/dfzq0Sen
 dnEustxPQrd+2N6655AZOemJNsPjhVQ38nlxpNO77AJfAYidrDy6t5JD2miRwJggDcR3vjhlo2x
 nIOMQ1HAwAwCzs7/pfN1BlGWxZD5Du4aJyYEDuiXVpOk75saX60HDOJNQ/CETE10tjrOh+ox3xn
 19+2HrVqpDcodwj+6+DlNqAhusxnXus9gzN0XoBKxyFV3OHYEKWj5C0fsJxFRwPFfIl02CrY2mT
 V7L+33r3e3kWtsbGAvA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 lowpriorityscore=0
 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605290147

On Sat, May 9, 2026 at 10:49=E2=80=AFAM <hehuan1@eswincomputing.com> wrote:
>
> From: Huan He <hehuan1@eswincomputing.com>
>
> The EIC7700 code in sdhci-of-dwcmshc uses host->mmc->caps2 to select
> different configuration paths for different card types. The current logic
> distinguishes eMMC and SD, but does not handle SDIO separately.
>
> Update the EIC7700 card-type checks so that eMMC, SD and SDIO are
> distinguished explicitly.
>
> Switch the reset path to dwcmshc_reset() so that pending interrupt state
> is cleared consistently, and use sdhci_enable_clk() so the clock enable
> sequence follows the standard SDHCI flow.
>
> Fixes: 32b2633219d3 ("mmc: sdhci-of-dwcmshc: Add support for Eswin EIC770=
0")
> Signed-off-by: Huan He <hehuan1@eswincomputing.com>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe


>
> ---
> Changes in v2:
>   - Update the subject to mention the reset and clock fixes as well as
>     SDIO support
>   - Rename is_non_emmc to is_emmc to avoid double negative conditions
>
> - Link to v1: https://lore.kernel.org/all/20260424070907.1422-1-hehuan1@e=
swincomputing.com/
> ---
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 44 ++++++++++++++---------------
>  1 file changed, 22 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci=
-of-dwcmshc.c
> index 0b2158a7e409..b9ecd91f44ad 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -277,6 +277,7 @@
>  #define PHY_DELAY_CODE_MAX             0x7f
>  #define PHY_DELAY_CODE_EMMC            0x17
>  #define PHY_DELAY_CODE_SD              0x55
> +#define PHY_DELAY_CODE_SDIO            0x29
>
>  struct rk35xx_priv {
>         struct reset_control *reset;
> @@ -1433,10 +1434,7 @@ static void sdhci_eic7700_set_clock(struct sdhci_h=
ost *host, unsigned int clock)
>         clk_set_rate(pltfm_host->clk, clock);
>
>         clk =3D sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> -       clk |=3D SDHCI_CLOCK_INT_EN;
> -       sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> -
> -       dwcmshc_enable_card_clk(host);
> +       sdhci_enable_clk(host, clk);
>  }
>
>  static void sdhci_eic7700_config_phy_delay(struct sdhci_host *host, int =
delay)
> @@ -1497,7 +1495,7 @@ static void sdhci_eic7700_config_phy(struct sdhci_h=
ost *host)
>
>  static void sdhci_eic7700_reset(struct sdhci_host *host, u8 mask)
>  {
> -       sdhci_reset(host, mask);
> +       dwcmshc_reset(host, mask);
>
>         /* after reset all, the phy's config will be clear */
>         if (mask =3D=3D SDHCI_RESET_ALL)
> @@ -1594,18 +1592,17 @@ static int sdhci_eic7700_phase_code_tuning(struct=
 sdhci_host *host, u32 opcode)
>  {
>         struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
>         struct dwcmshc_priv *priv =3D sdhci_pltfm_priv(pltfm_host);
> -       u32 sd_caps =3D MMC_CAP2_NO_MMC | MMC_CAP2_NO_SDIO;
> +       u32 emmc_caps =3D MMC_CAP2_NO_SD | MMC_CAP2_NO_SDIO;
>         int phase_code =3D -1;
>         int code_range =3D -1;
> -       bool is_sd =3D false;
>         int code_min =3D -1;
>         int code_max =3D -1;
>         int cmd_error =3D 0;
> +       bool is_emmc;
>         int ret =3D 0;
>         int i =3D 0;
>
> -       if ((host->mmc->caps2 & sd_caps) =3D=3D sd_caps)
> -               is_sd =3D true;
> +       is_emmc =3D (host->mmc->caps2 & emmc_caps) =3D=3D emmc_caps;
>
>         for (i =3D 0; i <=3D MAX_PHASE_CODE; i++) {
>                 /* Centered Phase code */
> @@ -1614,8 +1611,8 @@ static int sdhci_eic7700_phase_code_tuning(struct s=
dhci_host *host, u32 opcode)
>                 host->ops->reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA=
);
>
>                 if (ret) {
> -                       /* SD specific range tracking */
> -                       if (is_sd && code_min !=3D -1 && code_max !=3D -1=
) {
> +                       /* SD/SDIO specific range tracking */
> +                       if (!is_emmc && code_min !=3D -1 && code_max !=3D=
 -1) {
>                                 if (code_max - code_min > code_range) {
>                                         code_range =3D code_max - code_mi=
n;
>                                         phase_code =3D (code_min + code_m=
ax) / 2;
> @@ -1626,17 +1623,17 @@ static int sdhci_eic7700_phase_code_tuning(struct=
 sdhci_host *host, u32 opcode)
>                                 code_max =3D -1;
>                         }
>                         /* EMMC breaks after first valid range */
> -                       if (!is_sd && code_min !=3D -1 && code_max !=3D -=
1)
> +                       if (is_emmc && code_min !=3D -1 && code_max !=3D =
-1)
>                                 break;
>                 } else {
>                         /* Track valid phase code range */
>                         if (code_min =3D=3D -1) {
>                                 code_min =3D i;
> -                               if (!is_sd)
> +                               if (is_emmc)
>                                         continue;
>                         }
>                         code_max =3D i;
> -                       if (is_sd && i =3D=3D MAX_PHASE_CODE) {
> +                       if (!is_emmc && i =3D=3D MAX_PHASE_CODE) {
>                                 if (code_max - code_min > code_range) {
>                                         code_range =3D code_max - code_mi=
n;
>                                         phase_code =3D (code_min + code_m=
ax) / 2;
> @@ -1646,19 +1643,19 @@ static int sdhci_eic7700_phase_code_tuning(struct=
 sdhci_host *host, u32 opcode)
>         }
>
>         /* Handle tuning failure case */
> -       if ((is_sd && phase_code =3D=3D -1) ||
> -           (!is_sd && code_min =3D=3D -1 && code_max =3D=3D -1)) {
> +       if ((!is_emmc && phase_code =3D=3D -1) ||
> +           (is_emmc && code_min =3D=3D -1 && code_max =3D=3D -1)) {
>                 pr_err("%s: phase code tuning failed!\n", mmc_hostname(ho=
st->mmc));
>                 sdhci_writew(host, 0, priv->vendor_specific_area1 + DWCMS=
HC_AT_STAT);
>                 return -EIO;
>         }
> -       if (!is_sd)
> +       if (is_emmc)
>                 phase_code =3D (code_min + code_max) / 2;
>
>         sdhci_writew(host, phase_code, priv->vendor_specific_area1 + DWCM=
SHC_AT_STAT);
>
> -       /* SD specific final verification */
> -       if (is_sd) {
> +       /* SD/SDIO specific final verification */
> +       if (!is_emmc) {
>                 ret =3D mmc_send_tuning(host->mmc, opcode, &cmd_error);
>                 host->ops->reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA=
);
>                 if (ret) {
> @@ -1756,9 +1753,9 @@ static void sdhci_eic7700_set_uhs_signaling(struct =
sdhci_host *host, unsigned in
>
>  static void sdhci_eic7700_set_uhs_wrapper(struct sdhci_host *host, unsig=
ned int timing)
>  {
> -       u32 sd_caps =3D MMC_CAP2_NO_MMC | MMC_CAP2_NO_SDIO;
> +       u32 emmc_caps =3D MMC_CAP2_NO_SD | MMC_CAP2_NO_SDIO;
>
> -       if ((host->mmc->caps2 & sd_caps) =3D=3D sd_caps)
> +       if ((host->mmc->caps2 & emmc_caps) !=3D emmc_caps)
>                 sdhci_set_uhs_signaling(host, timing);
>         else
>                 sdhci_eic7700_set_uhs_signaling(host, timing);
> @@ -1767,6 +1764,7 @@ static void sdhci_eic7700_set_uhs_wrapper(struct sd=
hci_host *host, unsigned int
>  static int eic7700_init(struct device *dev, struct sdhci_host *host, str=
uct dwcmshc_priv *dwc_priv)
>  {
>         u32 emmc_caps =3D MMC_CAP2_NO_SD | MMC_CAP2_NO_SDIO;
> +       u32 sd_caps =3D MMC_CAP2_NO_MMC | MMC_CAP2_NO_SDIO;
>         unsigned int val, hsp_int_status, hsp_pwr_ctrl;
>         static const char * const clk_ids[] =3D {"axi"};
>         struct of_phandle_args args;
> @@ -1821,8 +1819,10 @@ static int eic7700_init(struct device *dev, struct=
 sdhci_host *host, struct dwcm
>
>         if ((host->mmc->caps2 & emmc_caps) =3D=3D emmc_caps)
>                 dwc_priv->delay_line =3D PHY_DELAY_CODE_EMMC;
> -       else
> +       else if ((host->mmc->caps2 & sd_caps) =3D=3D sd_caps)
>                 dwc_priv->delay_line =3D PHY_DELAY_CODE_SD;
> +       else
> +               dwc_priv->delay_line =3D PHY_DELAY_CODE_SDIO;
>
>         if (!of_property_read_u32(dev->of_node, "eswin,drive-impedance-oh=
ms", &val))
>                 priv->drive_impedance =3D eic7700_convert_drive_impedance=
_ohm(dev, val);
> --
> 2.25.1
