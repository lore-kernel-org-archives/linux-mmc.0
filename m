Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9061AAE35;
	Thu, 20 Jun 2024 10:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718879988; cv=none; b=Y9OLqb/r33QAr895jbztteW3JbbBHHXohmOm9i3oxs5dt6J+BBe3EqCq/P9qGly+gYWqEvBfJPSCKQuUz7Bk4mfDYZI8nb5SHu/OZLcxtvtQHvt46wmWeFAML/q/tRO6yMgz7rsYBlmuFiBHoOiBmP//wBFRJrUs4txNd7pCIDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718879988; c=relaxed/simple;
	bh=PtAQdVoP5V6ppx4dYLrQWFm0fTfaQMfiUnjujw567kA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I9u49rrqRBW3WUg4Jh0yV7okA6lWCl8ietIhFb4QxoFIbLZjmFAf++c2PI0TBLzYVYIXeyqEHlUlPwZ6lgl0p1dgfLWHaQjlf7WGc4b6OfhkFbG69PGuwFU3RCHLBhO+2lReLkIFuTD2OAmMuiFXUxv6I5OfFccEp8OMU5AJfhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dpiHOR4c; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dpiHOR4c"
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-80f59ebd021so249346241.3;
        Thu, 20 Jun 2024 03:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718879985; x=1719484785; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uYSuT6vUkK3TGV0GDL1F1U8u2DRFOjpO2c/fFNT9tGo=;
        b=dpiHOR4cKMEjpKTfcT7CBZijq/nSlVS9wIgVkyIfvqu7VkMUrACssiEmDZlRdXOCw8
         REphq4EtOOA34hQBq+T3Ahle6qNUdi5JauS9ixUMhOGJr+65rwF5H0SjjWbkaP5jIZ8i
         5mtCyywzWIJoIRRKQfDKL80SS3elW1kCuHTRHv04QMPIOQgWrqpSQGBhFGg5FCwJ8bXs
         4q53tmOMdBMsV0Hh6nTjHe8W3RDrNGqaYkCa46EjqlkwNto1p9svBoj1u33KlbuqBMyY
         xmbLqBl0CKxmrG/QkE8GNN/uFHFnBm88bJOT1dt4inwdeRWFPQugDjIQTeL5X6HWLMwV
         mthA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718879985; x=1719484785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uYSuT6vUkK3TGV0GDL1F1U8u2DRFOjpO2c/fFNT9tGo=;
        b=aHrLY6aWcJUo4kpicVawNg6Rqj+2QZKk2g3is8ZD/28A8AexBnjlLpEWpfc86vRTaH
         pStlIU1+57wl/XNyZDlxXwRqTd/Q6nu5rzBKv43K52dClk5pBuQHm33NPB7eby+FegTd
         42wh605jYUzIBiCVUU2U+UZVs9RIQMa/JOn30zvQoP+TzMKXNdLaBBZUDBh40EuzKsZh
         aONzNpqxz3Pf95ylLNtdGZ/Y5uOv1NsjMoYnxnuSS2cfRggw0TP4j9mg+b0xCbqQrPBv
         RqCgJtfahquL2hPSKltHBNlAt9AVicweHSfdb4wHCrnVbB5oh6ynfyWCPUvLm12ApUr9
         rKLA==
X-Forwarded-Encrypted: i=1; AJvYcCUpAn9/YKpxGKqY5mPwgRbJ7tMB4+BMtiImyZ1XfuxdNLWb0uVmW7swr4SWu11jnUY+5HV1wpKXz7RK7gmz8LDlZISxgHTg7G5dFLjw
X-Gm-Message-State: AOJu0Yyj5i7Ot4T7ZWNRFgIgzO4gBNwkPPOH3WN0kCZmDzZzg4JFFuYY
	0rBOpX/mQyG1Px6YwfNTGL2k1oWCnDHVHtOJJXrSl1mXckxpdphdSMIHaQYqpq70s4YtUHiZOZ/
	SoaDjZIvW1lxbkPtuz9z9QE/P+uw=
