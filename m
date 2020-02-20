Return-Path: <SRS0=5xTW=4I=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA5E8C11D09
	for <linux-mmc@archiver.kernel.org>; Thu, 20 Feb 2020 13:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C376C208C4
	for <linux-mmc@archiver.kernel.org>; Thu, 20 Feb 2020 13:43:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MOPvSlGH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbgBTNnb (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 20 Feb 2020 08:43:31 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:46255 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727298AbgBTNnb (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 20 Feb 2020 08:43:31 -0500
Received: by mail-vs1-f66.google.com with SMTP id t12so2648334vso.13
        for <linux-mmc@vger.kernel.org>; Thu, 20 Feb 2020 05:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VHEgUpty5OrcYJGxbPFH9uNYoAV1sH/e0iu6cPEMqFw=;
        b=MOPvSlGHs9vY9i1zxdZVYvRucN1GCv+wIlEmZNcxvOVJgWieyOuK5t2FgeWXlgssoI
         mgJD2DDeUXPTIpGdhTzqk5XirwmPaMk6CAwFKtPLAPWngvQpSx0wvzDZ3QBI5chjHIfO
         KlmT5z1qkHUZ1uy+lLfwhjvhlJoHtsQuwvRing9iIyS86tsUJYRObuuaZR1A4VsrYEWk
         CWwFljQX7WEAW5jj6YS8yCvSvpKPzB2Ug+lVXbgZ5JfB92mkizAVa2b/yNk21crOhZrc
         gnOIAvQqaXvxMxoOcpWkdq6mv+MYWKnMO5YcMjsRyGPJRrqW9wjWseT53Fo8heW6kC0g
         R9VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VHEgUpty5OrcYJGxbPFH9uNYoAV1sH/e0iu6cPEMqFw=;
        b=SHuRH5i2qMiTWZmm92Z+fEV1sla1SySe8tmpa2UsuJrGJcayV2Mt7/R5HjQP8l+hvR
         aNZOXwrWjKzuV5qJ9xefySzShRR+fiFIBKFkTQHS1cODivFf8XduXZdJVToT5spm0DBF
         L4+dhQjBCl/Qp7fu63eyjzSu39S+O+A5aPbhqs98zgJcuLYUM0xAlszsINhNVnHhI+SO
         a6DziuBkL1PJTuk0+Sae7ffZrC6sE5iP345vM07H89Bi1uD1jfXdZtbYecFiEQGaBnt3
         dkhbrn9h72lJR/hkYixBGkX7NK29ANAKebbOheD9AntE8WwNa5Pyg2GRr4iV4qjcfnsT
         b0fw==
X-Gm-Message-State: APjAAAVmuP28CClrNz6qdJ/wiEXmHpa9lD1BxJwHWKrJwB4phuk5+eHp
        MShd25TnDZSfYYPVCf+eFbHCLl3WflnMiHHKFe/yAA==
X-Google-Smtp-Source: APXvYqzAicYKMyJevIEntfrmo+/YD/iJAwDqnrwi2s9zzjbgZoib9lZtdmSkXq/LWZ2YjZVuv7nGnV3Vfctk+AI50NM=
X-Received: by 2002:a05:6102:22d6:: with SMTP id a22mr16400744vsh.191.1582206209871;
 Thu, 20 Feb 2020 05:43:29 -0800 (PST)
MIME-Version: 1.0
References: <20200211160321.22124-1-paul@crapouillou.net> <20200211160321.22124-4-paul@crapouillou.net>
 <CAPDyKFquXSB+ztXZQS4MPV20dRN_-CKJkmCF0A97pG+vJYRsbg@mail.gmail.com>
In-Reply-To: <CAPDyKFquXSB+ztXZQS4MPV20dRN_-CKJkmCF0A97pG+vJYRsbg@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 20 Feb 2020 14:42:52 +0100
Message-ID: <CAPDyKFrGTVZ9_d-rGDLiEJ-nxPhXtOmw5hTDekpt_+RNB2Sx2A@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] mmc: jz4740: Use pm_sleep_ptr() macro
To:     Paul Cercueil <paul@crapouillou.net>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        od@zcrc.me, Linux PM <linux-pm@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 20 Feb 2020 at 14:38, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Tue, 11 Feb 2020 at 17:03, Paul Cercueil <paul@crapouillou.net> wrote:
> >
> > Use the newly introduced pm_sleep_ptr() macro to simplify the code.
> >
> > Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> > ---
> >  drivers/mmc/host/jz4740_mmc.c | 12 +++---------
> >  1 file changed, 3 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
> > index fbae87d1f017..09554f9831de 100644
> > --- a/drivers/mmc/host/jz4740_mmc.c
> > +++ b/drivers/mmc/host/jz4740_mmc.c
> > @@ -1099,24 +1099,18 @@ static int jz4740_mmc_remove(struct platform_device *pdev)
> >         return 0;
> >  }
> >
> > -#ifdef CONFIG_PM_SLEEP
> > -
> > -static int jz4740_mmc_suspend(struct device *dev)
> > +static int __maybe_unused jz4740_mmc_suspend(struct device *dev)
> >  {
> >         return pinctrl_pm_select_sleep_state(dev);
> >  }
> >
> > -static int jz4740_mmc_resume(struct device *dev)
> > +static int __maybe_unused jz4740_mmc_resume(struct device *dev)
> >  {
> >         return pinctrl_select_default_state(dev);
> >  }
> >
> >  static SIMPLE_DEV_PM_OPS(jz4740_mmc_pm_ops, jz4740_mmc_suspend,
> >         jz4740_mmc_resume);
> > -#define JZ4740_MMC_PM_OPS (&jz4740_mmc_pm_ops)
> > -#else
> > -#define JZ4740_MMC_PM_OPS NULL
> > -#endif
>
> All of the above code can be simplified in this way, without having to
> convert into using the new pm_sleep_ptr() macro, below.
>
> The only "penalty" would be that, the struct dev_pm_ops
> (jz4740_mmc_pm_ops) would then be referenced even when CONFIG_PM* is
> unset, thus the compiler would be able to throw it away.

/s/would/would not

[...]

Kind regards
Uffe
