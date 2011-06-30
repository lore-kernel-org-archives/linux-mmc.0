From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH V2] MMC: PM: add suspend/resume in atmel-mci
Date: Thu, 30 Jun 2011 15:13:42 +0200
Message-ID: <20110630131342.GK11559@pengutronix.de>
References: <201106292339.12402.rjw@sisk.pl>
 <1309441781-11012-1-git-send-email-nicolas.ferre@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55586 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752252Ab1F3NNu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 30 Jun 2011 09:13:50 -0400
Content-Disposition: inline
In-Reply-To: <1309441781-11012-1-git-send-email-nicolas.ferre@atmel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: cjb@laptop.org, linux-mmc@vger.kernel.org, hans-christian.egtvedt@atmel.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@avr32linux.org

Hello Nicolas,

On Thu, Jun 30, 2011 at 03:49:41PM +0200, Nicolas Ferre wrote:
> Take care of slots while going to suspend state.
>=20
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> ---
> V2: move to pm_ops
>=20
>  drivers/mmc/host/atmel-mci.c |   47 ++++++++++++++++++++++++++++++++=
++++++++++
>  1 files changed, 47 insertions(+), 0 deletions(-)
>=20
> diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mc=
i.c
> index aa8039f..058f1842 100644
> --- a/drivers/mmc/host/atmel-mci.c
> +++ b/drivers/mmc/host/atmel-mci.c
> @@ -1878,10 +1878,57 @@ static int __exit atmci_remove(struct platfor=
m_device *pdev)
>  	return 0;
>  }
> =20
> +#ifdef CONFIG_PM
> +static int atmci_suspend(struct device *dev)
> +{
> +	struct atmel_mci *host =3D dev_get_drvdata(dev);
> +	struct atmel_mci_slot *slot;
> +	int i, ret;
slot and ret can have a more local scope.

> +
> +	 for (i =3D 0; i < ATMEL_MCI_MAX_NR_SLOTS; i++) {
> +		slot =3D host->slot[i];
> +		if (!slot)
> +			continue;
> +		ret =3D mmc_suspend_host(slot->mmc);
> +		if (ret < 0) {
> +			while (--i >=3D 0) {
> +				slot =3D host->slot[i];
> +				if (slot)
> +					mmc_resume_host(host->slot[i]->mmc);
hmm, mmc_resume_host could fail. But probably you cannot handle that in
a sane way, do you?

> +			}
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int atmci_resume(struct device *dev)
> +{
> +	struct atmel_mci *host =3D dev_get_drvdata(dev);
> +	struct atmel_mci_slot *slot;
> +	int i, ret;
> +
> +	for (i =3D 0; i < ATMEL_MCI_MAX_NR_SLOTS; i++) {
> +		slot =3D host->slot[i];
> +		if (!slot)
> +			continue;
> +		ret =3D mmc_resume_host(slot->mmc);
> +		if (ret < 0)
> +			return ret;
Maybe you should try to resume host 5 even if resuming host 4 failed?

> +	}
> +
> +	return 0;
> +}
> +#endif
> +static SIMPLE_DEV_PM_OPS(atmci_pm, atmci_suspend, atmci_resume);
> +
> +
=46or my taste a single empty line is enough.

>  static struct platform_driver atmci_driver =3D {
>  	.remove		=3D __exit_p(atmci_remove),
>  	.driver		=3D {
>  		.name		=3D "atmel_mci",
> +		.pm		=3D &atmci_pm,
>  	},
>  };

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
