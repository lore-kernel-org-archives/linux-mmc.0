Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A1B18DF89;
	Thu, 29 Aug 2024 09:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724923348; cv=none; b=IUxOFfkgnOI/LFA/sohFxqE6s0PPOnRfjNm3+Z9/0reodtUED5ADGIkOfgToc623TdMHCPZN9M5PKAN3qof8daaHkYOmErcKk5i9dl4bYnS2Ga7uF63HPI00lLEHVnnfjUs8moQ4pUrPL1X1XiwmogWgNDYBzJq2Lv6TZBSRK5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724923348; c=relaxed/simple;
	bh=2qJeJuWEGgKEL+op8XdX/ZVZpQE5/F4rMwMmkIYdSxI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eDYHcaNME/7QDVJ+aACNU+pO65mC02jQvLTqQ2PFkeZSqxDPomH6Bw5DehOAR8MLMqoH4lFQJ5svtrBAd4EAW3x1ZwVuccCo+yxUfhZK2Sgt06BTzQ8TrxRDgy9uSatlIijAPpuznwtllcSK+8Gb3LTkRVW74Omx4LY01goRPJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TJ9ptFII; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TJ9ptFII"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-4fcf4ae95dbso195120e0c.0;
        Thu, 29 Aug 2024 02:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724923345; x=1725528145; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RSl2ovaivwnTSTlfxzsVM7kAV63t3rvKKAijhEcDkl4=;
        b=TJ9ptFII6do1YobnQKPYCiCQwUZaSqgVnz0sPOZcGgOD+0OzBYrQclljzxa3ErxTQ1
         bWQ4DikdC/k49knkJ6/9wRJu58YiUSZjPqeuEkt2fc8bCWaeVjgOzCOdqZMz9rYGTK89
         CcHKml8Yymtm3AbwdVjsOwylbyXVHAgsVsZSieKSe7jYlSa23PjnJ1RW5E57jSHyz33u
         RnBk7r0AJxzlAurQY+SP+GmHBpVkdZoa2+7r7GbXzQlXqyQX5CMxV9azFoZeeIFzk0We
         Yx6ZNJma4N/+Vnea60hsYZGi5bnBsPSOBsMe82KZCWL7lI8nAIVRCBRMnuoVK8sXTTd1
         2uMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724923345; x=1725528145;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RSl2ovaivwnTSTlfxzsVM7kAV63t3rvKKAijhEcDkl4=;
        b=t8fan/h6pv667U2sNz0I8ftVGKpeO3WIiVnIWknS/k9qiHrtMSIv5QoQFRzHeHmXjU
         AEPs2YBYCk9jdSPpl/MqAstPMXl9aeQHABMVn1OzuCNCBqpBAYUaiIwACabe2yvMCags
         co+2IWYveapzScP3hRiCONG3ubpLrIvRhb33DBfdybUg+v10RRdn8jDNOS4yfd8IgPkc
         5vbzw90afelA6O/V2/fzWR/cI6dohABLYrU2KEcT9KG5gXci+tSIXhCLZESmf0lXX6DA
         FBzHZ33UPZbntGl2vxeykMTt8jACOIolcaogjiR8cRZH2m0V9km192doeK/YT7lq9+th
         ntDQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4rrXVrTqH93G1ZpSRcNGo9Ogdjf4lg+7EldvhFtR3wBx5kVmZ37hsOSBoY5IUiolKvMaMkG7KRqh8@vger.kernel.org, AJvYcCVFM28rtdTqgZAix0I/kdPid/7ltPw8vtguVfsjjAhlL9Urw82YUf92vD7mTTEiAYO7cwDnqAyEL6PDNG0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnXxSTQr4u6QcfF8EgGhOD4gHc6KmH5I8DxKdeQeLlL2Wdk6pK
	u/uGrF79ZIp/ke5MaXYgo6bPwB3uvNGsqUfJ1R7zic3UXuuag9D+RmAzE8nRDsRrG0scK3R7nus
	hqJ9ReabzAMrrgu2hbBQ0LUH9syg=
