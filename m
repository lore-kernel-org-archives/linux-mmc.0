Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCB0198E6C;
	Thu,  5 Sep 2024 10:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725531299; cv=none; b=TqB3GnWvaz6aqzD4sBZHx7eHBZ0UZnjBkc9NhnWqXg+o6cAdQYfb2nMs9B46t9xW+YhGB9/WDQN1qhbVIn7SmI0xz4tmMQxf4U3fvGNyM90F+u+onSo1JL4tJpVLI0RQ6kPz+RjgmPbB6af1P9fNmEDm2hsFTs4AD/q/OKh2Dkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725531299; c=relaxed/simple;
	bh=SrMfMao/Yjl1KV3kG9K/c3FlicY977tcSWMYwUZHJmU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s3LjgNl72upHVsxwqgUtUVyaEL9F3SezWyTO32+ytAS/UYqZlYZkHRXvMFqkL4XXpqUoCExoAEGSee71814h5Jxlhu3t1oYh3ycuWdoL4/rBqUniguTGH3YXR7wNPfTgXlQIxbZifbCn1W8xkgYcXrvFaKLSJWtKBO2lDT7M/ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HTME4Swy; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HTME4Swy"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-4fce6fd54ebso293516e0c.1;
        Thu, 05 Sep 2024 03:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725531296; x=1726136096; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eq2aBSpD3b/xdKdPdBpuH/biOImvtyOHot3P+D/0E7c=;
        b=HTME4Swy8nkKap4TrTHnoLL/XODODHGQztynFz6AWq/NEhjBWMOWlYc52XTQkXtue3
         pjIYYMGwEt/sYpjupCUGZ7W8dU503InWQ7oJjR20gZZ14fmtXUq0GyuPlueGqeOGOMM0
         UPCwFZEXkLBbZRSxIBHpWfbXKBxz9/EKsU+l9KA20HxgVZbseMNcDT4K4e+CtZB746sQ
         97rM1bdo/yGCUnxm+xaJtvALm1GVozcDtO0iU1ZPMplLZo3+CuA0DXMGjgPoHRRvYcS4
         XBP2rJTaAiGT02TC+DXZZg3G06aRShEIh06lOGqNLORvUP4ex5G0aOCz9r2tCN9SPzMQ
         1LLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725531296; x=1726136096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eq2aBSpD3b/xdKdPdBpuH/biOImvtyOHot3P+D/0E7c=;
        b=keCR3I8F8youjCpUXr1kp96VxxADeB4c2vEyTxEO9DUCRM/PcOGemLay4DBL1tbBqA
         ZpTcxrYrdG+nPabhaP7nWj9sSRCo1+ni+c4lNBjPyc0s15EDOUwZyiJv0aj7JAMdXAdF
         OspeHivvcRTmor5d0HgmNqoh1cPEK3xFBCOhZQ1oZfphDCRLUgh7U5P2bEloPMqcdE4Q
         jUUYKk8ztEBIE3oQ09BZQBPz4TP7NjXI+aixnzm9Zhjn31KkQ8QAxFYPCeTbHkzcqfEr
         KbSPIaz9o4mw1cB5dHBjaEO28TROSv3bQOSydVs3agix/DbRBD7xbm9xMXwKP6jFeKV+
         fReA==
X-Forwarded-Encrypted: i=1; AJvYcCU1qh7oZv2IjqauVGo3nQr7nYm/LAj4PogoEBoPzpDKhlJzlyZGTx60coLy4fociyEUFZmNa4f81O1W@vger.kernel.org, AJvYcCXq8SGbbOxuDFsYqw7IO/2lXtMPkHeSlx4k5kX6We4DLtnbvFoUk6yJKa9LSlUdOhfmyOVJRLnA/KjZpUY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiG/e6naXRe2cEH+7VsJaGmeh3BvtAIB54oa/kKexGX5jaiMHq
	ebDwAMW55mvDzdXlN7bHJ2ABmNKAOZAfVxMvqdAuSi9JK6npbI42yV8Vmg14FthhrFzCWeD0r+o
	3gNCXPWk4Bv129+hCRxZoiTEc3MA=
X-Google-Smtp-Source: AGHT+IErN8K5ihGQ/4b+bByVqSIqr4IFl3xgsF+8yyGl7kzsiyHatDkI//MMwoKNNYWd+lpi4rJe+TbI91yXg5+1oEU=
X-Received: by 2002:a05:6122:4888:b0:501:2556:1cd9 with SMTP id
 71dfb90a1353d-50125561fa7mr165680e0c.10.1725531296162; Thu, 05 Sep 2024
 03:14:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829101539.5058-1-victorshihgli@gmail.com>
 <20240829101539.5058-23-victorshihgli@gmail.com> <095aa301-aba8-465b-9306-11096ea804b9@intel.com>
