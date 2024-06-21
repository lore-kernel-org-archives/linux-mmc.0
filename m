Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929333EA6C;
	Fri, 21 Jun 2024 01:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718934609; cv=none; b=sv+ek3Shopoz/6LnE8y67NNFPZP15HaRb30ww4KlP3sWB0e1w6cHXFKwni92QA6J/5OxwihRIQzq/noiNLZmoKevAVqUzRojiTIJ2RyN9SZaK5d0Ja435NQ2khE9It1VzMyg4C0XofaU5wwdpzCC72Zm3FZnFys3qRnh0grJZ2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718934609; c=relaxed/simple;
	bh=po76r3KYyy1RfKlwuCH3suQv0JZgZA/wrSZoQGyi3tE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IK+3SfaCxu78oqozH7au6XdcKhMiyAvRNvXxaAXMIKShF+WUccVM33uptChGuBY6O9fTvgAQ/dfqsKLgv1+doxCNbgG/6fZQzuAuIL4T580DUFxsRRqf3m/TAgiY+2fohno0tJcDH4McHIyWoBHn/bnrXSKeSGzdkLMK1F7cogI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bOxOY8WO; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bOxOY8WO"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a6f7b785a01so152827166b.1;
        Thu, 20 Jun 2024 18:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718934604; x=1719539404; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/3Fa/DcfbTEjl+B1uq/Ob35NLfRLpvSwMg2zwgjGtIs=;
        b=bOxOY8WO+cJ5yBRmfp8o/cNEiIboqZxHTuQivwbZ4DDjtylaV2R/YCJB8IDKInfGob
         z595RYlDxcs1ogFQ9FSxiJ23U8hajPf0xvFuk58YvoWUZ4RfUbwWMQu8SbOb7maPABYn
         4SHGocfxXI7I8YuWJdyxMHTFsNURoWvB8+vN2pyEtNg0CX/6SNFv9tZglCFiuUjaiOQP
         N1gpvD/bWLIxzVb46Yf+gXNhmJqapFu7OtytDms109/XeaRIY+MUJ45EUv/mvZ0SBVe9
         krkY8LyhGWGd/DAfZnwqVCjiYNBL31+DEwKG2S4MFPWCYr9fLnoEKbdYI+hhwDd0aHbl
         wGbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718934604; x=1719539404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/3Fa/DcfbTEjl+B1uq/Ob35NLfRLpvSwMg2zwgjGtIs=;
        b=KGyCml3DQlN745KJK1zkFAHWrIl3KwkiaYdhcvd+S65nvVMuRcQLJl59/u4DKQfHKg
         S6TSBvM9yaZ90aTYlD0fyT9JZxoDtyhS9wwGkTREd9fKXtXizxX0eiZMDapei11YWyrz
         sHpoBKK7K3HEaWDyFrdbTQbYP6sgXHqyMfHwkNk+hJIr3V+i8EtD3oupNcT0kPANed78
         GP3UIFJNRMUcNwRHaWTbcKyLFy4cg4yF2qpOsiFCTnXaQX/4Ecqd/zUGKyNzNihnk8Nb
         4Pbzs8lnxqo3gkurDEce1m8ZE71UH5gaki8lbjaPoF1+KJ0wnUnT/Y3KBRk8hvafbqmw
         u0kw==
X-Forwarded-Encrypted: i=1; AJvYcCVuC1ostWWLQOqmofXcMJ2oIECG5C2fQWm8WnKAHMY/p0srwKpRs07Dv5ui91GlTgDPoxTMQrQTiOk0eHQMbvkE7QelRExK7n3YNqGQ/tWNHIiGNiHmCKOmvwb/pnCrSF/2bBy103FP
X-Gm-Message-State: AOJu0YxBdrA/okvkRv4nD+EL2TeXMRxkUcA1IT6Lnv2IqPYc2Z5zCEJv
	lA4g5c81mp2VgUVOH8BhI1AiqIqMmK7llG0gWugMKUjzEWrZsI2NA39KQxWWZQ2SwtR/5Iib4xD
	KdjJiQOuwnHkL2A1zFche38Qbhh8=