X-Google-Smtp-Source: AGHT+IEQDEXYMQXxLKTm5IOrOOeMgFR4QHup6ekVangCK6/sqvM7Etnj8rTnLS9gj/bppKrQymFBu/9U1vX7MkDYQvE=
X-Received: by 2002:a05:6102:184c:b0:48f:22d2:3b65 with SMTP id
 ada2fe7eead31-48f22d23c9amr2118517137.25.1718879985318; Thu, 20 Jun 2024
 03:39:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240522110909.10060-1-victorshihgli@gmail.com>
 <20240522110909.10060-24-victorshihgli@gmail.com> <81adac4f-edc5-4e3d-8c74-68a33183c3e3@intel.com>
In-Reply-To: <81adac4f-edc5-4e3d-8c74-68a33183c3e3@intel.com>
From: Victor Shih <victorshihgli@gmail.com>
Date: Thu, 20 Jun 2024 18:39:33 +0800
Message-ID: <CAK00qKDn46y59q9EFDSWBezrc5sbe5660xKzKsXs7eT1bj3DBQ@mail.gmail.com>
Subject: Re: [PATCH V16 23/23] mmc: sdhci-pci-gli: enable UHS-II mode for GL9767
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw, 
	Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org, dlunev@chromium.org, 
	Ben Chuang <ben.chuang@genesyslogic.com.tw>, 
	Victor Shih <victor.shih@genesyslogic.com.tw>, ulf.hansson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 24, 2024 at 1:09=E2=80=AFAM Adrian Hunter <adrian.hunter@intel.=
com> wrote:
>
> On 22/05/24 14:09, Victor Shih wrote:
> > From: Victor Shih <victor.shih@genesyslogic.com.tw>
> >
> > Changes are:
> >  * Enable the internal clock when do reset on UHS-II mode.
> >  * Increase timeout value before detecting UHS-II interface.
> >  * Add vendor settings for UHS-II mode.
> >
> > Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> > ---
> >
> > Updates in V15:
> >  - Add gl9767 to support uhs2 function.
> >
> > ---
> >
> >  drivers/mmc/host/sdhci-pci-gli.c | 152 ++++++++++++++++++++++++++++++-
> >  drivers/mmc/host/sdhci-uhs2.c    |   3 +-
> >  drivers/mmc/host/sdhci-uhs2.h    |   1 +
> >  3 files changed, 153 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-=
pci-gli.c
> > index 5df6be758b06..20f19cec6e64 100644
> > --- a/drivers/mmc/host/sdhci-pci-gli.c
> > +++ b/drivers/mmc/host/sdhci-pci-gli.c
> > @@ -210,6 +210,10 @@
> >  #define   PCIE_GLI_9767_SCR_CORE_PWR_D3_OFF            BIT(21)
> >  #define   PCIE_GLI_9767_SCR_CFG_RST_DATA_LINK_DOWN     BIT(30)
> >
> > +#define PCIE_GLI_9767_UHS2_PHY_SET_REG1                              0=
x90C
> > +#define   PCIE_GLI_9767_UHS2_PHY_SET_REG1_SERDES_INTR                 =
 GENMASK(31, 29)
> > +#define   PCIE_GLI_9767_UHS2_PHY_SET_REG1_SERDES_INTR_VALUE    0x3
> > +
> >  #define PCIE_GLI_9767_SDHC_CAP                       0x91C
> >  #define   PCIE_GLI_9767_SDHC_CAP_SDEI_RESULT   BIT(5)
> >
> > @@ -228,9 +232,15 @@
> >  #define   PCIE_GLI_9767_SD_EXPRESS_CTL_SD_EXPRESS_MODE         BIT(1)
> >
> >  #define PCIE_GLI_9767_SD_DATA_MULTI_CTL                              0=
x944
> > +#define   PCIE_GLI_9767_SD_DATA_MULTI_CTL_SELECT_UHS2                 =
 BIT(5)
> > +#define   PCIE_GLI_9767_SD_DATA_MULTI_CTL_UHS2_SWITCH_CTL      BIT(8)
> >  #define   PCIE_GLI_9767_SD_DATA_MULTI_CTL_DISCONNECT_TIME      GENMASK=
(23, 16)
> >  #define   PCIE_GLI_9767_SD_DATA_MULTI_CTL_DISCONNECT_TIME_VALUE       =
 0x64
