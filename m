Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778EF1AAE33;
	Thu, 20 Jun 2024 10:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718879977; cv=none; b=e3iQ/TSMlJRlQWmCAFT5SxkqCeOHA82dWV1u3D/dVatFPV2NRsjWmK5HtetkkCA63NX9yYzGpytR13JWEpsJ99kcP/BTyB5A/ScyvaJDjnnIzSHWWXZf+7jqBpl5DIrs2oO2h645ZywRL+788BxqZDtxejtNyIVJeoNljoMg8lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718879977; c=relaxed/simple;
	bh=A0Xz103TpTfJHJ+WJDmvIT3nZleSQDtRtBsxEzKc4+4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m9opJIf9OfG9Hp0Ii5AYiE+ahIeX/h4JhI9fbqkmdwJ9KJzU7DwvD3mKySnTRBKfGsV7jFyRu+kDMWTKIH+zOuVRtbh7A3yIFRk++o7iFhzmi1BwQgnHwFPI8OiviGwsKjvG+Rq5UXgdCMRpoBfSApvbFPrH4ggujEB7/w/IFFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FaHREBXM; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FaHREBXM"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-4e4efbc3218so260191e0c.0;
        Thu, 20 Jun 2024 03:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718879974; x=1719484774; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vi/spQT/Db8a4vF1Dc5UjNjRb1jH5UJsV/snCkfL6ks=;
        b=FaHREBXMoqKxdX+JFA6gbjedfVZEy/dFK9RMD227+Fi7Jj887UQ/MTkTMx1Or5xCMZ
         C+ZpfymVr7S4OodrkcZLcOotUD/wecsJCmPTSFtGrSCYZhFjNv5RTGX2OqiITwQUYWeC
         f/BkYxmg1K0Yrc6lxcFhTkeVFCmpwA6tX5h8E/cg/i3TL18HsokUh6a8PBzQv4A7My7D
         fp6C8fP5pfJ3Tyv3rebjF0uaC8k0y3JkqCbkarg+ZwFnPpBixduQ6Br2dl9MyOLGbNgj
         OWCvkWpNT9M7pvQhQMz0tno7cNa/4pqzgacBb8ThNaVCGUDTEkbaQJzv11tt3UHMpkUY
         n+YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718879974; x=1719484774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vi/spQT/Db8a4vF1Dc5UjNjRb1jH5UJsV/snCkfL6ks=;
        b=n+9hZ319si7e9KAGSMbjlP5dXgRgE+MipkLDip9VsZ3cn2y6SSAXnfsDkuyvmCukHt
         AjZUydu7ZgekezJhEqrv8yj/21nyiysJSUeJLtOWQwyih/H8mYn1iHu6wPPTLOn6oDgr
         m9OyRoyD82aZt6AhzPAyLI2I30Nz790EYx5kRk5Tiw0fewcJOQnicdfXsGOOQHaLGtBx
         56gEEs8/wDtcxkpo0DfPwRzPDVccZAo4B38anFyQ5j18+gMT0gMXWhqNQPtgUHocRfnQ
         1XYOPq/sgkJmK4fwGfekvZNre7hfTjWQ+WTGhy3XiSh/xx+G9NhJvzVFDtEDznD8T4Br
         xuMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUluj0Hk1vOzkuG4zABj44n024qSFYCugDajiPwzl7UeYFRgNY14TKJAx5KgyjciOz8PnGH7LVCav6etMKfDaVIEB8FuCy5B1b4GzcO
X-Gm-Message-State: AOJu0YwO0PR460qjTidcwNK+nFD6w9d4/8MSb+p8/6HHyhcwHeVo6CNt
	VeXgzWIzfXVOeag8hyNOzRcq4qLOqRrIR/qhzeoDCT49V+wOdOjnedtHTjphUaWMKo0tyGvXv2p
	uRy9uxWDidCWprNHsjQ6nxtyCO9m0gv6x
