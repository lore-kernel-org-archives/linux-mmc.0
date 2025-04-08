Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A9926AAAB
	for <linux-mmc@vger.kernel.org>; Tue,  8 Apr 2025 12:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744116068; cv=none; b=qtujpGKpAmOUTZ5oZ4OyPt/Z10zfHxtWH2zAurr4jGmxg0D2q27faMBItc76YT/44HJYZLPlz2paGnP4SLYacz06re9XrYa+R250d+yf/p30UD4jhDajGHG1ZMRcl4HiKA2b8friFtDWChsL+G1PaflSSBxYcHnZXBCOJxdp6+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744116068; c=relaxed/simple;
	bh=qLDMITlHkmBC9vQ1ZL9QNBFWIiCZvfOaQm2ASCOB0mU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=LbQpN2KvTBdRKinujiJU+GlQZZcbjDIANQWFtcwiYPoE7aE2GbaEk+V25boquW1tdf4v0HpR5HBufW/DgJUmVIyWIm8rNQ7x/4zM/7ozr5kueLGos9l/2pvroUEBTXLxaBV9GhRn7Z4sERZ+3IWYz74lgWZl5aBoQ4dCciHQn2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mro5MDSX; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mro5MDSX"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6ef7c9e9592so52187827b3.1
        for <linux-mmc@vger.kernel.org>; Tue, 08 Apr 2025 05:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744116065; x=1744720865; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h31NWp5NG78cqvJiAi8jWfDqzeGt0I+RYA/Hp3KCiI4=;
        b=mro5MDSXuxl+rI7To12fGqD9IiM/keuTFYIaWFjgLvnG2Jg6pDdRh8WcqsXF/O8vqa
         JUkA2qC8vtbYpxA/VvXfvrdk5N1+SH6Q/wyXxmehvCNl/esLDj66lBRIRPWg99NlpLBN
         OMfzZ/zdyJvGau5iJUtOoNN8sI3MC6lfqpWLTDYMQAnntEPeOUW9BJWNQHPBBjbLuepl
         /QXr33wM8dRPceI2uG1NZssBGSF0swj7W8Msy4hME5mrvm2MRNH1Y+vIEBt3FdgemTWM
         5rd+LzFBpfwwTNLciFGl7aR6H8tt9ZsvbYXqrrD/IcmzXDrhpjDJqmgEosxrQaPSUANf
         0qxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744116065; x=1744720865;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h31NWp5NG78cqvJiAi8jWfDqzeGt0I+RYA/Hp3KCiI4=;
        b=SKGrjiNW5l2ztC1DgHADImGaUR+DJ6mA4EORvi2ZuIyAa/qBvFO1D2qPDtInT6A/zq
         kmXLErZoK7g9TmNfTJ4L8X1WnqXHGZT4lgZpO/6yVdaHnHh31d4PQMy6T1r42/nM/Cx/
         gM+t9Q6f8yaul2EgkSNdEXzjl1sPaXC8EFcs1jEafUfrAT6UpJZU5Fh5M/lIQAOHDZqc
         VndFRueVfqUwVVe0mhIFV9clXulO/dDdh3l8tqNIqA5Pj4W+Mejr8qOjpR9LOqQ2jXOB
         vuzygEM4ehu8OMDdMVXA+pencXUhG+FTHsoMsf4LUKmeP9KektStIcFAvdHeFKCUKU7c
         WmUw==
X-Forwarded-Encrypted: i=1; AJvYcCXztE4l4F3skuF53PxSDhRbBLereDCMN6USQxV+CDqCCeLMo+rIJvrBylYFskQNNm7PxKrBkt4l7bA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzsjgsa99akmkSjgk1MWiBngAJGlUC5qMMf7R/lMi6ccKL+aNpq
	yFiMaffjaWSV8HXmBoIdhg6WmxgL3CLNpouAbFWLzXB2L6i4ykgyCvoc1nRhVVvVqCHUZyhBCPh
	eMqPGYVSPwScu0d9xd+ccJ/mtT9AYCBiSLHxmtQ==
X-Gm-Gg: ASbGnctuHXAgmhGlDZ5PbDFH4JU3YGPHOLscrE+7k4s26B2NKz92yacsuCxdIT+gaAE
	7t8x4Coe49fusABYN6AwWBoP9WlZ8vV082FlBSTYiCAZNETycjy6yKe6AzruQ7pud7O6qw8CBGa
	Kd5fxJqUgSRZrMAEDv3Dt3IA4FY/A=
X-Google-Smtp-Source: AGHT+IFi2YP0XvF5bDF9Jq40DyUHv5Ek50fAkz+eQJ5TMfPtzso0IeWqwOf8skCDPmoe9EJ6s/zbwELjZkMpg6aQGmQ=
X-Received: by 2002:a05:690c:b12:b0:703:b8f4:5b07 with SMTP id
 00721157ae682-703e15fc48fmr281518977b3.26.1744116064907; Tue, 08 Apr 2025
 05:41:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250407152759.25160-1-ulf.hansson@linaro.org>
 <20250407152759.25160-3-ulf.hansson@linaro.org> <Z_TZxXORT8H99qv4@shikoro>
In-Reply-To: <Z_TZxXORT8H99qv4@shikoro>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 8 Apr 2025 14:40:29 +0200
X-Gm-Features: ATxdqUFxgJAtDDVpsnTI2jHXWceVL4cabvWXC0qH_HhX-upbo0zNv7dP0b9TEt0
Message-ID: <CAPDyKFoOfNWa6b0jF0-a-imKqdDJQrdJe65OaOj3D0upmS7VXw@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] mmc: core: Further avoid re-storing power to the
 eMMC before a shutdown
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Avri Altman <Avri.Altman@sandisk.com>, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 8 Apr 2025 at 10:09, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
>
> > @@ -2187,11 +2198,12 @@ static int mmc_shutdown(struct mmc_host *host)
> >       int err = 0;
> >
> >       /*
> > -      * In a specific case for poweroff notify, we need to resume the card
> > -      * before we can shutdown it properly.
> > +      * If the card remains suspended at this point and it was done by using
> > +      * the sleep-cmd (CMD5), we may need to re-initialize it first, to allow
> > +      * us to send the preferred poweroff-notification cmd at shutdown.
> >        */
> >       if (mmc_can_poweroff_notify(host->card) &&
> > -             !(host->caps2 & MMC_CAP2_FULL_PWR_CYCLE))
> > +         !mmc_host_can_poweroff_notify(host, true))
>
> Ooookay, I think I got this logic now. I think it makes sense to make it
> more explicit in the comment, though:
>
> "This is then the case when the card is able to handle poweroff
> notifications in general but the host could not initiate those for
> suspend."
>
> Something like this?

Well, in my opinion I think this would become a bit too much comments
in the code.

The rather long function-names "mmc_can_poweroff_notify" (that will
change to mmc_card_can_poweroff_notify with your series) and
"mmc_host_can_poweroff_notify" are rather self-explanatory, don't you
think?

Kind regards
Uffe
