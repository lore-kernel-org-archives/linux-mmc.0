Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC851B07BB
	for <linux-mmc@vger.kernel.org>; Mon,  7 Oct 2024 09:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728294597; cv=none; b=QEvL3ZJbp7xlPODJQ+XNW7Z2owI+gvdEnTRg+Dcqwwa5hxrx/WguULEisnpJph08NJOK5zKTAFfDjf9XoQJwZUVoYeUA0Ixs57q8GSi1Sc1Z+4MBv6R12jcGKaay4lQlahKK6nd7SZUcpUZO8pOX4AK/CFG1KLNrL8w5lnQpWsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728294597; c=relaxed/simple;
	bh=k8brDWLlZk0dTO8J46y2uPWyWt9rqKJ6ybBhtU5TnAA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JJDssd+CzNNKk16nO+7vKp/nuFWgvF6Xt+ll+N69AoQmgz3PUIdKsKr5pEaL6dUfxkUvB9YXSMU7fwO9Bh86+f+sky/5vCWSWD/gBUaY/LmZDw1DxsRzp+AOt+wIz2u0PtWtCKwwI8I1t18nuc9/AiTEee0eWk8IMPxDD0r8wNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=n5bfMogd; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n5bfMogd"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6e2e3e4f65dso10512647b3.3
        for <linux-mmc@vger.kernel.org>; Mon, 07 Oct 2024 02:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728294593; x=1728899393; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k8brDWLlZk0dTO8J46y2uPWyWt9rqKJ6ybBhtU5TnAA=;
        b=n5bfMogdEoYJIDRe/R6/5RahWI1QeMggRlDradUu0D68q7g/Bx1VYnIUEMa3OVjcu/
         Bba54bKxWv/ciyHFB9/Qw+XJV7ys8sVd8c+kwwXGuv7bktW42F6sBJzxxJOJkEGqnbky
         x75s+zB0I/6F7cSGr8BXQaVNW4UgGpRdP78PGdfuzbxZbyDnjenE35V2YqCcQ/ExrFJA
         xQ0GMGj5SQMRW62cMJdlq6DUgQZLVF4AbaK2soxauJ0Yj7gfOzImXTw/65am52mU8gg6
         rZ155vtqPoXAtZyE1l843uu8WSacCp1VuK+/zGOwvS79ckiNQPnsslDrub0+jZYurPVd
         zajw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728294593; x=1728899393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k8brDWLlZk0dTO8J46y2uPWyWt9rqKJ6ybBhtU5TnAA=;
        b=HIxomGXbnVw1n8yrSIX6KLaZMV2lmvR6Gb3Vj7ZA0pYzQspPGxmwtwatu4j0g13GBd
         weiXw/EuueNMqdADlfTnxIZHBVYIWXa8Djv7G85E1nrgDXvxV/D+bws+myguxc4+V+l8
         xWUWjnl5IxSWB62uo8MaYtwxP516gejcauxujF+o64wPm1Q8IOQvnO+Sg0BKMGSNeIvT
         9GQv2z7xiXqlxWj8XnZQaGf/t0kZKhoT83ERYAJcGKSKtQSmrsUubaAER9AGWFK6yE5n
         xoCWgGuIlQwpJHHe00n5lcxofc8Qd4QwazodqsjscXOOs4yrjNsocD+INOeXq3EzIMUf
         /OWA==
X-Forwarded-Encrypted: i=1; AJvYcCUWuXAHNkdVWGDCczg1K0qOCPqI5IOBwTI8ZQsySM2T9NgZ5d+6yRr7HA94+vl2EN7fNnfQ6VHnzYo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLMrex108QGxKZdUjwYDTktGFgJnb2oMveERJ/eX8T0smp0I8h
	+WIDphT/6mfm+Mhj2NFF/I86uDzDONgdrXxV4FxRJkosGB8+wJ6R8K+KIGfKLcDXvRnHM15VHpO
	BWpjMOuW2UJ/FQKTY3XJPkk0+73movtTD6UCEmFLjG3UOvu4N+P0=
