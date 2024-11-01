Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C7A14EC62
	for <linux-mmc@vger.kernel.org>; Fri,  1 Nov 2024 11:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730459094; cv=none; b=c2U1d37v5Y7jzjgUt/QFQ5/GGK4NmuNQKpoy1rLN2NsOWTYfKiYVt4CGM5fGEOdm0wZXd8dugPlIB9244QbltkOPkWADf0/Wg8vE0Q1rsobTWS1KJT55rHbNkIyEiAzZusIb4j3LRpZEMYta7NWxP9nCo79Y+Bp88CRXkXAX5J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730459094; c=relaxed/simple;
	bh=omwNnWjrnHsokRVJxkjx6MXugKu+P+wlf/4zL6qAxa8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QIlvKmXB0W8pdv5wDUu9M6/k9/rjMP2xBGXCUcCN5Dsejhhj3QdJHdILG+ZNVLawnqyCnur2hZ2spudo0E/W7M0JpucvejflmqYGX1vw1xK06gQkaBquJKpdQaJu5Gyuj5iJSVWt2YSh9H8Th/qIaxZ5yB3VQH9/ocYEx+xqkcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xy7LavfM; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xy7LavfM"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e30d517c82fso1768620276.1
        for <linux-mmc@vger.kernel.org>; Fri, 01 Nov 2024 04:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730459090; x=1731063890; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RcyVnre0jfOXE57f1aZ6yOpuSdrWU3Uetk6AKG4MKck=;
        b=xy7LavfMncSilze0ZSbiCXxNzhz8AWiqBHrzWnOrY1LE5oByfjQrNpRytDM56CG7/E
         YvV6J6sofUq5fEY9uYgWaZYqx4iJckhU6zHXJCmFGJuwRXuRrDVr3W2Efy5vUmpJSi3m
         t2ColRg2kUjLNqo2yh2Iu/SNaMcU3R7NHLyCyaWh/72/QJ0yod1zdDLiCo31Fj5QUbgy
         qShXFxjwSELHw9m2AubiS8sOOajsbFLvswz8mo/UbiWZuy5k19Sbhal9Xj++JIrQrcpJ
         WuU+Z9kTTDgJ3BzaHcO5zcsGYe+QzPkPM5qOSaxxGPte5JZ5MDM+CIhIZcwNRJB4Idlt
         kV6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730459090; x=1731063890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RcyVnre0jfOXE57f1aZ6yOpuSdrWU3Uetk6AKG4MKck=;
        b=V8x8PEfG9IzUWVj0DMNBq7wCv3BDJzyi19zOAe+ElIoL6E9akdYlbvuZYzRLn0OfUv
         u5QdOrJZiSz30zA+AOthPY5Y0HZR5rlSY3Mg7Ph7qTqmyGqd3pE34XrEDi5qQf05QVeJ
         Vdhi0C30REC4GYHC+XqtuKn9RV2w9S9VMSMRj/15Wruw8b2KijE6gikUtrWZ51fix8dA
         ptV/9ebDYptuEvSjFnLALA8kqDZP+yL4xvODS+lSC0vSejiXc0He2UmVkSxkA7EsylRB
         D2GtVpg2hNh4P8GAOC89pUCcA377yKbjpN0/1bMw0YKp4Mg9TIGPdWe6dYOcWYA4X/PI
         JSLg==
X-Forwarded-Encrypted: i=1; AJvYcCXhUJrYjvIZT2lKVlAM100xn1jCNdk/KCMIDgFEuxlmOMK3eyVrSmCvRvNmcWC08txEqgX3D77eGZc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ05UQ5c18QdNT+nB9FWrlxqpWMdDp4IiICsS5ypcV+Z4jKKPR
	NpkDBfMqi7WYLHC+m1nnqW9vySgBs09CV8JO7p/OTnV9X6EtNoqza4MfRPXDuFz+K8CGRmAhohD
	hVkrxzrQaP8f3cmi0APv2+x7deyfGnTzU6bpo6Q==
