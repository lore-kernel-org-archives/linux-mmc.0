Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8A810E3;
	Fri, 21 Jun 2024 01:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718934871; cv=none; b=DrUO0M6bZC+6PaZIoSeZnf/sFxJ55+hbgiKMzMJYs1qBh43YSrP+6NWEZeUqDArbOFBSrV3bYlqKv4LPQ5Sva0D1zZi0BT/vlcrR2Bg13tnaYeCLAXDYzfrnBD+1yhYuR30eeqelmZo10DMvXPrGfhpT9sWhkOZG9YCajfOc978=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718934871; c=relaxed/simple;
	bh=aSFpcFs6ONeLuOrxd6sEWHEsddMElHt4cazYUQt0fjk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j7y31ceW8hEki4+O+xMKTw/wADEWwlfg3S033EFDm2G1aE5D/ayHgU4mbnuX080ZWZsv6MZenJVGL6dxRzTJDqZr7rPgYy5ONAGY6JaMZ/tRmF57oda00swcJ2KqqL4qrqBXm7cg1uF3TAYVtiKlh/L1cilZoYR0sqG2MEA48Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gkGaJBPe; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gkGaJBPe"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2eaae2a6dc1so28192921fa.0;
        Thu, 20 Jun 2024 18:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718934867; x=1719539667; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rxblhwcm0TqKOu+iYEsCkyv/maqBX/RToKbmabjo2cY=;
        b=gkGaJBPekZ+ijw5mgJEAJc0SQK4Dv9FXHSpFgB+rDVG47jdfXCHqUD3w+mRwaPPXpf
         eeP0DYiax23yoAxWV2GMhw7rKmIwVUKe/DONDFZFWio6tNn+QIpCGx/F9uFOCdNGDuMO
         cB+iPkkjrSzs8zI9XXkgMLkrWc7P5n0Xz3mLBdE+6LZ8bq+TELpK5lFRRZ7YAvIJN/k+
         H5IdVfcsoI2gY1slOqfOg30J45xDu40SvRW+FoSxK1T3R5dtI98veT7v9tbY8pdVL3KO
         9yUWU0WUKVJnnbDaYSpLNoyZCocNRguPDxdq7o+C48+0LlLPtKqdbC19Z0j5HBFE0IYm
         46PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718934867; x=1719539667;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rxblhwcm0TqKOu+iYEsCkyv/maqBX/RToKbmabjo2cY=;
        b=FlcE0s3YZ4Lp58fpxjmn6vwu+xsAPtF/U5vuKvp0dA42KVrA97XZStDBgxtr8EPd6z
         MTjjaTTTn1IwGPXTS6mKDt8onAPRGjQcq+wD0vuChRaiSzJ2OzdnxZRrMG6/wtxd1LH5
         2KuRS5ty//pYEAZ27fFPrHd4kMBk7DWm7forWv0v7E1LeZIiYPUbyapJAci7cmOcie/L
         H6wSJNCykuLETNwybFax0Lk+/D/lsDVOkEVrkJxDBaYSf48Q6eYFzKA6X+O+vPsmX4G8
         OGefa1Af+sS5oAFpch9dB5tOTfWOX8EOP02lm1UoKOBCk3GckL5AsRHVHeCA0OZIp3JD
         VNkg==
X-Forwarded-Encrypted: i=1; AJvYcCWI+6X+yuXV7JTq1sfkl++lQNDm+Jq1N4N781FUk3Uzt35nQ7UqRD+NTmuyzfKLSaMXRnJrAolSHhuQ4Nk3C81Ehy6rmdqtUZBX12eDIYCjbiWXsa14EYiWKGZHCuppMc2OuFTdc5vf
X-Gm-Message-State: AOJu0YwPL2UgbUWq0QI868fRO3I92ohbsxkDrTPG05SNuzBzlWxMjAKD
	j2ldpixsbe2r5xkuixDjt+3hckfusDSq+FNfCEel3LYmzLLNY6m9pM3wh53FBMtK7z1NxGR+Dug
	TCveTVk5LCtCqsgwxnHwNRep4V58=
