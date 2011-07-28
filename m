From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] cb710: fix possible pci_dev leak in cb710_pci_configure()
Date: Thu, 28 Jul 2011 18:34:07 -0400
Message-ID: <m2y5zihw68.fsf@bob.laptop.org>
References: <20110728183319.GC24120@rere.qmqm.pl>
	<d8d89ffdad20168a3c2273418aff74036eb24add.1311879121.git.mirq-linux@rere.qmqm.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:44997 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756079Ab1G1Weg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 28 Jul 2011 18:34:36 -0400
In-Reply-To: <d8d89ffdad20168a3c2273418aff74036eb24add.1311879121.git.mirq-linux@rere.qmqm.pl>
	(=?utf-8?Q?=22Micha=C5=82_Miros=C5=82aw=22's?= message of "Thu, 28 Jul 2011
 20:55:27 +0200
	(CEST)")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?utf-8?Q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc: linux-mmc@vger.kernel.org, kernel-janitors@vger.kernel.org, Julia Lawall <julia@diku.dk>

Hi Micha=C5=82,

On Thu, Jul 28 2011, Micha=C5=82 Miros=C5=82aw wrote:
> Reported-by: Julia Lawall <julia@diku.dk>
> Signed-off-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> ---
>  drivers/misc/cb710/core.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/misc/cb710/core.c b/drivers/misc/cb710/core.c
> index efec413..68cd05b 100644
> --- a/drivers/misc/cb710/core.c
> +++ b/drivers/misc/cb710/core.c
> @@ -33,7 +33,7 @@ EXPORT_SYMBOL_GPL(cb710_pci_update_config_reg);
>  static int __devinit cb710_pci_configure(struct pci_dev *pdev)
>  {
>  	unsigned int devfn =3D PCI_DEVFN(PCI_SLOT(pdev->devfn), 0);
> -	struct pci_dev *pdev0 =3D pci_get_slot(pdev->bus, devfn);
> +	struct pci_dev *pdev0;
>  	u32 val;
> =20
>  	cb710_pci_update_config_reg(pdev, 0x48,
> @@ -43,6 +43,7 @@ static int __devinit cb710_pci_configure(struct pci=
_dev *pdev)
>  	if (val & 0x80000000)
>  		return 0;
> =20
> +	pdev0 =3D pci_get_slot(pdev->bus, devfn);
>  	if (!pdev0)
>  		return -ENODEV;

Pushed to mmc-next for 3.1, thanks.

- Chris.
--=20
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
