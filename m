From: "Kadiyala, Kishore" <kishore.kadiyala@ti.com>
Subject: Re: [PATCH 37/57] mmc: irq: Remove IRQF_DISABLED
Date: Thu, 22 Sep 2011 20:20:23 +0530
Message-ID: <CAA93xcbHJNpPsPetnLZbPiJ+36QBr8cHFwOdv=yCOVgY9LjgFw@mail.gmail.com>
References: <1316597339-29861-1-git-send-email-yong.zhang0@gmail.com> <1316597339-29861-38-git-send-email-yong.zhang0@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:44045 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753216Ab1IVOup convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 22 Sep 2011 10:50:45 -0400
In-Reply-To: <1316597339-29861-38-git-send-email-yong.zhang0@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yong Zhang <yong.zhang0@gmail.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, Chris Ball <cjb@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Ian Molton <ian@mnementh.co.uk>, Tony Lindgren <tony@atomide.com>, Adrian Hunter <adrian.hunter@nokia.com>, Balaji T K <balajitk@ti.com>, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org

On Wed, Sep 21, 2011 at 2:58 PM, Yong Zhang <yong.zhang0@gmail.com> wro=
te:
> Since commit [c58543c8: genirq: Run irq handlers with interrupts disa=
bled],
> We run all interrupt handlers with interrupts disabled
> and we even check and yell when an interrupt handler
> returns with interrupts enabled (see commit [b738a50a:
> genirq: Warn when handler enables interrupts]).
>
> So now this flag is a NOOP and can be removed.
>
> Signed-off-by: Yong Zhang <yong.zhang0@gmail.com>

=46or omap_hsmmc.c

Acked-by: Kishore Kadiyala <kishore.kadiyala@ti.com>

> ---
> =A0drivers/mmc/host/omap_hsmmc.c | =A0 =A05 ++---
> =A0drivers/mmc/host/tmio_mmc.c =A0 | =A0 =A04 ++--
> =A02 files changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hs=
mmc.c
> index 21e4a79..75c6395 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -2015,7 +2015,7 @@ static int __init omap_hsmmc_probe(struct platf=
orm_device *pdev)
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0/* Request IRQ for MMC operations */
> - =A0 =A0 =A0 ret =3D request_irq(host->irq, omap_hsmmc_irq, IRQF_DIS=
ABLED,
> + =A0 =A0 =A0 ret =3D request_irq(host->irq, omap_hsmmc_irq, 0,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_hostname(mmc), hos=
t);
> =A0 =A0 =A0 =A0if (ret) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_dbg(mmc_dev(host->mmc), "Unable to=
 grab HSMMC IRQ\n");
> @@ -2043,8 +2043,7 @@ static int __init omap_hsmmc_probe(struct platf=
orm_device *pdev)
> =A0 =A0 =A0 =A0if ((mmc_slot(host).card_detect_irq)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D request_irq(mmc_slot(host).car=
d_detect_irq,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0om=
ap_hsmmc_cd_handler,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 IRQ=
=46_TRIGGER_RISING | IRQF_TRIGGER_FALLING
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 | IRQF_DISABLED,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 IRQ=
=46_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mm=
c_hostname(mmc), host);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (ret) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_dbg(mmc_dev(host->=
mmc),
> diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_mmc.=
c
> index 44a9668..a4ea102 100644
> --- a/drivers/mmc/host/tmio_mmc.c
> +++ b/drivers/mmc/host/tmio_mmc.c
> @@ -88,8 +88,8 @@ static int __devinit tmio_mmc_probe(struct platform=
_device *pdev)
> =A0 =A0 =A0 =A0if (ret)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto cell_disable;
>
> - =A0 =A0 =A0 ret =3D request_irq(irq, tmio_mmc_irq, IRQF_DISABLED |
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 IRQF_TRIGGER_FALLIN=
G, dev_name(&pdev->dev), host);
> + =A0 =A0 =A0 ret =3D request_irq(irq, tmio_mmc_irq, IRQF_TRIGGER_FAL=
LING,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_nam=
e(&pdev->dev), host);
> =A0 =A0 =A0 =A0if (ret)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto host_remove;
>
> --
> 1.7.4.1
>
>
