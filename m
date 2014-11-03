From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [Regression Resend] mmc: mx28: sd card detection broken since
 3.18-rc1
Date: Mon, 03 Nov 2014 08:15:53 +0100
Message-ID: <54572BA9.1090305@i2se.com>
References: <1747777414.897866.1414878004147.JavaMail.open-xchange@oxbsltgw09.schlund.de> <5456B7B3.60401@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <5456B7B3.60401@gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: =?UTF-8?B?S3Jpc3RpbmEgTWFydMWhZW5rbw==?= <kristina.martsenko@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>, linux-mmc@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, festevam@gmail.com, linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hello Kristina,

Am 03.11.2014 um 00:01 schrieb Kristina Mart=C5=A1enko:
> [...]
> I ran into this issue as well. Seems that a card-detect flag=20
> (MMC_CAP2_CD_ACTIVE_HIGH) can currently be set based on an=20
> uninitialized variable, which can lead to the card being reported as=20
> not present. This patch fixes it for me:
>
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index 03c53b72a2d6..f0e187682d3b 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -311,7 +311,7 @@ int mmc_of_parse(struct mmc_host *host)
>  	struct device_node *np;
>  	u32 bus_width;
>  	int len, ret;
> -	bool cap_invert, gpio_invert;
> +	bool cap_invert, gpio_invert =3D false;
> =20
>  	if (!host->parent || !host->parent->of_node)
>  		return 0;
> @@ -401,6 +401,7 @@ int mmc_of_parse(struct mmc_host *host)
>  	else
>  		cap_invert =3D false;
> =20
> +	gpio_invert =3D false;
>  	ret =3D mmc_gpiod_request_ro(host, "wp", 0, false, 0, &gpio_invert)=
;
>  	if (ret) {
>  		if (ret =3D=3D -EPROBE_DEFER)
>
> Let me know if this also fixes it for you, and I'll send in a proper=20
> patch.

the patch works for me too. You can also add:

Tested-by: Stefan Wahren <stefan.wahren@i2se.com>

> Thanks,
> Kristina

Thanks a lot
Stefan

--
To unsubscribe from this list: send the line "unsubscribe linux-gpio" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
