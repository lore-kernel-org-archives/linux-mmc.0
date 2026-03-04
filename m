Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE3B20E6E2
	for <linux-mmc@vger.kernel.org>; Wed,  4 Mar 2026 16:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772640272; cv=pass; b=YyPQaw1lfzMUlTUTK5y6FkKA21Mmw2v+5fvCSASxFMh9Em6X0T1QsA+xW+giaCVhj25LENuF70cAlBFOs7aJCHfM6ktHCZCqsR3cWhkl6mxQrNVURGrNUobjQQBsYQ1JTGs1rx1pxvnOVcbacSjdp7KUgC8zmNi0dQjzJUeApN0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772640272; c=relaxed/simple;
	bh=pU+3H5KjTIjCf3g3yU3tSGtSdSzvq1D4OWRpNq//49U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PwCBGka0XFKAs1J+mp4sgOeHhLfBEEX4YhBBhU3ST1w83+1jqZeHn8LwsBh8EEG2Calwj4p9W/BJoFp3jCYTLtIbkXFj2Gj1F3ePil4AWrPZ57dmePV1u8V4SQiYrO+8ny5exrHuHoirXOx5brnBeSU5vp0HmYJSfBAsywgRRtk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LKfZ2vwy; arc=pass smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LKfZ2vwy"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-389e139ee5eso122307721fa.0
        for <linux-mmc@vger.kernel.org>; Wed, 04 Mar 2026 08:04:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772640268; cv=none;
        d=google.com; s=arc-20240605;
        b=CC+wZbtM1HbMsqeIIjcXZo5ZSk0kF5IWdGmGgK7P37keIv6WJonklxQN26k9qBe2V1
         xPV6u+h6kEBSL96v5tttQ/vBRSRlMc2NQuasuE9YCKpnz6gNvE/4XDjwnHDtZ9cagmfq
         ayAMLNfdSLkhoQoHRT0Ma0SZeg1UjG4Ug6l/jJSeeIxc9j/mgnO5CqboekZ/9xbJ69O8
         oeNUpGkwDX60qjDpr+PN28+M7x8XAPyF9SflZ50zp48XGGEvcP8W2xuRpdPv6oHIQgB4
         Ok3Fg3mNdWIQAO2mjP77MhqLgvuUANUUsFQYOV8Q4COh5TlDv9crpBkOLmqQsqQc+Urt
         nhmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=X6VV//0BbRdnMvTRMP5NWmCJkEE3JMIsqRqxcg2IjNQ=;
        fh=fRpMHzkAenhrm7Oo7xVws8SWpB5GO9agDU1+lpS3DIg=;
        b=WvQwWACkfBN/4nUe3WBdervjDCZqTvviDX53m+ejskowwptGJSfPbi8eFmQnrUAkSV
         PMwSeghJtHxZ+EvBxYpjgFDDXd1AVhHCpuoiS2J3XEG6T7bBRYOyEmUdKHiIGjyouuZq
         Czu4amzqFBAb+y7JBRLo3dQcS4tSKBt9O/XZbNMgLv/iQmwrBhnbLqACmBt9g8qBqj6s
         TuYHdo8HtXLJ1eIGIq58DBTXpClPoXy9Fmh146iUwoSYOzkLuoNwmpF7Yx2Kaea7i+e1
         l1ANFVKwLgniP17fUNQRV/B2IlTwhyTy6QYnY+3suhE0op7PWnyJKozeDgDF0ZzDGR4Y
         GStQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772640268; x=1773245068; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X6VV//0BbRdnMvTRMP5NWmCJkEE3JMIsqRqxcg2IjNQ=;
        b=LKfZ2vwy2SOjS61NzlkAHEVESnvG8UMH6ZhTa80Lf4H43FyA7Hk5lGtUtfL+/r23u3
         2E1otTQPNuP0x6zgvhbo5odTErI+KT3Yhnzavbu/Tr0tvhF9YM6vQUMPRp0EDrMqpIOC
         ubSCyUDKJf/LpkdCIAscQ5Eh8s5Q1PLTcNdgU16i6kY1nKQhlBc0rNlU5uILh5NNhmBi
         wn+u88EgXxb4A9DVntN2odMOBTvGWFaI1HiNz5GRqiZAlYDOsVE1VRGs3iZ4pv8Iey4x
         yihRVkbOPNsj/jEZ/IIMD5jzWjSFCkrEYgNN0kqNgpi4AcJwE6OUBNGDdrIsfpoJoOaR
         cOMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772640268; x=1773245068;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X6VV//0BbRdnMvTRMP5NWmCJkEE3JMIsqRqxcg2IjNQ=;
        b=QiAPg4vYYRsTrcETclBByLW1/TXlHiKIsDLp2hkQhpH8Cn7ZuaMbvh0n96KA0XrH0P
         PwJ95kjGWvHSvEHpIEHqGXhLa0kHjQbcAX5n3lcqg4cYNpkfR9bt2kfdNMVWoru6CzXw
         ruyXgc1EimTs9cVCk6tWE835JzXpqf8AgRvVfWLOdtpl582FL0h2sST4wHNdtqOTpAjO
         UggxpjA+ynUbnTfjfOP4cCI+zbgpg0I2ugrzdgzMSl8ijE8lV6oCyQUUnbycZLvbfqPp
         kdPrJDjNK6zV12X104HfWDZ1hD232g+/E84l9Pp0qrJyptv+uCbajw9omz42KoeK/wOU
         hVxg==