X-Google-Smtp-Source: AGHT+IGr7JPsPEBOe+OOfAy4tfNLNJOtqWni1JL+hIWuIqf191at0kJMq/cjydeZChhj/ctobdGpxyAbOyskjA0K40E=
X-Received: by 2002:a17:907:6b8e:b0:a6f:33d6:2d45 with SMTP id
 a640c23a62f3a-a6fab7717d8mr475474366b.60.1718934603211; Thu, 20 Jun 2024
 18:50:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240620104444.5862-1-victorshihgli@gmail.com> <20240620104444.5862-23-victorshihgli@gmail.com>
In-Reply-To: <20240620104444.5862-23-victorshihgli@gmail.com>
From: Ben Chuang <benchuanggli@gmail.com>
Date: Fri, 21 Jun 2024 09:49:49 +0800
Message-ID: <CACT4zj9Nfd=W9ntQX4dDWzZJRFbP+vve9=BkaRjtmZY7752qfA@mail.gmail.com>
Subject: Re: [PATCH V17 22/22] mmc: sdhci-pci-gli: enable UHS-II mode for GL9767
To: Victor Shih <victorshihgli@gmail.com>
Cc: ulf.hansson@linaro.org, adrian.hunter@intel.com, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, HL.Liu@genesyslogic.com.tw, 
	Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org, dlunev@chromium.org, 
	Ben Chuang <ben.chuang@genesyslogic.com.tw>, 
	Victor Shih <victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Victor,

On Thu, Jun 20, 2024 at 6:46=E2=80=AFPM Victor Shih <victorshihgli@gmail.co=
m> wrote:
>
> From: Victor Shih <victor.shih@genesyslogic.com.tw>
>
> Changes are:
>  * Enable the internal clock when do reset on UHS-II mode.
>  * Increase timeout value before detecting UHS-II interface.
>  * Add vendor settings for UHS-II mode.
>
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> ---
>
> Updates in V17:
>  - Use mmc_card_uhs2() to simplify the code in the sdhci_gl9767_reset().
>  - Use mmc_card_uhs2() to simplify the code in the
>    sdhci_gl9767_set_power().
>  - Add sdhci_gli_overcurrent_event_enable() to sdhci_gl9767_set_power().
>
> Updates in V15:
>  - Add gl9767 to support uhs2 function.
>
> ---
>
>  drivers/mmc/host/sdhci-pci-gli.c | 150 ++++++++++++++++++++++++++++++-
>  1 file changed, 148 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pc=
i-gli.c
> index a4164948de81..37c63c45bdc9 100644
> --- a/drivers/mmc/host/sdhci-pci-gli.c
> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> @@ -210,6 +210,10 @@
>  #define   PCIE_GLI_9767_SCR_CORE_PWR_D3_OFF              BIT(21)
>  #define   PCIE_GLI_9767_SCR_CFG_RST_DATA_LINK_DOWN       BIT(30)
>
> +#define PCIE_GLI_9767_UHS2_PHY_SET_REG1                                0=
x90C
> +#define   PCIE_GLI_9767_UHS2_PHY_SET_REG1_SERDES_INTR            GENMASK=
(31, 29)
> +#define   PCIE_GLI_9767_UHS2_PHY_SET_REG1_SERDES_INTR_VALUE      0x3
> +
>  #define PCIE_GLI_9767_SDHC_CAP                 0x91C
>  #define   PCIE_GLI_9767_SDHC_CAP_SDEI_RESULT     BIT(5)
>
> @@ -228,9 +232,15 @@
>  #define   PCIE_GLI_9767_SD_EXPRESS_CTL_SD_EXPRESS_MODE   BIT(1)
>
>  #define PCIE_GLI_9767_SD_DATA_MULTI_CTL                                0=
x944
> +#define   PCIE_GLI_9767_SD_DATA_MULTI_CTL_SELECT_UHS2            BIT(5)
> +#define   PCIE_GLI_9767_SD_DATA_MULTI_CTL_UHS2_SWITCH_CTL        BIT(8)
>  #define   PCIE_GLI_9767_SD_DATA_MULTI_CTL_DISCONNECT_TIME        GENMASK=
(23, 16)
>  #define   PCIE_GLI_9767_SD_DATA_MULTI_CTL_DISCONNECT_TIME_VALUE         =
 0x64
>
> +#define PCIE_GLI_9767_UHS2_PHY_SET_REG2                                 =
       0x948
> +#define   PCIE_GLI_9767_UHS2_PHY_SET_REG2_SSC_PPM_SETTING               =
 GENMASK(22, 21)
> +#define   PCIE_GLI_9767_UHS2_PHY_SET_REG2_SSC_PPM_SETTING_VALUE         =
         0x0
