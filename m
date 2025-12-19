Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C13333FE03
	for <linux-mmc@vger.kernel.org>; Fri, 19 Dec 2025 12:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766147088; cv=none; b=uwVB7Uv2PngJGdk+z0b+diwboTHQ91lvnhVMg8A1u6rMeivGm77K+tk4KTS73Ui6W6ak3ShHK5EXoyLNB3RxRyx581Vlm0wBz97bLhhE9FaaqdBDIuzzEd5zjtlL6odcy/nKfJryouCVM+mBJ9OT91ByxAdz4zZ62NtwdGnE2B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766147088; c=relaxed/simple;
	bh=7AVmeKHEYBCPOMpl1HCtc65QrPd5PEmY7neaytSasuU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DB7OjgLMIzRiiS9Wd0vgUx12/GwFOT/4EZ6JNngBdwmO+ZiFzLgHhS6jNJmceRznqMmoXVkb4jC6GlufyHeTqFKSUbBU6g09j1IssSvuWL5bN+Q320hRITbvJoJwtlxGx/WPALA+SRTjHpuo4I23Db8XlqehvJU63nqhMmKgAWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lZOf9nYd; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lZOf9nYd"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-37d96f97206so11452671fa.3
        for <linux-mmc@vger.kernel.org>; Fri, 19 Dec 2025 04:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1766147083; x=1766751883; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1fOSfl+6q/lUB1UVPybjZ2s8e57yOJ/pMd9yaLc+xqo=;
        b=lZOf9nYdZJWLuvd9E3oWQhwjS6furR7Ko1n8r0yACJJB8+8kR7ill5OpW3x7I7EmCj
         8x16HrEeW2MYzCkxKrn0flkNc6EJaVjrxFSSrYRTGUweHc0vIrX+tXiPYQRkvNpJLYPv
         IEmYbz1ZX3xhGwN8Bl9Qou8uwvqTiKo7t5tksovldxJQ17xf0UD8phT/EgrKhN4dmXpd
         90PTa881PXVdsZzzpDNhtmiLza1OXw44iHTIFTs+I7j/wqUIxI369d6OJK9G7vKZbfMJ
         5lb+0+wopZp36O1T8CWSPdTp/7C9+9gx0hpQPytkUpHzwiKpB6xGwKFxXkcGHoKj0GFe
         /8Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766147083; x=1766751883;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1fOSfl+6q/lUB1UVPybjZ2s8e57yOJ/pMd9yaLc+xqo=;
        b=KEViXRu8GZULI5ZsaYp8VBQwFBR7ijYGFqcdPlMxxy9j8fAQXpCQyBYf0qRsV9K6gO
         FdzhEMJ1OEa7TGOi2XVL05VJBOyIdRYiu5QYuBaH56w+AAxNvj/UsZ2XQq4Fxl9dldY+
         pyh50dCzP7eNnx2VBNB/iNRx9pHlYjCA9E3GvR0IVRWZG3S3tiZcLxMDSaZxSBx1yzsl
         wGEaUH3EEXwEwLznNMWT8vDF6OXY2P9Wh30tDaZPWK5M+YQhfcEG+rlmlL0KWMVdVpyx
         OIBUbAZgvIWeXPdok/7wXXCkRiD5+uMEt6wWzQInSjy8n2/NNmiSEQIVwcpHS55pr6Sl
         S6/Q==
X-Gm-Message-State: AOJu0YxdoSyXmy0aD6ue2u5Zvsqh3jiKjNhJ6hVYWq+OKWA/+O5y2s1v
	a437puN6caclPz97aBtPuvCjCZx4xHouDfrYYTatgkH/GdhlWIi42mfV7dfln6x6vYjrJZUOut/
	QalkjfWU+evnd/EubCVVaPHUw3AVXKMs0pX+6gTA3xA==
