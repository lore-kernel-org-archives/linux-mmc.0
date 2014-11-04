From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [Regression Resend] mmc: mx28: sd card detection broken since 3.18-rc1
Date: Tue, 4 Nov 2014 11:30:59 +0100
Message-ID: <CACRpkdZ9oYZ10btdvQSAnZhPaxYn_n6JbAUO4h8qadeAiuJq-Q@mail.gmail.com>
References: <1747777414.897866.1414878004147.JavaMail.open-xchange@oxbsltgw09.schlund.de>
	<5456B7B3.60401@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:42638 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751651AbaKDKbA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 4 Nov 2014 05:31:00 -0500
Received: by mail-ie0-f182.google.com with SMTP id rd18so7308714iec.13
        for <linux-mmc@vger.kernel.org>; Tue, 04 Nov 2014 02:30:59 -0800 (PST)
In-Reply-To: <5456B7B3.60401@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?UTF-8?Q?Kristina_Mart=C5=A1enko?= <kristina.martsenko@gmail.com>
Cc: Stefan Wahren <stefan.wahren@i2se.com>, Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Fabio Estevam <festevam@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>

On Mon, Nov 3, 2014 at 12:01 AM, Kristina Mart=C5=A1enko
<kristina.martsenko@gmail.com> wrote:

> I ran into this issue as well. Seems that a card-detect flag
> (MMC_CAP2_CD_ACTIVE_HIGH) can currently be set based on an
> uninitialized variable, which can lead to the card being reported as
> not present. This patch fixes it for me:
>
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index 03c53b72a2d6..f0e187682d3b 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -311,7 +311,7 @@ int mmc_of_parse(struct mmc_host *host)
>         struct device_node *np;
>         u32 bus_width;
>         int len, ret;
> -       bool cap_invert, gpio_invert;
> +       bool cap_invert, gpio_invert =3D false;
>
>         if (!host->parent || !host->parent->of_node)
>                 return 0;
> @@ -401,6 +401,7 @@ int mmc_of_parse(struct mmc_host *host)
>         else
>                 cap_invert =3D false;
>
> +       gpio_invert =3D false;
>         ret =3D mmc_gpiod_request_ro(host, "wp", 0, false, 0, &gpio_i=
nvert);
>         if (ret) {
>                 if (ret =3D=3D -EPROBE_DEFER)
>
> Let me know if this also fixes it for you, and I'll send in a proper
> patch.

Argh how could I make this stupid mistake :(

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