X-Google-Smtp-Source: AGHT+IGz3V3Y8nJrM/Z70PIUGz+iqDL+L7eVGLDv3agZw8b8ghtyXK50kwKww85MwCWamr2lRawSCRHaODNED6KeIuc=
X-Received: by 2002:a2e:7e0b:0:b0:2ec:1708:4db5 with SMTP id
 38308e7fff4ca-2ec3cffc628mr50070041fa.51.1718934866592; Thu, 20 Jun 2024
 18:54:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240620104444.5862-1-victorshihgli@gmail.com>
 <20240620104444.5862-23-victorshihgli@gmail.com> <CACT4zj9Nfd=W9ntQX4dDWzZJRFbP+vve9=BkaRjtmZY7752qfA@mail.gmail.com>
In-Reply-To: <CACT4zj9Nfd=W9ntQX4dDWzZJRFbP+vve9=BkaRjtmZY7752qfA@mail.gmail.com>
From: Ben Chuang <benchuanggli@gmail.com>
Date: Fri, 21 Jun 2024 09:54:12 +0800
Message-ID: <CACT4zj9Cs+mF+LwyCxV_e5n2+e3iog6OH0E=fGe5oO1FC7KByg@mail.gmail.com>
Subject: Re: [PATCH V17 22/22] mmc: sdhci-pci-gli: enable UHS-II mode for GL9767
To: Victor Shih <victorshihgli@gmail.com>
Cc: ulf.hansson@linaro.org, adrian.hunter@intel.com, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, HL.Liu@genesyslogic.com.tw, 
	Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org, dlunev@chromium.org, 
	Ben Chuang <ben.chuang@genesyslogic.com.tw>, 
	Victor Shih <victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 9:49=E2=80=AFAM Ben Chuang <benchuanggli@gmail.com>=
 wrote:
>
> Hi Victor,
>
> On Thu, Jun 20, 2024 at 6:46=E2=80=AFPM Victor Shih <victorshihgli@gmail.=
com> wrote:
> >
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
> >  drivers/mmc/host/sdhci-pci-gli.c | 150 ++++++++++++++++++++++++++++++-
> >  1 file changed, 148 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-=
pci-gli.c
> > index a4164948de81..37c63c45bdc9 100644
> > --- a/drivers/mmc/host/sdhci-pci-gli.c
> > +++ b/drivers/mmc/host/sdhci-pci-gli.c
> > @@ -210,6 +210,10 @@
> >  #define   PCIE_GLI_9767_SCR_CORE_PWR_D3_OFF              BIT(21)
> >  #define   PCIE_GLI_9767_SCR_CFG_RST_DATA_LINK_DOWN       BIT(30)
> >
> > +#define PCIE_GLI_9767_UHS2_PHY_SET_REG1                               =
 0x90C
> > +#define   PCIE_GLI_9767_UHS2_PHY_SET_REG1_SERDES_INTR            GENMA=
SK(31, 29)
> > +#define   PCIE_GLI_9767_UHS2_PHY_SET_REG1_SERDES_INTR_VALUE      0x3
> > +
> >  #define PCIE_GLI_9767_SDHC_CAP                 0x91C
> >  #define   PCIE_GLI_9767_SDHC_CAP_SDEI_RESULT     BIT(5)
> >
> > @@ -228,9 +232,15 @@
> >  #define   PCIE_GLI_9767_SD_EXPRESS_CTL_SD_EXPRESS_MODE   BIT(1)
> >
> >  #define PCIE_GLI_9767_SD_DATA_MULTI_CTL                               =
 0x944
> > +#define   PCIE_GLI_9767_SD_DATA_MULTI_CTL_SELECT_UHS2            BIT(5=
)
> > +#define   PCIE_GLI_9767_SD_DATA_MULTI_CTL_UHS2_SWITCH_CTL        BIT(8=
)
> >  #define   PCIE_GLI_9767_SD_DATA_MULTI_CTL_DISCONNECT_TIME        GENMA=
SK(23, 16)
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
> >  #define PCIE_GLI_9767_NORMAL_ERR_INT_STATUS_REG2                      =
 0x950
> >  #define   PCIE_GLI_9767_NORMAL_ERR_INT_STATUS_REG2_SDEI_COMPLETE      =
   BIT(0)
> >
> > @@ -240,6 +250,28 @@
> >  #define PCIE_GLI_9767_NORMAL_ERR_INT_SIGNAL_EN_REG2                   =
         0x958
