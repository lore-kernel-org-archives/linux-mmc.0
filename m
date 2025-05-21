Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7892609D4;
	Wed, 21 May 2025 10:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747824346; cv=none; b=q4fGZHKpMr42LnFfHG3IcaJ8MsEmSSDXf2NmGiQAh4VH9yUKhbGuxl+LgRKvGBWEw4aQ3sbKCunoKi79EcFuV7KRjzHXzfZs87kH/D468lX0mG8ex1MVQj6FqzpOGmEuFuH9JrwE84OrRYDDwi0MSbL3QZx1BAl3oEXMv6iXEUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747824346; c=relaxed/simple;
	bh=4YmyGzWUO0u7I3pihFXAa3rQdETV8dc9AbOpV4uIFYs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b/apr/eQrTJcgV6pYOPzD1fBD+kUGi1vMMYmwVdwP/kMLTcoixCyGPMiHOkmaCZf9R42126Qf+E6fRtTn/A87F3d+ohuuNt7pVOnvm5j2jY0tntWrna8Cvp6ihvMH1AiVZQ8uXTrowOxML8a6cX2ZSFQwywDw8JRLRdZg1N8GJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C1f00h+U; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C1f00h+U"
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-87bf0cb66b1so1390433241.1;
        Wed, 21 May 2025 03:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747824344; x=1748429144; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eenI0BB/ezUYa2kf94KIjYliXbGesVJV1B4nFrddn2U=;
        b=C1f00h+UCgUcFMCymGW1xHC9CMj3mSF2qF7nnwywpdAfg4XAkBZ4gED4Y+vpjrBCyD
         LFR4tm2WxfLXSH4WzIw2eYShLikKUgW6er/1ZjZW1OPGwlMpLOEkHvfEH2azopNYNYyz
         3vu31IkLtlckFA8fzLunCxw6E3nKytRvaw/jcwEbMoKgwJyltTzsWBETau7APGDKW2Yi
         E6aJQpmuzPtWCSMlqaC44JpZVviW4oPnIO/SLNl9RJzUn6ahIHbDbgHSh1A/kEM1antn
         qZOI5xR3WmiIhKJlrDiNM4JtkiAV3sXRA2NTI5iQg3zbFV0W0F+hHlNwGERrNhGzh697
         Zxuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747824344; x=1748429144;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eenI0BB/ezUYa2kf94KIjYliXbGesVJV1B4nFrddn2U=;
        b=kTcKjDHUEaP4sazZE2FqfPNqLW9XXorEjjJHcRMA+RsEDTgNbYvvU3BZ1wlxbr/WMo
         zsU2cXkGNNc9gzvMWzsFXjaiMEgVSxyxBMxbySwdMD6ooSqKG++0RsbVI8Lz6b5j9Mvx
         DYIv8QzFcMZ9SiQJToLaMk2L2mApmPIg7SDZFKBFh77EHxDcAT/bX5ljk4mlt2RZ4pWK
         2TUbT+4J3EO39ZH/iYak5Y/ItqJ/VRpuF1gKTh1GDx/8FeCiCeAkVxj8M9znW+svt0gD
         ZY7emeMOo+H1bG4RYXhANkeo+5Pc3AfaV1PVgpr48sUYOU0OT6zjJ3YBIWCjxVTL3pzz
         2yoA==
X-Forwarded-Encrypted: i=1; AJvYcCWr/zKffh/+l9+1OZa+non8Shch0I8RAv7E7AQ9URtCRAwgpYhxuZcTOea4+RyRobpulXmL/fDCChmZtzo=@vger.kernel.org, AJvYcCXQbSx//Bsal/WaDrLIhEAaMdUu8WiBaIAnbPtM7CZ0ILAYh5cmGxe1Wwg4GSibeYUzdJVwi/S9COow@vger.kernel.org
X-Gm-Message-State: AOJu0YwPoTXAZVjZw0GnmeytgZniuLjWQY3d7y4IMwX48DxqBc/eB1bW
	WWe36ZytT8m5dm26NTktAtoSHdPMDfy7BN/EI7oAcgAVaLidnVvSvISGrLUyxL8SZxCGQEC6c+q
	23fm0eLO32ZQxQYtx+l6uDQW1yF9Zko8=
X-Gm-Gg: ASbGnctjdjcCeMwBoIevC66c1rHxxz6p7D3Yw9fMPk2SBXNnGSGFXVk+98DkF4BCwHd
	J1oaNB3JnT859WPPIDDqla4vrLvAHywKQVAo7Ux8GeiOrka+dBuhov9uzllq2zTcWpiSCwGTQV7
	D6qo3bgvHNlWWVkNZKrzIurocptVc2/KMTDLpnsRHuiYBDtDp797wqmOOGKS2IK3HBhA==
