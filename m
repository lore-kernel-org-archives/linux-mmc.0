Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BD211185;
	Wed, 21 May 2025 10:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747824341; cv=none; b=NSH+ROMGuYLQZ1I2lfFn9YZyeAy9WmAznAL9ga5DAx/7K7Ft8ichv6DK18Fa9yepzJPkacJlADrJUlR4ZWFpigy0urQIgm4tnocNTWuTrrgAmimQk2CnQq44SqTFgzulsXyskgaccVLv1KUwsjr0+0zeIaDGXGImFKCumQOr/8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747824341; c=relaxed/simple;
	bh=nBFVOBAzCwLiPJlbF86jc8AtqkeBEhLpQjQSOowZjjA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cNiX53OocDNxLq53cgqg+Gme14Q3AuDHCVGp1pWI/fYiNYcYMZIOV9ALztSEVPBiLgLeEj2z6lmCbylaSaoqF3jXakT3VcFNlF7NaJAif3CX9/efrOqCGeRxvtxFoo/0rpJPHRRF22j81UW3wLx3c5xI+bofEAzaMJ3jBtidDNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GgCsJyWM; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GgCsJyWM"
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-52413efd0d3so2016519e0c.2;
        Wed, 21 May 2025 03:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747824339; x=1748429139; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jI7WFIT3oOKIZEUz+s1sh9xGeM7AAYe8al+Kc062RVw=;
        b=GgCsJyWMiKpMzYcSoGwtjStkmAJWc0fdtemUTTcstDwNp1kA/K1PfW7+8+Wh41pGPA
         pCPoN1v1ZSTRta5iA/MhQE9615NJcZGNOlQtlWOe3gHXuTSsdj/3FhJAToxnT9WTqlaI
         m3LXS8auofXfLaf85v/FRqP3F6DdlvM4vD/gKx19Xv6XnK+gzDuAhJjiC7vGb9PaWa80
         2wtKNDjXZeZiOCold/kkgMI2Qovg68X3hdgcsxCrU8IBSA/NOc7zvoxGSyneDuGrY8qa
         a3CCtdBvyxHsETkHHgL8V5JiR+w8133amMnKDVO/KBjmFL1HhIRRck4Ytrg/2/DuGt4I
         fylw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747824339; x=1748429139;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jI7WFIT3oOKIZEUz+s1sh9xGeM7AAYe8al+Kc062RVw=;
        b=PwbFlq/AdMfadDgGLuyB4YkyfoPbVwYAZIpt3oDqdGz+hENGWOdta3bZhlzLkaNoD8
         hi6Lfg4VjG19+8SToSd/SwHC83odachefCnY9r51eaP5mNp9xiUMkaxp19UwJn3YHPQI
         uLAYYnW5VnjvJsSWIbn4R2VuSfMk1j2S19QtDnsb6UFS0ZlGbUL7lL410AMvcsR+xGsH
         e4Uo7evHkq7vIljGY5LgVeTQk7AOmBNcoy0YQ2PLVx3tKokDAhkjy4zDkKQHmP5tVKs7
         EOBmE1Er6DUe1jJzJYzTaztPa0RNgNdwqI6W3caoXD3hWOhn5d6BU3xld5SXraQqdKpK
         6uFg==
X-Forwarded-Encrypted: i=1; AJvYcCWLpXh6rvKpQQvurlkph9jTvvATJqiDYj1JZXj8zo3b2DqdEKIDUQC9bIvRvXCu5abDt5jn7lngX/NM@vger.kernel.org, AJvYcCXjNGuvkTAFHJKC6cevnUrN5CspP4O2wnbKXqfxevt3SPFcq8uL9B9VYhFZnzhCPVvyEX/3+hMmSoDeePs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCkhAJoIt7I2oE2EUjYZXiVfV8LJCU1RIjd3RCTls1icdaXyPB
	JC4CjhMrHK0Tr+XW5DfBL2xiFd56osKldc11Q4Kvm4kcL+Cio66/TGMrjb0AY3wvyX03YO6s/Ry
	/aPO9mPEVhtIj3H6qatXyuJ3m78gLB9wJIZr7
