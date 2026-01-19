Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53DE37F74E
	for <linux-mmc@vger.kernel.org>; Mon, 19 Jan 2026 15:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768834890; cv=pass; b=gQEbQ4Exo/PxXkMd1wYKZ8MvxxLdbQhp9Bho5AOj9D+qe1AfW3chMFAm/+IKVy3dKBejc6PST8ugDWwri7//pDQiwea/W9sTzGzn6vwB96cS4tQgY9vO/lXOrb3rkfLs4EScDLz5CPNZBZfGuUPSShylyve8oha5gk+pYa+ymKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768834890; c=relaxed/simple;
	bh=ToP/wjEEUKdgWYrBRUQfG/i07QfxwnL87suiJ07Oc6k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u05sAJmV1HLC84nV/xCpC8l/8ckQjYnmEAe8Zvd997R0Kdx/JejQhs/GA42eLziDS2W+xhlmATcTP0fc6wqZL+mcqAK8d3lazpnE55SHyl1uHHlxABcOvo1aEKT06KEDF7xNK9mHL4J2ut4mOFPLvx/7EqVMp7Q7S/hLoYsLC78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ou3kprCJ; arc=pass smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ou3kprCJ"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-59b8364e4ccso4769300e87.3
        for <linux-mmc@vger.kernel.org>; Mon, 19 Jan 2026 07:01:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768834887; cv=none;
        d=google.com; s=arc-20240605;
        b=OOGiUP7maFujEijdP4vzsxRubst7K7TnkALNYQerqLzFn6/7HvzbGfaJxJU/nHUcQ4
         B3FdtYp2zzm9/lV60Bwj0+cAzOwRyJO4O39uWl0Y4UJHxw6qVhmEz4S63qaBnMMpTu0o
         0s5jxnx7xeiRssoa4khqySW4PJX7sPFnDrNu3KW5VROHLniTmZ8G8tauFl57MggUO8PZ
         WssK4iVY/7jlJq9zbwIMWLQ0kSu+SVToNaw5HfSzU8PYgCS4jZtvAszUqEZy1HqVo9b3
         OUKUYvv0tc9BLmCE6VIhnQ7VLn15hCH44az3Jw/NYxVFjqIVr1IPOb79NxUVGwo47tZY
         GOPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7en7/xIG4SBtAoiVCkkhvxRBMacBsb7Kwqq2bQY1J8U=;
        fh=zruFR665eCScwjEp2ig7ttm1ndlKL+WHgfcVL0TVYx0=;
        b=BLTrqlhJTxi6rGPjxPz+kk/x3UZp6AhN/k8Uz2MQrGLGOHJFmw2FHDq30tI1ipAvKd
         xhpjuTgaCeK8CuDIsYFY8GyhwnXTv+yBG3t3OeTdSTY03OL5L3QpDAjXoDUyPkd0AaV0
         0d0URJJRmRaWxzAbp7BxeRe5Iv0S9nntgfRryBeWVjgmAec+8r7CJkCD3Ygs5e1Jtnji
         BAMzEoRSCNNI9ZH1mifnwQ5haNacpjWIJiaxeamnUrh6J0mmmESV42jN9pbs6WruxIjX
         BaemKCP9shNHGldYZogsfIVtk0WkMEaQ1p/KSgwjlgxZE8/c+512q7fzbiKswnJKQn49
         UlEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768834887; x=1769439687; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7en7/xIG4SBtAoiVCkkhvxRBMacBsb7Kwqq2bQY1J8U=;
        b=Ou3kprCJfmMOcNKC5GNUv3/3TTqeJUavhAMs7QxcRK8ZAnVe7aEMKP55rx5N7JP1cV
         yrRbxIxy08vJ1pOFgLqzNfatWJPS9YkCF9SRbevo+8Lby+tWh4PROtYPi1DgB1jTI6Wn
         w/Q9Mw1eDl1ci3B4GjOmiBjleR0c8VkCCeA+O/NGF2yo1VcDaxs7Gg/u31CoxTjVT0NM
         RJkDWkhC3LGOwfkCV8hj7E14lq6BSimEFaumnqeypwe/TjsUi4U/Hgi7xGPSvXCl9QJ+
         HR4BvfUxxnS5+8pAeL2TEX3Mx6Ho0uja4nQiv979Pjii5k+a7jZ+gqoxIIa8lqyRI/AQ
         WGBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768834887; x=1769439687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7en7/xIG4SBtAoiVCkkhvxRBMacBsb7Kwqq2bQY1J8U=;
        b=UMGyTlTZBYoXga09L71liTv8lRY5GvjYOIFKyiPnbwvBLzqj7qrPeGRZmLgKofo6F0
         XOPEtSQN8IcKSAKPhqdWlmPw6MBQN19A7+qaRgVc9bL3I9S2A8hnlVszYznit+RBXJhv
         jc0btAEA3AWgH3ttKeuBFlhEkkexUu+MdmYI5EPN2SKvA7ihmR65lEzAVuCNMvwzs9D+
         DGRqPa8R+iuM/o4sA02y1YDE+bqOyhIPiA5dcHYwCsXTc0ZbyyrMCaKxTVGl9ddapAlH
         dMezs4M/QlKPl5X/GS/qJyt8fqzFo6xNITI0aiLtQ0NvP4OTniL0uo1FIDWKcTkoW4es
         MP1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVRLIvmMrX5rHqL1AkpY+KtNGl4EJBVFe83evlBf0xB24/NWoHVNvX7AFMk2CHQsSt0oJ2YKm9bVpw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjgssLyLAc4ETuSaIR2mmolJQBYq5NuQaOwr8kDg3+6LDI23l7
	2XF/AOA0ZcK1WpA6k0rdgWsaN7Wi2aFs6BQny2xdDPRfQvF2LTmp3qL48w3ZBhicVtOLojJ7YRh
	KBNyeQlclOzEBCPSftmESOhfqNhTdVAhfDQI1iAO5Jw==