X-Google-Smtp-Source: AGHT+IE1idR3INf7XtwzYnYUtkIB+AT4PurdzcHOPXM6rIOeEiM8IsG27TNjFdC1MrHZypDDGayfN9M4rdmHSS3MqUg=
X-Received: by 2002:a67:ef4a:0:b0:4e1:263c:c422 with SMTP id
 ada2fe7eead31-4e1264c3184mr14078971137.11.1747824343499; Wed, 21 May 2025
 03:45:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250516092716.3918-1-victorshihgli@gmail.com>
 <20250516092716.3918-3-victorshihgli@gmail.com> <CAPDyKFqCo2-9fYYAoNpmJf7XOiTvLM07hQks1io-S0MvmbAjCQ@mail.gmail.com>
In-Reply-To: <CAPDyKFqCo2-9fYYAoNpmJf7XOiTvLM07hQks1io-S0MvmbAjCQ@mail.gmail.com>
From: Victor Shih <victorshihgli@gmail.com>
Date: Wed, 21 May 2025 18:45:31 +0800
X-Gm-Features: AX0GCFusqpFzmYiuNKDKzrYWd7bt4LxKHYjOKr0plDaEbf1Fai1DfMwtHjiHNIM
Message-ID: <CAK00qKAEN9+aA_7_YEGjjgovNG78du7+wmMyB4D0jZjzzcFNbA@mail.gmail.com>
Subject: Re: [PATCH V1 2/2] mmc: sdhci-uhs2: Adjust some error messages and
 register dump for SD UHS-II card
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: adrian.hunter@intel.com, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, benchuanggli@gmail.com, 
	HL.Liu@genesyslogic.com.tw, Greg.tu@genesyslogic.com.tw, 
	Ben Chuang <ben.chuang@genesyslogic.com.tw>, 
	Victor Shih <victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 19, 2025 at 8:25=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org=
