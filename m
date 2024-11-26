Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503561CEAB3
	for <linux-mmc@vger.kernel.org>; Tue, 26 Nov 2024 12:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732623509; cv=none; b=ljA6sotvfvB++vueL38DfWZ+W/MlBDnB+v8Wdgbx9K/3Kj9b6JiG98aTlAqKXdVkoG7BojQ41w5e/FlLG1osG7/vfUkqJp8CGaNmFpAKb4X1IuZdBfOr9ikoq8uBIbQv4SMxWhGO3Wr3ZCiCdm01VYE2HQNiVt02A2L0K9w7BUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732623509; c=relaxed/simple;
	bh=NsOkQNizfy7L6gUL++EqJf4pjp0B+QFz5IwWcPxP0v4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YEEOtYOpiv3tY/gOb4Y4X8QoPkzP+JDtRm+u3a4Ez2MsNYizbhPXUx3quy+iAGJfwgXUBuNOvMgb7AaKGFpjSBTaJgaSBIOy3WJiyrdjYut4ThqAkCLXBEjfEFKAjj5ig8xOPt5Ku8JXIWgbQjspuRFUT5oLO/yidqz0GOIvWYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Xrm0r4Z9; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xrm0r4Z9"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e3884cd186aso5546759276.1
        for <linux-mmc@vger.kernel.org>; Tue, 26 Nov 2024 04:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732623506; x=1733228306; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1t2bdLsphO4qv8lX65ai1ApZKPwIzSeCFPg10eL8iQU=;
        b=Xrm0r4Z9plqyu6EMaQ33HU3gA15VUn/9eXRZVDYz+yMWMUDJd/SsM+cLxql5xOWWL3
         fKNVrQy/iWj2iMb2NlWu2oZRCK9n0EvmOBRVaVciynw9+F8P3AhxnXIEMl2oGtuIK0ge
         zNu4/NFlYiGx/z19tABn4P7IeThn/WnGB0Vxqx9Tt2OAEahOFtwcw6eF9/nm42OnzRl1
         zoneEr0r9Pg2fksLuYLRYg/Cxg4ga3uA5NN993xTIoEnV+4vvzL0RRBCiQkhyhM3r0Uq
         aONtdUf0334ih3xDgu3Vlp2z/5rRICseXyVzMOfA0DMm/t2/5gusABvOAJaBFtgQgp8r
         +nWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732623506; x=1733228306;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1t2bdLsphO4qv8lX65ai1ApZKPwIzSeCFPg10eL8iQU=;
        b=mJ4MZyRppPlq91VR2qmyxF5/ErOFDnQksTVAoznwBzcMuR7VNYdgBx9F/53aFw/vfl
         v0IBZ9hV/TarMan1UEJJ/DcKfplipW95Fir8qI7l0urmWdPH35tI7G0ZGULkcxRPiCrd
         umeomcAEAB+8Kq4PQ5R54GR+L3X/qqj9+4oiNnJG+IHDQeiY1S/sS79Gp4ORGxHvoocJ
         EFaqURyCUkf+31HMhnesrugYwOvIguUlZUB3UooTox+ydly5g3HZQuO70edt5vablwUj
         R7rk56/9Xg0RWV5o7udv916KoiSrar0Deybml7t3BhS2DnOe5rQemqHG4xWT54iRUxw6
         Qepg==
X-Gm-Message-State: AOJu0YzVpgWBbEBjHEqneP5F6o4IAIpJzcmq/Sher2SMWGRyQGm+Qoha
	UFsYkUIo1CcNZ6loeETr4FHAXbZWbc/ba+KGb9Pw5wMOpPK3Cp7VAZnp1Ki/36AqDF61So5gMrh
	/KDT6ihen58QJNdpVJwf0KQ1E68QQwCmFEhDrtA==
X-Gm-Gg: ASbGncvJsTn7tvKeYcIyCu/C7Y1RrQOJ7oMRN8RzDDwMnu3dGhuxCB2F7RXdCilFjn4
	viAFTAZi7rOh3QuI/3+XY/HpmyBvoh0Ax
X-Google-Smtp-Source: AGHT+IGd5+wBDRxy/P2XFJDCWgoDYm0J6RIEhVEBraMx8w2/LeSUu3keiz9cNbvZe3rDWYJygxSUe3J10dUdOJanJ80=
X-Received: by 2002:a05:6902:310b:b0:e38:8ea6:2abf with SMTP id
 3f1490d57ef6-e38f8c05130mr12064188276.46.1732623506153; Tue, 26 Nov 2024
 04:18:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241125122446.18684-1-ulf.hansson@linaro.org> <113cb538-f337-464e-9854-3a6dcb5b95e6@intel.com>
In-Reply-To: <113cb538-f337-464e-9854-3a6dcb5b95e6@intel.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 26 Nov 2024 13:17:50 +0100
Message-ID: <CAPDyKFowPmNKDhn2Mb8QCGkO1cC1jkdHbMk94fxAur2D1fXqZA@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Further prevent card detect during shutdown
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org, Anthony Pighin <anthony.pighin@nokia.com>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 26 Nov 2024 at 12:57, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 25/11/24 14:24, Ulf Hansson wrote:
> > Disabling card detect from the host's ->shutdown_pre() callback turned out
> > to not be the complete solution. More precisely, beyond the point when the
> > mmc_bus->shutdown() has been called, to gracefully power off the card, we
> > need to prevent card detect. Otherwise the mmc_rescan work may poll for the
> > card with a CMD13, to see if it's still alive, which then will fail and
> > hang as the card has already been powered off.
> >
> > To fix this problem, let's disable mmc_rescan prior to power off the card
> > during shutdown.
> >
> > Reported-by: Anthony Pighin <anthony.pighin@nokia.com>
>
> Could add a closes tag here

Good point, I will add it when applying!

>
> > Fixes: 66c915d09b94 ("mmc: core: Disable card detect during shutdown")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>
> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

Thanks!

Kind regards
Uffe

>
> > ---
> >  drivers/mmc/core/bus.c  | 2 ++
> >  drivers/mmc/core/core.c | 3 +++
> >  2 files changed, 5 insertions(+)
> >
> > diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
> > index 9283b28bc69f..1cf64e0952fb 100644
> > --- a/drivers/mmc/core/bus.c
> > +++ b/drivers/mmc/core/bus.c
> > @@ -149,6 +149,8 @@ static void mmc_bus_shutdown(struct device *dev)
> >       if (dev->driver && drv->shutdown)
> >               drv->shutdown(card);
> >
> > +     __mmc_stop_host(host);
> > +
> >       if (host->bus_ops->shutdown) {
> >               ret = host->bus_ops->shutdown(host);
> >               if (ret)
> > diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> > index a499f3c59de5..d996d39c0d6f 100644
> > --- a/drivers/mmc/core/core.c
> > +++ b/drivers/mmc/core/core.c
> > @@ -2335,6 +2335,9 @@ void mmc_start_host(struct mmc_host *host)
> >
> >  void __mmc_stop_host(struct mmc_host *host)
> >  {
> > +     if (host->rescan_disable)
> > +             return;
> > +
> >       if (host->slot.cd_irq >= 0) {
> >               mmc_gpio_set_cd_wake(host, false);
> >               disable_irq(host->slot.cd_irq);
>
