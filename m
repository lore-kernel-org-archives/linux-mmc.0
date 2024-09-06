Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA92114A4D1;
	Fri,  6 Sep 2024 09:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725616728; cv=none; b=WSCdQapfPoLAn5F+7yBfeY56x0wDkHQbzvhkn+bagqlWZmwRBcoBw2dlGNZCtMsjstcvcYTD+tvdvtcS4ryahDV50AFr5JlU5/hTEfdkBUx84P26aUYND8A92p4/cs5YWrLB9Z9JEq2wibJVZ4pnTSPvWN4RzujFFVtc1r358bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725616728; c=relaxed/simple;
	bh=kjAs6MRwwU3oj3PYEflwQVglrj3xg0QdQNLhOf598o4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eha89gYF5f2fnHtocZDnz67Gf5GnvQ9r0hU5e7qX2xMM2J2x8TUH7YgxStO/Ei4NrEh+xkcVBgodoDUvw7h4QKAfgaOmNH6+YdKde8qSL72Or7tT64rnY/mBWUefFwoG/RjcMzSyWOhhrVfwaNVbrea4ihmS69f2hS7r3ORRlt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LZ9w0oZq; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LZ9w0oZq"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-49bcb3d0d6fso575984137.2;
        Fri, 06 Sep 2024 02:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725616726; x=1726221526; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cOIA0REj571V3VZmLzYqnvMNlXRWK1N41o4l0+0fHBc=;
        b=LZ9w0oZqOS/HW4jIb+eW+R1b4l8YRpkdMONXppUk/NiMzC4Ow1xtulBGl3jeGzaTM5
         51bbPWR6KQEGqpQVQUF54YYbyHL07j0KQK9d909bmPdp7I1sHG2qLVIQYA1bNhdRGeZh
         bAJWFjN+GHWePEqINaxdYf6q64VkuK8Om2lh4ZrOjeXuFQdlKhL69Q9gCtBPhuKWsntE
         uaajRUcFDo7aNKYPUyDSFmMqyADxSFBF+pOkWbcUtkCbOzaU+ZB/Zek2tARMh/f4AeYt
         5T94/vTPkjnNuoYXHwP0Dfcy+VRWGmrDcrHdqWQmpRA71tOd1jKZhekeIfMsQHC2bPkA
         2PHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725616726; x=1726221526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cOIA0REj571V3VZmLzYqnvMNlXRWK1N41o4l0+0fHBc=;
        b=qqiw85wcRUNGLJpGF6i1aArp+hsITgmcCPmNs8Qz99g6JpZSBy7JMKEBsBqog41crX
         OWmSVcGhQ8XZsHcS0SSx9dYdsIZIe2RHHMYZRaghr5igPJtPOxEKMklT5AsYDaTEYAIU
         cT9zE/SuoTvvCwnYpL21VWVi3f9qs4SLMa+t4tGGFEwjDiEOF8gUixSWQTq+D5YaVqp3
         8oQm/C0Jdu/ntGTYPWC28VDFgkmreOThDK6xZDUug5ns+TtFdjtV9Jr02Cf+MLCOEbym
         qdHtqqmcJejhDqW3RJrvehmIyGnCszqctrFHs23LolOFBC/qmTzeAITuHESDNtO9B6pl
         qyBA==
X-Forwarded-Encrypted: i=1; AJvYcCUJb0L+RRIo4F2A0/qm2ZAKg3oRHsT+EBg06jyP4oJdloUCP4HhhXXE0tk+I4boRU+84GdXLlkcwP6K@vger.kernel.org, AJvYcCVh0x++TxkkFKShOF2aKsGOgKUcVwWdwFhmJ7c2/VIOdLMaRFzKbJ7jhPJ7M9X//gBjKKG3/OpdDy+wKmU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYziEA2XjS/Kitd7wtsRaesL3w0gJwGmE0DdKFf7xvHTI0WGzn
	nCc2wKY5tWOuvp7vn2neGXZUfJNJiswULZPpK5wkrEUTcrYAPZSu2+DnD2ibLYia7jav021u3eL
	y1ffPH+/u9cD/lk6c6Ereq6QymzQ=
