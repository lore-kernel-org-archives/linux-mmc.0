Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6003ACA54
	for <linux-mmc@vger.kernel.org>; Mon,  6 Jul 2026 15:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783352791; cv=pass; b=iE6IP/8tERGnBoPhE2avM9MbvAOj3W78SDIX4ykfiaZKa8MQxeoQlLEZ31QPONoKSxmEyeWWd+bfkO9yynatXSYHUqHPnbXet32omJCZj2SedyF0HNnuK9CHO/ZKy7k0F6dHkd+JGni7muMXHWIPMIbHFu2xzFEjS4sZfSsqhgU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783352791; c=relaxed/simple;
	bh=puuTOTVkj7WGu9o679YWetaI9S6eilJUeJleGSsUDsU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O2gDoHA9/eW9wHtwA1AnkU5Xwi1X41IlhJrQARxt8nguFBqxv3RQ7A8pQoTKhBkzRAytmo9owXPKpHk6CKv749a85qQbLpB52gBywkX/pk+XVyfygHhiXBbzTM8bhP16GsiZY3Bb6SSODojv6z82tUyPbtysBa9TmTbnd1mncqY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hXZp1fbz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=b+oO4MIU; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hXZp1fbz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="b+oO4MIU"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666FF21S956766
	for <linux-mmc@vger.kernel.org>; Mon, 6 Jul 2026 15:46:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+OnMOn2/de6czvKsT65QKA7vIysNRqWUd1S/71D1Jas=; b=hXZp1fbz4cz372gL
	swOx37jRUZyhMOJu11R2PHaveWDbkEDuxJtIIw4ZT8oFYwMMK0fEMQd5MDT2KCnP
	XASsVc0hrVC9REAWNI++Jh/oryw7S61DX6jKX1daudC2gs038daj+7xFQQgF988+
	JPH+iDKbsv8dnDthyUtGuJefBq/O8S5tEJ2U4eUOBxCenwg+6OzRVVzZt/AYtFjd
	mh0HyEE8+WxFz8efJ/yINBZoPcjRTpPy6IBmGwV/H+I5Jcx8dZIxnwVKGM4XVHhu
	9fArCoYwqx5Bk9VzTbzuv8X/36v6/sds5G9lYjuxWbzWAvoU9PWrdm/SDU7CBcMz
	tYON5Q==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f891usvpa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 06 Jul 2026 15:46:29 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8eac2620cb0so43875536d6.3
        for <linux-mmc@vger.kernel.org>; Mon, 06 Jul 2026 08:46:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783352789; cv=none;
        d=google.com; s=arc-20260327;
        b=ZtClHIFhZVn15xpCCowUV/B78XawAHSWvXcvK+qFJbX+pZVS3ORlLTYJmBhh5EUjTT
         1/PPOxoa6qfyKV+5JmmpnZz1AmXH343vZ1ilkgFaj1wMkK2rfXrWmALEgKCuEnAvw4NO
         CHo9G1+Wp8qCF8k2ZZghYM+qkny5xMBj5x3Wvt1A3h3DNpnSxBE5YCWO9xpPrNvbx9GA
         yFTZhnS5YWqJcCxwht3yEPrbUnqh1qhHAaWR6ZDsrZRFgWqnAxZDDMLaqGmWlyLVZUSr
         iqzt30vcTie+DVCIPLkz84yJlVzzZ/HBYCXZmCL23kvyAIfgS704Ye/lcgWIlrNS/RlS
         RAAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+OnMOn2/de6czvKsT65QKA7vIysNRqWUd1S/71D1Jas=;
        fh=UPTFA+k99WLW5DOfL2kev3V5055b6z7FhW6SaWh3x0A=;
        b=j5nIoFrZrofmTVhp7+NOPIR7hiP9igj5W7GA4v7TlOOOlz4hrFcTwk1Jlyp0Ge+NGz
         E7j+U1lShmTZQ0TapWGCsJLBPGdUQaN4SupxW0+8q5IJZPhKwbkPM2psCbK74scRr+HU
         TxmjJHpMBcEbAq3L92HM3mEzKmxE/jItL778uGAx8yq9QA15SznsatVSZcLmBrTVwpyA
         8tMLzTLfnQpF6lDWq7/UFpboLGcaTorJC/C+X2R3bQGNjjCeEst6FJd7gxRU72odB0AD
         ePuL08uSvCUL8lLZnP3Fq6AiM2fVMU8TCxPWh3zaGSvHo4a+w2Knkj4+Tut3hwKGorKG
         3LgA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783352789; x=1783957589; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+OnMOn2/de6czvKsT65QKA7vIysNRqWUd1S/71D1Jas=;
        b=b+oO4MIUeghHjvtstR0ZmQtDToct5BCHQze5uaArX64e/zcySL/9PQo3+Z2tYjWSTS
         tDeKvx6THlXIAjaolkN5x6RwWoCBDYJDjgTw1gxLBKhDHYnLAdmjFEnmaH+jG3OtBNJG
         ZIVRtvbsh70na8FVKh1xXQs6rA9U+5GMCVP38f7ivJ/KNyAKDUdFCWIaQL1Vq876o7gV
         Gzso72Cl+MDC8DAw3y0QLXQVA7+TtdTaIKY5ERgA02IPAGtQwAEJwArn/U5AQ0TbrNU1
         RibF16loOBTNOqq8HmqKc7jtUDnIvM4Sn0N1GetyHoCLtEQ7lbTDh085pkcaSovjOmmX
         yn4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783352789; x=1783957589;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+OnMOn2/de6czvKsT65QKA7vIysNRqWUd1S/71D1Jas=;
        b=CZqW/GXQWPhOVf/ezz/YA0TOBjEUg+vjE8X0Vm44FqmlDZxq/8sG8L96y5+yWo1mGq
         BsPZM38UIeTELhl8ps78bdN8hlagpHkU57/KRHL4th2X/l9WtGb/w6QBP5423RtCkLGw
         VFAKRkbDzh60wwMD1S4tBQpytDK0RNZUfJxFIVXQqs7gUgJdA6yZnYOCfFbYckCOVd97
         ppmvZpFGxLZ7UeOrR81z7o3NdduzGh508uP2sWKX7pEL+NcxSXeOZu0OABtL2TvRb0YK
         XvJVcW7uSIM0lHhK4nPvXPlTzMH/LnxU5Nd9gx+vrfYrEX3xrnkhVmRQMd1q59/1bMKK
         Ob5A==