> +
>  #define PCIE_GLI_9767_NORMAL_ERR_INT_STATUS_REG2                       0=
x950
>  #define   PCIE_GLI_9767_NORMAL_ERR_INT_STATUS_REG2_SDEI_COMPLETE        =
 BIT(0)
>
> @@ -240,6 +250,28 @@
>  #define PCIE_GLI_9767_NORMAL_ERR_INT_SIGNAL_EN_REG2                     =
       0x958
>  #define   PCIE_GLI_9767_NORMAL_ERR_INT_SIGNAL_EN_REG2_SDEI_COMPLETE_SIGN=
AL_EN    BIT(0)
>
> +#define PCIE_GLI_9767_UHS2_CTL1                                0x95C
> +#define   PCIE_GLI_9767_UHS2_CTL1_TRANS_PASS             BIT(5)
> +#define   PCIE_GLI_9767_UHS2_CTL1_TRANS_PASS_VALUE       0x1
> +#define   PCIE_GLI_9767_UHS2_CTL1_DECODING_CTL           BIT(6)
> +#define   PCIE_GLI_9767_UHS2_CTL1_DECODING_CTL_VALUE     0x1
> +#define   PCIE_GLI_9767_UHS2_CTL1_SERDES_TRAN            GENMASK(10, 7)
> +#define   PCIE_GLI_9767_UHS2_CTL1_SERDES_TRAN_VALUE      0x3
> +#define   PCIE_GLI_9767_UHS2_CTL1_SERDES_RECV            GENMASK(14, 11)
> +#define   PCIE_GLI_9767_UHS2_CTL1_SERDES_RECV_VALUE      0xf
> +#define   PCIE_GLI_9767_UHS2_CTL1_DIR_TRANS              GENMASK(16, 15)
> +#define   PCIE_GLI_9767_UHS2_CTL1_DIR_TRANS_VALUE        0x3
> +#define   PCIE_GLI_9767_UHS2_CTL1_DIR_RECV               GENMASK(18, 17)
> +#define   PCIE_GLI_9767_UHS2_CTL1_DIR_RECV_VALUE         0x0
> +#define   PCIE_GLI_9767_UHS2_CTL1_PDRST                          BIT(25)
> +#define   PCIE_GLI_9767_UHS2_CTL1_PDRST_VALUE            0x1
> +
> +#define PCIE_GLI_9767_UHS2_CTL2                        0x964
> +#define   PCIE_GLI_9767_UHS2_CTL2_ZC             GENMASK(3, 0)
> +#define   PCIE_GLI_9767_UHS2_CTL2_ZC_VALUE       0xb
> +#define   PCIE_GLI_9767_UHS2_CTL2_ZC_CTL         BIT(6)
> +#define   PCIE_GLI_9767_UHS2_CTL2_ZC_CTL_VALUE   0x1
> +
>  #define GLI_MAX_TUNING_LOOP 40
>
>  /* Genesys Logic chipset */
> @@ -1197,8 +1229,32 @@ static void gl9767_hw_setting(struct sdhci_pci_slo=
t *slot)
>
>  static void sdhci_gl9767_reset(struct sdhci_host *host, u8 mask)
>  {
> -       sdhci_reset(host, mask);
> -       gli_set_9767(host);
> +       u16 clk_ctrl;
> +       u16 ctrl2;
> +
> +       if (mmc_card_uhs2(host->mmc)) {
> +               /* need internal clock */
> +               if (mask & SDHCI_RESET_ALL) {
> +                       ctrl2 =3D sdhci_readw(host, SDHCI_HOST_CONTROL2);
> +                       clk_ctrl =3D sdhci_readw(host, SDHCI_CLOCK_CONTRO=
L);
> +
> +                       if ((ctrl2 & SDHCI_CTRL_V4_MODE) && (ctrl2 & SDHC=
I_CTRL_UHS2_ENABLE)) {
> +                               sdhci_writew(host, SDHCI_CLOCK_INT_EN, SD=
HCI_CLOCK_CONTROL);
> +                       } else {
> +                               sdhci_writew(host, SDHCI_CLOCK_INT_EN, SD=
HCI_CLOCK_CONTROL);
> +                               sdhci_wait_clock_stable(host);
> +                               sdhci_writew(host, SDHCI_CTRL_V4_MODE, SD=
HCI_HOST_CONTROL2);
> +                       }
> +               }
> +               if (mask & (SDHCI_RESET_CMD | SDHCI_RESET_DATA))

Is this your intention?
    -> if ((mask & SDHCI_RESET_CMD) |
            (mask & SDHCI_RESET_DATA))

Best regards,
Ben Chuang

> +                       sdhci_gli_uhs2_reset_sd_tran(host);
> +
> +               sdhci_uhs2_reset(host, mask);
> +               gli_set_9767(host);
> +       } else {
> +               sdhci_reset(host, mask);
> +               gli_set_9767(host);
> +       }
>  }
>
>  static int gl9767_init_sd_express(struct mmc_host *mmc, struct mmc_ios *=
ios)
> @@ -1288,6 +1344,88 @@ static int gl9767_init_sd_express(struct mmc_host =
*mmc, struct mmc_ios *ios)
>         return 0;
>  }
>
> +static void gl9767_vendor_init(struct sdhci_host *host)
> +{
> +       struct sdhci_pci_slot *slot =3D sdhci_priv(host);
> +       struct pci_dev *pdev =3D slot->chip->pdev;
> +       u32 value;
> +
> +       gl9767_vhs_write(pdev);
> +
> +       pci_read_config_dword(pdev, PCIE_GLI_9767_UHS2_PHY_SET_REG1, &val=
ue);
> +       value |=3D FIELD_PREP(PCIE_GLI_9767_UHS2_PHY_SET_REG1_SERDES_INTR=
,
> +                           PCIE_GLI_9767_UHS2_PHY_SET_REG1_SERDES_INTR_V=
ALUE);
> +       pci_write_config_dword(pdev, PCIE_GLI_9767_UHS2_PHY_SET_REG1, val=
ue);
> +
> +       pci_read_config_dword(pdev, PCIE_GLI_9767_UHS2_PHY_SET_REG2, &val=
ue);
> +       value |=3D FIELD_PREP(PCIE_GLI_9767_UHS2_PHY_SET_REG2_SSC_PPM_SET=
TING,
> +                           PCIE_GLI_9767_UHS2_PHY_SET_REG2_SSC_PPM_SETTI=
NG_VALUE);
> +       pci_write_config_dword(pdev, PCIE_GLI_9767_UHS2_PHY_SET_REG2, val=
ue);
> +
> +       pci_read_config_dword(pdev, PCIE_GLI_9767_UHS2_CTL1, &value);
> +       value |=3D FIELD_PREP(PCIE_GLI_9767_UHS2_CTL1_TRANS_PASS,
> +                           PCIE_GLI_9767_UHS2_CTL1_TRANS_PASS_VALUE) |
> +                FIELD_PREP(PCIE_GLI_9767_UHS2_CTL1_DECODING_CTL,
> +                           PCIE_GLI_9767_UHS2_CTL1_DECODING_CTL_VALUE) |
> +                FIELD_PREP(PCIE_GLI_9767_UHS2_CTL1_SERDES_TRAN,
> +                           PCIE_GLI_9767_UHS2_CTL1_SERDES_TRAN_VALUE) |
> +                FIELD_PREP(PCIE_GLI_9767_UHS2_CTL1_SERDES_RECV,
> +                           PCIE_GLI_9767_UHS2_CTL1_SERDES_RECV_VALUE) |
> +                FIELD_PREP(PCIE_GLI_9767_UHS2_CTL1_DIR_TRANS,
> +                           PCIE_GLI_9767_UHS2_CTL1_DIR_TRANS_VALUE) |
> +                FIELD_PREP(PCIE_GLI_9767_UHS2_CTL1_DIR_RECV,
> +                           PCIE_GLI_9767_UHS2_CTL1_DIR_RECV_VALUE) |
> +                FIELD_PREP(PCIE_GLI_9767_UHS2_CTL1_PDRST,
> +                           PCIE_GLI_9767_UHS2_CTL1_PDRST_VALUE);
> +       pci_write_config_dword(pdev, PCIE_GLI_9767_UHS2_CTL1, value);
> +
> +       pci_read_config_dword(pdev, PCIE_GLI_9767_UHS2_CTL2, &value);
> +       value |=3D FIELD_PREP(PCIE_GLI_9767_UHS2_CTL2_ZC,
> +                           PCIE_GLI_9767_UHS2_CTL2_ZC_VALUE) |
> +                FIELD_PREP(PCIE_GLI_9767_UHS2_CTL2_ZC_CTL,
> +                           PCIE_GLI_9767_UHS2_CTL2_ZC_CTL_VALUE);
> +       pci_write_config_dword(pdev, PCIE_GLI_9767_UHS2_CTL2, value);
> +
> +       gl9767_vhs_read(pdev);
> +}
> +
> +static void sdhci_gl9767_set_power(struct sdhci_host *host, unsigned cha=
r mode,        unsigned short vdd)
> +{
> +       struct sdhci_pci_slot *slot =3D sdhci_priv(host);
> +       struct pci_dev *pdev;
> +       u32 value;
> +
> +       pdev =3D slot->chip->pdev;
> +
> +       if (mmc_card_uhs2(host->mmc)) {
> +               gl9767_vhs_write(pdev);
> +
> +               pci_read_config_dword(pdev, PCIE_GLI_9767_SD_DATA_MULTI_C=
TL, &value);
> +               value |=3D PCIE_GLI_9767_SD_DATA_MULTI_CTL_SELECT_UHS2 |
> +                        PCIE_GLI_9767_SD_DATA_MULTI_CTL_UHS2_SWITCH_CTL;
> +               pci_write_config_dword(pdev, PCIE_GLI_9767_SD_DATA_MULTI_=
CTL, value);
> +
> +               gl9767_vhs_read(pdev);
> +
> +               sdhci_gli_overcurrent_event_enable(host, false);
> +               sdhci_uhs2_set_power(host, mode, vdd);
> +               sdhci_gli_overcurrent_event_enable(host, true);
> +       } else {
> +               gl9767_vhs_write(pdev);
> +
> +               pci_read_config_dword(pdev, PCIE_GLI_9767_SD_DATA_MULTI_C=
TL, &value);
> +               value &=3D ~(PCIE_GLI_9767_SD_DATA_MULTI_CTL_SELECT_UHS2 =
|
> +                          PCIE_GLI_9767_SD_DATA_MULTI_CTL_UHS2_SWITCH_CT=
L);
> +               pci_write_config_dword(pdev, PCIE_GLI_9767_SD_DATA_MULTI_=
CTL, value);
> +
> +               gl9767_vhs_read(pdev);
> +
> +               sdhci_gli_overcurrent_event_enable(host, false);
> +               sdhci_set_power(host, mode, vdd);
> +               sdhci_gli_overcurrent_event_enable(host, true);
> +       }
> +}
> +
>  static int gli_probe_slot_gl9750(struct sdhci_pci_slot *slot)
>  {
>         struct sdhci_host *host =3D slot->host;
> @@ -1324,6 +1462,7 @@ static int gli_probe_slot_gl9767(struct sdhci_pci_s=
lot *slot)
>         host->mmc->caps2 |=3D MMC_CAP2_SD_EXP;
>         host->mmc_host_ops.init_sd_express =3D gl9767_init_sd_express;
>         sdhci_enable_v4_mode(host);
> +       gl9767_vendor_init(host);
>
>         return 0;
>  }
> @@ -1827,12 +1966,19 @@ static const struct sdhci_ops sdhci_gl9767_ops =
=3D {
>         .reset                   =3D sdhci_gl9767_reset,
>         .set_uhs_signaling       =3D sdhci_set_uhs_signaling,
>         .voltage_switch          =3D sdhci_gl9767_voltage_switch,
> +       .dump_uhs2_regs          =3D sdhci_uhs2_dump_regs,
> +       .set_timeout             =3D sdhci_uhs2_set_timeout,
> +       .irq                     =3D sdhci_uhs2_irq,
> +       .set_power               =3D sdhci_gl9767_set_power,
> +       .uhs2_pre_detect_init    =3D sdhci_gli_pre_detect_init,
>  };
>
>  const struct sdhci_pci_fixes sdhci_gl9767 =3D {
>         .quirks         =3D SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
>         .quirks2        =3D SDHCI_QUIRK2_BROKEN_DDR50,
>         .probe_slot     =3D gli_probe_slot_gl9767,
> +       .add_host       =3D sdhci_pci_uhs2_add_host,
> +       .remove_host    =3D sdhci_pci_uhs2_remove_host,
>         .ops            =3D &sdhci_gl9767_ops,
>  #ifdef CONFIG_PM_SLEEP
>         .resume         =3D sdhci_pci_gli_resume,
> --
> 2.25.1
>
