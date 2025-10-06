Received: from mail-qt1-f228.google.com (mail-qt1-f228.google.com [209.85.160.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846BC27A12B
	for <linux-mmc@vger.kernel.org>; Mon,  6 Oct 2025 18:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759775149; cv=none; b=YD5Dcs6VQ+JPEjAFmAeCCHU+UneBI6oDCY4TR0HpOPlAkrJGKJ6rBNjKVAYuiuGD5AASdIT8s+2rZFYG7Vy+E6eiGcoVpgTM+j5j1pn9e+f4yeuac7z/aXnkI0n6FGNbqScDSxmEEt/OjF+tc2zBQjwUGuUG1m7pPKofWBnntZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759775149; c=relaxed/simple;
	bh=0DgEacxTXbCnkeBV8dc/dSb68/vO+1FitYEftLBiUwI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PNgdHrNi+WX/nE5rNbkvrsB3mJjXnvw3A+58N5A04RMlbo/8VhZEoT7LfrXIAZ3cRbCGwGIT7ocqAB2jmrz11dg/oJ4bLk8xyerAs4RBdI03v+dByrwE35DwXqO0QvdX8Rf4dTmQWK0JxmbDAH18uz535HrTUiU8VV9IguACjPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=OqwCjvHq; arc=none smtp.client-ip=209.85.160.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="OqwCjvHq"
Received: by mail-qt1-f228.google.com with SMTP id d75a77b69052e-4df0467b510so64096301cf.3
        for <linux-mmc@vger.kernel.org>; Mon, 06 Oct 2025 11:25:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759775146; x=1760379946;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PL71oD9jjPzRosEgb+nnRWqmcte/cjIahJtCTmgXmKE=;
        b=B+qF8F43uiULBX5kN6NaOMzdfn5WGheSBjiruFY1HOqpWlgORYMX5bTNYCac+3q2lV
         mm/ZvHniVrArw2hZQVL1uwths5xKEVUOaZtZti7lfbE97Ak//V5ln8TfGOevECvnod8Q
         Jdspea4SHeWIYllvfKX7glQolk1u38p80hrE/Py+K5NsiAs+fL+nWU4idbSAvzk8qitV
         xiUnxGoojPuoKMqnmzVNFUgBzq2NO8MA0kjAQR2u122Vv/ggyVjLxuHeGXenQZs6+dDi
         vOocmTSg5DHxcYp5QMh+ex6p8mWbtaRkvC9laRA/K5ZfvN298vAG+TrnPYlH2ohzJw8F
         K5zQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxOLOtXpAtafQ6WlGrfdR7nCciQpnIYS2VtUuTZ1+7aOl28hrFx0ZLOp2H6FBngB7cyDf79Vcw3z4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyovq5D5zKGcm4vLZUFwgTg7R5o4QBX9Tn2mwsrOlnq8/6BXFqi
	+Wqoh4k1ochBe+Rai3wUhAZ1oVtULBVaeicx9cZSMXrEB8roJMyFSm5YtWbE7YITmYDoaSuYgVD
	b2TuXTSA7rqTInJPqqVBRoUDmIKSF1MMmlWGNTUoNWyrD9XwpLqMDyiAIxjze31FeTUxz26UU+z
	YeMlUpaexATngrbSv8wwz3w9ntQip6EMy8CCS1CA/whG7jm0ypFU7Q1SFmoVxe/3vFqF18yuFjA
	RehWlewVuVI
X-Gm-Gg: ASbGncvEq1Nse4b/y/iuwSM7FIT8n1TgldpniIGAxNP7qGV/49wPSHUZys3f5/1moCA
	dEe1+J2xms/YKuL/bFpkMHEIQwz9iQVVjeRbp71xbGBxZvxGkQZ7z1N5pG3gB2A1goezjIXDT9W
	/MTcnLogLW0v4Ql+aPYNUjnmA1a/FtRPYYWpFgFWms/1I/+EI+nk79vHR86DeMQzAVC0diGAfqj
	z7byDl7ZWs28s3yPlMR2FMFYk6BLzH7xEfVBRauhRQADezlSPD4Q/+2+x5A6EJd5ERze1DPUqsB
	CXetWI+eZld64UBNzb7QUTA7L7r6Bg9rqVWD4n39gHqeHzdc8Yl7sxyHlNesdWjpjmDWXOqwnm4
	16eZ9FDGGN0IpROc7onh8PNiGH3Ht/srRtkYGNOqVr+aIvaN4SMlNe1C9p0r82+9hxIIQyxMq7W
	o5uw==
X-Google-Smtp-Source: AGHT+IGwHflT9ke8V0b6VS91OVmYMHKdOBzd4E1yUz7lyRegWFl/v0FHxyp2RMQ1hOHU4Mu+qYq+niQE+UHF
X-Received: by 2002:a05:622a:4d0e:b0:4d7:bf73:7641 with SMTP id d75a77b69052e-4e576a45ad4mr161521211cf.17.1759775146083;
        Mon, 06 Oct 2025 11:25:46 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
        by smtp-relay.gmail.com with ESMTPS id d75a77b69052e-4e55a64bf3csm4792721cf.6.2025.10.06.11.25.45
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Oct 2025 11:25:46 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-28eb14e3cafso37730885ad.1
        for <linux-mmc@vger.kernel.org>; Mon, 06 Oct 2025 11:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1759775145; x=1760379945; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PL71oD9jjPzRosEgb+nnRWqmcte/cjIahJtCTmgXmKE=;
        b=OqwCjvHqjqeIMQSy/cqoN1VOWfwROcGkpjgMJOlP1yCDnEmUKUHar6ynOgU/eMwsoL
         7HCc0hrVmk5rhcN6kQGTJBWBDCHVm6TGs3/AnKlJRdMnOSMCnnzJsuYVqugjUH4rzsIa
         pMjrcpnGfrrOr/nyNM6sOXVCKsDqrZPIHg2g8=
X-Forwarded-Encrypted: i=1; AJvYcCUxfvTVpShca2wrZFcWUaoywnIhfHGMJYMrHk0mjJvrzt3r/5jX9Y1by9DY0d78K80Z+GYHIYPLaBU=@vger.kernel.org
X-Received: by 2002:a17:903:1786:b0:288:e46d:b32b with SMTP id d9443c01a7336-28e9a58dd00mr166518145ad.17.1759775144681;
        Mon, 06 Oct 2025 11:25:44 -0700 (PDT)
X-Received: by 2002:a17:903:1786:b0:288:e46d:b32b with SMTP id
 d9443c01a7336-28e9a58dd00mr166517985ad.17.1759775144181; Mon, 06 Oct 2025
 11:25:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251002210426.2490368-1-kamal.dasu@broadcom.com>
 <20251002210426.2490368-4-kamal.dasu@broadcom.com> <24a58a70-b4db-4925-8454-78dea4fb22b2@intel.com>
 <957d5c73-528f-4182-b655-116fb6b94f3f@intel.com>
In-Reply-To: <957d5c73-528f-4182-b655-116fb6b94f3f@intel.com>
From: Kamal Dasu <kamal.dasu@broadcom.com>
Date: Mon, 6 Oct 2025 14:25:05 -0400
X-Gm-Features: AS18NWAYskofCaCne01eO5HckllhJb6_szW_z_kw6AYLXSV_TS1luC3iIY63pw4
Message-ID: <CAKekbetcu9QHi2j-EYG2JCqDU=M8_5wMohbmTvkDU2nJjx6ySQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] mmc: brcmstb: save and restore registers during PM
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: andersson@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, florian.fainelli@broadcom.com, ulf.hansson@linaro.org, 
	bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mmc@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000068c7960640819427"

--00000000000068c7960640819427
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 6, 2025 at 6:22=E2=80=AFAM Adrian Hunter <adrian.hunter@intel.c=
om> wrote:
>
> On 06/10/2025 13:08, Adrian Hunter wrote:
> > On 03/10/2025 00:04, Kamal Dasu wrote:
> >> Added support to save and restore registers that are critical
> >> during PM.
> >>
> >> Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>
> >> ---
> >>  drivers/mmc/host/sdhci-brcmstb.c | 124 +++++++++++++++++++++++++++++-=
-
> >>  1 file changed, 119 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci=
-brcmstb.c
> >> index 0905b316a24b..ffa602a99ab7 100644
> >> --- a/drivers/mmc/host/sdhci-brcmstb.c
> >> +++ b/drivers/mmc/host/sdhci-brcmstb.c
> >> @@ -24,7 +24,9 @@
> >>  #define BRCMSTB_MATCH_FLAGS_NO_64BIT                BIT(0)
> >>  #define BRCMSTB_MATCH_FLAGS_BROKEN_TIMEOUT  BIT(1)
> >>  #define BRCMSTB_MATCH_FLAGS_HAS_CLOCK_GATE  BIT(2)
> >> -#define BRCMSTB_MATCH_FLAGS_USE_CARD_BUSY   BIT(4)
> >> +#define BRCMSTB_MATCH_FLAGS_HAS_CFG_V1              BIT(3)
> >> +#define BRCMSTB_MATCH_FLAGS_HAS_CFG_V2              BIT(4)
> >> +#define BRCMSTB_MATCH_FLAGS_USE_CARD_BUSY   BIT(5)
> >>
> >>  #define BRCMSTB_PRIV_FLAGS_HAS_CQE          BIT(0)
> >>  #define BRCMSTB_PRIV_FLAGS_GATE_CLOCK               BIT(1)
> >> @@ -38,19 +40,39 @@
> >>  #define SDIO_CFG_OP_DLY_DEFAULT                     0x80000003
> >>  #define SDIO_CFG_CQ_CAPABILITY                      0x4c
> >>  #define SDIO_CFG_CQ_CAPABILITY_FMUL         GENMASK(13, 12)
> >> +#define SDIO_CFG_SD_PIN_SEL                 0x44
> >> +#define SDIO_CFG_V1_SD_PIN_SEL                      0x54
> >> +#define SDIO_CFG_PHY_SW_MODE_0_RX_CTRL              0x7C
> >>  #define SDIO_CFG_MAX_50MHZ_MODE                     0x1ac
> >>  #define SDIO_CFG_MAX_50MHZ_MODE_STRAP_OVERRIDE      BIT(31)
> >>  #define SDIO_CFG_MAX_50MHZ_MODE_ENABLE              BIT(0)
> >>
> >> +#define SDIO_BOOT_MAIN_CTL                  0x0
> >> +
> >>  #define MMC_CAP_HSE_MASK    (MMC_CAP2_HSX00_1_2V | MMC_CAP2_HSX00_1_8=
V)
> >>  /* Select all SD UHS type I SDR speed above 50MB/s */
> >>  #define MMC_CAP_UHS_I_SDR_MASK      (MMC_CAP_UHS_SDR50 | MMC_CAP_UHS_=
SDR104)
> >>
> >> +enum cfg_core_ver {
> >> +    SDIO_CFG_CORE_V1 =3D 1,
> >> +    SDIO_CFG_CORE_V2,
> >> +};
> >> +
> >> +struct sdhci_brcmstb_saved_regs {
> >> +    u32 sd_pin_sel;
> >> +    u32 phy_sw_mode0_rxctrl;
> >> +    u32 max_50mhz_mode;
> >> +    u32 boot_main_ctl;
> >> +};
> >> +
> >>  struct sdhci_brcmstb_priv {
> >>      void __iomem *cfg_regs;
> >> +    void __iomem *boot_regs;
> >> +    struct sdhci_brcmstb_saved_regs saved_regs;
> >>      unsigned int flags;
> >>      struct clk *base_clk;
> >>      u32 base_freq_hz;
> >> +    void (*save_restore_regs)(struct mmc_host *mmc, int save);
> >>  };
> >>
> >>  struct brcmstb_match_priv {
> >> @@ -60,6 +82,69 @@ struct brcmstb_match_priv {
> >>      const unsigned int flags;
> >>  };
> >>
> >> +static void sdhci_brcmstb_save_regs(struct mmc_host *mmc, enum cfg_co=
re_ver ver)
> >> +{
> >> +    struct sdhci_host *host =3D mmc_priv(mmc);
> >> +    struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> >> +    struct sdhci_brcmstb_priv *priv =3D sdhci_pltfm_priv(pltfm_host);
> >> +    struct sdhci_brcmstb_saved_regs *sr =3D &priv->saved_regs;
> >> +    void __iomem *cr =3D priv->cfg_regs;
> >> +    bool is_emmc =3D mmc->caps & MMC_CAP_NONREMOVABLE;
> >> +
> >> +    /* save  */
>
> Comment is not really needed.
>
> >> +    if (is_emmc && priv->boot_regs)
> >> +            sr->boot_main_ctl =3D readl(priv->boot_regs + SDIO_BOOT_M=
AIN_CTL);
> >> +
> >> +    if (ver =3D=3D SDIO_CFG_CORE_V1) {
> >> +            sr->sd_pin_sel =3D readl(cr + SDIO_CFG_V1_SD_PIN_SEL);
> >> +            return;
> >> +    }
> >> +
> >> +    sr->sd_pin_sel =3D readl(cr + SDIO_CFG_SD_PIN_SEL);
> >> +    sr->phy_sw_mode0_rxctrl =3D readl(cr + SDIO_CFG_PHY_SW_MODE_0_RX_=
CTRL);
> >> +    sr->max_50mhz_mode =3D readl(cr + SDIO_CFG_MAX_50MHZ_MODE);
> >> +}
> >> +
> >> +static void sdhci_brcmstb_restore_regs(struct mmc_host *mmc,
> >> +                                            enum cfg_core_ver ver)
>
> Prefer to line up function parameters.  Using up to 100 columns is also o=
k.
>
> >> +{
> >> +    struct sdhci_host *host =3D mmc_priv(mmc);
> >> +    struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> >> +    struct sdhci_brcmstb_priv *priv =3D sdhci_pltfm_priv(pltfm_host);
> >> +    struct sdhci_brcmstb_saved_regs *sr =3D &priv->saved_regs;
> >> +    void __iomem *cr =3D priv->cfg_regs;
> >> +    bool is_emmc =3D mmc->caps & MMC_CAP_NONREMOVABLE;
> >> +
> >> +    /* restore */
>
> Comment is not really needed.
>
> >> +    if (is_emmc && priv->boot_regs)
> >> +            writel(sr->boot_main_ctl, priv->boot_regs + SDIO_BOOT_MAI=
N_CTL);
> >> +
> >> +    if (ver =3D=3D SDIO_CFG_CORE_V1) {
> >> +            writel(sr->sd_pin_sel, cr + SDIO_CFG_SD_PIN_SEL);
> >> +            return;
> >> +    }
> >> +
> >> +    writel(sr->sd_pin_sel, cr + SDIO_CFG_SD_PIN_SEL);
> >> +    writel(sr->phy_sw_mode0_rxctrl, cr + SDIO_CFG_PHY_SW_MODE_0_RX_CT=
RL);
> >> +    writel(sr->max_50mhz_mode, cr + SDIO_CFG_MAX_50MHZ_MODE);
> >> +}
> >> +
> >> +static void sdhci_brcmstb_save_restore_regs_v1(struct mmc_host *mmc, =
int save)
> >> +{
> >> +    if (save)
> >> +            sdhci_brcmstb_save_regs(mmc, SDIO_CFG_CORE_V1);
> >> +    else
> >> +            sdhci_brcmstb_restore_regs(mmc, SDIO_CFG_CORE_V1);
> >> +}
> >> +
> >> +static void sdhci_brcmstb_save_restore_regs_v2(struct mmc_host *mmc, =
int save)
> >> +{
> >> +    if (save)
> >> +            sdhci_brcmstb_save_regs(mmc, SDIO_CFG_CORE_V2);
> >> +    else
> >> +            sdhci_brcmstb_restore_regs(mmc, SDIO_CFG_CORE_V2);
> >> +}
> >> +
> >>  static inline void enable_clock_gating(struct sdhci_host *host)
> >>  {
> >>      struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> >> @@ -300,24 +385,33 @@ static struct brcmstb_match_priv match_priv_7425=
 =3D {
> >>      .ops =3D &sdhci_brcmstb_ops,
> >>  };
> >>
> >> -static struct brcmstb_match_priv match_priv_7445 =3D {
> >> +static struct brcmstb_match_priv match_priv_74371 =3D {
> >>      .flags =3D BRCMSTB_MATCH_FLAGS_BROKEN_TIMEOUT,
> >>      .ops =3D &sdhci_brcmstb_ops,
> >>  };
> >>
> >> +static struct brcmstb_match_priv match_priv_7445 =3D {
> >> +    .flags =3D BRCMSTB_MATCH_FLAGS_BROKEN_TIMEOUT |
> >> +                    BRCMSTB_MATCH_FLAGS_HAS_CFG_V1,
> >> +    .ops =3D &sdhci_brcmstb_ops,
> >> +};
> >> +
> >>  static struct brcmstb_match_priv match_priv_72116 =3D {
> >> -    .flags =3D BRCMSTB_MATCH_FLAGS_BROKEN_TIMEOUT,
> >> +    .flags =3D BRCMSTB_MATCH_FLAGS_BROKEN_TIMEOUT |
> >> +                    BRCMSTB_MATCH_FLAGS_HAS_CFG_V1,
> >>      .ops =3D &sdhci_brcmstb_ops_72116,
> >>  };
> >>
> >>  static const struct brcmstb_match_priv match_priv_7216 =3D {
> >> -    .flags =3D BRCMSTB_MATCH_FLAGS_HAS_CLOCK_GATE,
> >> +    .flags =3D BRCMSTB_MATCH_FLAGS_HAS_CLOCK_GATE |
> >> +                    BRCMSTB_MATCH_FLAGS_HAS_CFG_V2,
> >>      .hs400es =3D sdhci_brcmstb_hs400es,
> >>      .ops =3D &sdhci_brcmstb_ops_7216,
> >>  };
> >>
> >>  static struct brcmstb_match_priv match_priv_74165b0 =3D {
> >> -    .flags =3D BRCMSTB_MATCH_FLAGS_HAS_CLOCK_GATE,
> >> +    .flags =3D BRCMSTB_MATCH_FLAGS_HAS_CLOCK_GATE |
> >> +                    BRCMSTB_MATCH_FLAGS_HAS_CFG_V2,
> >>      .hs400es =3D sdhci_brcmstb_hs400es,
> >>      .ops =3D &sdhci_brcmstb_ops_74165b0,
> >>  };
> >> @@ -325,6 +419,7 @@ static struct brcmstb_match_priv match_priv_74165b=
0 =3D {
> >>  static const struct of_device_id __maybe_unused sdhci_brcm_of_match[]=
 =3D {
> >>      { .compatible =3D "brcm,bcm2712-sdhci", .data =3D &match_priv_271=
2 },
> >>      { .compatible =3D "brcm,bcm7425-sdhci", .data =3D &match_priv_742=
5 },
> >> +    { .compatible =3D "brcm,bcm74371-sdhci", .data =3D &match_priv_74=
371 },
> >
> > Shouldn't adding brcm,bcm74371-sdhci be a separate patch?
> >
> >>      { .compatible =3D "brcm,bcm7445-sdhci", .data =3D &match_priv_744=
5 },
> >>      { .compatible =3D "brcm,bcm72116-sdhci", .data =3D &match_priv_72=
116 },
> >>      { .compatible =3D "brcm,bcm7216-sdhci", .data =3D &match_priv_721=
6 },
> >> @@ -441,6 +536,19 @@ static int sdhci_brcmstb_probe(struct platform_de=
vice *pdev)
> >>      if (res)
> >>              goto err;
> >>
> >> +    /* map non-standard BOOT registers if present */
> >> +    if (host->mmc->caps & MMC_CAP_NONREMOVABLE) {
> >> +            priv->boot_regs =3D devm_platform_get_and_ioremap_resourc=
e(pdev, 2, NULL);
> >> +            if (IS_ERR(priv->boot_regs))
> >> +                    priv->boot_regs =3D NULL;
> >> +    }
> >> +
> >> +    if (match_priv->flags & BRCMSTB_MATCH_FLAGS_HAS_CFG_V1)
> >> +            priv->save_restore_regs =3D sdhci_brcmstb_save_restore_re=
gs_v1;
> >> +
> >> +    if (match_priv->flags & BRCMSTB_MATCH_FLAGS_HAS_CFG_V2)
> >> +            priv->save_restore_regs =3D sdhci_brcmstb_save_restore_re=
gs_v2;
> >
> > It is not ideal to use a flag to set a callback.  Perhaps sdhci_brcmstb=
_priv
> > should have a pointer to brcmstb_match_priv, then ->save_restore_regs()=
 could
> > just be put there, and BRCMSTB_MATCH_FLAGS_HAS_CFG_V* are not needed.
> >
> >> +
> >>      /*
> >>       * Automatic clock gating does not work for SD cards that may
> >>       * voltage switch so only enable it for non-removable devices.
> >> @@ -533,6 +641,9 @@ static int sdhci_brcmstb_suspend(struct device *de=
v)
> >>      struct sdhci_brcmstb_priv *priv =3D sdhci_pltfm_priv(pltfm_host);
> >>      int ret;
> >>
> >> +    if (priv->save_restore_regs)
> >> +            priv->save_restore_regs(host->mmc, 1);
> >> +
> >>      clk_disable_unprepare(priv->base_clk);
> >>      if (host->mmc->caps2 & MMC_CAP2_CQE) {
> >>              ret =3D cqhci_suspend(host->mmc);
> >> @@ -564,6 +675,9 @@ static int sdhci_brcmstb_resume(struct device *dev=
)
> >>                      ret =3D clk_set_rate(priv->base_clk, priv->base_f=
req_hz);
> >>      }
> >>
> >> +    if (priv->save_restore_regs)
> >> +            priv->save_restore_regs(host->mmc, 0);
> >> +
> >>      if (host->mmc->caps2 & MMC_CAP2_CQE)
> >>              ret =3D cqhci_resume(host->mmc);
> >>
> >
>
Thanks for the review. Ok let me fix all the review comments and send a v2.

--00000000000068c7960640819427
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
H0K0rs+X8O45xZIUJlxzf5UZex3BLi1f/H+08rSQULWEtO/ECwkFod2DIzSX7fZdz5RQ1PpziEOp
goo/JZPYIeCmgt3rIyvMuupj8Ymb0J/velhpXfQuYUM52viw2nmqVcxCwBqyM3Iq7eI4xtEOFRmR
wxSizd3MSQMf6GCHA4/B/6ttnxhGAr3utaOU+x/RnzG0gPLTW1XRAQ0+GVc/tGFdI864OG1cyrRl
GvBnHJQSAFOIKwYrUk2oFpgMbafQ6osCAwEAAaOCAdswggHXMA4GA1UdDwEB/wQEAwIFoDAMBgNV
HRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDovL3NlY3VyZS5n
bG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5BggrBgEFBQcwAYYt
aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUGA1UdIAReMFww
CQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUFBwIBFiZodHRw
czovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDagNKAyhjBodHRw
Oi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMy5jcmwwIgYDVR0RBBswGYEX
a2FtYWwuZGFzdUBicm9hZGNvbS5jb20wEwYDVR0lBAwwCgYIKwYBBQUHAwQwHwYDVR0jBBgwFoAU
ACk2nlx6ug+vLVAt26AjhRiwoJIwHQYDVR0OBBYEFOV9h+N/T9ZsJ40qRxh7NYYD+N6MMA0GCSqG
SIb3DQEBCwUAA4ICAQAKtKh30wv1/30230mCimgUjMWQE/LImRmyfDgrp2IhBVS6mDun+wH8thEB
WhBHQMz3gsGixU4ZBJG72eWi39IzQ7CGnisJwA0+hsGaGg03AVtFtqo1rXYRZ81MEDOb6BPYLigJ
RsHbNmrUGR+LsGeUwOWUeRXqBrYaYFrkgHKvVK1NEewv+vUY08n4tsezO3jq0HKhVDY46bMbf8vL
oQqqhtcQvu2+5FK2jpUayeubpzPwobjEG61RIhBvM0KivY4CB2s9A7qgjL1XBycAybIvG03BbFoT
t282FqXwk9JU6YihLlt+hpzO9UF7E8GZYlQlVIZOLOvytqilhua+2h77Yy8Jz/FJyIXKuaLPtvb2
SC2shL7jF28kQbP3QUKwAig+cxwbpngnUkd9D9cXSHVq9PPwYm0A4eAO0YQ/80Uq20+gXF++g0sy
NKrrV3i0T1dbCd86miGDKvarGzjh7pdsdwNY15liGP6Orib1tnWkJcbtP1rJty4r/mbbxcK8ILO4
IvTGFG6BfjJ+La0aRt69i1fQmjUWHLwzkLNpw9cJH8/MONZcEJeDkq9WELSyy29bagStk5KHu7NO
TH65sZg+i/4qmj3DEeEGTr/Shzp4YWSNn4W7NEelr0VgDlwa7xqlwZjXxG4MIJqy0SsQlAwEXtqd
nH2FpJfzgAetkuyU6DGCAlcwggJTAgEBMGIwUjELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2Jh
bFNpZ24gbnYtc2ExKDAmBgNVBAMTH0dsb2JhbFNpZ24gR0NDIFI2IFNNSU1FIENBIDIwMjMCDEca
ZUGCu6d0oT1M+zANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQgTZEmvZl17glf1scg
9VzoMaGwDk6nR0huErZT4zh/qtwwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0B
CQUxDxcNMjUxMDA2MTgyNTQ1WjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFlAwQBKjALBglghkgB
ZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEw
DQYJKoZIhvcNAQEBBQAEggEASMndznfIczNjsu8ZBYrniekr2vq3FdDib+N0eTed1FAORfOpkDZS
U+uC0PWwZogARysVlZJ0jS77XKshWhfeNnDKHtiZ+Gr2HkaXiry7AuO/YtUI7UeiaViWER46DV5n
A9oiudwTTHa9TEd95rH/onHV6zJxyeqb+8V2EditxBBG6HUPht25dGHS3hAIM99wol8Y4LNOcMMj
EqrIfE8lrVjfdC9bkOfMy9jnsxSocfIJEJ647WpijVa66zlqk/5fSSEu+QdYQKj9fMoPxlnAQpGE
2PECAlogYgT+JeXFIvEJee7Vgk4hjlmGhmzr0yVPxmVvou6Qw5o4A0JNvmnbFQ==
--00000000000068c7960640819427--