X-Forwarded-Encrypted: i=1; AHgh+Rqov8jcu0QREolGOAsXkw9wvV57jKAfKDcw98d2XRcE7tNx3Z3Z5ku2Li/8DKwfFNDhZjYw81GoL8U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8tsPquIfOlZ693lJ612T1eaBDFPsdFpW8JAb1J/2VUKu2j/oR
	d0a1gdxkd3lHsQtlw8iaX1GADs2VYUTkFUpfwc59phms3rNRxu9rtpecGlaYC7fYGEVbyBLQw+v
	sj4UOQxJ0gSvQt1v/UNyw5CibBEQIHpDVPpKA5ppnvUD3LZenQMfFi937P1i/5sRwBtBF83kGkD
	f9A56m1r8aHGTtj6t2LmdNwgN+/G+3iyrellZgIA==
X-Gm-Gg: AfdE7cl0tkt7aBHYFNJQidYndnlCQILT8dcxKqTqkCym+P9E5kxd4iUbWN2PWUABSp1
	+zNgfmofnaoCb/YFfPvuEqv7n3y68AAq0D+OuMua8msudmTmANFS5r6No95va5LlIzNLkmUN3g2
	wcpURmuJvLoG6obMyzea/fjdxDWQ41S/ifZ8ehDmyxmhUdIN91vUqTh7XeroGhfxwqa+Z9
X-Received: by 2002:a05:6214:5003:b0:8f3:e97:59b8 with SMTP id 6a1803df08f44-8fcb3d3ee24mr12450756d6.29.1783352788246;
        Mon, 06 Jul 2026 08:46:28 -0700 (PDT)
