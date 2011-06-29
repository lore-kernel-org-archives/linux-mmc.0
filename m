From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/2] MMC: PM: add suspend/resume in atmel-mci
Date: Wed, 29 Jun 2011 23:39:12 +0200
Message-ID: <201106292339.12402.rjw@sisk.pl>
References: <1ef60c032bc39531302c1603bfcb841d2d437ccc.1309366360.git.nicolas.ferre@atmel.com> <20110629160110.GD2760@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:41333 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753951Ab1F2ViI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 29 Jun 2011 17:38:08 -0400
In-Reply-To: <20110629160110.GD2760@legolas.emea.dhcp.ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: balbi@ti.com
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, cjb@laptop.org, linux-mmc@vger.kernel.org, hans-christian.egtvedt@atmel.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@avr32linux.org, Uwe =?iso-8859-2?q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>

On Wednesday, June 29, 2011, Felipe Balbi wrote:
> Hi,
>=20
> On Wed, Jun 29, 2011 at 06:54:19PM +0200, Nicolas Ferre wrote:
> > Take care of slots while going to suspend state.
> >=20
> > Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > ---
> >  drivers/mmc/host/atmel-mci.c |   51 ++++++++++++++++++++++++++++++=
++++++++++++
> >  1 files changed, 51 insertions(+), 0 deletions(-)
> >=20
> > diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-=
mci.c
> > index aa8039f..c414ebe 100644
> > --- a/drivers/mmc/host/atmel-mci.c
> > +++ b/drivers/mmc/host/atmel-mci.c
> > @@ -1878,8 +1878,59 @@ static int __exit atmci_remove(struct platfo=
rm_device *pdev)
> >  	return 0;
> >  }
> > =20
> > +#ifdef CONFIG_PM
> > +static int atmci_suspend(struct platform_device *pdev, pm_message_=
t mesg)
> > +{
> > +	struct atmel_mci *host =3D platform_get_drvdata(pdev);
> > +	struct atmel_mci_slot *slot;
> > +	int i, ret;
> > +
> > +	 for (i =3D 0; i < ATMEL_MCI_MAX_NR_SLOTS; i++) {
> > +		slot =3D host->slot[i];
> > +		if (!slot)
> > +			continue;
> > +		ret =3D mmc_suspend_host(slot->mmc);
> > +		if (ret < 0) {
> > +			while (--i >=3D 0) {
> > +				slot =3D host->slot[i];
> > +				if (slot)
> > +					mmc_resume_host(host->slot[i]->mmc);
> > +			}
> > +			return ret;
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int atmci_resume(struct platform_device *pdev)
> > +{
> > +	struct atmel_mci *host =3D platform_get_drvdata(pdev);
> > +	struct atmel_mci_slot *slot;
> > +	int i, ret;
> > +
> > +	for (i =3D 0; i < ATMEL_MCI_MAX_NR_SLOTS; i++) {
> > +		slot =3D host->slot[i];
> > +		if (!slot)
> > +			continue;
> > +		ret =3D mmc_resume_host(slot->mmc);
> > +		if (ret < 0)
> > +			return ret;
> > +	}
> > +
> > +	return 0;
> > +}
> > +#else
> > +#define atmci_suspend	NULL
> > +#define atmci_resume	NULL
> > +#endif
> > +
> > +
> > +
> >  static struct platform_driver atmci_driver =3D {
> >  	.remove		=3D __exit_p(atmci_remove),
> > +	.suspend	=3D atmci_suspend,
> > +	.resume		=3D atmci_resume,
>=20
> should this be using dev_pm_ops instead ?

It should.  Also, please remember to initialize the hibernate callback
pointers too, e.g. via the SIMPLE_DEV_PM_OPS() macro.

Thanks,
Rafael