X-Google-Smtp-Source: AGHT+IGSGgIFN4afz5XWgt9KmsO3+YZJnn8Ko+Z2HXn7fkNdGM2ZDBjhHypaK+quYOHT6jssiLjEWS446xsZEN9pFLg=
X-Received: by 2002:a05:6902:20c4:b0:e28:6c15:ac6c with SMTP id
 3f1490d57ef6-e289393a731mr7649236276.40.1728294593313; Mon, 07 Oct 2024
 02:49:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912152538.1.I858c2a0bf83606c8b59ba1ab6944978a398d2ac5@changeid>
 <4920950.GXAFRqVoOG@diego> <CAPDyKFosf_+m9j8YgHa-PsC2SV8+Aou2O6bTbMfzGBpQ2sY8YA@mail.gmail.com>
 <69d06c04-cc8c-4435-a622-33d5dcd1fa24@arm.com>
In-Reply-To: <69d06c04-cc8c-4435-a622-33d5dcd1fa24@arm.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 7 Oct 2024 11:49:17 +0200
Message-ID: <CAPDyKFoU=AoQqXov_-qFo8xjEbiDAk9mtTtCR9HAYz_gg-bnzQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc: rockchip: Keep controller working for card detect
To: Robin Murphy <robin.murphy@arm.com>
Cc: Kever Yang <kever.yang@rock-chips.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
	linux-rockchip@lists.infradead.org, Jaehoon Chung <jh80.chung@samsung.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 4 Oct 2024 at 19:34, Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 02/10/2024 10:55 pm, Ulf Hansson wrote:
> > On Sat, 14 Sept 2024 at 13:52, Heiko St=C3=BCbner <heiko@sntech.de> wro=
te:
> >>
> >> Am Donnerstag, 12. September 2024, 09:26:14 CEST schrieb Kever Yang:
> >>> In order to make the SD card hotplug working we need the card detect
> >>> function logic inside the controller always working. The runtime PM w=
ill
> >>> gate the clock and the power domain, which stops controller working w=
hen
> >>> no data transfer happen.
> >>>
> >>> So lets skip enable runtime PM when the card needs to detected by the
> >>> controller and the card is removable.
> >>>
> >>> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> >>
> >> So for the change itself this looks good, i.e. it fixes an issue for b=
aords relying
> >> on the on-chip-card-detect.
> >>
> >>
> >> But for boards doing that, the controller will be running _all the tim=
e_
> >> even if there is never any card inserted.
> >>
> >> So relying on the on-soc card-detect will effectively increase the pow=
er-
> >> consumption of the board - even it it'll never use any sd-card?
> >
> > Good point! A better option is to use a polling based mechanism - and
> > we have MMC_CAP_NEEDS_POLL for exactly that.
> >
> > Moreover, on DT based platforms one can even use the "broken-cd"
> > property to indicate this.
>
> Except that goes further than is needed here, since it would fall back
> entirely to software-based polling for card presence. In this case the
> CD function is not broken in terms of actually detecting a card, it just
> doesn't work to wake the controller up from suspend because it can't
> fire its own interrupt while powered off. In principle all we should
> require here is to periodically resume/suspend the device, to provide a
> window for the interrupt to work and normal operation to take over if
> appropriate.

Well, I would not object if "broken-cd" would be used for this case
too. I believe it already is.

Another option would be to look at a compatible string and set
MMC_CAP_NEEDS_POLL based on that.

>
> Of course the really clever way would be for suspend to switch the pin
> into GPIO mode, and set the GPIO interrupt as a wakeup to trigger resume
> and switch it back again, but perhaps that's a bit tricky without
> explicit pinctrl states in the DT :/

Right. A dedicated GPIO pin for the card detect is certainly the
preferred method, if you care about not wasting power.

Kind regards
Uffe