X-Google-Smtp-Source: AGHT+IHQPvoYjpv+P9jAQgpo/Y5SnFgp2zy5yH+BG0+EC6DMlAB1L8Beh+Vaz/p3JGCX6qlstGICxNgUakREIWshEgo=
X-Received: by 2002:a05:6102:26ce:b0:498:d12b:4774 with SMTP id
 ada2fe7eead31-49a5b05b40amr24531059137.7.1725616725676; Fri, 06 Sep 2024
 02:58:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240905102000.5020-1-victorshihgli@gmail.com>
 <20240905102000.5020-22-victorshihgli@gmail.com> <313ed563-8839-418f-8c1f-3275081d1258@intel.com>
In-Reply-To: <313ed563-8839-418f-8c1f-3275081d1258@intel.com>
From: Victor Shih <victorshihgli@gmail.com>
Date: Fri, 6 Sep 2024 17:58:32 +0800
Message-ID: <CAK00qKCYoOE6uF3nekyZjOOxcr-L7koE8z=nwpFP3XWnD+psag@mail.gmail.com>
Subject: Re: [PATCH V20 21/22] mmc: sdhci-pci-gli: enable UHS-II mode for GL9755
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, benchuanggli@gmail.com, 
	Lucas.Lai@genesyslogic.com.tw, HL.Liu@genesyslogic.com.tw, 
	Greg.tu@genesyslogic.com.tw, dlunev@chromium.org, 
	Ben Chuang <ben.chuang@genesyslogic.com.tw>, 
	AKASHI Takahiro <takahiro.akashi@linaro.org>, Victor Shih <victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 9:55=E2=80=AFPM Adrian Hunter <adrian.hunter@intel.c=