X-Google-Smtp-Source: AGHT+IF7Us3zYBzirqlMO/EDflk6MgIBFZc3g3tzDRZIzDRI8J0kwiJ1SoG6KcjJsB9d7PmiI8L2NJgAlh6NJiaBsQs=
X-Received: by 2002:a05:6122:a08:b0:4f5:28e3:5a5a with SMTP id
 71dfb90a1353d-4ffe4a7bfabmr2353262e0c.4.1724923344880; Thu, 29 Aug 2024
 02:22:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240802102229.10204-1-victorshihgli@gmail.com>
 <20240802102229.10204-23-victorshihgli@gmail.com> <7b68185d-6847-4482-b1c2-403bf5fa78d5@intel.com>
In-Reply-To: <7b68185d-6847-4482-b1c2-403bf5fa78d5@intel.com>
From: Victor Shih <victorshihgli@gmail.com>
Date: Thu, 29 Aug 2024 17:22:05 +0800
Message-ID: <CAK00qKDMZQkwFq3Eovmzht1cGNQm_S954tEm2xOo6P2aj6Anxg@mail.gmail.com>
Subject: Re: [PATCH V18 22/22] mmc: sdhci-pci-gli: enable UHS-II mode for GL9767
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, benchuanggli@gmail.com, 
	Lucas.Lai@genesyslogic.com.tw, HL.Liu@genesyslogic.com.tw, 
	Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org, dlunev@chromium.org, 
	Ben Chuang <ben.chuang@genesyslogic.com.tw>, 
	Victor Shih <victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2024 at 8:41=E2=80=AFPM Adrian Hunter <adrian.hunter@intel.=
com> wrote:
>
> On 2/08/24 13:22, Victor Shih wrote:
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
> > Updates in V18:
> >  - Add new register settings for gl9767.
> >  - Add card_event in the sdhci_ops for gl9767.
> >  - Add sdhci_gl9767_set_card_detect_debounce_time()
> >    to configure the gl9767.
> >  - Adjust the sdhci_gl9767_reset() process for gl9767.
> >
> > Updates in V17:
> >  - Use mmc_card_uhs2() to simplify the code in the sdhci_gl9767_reset()=
.
> >  - Use mmc_card_uhs2() to simplify the code in the
> >    sdhci_gl9767_set_power().
> >  - Add sdhci_gli_overcurrent_event_enable() to sdhci_gl9767_set_power()=
.
> >
> > Updates in V15:
> >  - Add gl9767 to support uhs2 function.
> >
> > ---
> >
> >  drivers/mmc/host/sdhci-pci-gli.c | 214 ++++++++++++++++++++++++++++++-
> >  1 file changed, 212 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-=
pci-gli.c
> > index a4164948de81..26f7cf4cb109 100644
> > --- a/drivers/mmc/host/sdhci-pci-gli.c
> > +++ b/drivers/mmc/host/sdhci-pci-gli.c
> > @@ -174,6 +174,15 @@
> >  #define PCI_GLI_9755_MISC        0x78
> >  #define   PCI_GLI_9755_MISC_SSC_OFF    BIT(26)
> >
> > +#define SDHCI_GLI_9767_SD_HOST_OPERATION_CTL                         0=
x508
> > +#define   SDHCI_GLI_9767_SD_HOST_OPERATION_CTL_CMD_CONFLICT_CHECK     =
 BIT(0)
> > +#define   SDHCI_GLI_9767_SD_HOST_OPERATION_CTL_DEBOUNCE               =
         GENMASK(21, 16)
> > +#define   SDHCI_GLI_9767_SD_HOST_OPERATION_CTL_DEBOUNCE_PLUG_IN_VALUE =
         0x05
> > +#define   SDHCI_GLI_9767_SD_HOST_OPERATION_CTL_DEBOUNCE_PLUG_OUT_VALUE=
         0x3F
> > +#define   SDHCI_GLI_9767_SD_HOST_OPERATION_CTL_DEBOUNCE_SCALE         =
         GENMASK(23, 22)