X-Received: by 2002:a05:6214:5003:b0:8f3:e97:59b8 with SMTP id
 6a1803df08f44-8fcb3d3ee24mr12450156d6.29.1783352787606; Mon, 06 Jul 2026
 08:46:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20260624021955epcas1p2ba2fa4eb8bd0aafaf7b46bde2cf524be@epcas1p2.samsung.com>
 <20260624021912.632627-1-cw9316.lee@samsung.com>
In-Reply-To: <20260624021912.632627-1-cw9316.lee@samsung.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 17:46:16 +0200
X-Gm-Features: AVVi8CcBYSP5zyLpt00Q11yUujyWdz_mc32EjqBaIjLdlr5HgDzXa1HvKfgTjLk
Message-ID: <CAPx+jO9=7B4SYyKSwvGqx+zzMsJ+hhFUK_vmU-HNYQZfKv+bdQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: cqhci: Remove unused intmask parameter from cqhci_irq()
To: Chanwoo Lee <cw9316.lee@samsung.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
        Asutosh Das <quic_asutoshd@quicinc.com>,
        Ritesh Harjani <ritesh.list@gmail.com>, Ulf Hansson <ulfh@kernel.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Kamal Dasu <kamal.dasu@broadcom.com>, Al Cooper <alcooperx@gmail.com>,
        Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Haibo Chen <haibo.chen@nxp.com>, Frank Li <Frank.Li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Michal Simek <michal.simek@amd.com>,
        Thierry Reding <thierry.reding@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "open list:EMMC CMDQ HOST CONTROLLER INTERFACE (CQHCI) DRIVER" <linux-mmc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
        "open list:ARM/QUALCOMM MAILING LIST" <linux-arm-msm@vger.kernel.org>,
        "open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: jhVXYOr_iRTuqBpvVDTi3wDYn8njOTVj
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE2MCBTYWx0ZWRfX2+ooycPtVFu/
 +wrRJDi+O2mQvmA30uEnj2koPqBvCzAd794wKzn/9aP0AF4Jp2U7y2Qa6HRvi7UhT2c4b89autl
 nzuG2oKrnayJVtK+pKPSP6rCKpjRI+o=
X-Authority-Analysis: v=2.4 cv=Mo1iLWae c=1 sm=1 tr=0 ts=6a4bcdd5 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=hD80L64hAAAA:8 a=EqBXy2bI2-3AcK8LOXQA:9
 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE2MCBTYWx0ZWRfX3fs+5igealnn
 D7ImQN+3E0LfPBSk391QpEoiHg4SsaTGSlx8nmsdVBN5dnqf3QeQcl0XSz4EZeHG11SFQ0hXK52
 Ej9fTuAKOeyw61GUyaHoSKJoT5z/qLPCV5LCGmY/y0nzP+/5MopLDYFJtsZ5aD7zzpyYtoZEqbp
 KLz6ZnCHyt4UAPxNAeiIKiZ5T8kFcm+/vEzB9to3s+kJDiR+jrs/88x7GfDODGhH9YXQ7x4BKaC
 EfjsOIPKEtkWIsGLb1TY5QNLnrICA1PchMjGeXAfaxBTOsLDbRegyrgw8BNEAppOPtgySDlJ1Ny
 4gxYrZWKF71RTB88uzGF02Sl7sSPxj3C8HvLupmEAP7FD3Z/zuXPqGXtFS4ydwhR3aR8zBCUVPx
 Xpw1Ios9Y2pCW9nJcza77AxyfrCJRg6oVEOfUpWy6jMVtDMwR0ErOJrJ3BdxJ97bafwmGo/rOYN
 L8zaa1BhqMM0CKycovA==
X-Proofpoint-ORIG-GUID: jhVXYOr_iRTuqBpvVDTi3wDYn8njOTVj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060160

