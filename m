From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] mmc: core: fix card detection regression
Date: Tue, 4 Nov 2014 22:48:45 -0200
Message-ID: <CAOMZO5CKB4aHTyYCvnT0UZCi4Pe+XyDa2-G1kpzyce1J3y3nfQ@mail.gmail.com>
References: <1747777414.897866.1414878004147.JavaMail.open-xchange@oxbsltgw09.schlund.de>
	<1415146961-25993-1-git-send-email-kristina.martsenko@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1415146961-25993-1-git-send-email-kristina.martsenko@gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: =?UTF-8?Q?Kristina_Mart=C5=A1enko?= <kristina.martsenko@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>, Linus Walleij <linus.walleij@linaro.org>, Stefan Wahren <stefan.wahren@i2se.com>, Michael Heimpold <mhei@heimpold.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi Kristina,

On Tue, Nov 4, 2014 at 10:22 PM, Kristina Mart=C5=A1enko
<kristina.martsenko@gmail.com> wrote:
> Since commit 89168b489915 ("mmc: core: restore detect line inversion
> semantics"), the SD card on i.MX28 (and possibly other) devices isn't
> detected and booting stops at:
>
> [    4.120617] Waiting for root device /dev/mmcblk0p3...
>
> This is caused by the MMC_CAP2_CD_ACTIVE_HIGH flag being set incorrec=
tly
> when the host controller doesn't use a GPIO for card detection (but
> instead uses a dedicated pin). In this case mmc_gpiod_request_cd() wi=
ll
> return before assigning to the gpio_invert variable, leaving the
> variable uninitialized. The variable then gets used to set the flag.
> This patch fixes the issue by making sure gpio_invert is set to false
> when a GPIO isn't used. After this patch, i.MX28 boots fine.
>
> The MMC_CAP2_RO_ACTIVE_HIGH (write protect) flag is also set incorrec=
tly
> for the exact same reason (it uses the same uninitialized variable), =
so
> this patch fixes that too.
>
> Fixes: 89168b489915 ("mmc: core: restore detect line inversion semant=
ics")
> Reported-by: Stefan Wahren <stefan.wahren@i2se.com>
> Signed-off-by: Kristina Mart=C5=A1enko <kristina.martsenko@gmail.com>

This fixes mx28 card detection, thanks!

Tested-by: Fabio Estevam <fabio.estevam@freescale.com>
--
To unsubscribe from this list: send the line "unsubscribe linux-gpio" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