X-Gm-Gg: AY/fxX5gN0Uxkl3Saz7zQo0FaWvYtQekBK2oLOSXkidkNH4ctgZPlABPwoBZ2+MXEjk
	RoV12xgxLWuKgLsDVKyESn7y7J6qa/UbAMF5I2q/jjMhZxqGIa/ftOpFpfkHQO01WOGHTBrt0wD
	IAPArVrpiWVlPAmR1y/421EHwomeiuZYrnA6VbyJLViBgdCx10HKjVWS+IXdBRClAhOnrVxpvb+
	m1Y0pPeWPPpM+xD6gC7UOVwBJ+jk0caRq9Bsmnfx7aZrt5AzWCzYm99TZ1v61iDtllQtqv1
X-Google-Smtp-Source: AGHT+IEqEqTT3JQ7a04Vg9YJD0E7wTGkYd5J22WKXtaVaWHmXCMaPZ+CL8d0xtIqX4tXtdwmfYe0ztKJUti6oec/NGo=
X-Received: by 2002:a05:651c:f02:b0:37f:8bb4:88 with SMTP id
 38308e7fff4ca-381216bd8cfmr8552511fa.41.1766147083069; Fri, 19 Dec 2025
 04:24:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1765968841.git.ukleinek@kernel.org> <53a46d554faed2f28ac0c0e981ae12badf020cab.1765968841.git.ukleinek@kernel.org>
In-Reply-To: <53a46d554faed2f28ac0c0e981ae12badf020cab.1765968841.git.ukleinek@kernel.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 19 Dec 2025 13:24:06 +0100
X-Gm-Features: AQt7F2rxb3yEWUBTB67GPfxWs_btg12FwkTqcSidiq1mqsRo9eH-fu_ASfw1IBo
Message-ID: <CAPDyKFoQVh=WhB0AFFcwX-yeGM5s5cEFTUUS4LXnAcTEnikF2g@mail.gmail.com>
Subject: Re: [PATCH v1 3/4] wifi: rsi: sdio: Migrate to use sdio specific
 shutdown function
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: linux-mmc@vger.kernel.org, linux-wireless@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 17 Dec 2025 at 12:09, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@baylibre.com> wrote:
>
> This saves a cast in the driver. The motivation is stop using the callbac=
k
> .shutdown in rsi_driver.drv to make it possible to drop that.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
> ---
>  drivers/net/wireless/rsi/rsi_91x_sdio.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/wireless/rsi/rsi_91x_sdio.c b/drivers/net/wirele=
ss/rsi/rsi_91x_sdio.c
> index c2b2d09b616f..a1376847ac85 100644
> --- a/drivers/net/wireless/rsi/rsi_91x_sdio.c
> +++ b/drivers/net/wireless/rsi/rsi_91x_sdio.c
> @@ -1442,9 +1442,8 @@ static int rsi_thaw(struct device *dev)
>         return 0;
>  }
>
> -static void rsi_shutdown(struct device *dev)
> +static void rsi_shutdown(struct sdio_func *pfunction)
>  {
> -       struct sdio_func *pfunction =3D dev_to_sdio_func(dev);
>         struct rsi_hw *adapter =3D sdio_get_drvdata(pfunction);
>         struct rsi_91x_sdiodev *sdev =3D adapter->rsi_dev;
>         struct ieee80211_hw *hw =3D adapter->hw;
> @@ -1509,10 +1508,10 @@ static struct sdio_driver rsi_driver =3D {
>         .name       =3D "RSI-SDIO WLAN",
>         .probe      =3D rsi_probe,
>         .remove     =3D rsi_disconnect,
> +       .shutdown   =3D pm_ptr(rsi_shutdown),
>         .id_table   =3D rsi_dev_table,
>         .drv =3D {
>                 .pm =3D pm_ptr(&rsi_pm_ops),
> -               .shutdown =3D pm_ptr(rsi_shutdown),

Apologize for my ignorance, but why does an SDIO function driver need
a ->shutdown() callback in the first place?

What does it need to do during shutdown?

>         }
>  };
>  module_sdio_driver(rsi_driver);
> --
> 2.47.3
>

Kind regards
Uffe
