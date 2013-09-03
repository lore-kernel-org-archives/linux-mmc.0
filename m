From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH V3 3/4] mmc: mmci: Adapt to register write restrictions
Date: Tue, 03 Sep 2013 11:50:39 +0200
Message-ID: <5225B0EF.7030006@linaro.org>
References: <1378200576-13413-1-git-send-email-ulf.hansson@linaro.org> <1378200576-13413-4-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bk0-f54.google.com ([209.85.214.54]:59174 "EHLO
	mail-bk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754149Ab3ICJun (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 3 Sep 2013 05:50:43 -0400
Received: by mail-bk0-f54.google.com with SMTP id mz12so2048211bkb.27
        for <linux-mmc@vger.kernel.org>; Tue, 03 Sep 2013 02:50:42 -0700 (PDT)
In-Reply-To: <1378200576-13413-4-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Linus Walleij <linus.walleij@linaro.org>, Johan Rudholm <jrudholm@gmail.com>

On 09/03/2013 11:29 AM, Ulf Hansson wrote:
> After a write to the MMCICLOCK register data cannot be written to thi=
s
> register for three feedback clock cycles. Writes to the MMCIPOWER
> register must be separated by three MCLK cycles. Previously no issues
> has been observered, but using higher ARM clock frequencies on STE-
> platforms has triggered this problem.
>=20
> The MMCICLOCK register is written to in .set_ios and for some data
> transmissions for SDIO. We do not need a delay at the data transmissi=
on
> path, because sending and receiving data will require more than three
> clock cycles. Then we use a simple logic to only delay in .set_ios an=
d
> thus we don't affect throughput performance.
>=20
> Signed-off-by: Johan Rudholm <jrudholm@gmail.com>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> Acked-by: Rickard Andersson <rickard.andersson@stericsson.com>
> ---

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

+ two questions below.

>  drivers/mmc/host/mmci.c |   16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>=20
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index c550b3e..82afcd3 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -189,6 +189,21 @@ static int mmci_validate_data(struct mmci_host *=
host,
>  	return 0;
>  }
> =20
> +static void mmci_reg_delay(struct mmci_host *host)
> +{
> +	/*
> +	 * According to the spec, at least three feedback clock cycles
> +	 * of max 52 MHz must pass between two writes to the MMCICLOCK reg.
> +	 * Three MCLK clock cycles must pass between two MMCIPOWER reg writ=
es.
> +	 * Worst delay time during card init is at 100 kHz =3D> 30 us.
> +	 * Worst delay time when up and running is at 25 MHz =3D> 120 ns.
> +	 */
> +	if (host->cclk < 20000000)

Shouldn't it be 25000000 ?

What about using macros ?

#define MMC_CLOCK 25000000
#define MMCINIT_DELAY 30
#define MMCUP_DELAY 120

> +		udelay(30);
> +	else
> +		ndelay(120);
> +}
> +
>  /*
>   * This must be called with host->lock held
>   */
> @@ -1264,6 +1279,7 @@ static void mmci_set_ios(struct mmc_host *mmc, =
struct mmc_ios *ios)
> =20
>  	mmci_set_clkreg(host, ios->clock);
>  	mmci_write_pwrreg(host, pwr);
> +	mmci_reg_delay(host);
> =20
>  	spin_unlock_irqrestore(&host->lock, flags);
> =20
>=20


--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

