Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF902C3242;
	Fri,  6 Jun 2025 10:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749205983; cv=none; b=kNowh+Ho+8CjdaxTPK6vZnLevVkoV6+D5MwwYwxaU+C/mMcigAkG+gWsroXa5PtiuoMLeNde+6hUzbCtMu0nZWWjTcnoCtZxXzjV+foA6Xwd34+a4siHiUe0fyJd/cxZhF4gvwOQIs57cT/cIoxbB5ebi7gXfEQOPSzp1+KCHC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749205983; c=relaxed/simple;
	bh=EWmGOY2fETYBex1yy7JXLNMgL5UaZwO+d6xDM+yA6e0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=frryZTqEWRwUv19O5AWMNw61u6t0UnMZW3TukSuPveKhYSzGFTPMAhxn0eYc1EvfgXN1q9pEWnFKIGDmnsoxNJrkpkHWXgVtW3SOO15GFXHwUjca/2k8m6WwGfeu/GRF9X5/yy6GmcvDuWOf2czgRPR5ofkrn5kIBf/BMUaGYOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BlNAwxvu; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BlNAwxvu"
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-4e45cfc3a26so1394467137.0;
        Fri, 06 Jun 2025 03:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749205980; x=1749810780; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MSCRtgJh3mrO0HRWQido0oMhIOru4mIvGKrAajD/acI=;
        b=BlNAwxvuHpX4hfRJypQKHlqlxXJA4jap2RDxYgXnURCbtBOss+ILN9pUyXBwRImxdk
         n6giTy1JIpyniLI6+oN8hltZ9z63Bg06TYp1FZk0rGOhd2m9XvoxJDPU6hJyKBKR0mcL
         ULlS+3cnR4qT8ovoYBCNche/0bwkUHwH8Zf4ryz5wdTKtL8fTuhPjQH0WHczCvCyKha9
         RjmPaC9xeKkmrwNY1G6u8ex/EutQAKsJ66NVb93lj5MBGVtDzPjoaevaEcl2C0X/ozSL
         FJqEgqnR9F0QSd1AKsuvA+NgK1l06PLVAAMcphxDdYBBHbsjOzXdipa84jqzY/TJuDsH
         V4TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749205980; x=1749810780;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MSCRtgJh3mrO0HRWQido0oMhIOru4mIvGKrAajD/acI=;
        b=qPVbIWHfZ5OI5WBnNkRyOgXHhNOd/D2c5PUse3jsKre8qHY3ry9JtkmuekpVz4NzPk
         P8ygVxjLdw7NdKOTAPt5WIW9vnwX7js+bvTooHxugRf+WUXr+XmlX1qR0tLLgDfRDbLu
         dxjizr2P54dUEBplw5ihi3Rg67yjdFSVQeML4kDtCbmTaONg6w2t2A8b0N05sVnsbcl4
         RFEcWX9G/S5f6q6eRrM5LYu5NaBgiEMOFKKOjIs0YjPGgQqflRl3SFRGnOdaQAsXWxWn
         Qdkh9vf7t7zwNKvIAfC0r7jQRSdsEoqxiS3+T3muLF+pa5NNejj1QSBpBiuIKTFYtUiL
         8zTg==
X-Forwarded-Encrypted: i=1; AJvYcCVQGHBZb0s5kPvh7rRwPGbXS/+AKOcANJ9EDxlB8v2Hq/7HH8zGYljNh5xFy71aAF862H7fZCMVt8pRYmc=@vger.kernel.org, AJvYcCVrVhUo7sXmfW1Y4bQH/WCTTLDoirP7/juFNzOXIHD6js+KmOiperJBR6ysRD/IL0UlpVpatWNJTAeG@vger.kernel.org
X-Gm-Message-State: AOJu0YzDyDFxZS3mV9pJo3/61eXHxbrlq9/Jt0MFofiAoyfFLqSryc+j
	yv5lSTYnbPzp778A5yUJiqbWqXPm6rIDz+5z4eFV3nj0aFSlqKNhnYi6v2h/BdMpxZ29R+qrqZ5
	d+kB0U6cprZBruGX6zYJfaEfXI2qouJ67gua7
X-Gm-Gg: ASbGnctVlY+6MrhW+Kr63y+LOOcrkmyn7ums1foahEAThRJy7vDEq6HseZbde4DNVBy
	WDFwG3JLjg2/Vqjob5QDDAr3BopcIDJ3y3gCN7FxkRg4xdj9JzTj4xnWNtMaoY8u6bWmdleOgwr
	gWhW1GInSPzSP/ypQM5TwJgsRyOGhgg0DdRmQqyz4KYz8IYSuVS71489dogpuvOdndmw==