On Wed, Jun 24, 2026 at 4:20=E2=80=AFAM Chanwoo Lee <cw9316.lee@samsung.com=
> wrote:
>
> The intmask parameter of cqhci_irq() is never used within the function
> body. The function reads the CQHCI interrupt status directly via
> cqhci_readl() and processes interrupts independently of the SDHCI
> intmask value passed by callers.
>
> Signed-off-by: Chanwoo Lee <cw9316.lee@samsung.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/cqhci-core.c       | 3 +--
>  drivers/mmc/host/cqhci.h            | 3 +--
>  drivers/mmc/host/mtk-sd.c           | 2 +-
>  drivers/mmc/host/sdhci-brcmstb.c    | 2 +-
>  drivers/mmc/host/sdhci-esdhc-imx.c  | 2 +-
>  drivers/mmc/host/sdhci-msm.c        | 2 +-
>  drivers/mmc/host/sdhci-of-arasan.c  | 2 +-
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 2 +-
>  drivers/mmc/host/sdhci-pci-core.c   | 2 +-
>  drivers/mmc/host/sdhci-pci-gli.c    | 2 +-
>  drivers/mmc/host/sdhci-tegra.c      | 2 +-
>  drivers/mmc/host/sdhci_am654.c      | 2 +-
>  12 files changed, 12 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/mmc/host/cqhci-core.c b/drivers/mmc/host/cqhci-core.=
c
> index 178277d90c31..98ceb0b9a6d1 100644
> --- a/drivers/mmc/host/cqhci-core.c
> +++ b/drivers/mmc/host/cqhci-core.c
> @@ -819,8 +819,7 @@ static void cqhci_finish_mrq(struct mmc_host *mmc, un=
signed int tag)
>         mmc_cqe_request_done(mmc, mrq);
>  }
>
> -irqreturn_t cqhci_irq(struct mmc_host *mmc, u32 intmask, int cmd_error,
> -                     int data_error)
> +irqreturn_t cqhci_irq(struct mmc_host *mmc, int cmd_error, int data_erro=
r)
>  {
>         u32 status;
>         unsigned long tag =3D 0, comp_status;
> diff --git a/drivers/mmc/host/cqhci.h b/drivers/mmc/host/cqhci.h
> index 3668856531c1..8fbbc48c3f85 100644
> --- a/drivers/mmc/host/cqhci.h
> +++ b/drivers/mmc/host/cqhci.h
> @@ -315,8 +315,7 @@ static inline u32 cqhci_readl(struct cqhci_host *host=
, int reg)
>
>  struct platform_device;
>
> -irqreturn_t cqhci_irq(struct mmc_host *mmc, u32 intmask, int cmd_error,
> -                     int data_error);
> +irqreturn_t cqhci_irq(struct mmc_host *mmc, int cmd_error, int data_erro=
r);
>  int cqhci_init(struct cqhci_host *cq_host, struct mmc_host *mmc, bool dm=
a64);
>  struct cqhci_host *cqhci_pltfm_init(struct platform_device *pdev);
>  int cqhci_deactivate(struct mmc_host *mmc);
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index b2680cc054bd..01ea3adbdf3b 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -1805,7 +1805,7 @@ static irqreturn_t msdc_cmdq_irq(struct msdc_host *=
host, u32 intsts)
>                         cmd_err, dat_err, intsts);
>         }
>
> -       return cqhci_irq(mmc, 0, cmd_err, dat_err);
> +       return cqhci_irq(mmc, cmd_err, dat_err);
>  }
>
>  static irqreturn_t msdc_irq(int irq, void *dev_id)
> diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-br=
cmstb.c
> index 57e45951644e..1de2f05fd958 100644
> --- a/drivers/mmc/host/sdhci-brcmstb.c
> +++ b/drivers/mmc/host/sdhci-brcmstb.c
> @@ -430,7 +430,7 @@ static u32 sdhci_brcmstb_cqhci_irq(struct sdhci_host =
*host, u32 intmask)
>         if (!sdhci_cqe_irq(host, intmask, &cmd_error, &data_error))
>                 return intmask;
>
> -       cqhci_irq(host->mmc, intmask, cmd_error, data_error);
> +       cqhci_irq(host->mmc, cmd_error, data_error);
>
>         return 0;
>  }
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-=
esdhc-imx.c
> index 18ecddd6df6f..d0fa83f67a80 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -1503,7 +1503,7 @@ static u32 esdhc_cqhci_irq(struct sdhci_host *host,=
 u32 intmask)