> >  #define   PCIE_GLI_9767_NORMAL_ERR_INT_SIGNAL_EN_REG2_SDEI_COMPLETE_SI=
GNAL_EN    BIT(0)
> >
> > +#define PCIE_GLI_9767_UHS2_CTL1                                0x95C
> > +#define   PCIE_GLI_9767_UHS2_CTL1_TRANS_PASS             BIT(5)
> > +#define   PCIE_GLI_9767_UHS2_CTL1_TRANS_PASS_VALUE       0x1
> > +#define   PCIE_GLI_9767_UHS2_CTL1_DECODING_CTL           BIT(6)
> > +#define   PCIE_GLI_9767_UHS2_CTL1_DECODING_CTL_VALUE     0x1
> > +#define   PCIE_GLI_9767_UHS2_CTL1_SERDES_TRAN            GENMASK(10, 7=
)
> > +#define   PCIE_GLI_9767_UHS2_CTL1_SERDES_TRAN_VALUE      0x3
> > +#define   PCIE_GLI_9767_UHS2_CTL1_SERDES_RECV            GENMASK(14, 1=
1)
> > +#define   PCIE_GLI_9767_UHS2_CTL1_SERDES_RECV_VALUE      0xf
> > +#define   PCIE_GLI_9767_UHS2_CTL1_DIR_TRANS              GENMASK(16, 1=
5)
> > +#define   PCIE_GLI_9767_UHS2_CTL1_DIR_TRANS_VALUE        0x3
> > +#define   PCIE_GLI_9767_UHS2_CTL1_DIR_RECV               GENMASK(18, 1=
7)
> > +#define   PCIE_GLI_9767_UHS2_CTL1_DIR_RECV_VALUE         0x0
> > +#define   PCIE_GLI_9767_UHS2_CTL1_PDRST                          BIT(2=
5)
> > +#define   PCIE_GLI_9767_UHS2_CTL1_PDRST_VALUE            0x1
> > +
> > +#define PCIE_GLI_9767_UHS2_CTL2                        0x964
> > +#define   PCIE_GLI_9767_UHS2_CTL2_ZC             GENMASK(3, 0)
> > +#define   PCIE_GLI_9767_UHS2_CTL2_ZC_VALUE       0xb
> > +#define   PCIE_GLI_9767_UHS2_CTL2_ZC_CTL         BIT(6)
> > +#define   PCIE_GLI_9767_UHS2_CTL2_ZC_CTL_VALUE   0x1
> > +
> >  #define GLI_MAX_TUNING_LOOP 40
> >
> >  /* Genesys Logic chipset */
> > @@ -1197,8 +1229,32 @@ static void gl9767_hw_setting(struct sdhci_pci_s=
lot *slot)
> >
> >  static void sdhci_gl9767_reset(struct sdhci_host *host, u8 mask)
> >  {
> > -       sdhci_reset(host, mask);
> > -       gli_set_9767(host);
> > +       u16 clk_ctrl;
> > +       u16 ctrl2;
> > +
> > +       if (mmc_card_uhs2(host->mmc)) {
> > +               /* need internal clock */
> > +               if (mask & SDHCI_RESET_ALL) {
> > +                       ctrl2 =3D sdhci_readw(host, SDHCI_HOST_CONTROL2=
);
> > +                       clk_ctrl =3D sdhci_readw(host, SDHCI_CLOCK_CONT=
ROL);
> > +
> > +                       if ((ctrl2 & SDHCI_CTRL_V4_MODE) && (ctrl2 & SD=
HCI_CTRL_UHS2_ENABLE)) {
> > +                               sdhci_writew(host, SDHCI_CLOCK_INT_EN, =
SDHCI_CLOCK_CONTROL);
> > +                       } else {
> > +                               sdhci_writew(host, SDHCI_CLOCK_INT_EN, =
SDHCI_CLOCK_CONTROL);
> > +                               sdhci_wait_clock_stable(host);
> > +                               sdhci_writew(host, SDHCI_CTRL_V4_MODE, =
SDHCI_HOST_CONTROL2);
> > +                       }
> > +               }
> > +               if (mask & (SDHCI_RESET_CMD | SDHCI_RESET_DATA))
>
> Is this your intention?
>     -> if ((mask & SDHCI_RESET_CMD) |
>             (mask & SDHCI_RESET_DATA))
>
sorry, fix typo
     -> if ((mask & SDHCI_RESET_CMD) ||
             (mask & SDHCI_RESET_DATA))

Best regards,
Ben Chuang
>
> > +                       sdhci_gli_uhs2_reset_sd_tran(host);
> > +
> > +               sdhci_uhs2_reset(host, mask);
> > +               gli_set_9767(host);
> > +       } else {
> > +               sdhci_reset(host, mask);
> > +               gli_set_9767(host);
> > +       }
> >  }
> >
> >  static int gl9767_init_sd_express(struct mmc_host *mmc, struct mmc_ios=
 *ios)