om> wrote:
>
> On 5/09/24 13:19, Victor Shih wrote:
> > From: Victor Shih <victor.shih@genesyslogic.com.tw>
> >
> > Changes are:
> >  * Disable GL9755 overcurrent interrupt when power on/off on UHS-II.
> >  * Enable the internal clock when do reset on UHS-II mode.
> >  * Increase timeout value before detecting UHS-II interface.
> >  * Add vendor settings fro UHS-II mode.
> >  * Remove sdhci_gli_enable_internal_clock functon unused clk_ctrl varia=
ble.
> >  * Make a function sdhci_gli_wait_software_reset_done() for gl9755 rese=
t.
> >
> > Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> > Signed-off-by: Lucas Lai <lucas.lai@genesyslogic.com.tw>
> > ---
> >
> > Updates in V20:
> >  - Remove sdhci_gli_enable_internal_clock functon unused clk_ctrl varia=
ble.
> >  - Make a function sdhci_gli_wait_software_reset_done() for gl9755 rese=
t.
> >
> > Updates in V19:
> >  - Add sdhci_gli_enable_internal_clock() to simplify the code
> >    in the sdhci_gl9755_reset().
> >
> > Updates in V17:
> >  - Rname gl9755_overcurrent_event_enable() to
> >    sdhci_gli_overcurrent_event_enable().
> >
> > Updates in V15:
> >  - Adjust gl9755_vendor_init() to the correct function.
> >
> > Updates in V13:
> >  - Ues uhs2_sd_tran to stead MMC_UHS2_SD_TRAN.
> >
> > Updates in V9:
> >  - Rename gl9755_pre_detect_init() to sdhci_gli_pre_detect_init().
> >  - Rename gl9755_uhs2_reset_sd_tran() to sdhci_gli_uhs2_reset_sd_tran()=
.
> >
> > Updates in V8:
> >  - Use sdhci_get_vdd_value() to simplify code in gl9755_set_power().
> >  - Use read_poll_timeout_atomic() to simplify code in
> >    sdhci_wait_clock_stable().
> >  - Use read_poll_timeout_atomic() to simplify code in sdhci_gl9755_rese=
t().
> >
> > Updates in V7:
> >  - Drop using gl9755_post_attach_sd().
> >
> > ---
> >
> >  drivers/mmc/host/sdhci-pci-gli.c | 236 ++++++++++++++++++++++++++++++-
> >  1 file changed, 235 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-=
pci-gli.c
> > index 0f81586a19df..7cf27a666f34 100644
> > --- a/drivers/mmc/host/sdhci-pci-gli.c
> > +++ b/drivers/mmc/host/sdhci-pci-gli.c
> > @@ -18,6 +18,7 @@
> >  #include "sdhci-cqhci.h"
> >  #include "sdhci-pci.h"
> >  #include "cqhci.h"
> > +#include "sdhci-uhs2.h"
> >
> >  /*  Genesys Logic extra registers */
> >  #define SDHCI_GLI_9750_WT         0x800
> > @@ -139,9 +140,36 @@
> >
> >  #define PCI_GLI_9755_PLLSSC        0x68
> >  #define   PCI_GLI_9755_PLLSSC_PPM    GENMASK(15, 0)
> > +#define   PCI_GLI_9755_PLLSSC_RTL             BIT(24)
> > +#define   GLI_9755_PLLSSC_RTL_VALUE           0x1
> > +#define   PCI_GLI_9755_PLLSSC_TRANS_PASS      BIT(27)
> > +#define   GLI_9755_PLLSSC_TRANS_PASS_VALUE    0x1
> > +#define   PCI_GLI_9755_PLLSSC_RECV            GENMASK(29, 28)
> > +#define   GLI_9755_PLLSSC_RECV_VALUE          0x0
> > +#define   PCI_GLI_9755_PLLSSC_TRAN            GENMASK(31, 30)
> > +#define   GLI_9755_PLLSSC_TRAN_VALUE          0x3
> > +
> > +#define PCI_GLI_9755_UHS2_PLL            0x6C
> > +#define   PCI_GLI_9755_UHS2_PLL_SSC        GENMASK(9, 8)
> > +#define   GLI_9755_UHS2_PLL_SSC_VALUE      0x0
> > +#define   PCI_GLI_9755_UHS2_PLL_DELAY      BIT(18)
> > +#define   GLI_9755_UHS2_PLL_DELAY_VALUE    0x1
> > +#define   PCI_GLI_9755_UHS2_PLL_PDRST      BIT(27)
> > +#define   GLI_9755_UHS2_PLL_PDRST_VALUE    0x1
> >
> >  #define PCI_GLI_9755_SerDes  0x70
> > +#define   PCI_GLI_9755_UHS2_SERDES_INTR       GENMASK(2, 0)
> > +#define   GLI_9755_UHS2_SERDES_INTR_VALUE     0x3
> > +#define   PCI_GLI_9755_UHS2_SERDES_ZC1        BIT(3)
> > +#define   GLI_9755_UHS2_SERDES_ZC1_VALUE      0x0
> > +#define   PCI_GLI_9755_UHS2_SERDES_ZC2        GENMASK(7, 4)
> > +#define   GLI_9755_UHS2_SERDES_ZC2_DEFAULT    0xB
> > +#define   GLI_9755_UHS2_SERDES_ZC2_SANDISK    0x0
> >  #define PCI_GLI_9755_SCP_DIS   BIT(19)
> > +#define   PCI_GLI_9755_UHS2_SERDES_TRAN       GENMASK(27, 24)
> > +#define   GLI_9755_UHS2_SERDES_TRAN_VALUE     0xC
> > +#define   PCI_GLI_9755_UHS2_SERDES_RECV       GENMASK(31, 28)
> > +#define   GLI_9755_UHS2_SERDES_RECV_VALUE     0xF
> >
> >  #define PCI_GLI_9755_MISC        0x78
> >  #define   PCI_GLI_9755_MISC_SSC_OFF    BIT(26)
> > @@ -779,6 +807,204 @@ static void gl9755_hw_setting(struct sdhci_pci_sl=
ot *slot)
> >       gl9755_wt_off(pdev);
> >  }
> >
> > +static void gl9755_vendor_init(struct sdhci_host *host)
> > +{
> > +     struct sdhci_pci_slot *slot =3D sdhci_priv(host);
> > +     struct pci_dev *pdev =3D slot->chip->pdev;
> > +     u32 serdes;
> > +     u32 pllssc;
> > +     u32 uhs2_pll;
> > +
> > +     gl9755_wt_on(pdev);
> > +
> > +     pci_read_config_dword(pdev, PCI_GLI_9755_SerDes, &serdes);
> > +     serdes &=3D ~PCI_GLI_9755_UHS2_SERDES_TRAN;
> > +     serdes |=3D FIELD_PREP(PCI_GLI_9755_UHS2_SERDES_TRAN,
> > +                          GLI_9755_UHS2_SERDES_TRAN_VALUE);
> > +     serdes &=3D ~PCI_GLI_9755_UHS2_SERDES_RECV;
> > +     serdes |=3D FIELD_PREP(PCI_GLI_9755_UHS2_SERDES_RECV,
> > +                          GLI_9755_UHS2_SERDES_RECV_VALUE);
> > +     serdes &=3D ~PCI_GLI_9755_UHS2_SERDES_INTR;
> > +     serdes |=3D FIELD_PREP(PCI_GLI_9755_UHS2_SERDES_INTR,
> > +                          GLI_9755_UHS2_SERDES_INTR_VALUE);
> > +     serdes &=3D ~PCI_GLI_9755_UHS2_SERDES_ZC1;
> > +     serdes |=3D FIELD_PREP(PCI_GLI_9755_UHS2_SERDES_ZC1,
> > +                          GLI_9755_UHS2_SERDES_ZC1_VALUE);
> > +     serdes &=3D ~PCI_GLI_9755_UHS2_SERDES_ZC2;
> > +     serdes |=3D FIELD_PREP(PCI_GLI_9755_UHS2_SERDES_ZC2,
> > +                          GLI_9755_UHS2_SERDES_ZC2_DEFAULT);
> > +     pci_write_config_dword(pdev, PCI_GLI_9755_SerDes, serdes);
> > +
> > +     pci_read_config_dword(pdev, PCI_GLI_9755_UHS2_PLL, &uhs2_pll);
> > +     uhs2_pll &=3D ~PCI_GLI_9755_UHS2_PLL_SSC;
> > +     uhs2_pll |=3D FIELD_PREP(PCI_GLI_9755_UHS2_PLL_SSC,
> > +                       GLI_9755_UHS2_PLL_SSC_VALUE);
> > +     uhs2_pll &=3D ~PCI_GLI_9755_UHS2_PLL_DELAY;
> > +     uhs2_pll |=3D FIELD_PREP(PCI_GLI_9755_UHS2_PLL_DELAY,
> > +                       GLI_9755_UHS2_PLL_DELAY_VALUE);
> > +     uhs2_pll &=3D ~PCI_GLI_9755_UHS2_PLL_PDRST;
> > +     uhs2_pll |=3D FIELD_PREP(PCI_GLI_9755_UHS2_PLL_PDRST,
> > +                       GLI_9755_UHS2_PLL_PDRST_VALUE);
> > +     pci_write_config_dword(pdev, PCI_GLI_9755_UHS2_PLL, uhs2_pll);
> > +
> > +     pci_read_config_dword(pdev, PCI_GLI_9755_PLLSSC, &pllssc);
> > +     pllssc &=3D ~PCI_GLI_9755_PLLSSC_RTL;
> > +     pllssc |=3D FIELD_PREP(PCI_GLI_9755_PLLSSC_RTL,
> > +                       GLI_9755_PLLSSC_RTL_VALUE);
> > +     pllssc &=3D ~PCI_GLI_9755_PLLSSC_TRANS_PASS;
> > +     pllssc |=3D FIELD_PREP(PCI_GLI_9755_PLLSSC_TRANS_PASS,
> > +                       GLI_9755_PLLSSC_TRANS_PASS_VALUE);
> > +     pllssc &=3D ~PCI_GLI_9755_PLLSSC_RECV;
> > +     pllssc |=3D FIELD_PREP(PCI_GLI_9755_PLLSSC_RECV,
> > +                       GLI_9755_PLLSSC_RECV_VALUE);
> > +     pllssc &=3D ~PCI_GLI_9755_PLLSSC_TRAN;
> > +     pllssc |=3D FIELD_PREP(PCI_GLI_9755_PLLSSC_TRAN,
> > +                       GLI_9755_PLLSSC_TRAN_VALUE);
> > +     pci_write_config_dword(pdev, PCI_GLI_9755_PLLSSC, pllssc);
> > +
> > +     gl9755_wt_off(pdev);
> > +}
> > +
> > +static void sdhci_gli_pre_detect_init(struct sdhci_host *host)
> > +{
> > +     /* Need more time on UHS2 detect flow */
> > +     sdhci_writeb(host, 0xA7, SDHCI_UHS2_TIMER_CTRL);
> > +}
> > +
> > +static void sdhci_gli_overcurrent_event_enable(struct sdhci_host *host=
, bool enable)
> > +{
> > +     u32 mask;
> > +
> > +     mask =3D sdhci_readl(host, SDHCI_SIGNAL_ENABLE);
> > +     if (enable)
> > +             mask |=3D SDHCI_INT_BUS_POWER;
> > +     else
> > +             mask &=3D ~SDHCI_INT_BUS_POWER;
> > +
> > +     sdhci_writel(host, mask, SDHCI_SIGNAL_ENABLE);
> > +
> > +     mask =3D sdhci_readl(host, SDHCI_INT_ENABLE);
> > +     if (enable)
> > +             mask |=3D SDHCI_INT_BUS_POWER;
> > +     else
> > +             mask &=3D ~SDHCI_INT_BUS_POWER;
> > +
> > +     sdhci_writel(host, mask, SDHCI_INT_ENABLE);
> > +}
> > +
> > +static void gl9755_set_power(struct sdhci_host *host, unsigned char mo=
de,
> > +                          unsigned short vdd)
> > +{
> > +     u8 pwr =3D 0;
> > +
> > +     if (mode !=3D MMC_POWER_OFF) {
> > +             pwr =3D sdhci_get_vdd_value(vdd);
> > +             if (!pwr)
> > +                     WARN(1, "%s: Invalid vdd %#x\n", mmc_hostname(hos=
t->mmc), vdd);
> > +             pwr |=3D SDHCI_VDD2_POWER_180;
> > +     }
> > +
> > +     if (host->pwr =3D=3D pwr)
> > +             return;
> > +
> > +     host->pwr =3D pwr;
> > +
> > +     if (pwr =3D=3D 0) {
> > +             sdhci_gli_overcurrent_event_enable(host, false);
> > +             sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
> > +     } else {
> > +             sdhci_gli_overcurrent_event_enable(host, false);
> > +             sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
> > +
> > +             pwr |=3D (SDHCI_POWER_ON | SDHCI_VDD2_POWER_ON);
> > +
> > +             sdhci_writeb(host, pwr & 0xf, SDHCI_POWER_CONTROL);
> > +             /* wait stable */
> > +             mdelay(5);
> > +             sdhci_writeb(host, pwr, SDHCI_POWER_CONTROL);
> > +             /* wait stable */
> > +             mdelay(5);
> > +             sdhci_gli_overcurrent_event_enable(host, true);
> > +     }
> > +}
> > +
> > +static bool sdhci_wait_clock_stable(struct sdhci_host *host)
> > +{
> > +     u16 clk =3D 0;
> > +
> > +     if (read_poll_timeout_atomic(sdhci_readw, clk, (clk & SDHCI_CLOCK=
_INT_STABLE),
> > +                                  10, 20000, false, host, SDHCI_CLOCK_=
CONTROL)) {
> > +             pr_err("%s: Internal clock never stabilised.\n", mmc_host=
name(host->mmc));
> > +             sdhci_dumpregs(host);
> > +             return false;
> > +     }
> > +     return true;
> > +}
> > +
> > +static void sdhci_gli_enable_internal_clock(struct sdhci_host *host)
> > +{
> > +     u16 ctrl2;
> > +
> > +     ctrl2 =3D sdhci_readw(host, SDHCI_HOST_CONTROL2);
> > +
> > +     sdhci_writew(host, SDHCI_CLOCK_INT_EN, SDHCI_CLOCK_CONTROL);
> > +
> > +     if (!((ctrl2 & SDHCI_CTRL_V4_MODE) &&
> > +           (ctrl2 & SDHCI_CTRL_UHS2_ENABLE))) {
> > +             sdhci_wait_clock_stable(host);
> > +             sdhci_writew(host, SDHCI_CTRL_V4_MODE, SDHCI_HOST_CONTROL=
2);
> > +     }
> > +}
> > +
> > +static int sdhci_gli_wait_software_reset_done(struct sdhci_host *host,=
 u8 mask)