In-Reply-To: <095aa301-aba8-465b-9306-11096ea804b9@intel.com>
From: Victor Shih <victorshihgli@gmail.com>
Date: Thu, 5 Sep 2024 18:14:44 +0800
Message-ID: <CAK00qKB3qbPKsBbghC1N15kxvOjwY99BvPixvHD8O2ww9Fa9ig@mail.gmail.com>
Subject: Re: [PATCH V19 22/22] mmc: sdhci-pci-gli: enable UHS-II mode for GL9767
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, benchuanggli@gmail.com, 
	Lucas.Lai@genesyslogic.com.tw, HL.Liu@genesyslogic.com.tw, 
	Greg.tu@genesyslogic.com.tw, dlunev@chromium.org, 
	Ben Chuang <ben.chuang@genesyslogic.com.tw>, 
	Victor Shih <victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 3, 2024 at 2:40=E2=80=AFAM Adrian Hunter <adrian.hunter@intel.c=
om> wrote:
>
> On 29/08/24 13:15, Victor Shih wrote:
> > From: Victor Shih <victor.shih@genesyslogic.com.tw>
> >
> > Changes are:
> >  * Enable the internal clock when do reset on UHS-II mode.
> >  * Increase timeout value before detecting UHS-II interface.
> >  * Add vendor settings for UHS-II mode.
> >
> > Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> > Signed-off-by: Lucas Lai <lucas.lai@genesyslogic.com.tw>
> > ---
> >
> > Updates in V19:
> >  - Use sdhci_gli_enable_internal_clock() to simplify the code
> >    in the sdhci_gl9767_reset().
> >  - Directly reading the SDHCI_PRESENT_STATE register to replace
> >    the get_cd() avoids the possibility of the get_cd() sleeping
> >    in the sdhci_gl9767_set_card_detect_debounce_time().
> >  - Refine the position of gli_set_9767() in the sdhci_gl9767_reset().
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
> >  drivers/mmc/host/sdhci-pci-gli.c | 211 ++++++++++++++++++++++++++++++-
> >  1 file changed, 210 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-=
pci-gli.c
> > index e826e02a0d52..2375a810c2b8 100644
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
> > @@ -1150,6 +1194,31 @@ static void sdhci_gl9767_set_clock(struct sdhci_=
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
> > +     if (sdhci_readl(host, SDHCI_PRESENT_STATE) & SDHCI_CARD_PRESENT)
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
> > @@ -1157,6 +1226,12 @@ static void gli_set_9767(struct sdhci_host *host=
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
> > @@ -1195,7 +1270,52 @@ static void gl9767_hw_setting(struct sdhci_pci_s=
lot *slot)
> >
> >  static void sdhci_gl9767_reset(struct sdhci_host *host, u8 mask)
> >  {
> > -     sdhci_reset(host, mask);
> > +     struct sdhci_pci_slot *slot =3D sdhci_priv(host);
> > +     struct pci_dev *pdev =3D slot->chip->pdev;
> > +     u32 value;
> > +     u8 rst;
> > +
> > +     /* need internal clock */
> > +     if (mask & SDHCI_RESET_ALL) {
> > +             sdhci_gli_enable_internal_clock(host);
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
> > +                     gl9767_vhs_read(pdev);
> > +                     return;
> > +             }
> > +             gl9767_vhs_read(pdev);
> > +     }
> > +
> > +     if (mmc_card_uhs2(host->mmc)) {
> > +             if (mask & (SDHCI_RESET_CMD | SDHCI_RESET_DATA)) {
> > +                     sdhci_writeb(host, mask, SDHCI_SOFTWARE_RESET);
> > +                     sdhci_gli_uhs2_reset_sd_tran(host);
> > +                     if (read_poll_timeout_atomic(sdhci_readb, rst, !(=
rst & mask), 10, 100000,
> > +                                                  false, host, SDHCI_S=
OFTWARE_RESET)) {
> > +                             pr_err("%s: Reset 0x%x never completed.\n=
",
> > +                                    mmc_hostname(host->mmc), (int)mask=
);
> > +                             sdhci_dumpregs(host);
> > +                             /* manual clear */
> > +                             sdhci_writeb(host, 0, SDHCI_SOFTWARE_RESE=
T);
> > +                             return;
> > +                     }
>
> Same code in sdhci_gl9755_reset().  Might as well make it a separate
> function so it can be shared.
>

Hi, Adrian

I will update this in the next version.

Thanks, Victor Shih

> > +             } else {
> > +                     sdhci_uhs2_reset(host, mask);
> > +             }
> > +     } else {
> > +             sdhci_reset(host, mask);
> > +     }
> > +
> >       gli_set_9767(host);
> >  }
> >
> > @@ -1286,6 +1406,86 @@ static int gl9767_init_sd_express(struct mmc_hos=
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
> > @@ -1322,6 +1522,7 @@ static int gli_probe_slot_gl9767(struct sdhci_pci=
_slot *slot)
> >       host->mmc->caps2 |=3D MMC_CAP2_SD_EXP;
> >       host->mmc_host_ops.init_sd_express =3D gl9767_init_sd_express;
> >       sdhci_enable_v4_mode(host);
> > +     gl9767_vendor_init(host);
> >
> >       return 0;
> >  }
> > @@ -1825,12 +2026,20 @@ static const struct sdhci_ops sdhci_gl9767_ops =
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