X-Google-Smtp-Source: AGHT+IEm0w4Bc6bpa9fFzIh7gFznHA6TyOg1AJUMCvNz0eEXmCXuB9jRIMZyo30oCm1/Jxs53bamqXzVvH4THAHgov4=
X-Received: by 2002:a05:690c:7289:b0:6e5:a78c:5795 with SMTP id
 00721157ae682-6ea3b9a5f4dmr86832957b3.43.1730459089626; Fri, 01 Nov 2024
 04:04:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912152538.1.I858c2a0bf83606c8b59ba1ab6944978a398d2ac5@changeid>
 <4920950.GXAFRqVoOG@diego> <CAPDyKFosf_+m9j8YgHa-PsC2SV8+Aou2O6bTbMfzGBpQ2sY8YA@mail.gmail.com>
 <69d06c04-cc8c-4435-a622-33d5dcd1fa24@arm.com> <CAPDyKFoU=AoQqXov_-qFo8xjEbiDAk9mtTtCR9HAYz_gg-bnzQ@mail.gmail.com>
 <eb96b240-f3ee-4057-b016-c746d48cc1b4@rock-chips.com>
In-Reply-To: <eb96b240-f3ee-4057-b016-c746d48cc1b4@rock-chips.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 1 Nov 2024 12:04:13 +0100
Message-ID: <CAPDyKFonhL3JwN1TDrXW-0=VgZowBqTpHsi99GSRmW+aN+4ELQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc: rockchip: Keep controller working for card detect
To: Kever Yang <kever.yang@rock-chips.com>
Cc: Robin Murphy <robin.murphy@arm.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
	linux-rockchip@lists.infradead.org, Jaehoon Chung <jh80.chung@samsung.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 1 Nov 2024 at 08:59, Kever Yang <kever.yang@rock-chips.com> wrote:
>
> Hi Ulf, Robin, Heiko,
>
> On 2024/10/7 17:49, Ulf Hansson wrote:
> > On Fri, 4 Oct 2024 at 19:34, Robin Murphy <robin.murphy@arm.com> wrote:
> >> On 02/10/2024 10:55 pm, Ulf Hansson wrote:
> >>> On Sat, 14 Sept 2024 at 13:52, Heiko St=C3=BCbner <heiko@sntech.de> w=
rote:
> >>>> Am Donnerstag, 12. September 2024, 09:26:14 CEST schrieb Kever Yang:
> >>>>> In order to make the SD card hotplug working we need the card detec=
t
> >>>>> function logic inside the controller always working. The runtime PM=
 will
> >>>>> gate the clock and the power domain, which stops controller working=
 when
> >>>>> no data transfer happen.
> >>>>>
> >>>>> So lets skip enable runtime PM when the card needs to detected by t=
he
> >>>>> controller and the card is removable.
> >>>>>
> >>>>> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> >>>> So for the change itself this looks good, i.e. it fixes an issue for=
 baords relying
> >>>> on the on-chip-card-detect.
> >>>>
> >>>>
> >>>> But for boards doing that, the controller will be running _all the t=
ime_
> >>>> even if there is never any card inserted.
> >>>>
> >>>> So relying on the on-soc card-detect will effectively increase the p=
ower-
> >>>> consumption of the board - even it it'll never use any sd-card?
> Yes, this is how the controller works, the controller needs the clock to
> make the detect logic work.
> If we use gpio to implement this card-detect, it works because the GPIO
> controller/clock keeps working.

Right. On embedded battery driven platforms it's quite common that
there is some always-on logic (maybe via a PMIC) that helps to take
care of these GPIO irqs.

> For the dw_mmc driver support, we should support both kind of implement
> due to the controller has this function,
> so this patch is for the card-detect implement by the dwmmc controller,
> the controller need to keep working
> - only for sd-card (so not include the "non-removable " device)
> - also not disable rpm when "cd-gpios" is used.
>
> For the power consumption, I believe it will increase, but very very
> small, we can't even monitor the change

Right, that may be perfectly correct on the platform you are using. On
others it may not.

In general, it's a bad idea to keep devices runtime resumed, unless we
really have too. In particular when the are shared power-rails being
managed by a power-domain, for example.

> if we use the normal equipment. The driver should make function works
> first, and then consider the power.
>
> This patch is to make the dwmmc function works without gpio's help in
> dwmmc driver,
>   and has no affect to the gpio option, people still able to use gpio to
> do the cd.
>

I understand and you certainly have a point.

However, it sounds like you think there is a drawback involved to use
MMC_CAP_NEEDS_POLL in this case? In that case, can you please
elaborate why preventing runtime suspend would be better?

[...]

Kind regards
Uffe
