From: Kishore Kadiyala <kishorek.kadiyala@gmail.com>
Subject: Re: [PATCH] omap_hsmmc - use threaded irq handler for card-detect.
Date: Fri, 30 Dec 2011 02:18:34 -0500
Message-ID: <CAF=Qhp3aM4o59Lpbf0zrDdjrgbmO6sA-vfOM1wU4iDtDjNKUow@mail.gmail.com>
References: <20111230123513.6a843526@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20111230123513.6a843526@notabene.brown>
Sender: linux-omap-owner@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Chris Ball <cjb@laptop.org>, Tony Lindgren <tony@atomide.com>, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Grazvydas Ignotas <notasas@gmail.com>
List-Id: linux-mmc@vger.kernel.org

On Thu, Dec 29, 2011 at 8:35 PM, NeilBrown <neilb@suse.de> wrote:
>
>
> As the card-detect irq handler just schedules work to be done by
> a thread, we can use request_threaded_irq to do much of the work for
> us. =A0This means that interrupts which arrive by handle_nested_irq
> actually work.
>
> Reviewed-by: Felipe Balbi <balbi@ti.com>
> Tested-by: Grazvydas Ignotas <notasas@gmail.com>
> Signed-off-by: NeilBrown <neilb@suse.de>

I have done some thing similar but didn't pushed it  :-(
Anyways
Acked-by:  Kishore Kadiyala <kishorek.kadiyala@gmail.com>

>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hs=
mmc.c
> index d5fe43d..56f6cfc 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -24,7 +24,6 @@
> =A0#include <linux/delay.h>
> =A0#include <linux/dma-mapping.h>
> =A0#include <linux/platform_device.h>
> -#include <linux/workqueue.h>
> =A0#include <linux/timer.h>
> =A0#include <linux/clk.h>
> =A0#include <linux/mmc/host.h>
> @@ -163,7 +162,6 @@ struct omap_hsmmc_host {
> =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0struct =A0regulator =A0 =A0 =A0 *vcc;
> =A0 =A0 =A0 =A0struct =A0regulator =A0 =A0 =A0 *vcc_aux;
> - =A0 =A0 =A0 struct =A0work_struct =A0 =A0 mmc_carddetect_work;
> =A0 =A0 =A0 =A0void =A0 =A0__iomem =A0 =A0 =A0 =A0 *base;
> =A0 =A0 =A0 =A0resource_size_t =A0 =A0 =A0 =A0 mapbase;
> =A0 =A0 =A0 =A0spinlock_t =A0 =A0 =A0 =A0 =A0 =A0 =A0irq_lock; /* Pre=
vent races with irq handler */
> @@ -1280,17 +1278,16 @@ static void omap_hsmmc_protect_card(struct om=
ap_hsmmc_host *host)
> =A0}
>
> =A0/*
> - * Work Item to notify the core about card insertion/removal
> + * irq handler to notify the core about card insertion/removal
> =A0*/
> -static void omap_hsmmc_detect(struct work_struct *work)
> +static irqreturn_t omap_hsmmc_detect(int irq, void *dev_id)
> =A0{
> - =A0 =A0 =A0 struct omap_hsmmc_host *host =3D
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 container_of(work, struct omap_hsmmc_ho=
st, mmc_carddetect_work);
> + =A0 =A0 =A0 struct omap_hsmmc_host *host =3D dev_id;
> =A0 =A0 =A0 =A0struct omap_mmc_slot_data *slot =3D &mmc_slot(host);
> =A0 =A0 =A0 =A0int carddetect;
>
> =A0 =A0 =A0 =A0if (host->suspended)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return IRQ_HANDLED;
>
> =A0 =A0 =A0 =A0sysfs_notify(&host->mmc->class_dev.kobj, NULL, "cover_=
switch");
>
> @@ -1305,19 +1302,6 @@ static void omap_hsmmc_detect(struct work_stru=
ct *work)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_detect_change(host->mmc, (HZ * 200=
) / 1000);
> =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_detect_change(host->mmc, (HZ * 50)=
 / 1000);
> -}
> -
> -/*
> - * ISR for handling card insertion and removal
> - */
> -static irqreturn_t omap_hsmmc_cd_handler(int irq, void *dev_id)
> -{
> - =A0 =A0 =A0 struct omap_hsmmc_host *host =3D (struct omap_hsmmc_hos=
t *)dev_id;
> -
> - =A0 =A0 =A0 if (host->suspended)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return IRQ_HANDLED;
> - =A0 =A0 =A0 schedule_work(&host->mmc_carddetect_work);
> -
> =A0 =A0 =A0 =A0return IRQ_HANDLED;
> =A0}
>
> @@ -1919,7 +1903,6 @@ static int __init omap_hsmmc_probe(struct platf=
orm_device *pdev)
> =A0 =A0 =A0 =A0host->next_data.cookie =3D 1;
>
> =A0 =A0 =A0 =A0platform_set_drvdata(pdev, host);
> - =A0 =A0 =A0 INIT_WORK(&host->mmc_carddetect_work, omap_hsmmc_detect=
);
>
> =A0 =A0 =A0 =A0mmc->ops =A0 =A0 =A0 =A0=3D &omap_hsmmc_ops;
>
> @@ -2047,10 +2030,11 @@ static int __init omap_hsmmc_probe(struct pla=
tform_device *pdev)
>
> =A0 =A0 =A0 =A0/* Request IRQ for card detect */
> =A0 =A0 =A0 =A0if ((mmc_slot(host).card_detect_irq)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D request_irq(mmc_slot(host).card=
_detect_irq,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 oma=
p_hsmmc_cd_handler,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 IRQ=
=46_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc=
_hostname(mmc), host);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D request_threaded_irq(mmc_slot(h=
ost).card_detect_irq,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0NULL,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0omap_hsmmc_detect,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0mmc_hostname(mmc), host);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (ret) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_dbg(mmc_dev(host->=
mmc),
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"Unabl=
e to grab MMC CD IRQ\n");
> @@ -2129,7 +2113,6 @@ static int omap_hsmmc_remove(struct platform_de=
vice *pdev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0free_irq(host->irq, host);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (mmc_slot(host).card_detect_irq)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0free_irq(mmc_slot(host=
).card_detect_irq, host);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 flush_work_sync(&host->mmc_carddetect_w=
ork);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pm_runtime_put_sync(host->dev);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pm_runtime_disable(host->dev);
> @@ -2176,7 +2159,6 @@ static int omap_hsmmc_suspend(struct device *de=
v)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return=
 ret;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 cancel_work_sync(&host->mmc_carddetect_=
work);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D mmc_suspend_host(host->mmc);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (ret =3D=3D 0) {
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
