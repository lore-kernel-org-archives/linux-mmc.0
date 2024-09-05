Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E22319413B;
	Thu,  5 Sep 2024 10:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725531295; cv=none; b=XZ/Yvfu1KVyLfZCRCnz8oeEr1/NQtKfgfHOSeuUIGoU5hC14zcSOc3pqzcznCAIq0o0XMLck9y4o7eZI5g6B6tQ+HfQVoFs2KWy0df+RBno+Dh2zCBKKuMD7V8O5q5/xbqXDPnAEgN0akB/7Kfcr0zDtD0HWnm0e80XrotYqsZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725531295; c=relaxed/simple;
	bh=/kBWNv03LwLZ34wyRxW3j3aXo30BD1WoPqA20STUnTM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IO+AC3Bi45dTAQtrCC9RTzBjJkLQxDHkyuJV5mckh16RkoH45MjKWEro5CVXkm/NU010Hy6pLPXEflKC/Xs/Pq2QJXFl4lnn+VUUHIt6tzi2nLHYH7WV5/Ld29rwyzdyHlOXG97Ar7eXEqqRg22l1xgPZZLQrccRV2jjnOmtVRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KgbtX5Qq; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KgbtX5Qq"
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-846d1ba933eso156865241.2;
        Thu, 05 Sep 2024 03:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725531292; x=1726136092; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BZqvfaDn0uYu3ziPPzK+s7msOSRy6Nfa0FRVsEZi0pY=;
        b=KgbtX5QqVULl4USWVSJRgSSWnzPVP3NRV0BJzSqQTyt1c2+2aPPUbk+VAsB8x5DLyb
         iG5b6mjWGKKNomI9RPoS/np69R3TDiLu6FqPZuTHk4JCPHUJo5QvA2rU9FNOra19XMRU
         nZ2i9fwC7Nb2TO1jZ03nsZ1FzMd3X0iHi4gTz7xG2/2EOD86tzkPrz+XhDFMMWOMLxug
         i4ZvwKsD+2AaY6MiRI9PRxOHslgQdm2XPDJavhwhIxJ+RdTwsHl1XUIb5ENt3rDn6jx5
         NoeClN1NnZT5fHZmRDFko8nr5ud0bbr3K8X1zcx02K0kFejQzEvpkJx2iu800p/GHSsn
         PlPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725531292; x=1726136092;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BZqvfaDn0uYu3ziPPzK+s7msOSRy6Nfa0FRVsEZi0pY=;
        b=OKll3XlPA5lnrrAAOlUsNNzA9KgPuKU3hPvectcii4oOXQEtLjL82uGd3wGGoGhuxu
         xlI5/0o2/YQb4kg2+8uNMKUvK39UZ97YWpTdi+JQOm175T+/PkWbVah0NNrymyqTMf+/
         7saxwaHR5Tm5NAlJnWYYxoco0FLnpUmiFztq4Y1ZRYubxBvJwzU7VNOHZ5hed1mw0oYx
         pvFyUbUWW52vaf3tJjFldOAIkdrQ10oTnr2rsW9whrT9Q9/q3BAbYJoy1Dki/VJXYMUQ
         4C/dPEHU+YnAX0uaupY2iSrVTqQz5Kgld5TuL4/lkfxF70KXMQP+LAv+OJJuQzjBoAnH
         8hOw==
X-Forwarded-Encrypted: i=1; AJvYcCU2Hx65X8jQdx514faUWuYbe1jVX8cMaHclRRupSNzShyleVad1OOfldG7TTfO0EU1ISCLqBRgtfB8I@vger.kernel.org, AJvYcCWga3OMjk8fYbNWSH3gLTMLhHHit7x93ZgZJLOuhs1JhEE6RkF5gR3PP2FgLN2APXfqDFk1bwGwcNNLa9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YweesnXKoO0vObzPUClFh0U5amW4uRgBi2HEDPuJyMUkV5kawfN
	/5LfsQStiTnUsnq2po6Nvvd1/oSY2ttAfJyFpVTj7igE2g9ut88O3YCHPsrBB4WNgXQeXNa/vd/
	cS6NftqKYPbEdaN7zwFrCz9HIMoQ=