X-Google-Smtp-Source: AGHT+IG9W4xhAk0iUlQ+I6RzRMgGFuNM5rmBUNE/1Eh1hXerKxZfPEnedKzaWd9XWNTqqXkVz+jM2YYtNiWDjeq4+AQ=
X-Received: by 2002:a05:6122:459d:b0:4d3:cff6:79f0 with SMTP id
 71dfb90a1353d-4ef276f767cmr5550250e0c.4.1718879972760; Thu, 20 Jun 2024
 03:39:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240522110909.10060-1-victorshihgli@gmail.com>
 <20240522110909.10060-13-victorshihgli@gmail.com> <42f2b1d4-e6c2-4860-956d-4f10c3b05529@intel.com>
 <CAK00qKBA81zx=QmU7m=pZXOzdY4syOht4p_-SU7fdw+-an0ciQ@mail.gmail.com> <a4542d2a-490f-40ab-a2a8-a42b921d2656@intel.com>
In-Reply-To: <a4542d2a-490f-40ab-a2a8-a42b921d2656@intel.com>
From: Victor Shih <victorshihgli@gmail.com>
Date: Thu, 20 Jun 2024 18:39:20 +0800
Message-ID: <CAK00qKBmH5fRMDBH_NwJTvGFLU2pw7fXy6Ni4FnB2X4WjeXb-A@mail.gmail.com>
Subject: Re: [PATCH V16 12/23] mmc: sdhci-uhs2: add reset function function
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw, 
	Greg.tu@genesyslogic.com.tw, dlunev@chromium.org, 
	Ben Chuang <ben.chuang@genesyslogic.com.tw>, 
	Victor Shih <victor.shih@genesyslogic.com.tw>, ulf.hansson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 7:25=E2=80=AFPM Adrian Hunter <adrian.hunter@intel.=