>         if (!sdhci_cqe_irq(host, intmask, &cmd_error, &data_error))
>                 return intmask;
>
> -       cqhci_irq(host->mmc, intmask, cmd_error, data_error);
> +       cqhci_irq(host->mmc, cmd_error, data_error);
>
>         return 0;
>  }
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index 0882ce74e0c9..ceed47ccfda8 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -2165,7 +2165,7 @@ static u32 sdhci_msm_cqe_irq(struct sdhci_host *hos=
t, u32 intmask)
>         if (!sdhci_cqe_irq(host, intmask, &cmd_error, &data_error))
>                 return intmask;
>
> -       cqhci_irq(host->mmc, intmask, cmd_error, data_error);
> +       cqhci_irq(host->mmc, cmd_error, data_error);
>         return 0;
>  }
>
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-=
of-arasan.c
> index 785d3acb18c5..4ca73e7d799e 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -555,7 +555,7 @@ static u32 sdhci_arasan_cqhci_irq(struct sdhci_host *=
host, u32 intmask)
>         if (!sdhci_cqe_irq(host, intmask, &cmd_error, &data_error))
>                 return intmask;
>
> -       cqhci_irq(host->mmc, intmask, cmd_error, data_error);
> +       cqhci_irq(host->mmc, cmd_error, data_error);
>
>         return 0;
>  }
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci=
-of-dwcmshc.c
> index eef53455b8ee..4c5fa6a6931d 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -624,7 +624,7 @@ static u32 dwcmshc_cqe_irq_handler(struct sdhci_host =
*host, u32 intmask)
>         if (!sdhci_cqe_irq(host, intmask, &cmd_error, &data_error))
>                 return intmask;
>
> -       cqhci_irq(host->mmc, intmask, cmd_error, data_error);
> +       cqhci_irq(host->mmc, cmd_error, data_error);
>
>         return 0;
>  }
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-p=
ci-core.c
> index c347fac24515..b121d896a804 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -215,7 +215,7 @@ static u32 sdhci_cqhci_irq(struct sdhci_host *host, u=
32 intmask)
>         if (!sdhci_cqe_irq(host, intmask, &cmd_error, &data_error))
>                 return intmask;
>
> -       cqhci_irq(host->mmc, intmask, cmd_error, data_error);
> +       cqhci_irq(host->mmc, cmd_error, data_error);
>
>         return 0;
>  }
> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pc=
i-gli.c
> index 6e4084407662..b55618566d65 100644
> --- a/drivers/mmc/host/sdhci-pci-gli.c
> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> @@ -1760,7 +1760,7 @@ static u32 sdhci_gl9763e_cqhci_irq(struct sdhci_hos=
t *host, u32 intmask)
>         if (!sdhci_cqe_irq(host, intmask, &cmd_error, &data_error))
>                 return intmask;
>
> -       cqhci_irq(host->mmc, intmask, cmd_error, data_error);
> +       cqhci_irq(host->mmc, cmd_error, data_error);
>
>         return 0;
>  }
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegr=
a.c
> index 820ce4dae58b..221e48b59f48 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -1280,7 +1280,7 @@ static u32 sdhci_tegra_cqhci_irq(struct sdhci_host =
*host, u32 intmask)
>         if (!sdhci_cqe_irq(host, intmask, &cmd_error, &data_error))
>                 return intmask;
>
> -       cqhci_irq(host->mmc, intmask, cmd_error, data_error);
> +       cqhci_irq(host->mmc, cmd_error, data_error);
>
>         return 0;
>  }
> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am65=
4.c
> index d235b0aecfdb..2a27db2f558b 100644
> --- a/drivers/mmc/host/sdhci_am654.c
> +++ b/drivers/mmc/host/sdhci_am654.c
> @@ -462,7 +462,7 @@ static u32 sdhci_am654_cqhci_irq(struct sdhci_host *h=
ost, u32 intmask)
>         if (!sdhci_cqe_irq(host, intmask, &cmd_error, &data_error))
>                 return intmask;
>
> -       cqhci_irq(host->mmc, intmask, cmd_error, data_error);
> +       cqhci_irq(host->mmc, cmd_error, data_error);
>
>         return 0;
>  }
> --
> 2.43.0
>
