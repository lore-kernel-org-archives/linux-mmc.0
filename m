From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH v1 3/3]mmc: changes to enable runtime PM of mmc core layer
Date: Tue, 30 Nov 2010 00:57:07 -0800
Message-ID: <AANLkTiknO0BEBetKmFT5W0qwW+q1pS59qcwiqSMUHa_u@mail.gmail.com>
References: <20101128055315.GD3318@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:38428 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753835Ab0K3I52 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 30 Nov 2010 03:57:28 -0500
In-Reply-To: <20101128055315.GD3318@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yunpeng Gao <yunpeng.gao@intel.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Yunpeng,

On Sat, Nov 27, 2010 at 9:53 PM, Yunpeng Gao <yunpeng.gao@intel.com> wr=
ote:
> =A0static int mmc_runtime_idle(struct device *dev)
> =A0{
> - =A0 =A0 =A0 return pm_runtime_suspend(dev);
> + =A0 =A0 =A0 return pm_schedule_suspend(dev, 100);

You shouldn't do this here.

You didn't comment about or mentioned this change, but I guess you did
it because you (quite reasonably) didn't want the card to be powered
off as soon as mmc_blk_issue_rq() completes, and instead, you
preferred to wait until some period of inactivity time passes.

But that's not true for all mmc buses: e.g., when an SDIO function
driver decides it's time to power off the card (e.g. user disables the
wlan interface), there is no reason to have this delay.

In addition, putting an inherent delay here will completely prevent
anyone from achieving a synchronous idle notification on an mmc card
(so even pm_runtime_put_sync() will now set a timer to submit a
suspend request instead of carrying out a synchronous suspend).

It looks like you can drop this change, and instead just use the
autosuspend API from the mmc block driver (mainly use
pm_runtime_put_autosuspend() instead of pm_runtime_put()).

Another nice benefit of autosuspend is that now user space will be
able to tweak the amount of delay by using
/sys/devices/.../power/autosuspend_delay_ms attribute.


> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index 92e3370..8268b8e 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -19,6 +19,7 @@
> =A0#include <linux/leds.h>
> =A0#include <linux/slab.h>
> =A0#include <linux/suspend.h>
> +#include <linux/pm_runtime.h>
>
> =A0#include <linux/mmc/host.h>
> =A0#include <linux/mmc/card.h>
> @@ -28,6 +29,33 @@
>
> =A0#define cls_dev_to_mmc_host(d) container_of(d, struct mmc_host, cl=
ass_dev)
>
> +#ifdef CONFIG_PM_RUNTIME
> +static int mmc_host_runtime_suspend(struct device *dev)
> +{
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int mmc_host_runtime_resume(struct device *dev)
> +{
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int mmc_host_runtime_idle(struct device *dev)
> +{
> + =A0 =A0 =A0 return pm_runtime_suspend(dev);
> +}
> +#else
> +#define mmc_host_runtime_suspend =A0 =A0 =A0 NULL
> +#define mmc_host_runtime_resume =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0NULL
> +#define mmc_host_runtime_idle =A0 =A0 =A0 =A0 =A0NULL
> +#endif
> +
> +const static struct dev_pm_ops host_pm =3D {
> + =A0 =A0 =A0 .runtime_suspend =3D mmc_host_runtime_suspend,
> + =A0 =A0 =A0 .runtime_resume =3D mmc_host_runtime_resume,
> + =A0 =A0 =A0 .runtime_idle =3D mmc_host_runtime_idle,
> +};

Since the host's classdev is just a logical sub device of the parent,
and will never be power managed on its own, we don't really need those
handlers.

Instead, you can just call pm_runtime_no_callbacks(). This will tell
the PM core to assume that ->runtime_idle() always invokes
->runtime_suspend(), and that the ->runtime_{suspend, resume}
callbacks always succeed.

> +
> =A0static void mmc_host_classdev_release(struct device *dev)
> =A0{
> =A0 =A0 =A0 =A0struct mmc_host *host =3D cls_dev_to_mmc_host(dev);
> @@ -37,6 +65,7 @@ static void mmc_host_classdev_release(struct device=
 *dev)
> =A0static struct class mmc_host_class =3D {
> =A0 =A0 =A0 =A0.name =A0 =A0 =A0 =A0 =A0 =3D "mmc_host",
> =A0 =A0 =A0 =A0.dev_release =A0 =A0=3D mmc_host_classdev_release,
> + =A0 =A0 =A0 .pm =A0 =A0 =A0 =A0 =A0 =A0 =3D &host_pm,
> =A0};
>
> =A0int mmc_register_host_class(void)
> @@ -333,6 +362,12 @@ int mmc_add_host(struct mmc_host *host)
> =A0 =A0 =A0 =A0if (err)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return err;
>
> + =A0 =A0 =A0 /* Enable runtime PM */
> + =A0 =A0 =A0 pm_runtime_get_noresume(&host->class_dev);
> + =A0 =A0 =A0 pm_runtime_set_active(&host->class_dev);
> + =A0 =A0 =A0 pm_runtime_enable(&host->class_dev);
> + =A0 =A0 =A0 pm_runtime_put_sync(&host->class_dev);

Why do you need the get_noresume() and put_sync() calls here ?

If you put it in order to ensure the device is automatically powered
off after enabling runtime pm, you can just move the set_active() and
enable() calls a few lines upwards that function, just _before_ you
add the device to the device tree.

Thanks,
Ohad.

> +
> =A0#ifdef CONFIG_DEBUG_FS
> =A0 =A0 =A0 =A0mmc_add_host_debugfs(host);
> =A0#endif
> --
> 1.6.6.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