X-Gm-Gg: AY/fxX659WXJu7KMQjpM5E5/seKNV57yH0i/z4/egNNsmkbSGCeAv731yhPN7wx6O8w
	+6dqLnAbTc4kMhrnELYlNaPW7q56/gB/xhn5aPg2Jc3wlP2eeqopZyfmsDK4uQ9hKRwlgrpf1Bw
	SN4Rd5MJGP/SMZY0OxyciJ+PZottWcF0fnlztBoID3/Hq7vrZt7AoQQoE74n/OtJ//x+tTT3XEq
	BBLOviV5+qTcIg14ao4wM5hwZaoCsyVjXzlQKHY9KaYaUF4qUK5q6U9YEImUGzxV6FACu5+
X-Received: by 2002:a05:6512:b98:b0:598:ee60:8af1 with SMTP id
 2adb3069b0e04-59baeed3ebcmr3912991e87.15.1768834886687; Mon, 19 Jan 2026
 07:01:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1768232321.git.u.kleine-koenig@baylibre.com> <397f45c2818f6632151f92b70e547262f373c3b6.1768232321.git.u.kleine-koenig@baylibre.com>
In-Reply-To: <397f45c2818f6632151f92b70e547262f373c3b6.1768232321.git.u.kleine-koenig@baylibre.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 19 Jan 2026 16:00:48 +0100
X-Gm-Features: AZwV_Qj4grH1RKk5qfKA25XGG5qhWfI8EZrg4Dt6c7jkFfG6Ya_nNj2n7M1gxV4
Message-ID: <CAPDyKFrman8YodyPNy6fSOYahoFKBuJRN6+Esz7ojmYqessEYw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] sdio: Provide a bustype shutdown function
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Ping-Ke Shih <pkshih@realtek.com>, Johannes Berg <johannes@sipsolutions.net>, 
	linux-wireless@vger.kernel.org, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 12 Jan 2026 at 16:47, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@baylibre.com> wrote:
