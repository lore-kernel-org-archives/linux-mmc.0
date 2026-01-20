Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567AF3BF30C
	for <linux-mmc@vger.kernel.org>; Tue, 20 Jan 2026 10:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768904872; cv=pass; b=BzJr5+5W2ldyCqcw9zCz8lKYCcYf/N184hZ/KZasdubhjf+ZRiGERMZbo2akDUqGMMuU1Y1jriqpF6T/fXXu1ughV5ty+MeqBI6MRYk8KsLUVN0XXlACXXfBZHz/BskqI1laTGybo3r4HT1S25FJfykgHyMRs4RrYkNlQse6LG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768904872; c=relaxed/simple;
	bh=07idC1GmCrNrfYK8Qy2V4mxBASfpPWP6F+yFcUb/4fE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ACY9FQKsaFFfIrHdc5Z0lN8ZxM9SbIz6uFMG94mN640E1pPa07b+85zf2AVgu/QuT1hk/PjLbi/wP9wvrL+/zsPrGxUg3MkZYR2cpbAyZ2eDRgm4IubftUYiD1zsrL4LK6ZPWJKtRf6FlbqJxAZToSVfibogNubnWIcUThzIAe4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Yuf7OtuU; arc=pass smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yuf7OtuU"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-59b6c905a46so5350141e87.1
        for <linux-mmc@vger.kernel.org>; Tue, 20 Jan 2026 02:27:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768904867; cv=none;
        d=google.com; s=arc-20240605;
        b=DmvQ5KsOLMWlYFmAXVik8XMqehHQqOKbBClUviq7V1RLZgYufsdz1jXIPsoC7DzcAw
         Yc//IUWi6nDNWNTo+fnknHaNIU4R9oBSyQCo2JP9T4ndUf6gVXNyGAC5Ph8jhYrKbVDT
         4v/GvNBgGcr4VDdIMp6D/OH24d/L0N6m/Af+lEWVET2MV/9GuDS6PBr2hLCLbiJfWWF+
         1DZgqa3GT81nl6gzN3vYfHQjttaLW46PIRaGJNrz2D3fLQkhhTUxv7nYxuKfIgZx0O/k
         mTuGNDZeWP5Z1EGyXTttJo/hyhC/NxINY/DulzaBx3I70JleUSMyRdwqgosuQj4jboOn
         Mi0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7zcWF83k9wfYKZ/pKRWhqE/Kqb04cd3WQEzcDFN468g=;
        fh=G2+tzcQHL8rArM2+daSmfuMdTmvrHOOFXMhdergGM98=;
        b=em9iQKN5HnbaQYhb2B8czrRKC+dUCUWj5+1BU2RSTWIOkKN+koVJ2jewql1t7oEnBd
         6RleeAlXFGBVW6+nWgcVYVOl8udGVabIvKN7TR915C3R2K9MVjnsEXZIG/mL29LYhZqo
         yasWdf4IlZeFYoATq35bW8A/kcbKXuuJx5lhyDTD2uX/enQfaJ44GEXWY15oafpBxnNc
         AUHKpqlzeEB8ND4ty+WKoeXqu6PQT6sVUJK2tF6hakByIPDNNVIkQKmRLpkIwP/U9JfT
         7073o0wB384F+TFRxYlZGSImdizlb39ba0GtB3oTYsLNITZujKW48Zxdqnxggy6gox5a
         LfeA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768904867; x=1769509667; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7zcWF83k9wfYKZ/pKRWhqE/Kqb04cd3WQEzcDFN468g=;
        b=Yuf7OtuUDfS5/lsLHSZMaQDKnJWqMRmw1ckG7aEY7USvvKCMTFqSy4gQCm4oHm6lGd
         vNQT++mqJwJdtwXaVABNudNiRl1N62sQ/JEGIJnbpvaStn5Ge4X5CIf2Om9vS51ejGIs
         T/Qpp3fvGwfaVrtp7bojdmD9YAGlLBRERmoKwtHXa52V9mVdvbUEU9YZhNfccZqnWqed
         8x8slOqi1oUuyGd1g5hoCp5HEcKY8FGUcuTS0C0Vm17cJWfgUW7+pENTrUf3ntWtwDSp
         Bi3s5M8cN356hZqJeB18ft6QYI51/fTORWoVp+k8aRPcylMRhopubtMgulYYOj7M0vRE
         7zLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768904867; x=1769509667;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7zcWF83k9wfYKZ/pKRWhqE/Kqb04cd3WQEzcDFN468g=;
        b=RMYCyyc7ptavja/NctJmAK62q1Q5iB5c7UoJPI+KEcNOQQNR7eVBH8JXLON70jEVQW
         cpV4IrwxsZcZNCeO8lr5/Q4FHr97Yg07bSj10feO1rTD4DkocbAXmh980oxpnDfdUhZz
         SO2GJMqmZdKYRjgCC+XxHMb3YJT9mziXPtsELpcvijzRfyC8CCj2fy1MrEOZvU2vKd5j
         TRySCmvzdHIVB2I3rcDH3B2aWKQ3wGBPrCC9JV3FJrRyy1pomfICoxjtkYhk5lhij3fP
         zH6/pWSeJ6ABIRNWZEYYIbS10ny1CACYZKUJJxAOkoLZKk8TMVqTmR7+6/Viy7IhTOmY
         oEhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpe1M6WWVJU1KCtOOVMHtQMaVhQB7BubR/gVC7JdKqd9TjH82WEZ8lSYd+UdnIttVgpr2Iq+aaauQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywdq7XFVrM+rriixdoQG3Sdpc2AOhLJOlu1By2q0Wj8458Mu8AN
	H06IWB7VznNgdmWr5anys/a2IUwWf/fCPgoyrP6t1GrBcn9QY+0glM2rYMYXUL38GDj4TTegdO3
	ZsvGoZZHbWgfkrGslVAnFpmva8F9l1f6+KlWD69lNNw==
