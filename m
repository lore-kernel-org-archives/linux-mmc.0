Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4813DA7E6
	for <linux-mmc@vger.kernel.org>; Tue, 20 Jan 2026 10:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768904779; cv=pass; b=ubDrziJevMPy3AHnbwXywYFjY987yQP1DLa9fy6LIgBkaw+jAhZtswP3dHiuaCyivxXVQ2A/QNr0+vkB6GxbVBjU5ySgmAJLosM9MVlhKdHtRri3XmmSCLy07LXLyA/2H5REjlTCGmC8JasNUF6bJTHFSK0RrZj9VEbWgv9j4Hs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768904779; c=relaxed/simple;
	bh=2voIFGn6SR1MogbmE3kR3Vdr38x74Nd/URKdq4hbHvk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VGmQo5+qYFoDeEullr/lAOduyZmkN8fJ0WFMyCH0ift9r3nAAfNL+E4/mmuMa0KBJBOsFtiRYngHJuBmALOmYH91n03rXqDas+tVVjh1LLV425qD3qjE66+8lIH5WYZJCrvnI+B3VU7ySp3u1juGeL4jJWLJsyx6kH36OXefjMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SLTsLSsB; arc=pass smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SLTsLSsB"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-59b77f2e43aso7782141e87.1
        for <linux-mmc@vger.kernel.org>; Tue, 20 Jan 2026 02:26:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768904775; cv=none;
        d=google.com; s=arc-20240605;
        b=Mf1GMUOuYLVoBeENW1oGtk0XyEH61IyhVcljcLeWArbmHWecnZ5MLKlmp89qobFr16
         rq1E+1XfK13pgdI4lrJ2n2OAsFXzpgcHoLXtQ+iGxRyAKkwMQv5/DDasnkyy5GWEFqX1
         hd/44DnkMAOldnAstiEvxZlKyc9ch3ezalmSXExdFoM9w+9jPYSurJ830qcjj0Nnpy9X
         8bioLLPuJDxOF4wdTTpc2mZzmTn7bIRF/LBaiF2aV6p7iEC57iLDjfJyEJLvmOX/wHBi
         Y2UmoH7Ql8FasayWaZae+j7Q8+nailzuwF2+BY5fmWlUfW1ULc4AH7TE7AhY+Jwp9zdg
         VIKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7dc4uOSwQ2vBzThtTBXaWxDon+kZapkB4rooEPiZwsE=;
        fh=9bCBdMmtBdSSeaThLDKitZ84tJDrdjuXIM/GDfPHJR0=;
        b=ZCc+jd2Y77bOQ19J49p8kgMTK4VaT2VWmCNV8zLo5DaG4rlBvOhRriLknSIXe1vyig
         gxkH+TRl0Ko4twMWjuE6V3awgJpfLLMicMNHWwOxNG+iAuT9FPfQMs0ILCSUzlI0Zf8R
         whosxZ7cg4caXjXG86eG4NzK8ShirKARU+NabPG75K4Dsv54sCo6a9fgoR1wJC2ng0Rj
         wr40Bz99iAcDaTht/MJ8sOD0clnF1GMm/kwgesBNnTabE+ZeWbo3UZLKv9rk+gbH6N+r
         RpIIFk7C74Ts5QSSGJbIwx2Zy+6hTOMEZIOBkdNC3yH4IYSz+WiEXLknBiiXFkJ+W9se
         2d1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768904775; x=1769509575; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7dc4uOSwQ2vBzThtTBXaWxDon+kZapkB4rooEPiZwsE=;
        b=SLTsLSsBmNdCC6K0hs7UxMOpWLLNe9OnzkqQV35PejWHCxehhZfZXrGQaaFNpWCCY+
         l0L8EXAZFZAjj7irvRlZeBB/rnX8X66H6vhKX2vCnu7Y/t09c3YTPRIatosRiBJlZ/AJ
         2N+RGPgPuByZlhxAYLoWMY7TliBGbTvCGYrKkXlN9tB6aNdrF13XETDOIA98huKqMGd6
         XVuoo2J7A+peDjrap3bp4j2UOXkmPnHtmDh5y9L5fSwcNaoJ+UAnbNYDQXrUuP4q0MvZ
         kCaXu3EF9rUqaS/igwsnpbbbZ/wvfFeb6LEY6M98PkPAhOjkjXfc26v0qwSOmkVEgwE6
         QzXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768904775; x=1769509575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7dc4uOSwQ2vBzThtTBXaWxDon+kZapkB4rooEPiZwsE=;
        b=eQu/E5Oa1RXlEjuw3yZ8hZScdSNQhqYbf/d+EZaa8aUxUuLp9YJHkGDVabPTS5sNmf
         AHm6RZby9R5G86ATvJ5MzwpaMvOMljZ0iFUsSvTjX9IqgMMnHu3zh+yCyhljKZEY5p0l
         Tyb+dTfp3qghkAoDWWQRuVZxj6ajWhQf9/QZfBH+3k2EjQfhYZ1tHUS25k0ZLBpcgl1m
         Bis8CP5LIUAG9BpFEccDuXiliW1hxGSobc3st/mi1UPdjjLaKkMqMzsw4B2b0FZgZZRD
         4JbnIDhsfM8s9KbzZtF969V7DP60QXCe7vSn4coJF6tfqaO/RqYVVFmkDReqQF9NaWHU
         zKdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTFDGyJ9a1DmPgt0rLq3OMCb5LfzWaWTD9cp/XZNYkeqcoRA6vSpxKKNjhgCSbjHHlMuGO2ZjviBI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRiKIt28n7hnYLhHV5doB6+zth1J1VeW8+AgPWOIeTzit/bVsW
	udwEewO5p6QFAAu4exjJsfv5pRktSfzOh2S34AXZWgEgq6GATxxI4lN4WiRCNri66PdgIPXvs4/
	UtwKzXc6dOJsgHYOZD7nwhbtlD165ry+TInP3KQK09A==
