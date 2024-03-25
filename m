Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0634174953
	for <linux-mmc@vger.kernel.org>; Mon, 25 Mar 2024 13:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711372792; cv=none; b=XK84iNzpx3OOKfoFhViTMeQG5RHOV3NQZriEypc3pNLHibssjfrA9RNRkWmCrX8UMWsyO0x5W1PILghDbLGl6lIgZSZEEuR7QHpqNvkKgAMt/n+ZrxyCbYkcf7Nn8l4joCpBDn86Ae3CXQJhsDSfssxk5c4RHCDXHLpZGRKOHdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711372792; c=relaxed/simple;
	bh=6U0usObrly34Br1A2i1J5xtvAeOTtoPhriMbvHNM3sA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ev1PDwMnicUY++C8lWZIAMZPJEZKa92ZPBu/GTUfG/eef/gEeW/3RkewHA+mX7hX4bVVBt/tZkyCWB/QxeydXbA1V+KHEhegbaNYI34Pb8wa4j3FTXIBAH6+AbilFKUJ9d0MZv71FzkFiuJeuPHY4CTJ0WrJgcHaMqyHNKQuLRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jCvYVi4y; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jCvYVi4y"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dd14d8e7026so3728177276.2
        for <linux-mmc@vger.kernel.org>; Mon, 25 Mar 2024 06:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711372790; x=1711977590; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S40U5XpE5e+tWnCzJS15XcSV9C7o9+kj8MqbVXjyTG8=;
        b=jCvYVi4yO6pZ2QgO5nDo9fCj03Z/TINViJZIuvTJnjjG1+AW/q/HOeBLw40nblR3fi
         ezqmggdTQhZ25RNcGlWBEFnknxvY5/Z7O/V8CpNxYrD0KohvQyX3po4SyzVq69NTHu+x
         ttN1lgWBLPAdVVafjmVKPPHBCxq/hfPaWZjzEhfSD17vRhniP+6QMR6jEO07KsVV1h/g
         rx4qYmInrCe5d5UT0wphD5OeLIIwheQQcXD5xBur1aDMn9aIuKjW5ypBSZPz5433ChdK
         ouu9nosy4Ug9w/PFTBqaz13xkQpyHSNdso2gWK5WaHZbD4qLj3jZ3pLDCCIaVTdkqoIK
         gBbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711372790; x=1711977590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S40U5XpE5e+tWnCzJS15XcSV9C7o9+kj8MqbVXjyTG8=;
        b=Z0hXIDHvZtBj2O7IKNBXyULuCkVa2D/pFGc8GpcaO/abxI6c6TekQZXbWj4GvvXPhb
         JvHFJXB2O50JJ9CGfUHop5IpGYlNmW+ZdIzxFrqpPd3vrpIj+vy28Jh/xS/3EQ+P66aw
         wB5xWHGndNlr2h02bPSzdr36+Ypn6ico7jvaowJlnBMjXv/pIDlfGksrciobsMlbnWyT
         o3QSLR92tru808R70J83CuODyTkcBDEMn1JYRAJDCeEUqPcHvrfpFt3HTazdxZ3/2jj8
         6AxGajRHq7eUYjxjt+vuNVVUli6bfs/6AHtKg1Xj8Eo3LultowWwjejs9YQD9QQTCkw/
         3hOQ==
X-Gm-Message-State: AOJu0YyagEI/yktQnfmTdycXO3bCOtfjiiR4HS8FqCzHW9eGEurlUAMN
	96Wb62QK19UCNvwsKfeCLamB/B1McP8ivMtnlk9YWU2env2fY5cDqddSlvaJedpngHqSY86B4xO
	mbikStpcbLfhVaXu6AgNMOHkE4K/6XbVzeGstJXbknQZYCCQ5
X-Google-Smtp-Source: AGHT+IGG/7/pUr8ycONWdS+EDFipNdpQb+5K6+jBwlbEkrGfGrU6iF0fdmcw9WS+RAU/chmOIbJQjoEutettmwm2sUE=
X-Received: by 2002:a25:e08a:0:b0:dc6:8534:bb06 with SMTP id
 x132-20020a25e08a000000b00dc68534bb06mr5191321ybg.17.1711372789892; Mon, 25
 Mar 2024 06:19:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240324114017.231936-2-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20240324114017.231936-2-u.kleine-koenig@pengutronix.de>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 25 Mar 2024 14:19:14 +0100
Message-ID: <CAPDyKFrdTLZjz=dysrz073c0_r=TnRz-D=sq-xkLHkwKfPndhw@mail.gmail.com>
Subject: Re: [PATCH] mmc: davinci: Don't strip remove function when driver is builtin
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-mmc@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 24 Mar 2024 at 12:40, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Using __exit for the remove function results in the remove callback
> being discarded with CONFIG_MMC_DAVINCI=3Dy. When such a device gets
> unbound (e.g. using sysfs or hotplug), the driver is just removed
> without the cleanup being performed. This results in resource leaks. Fix
> it by compiling in the remove callback unconditionally.
>
> This also fixes a W=3D1 modpost warning:
>
>         WARNING: modpost: drivers/mmc/host/davinci_mmc: section mismatch =
in reference: davinci_mmcsd_driver+0x10 (section: .data) -> davinci_mmcsd_r=
emove (section: .exit.text)
>
> Fixes: b4cff4549b7a ("DaVinci: MMC: MMC/SD controller driver for DaVinci =
family")
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Applied for next and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/davinci_mmc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mm=
c.c
> index 8bd938919687..d7427894e0bc 100644
> --- a/drivers/mmc/host/davinci_mmc.c
> +++ b/drivers/mmc/host/davinci_mmc.c
> @@ -1337,7 +1337,7 @@ static int davinci_mmcsd_probe(struct platform_devi=
ce *pdev)
>         return ret;
>  }
>
> -static void __exit davinci_mmcsd_remove(struct platform_device *pdev)
> +static void davinci_mmcsd_remove(struct platform_device *pdev)
>  {
>         struct mmc_davinci_host *host =3D platform_get_drvdata(pdev);
>
> @@ -1392,7 +1392,7 @@ static struct platform_driver davinci_mmcsd_driver =
=3D {
>                 .of_match_table =3D davinci_mmc_dt_ids,
>         },
>         .probe          =3D davinci_mmcsd_probe,
> -       .remove_new     =3D __exit_p(davinci_mmcsd_remove),
> +       .remove_new     =3D davinci_mmcsd_remove,
>         .id_table       =3D davinci_mmc_devtype,
>  };
>
>
> base-commit: 70293240c5ce675a67bfc48f419b093023b862b3
> --
> 2.43.0
>