> wrote:
>
> On Fri, 16 May 2025 at 11:27, Victor Shih <victorshihgli@gmail.com> wrote=
:
> >
> > From: Victor Shih <victor.shih@genesyslogic.com.tw>
> >
> > Adjust some error messages to debug mode and register dump to dynamic
> > debug mode to avoid causing misunderstanding it is an error.
>
> Dumping the register may be useful for the debug level, I am not sure.
> Maybe Adrian has an opinion?
>
> >
> > Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> > ---
> >  drivers/mmc/host/sdhci-uhs2.c | 18 +++++++++---------
> >  drivers/mmc/host/sdhci.h      | 16 ++++++++++++++++
> >  2 files changed, 25 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs=
2.c
> > index c53b64d50c0d..9ff867aee985 100644
> > --- a/drivers/mmc/host/sdhci-uhs2.c
> > +++ b/drivers/mmc/host/sdhci-uhs2.c
> > @@ -99,8 +99,8 @@ void sdhci_uhs2_reset(struct sdhci_host *host, u16 ma=
sk)
> >         /* hw clears the bit when it's done */
> >         if (read_poll_timeout_atomic(sdhci_readw, val, !(val & mask), 1=
0,
> >                                      UHS2_RESET_TIMEOUT_100MS, true, ho=
st, SDHCI_UHS2_SW_RESET)) {
> > -               pr_warn("%s: %s: Reset 0x%x never completed. %s: clean =
reset bit.\n", __func__,
> > -                       mmc_hostname(host->mmc), (int)mask, mmc_hostnam=
e(host->mmc));
> > +               DBG("%s: %s: Reset 0x%x never completed. %s: clean rese=
t bit.\n", __func__,
> > +                   mmc_hostname(host->mmc), (int)mask, mmc_hostname(ho=
st->mmc));
>
> As I said on patch1, please use pr_debug() and drop the macro.
>

Hi, Ulf

This macro has been defined in previous patches not the first time it
has appeared here,
are we still going to drop this macro?

Thanks, Victor Shih

> >                 sdhci_writeb(host, 0, SDHCI_UHS2_SW_RESET);
> >                 return;
> >         }
> > @@ -335,8 +335,8 @@ static int sdhci_uhs2_interface_detect(struct sdhci=
_host *host)
> >         if (read_poll_timeout(sdhci_readl, val, (val & SDHCI_UHS2_IF_DE=
TECT),
> >                               100, UHS2_INTERFACE_DETECT_TIMEOUT_100MS,=
 true,
> >                               host, SDHCI_PRESENT_STATE)) {
> > -               pr_warn("%s: not detect UHS2 interface in 100ms.\n", mm=
c_hostname(host->mmc));
> > -               sdhci_dumpregs(host);
> > +               DBG("%s: not detect UHS2 interface in 100ms.\n", mmc_ho=
stname(host->mmc));
> > +               sdhci_dbg_dumpregs(host, "UHS2 interface detect timeout=
 in 100ms");
>
> If we really need this, I think we should first introduce the helper
> function in a separate patch, that precedes $subject patch in the
> series.
>

Hi, Ulf

Ok, I will make this helper function into a separate patch in the next vers=
ion.

Thanks, Victor Shih

> >                 return -EIO;
> >         }
> >
> > @@ -345,8 +345,8 @@ static int sdhci_uhs2_interface_detect(struct sdhci=
_host *host)
> >
> >         if (read_poll_timeout(sdhci_readl, val, (val & SDHCI_UHS2_LANE_=
SYNC),
> >                               100, UHS2_LANE_SYNC_TIMEOUT_150MS, true, =
host, SDHCI_PRESENT_STATE)) {
> > -               pr_warn("%s: UHS2 Lane sync fail in 150ms.\n", mmc_host=
name(host->mmc));
> > -               sdhci_dumpregs(host);
> > +               DBG("%s: UHS2 Lane sync fail in 150ms.\n", mmc_hostname=
(host->mmc));
> > +               sdhci_dbg_dumpregs(host, "UHS2 Lane sync fail in 150ms"=
);
> >                 return -EIO;
> >         }
> >
> > @@ -417,12 +417,12 @@ static int sdhci_uhs2_do_detect_init(struct mmc_h=
ost *mmc)
> >                 host->ops->uhs2_pre_detect_init(host);
> >
> >         if (sdhci_uhs2_interface_detect(host)) {
> > -               pr_warn("%s: cannot detect UHS2 interface.\n", mmc_host=
name(host->mmc));
> > +               DBG("%s: cannot detect UHS2 interface.\n", mmc_hostname=
(host->mmc));
> >                 return -EIO;
> >         }
> >
> >         if (sdhci_uhs2_init(host)) {
> > -               pr_warn("%s: UHS2 init fail.\n", mmc_hostname(host->mmc=
));
> > +               DBG("%s: UHS2 init fail.\n", mmc_hostname(host->mmc));
> >                 return -EIO;
> >         }
> >
> > @@ -504,7 +504,7 @@ static int sdhci_uhs2_check_dormant(struct sdhci_ho=
st *host)
> >         if (read_poll_timeout(sdhci_readl, val, (val & SDHCI_UHS2_IN_DO=
RMANT_STATE),
> >                               100, UHS2_CHECK_DORMANT_TIMEOUT_100MS, tr=
ue, host,
> >                               SDHCI_PRESENT_STATE)) {
> > -               pr_warn("%s: UHS2 IN_DORMANT fail in 100ms.\n", mmc_hos=
tname(host->mmc));
> > +               DBG("%s: UHS2 IN_DORMANT fail in 100ms.\n", mmc_hostnam=
e(host->mmc));
> >                 sdhci_dumpregs(host);
> >                 return -EIO;
> >         }
> > diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> > index cd0e35a80542..2c28240e6003 100644
> > --- a/drivers/mmc/host/sdhci.h
> > +++ b/drivers/mmc/host/sdhci.h
> > @@ -898,4 +898,20 @@ void sdhci_switch_external_dma(struct sdhci_host *=
host, bool en);
> >  void sdhci_set_data_timeout_irq(struct sdhci_host *host, bool enable);
> >  void __sdhci_set_timeout(struct sdhci_host *host, struct mmc_command *=
cmd);
> >
> > +#if defined(CONFIG_DYNAMIC_DEBUG) || \
> > +       (defined(CONFIG_DYNAMIC_DEBUG_CORE) && defined(DYNAMIC_DEBUG_MO=
DULE))
> > +#define SDHCI_DBG_ANYWAY 0
> > +#elif defined(DEBUG)
> > +#define SDHCI_DBG_ANYWAY 1
> > +#else
> > +#define SDHCI_DBG_ANYWAY 0
> > +#endif
> > +
> > +#define sdhci_dbg_dumpregs(host, fmt)                                 =
 \
> > +do {                                                                  =
 \
> > +       DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, fmt);                =
 \
> > +       if (DYNAMIC_DEBUG_BRANCH(descriptor) || SDHCI_DBG_ANYWAY)      =
 \
> > +               sdhci_dumpregs(host);                                  =
 \
> > +} while (0)
> > +
> >  #endif /* __SDHCI_HW_H */
> > --
> > 2.43.0
> >
>
> Kind regards
> Uffe