X-Google-Smtp-Source: AGHT+IGOU9vZErXkR16hmHisOuyevRgplZOoNNGLBXXZWihYYDanMFHkCRIUkTwK/lR/zMYAuNMpHitCjxQNZcxLuYs=
X-Received: by 2002:a05:6122:338a:b0:530:ba70:cfc9 with SMTP id
 71dfb90a1353d-530e5025eb2mr2261725e0c.0.1749205969153; Fri, 06 Jun 2025
 03:32:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250523110155.10451-1-victorshihgli@gmail.com>
 <20250523110155.10451-3-victorshihgli@gmail.com> <20d2730f-1e1b-4f47-b208-201468e21029@intel.com>
In-Reply-To: <20d2730f-1e1b-4f47-b208-201468e21029@intel.com>
From: Victor Shih <victorshihgli@gmail.com>
Date: Fri, 6 Jun 2025 18:32:36 +0800
X-Gm-Features: AX0GCFuCsh_QPaMAcJWsev2oqyRwidon6gRsisjqQtww0hDLSd6tUsDIB2dWTJ4
Message-ID: <CAK00qKB3QZZjXFvwQazE7iYG_W-0PgsQzYWWTMKt8fAr5ePiyw@mail.gmail.com>
Subject: Re: [PATCH RESEND V2 2/2] mmc: sdhci-uhs2: Adjust some error messages
 and register dump for SD UHS-II card
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, benchuanggli@gmail.com, 
	HL.Liu@genesyslogic.com.tw, Greg.tu@genesyslogic.com.tw, 
	Ben.Chuang@genesyslogic.com.tw, Victor Shih <victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 28, 2025 at 8:10=E2=80=AFPM Adrian Hunter <adrian.hunter@intel.=
com> wrote:
>
> On 23/05/2025 14:01, Victor Shih wrote:
> > From: Victor Shih <victor.shih@genesyslogic.com.tw>
> >
> > Adjust some error messages to debug mode and register dump to dynamic
> > debug mode to avoid causing misunderstanding it is an error.
> >
> > Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
>
> I think Ulf asked for the drivers/mmc/host/sdhci.h change to be
> a separate patch.
>
> In any case:
>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
>

Hi, Adrian

I left this part out, I'll resend the patch for the new series to
match this thing,
and I will also keep your acked tag.

Thanks, Victor Shih