> > +#define   SDHCI_GLI_9767_SD_HOST_OPERATION_CTL_DEBOUNCE_SCALE_1MS     =
 0x2
> > +#define   SDHCI_GLI_9767_SD_HOST_OPERATION_CTL_DEBOUNCE_SCALE_10MS    =
 0x3
> > +
> >  #define SDHCI_GLI_9767_GM_BURST_SIZE                 0x510
> >  #define   SDHCI_GLI_9767_GM_BURST_SIZE_AXI_ALWAYS_SET          BIT(8)
> >
> > @@ -210,6 +219,13 @@
> >  #define   PCIE_GLI_9767_SCR_CORE_PWR_D3_OFF            BIT(21)
> >  #define   PCIE_GLI_9767_SCR_CFG_RST_DATA_LINK_DOWN     BIT(30)
> >
> > +#define PCIE_GLI_9767_RESET_REG                              0x8E4
> > +#define   PCIE_GLI_9767_RESET_REG_SD_HOST_SW_RESET     BIT(0)
> > +
> > +#define PCIE_GLI_9767_UHS2_PHY_SET_REG1                              0=
x90C
> > +#define   PCIE_GLI_9767_UHS2_PHY_SET_REG1_SERDES_INTR                 =
 GENMASK(31, 29)
> > +#define   PCIE_GLI_9767_UHS2_PHY_SET_REG1_SERDES_INTR_VALUE    0x3
> > +
> >  #define PCIE_GLI_9767_SDHC_CAP                       0x91C
> >  #define   PCIE_GLI_9767_SDHC_CAP_SDEI_RESULT   BIT(5)
> >
> > @@ -228,9 +244,15 @@
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
> > @@ -240,6 +262,28 @@
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
> > +#define   PCIE_GLI_9767_UHS2_CTL1_DIR_TRANS_VALUE      0x0
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
> > @@ -1152,6 +1196,31 @@ static void sdhci_gl9767_set_clock(struct sdhci_=
host *host, unsigned int clock)
> >       gl9767_vhs_read(pdev);
> >  }
> >
> > +static void sdhci_gl9767_set_card_detect_debounce_time(struct sdhci_ho=
st *host)
> > +{
> > +     u32 value;
> > +
> > +     value =3D sdhci_readl(host, SDHCI_GLI_9767_SD_HOST_OPERATION_CTL)=
;
> > +     value &=3D ~(SDHCI_GLI_9767_SD_HOST_OPERATION_CTL_DEBOUNCE |
> > +                SDHCI_GLI_9767_SD_HOST_OPERATION_CTL_DEBOUNCE_SCALE);
> > +     if (host->mmc->ops->get_cd(host->mmc))
>
> This is OK from the ->card_event() path but not from others like:
>
> sdhci_gl9767_reset() -> gli_set_9767() -> sdhci_gl9767_set_card_detect_de=
bounce_time()
>         o Reset can be called in atomic context (under spin lock), but
>         host->mmc->ops->get_cd() can be reading a card detect GPIO which
>         might sleep.
>
> gli_probe_slot_gl9767() -> gli_set_9767() -> sdhci_gl9767_set_card_detect=
_debounce_time()
>         o gli_probe_slot_gl9767() gets called before card detect GPIO
>         is set up in sdhci-pci-core.c
>
> However, presumably you are always using SDHCI_PRESENT_STATE register
> for card detect (hence the debounce settings on the controller), so
> it would be better to just read SDHCI_PRESENT_STATE here.
>

Hi, Adrian

I will correct this issue in the next version.

Thanks, Victor Shih

> > +             value |=3D FIELD_PREP(SDHCI_GLI_9767_SD_HOST_OPERATION_CT=
L_DEBOUNCE,
> > +                                 SDHCI_GLI_9767_SD_HOST_OPERATION_CTL_=
DEBOUNCE_PLUG_IN_VALUE) |
> > +                      FIELD_PREP(SDHCI_GLI_9767_SD_HOST_OPERATION_CTL_=
DEBOUNCE_SCALE,
> > +                                 SDHCI_GLI_9767_SD_HOST_OPERATION_CTL_=
DEBOUNCE_SCALE_1MS);
> > +     else
> > +             value |=3D FIELD_PREP(SDHCI_GLI_9767_SD_HOST_OPERATION_CT=
L_DEBOUNCE,
> > +                                 SDHCI_GLI_9767_SD_HOST_OPERATION_CTL_=
DEBOUNCE_PLUG_OUT_VALUE) |
> > +                      FIELD_PREP(SDHCI_GLI_9767_SD_HOST_OPERATION_CTL_=
DEBOUNCE_SCALE,
> > +                                 SDHCI_GLI_9767_SD_HOST_OPERATION_CTL_=
DEBOUNCE_SCALE_10MS);
> > +     sdhci_writel(host, value, SDHCI_GLI_9767_SD_HOST_OPERATION_CTL);
> > +}
> > +
> > +static void sdhci_gl9767_card_event(struct sdhci_host *host)
> > +{
> > +     sdhci_gl9767_set_card_detect_debounce_time(host);
> > +}
> > +
> >  static void gli_set_9767(struct sdhci_host *host)
> >  {
> >       u32 value;
> > @@ -1159,6 +1228,12 @@ static void gli_set_9767(struct sdhci_host *host=
)
> >       value =3D sdhci_readl(host, SDHCI_GLI_9767_GM_BURST_SIZE);
> >       value &=3D ~SDHCI_GLI_9767_GM_BURST_SIZE_AXI_ALWAYS_SET;
> >       sdhci_writel(host, value, SDHCI_GLI_9767_GM_BURST_SIZE);
> > +
> > +     value =3D sdhci_readl(host, SDHCI_GLI_9767_SD_HOST_OPERATION_CTL)=
;
> > +     value &=3D ~SDHCI_GLI_9767_SD_HOST_OPERATION_CTL_CMD_CONFLICT_CHE=
CK;
> > +     sdhci_writel(host, value, SDHCI_GLI_9767_SD_HOST_OPERATION_CTL);
> > +
> > +     sdhci_gl9767_set_card_detect_debounce_time(host);
> >  }
> >
> >  static void gl9767_hw_setting(struct sdhci_pci_slot *slot)
> > @@ -1197,8 +1272,54 @@ static void gl9767_hw_setting(struct sdhci_pci_s=
lot *slot)
> >
> >  static void sdhci_gl9767_reset(struct sdhci_host *host, u8 mask)
> >  {
> > -     sdhci_reset(host, mask);
> > -     gli_set_9767(host);
> > +     struct sdhci_pci_slot *slot =3D sdhci_priv(host);
> > +     struct pci_dev *pdev =3D slot->chip->pdev;
> > +     u32 value;
> > +     u16 clk_ctrl;
> > +     u16 ctrl2;
> > +
> > +     /* need internal clock */
> > +     if (mask & SDHCI_RESET_ALL) {
> > +             ctrl2 =3D sdhci_readw(host, SDHCI_HOST_CONTROL2);
> > +             clk_ctrl =3D sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> > +
> > +             if ((ctrl2 & SDHCI_CTRL_V4_MODE) && (ctrl2 & SDHCI_CTRL_U=
HS2_ENABLE)) {
> > +                     sdhci_writew(host, SDHCI_CLOCK_INT_EN, SDHCI_CLOC=
K_CONTROL);
> > +             } else {
> > +                     sdhci_writew(host, SDHCI_CLOCK_INT_EN, SDHCI_CLOC=
K_CONTROL);
> > +                     sdhci_wait_clock_stable(host);
> > +                     sdhci_writew(host, SDHCI_CTRL_V4_MODE, SDHCI_HOST=
_CONTROL2);
> > +             }
>
> Same code is in sdhci_gl9755_reset(), so could factor it out into
> a separate function.
>

Hi, Adrian

I will correct this issue in the next version.

Thanks, Victor Shih

> > +
> > +             gl9767_vhs_write(pdev);
> > +
> > +             pci_read_config_dword(pdev, PCIE_GLI_9767_RESET_REG, &val=
ue);
> > +             value &=3D ~PCIE_GLI_9767_RESET_REG_SD_HOST_SW_RESET;
> > +             pci_write_config_dword(pdev, PCIE_GLI_9767_RESET_REG, val=
ue);
> > +
> > +             if (read_poll_timeout_atomic(pci_read_config_dword, value=
,
> > +                                          !(value & PCIE_GLI_9767_RESE=
T_REG_SD_HOST_SW_RESET),
> > +                                          1, 5, true, pdev, PCIE_GLI_9=
767_RESET_REG, &value)) {
> > +                     pr_warn("%s: %s: Reset SDHC AHB and TL-AMBA failu=
re.\n",
> > +                             __func__, mmc_hostname(host->mmc));
> > +                     return;
> > +             }
> > +
> > +             gl9767_vhs_read(pdev);
> > +     }
> > +
> > +     if (mmc_card_uhs2(host->mmc)) {
> > +             if (mask & (SDHCI_RESET_CMD | SDHCI_RESET_DATA)) {
> > +                     sdhci_writeb(host, mask, SDHCI_SOFTWARE_RESET);
>
> Don't you need to wait for that reset at some point?
>

Hi, Adrian

I will correct this issue in the next version.

Thanks, Victor Shih

> > +                     sdhci_gli_uhs2_reset_sd_tran(host);
> > +             } else {
> > +                     sdhci_uhs2_reset(host, mask);
> > +             }
> > +             gli_set_9767(host);
> > +     } else {
> > +             sdhci_reset(host, mask);
> > +             gli_set_9767(host);
> > +     }
>
> gli_set_9767() is always called, so could be moved here.
>

Hi, Adrian

I will correct this issue in the next version.

Thanks, Victor Shih

> >  }
> >
> >  static int gl9767_init_sd_express(struct mmc_host *mmc, struct mmc_ios=
 *ios)
