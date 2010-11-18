From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH v2 1/1]mmc: check SDIO card wake up during suspending
Date: Thu, 18 Nov 2010 14:29:29 +0200
Message-ID: <AANLkTikQFX68ok4Udi-ZLwCKni8fvj5FrNWAKRu1EQR6@mail.gmail.com>
References: <AANLkTimgPjY0=+mQxf+qa73L_2KfhH+A3XHhb_z1xp58@mail.gmail.com>
 <AANLkTikP7o=H6MC9LYVm=TKMZtj2Y=o7DAq3NEHXx8o+@mail.gmail.com> <AANLkTimYfU1EMOPZ7R+vmf7cbPD2+BmdwQErPOx8FrD0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:59188 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751515Ab0KRM36 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 18 Nov 2010 07:29:58 -0500
Received: by iwn35 with SMTP id 35so3453529iwn.19
        for <linux-mmc@vger.kernel.org>; Thu, 18 Nov 2010 04:29:58 -0800 (PST)
In-Reply-To: <AANLkTimYfU1EMOPZ7R+vmf7cbPD2+BmdwQErPOx8FrD0@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jun Nie <niej0001@gmail.com>
Cc: linux-mmc@vger.kernel.org, Michal Miroslaw <mirqus@gmail.com>, Nicolas Pitre <nico@fluxnic.net>, Chris Ball <cjb@laptop.org>, Andrew Morton <akpm@linux-foundation.org>, Bing Zhao <bzhao@marvell.com>, zhangfei gao <zhangfei.gao@gmail.com>, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>

Hi Jun,

On Thu, Nov 18, 2010 at 4:20 AM, Jun Nie <niej0001@gmail.com> wrote:
> It is possible that SDIO card send card interrupt to wake up
> system just after SDIO func driver and SDIO card firmware commit
> suspend state, while system is still in suspending process and
> mmc interrupt is not release yet.
>
> Interrupt storm may happen if func driver does not notify firmware
> to clear the wake up source. If func driver issue SDIO bus transactio=
n
> to have firmware clear the source and driver continue to handle the
> wake up event, system may enter suspend before all transaction done.
> In this case, SDIO card will not enter lower power mode never. But
> system can not be wake up for only card insert/remove/interrupt irq a=
re
> listed in wake up source in SD spec. Data/command done irq can
> not wake up system.
>
> This patch check SDIO card interrupt and stop system suspend if there
> are card interrupt after func driver suspend.

We already have a kernel framework for dealing with similar race
conditions, check out mainline commit c125e96 "PM: Make it possible to
avoid races between wakeup and system sleep" and
drivers/base/power/wakeup.c.

Does this satisfy your requirement ? It seems that it can
significantly simplify your patch (in essence, calling
pm_wakeup_event() will request PM core to abort system transition into
suspend).

Thanks,
Ohad.

>
> Signed-off-by: Jun Nie <njun@marvell.com>
> ---
> =A0drivers/mmc/core/sdio.c =A0 =A0 =A0 | =A0 14 ++++++++++++++
> =A0drivers/mmc/core/sdio_irq.c =A0 | =A0 =A06 ++++++
> =A0drivers/mmc/host/sdhci.c =A0 =A0 =A0| =A0 18 ++++++++++++++++--
> =A0include/linux/mmc/card.h =A0 =A0 =A0| =A0 =A02 ++
> =A0include/linux/mmc/sdio_func.h | =A0 =A02 ++
> =A05 files changed, 40 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
> index c3ad105..48a4106 100644
> --- a/drivers/mmc/core/sdio.c
> +++ b/drivers/mmc/core/sdio.c
> @@ -584,6 +584,14 @@ static int mmc_sdio_suspend(struct mmc_host *hos=
t)
>
> =A0 =A0 =A0 =A0for (i =3D 0; i < host->card->sdio_funcs; i++) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct sdio_func *func =3D host->card-=
>sdio_func[i];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* cancel suspend once we detect extern=
al wake up source */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (host->card->pending_interrupt) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->card->pending_int=
errupt =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D -EBUSY;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ALERT "%s: =
wake up event after device suspended\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 mmc_hostname(host));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (func && sdio_func_present(func) &&=
 func->dev.driver) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0const struct dev_pm_op=