X-Forwarded-Encrypted: i=1; AJvYcCXyI0nU2nE17C2sRNS6RnVYpSNmXMLCJq3hZFq8gTlXyVKR4JfW1tQksqXwC73L/pfD36M/qZdWn4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YztToFB6QsM95dxLUhgA0c88Wy9s75klVWpLA0x1MI4jhssBYq4
	Ze8z1SM3gAufpNRfJYrZhVp3kesAQ6g8ok8XwDHmevUgArWmWU3IzLgoeMSU3bY0O2lI2K+OHot
	GCs3BkLQhVZ9yRNFdf692sj82y1Sp1vhBKwwinMpm7Q==
X-Gm-Gg: ATEYQzzZvzm0sp5fEs8WLbGo6bIaDaHHTDylv8swPtRysv/dlPh/VdIvYdljL/VzPW4
	6u8wFqSKmpqKCZYha3RrIfob6N1ptJmnZUds7+i8k8IDEdAjW1u2S282j4Rrzf1qNpCb4YtHTar
	ZypYZHcgN3CB1L3HXZrzgX6u4AAnsogN5XWv7s6pq4Kfv6JxoQFiUap8uZpCOa5N8ni8vkzpgQ2
	7a6YI1bjtg/ugW0l79gqv43M+I8U0aBUHVA3DXqayxZs2jQGA6K0Fbr8vYt1IdubHIY6Rxo1kO5
	lBUuiED6
X-Received: by 2002:a05:651c:1510:b0:37f:af92:1c03 with SMTP id
 38308e7fff4ca-38a2c5972f1mr25096681fa.12.1772640267747; Wed, 04 Mar 2026
 08:04:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220194725.1341281-1-sergey.suloev@gmail.com>
In-Reply-To: <20260220194725.1341281-1-sergey.suloev@gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 4 Mar 2026 17:03:51 +0100
X-Gm-Features: AaiRm53hGnZxwAIpUL8zLlSc8DF4TSmVCIL_21d4iT3X7bNxfCCFnO_A3djKlrI
Message-ID: <CAPDyKFpktWMvA=wQK_Am_8dJNT+_WFQ-6=gQrq4462rG5G4w4Q@mail.gmail.com>
Subject: Re: [PATCH] mmc: pwrseq_simple: fix probe failure when
 CONFIG_RESET_GPIO is enabled