X-Gm-Gg: AZuq6aKMxyfDLYO0aVJ9TVCqNeVtPRg5W6dYB71TcU90OBDruPDJLF7BQtmvQc8c6vP
	7T8zsp1StFKZ8aar5CrXoe6G0qJLOVbKHQREM/lOkd3WmHZTn8kzhp8oUs+7qaEXzlP3QzbfD9l
	6CjiXcZdxGQnwoCunKjyvLLBgub/FFjBH4kLY7VvLt7kD7/MrOdcrWjf9U7LBzOOtU+9wm+sFxw
	Iirajgp3apS3IurX5UquuEPuQonRjHp2R1FewS1aihnjXfMfa836/ER4sGm+J29suFaLBA=
X-Received: by 2002:a05:6512:68e:b0:59b:9a12:8902 with SMTP id
 2adb3069b0e04-59ba719c7f9mr6571686e87.23.1768904774640; Tue, 20 Jan 2026
 02:26:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1768232321.git.u.kleine-koenig@baylibre.com>
 <397f45c2818f6632151f92b70e547262f373c3b6.1768232321.git.u.kleine-koenig@baylibre.com>
 <CAPDyKFrman8YodyPNy6fSOYahoFKBuJRN6+Esz7ojmYqessEYw@mail.gmail.com> <v5jqdtpdj3zpuyo5owlujvifphjjxyygfrgqnmql664ck6vpc4@yvihqvp4lgka>
In-Reply-To: <v5jqdtpdj3zpuyo5owlujvifphjjxyygfrgqnmql664ck6vpc4@yvihqvp4lgka>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 20 Jan 2026 11:25:38 +0100
X-Gm-Features: AZwV_Qioo1xVJnMg6rdq9cvpXXwdbJnFq0ihxCbSVN1OxJlswmdZiRgfxeUuarE
Message-ID: <CAPDyKFpzB82-pHwr+RtdiXcHPDDXyVh2xD+BVM635hP3bSJ8AQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] sdio: Provide a bustype shutdown function
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Ping-Ke Shih <pkshih@realtek.com>, Johannes Berg <johannes@sipsolutions.net>, 
	linux-wireless@vger.kernel.org, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 19 Jan 2026 at 19:25, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@baylibre.com> wrote:
>
> Hello Ulf,
>
> On Mon, Jan 19, 2026 at 04:00:48PM +0100, Ulf Hansson wrote:
> > On Mon, 12 Jan 2026 at 16:47, Uwe Kleine-K=C3=B6nig
> > <u.kleine-koenig@baylibre.com> wrote:
> > > @@ -272,6 +290,13 @@ int __sdio_register_driver(struct sdio_driver *d=
rv, struct module *owner)
> > >         drv->drv.bus =3D &sdio_bus_type;
> > >         drv->drv.owner =3D owner;
> > >
> > > +       /*
> > > +        * This driver needs updating. Note that driver_register() wa=
rns about
> > > +        * this, so we're not adding another warning here.
> > > +        */
> > > +       if (!drv->shutdown && drv->drv.shutdown)
> > > +               drv->shutdown =3D sdio_legacy_shutdown;
> > > +
> >
> > Is this added only to keep the series bisectable or are there other
> > (except those you fix in the series) sdio func drivers that make use
> > of the shutdown callback?
>
> It's kept because I don't know if there are any other sdio driver in
> flight and these would break silently when they are applied between this
> series and the removal of the callbacks from struct device_driver.
>
> > In any case, when are you planning to remove this?
>
> So my plan is to remove this in a series where the last patch is the
> modification to struct driver.

Okay, thanks for clarifying!

Kind regards
Uffe