> >
> > +#define PCIE_GLI_9767_UHS2_PHY_SET_REG2                               =
       0x948
> > +#define   PCIE_GLI_9767_UHS2_PHY_SET_REG2_SSC_PPM_SETTING             =
 GENMASK(22, 21)
> > +#define   PCIE_GLI_9767_UHS2_PHY_SET_REG2_SSC_PPM_SETTING_VALUE       =
         0x0
> > +
> >  #define PCIE_GLI_9767_NORMAL_ERR_INT_STATUS_REG2                     0=
x950
> >  #define   PCIE_GLI_9767_NORMAL_ERR_INT_STATUS_REG2_SDEI_COMPLETE      =
 BIT(0)
> >
> > @@ -240,6 +250,28 @@
> >  #define PCIE_GLI_9767_NORMAL_ERR_INT_SIGNAL_EN_REG2                   =
       0x958
> >  #define   PCIE_GLI_9767_NORMAL_ERR_INT_SIGNAL_EN_REG2_SDEI_COMPLETE_SI=
GNAL_EN          BIT(0)
> >
> > +#define PCIE_GLI_9767_UHS2_CTL1                              0x95C
> > +#define   PCIE_GLI_9767_UHS2_CTL1_TRANS_PASS           BIT(5)
> > +#define   PCIE_GLI_9767_UHS2_CTL1_TRANS_PASS_VALUE     0x1
> > +#define   PCIE_GLI_9767_UHS2_CTL1_DECODING_CTL                 BIT(6)
> > +#define   PCIE_GLI_9767_UHS2_CTL1_DECODING_CTL_VALUE   0x1
> > +#define   PCIE_GLI_9767_UHS2_CTL1_SERDES_TRAN                  GENMASK=
(10, 7)
> > +#define   PCIE_GLI_9767_UHS2_CTL1_SERDES_TRAN_VALUE    0x3
> > +#define   PCIE_GLI_9767_UHS2_CTL1_SERDES_RECV                  GENMASK=
(14, 11)
> > +#define   PCIE_GLI_9767_UHS2_CTL1_SERDES_RECV_VALUE    0xf
> > +#define   PCIE_GLI_9767_UHS2_CTL1_DIR_TRANS            GENMASK(16, 15)
> > +#define   PCIE_GLI_9767_UHS2_CTL1_DIR_TRANS_VALUE      0x3
> > +#define   PCIE_GLI_9767_UHS2_CTL1_DIR_RECV             GENMASK(18, 17)
> > +#define   PCIE_GLI_9767_UHS2_CTL1_DIR_RECV_VALUE       0x0
> > +#define   PCIE_GLI_9767_UHS2_CTL1_PDRST                        BIT(25)
> > +#define   PCIE_GLI_9767_UHS2_CTL1_PDRST_VALUE                  0x1
> > +
> > +#define PCIE_GLI_9767_UHS2_CTL2                      0x964
> > +#define   PCIE_GLI_9767_UHS2_CTL2_ZC           GENMASK(3, 0)
> > +#define   PCIE_GLI_9767_UHS2_CTL2_ZC_VALUE     0xb
> > +#define   PCIE_GLI_9767_UHS2_CTL2_ZC_CTL       BIT(6)
> > +#define   PCIE_GLI_9767_UHS2_CTL2_ZC_CTL_VALUE         0x1
> > +
> >  #define GLI_MAX_TUNING_LOOP 40
> >
> >  /* Genesys Logic chipset */
> > @@ -1198,8 +1230,35 @@ static void gl9767_hw_setting(struct sdhci_pci_s=
lot *slot)
> >
> >  static void sdhci_gl9767_reset(struct sdhci_host *host, u8 mask)
> >  {
> > -     sdhci_reset(host, mask);
> > -     gli_set_9767(host);
> > +     u16 clk_ctrl;
> > +     u16 ctrl2;
> > +
> > +     if (host->mmc->ios.timing =3D=3D MMC_TIMING_UHS2_SPEED_A ||
> > +         host->mmc->ios.timing =3D=3D MMC_TIMING_UHS2_SPEED_A_HD ||
> > +         host->mmc->ios.timing =3D=3D MMC_TIMING_UHS2_SPEED_B ||
> > +         host->mmc->ios.timing =3D=3D MMC_TIMING_UHS2_SPEED_B_HD) {
> > +             /* need internal clock */
> > +             if (mask & SDHCI_RESET_ALL) {
> > +                     ctrl2 =3D sdhci_readw(host, SDHCI_HOST_CONTROL2);
> > +                     clk_ctrl =3D sdhci_readw(host, SDHCI_CLOCK_CONTRO=
L);
> > +
> > +                     if ((ctrl2 & SDHCI_CTRL_V4_MODE) && (ctrl2 & SDHC=
I_CTRL_UHS2_ENABLE)) {
> > +                             sdhci_writew(host, SDHCI_CLOCK_INT_EN, SD=
HCI_CLOCK_CONTROL);
> > +                     } else {
> > +                             sdhci_writew(host, SDHCI_CLOCK_INT_EN, SD=
HCI_CLOCK_CONTROL);
> > +                             sdhci_wait_clock_stable(host);
> > +                             sdhci_writew(host, SDHCI_CTRL_V4_MODE, SD=
HCI_HOST_CONTROL2);
> > +                     }
> > +             }
> > +             if ((mask & SDHCI_RESET_CMD) | (mask & SDHCI_RESET_DATA))
> > +                     sdhci_gli_uhs2_reset_sd_tran(host);
> > +
> > +             sdhci_uhs2_reset(host, mask);
> > +             gli_set_9767(host);
> > +     } else {
> > +             sdhci_reset(host, mask);
> > +             gli_set_9767(host);
> > +     }
> >  }
> >
> >  static int gl9767_init_sd_express(struct mmc_host *mmc, struct mmc_ios=
 *ios)