> > +{
> > +     u8 rst;
> > +
> > +     /* hw clears the bit when it's done */
> > +     if (read_poll_timeout_atomic(sdhci_readb, rst, !(rst & mask),
> > +                                  10, 100000, false, host, SDHCI_SOFTW=
ARE_RESET)) {
> > +             pr_err("%s: Reset 0x%x never completed.\n", mmc_hostname(=
host->mmc), (int)mask);
> > +             sdhci_dumpregs(host);
> > +             /* manual clear */
> > +             sdhci_writeb(host, 0, SDHCI_SOFTWARE_RESET);
> > +             return -ETIMEDOUT;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static void sdhci_gli_uhs2_reset_sd_tran(struct sdhci_host *host)
> > +{
> > +     /* do this on UHS2 mode */
> > +     if (host->mmc->uhs2_sd_tran) {
> > +             sdhci_uhs2_reset(host, SDHCI_UHS2_SW_RESET_SD);
> > +             sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
> > +             sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
> > +             sdhci_uhs2_clear_set_irqs(host,
> > +                                       SDHCI_INT_ALL_MASK,
> > +                                       SDHCI_UHS2_INT_ERROR_MASK);
> > +     }
> > +}
> > +
> > +static void sdhci_gl9755_reset(struct sdhci_host *host, u8 mask)
> > +{
> > +     /* need internal clock */
> > +     if (mask & SDHCI_RESET_ALL)
> > +             sdhci_gli_enable_internal_clock(host);
> > +
> > +     sdhci_writeb(host, mask, SDHCI_SOFTWARE_RESET);
> > +
> > +     /* reset sd-tran on UHS2 mode if need to reset cmd/data */
> > +     if ((mask & SDHCI_RESET_CMD) | (mask & SDHCI_RESET_DATA))
> > +             sdhci_gli_uhs2_reset_sd_tran(host);
> > +
> > +     if (mask & SDHCI_RESET_ALL)
> > +             host->clock =3D 0;
> > +
> > +     if (sdhci_gli_wait_software_reset_done(host, mask))
> > +             return;
>
> Should be just:
>
>         sdhci_gli_wait_software_reset_done(host, mask);
>

Hi, Adrian

I will update this in the next version.

Thanks, Victor Shih

> > +}
> > +
> >  static inline void gl9767_vhs_read(struct pci_dev *pdev)
> >  {
> >       u32 vhs_enable;
> > @@ -1086,6 +1312,7 @@ static int gli_probe_slot_gl9755(struct sdhci_pci=
_slot *slot)
> >       gli_pcie_enable_msi(slot);
> >       slot->host->mmc->caps2 |=3D MMC_CAP2_NO_SDIO;
> >       sdhci_enable_v4_mode(host);
> > +     gl9755_vendor_init(host);
> >
> >       return 0;
> >  }
> > @@ -1524,17 +1751,24 @@ static const struct sdhci_ops sdhci_gl9755_ops =
=3D {
> >       .read_w                 =3D sdhci_gli_readw,
> >       .read_b                 =3D sdhci_gli_readb,
> >       .set_clock              =3D sdhci_gl9755_set_clock,
> > +     .set_power              =3D gl9755_set_power,
> >       .enable_dma             =3D sdhci_pci_enable_dma,
> >       .set_bus_width          =3D sdhci_set_bus_width,
> > -     .reset                  =3D sdhci_reset,
> > +     .reset                  =3D sdhci_gl9755_reset,
> >       .set_uhs_signaling      =3D sdhci_set_uhs_signaling,
> >       .voltage_switch         =3D sdhci_gli_voltage_switch,
> > +     .dump_uhs2_regs         =3D sdhci_uhs2_dump_regs,
> > +     .set_timeout            =3D sdhci_uhs2_set_timeout,
> > +     .irq                    =3D sdhci_uhs2_irq,
> > +     .uhs2_pre_detect_init   =3D sdhci_gli_pre_detect_init,
> >  };
> >
> >  const struct sdhci_pci_fixes sdhci_gl9755 =3D {
> >       .quirks         =3D SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
> >       .quirks2        =3D SDHCI_QUIRK2_BROKEN_DDR50,
> >       .probe_slot     =3D gli_probe_slot_gl9755,
> > +     .add_host       =3D sdhci_pci_uhs2_add_host,
> > +     .remove_host    =3D sdhci_pci_uhs2_remove_host,
> >       .ops            =3D &sdhci_gl9755_ops,
> >  #ifdef CONFIG_PM_SLEEP
> >       .resume         =3D sdhci_pci_gli_resume,
>