s *pmops =3D func->dev.driver->pm;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!pmops || !pmops->=
suspend || !pmops->resume) {
> @@ -593,10 +601,15 @@ static int mmc_sdio_suspend(struct mmc_host *ho=
st)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D=
 pmops->suspend(&func->dev);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (err)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* It i=
s prefer that func driver set it in its
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
suspend function with mmc_claim_host */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 func->s=
uspended =3D true;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0while (err && --i >=3D 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct sdio_func *func =3D host->card-=
>sdio_func[i];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 func->suspended =3D false;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (func && sdio_func_present(func) &&=
 func->dev.driver) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0const struct dev_pm_op=
s *pmops =3D func->dev.driver->pm;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pmops->resume(&func->d=
ev);
> @@ -639,6 +652,7 @@ static int mmc_sdio_resume(struct mmc_host *host)
> =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0for (i =3D 0; !err && i < host->card->sdio_funcs; i++)=
 {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct sdio_func *func =3D host->card-=
>sdio_func[i];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 func->suspended =3D false;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (func && sdio_func_present(func) &&=
 func->dev.driver) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0const struct dev_pm_op=
s *pmops =3D func->dev.driver->pm;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D pmops->resume(=
&func->dev);
> diff --git a/drivers/mmc/core/sdio_irq.c b/drivers/mmc/core/sdio_irq.=
c
> index bb192f9..727a1a3 100644
> --- a/drivers/mmc/core/sdio_irq.c
> +++ b/drivers/mmc/core/sdio_irq.c
> @@ -49,6 +49,12 @@ static int process_sdio_pending_irqs(struct mmc_ca=
rd *card)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0mmc_card_id(card));
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D=
 -EINVAL;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else if (func->irq_h=
andler) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (fun=
c->suspended) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 card->pending_interrupt =3D true;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 printk(KERN_WARNING "%s: IRQ that "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 "arrives in suspend mode"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 " mode\n", sdio_func_id(func));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0func->=
irq_handler(func);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0count+=
+;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else {
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 782c0ee..9c8f1cc 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -24,6 +24,7 @@
> =A0#include <linux/leds.h>
>
> =A0#include <linux/mmc/host.h>
> +#include <linux/mmc/card.h>
>
> =A0#include "sdhci.h"
>
> @@ -1631,7 +1632,7 @@ out:
>
> =A0int sdhci_suspend_host(struct sdhci_host *host, pm_message_t state=
)
> =A0{
> - =A0 =A0 =A0 int ret;
> + =A0 =A0 =A0 int ret =3D 0;
>
> =A0 =A0 =A0 =A0sdhci_disable_card_detection(host);
>
> @@ -1641,8 +1642,19 @@ int sdhci_suspend_host(struct sdhci_host *host=
,
> pm_message_t state)
>
> =A0 =A0 =A0 =A0free_irq(host->irq, host);
>
> - =A0 =A0 =A0 if (host->vmmc)
> + =A0 =A0 =A0 if (host->vmmc) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D regulator_disable(host->vmmc);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (host->mmc->card && host->mmc->card->pending_interru=
pt) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 DBG("%s wake up event after suspend, re=
suming to handle it\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_hostname(host->mmc)=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->mmc->card->pending_interrupt =3D =
0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_resume_host(host);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EBUSY;
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0return ret;
> =A0}
> @@ -1659,6 +1671,8 @@ int sdhci_resume_host(struct sdhci_host *host)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return ret;
> =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 if (host->mmc->card && host->mmc->card->pending_interru=
pt)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->mmc->card->pending_interrupt =3D =
0;
>
> =A0 =A0 =A0 =A0if (host->flags & (SDHCI_USE_SDMA | SDHCI_USE_ADMA)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (host->ops->enable_dma)
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index 8ce0827..2252fe2 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -146,6 +146,8 @@ struct mmc_card {
> =A0 =A0 =A0 =A0struct sdio_func_tuple =A0*tuples; =A0 =A0 =A0 =A0/* u=
nknown common tuples */
>
> =A0 =A0 =A0 =A0struct dentry =A0 =A0 =A0 =A0 =A0 *debugfs_root;
> + =A0 =A0 =A0 /* external interrupt arrived after sdio function suspe=
nded */
> + =A0 =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pending_int=
errupt;
> =A0};
>
> =A0#define mmc_card_mmc(c) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0((c)->type =
=3D=3D MMC_TYPE_MMC)
> diff --git a/include/linux/mmc/sdio_func.h b/include/linux/mmc/sdio_f=
unc.h
> index 31baaf8..5c1c462 100644
> --- a/include/linux/mmc/sdio_func.h
> +++ b/include/linux/mmc/sdio_func.h
> @@ -59,6 +59,8 @@ struct sdio_func {
> =A0 =A0 =A0 =A0const char =A0 =A0 =A0 =A0 =A0 =A0 =A0**info; =A0 =A0 =
=A0 =A0 /* info strings */
>
> =A0 =A0 =A0 =A0struct sdio_func_tuple *tuples;
> +
> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 suspended; =
/* SDIO function driver state */
> =A0};
>
> =A0#define sdio_func_present(f) =A0 ((f)->state & SDIO_STATE_PRESENT)
> --
> 1.7.0.4
>