X-Gm-Gg: AZuq6aLJnk3XbFDv4xn7lA3TJLyqFAw+1WrOFYF11FdigekNIhivi14g/MXquokHy33
	/dxftmMhfjL40u5M1S7F1QSvYSO3VDEzKi7UWV390iwjqmF2ROEDb81Moi6DlpFTBJKTjNH2K/k
	S5E3badiECVy2H55bCGeBeQBBqdoyrx4/SbW9h+vhTR65xgxdM0Ktt4WVlODGf3EABK3mDCGVES
	wRLhEnmN3OAELCM7vAhyQo8aPoaIS+Nb72as6yEqseQ2vTOi5kl5U2hG1YbiT5fAw/EG1jWMlmF
	fc2HIw==
X-Received: by 2002:a05:6512:8011:20b0:59b:b3df:cd79 with SMTP id
 2adb3069b0e04-59bb3dfcdf6mr2962095e87.10.1768904867209; Tue, 20 Jan 2026
 02:27:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1768232321.git.u.kleine-koenig@baylibre.com> <397f45c2818f6632151f92b70e547262f373c3b6.1768232321.git.u.kleine-koenig@baylibre.com>
In-Reply-To: <397f45c2818f6632151f92b70e547262f373c3b6.1768232321.git.u.kleine-koenig@baylibre.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 20 Jan 2026 11:27:11 +0100
X-Gm-Features: AZwV_QjFjXjc-U8euh4MC9z2kFcNJA0P9wX41pDZQ4VLxKcd4e9zNglVFRdV4L4
Message-ID: <CAPDyKFrinbj0QdL4rAP7zCvcnc6kGRQDTbiq1H0nRd+-B+HWnw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] sdio: Provide a bustype shutdown function
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Johannes Berg <johannes@sipsolutions.net>
Cc: Ping-Ke Shih <pkshih@realtek.com>, linux-wireless@vger.kernel.org, 
	linux-mmc@vger.kernel.org
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

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Johannes, please pick this via your tree. And sorry for the delay in
reviewing this!

Kind regards
Uffe

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