> > ---
> >  drivers/mmc/host/sdhci-uhs2.c | 20 ++++++++++----------
> >  drivers/mmc/host/sdhci.h      | 16 ++++++++++++++++
> >  2 files changed, 26 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs=
2.c
> > index c53b64d50c0d..0efeb9d0c376 100644
> > --- a/drivers/mmc/host/sdhci-uhs2.c
> > +++ b/drivers/mmc/host/sdhci-uhs2.c
> > @@ -99,8 +99,8 @@ void sdhci_uhs2_reset(struct sdhci_host *host, u16 ma=
sk)
> >       /* hw clears the bit when it's done */
> >       if (read_poll_timeout_atomic(sdhci_readw, val, !(val & mask), 10,
> >                                    UHS2_RESET_TIMEOUT_100MS, true, host=
, SDHCI_UHS2_SW_RESET)) {
> > -             pr_warn("%s: %s: Reset 0x%x never completed. %s: clean re=
set bit.\n", __func__,
> > -                     mmc_hostname(host->mmc), (int)mask, mmc_hostname(=
host->mmc));
> > +             pr_debug("%s: %s: Reset 0x%x never completed. %s: clean r=
eset bit.\n", __func__,
> > +                      mmc_hostname(host->mmc), (int)mask, mmc_hostname=
(host->mmc));
> >               sdhci_writeb(host, 0, SDHCI_UHS2_SW_RESET);
> >               return;
> >       }
> > @@ -335,8 +335,8 @@ static int sdhci_uhs2_interface_detect(struct sdhci=
_host *host)
> >       if (read_poll_timeout(sdhci_readl, val, (val & SDHCI_UHS2_IF_DETE=
CT),
> >                             100, UHS2_INTERFACE_DETECT_TIMEOUT_100MS, t=
rue,
> >                             host, SDHCI_PRESENT_STATE)) {
> > -             pr_warn("%s: not detect UHS2 interface in 100ms.\n", mmc_=
hostname(host->mmc));
> > -             sdhci_dumpregs(host);
> > +             pr_debug("%s: not detect UHS2 interface in 100ms.\n", mmc=
_hostname(host->mmc));
> > +             sdhci_dbg_dumpregs(host, "UHS2 interface detect timeout i=
n 100ms");
> >               return -EIO;
> >       }
> >
> > @@ -345,8 +345,8 @@ static int sdhci_uhs2_interface_detect(struct sdhci=
_host *host)
> >
> >       if (read_poll_timeout(sdhci_readl, val, (val & SDHCI_UHS2_LANE_SY=
NC),
> >                             100, UHS2_LANE_SYNC_TIMEOUT_150MS, true, ho=
st, SDHCI_PRESENT_STATE)) {
> > -             pr_warn("%s: UHS2 Lane sync fail in 150ms.\n", mmc_hostna=
me(host->mmc));
> > -             sdhci_dumpregs(host);
> > +             pr_debug("%s: UHS2 Lane sync fail in 150ms.\n", mmc_hostn=
ame(host->mmc));
> > +             sdhci_dbg_dumpregs(host, "UHS2 Lane sync fail in 150ms");
> >               return -EIO;
> >       }
> >
> > @@ -417,12 +417,12 @@ static int sdhci_uhs2_do_detect_init(struct mmc_h=
ost *mmc)
> >               host->ops->uhs2_pre_detect_init(host);
> >
> >       if (sdhci_uhs2_interface_detect(host)) {
> > -             pr_warn("%s: cannot detect UHS2 interface.\n", mmc_hostna=
me(host->mmc));
> > +             pr_debug("%s: cannot detect UHS2 interface.\n", mmc_hostn=
ame(host->mmc));
> >               return -EIO;
> >       }
> >
> >       if (sdhci_uhs2_init(host)) {
> > -             pr_warn("%s: UHS2 init fail.\n", mmc_hostname(host->mmc))=
;
> > +             pr_debug("%s: UHS2 init fail.\n", mmc_hostname(host->mmc)=
);
> >               return -EIO;
> >       }
> >
> > @@ -504,8 +504,8 @@ static int sdhci_uhs2_check_dormant(struct sdhci_ho=
st *host)
> >       if (read_poll_timeout(sdhci_readl, val, (val & SDHCI_UHS2_IN_DORM=
ANT_STATE),
> >                             100, UHS2_CHECK_DORMANT_TIMEOUT_100MS, true=
, host,
> >                             SDHCI_PRESENT_STATE)) {
> > -             pr_warn("%s: UHS2 IN_DORMANT fail in 100ms.\n", mmc_hostn=
ame(host->mmc));
> > -             sdhci_dumpregs(host);
> > +             pr_debug("%s: UHS2 IN_DORMANT fail in 100ms.\n", mmc_host=
name(host->mmc));
> > +             sdhci_dbg_dumpregs(host, "UHS2 IN_DORMANT fail in 100ms")=
;
> >               return -EIO;
> >       }
> >       return 0;
> > diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> > index f9d65dd0f2b2..70ada1857a4c 100644
> > --- a/drivers/mmc/host/sdhci.h
> > +++ b/drivers/mmc/host/sdhci.h
> > @@ -900,4 +900,20 @@ void sdhci_switch_external_dma(struct sdhci_host *=
host, bool en);
> >  void sdhci_set_data_timeout_irq(struct sdhci_host *host, bool enable);
> >  void __sdhci_set_timeout(struct sdhci_host *host, struct mmc_command *=
cmd);
> >
> > +#if defined(CONFIG_DYNAMIC_DEBUG) || \
> > +     (defined(CONFIG_DYNAMIC_DEBUG_CORE) && defined(DYNAMIC_DEBUG_MODU=
LE))
> > +#define SDHCI_DBG_ANYWAY 0
> > +#elif defined(DEBUG)
> > +#define SDHCI_DBG_ANYWAY 1
> > +#else
> > +#define SDHCI_DBG_ANYWAY 0
> > +#endif
> > +
> > +#define sdhci_dbg_dumpregs(host, fmt)                                 =
       \
> > +do {                                                                 \
> > +     DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, fmt);                 \
> > +     if (DYNAMIC_DEBUG_BRANCH(descriptor) || SDHCI_DBG_ANYWAY)       \
> > +             sdhci_dumpregs(host);                                   \
> > +} while (0)
> > +
> >  #endif /* __SDHCI_HW_H */
>