> > @@ -1289,6 +1348,87 @@ static int gl9767_init_sd_express(struct mmc_hos=
t *mmc, struct mmc_ios *ios)
> >       return 0;
> >  }
> >
> > +static void gl9767_vendor_init(struct sdhci_host *host)
> > +{
> > +     struct sdhci_pci_slot *slot =3D sdhci_priv(host);
> > +     struct pci_dev *pdev =3D slot->chip->pdev;
> > +     u32 value;
> > +
> > +     gl9767_vhs_write(pdev);
> > +
> > +     pci_read_config_dword(pdev, PCIE_GLI_9767_UHS2_PHY_SET_REG1, &val=
ue);
> > +     value |=3D FIELD_PREP(PCIE_GLI_9767_UHS2_PHY_SET_REG1_SERDES_INTR=
,
> > +                         PCIE_GLI_9767_UHS2_PHY_SET_REG1_SERDES_INTR_V=
ALUE);
> > +     pci_write_config_dword(pdev, PCIE_GLI_9767_UHS2_PHY_SET_REG1, val=
ue);
> > +
> > +     pci_read_config_dword(pdev, PCIE_GLI_9767_UHS2_PHY_SET_REG2, &val=
ue);
> > +     value |=3D FIELD_PREP(PCIE_GLI_9767_UHS2_PHY_SET_REG2_SSC_PPM_SET=
TING,
> > +                         PCIE_GLI_9767_UHS2_PHY_SET_REG2_SSC_PPM_SETTI=
NG_VALUE);
> > +     pci_write_config_dword(pdev, PCIE_GLI_9767_UHS2_PHY_SET_REG2, val=
ue);
> > +
> > +     pci_read_config_dword(pdev, PCIE_GLI_9767_UHS2_CTL1, &value);
> > +     value |=3D FIELD_PREP(PCIE_GLI_9767_UHS2_CTL1_TRANS_PASS,
> > +                         PCIE_GLI_9767_UHS2_CTL1_TRANS_PASS_VALUE) |
> > +              FIELD_PREP(PCIE_GLI_9767_UHS2_CTL1_DECODING_CTL,
> > +                         PCIE_GLI_9767_UHS2_CTL1_DECODING_CTL_VALUE) |
> > +              FIELD_PREP(PCIE_GLI_9767_UHS2_CTL1_SERDES_TRAN,
> > +                         PCIE_GLI_9767_UHS2_CTL1_SERDES_TRAN_VALUE) |
> > +              FIELD_PREP(PCIE_GLI_9767_UHS2_CTL1_SERDES_RECV,
> > +                         PCIE_GLI_9767_UHS2_CTL1_SERDES_RECV_VALUE) |
> > +              FIELD_PREP(PCIE_GLI_9767_UHS2_CTL1_DIR_TRANS,
> > +                         PCIE_GLI_9767_UHS2_CTL1_DIR_TRANS_VALUE) |
> > +              FIELD_PREP(PCIE_GLI_9767_UHS2_CTL1_DIR_RECV,
> > +                         PCIE_GLI_9767_UHS2_CTL1_DIR_RECV_VALUE) |
> > +              FIELD_PREP(PCIE_GLI_9767_UHS2_CTL1_PDRST,
> > +                         PCIE_GLI_9767_UHS2_CTL1_PDRST_VALUE);
> > +     pci_write_config_dword(pdev, PCIE_GLI_9767_UHS2_CTL1, value);
> > +
> > +     pci_read_config_dword(pdev, PCIE_GLI_9767_UHS2_CTL2, &value);
> > +     value |=3D FIELD_PREP(PCIE_GLI_9767_UHS2_CTL2_ZC,
> > +                         PCIE_GLI_9767_UHS2_CTL2_ZC_VALUE) |
> > +              FIELD_PREP(PCIE_GLI_9767_UHS2_CTL2_ZC_CTL,
> > +                         PCIE_GLI_9767_UHS2_CTL2_ZC_CTL_VALUE);
> > +     pci_write_config_dword(pdev, PCIE_GLI_9767_UHS2_CTL2, value);
> > +
> > +     gl9767_vhs_read(pdev);
> > +}
> > +
> > +static void sdhci_gl9767_set_power(struct sdhci_host *host, unsigned c=
har mode,      unsigned short vdd)
> > +{
> > +     struct sdhci_pci_slot *slot =3D sdhci_priv(host);
> > +     struct pci_dev *pdev;
> > +     u32 value;
> > +
> > +     pdev =3D slot->chip->pdev;
> > +
> > +     if (host->mmc->ios.timing =3D=3D MMC_TIMING_UHS2_SPEED_A ||
> > +         host->mmc->ios.timing =3D=3D MMC_TIMING_UHS2_SPEED_A_HD ||
> > +         host->mmc->ios.timing =3D=3D MMC_TIMING_UHS2_SPEED_B ||
> > +         host->mmc->ios.timing =3D=3D MMC_TIMING_UHS2_SPEED_B_HD) {
> > +             gl9767_vhs_write(pdev);
> > +
> > +             pci_read_config_dword(pdev, PCIE_GLI_9767_SD_DATA_MULTI_C=
TL, &value);
> > +             value |=3D PCIE_GLI_9767_SD_DATA_MULTI_CTL_SELECT_UHS2 |
> > +                      PCIE_GLI_9767_SD_DATA_MULTI_CTL_UHS2_SWITCH_CTL;
> > +             pci_write_config_dword(pdev, PCIE_GLI_9767_SD_DATA_MULTI_=
CTL, value);
> > +
> > +             gl9767_vhs_read(pdev);
> > +
> > +             sdhci_uhs2_set_power(host, mode, vdd);
> > +     } else {
> > +             gl9767_vhs_write(pdev);
> > +
> > +             pci_read_config_dword(pdev, PCIE_GLI_9767_SD_DATA_MULTI_C=
TL, &value);
> > +             value &=3D ~(PCIE_GLI_9767_SD_DATA_MULTI_CTL_SELECT_UHS2 =
|
> > +                        PCIE_GLI_9767_SD_DATA_MULTI_CTL_UHS2_SWITCH_CT=
L);
> > +             pci_write_config_dword(pdev, PCIE_GLI_9767_SD_DATA_MULTI_=
CTL, value);
> > +
> > +             gl9767_vhs_read(pdev);
> > +
> > +             sdhci_set_power(host, mode, vdd);
> > +     }
> > +}
> > +
> >  static int gli_probe_slot_gl9750(struct sdhci_pci_slot *slot)
> >  {
> >       struct sdhci_host *host =3D slot->host;
> > @@ -1325,6 +1465,7 @@ static int gli_probe_slot_gl9767(struct sdhci_pci=
_slot *slot)
> >       host->mmc->caps2 |=3D MMC_CAP2_SD_EXP;
> >       host->mmc_host_ops.init_sd_express =3D gl9767_init_sd_express;
> >       sdhci_enable_v4_mode(host);
> > +     gl9767_vendor_init(host);
> >
> >       return 0;
> >  }
> > @@ -1828,12 +1969,19 @@ static const struct sdhci_ops sdhci_gl9767_ops =
=3D {
> >       .reset                   =3D sdhci_gl9767_reset,
> >       .set_uhs_signaling       =3D sdhci_set_uhs_signaling,
> >       .voltage_switch          =3D sdhci_gl9767_voltage_switch,
> > +     .dump_uhs2_regs          =3D sdhci_uhs2_dump_regs,
> > +     .set_timeout             =3D sdhci_uhs2_set_timeout,
> > +     .irq                     =3D sdhci_uhs2_irq,
> > +     .set_power               =3D sdhci_gl9767_set_power,
> > +     .uhs2_pre_detect_init    =3D sdhci_gli_pre_detect_init,
> >  };
> >
> >  const struct sdhci_pci_fixes sdhci_gl9767 =3D {
> >       .quirks         =3D SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
> >       .quirks2        =3D SDHCI_QUIRK2_BROKEN_DDR50,
> >       .probe_slot     =3D gli_probe_slot_gl9767,
> > +     .add_host       =3D sdhci_pci_uhs2_add_host,
> > +     .remove_host    =3D sdhci_pci_uhs2_remove_host,
> >       .ops            =3D &sdhci_gl9767_ops,
> >  #ifdef CONFIG_PM_SLEEP
> >       .resume         =3D sdhci_pci_gli_resume,
> > diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs=
2.c
> > index c830ee352504..47180429448b 100644
> > --- a/drivers/mmc/host/sdhci-uhs2.c
> > +++ b/drivers/mmc/host/sdhci-uhs2.c
> > @@ -125,7 +125,7 @@ static void sdhci_uhs2_reset_cmd_data(struct mmc_ho=
st *mmc)
> >       }
> >  }
> >
> > -static void sdhci_uhs2_set_power(struct sdhci_host *host, unsigned cha=
r mode, unsigned short vdd)
> > +void sdhci_uhs2_set_power(struct sdhci_host *host, unsigned char mode,=
 unsigned short vdd)
