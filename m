From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [Regression Resend] mmc: mx28: sd card detection broken since 3.18-rc1
Date: Mon, 3 Nov 2014 00:23:38 -0200
Message-ID: <CAOMZO5Cw7PGaum+HD7kPbgNqPdUE8U5E4wF61Kg7iu1nwjXxkg@mail.gmail.com>
References: <1747777414.897866.1414878004147.JavaMail.open-xchange@oxbsltgw09.schlund.de>
	<5456B7B3.60401@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <5456B7B3.60401@gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: =?UTF-8?Q?Kristina_Mart=C5=A1enko?= <kristina.martsenko@gmail.com>
Cc: Stefan Wahren <stefan.wahren@i2se.com>, Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi Kristina,

On Sun, Nov 2, 2014 at 9:01 PM, Kristina Mart=C5=A1enko
<kristina.martsenko@gmail.com> wrote:

> I ran into this issue as well. Seems that a card-detect flag
> (MMC_CAP2_CD_ACTIVE_HIGH) can currently be set based on an
> uninitialized variable, which can lead to the card being reported as
> not present. This patch fixes it for me:

Your patch fixes the card detection issue on mx28.

When you submit the patch formally, you can add my:

Tested-by: Fabio Estevam <fabio.estevam@freescale.com>

Thanks
--
To unsubscribe from this list: send the line "unsubscribe linux-gpio" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