>
> To prepare sdio drivers to migrate away from struct device_driver::shutdo=
wn
> (and then eventually remove that callback) create a serdev driver shutdow=
n
> callback and migration code to keep the existing behaviour. Note this
> introduces a warning for each driver that isn't converted yet to that
> callback at register time.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
> ---
>  drivers/mmc/core/sdio_bus.c   | 25 +++++++++++++++++++++++++
>  include/linux/mmc/sdio_func.h |  1 +
>  2 files changed, 26 insertions(+)
>
> diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
> index 10799772494a..6e5bdc2f0cc8 100644
> --- a/drivers/mmc/core/sdio_bus.c
> +++ b/drivers/mmc/core/sdio_bus.c
> @@ -232,6 +232,15 @@ static void sdio_bus_remove(struct device *dev)
>                 pm_runtime_put_sync(dev);
>  }
>
> +static void sdio_bus_shutdown(struct device *dev)
> +{
> +       struct sdio_driver *drv =3D to_sdio_driver(dev->driver);
> +       struct sdio_func *func =3D dev_to_sdio_func(dev);
> +
> +       if (dev->driver && drv->shutdown)
> +               drv->shutdown(func);
> +}
> +
>  static const struct dev_pm_ops sdio_bus_pm_ops =3D {
>         SET_SYSTEM_SLEEP_PM_OPS(pm_generic_suspend, pm_generic_resume)
>         SET_RUNTIME_PM_OPS(
> @@ -248,6 +257,7 @@ static const struct bus_type sdio_bus_type =3D {
>         .uevent         =3D sdio_bus_uevent,
>         .probe          =3D sdio_bus_probe,
>         .remove         =3D sdio_bus_remove,
> +       .shutdown       =3D sdio_bus_shutdown,
>         .pm             =3D &sdio_bus_pm_ops,
>  };
>
> @@ -261,6 +271,14 @@ void sdio_unregister_bus(void)
>         bus_unregister(&sdio_bus_type);
>  }
>
> +static void sdio_legacy_shutdown(struct sdio_func *func)
> +{
> +       struct device *dev =3D &func->dev;
> +       struct device_driver *driver =3D dev->driver;
> +
> +       driver->shutdown(dev);
> +}
> +
>  /**
>   *     __sdio_register_driver - register a function driver
>   *     @drv: SDIO function driver
> @@ -272,6 +290,13 @@ int __sdio_register_driver(struct sdio_driver *drv, =
struct module *owner)
>         drv->drv.bus =3D &sdio_bus_type;
>         drv->drv.owner =3D owner;
>
> +       /*
> +        * This driver needs updating. Note that driver_register() warns =
about
> +        * this, so we're not adding another warning here.
> +        */
> +       if (!drv->shutdown && drv->drv.shutdown)
> +               drv->shutdown =3D sdio_legacy_shutdown;
> +

Is this added only to keep the series bisectable or are there other
(except those you fix in the series) sdio func drivers that make use
of the shutdown callback?

In any case, when are you planning to remove this?

>         return driver_register(&drv->drv);
>  }
>  EXPORT_SYMBOL_GPL(__sdio_register_driver);
> diff --git a/include/linux/mmc/sdio_func.h b/include/linux/mmc/sdio_func.=
h
> index fed1f5f4a8d3..4534bf462aac 100644
> --- a/include/linux/mmc/sdio_func.h
> +++ b/include/linux/mmc/sdio_func.h
> @@ -78,6 +78,7 @@ struct sdio_driver {
>
>         int (*probe)(struct sdio_func *, const struct sdio_device_id *);
>         void (*remove)(struct sdio_func *);
> +       void (*shutdown)(struct sdio_func *);
>
>         struct device_driver drv;
>  };
> --
> 2.47.3
>

Kind regards
Uffe
