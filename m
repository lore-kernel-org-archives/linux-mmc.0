From: =?iso-8859-2?Q?'Micha=B3_Miros=B3aw'?= <mirq-linux@rere.qmqm.pl>
Subject: Re: [PATCH] mmc: host: use platform_{get,set}_drvdata()
Date: Mon, 3 Jun 2013 03:38:30 +0200
Message-ID: <20130603013830.GA14722@rere.qmqm.pl>
References: <000001ce5e87$284f88e0$78ee9aa0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from rere.qmqm.pl ([89.167.52.164]:57003 "EHLO rere.qmqm.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755276Ab3FCBrn (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 2 Jun 2013 21:47:43 -0400
Content-Disposition: inline
In-Reply-To: <000001ce5e87$284f88e0$78ee9aa0$@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jingoo Han <jg1.han@samsung.com>
Cc: 'Chris Ball' <cjb@laptop.org>, linux-mmc@vger.kernel.org, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Ian Molton <ian@mnementh.co.uk>

On Sat, Jun 01, 2013 at 02:16:22PM +0900, Jingoo Han wrote:
> Use the wrapper functions for getting and setting the driver data usi=
ng
> platform_device instead of using dev_{get,set}_drvdata() with &pdev->=
dev,
> so we can directly pass a struct platform_device.
>=20
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
>  drivers/mmc/host/cb710-mmc.c      |    2 +-
>  drivers/mmc/host/sh_mobile_sdhi.c |    6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/mmc/host/cb710-mmc.c b/drivers/mmc/host/cb710-mm=
c.c
> index 777ca20..9d6e2b8 100644
> --- a/drivers/mmc/host/cb710-mmc.c
> +++ b/drivers/mmc/host/cb710-mmc.c
> @@ -703,7 +703,7 @@ static int cb710_mmc_init(struct platform_device =
*pdev)
>  	if (!mmc)
>  		return -ENOMEM;
> =20
> -	dev_set_drvdata(&pdev->dev, mmc);
> +	platform_set_drvdata(pdev, mmc);
> =20
>  	/* harmless (maybe) magic */
>  	pci_read_config_dword(chip->pdev, 0x48, &val);

You missed the counterpart - cb710_slot_to_mmc() in cb710-mmc.h.
After the fix:

Acked-by: Micha=B3 Miros=B3aw <mirq-linux@rere.qmqm.pl>
[for cb710]

Best Regards,
Micha=B3 Miros=B3aw