> >  {
> >       struct mmc_host *mmc =3D host->mmc;
> >       u8 pwr =3D 0;
> > @@ -165,6 +165,7 @@ static void sdhci_uhs2_set_power(struct sdhci_host =
*host, unsigned char mode, un
> >               mdelay(5);
> >       }
> >  }
> > +EXPORT_SYMBOL_GPL(sdhci_uhs2_set_power);
>
> Might as well export sdhci_uhs2_set_power() when it is first added
>

Hi, Adrian

I will update this in patch series v17.

Thanks, Victor Shih

> >
> >  static u8 sdhci_calc_timeout_uhs2(struct sdhci_host *host, u8 *cmd_res=
, u8 *dead_lock)
> >  {
> > diff --git a/drivers/mmc/host/sdhci-uhs2.h b/drivers/mmc/host/sdhci-uhs=
2.h
> > index 42f34ca75275..c4a860f4e1e0 100644
> > --- a/drivers/mmc/host/sdhci-uhs2.h
> > +++ b/drivers/mmc/host/sdhci-uhs2.h
> > @@ -185,5 +185,6 @@ void sdhci_uhs2_clear_set_irqs(struct sdhci_host *h=
ost, u32 clear, u32 set);
> >  u32 sdhci_uhs2_irq(struct sdhci_host *host, u32 intmask);
> >  int sdhci_uhs2_add_host(struct sdhci_host *host);
> >  void sdhci_uhs2_remove_host(struct sdhci_host *host, int dead);
> > +void sdhci_uhs2_set_power(struct sdhci_host *host, unsigned char mode,=
 unsigned short vdd);
> >
> >  #endif /* __SDHCI_UHS2_H */
>