X-Gm-Gg: ASbGncvoNA9wEN4TQiozHh/Dnkp37nRJ/MqbtDHS7lmzcqjTqRmzk4ldxXeoXOpXK36
	P8kQXphrm98xv0ThAk15uv7mK2c5BXxG+UlpJNENrhSPWrSLXzjPfpo/pYW0SqMCP271mj4+QXo
	u/wAVbKF8Jer8zK+F3NtTn7CXFiEhOO+whtTYAdvwVrlPjGZ8y09gpz+AUEP3FB1BatA==
X-Google-Smtp-Source: AGHT+IFWF5OsgsU1QzpUJixobWdrzKZcXKaR0HkmiUChadkshUDPW61+RL/bvsQALDrLp7/ocx0XIQLx8Ht21EVNx+k=
X-Received: by 2002:a05:6122:da7:b0:52d:b8fc:991f with SMTP id
 71dfb90a1353d-52dbce2ab91mr16664934e0c.6.1747824338903; Wed, 21 May 2025
 03:45:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250516092716.3918-1-victorshihgli@gmail.com>
 <20250516092716.3918-2-victorshihgli@gmail.com> <CAPDyKFrKRw2kOQ9Gq=eCmm0N24hSEamNeCWGzC6X-Qg33ad-gw@mail.gmail.com>
In-Reply-To: <CAPDyKFrKRw2kOQ9Gq=eCmm0N24hSEamNeCWGzC6X-Qg33ad-gw@mail.gmail.com>
From: Victor Shih <victorshihgli@gmail.com>
Date: Wed, 21 May 2025 18:45:26 +0800
X-Gm-Features: AX0GCFtUXh2b2WmqbWg3oVW5IpySFiz1dAa98yuROK1LERLAVrWp1wc5Otj8SME
Message-ID: <CAK00qKBRtBfWe_vGKz7Bbw3ZZfY4bxXiFDd3bSqzwdqP9hK01A@mail.gmail.com>
Subject: Re: [PATCH V1 1/2] mmc: core: Adjust some error messages for SD
 UHS-II cards
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: adrian.hunter@intel.com, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, benchuanggli@gmail.com, 
	HL.Liu@genesyslogic.com.tw, Greg.tu@genesyslogic.com.tw, 
	Ben Chuang <ben.chuang@genesyslogic.com.tw>, 
	Victor Shih <victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 19, 2025 at 8:10=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org=
> wrote:
>
> On Fri, 16 May 2025 at 11:27, Victor Shih <victorshihgli@gmail.com> wrote=
:
> >
> > From: Victor Shih <victor.shih@genesyslogic.com.tw>
> >
> > Adjust some error messages to debug mode to avoid causing
> > misunderstanding it is an error.
> >
> > Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> > ---
> >  drivers/mmc/core/sd_uhs2.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/mmc/core/sd_uhs2.c b/drivers/mmc/core/sd_uhs2.c
> > index 1c31d0dfa961..58c4cef37f7c 100644
> > --- a/drivers/mmc/core/sd_uhs2.c
> > +++ b/drivers/mmc/core/sd_uhs2.c
> > @@ -36,6 +36,10 @@
> >  #include "sd_ops.h"
> >  #include "mmc_ops.h"
> >
> > +#define DRIVER_NAME "sd_uhs2"
> > +#define DBG(f, x...) \
> > +       pr_debug(DRIVER_NAME " [%s()]: " f, __func__, ## x)
> > +
>
> We don't need a macro for this, just use a pr_debug() below instead.
>

Hi, Ulf

I will drop this macro and use pr_debug() instead in the next version.

Thanks, Victor Shih

> >  #define UHS2_WAIT_CFG_COMPLETE_PERIOD_US  (1 * 1000)
> >  #define UHS2_WAIT_CFG_COMPLETE_TIMEOUT_MS 100
> >
> > @@ -91,8 +95,8 @@ static int sd_uhs2_phy_init(struct mmc_host *host)
> >
> >         err =3D host->ops->uhs2_control(host, UHS2_PHY_INIT);
> >         if (err) {
> > -               pr_err("%s: failed to initial phy for UHS-II!\n",
> > -                      mmc_hostname(host));
> > +               DBG("%s: failed to initial phy for UHS-II!\n",
> > +                   mmc_hostname(host));
> >         }
> >
> >         return err;
> > --
> > 2.43.0
> >
>
> Kind regards
> Uffe
