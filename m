From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] mmci: handle clock frequency 0 properly
Date: Sat, 4 Dec 2010 12:23:40 +0000
Message-ID: <20101204122340.GC20969@n2100.arm.linux.org.uk>
References: <1289927869-14519-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:55556 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751134Ab0LDMXy (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 4 Dec 2010 07:23:54 -0500
Content-Disposition: inline
In-Reply-To: <1289927869-14519-1-git-send-email-linus.walleij@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@stericsson.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, Chris Ball <cjb@laptop.org>

On Tue, Nov 16, 2010 at 06:17:49PM +0100, Linus Walleij wrote:
> This removes the default clocking for the MMCI controller so that
> the external MCI card clock does not activate until the first
> .set_ios() call is issued. It will further handle the transitions
> from a clock !=3D 0 to 0 and vice versa by gating/ungating the
> clock with clk_disable()/clk_enable().

I've just looked at this again, and I'm not happy - initially with the
above description, but the on the way the clock gating is being handled=
=2E

Your commentry seems to suggest that we currently don't turn off the
clock signal to the card.  This is not the case:

| The clock management logic generates and controls the MMCICLK signal.
| The MMCICLK output can use either a clock divide or clock bypass mode=
=2E
| The clock output is inactive:
| =E2=80=A2 after the PrimeCell MMCI is reset
| =E2=80=A2 during the power-off or power-up phases
| =E2=80=A2 if the power saving mode is enabled and the card bus is in =
the IDLE
|   state (eight clock periods after both the command and data path sub=
units
|   enter the IDLE phase).

I think what you actually mean is that the MCLK input to the primecell
(described as "PrimeCell MMCI adapter clock (MCLK)") rather than "exter=
nal
MCI card clock".

> This assures that the MCI clock will not be active unless there
> is a card in the MMC slot.

Is this sufficient?  The ARM MMCI TRM says that (eg) clear signals for
the status register (from the clear register) are synchronized to the
MCLK domain, which means without MCLK running, writing to the clear
register will be a no-op.

Also, the power, clock, data control and command registers have a
restriction that after any write to these individual registers, that
register must not be re-written for 3 MCLK periods plus 2 PCLK periods.
Are we sure that we're writing these registers with the MCLK turned
on, and it remains on for sufficient time?

I suspect that what this means is that we must enable MCLK before
writing to these registers, and disable MCLK after a delay after the
last write to any of these registers.  We probably want a read-back
and barrier after the last write to ensure that any delay is correct.

> By default the MMC core will not gate off the clock to a card
> once it's enabled, but with the separate patch for aggressive
> clocking this can optionally be enabled for the system.
>=20
> Cc: Chris Ball <cjb@laptop.org>
> Cc: Russell King <linux@arm.linux.org.uk>
> Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
> ---
> Changes since v8:
>=20
> The frequency registers shall be set with mmci_set_clkreg()
> no matter whether the clock gets enabled or disabled, systems
> without a clk framework will need this so that the clock
> dividers are set to the apropriate values for clock 0 as
> well, and that will probably mitigate power consumption
> somewhat on these systems.
>=20
> Chris: this is a new version after Russell found an error in
> it. Can you please take the old version of this patch out of
> the MMC tree so I can merge it through Russells ARM tree
> instead? The patches are perfectly orthogonal so it doesn't
> need to live in the MMC tree.
> ---
>  drivers/mmc/host/mmci.c |   33 ++++++++++++++++++++++-----------
>  drivers/mmc/host/mmci.h |    1 +
>  2 files changed, 23 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index 0814b88..3709ab3 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -689,6 +689,22 @@ static void mmci_set_ios(struct mmc_host *mmc, s=
truct mmc_ios *ios)
> =20
>  	mmci_set_clkreg(host, ios->clock);
> =20
> +	/*
> +	 * Turn on clock whenever ios->clock transitions
> +	 * from 0 to !=3D0 and gate it off whenever ios->clock
> +	 * transitions from !=3D0 to 0.
> +	 */
> +	if (host->iosclock =3D=3D 0 && ios->clock !=3D 0) {
> +		dev_dbg(mmc_dev(mmc), "enable clock f=3D%d\n", ios->clock);
> +		clk_enable(host->clk);
> +	} else if (host->iosclock !=3D 0 && ios->clock =3D=3D 0) {
> +		dev_dbg(mmc_dev(mmc), "disable clock\n");
> +		clk_disable(host->clk);
> +	} else if (ios->clock !=3D 0) {
> +		dev_dbg(mmc_dev(mmc), "set clock f=3D%d\n", ios->clock);
> +	}
> +	host->iosclock =3D ios->clock;
> +
>  	if (host->pwr !=3D pwr) {
>  		host->pwr =3D pwr;
>  		writel(pwr, host->base + MMCIPOWER);
> @@ -772,6 +788,8 @@ static int __devinit mmci_probe(struct amba_devic=
e *dev, struct amba_id *id)
> =20
>  	host =3D mmc_priv(mmc);
>  	host->mmc =3D mmc;
> +	host->plat =3D plat;
> +	host->variant =3D variant;
> =20
>  	host->gpio_wp =3D -ENOSYS;
>  	host->gpio_cd =3D -ENOSYS;
> @@ -782,19 +800,14 @@ static int __devinit mmci_probe(struct amba_dev=
ice *dev, struct amba_id *id)
>  	dev_dbg(mmc_dev(mmc), "designer ID =3D 0x%02x\n", host->hw_designer=
);
>  	dev_dbg(mmc_dev(mmc), "revision =3D 0x%01x\n", host->hw_revision);
> =20
> +	/* This clock will be enabled/disabled by set_ios() calls later */
>  	host->clk =3D clk_get(&dev->dev, NULL);
>  	if (IS_ERR(host->clk)) {
>  		ret =3D PTR_ERR(host->clk);
>  		host->clk =3D NULL;
>  		goto host_free;
>  	}
> -
> -	ret =3D clk_enable(host->clk);
> -	if (ret)
> -		goto clk_free;
> -
> -	host->plat =3D plat;
> -	host->variant =3D variant;
> +	host->iosclock =3D 0;
>  	host->mclk =3D clk_get_rate(host->clk);
>  	/*
>  	 * According to the spec, mclk is max 100 MHz,
> @@ -804,7 +817,7 @@ static int __devinit mmci_probe(struct amba_devic=
e *dev, struct amba_id *id)
>  	if (host->mclk > 100000000) {
>  		ret =3D clk_set_rate(host->clk, 100000000);
>  		if (ret < 0)
> -			goto clk_disable;
> +			goto clk_free;
>  		host->mclk =3D clk_get_rate(host->clk);
>  		dev_dbg(mmc_dev(mmc), "eventual mclk rate: %u Hz\n",
>  			host->mclk);
> @@ -812,7 +825,7 @@ static int __devinit mmci_probe(struct amba_devic=
e *dev, struct amba_id *id)
>  	host->base =3D ioremap(dev->res.start, resource_size(&dev->res));
>  	if (!host->base) {
>  		ret =3D -ENOMEM;
> -		goto clk_disable;
> +		goto clk_free;
>  	}
> =20
>  	mmc->ops =3D &mmci_ops;
> @@ -961,8 +974,6 @@ static int __devinit mmci_probe(struct amba_devic=
e *dev, struct amba_id *id)
>  		gpio_free(host->gpio_cd);
>   err_gpio_cd:
>  	iounmap(host->base);
> - clk_disable:
> -	clk_disable(host->clk);
>   clk_free:
>  	clk_put(host->clk);
>   host_free:
> diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
> index df06f01..4791a2b 100644
> --- a/drivers/mmc/host/mmci.h
> +++ b/drivers/mmc/host/mmci.h
> @@ -167,6 +167,7 @@ struct mmci_host {
> =20
>  	unsigned int		mclk;
>  	unsigned int		cclk;
> +	unsigned int		iosclock;
>  	u32			pwr;
>  	struct mmci_platform_data *plat;
>  	struct variant_data	*variant;
> --=20
> 1.6.3.3
>=20