X-Google-Smtp-Source: AGHT+IHUASNnsd9/qFe37m9DukhjnzVEgGjoMn6KfvUbIe5HKKuZZ9al1i3QE9pemhJaf1nVu7guCdRF+sQ4nMp+dCQ=
X-Received: by 2002:a05:6102:3909:b0:498:e7fc:d273 with SMTP id
 ada2fe7eead31-49a779b9db0mr16269973137.18.1725531292318; Thu, 05 Sep 2024
 03:14:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829101539.5058-1-victorshihgli@gmail.com>
 <20240829101539.5058-22-victorshihgli@gmail.com> <1bf5c397-5d07-4bd5-a769-e10751bb0da2@intel.com>
In-Reply-To: <1bf5c397-5d07-4bd5-a769-e10751bb0da2@intel.com>
From: Victor Shih <victorshihgli@gmail.com>
Date: Thu, 5 Sep 2024 18:14:40 +0800
Message-ID: <CAK00qKCh-ey0reNwgXUYXPu=gyw-JZjYBEGUNOUXPXbp434j=w@mail.gmail.com>
Subject: Re: [PATCH V19 21/22] mmc: sdhci-pci-gli: enable UHS-II mode for GL9755
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, benchuanggli@gmail.com, 
	Lucas.Lai@genesyslogic.com.tw, HL.Liu@genesyslogic.com.tw, 
	Greg.tu@genesyslogic.com.tw, dlunev@chromium.org, 
	Ben Chuang <ben.chuang@genesyslogic.com.tw>, 
	AKASHI Takahiro <takahiro.akashi@linaro.org>, Victor Shih <victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 3, 2024 at 2:40=E2=80=AFAM Adrian Hunter <adrian.hunter@intel.c=
om> wrote:
>
> On 29/08/24 13:15, Victor Shih wrote:
> > From: Victor Shih <victor.shih@genesyslogic.com.tw>
> >
> > Changes are:
> >  * Disable GL9755 overcurrent interrupt when power on/off on UHS-II.
> >  * Enable the internal clock when do reset on UHS-II mode.
> >  * Increase timeout value before detecting UHS-II interface.
> >  * Add vendor settings fro UHS-II mode.
> >
> > Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> > Signed-off-by: Lucas Lai <lucas.lai@genesyslogic.com.tw>
> > ---
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
> >  drivers/mmc/host/sdhci-pci-gli.c | 230 ++++++++++++++++++++++++++++++-
> >  1 file changed, 229 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-=
pci-gli.c
> > index 0f81586a19df..e826e02a0d52 100644
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
> > @@ -779,6 +807,198 @@ static void gl9755_hw_setting(struct sdhci_pci_sl=
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
> > +     u16 clk_ctrl;
> > +     u16 ctrl2;
> > +
> > +     ctrl2 =3D sdhci_readw(host, SDHCI_HOST_CONTROL2);
> > +     clk_ctrl =3D sdhci_readw(host, SDHCI_CLOCK_CONTROL);
>
> clk_ctrl is not used?
>

Hi, Adrian

I will update this in the next version.

Thanks, Victor Shih

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
> > +     u8 rst;
> > +
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
> > +     /* hw clears the bit when it's done */
> > +     if (read_poll_timeout_atomic(sdhci_readb, rst, !(rst & mask),
> > +                                  10, 100000, false, host, SDHCI_SOFTW=
ARE_RESET)) {
> > +             pr_err("%s: Reset 0x%x never completed.\n", mmc_hostname(=
host->mmc), (int)mask);
> > +             sdhci_dumpregs(host);
> > +             /* manual clear */
> > +             sdhci_writeb(host, 0, SDHCI_SOFTWARE_RESET);
> > +             return;
> > +     }
> > +}
> > +
> >  static inline void gl9767_vhs_read(struct pci_dev *pdev)
> >  {
> >       u32 vhs_enable;
> > @@ -1086,6 +1306,7 @@ static int gli_probe_slot_gl9755(struct sdhci_pci=
_slot *slot)
> >       gli_pcie_enable_msi(slot);
> >       slot->host->mmc->caps2 |=3D MMC_CAP2_NO_SDIO;
> >       sdhci_enable_v4_mode(host);
> > +     gl9755_vendor_init(host);
> >
> >       return 0;
> >  }
> > @@ -1524,17 +1745,24 @@ static const struct sdhci_ops sdhci_gl9755_ops =
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