To: Sergey Suloev <sergey.suloev@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>
Cc: catalin.popescu@leica-geosystems.com, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+ gpio and reset maintainers

On Fri, 20 Feb 2026 at 20:47, Sergey Suloev <sergey.suloev@gmail.com> wrote=
:
>
> The driver uses a heuristic =E2=80=94 checking if exactly one entry exist=
s in
> 'reset-gpios' =E2=80=94 to decide whether to attempt reset controller API=
 usage
> via devm_reset_control_get_optional_shared(). This is semantically
> incorrect and causes a permanent probe failure when CONFIG_RESET_GPIO
> is enabled.
>
> When CONFIG_RESET_GPIO=3Dy, __of_reset_control_get() intercepts the
> 'reset-gpios' DT property and attempts to register the GPIO as a reset
> controller via __reset_add_reset_gpio_device(). If the GPIO controller
> is not yet fully initialized at probe time, this returns -ENOENT instead
> of -EPROBE_DEFER, and the error path does not respect the 'optional'
> flag, causing pwrseq_simple to fail permanently rather than defer.
> This prevents mmc1 from probing on boards that use 'reset-gpios' for
> WiFi power sequencing, such as BananaPi M2 Magic with AP6212/BCM43430
> on Allwinner R16.
>
> The correct indicator of reset controller intent is the explicit presence
> of a 'resets' property in the device tree node, not the count of
> 'reset-gpios' entries. A single 'reset-gpios' entry is just as likely
> to be a plain GPIO as multiple entries.
>
> Replace the ngpio =3D=3D 1 heuristic with an explicit check for the 'rese=
ts'
> DT property, making the behavior unambiguous and immune to
> CONFIG_RESET_GPIO interference.
>
> Fixes: 73bf4b7381f7 ("mmc: pwrseq_simple: add support for one reset contr=
ol")
> Signed-off-by: Sergey Suloev <sergey.suloev@gmail.com>
> ---
>  drivers/mmc/core/pwrseq_simple.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/core/pwrseq_simple.c b/drivers/mmc/core/pwrseq_s=
imple.c
> index 4b47e6c3b04b..780c8818a273 100644
> --- a/drivers/mmc/core/pwrseq_simple.c
> +++ b/drivers/mmc/core/pwrseq_simple.c
> @@ -124,7 +124,6 @@ static int mmc_pwrseq_simple_probe(struct platform_de=
vice *pdev)
>  {
>         struct mmc_pwrseq_simple *pwrseq;
>         struct device *dev =3D &pdev->dev;
> -       int ngpio;
>
>         pwrseq =3D devm_kzalloc(dev, sizeof(*pwrseq), GFP_KERNEL);
>         if (!pwrseq)
> @@ -134,8 +133,7 @@ static int mmc_pwrseq_simple_probe(struct platform_de=
vice *pdev)
>         if (IS_ERR(pwrseq->ext_clk) && PTR_ERR(pwrseq->ext_clk) !=3D -ENO=
ENT)
>                 return dev_err_probe(dev, PTR_ERR(pwrseq->ext_clk), "exte=
rnal clock not ready\n");
>
> -       ngpio =3D of_count_phandle_with_args(dev->of_node, "reset-gpios",=
 "#gpio-cells");
> -       if (ngpio =3D=3D 1) {
> +       if (device_property_present(dev, "resets")) {
>                 pwrseq->reset_ctrl =3D devm_reset_control_get_optional_sh=
ared(dev, NULL);
>                 if (IS_ERR(pwrseq->reset_ctrl))
>                         return dev_err_probe(dev, PTR_ERR(pwrseq->reset_c=
trl),

Indeed the existing code looks a bit weird, but checking for the
"resets" property here should also require an update to the DT docs
[1].

I have looped in the gpio/reset maintainers to get their opinion on this to=
o.

Kind regards
Uffe

[1] Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.yaml