> > @@ -1288,6 +1344,88 @@ static int gl9767_init_sd_express(struct mmc_hos=
t *mmc, struct mmc_ios *ios)
> >         return 0;
> >  }
> >
> > +static void gl9767_vendor_init(struct sdhci_host *host)
> > +{
> > +       struct sdhci_pci_slot *slot =3D sdhci_priv(host);
> > +       struct pci_dev *pdev =3D slot->chip->pdev;
> > +       u32 value;
> > +
> > +       gl9767_vhs_write(pdev);
> > +
> > +       pci_read_config_dword(pdev, PCIE_GLI_9767_UHS2_PHY_SET_REG1, &v=
alue);
> > +       value |=3D FIELD_PREP(PCIE_GLI_9767_UHS2_PHY_SET_REG1_SERDES_IN=
TR,
> > +                           PCIE_GLI_9767_UHS2_PHY_SET_REG1_SERDES_INTR=
_VALUE);
> > +       pci_write_config_dword(pdev, PCIE_GLI_9767_UHS2_PHY_SET_REG1, v=
alue);
> > +
> > +       pci_read_config_dword(pdev, PCIE_GLI_9767_UHS2_PHY_SET_REG2, &v=
alue);
> > +       value |=3D FIELD_PREP(PCIE_GLI_9767_UHS2_PHY_SET_REG2_SSC_PPM_S=
ETTING,
> > +                           PCIE_GLI_9767_UHS2_PHY_SET_REG2_SSC_PPM_SET=
TING_VALUE);
> > +       pci_write_config_dword(pdev, PCIE_GLI_9767_UHS2_PHY_SET_REG2, v=
alue);
> > +
> > +       pci_read_config_dword(pdev, PCIE_GLI_9767_UHS2_CTL1, &value);
> > +       value |=3D FIELD_PREP(PCIE_GLI_9767_UHS2_CTL1_TRANS_PASS,
> > +                           PCIE_GLI_9767_UHS2_CTL1_TRANS_PASS_VALUE) |
> > +                FIELD_PREP(PCIE_GLI_9767_UHS2_CTL1_DECODING_CTL,
> > +                           PCIE_GLI_9767_UHS2_CTL1_DECODING_CTL_VALUE)=
 |
> > +                FIELD_PREP(PCIE_GLI_9767_UHS2_CTL1_SERDES_TRAN,
> > +                           PCIE_GLI_9767_UHS2_CTL1_SERDES_TRAN_VALUE) =
|
> > +                FIELD_PREP(PCIE_GLI_9767_UHS2_CTL1_SERDES_RECV,
> > +                           PCIE_GLI_9767_UHS2_CTL1_SERDES_RECV_VALUE) =
|
> > +                FIELD_PREP(PCIE_GLI_9767_UHS2_CTL1_DIR_TRANS,
> > +                           PCIE_GLI_9767_UHS2_CTL1_DIR_TRANS_VALUE) |
> > +                FIELD_PREP(PCIE_GLI_9767_UHS2_CTL1_DIR_RECV,
> > +                           PCIE_GLI_9767_UHS2_CTL1_DIR_RECV_VALUE) |
> > +                FIELD_PREP(PCIE_GLI_9767_UHS2_CTL1_PDRST,
> > +                           PCIE_GLI_9767_UHS2_CTL1_PDRST_VALUE);
> > +       pci_write_config_dword(pdev, PCIE_GLI_9767_UHS2_CTL1, value);
> > +
> > +       pci_read_config_dword(pdev, PCIE_GLI_9767_UHS2_CTL2, &value);
> > +       value |=3D FIELD_PREP(PCIE_GLI_9767_UHS2_CTL2_ZC,
> > +                           PCIE_GLI_9767_UHS2_CTL2_ZC_VALUE) |
> > +                FIELD_PREP(PCIE_GLI_9767_UHS2_CTL2_ZC_CTL,
> > +                           PCIE_GLI_9767_UHS2_CTL2_ZC_CTL_VALUE);
> > +       pci_write_config_dword(pdev, PCIE_GLI_9767_UHS2_CTL2, value);
> > +
> > +       gl9767_vhs_read(pdev);
> > +}
> > +
> > +static void sdhci_gl9767_set_power(struct sdhci_host *host, unsigned c=
har mode,        unsigned short vdd)
> > +{
> > +       struct sdhci_pci_slot *slot =3D sdhci_priv(host);
> > +       struct pci_dev *pdev;
> > +       u32 value;
> > +
> > +       pdev =3D slot->chip->pdev;
> > +
> > +       if (mmc_card_uhs2(host->mmc)) {
> > +               gl9767_vhs_write(pdev);
> > +
> > +               pci_read_config_dword(pdev, PCIE_GLI_9767_SD_DATA_MULTI=
_CTL, &value);
> > +               value |=3D PCIE_GLI_9767_SD_DATA_MULTI_CTL_SELECT_UHS2 =
|
> > +                        PCIE_GLI_9767_SD_DATA_MULTI_CTL_UHS2_SWITCH_CT=
L;
> > +               pci_write_config_dword(pdev, PCIE_GLI_9767_SD_DATA_MULT=
I_CTL, value);
> > +
> > +               gl9767_vhs_read(pdev);
> > +
> > +               sdhci_gli_overcurrent_event_enable(host, false);
> > +               sdhci_uhs2_set_power(host, mode, vdd);
> > +               sdhci_gli_overcurrent_event_enable(host, true);
> > +       } else {
> > +               gl9767_vhs_write(pdev);
> > +
> > +               pci_read_config_dword(pdev, PCIE_GLI_9767_SD_DATA_MULTI=
_CTL, &value);
> > +               value &=3D ~(PCIE_GLI_9767_SD_DATA_MULTI_CTL_SELECT_UHS=
2 |
> > +                          PCIE_GLI_9767_SD_DATA_MULTI_CTL_UHS2_SWITCH_=
CTL);
> > +               pci_write_config_dword(pdev, PCIE_GLI_9767_SD_DATA_MULT=
I_CTL, value);
> > +
> > +               gl9767_vhs_read(pdev);
> > +
> > +               sdhci_gli_overcurrent_event_enable(host, false);
> > +               sdhci_set_power(host, mode, vdd);
> > +               sdhci_gli_overcurrent_event_enable(host, true);
> > +       }
> > +}
> > +
> >  static int gli_probe_slot_gl9750(struct sdhci_pci_slot *slot)
> >  {
> >         struct sdhci_host *host =3D slot->host;
> > @@ -1324,6 +1462,7 @@ static int gli_probe_slot_gl9767(struct sdhci_pci=
_slot *slot)
> >         host->mmc->caps2 |=3D MMC_CAP2_SD_EXP;
> >         host->mmc_host_ops.init_sd_express =3D gl9767_init_sd_express;
> >         sdhci_enable_v4_mode(host);
> > +       gl9767_vendor_init(host);
> >
> >         return 0;
> >  }
> > @@ -1827,12 +1966,19 @@ static const struct sdhci_ops sdhci_gl9767_ops =
=3D {
> >         .reset                   =3D sdhci_gl9767_reset,
> >         .set_uhs_signaling       =3D sdhci_set_uhs_signaling,
> >         .voltage_switch          =3D sdhci_gl9767_voltage_switch,
> > +       .dump_uhs2_regs          =3D sdhci_uhs2_dump_regs,
> > +       .set_timeout             =3D sdhci_uhs2_set_timeout,
> > +       .irq                     =3D sdhci_uhs2_irq,
> > +       .set_power               =3D sdhci_gl9767_set_power,
> > +       .uhs2_pre_detect_init    =3D sdhci_gli_pre_detect_init,
> >  };
> >
> >  const struct sdhci_pci_fixes sdhci_gl9767 =3D {
> >         .quirks         =3D SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
> >         .quirks2        =3D SDHCI_QUIRK2_BROKEN_DDR50,
> >         .probe_slot     =3D gli_probe_slot_gl9767,
> > +       .add_host       =3D sdhci_pci_uhs2_add_host,
> > +       .remove_host    =3D sdhci_pci_uhs2_remove_host,
> >         .ops            =3D &sdhci_gl9767_ops,
> >  #ifdef CONFIG_PM_SLEEP
> >         .resume         =3D sdhci_pci_gli_resume,
> > --
> > 2.25.1
> >
