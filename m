From: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
Subject: Re: [PATCH] mmc: core: move suspend/resume to dev_pm_ops and add
 hibernation support
Date: Mon, 9 Jan 2012 14:15:02 +0530
Message-ID: <CAM=Q2cv_sZ89YJbyqVhKYaBA=Yg3UDcv6hfpiebvMYoXkrVg3Q@mail.gmail.com>
References: <1326090169-4942-1-git-send-email-Barry.Song@csr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:56087 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751615Ab2AIIpF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 9 Jan 2012 03:45:05 -0500
Received: by vbbfc26 with SMTP id fc26so2472505vbb.19
        for <linux-mmc@vger.kernel.org>; Mon, 09 Jan 2012 00:45:04 -0800 (PST)
In-Reply-To: <1326090169-4942-1-git-send-email-Barry.Song@csr.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Barry Song <Barry.Song@csr.com>
Cc: cjb@laptop.org, linux-mmc@vger.kernel.org, linux-pm@lists.linux-foundation.org, workgroup.linux@csr.com, Bin Shi <Bin.Shi@csr.com>

Hi Bin,

On Mon, Jan 9, 2012 at 11:52 AM, Barry Song <Barry.Song@csr.com> wrote:
> From: Bin Shi <Bin.Shi@csr.com>
>
> This patch moves suspend/resume to dev_pm_ops and add hibernation sup=
port.
> It was tested on CSR SiRFprimaII cortex-a9 platform. A sd partition i=
s used
> as swsusp partition.
>
> Signed-off-by: Bin Shi <Bin.Shi@csr.com>
> Signed-off-by: Barry Song <Barry.Song@csr.com>
> ---
> =A0drivers/mmc/core/bus.c | =A0 38 +++++++++++++++++++++++++---------=
----
> =A01 files changed, 25 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
> index 6be4924..bab50f7 100644
> --- a/drivers/mmc/core/bus.c
> +++ b/drivers/mmc/core/bus.c
> @@ -122,14 +122,14 @@ static int mmc_bus_remove(struct device *dev)
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> -static int mmc_bus_suspend(struct device *dev, pm_message_t state)
> +static int mmc_bus_suspend(struct device *dev)
> =A0{
> =A0 =A0 =A0 =A0struct mmc_driver *drv =3D to_mmc_driver(dev->driver);
> =A0 =A0 =A0 =A0struct mmc_card *card =3D mmc_dev_to_card(dev);
> =A0 =A0 =A0 =A0int ret =3D 0;
>
> =A0 =A0 =A0 =A0if (dev->driver && drv->suspend)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D drv->suspend(card, state);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D drv->suspend(card, PMSG_SUSPEND=
);
> =A0 =A0 =A0 =A0return ret;
> =A0}
>
> @@ -144,6 +144,17 @@ static int mmc_bus_resume(struct device *dev)
> =A0 =A0 =A0 =A0return ret;
> =A0}
>
> +static int mmc_bus_freeze(struct device *dev)
> +{
> + =A0 =A0 =A0 struct mmc_driver *drv =3D to_mmc_driver(dev->driver);
> + =A0 =A0 =A0 struct mmc_card *card =3D mmc_dev_to_card(dev);
> + =A0 =A0 =A0 int ret =3D 0;
> +
> + =A0 =A0 =A0 if (dev->driver && drv->suspend)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D drv->suspend(card, PMSG_FREEZE)=
;

Not a comment , rather a doubt

Any particular reason to differenciate freeze and  suspend?


> + =A0 =A0 =A0 return ret;
> +}
> +
> =A0#ifdef CONFIG_PM_RUNTIME
>
> =A0static int mmc_runtime_suspend(struct device *dev)
> @@ -165,20 +176,23 @@ static int mmc_runtime_idle(struct device *dev)
> =A0 =A0 =A0 =A0return pm_runtime_suspend(dev);
> =A0}
>
> +#else /* !CONFIG_PM_RUNTIME */
> +#define mmc_runtime_suspend =A0 =A0NULL
> +#define mmc_runtime_resume =A0 =A0 NULL
> +#define mmc_runtime_idle =A0 =A0 =A0 NULL
> +#endif /* !CONFIG_PM_RUNTIME */
> +
> =A0static const struct dev_pm_ops mmc_bus_pm_ops =3D {
> =A0 =A0 =A0 =A0.runtime_suspend =A0 =A0 =A0 =A0=3D mmc_runtime_suspen=
d,
> =A0 =A0 =A0 =A0.runtime_resume =A0 =A0 =A0 =A0 =3D mmc_runtime_resume=
,
> =A0 =A0 =A0 =A0.runtime_idle =A0 =A0 =A0 =A0 =A0 =3D mmc_runtime_idle=
,
> + =A0 =A0 =A0 .suspend =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D mmc_bus_sus=
pend,
> + =A0 =A0 =A0 .resume =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D mmc_bus_res=
ume,
> + =A0 =A0 =A0 .freeze =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D mmc_bus_fre=
eze,
> + =A0 =A0 =A0 .restore =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D mmc_bus_res=
ume,
> + =A0 =A0 =A0 .thaw =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D mmc_bus_r=
esume,
> =A0};
>
> -#define MMC_PM_OPS_PTR (&mmc_bus_pm_ops)
> -
> -#else /* !CONFIG_PM_RUNTIME */
> -
> -#define MMC_PM_OPS_PTR NULL
> -
> -#endif /* !CONFIG_PM_RUNTIME */
> -
> =A0static struct bus_type mmc_bus_type =3D {
> =A0 =A0 =A0 =A0.name =A0 =A0 =A0 =A0 =A0 =3D "mmc",
> =A0 =A0 =A0 =A0.dev_attrs =A0 =A0 =A0=3D mmc_dev_attrs,
> @@ -186,9 +200,7 @@ static struct bus_type mmc_bus_type =3D {
> =A0 =A0 =A0 =A0.uevent =A0 =A0 =A0 =A0 =3D mmc_bus_uevent,
> =A0 =A0 =A0 =A0.probe =A0 =A0 =A0 =A0 =A0=3D mmc_bus_probe,
> =A0 =A0 =A0 =A0.remove =A0 =A0 =A0 =A0 =3D mmc_bus_remove,
> - =A0 =A0 =A0 .suspend =A0 =A0 =A0 =A0=3D mmc_bus_suspend,
> - =A0 =A0 =A0 .resume =A0 =A0 =A0 =A0 =3D mmc_bus_resume,
> - =A0 =A0 =A0 .pm =A0 =A0 =A0 =A0 =A0 =A0 =3D MMC_PM_OPS_PTR,
> + =A0 =A0 =A0 .pm =A0 =A0 =A0 =A0 =A0 =A0 =3D &mmc_bus_pm_ops,
> =A0};
>
> =A0int mmc_register_bus(void)
> --
> 1.7.1
>
>
>
> Member of the CSR plc group of companies. CSR plc registered in Engla=
nd and Wales, registered number 4187346, registered office Churchill Ho=
use, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United K=
ingdom
> More information can be found at www.csr.com. Follow CSR on Twitter a=
t http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