> > @@ -1288,6 +1409,86 @@ static int gl9767_init_sd_express(struct mmc_hos=
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
> > +     struct pci_dev *pdev =3D slot->chip->pdev;
> > +     u32 value;
> > +
> > +     if (mmc_card_uhs2(host->mmc)) {
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
> > +             sdhci_gli_overcurrent_event_enable(host, false);
> > +             sdhci_uhs2_set_power(host, mode, vdd);
> > +             sdhci_gli_overcurrent_event_enable(host, true);
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
> > +             sdhci_gli_overcurrent_event_enable(host, false);
> > +             sdhci_set_power(host, mode, vdd);
> > +             sdhci_gli_overcurrent_event_enable(host, true);
> > +     }
> > +}
> > +
> >  static int gli_probe_slot_gl9750(struct sdhci_pci_slot *slot)
> >  {
> >       struct sdhci_host *host =3D slot->host;
> > @@ -1324,6 +1525,7 @@ static int gli_probe_slot_gl9767(struct sdhci_pci=
_slot *slot)
> >       host->mmc->caps2 |=3D MMC_CAP2_SD_EXP;
> >       host->mmc_host_ops.init_sd_express =3D gl9767_init_sd_express;
> >       sdhci_enable_v4_mode(host);
> > +     gl9767_vendor_init(host);
> >
> >       return 0;
> >  }
> > @@ -1827,12 +2029,20 @@ static const struct sdhci_ops sdhci_gl9767_ops =
=3D {
> >       .reset                   =3D sdhci_gl9767_reset,
> >       .set_uhs_signaling       =3D sdhci_set_uhs_signaling,
> >       .voltage_switch          =3D sdhci_gl9767_voltage_switch,
> > +     .dump_uhs2_regs          =3D sdhci_uhs2_dump_regs,
> > +     .set_timeout             =3D sdhci_uhs2_set_timeout,
> > +     .irq                     =3D sdhci_uhs2_irq,
> > +     .set_power               =3D sdhci_gl9767_set_power,
> > +     .uhs2_pre_detect_init    =3D sdhci_gli_pre_detect_init,
> > +     .card_event              =3D sdhci_gl9767_card_event,
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
>