com> wrote:
>
> On 31/05/24 13:32, Victor Shih wrote:
> > On Fri, May 24, 2024 at 3:23=E2=80=AFPM Adrian Hunter <adrian.hunter@in=
tel.com> wrote:
> >>
> >> On 22/05/24 14:08, Victor Shih wrote:
> >>> From: Victor Shih <victor.shih@genesyslogic.com.tw>
> >>>
> >>> Sdhci_uhs2_reset() does a UHS-II specific reset operation.
> >>>
> >>> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> >>> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> >>> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> >>> ---
> >>>
> >>> Updates in V15:
> >>>  - Refer the SD Host Controller Standard Specification Section 3.10
> >>>    to add reset command data mechanism.
> >>>
> >>> Updates in V14:
> >>>  - Since mmc_card_uhs2() is the same as sdhci_uhs2_mode(), so drop
> >>>    sdhci_uhs2_mode() and use mmc_card_uhs2() instead of sdhci_uhs2_mo=
de().
> >>>
> >>> Updates in V13:
> >>>  - Use ios timing to stead MMC_UHS2_SUPPORT for indicate the UHS2 mod=
e.
> >>>
> >>> Updates in V8:
> >>>  - Adjust the position of matching brackets.
> >>>
> >>> Updates in V6:
> >>>  - Remove unnecessary functions and simplify code.
> >>>
> >>> ---
> >>>
> >>>  drivers/mmc/host/sdhci-uhs2.c | 57 +++++++++++++++++++++++++++++++++=
++
> >>>  drivers/mmc/host/sdhci-uhs2.h |  1 +
> >>>  drivers/mmc/host/sdhci.c      |  3 +-
> >>>  drivers/mmc/host/sdhci.h      |  1 +
> >>>  4 files changed, 61 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-u=
hs2.c
> >>> index 9cb0f1b2a37d..7652158ea151 100644
> >>> --- a/drivers/mmc/host/sdhci-uhs2.c
> >>> +++ b/drivers/mmc/host/sdhci-uhs2.c
> >>> @@ -10,7 +10,9 @@
> >>>   *  Author: AKASHI Takahiro <takahiro.akashi@linaro.org>
> >>>   */
> >>>
> >>> +#include <linux/delay.h>
> >>>  #include <linux/module.h>
> >>> +#include <linux/iopoll.h>
> >>>
> >>>  #include "sdhci.h"
> >>>  #include "sdhci-uhs2.h"
> >>> @@ -21,6 +23,8 @@
> >>>  #define SDHCI_UHS2_DUMP(f, x...) \
> >>>       pr_err("%s: " DRIVER_NAME ": " f, mmc_hostname(host->mmc), ## x=
)
> >>>
> >>> +#define UHS2_RESET_TIMEOUT_100MS             100000
> >>> +
> >>>  void sdhci_uhs2_dump_regs(struct sdhci_host *host)
> >>>  {
> >>>       if (!(mmc_card_uhs2(host->mmc)))
> >>> @@ -49,6 +53,57 @@ void sdhci_uhs2_dump_regs(struct sdhci_host *host)
> >>>  }
> >>>  EXPORT_SYMBOL_GPL(sdhci_uhs2_dump_regs);
> >>>
> >>> +/*******************************************************************=
**********\
> >>> + *                                                                  =
         *
> >>> + * Low level functions                                              =
         *
> >>> + *                                                                  =
         *
> >>> +\*******************************************************************=
**********/
> >>> +
> >>> +/**
> >>> + * sdhci_uhs2_reset - invoke SW reset
> >>> + * @host: SDHCI host
> >>> + * @mask: Control mask
> >>> + *
> >>> + * Invoke SW reset, depending on a bit in @mask and wait for complet=
ion.
> >>> + */
> >>> +void sdhci_uhs2_reset(struct sdhci_host *host, u16 mask)
> >>> +{
> >>> +     u32 val;
> >>> +
> >>> +     sdhci_writew(host, mask, SDHCI_UHS2_SW_RESET);
> >>> +
> >>> +     if (mask & SDHCI_UHS2_SW_RESET_FULL)
> >>> +             host->clock =3D 0;
> >>> +
> >>> +     /* hw clears the bit when it's done */
> >>> +     if (read_poll_timeout_atomic(sdhci_readw, val, !(val & mask), 1=
0,
> >>> +                                  UHS2_RESET_TIMEOUT_100MS, true, ho=
st, SDHCI_UHS2_SW_RESET)) {
> >>> +             pr_warn("%s: %s: Reset 0x%x never completed. %s: clean =
reset bit.\n", __func__,
> >>> +                     mmc_hostname(host->mmc), (int)mask, mmc_hostnam=
e(host->mmc));
> >>> +             sdhci_writeb(host, 0, SDHCI_UHS2_SW_RESET);
> >>> +             return;
> >>> +     }
> >>> +}
> >>> +EXPORT_SYMBOL_GPL(sdhci_uhs2_reset);
> >>> +
> >>> +static void sdhci_uhs2_reset_cmd_data(struct mmc_host *mmc)
> >>> +{
> >>> +     struct sdhci_host *host =3D mmc_priv(mmc);
> >>> +
> >>> +     sdhci_do_reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
> >>> +
> >>> +     if (host->mmc->ios.timing =3D=3D MMC_TIMING_UHS2_SPEED_A ||
> >>> +         host->mmc->ios.timing =3D=3D MMC_TIMING_UHS2_SPEED_A_HD ||
> >>> +         host->mmc->ios.timing =3D=3D MMC_TIMING_UHS2_SPEED_B ||
> >>> +         host->mmc->ios.timing =3D=3D MMC_TIMING_UHS2_SPEED_B_HD) {
> >>
> >> Please use mmc_card_uhs2()
> >>
> >
> > Hi, Adrian
> >
> >      I will update this in the v17 version.
> >
> > Thanks, Victor Shih
> >
> >>> +             sdhci_uhs2_reset(host, SDHCI_UHS2_SW_RESET_SD);
> >>> +
> >>> +             sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
> >>> +             sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
> >>> +             sdhci_uhs2_clear_set_irqs(host, SDHCI_INT_ALL_MASK, SDH=
CI_UHS2_INT_ERROR_MASK);
> >>> +     }
> >>> +}
> >>> +
> >>>  /*******************************************************************=
**********\
> >>>   *                                                                  =
         *
> >>>   * Driver init/exit                                                 =
         *
> >>> @@ -57,6 +112,8 @@ EXPORT_SYMBOL_GPL(sdhci_uhs2_dump_regs);
> >>>
> >>>  static int sdhci_uhs2_host_ops_init(struct sdhci_host *host)
> >>>  {
> >>> +     host->mmc_host_ops.uhs2_reset_cmd_data =3D sdhci_uhs2_reset_cmd=
_data;
> >>
> >> As noted for patch 8, any host controller resets needed
> >> should be done before completing the request, so a call
> >> back function should not be needed.
> >>
> >
> > Hi, Adrian
> >
> >      I want to confirm further, so can I call
> > sdhci_uhs2_reset_cmd_data() directly
> >      in the mmc_wait_for_req_done()?
>
> No
>
> >      Am I understanding something wrong?
>
> See the response to your questions over patch 8.
>

Hi, Adrian

I will update the discussion in the patch 8 into patch series v17.

Thanks, Victor Shih

> >
> > Thanks, Victor Shih
> >
> >>> +
> >>>       return 0;
> >>>  }
> >>>
> >>> diff --git a/drivers/mmc/host/sdhci-uhs2.h b/drivers/mmc/host/sdhci-u=
hs2.h
> >>> index 2bfe18d29bca..caaf9fba4975 100644
> >>> --- a/drivers/mmc/host/sdhci-uhs2.h
> >>> +++ b/drivers/mmc/host/sdhci-uhs2.h
> >>> @@ -177,5 +177,6 @@
> >>>  struct sdhci_host;
> >>>
> >>>  void sdhci_uhs2_dump_regs(struct sdhci_host *host);
> >>> +void sdhci_uhs2_reset(struct sdhci_host *host, u16 mask);
> >>>
> >>>  #endif /* __SDHCI_UHS2_H */
> >>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> >>> index 8fc3e001db74..f212da6dc2aa 100644
> >>> --- a/drivers/mmc/host/sdhci.c
> >>> +++ b/drivers/mmc/host/sdhci.c
> >>> @@ -236,7 +236,7 @@ void sdhci_reset(struct sdhci_host *host, u8 mask=
)
> >>>  }
> >>>  EXPORT_SYMBOL_GPL(sdhci_reset);
> >>>
> >>> -static bool sdhci_do_reset(struct sdhci_host *host, u8 mask)
> >>> +bool sdhci_do_reset(struct sdhci_host *host, u8 mask)
> >>>  {
> >>>       if (host->quirks & SDHCI_QUIRK_NO_CARD_NO_RESET) {
> >>>               struct mmc_host *mmc =3D host->mmc;
> >>> @@ -249,6 +249,7 @@ static bool sdhci_do_reset(struct sdhci_host *hos=
t, u8 mask)
> >>>
> >>>       return true;
> >>>  }
> >>> +EXPORT_SYMBOL_GPL(sdhci_do_reset);
> >>>
> >>>  static void sdhci_reset_for_all(struct sdhci_host *host)
> >>>  {
> >>> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> >>> index 13703f1a3710..83d994c8d89e 100644
> >>> --- a/drivers/mmc/host/sdhci.h
> >>> +++ b/drivers/mmc/host/sdhci.h
> >>> @@ -845,6 +845,7 @@ void sdhci_request(struct mmc_host *mmc, struct m=
mc_request *mrq);
> >>>  int sdhci_request_atomic(struct mmc_host *mmc, struct mmc_request *m=
rq);
> >>>  void sdhci_set_bus_width(struct sdhci_host *host, int width);
> >>>  void sdhci_reset(struct sdhci_host *host, u8 mask);
> >>> +bool sdhci_do_reset(struct sdhci_host *host, u8 mask);
> >>>  void sdhci_set_uhs_signaling(struct sdhci_host *host, unsigned timin=
g);
> >>>  int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode);
> >>>  int __sdhci_execute_tuning(struct sdhci_host *host, u32 opcode);
> >>
>
