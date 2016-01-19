From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [RFC PATCH 3/3] mmc: pwrseq: convert to proper platform device
Date: Tue, 19 Jan 2016 14:01:46 +0100
Message-ID: <CAPDyKFpsQwmdXxSaAx=KkL4q3anrRDsvnOd3_4f0rTzjDJes4g@mail.gmail.com>
References: <1453201052-2347-1-git-send-email-srinivas.kandagatla@linaro.org>
	<1453201155-2598-1-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f177.google.com ([209.85.160.177]:35870 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753033AbcASNBr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Jan 2016 08:01:47 -0500
Received: by mail-yk0-f177.google.com with SMTP id v14so552718400ykd.3
        for <linux-mmc@vger.kernel.org>; Tue, 19 Jan 2016 05:01:46 -0800 (PST)
In-Reply-To: <1453201155-2598-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 19 January 2016 at 11:59, Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
> simple-pwrseq and emmc-pwrseq drivers rely on platform_device
> structure from of_find_device_by_node(), this works mostly. But, as t=
here
> is no driver associated with this devices, cases like default/init pi=
nctrl
> setup would never be performed by pwrseq. This becomes problem when t=
he
> gpios used in pwrseq require pinctrl setup.
>
> Currently most of the common pinctrl setup is done in
> drivers/base/pinctrl.c by pinctrl_bind_pins().
>
> There are two ways to slove this issue on either convert pwrseq drive=
rs
> to a proper platform drivers or copy the exact code from
> pcintrl_bind_pins(). I prefer converting pwrseq to proper drivers so =
that
> other cases like setting up clks/parents from dt would also be possib=
le.

Overall I like the approach, thanks for posting this!

I have browsed through the patch, it looks okay, besides one issue...

There is a possibility that the pwrseq drivers haven't been probed
before mmc_pwrseq_alloc() gets called. This leads to that the
pwrseq_list may be empty, which means that we would silently fail to
find a corresponding pwrseq type even if the device node would say
there should be one.

Perhaps you should do a pre-validation of the device node in
mmc_pwrseq_alloc(), to see if there is a pwrseq handle. If so, but no
corresponding pwrseq method registerd (because the driver hasn=E2=80=99=
t been
probed yet), you could return -EPROBE_DEFER. Or perhaps there are
other alternatives to solved this issue!?

Kind regards
Uffe

>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  drivers/mmc/core/pwrseq.c        | 99 ++++++++++++++++++++----------=
----------
>  drivers/mmc/core/pwrseq.h        | 13 ++++--
>  drivers/mmc/core/pwrseq_emmc.c   | 65 ++++++++++++++++----------
>  drivers/mmc/core/pwrseq_simple.c | 71 ++++++++++++++++++----------
>  4 files changed, 145 insertions(+), 103 deletions(-)
>
> diff --git a/drivers/mmc/core/pwrseq.c b/drivers/mmc/core/pwrseq.c
> index 4c1d175..669608e 100644
> --- a/drivers/mmc/core/pwrseq.c
> +++ b/drivers/mmc/core/pwrseq.c
> @@ -8,50 +8,30 @@
>   *  MMC power sequence management
>   */
>  #include <linux/kernel.h>
> -#include <linux/platform_device.h>
>  #include <linux/err.h>
>  #include <linux/of.h>
> -#include <linux/of_platform.h>
>
>  #include <linux/mmc/host.h>
>
>  #include "pwrseq.h"
>
> -struct mmc_pwrseq_match {
> -       const char *compatible;
> -       struct mmc_pwrseq *(*alloc)(struct mmc_host *host, struct dev=
ice *dev);
> -};
> -
> -static struct mmc_pwrseq_match pwrseq_match[] =3D {
> -       {
> -               .compatible =3D "mmc-pwrseq-simple",
> -               .alloc =3D mmc_pwrseq_simple_alloc,
> -       }, {
> -               .compatible =3D "mmc-pwrseq-emmc",
> -               .alloc =3D mmc_pwrseq_emmc_alloc,
> -       },
> -};
> -
> -static struct mmc_pwrseq_match *mmc_pwrseq_find(struct device_node *=
np)
> +static DEFINE_MUTEX(pwrseq_list_mutex);
> +static LIST_HEAD(pwrseq_list);
> +
> +static struct mmc_pwrseq *of_find_mmc_pwrseq(struct device_node *np)
>  {
> -       struct mmc_pwrseq_match *match =3D ERR_PTR(-ENODEV);
> -       int i;
> +       struct mmc_pwrseq *p;
>
> -       for (i =3D 0; i < ARRAY_SIZE(pwrseq_match); i++) {
> -               if (of_device_is_compatible(np, pwrseq_match[i].compa=
tible)) {
> -                       match =3D &pwrseq_match[i];
> -                       break;
> -               }
> -       }
> +       list_for_each_entry(p, &pwrseq_list, list)
> +               if (p->dev->of_node =3D=3D np)
> +                       return p;
>
> -       return match;
> +       return NULL;
>  }
>
>  int mmc_pwrseq_alloc(struct mmc_host *host)
>  {
> -       struct platform_device *pdev;
>         struct device_node *np;
> -       struct mmc_pwrseq_match *match;
>         struct mmc_pwrseq *pwrseq;
>         int ret =3D 0;
>
> @@ -59,25 +39,18 @@ int mmc_pwrseq_alloc(struct mmc_host *host)
>         if (!np)
>                 return 0;
>
> -       pdev =3D of_find_device_by_node(np);
> -       if (!pdev) {
> -               ret =3D -ENODEV;
> -               goto err;
> -       }
> +       pwrseq =3D of_find_mmc_pwrseq(np);
>
> -       match =3D mmc_pwrseq_find(np);
> -       if (IS_ERR(match)) {
> -               ret =3D PTR_ERR(match);
> -               goto err;
> -       }
> +       if (pwrseq && pwrseq->ops && pwrseq->ops->alloc) {
> +               host->pwrseq =3D pwrseq;
> +               ret =3D pwrseq->ops->alloc(host);
> +               if (IS_ERR_VALUE(ret)) {
> +                       host->pwrseq =3D NULL;
> +                       goto err;
> +               }
>
> -       pwrseq =3D match->alloc(host, &pdev->dev);
> -       if (IS_ERR(pwrseq)) {
> -               ret =3D PTR_ERR(pwrseq);
> -               goto err;
>         }
>
> -       host->pwrseq =3D pwrseq;
>         dev_info(host->parent, "allocated mmc-pwrseq\n");
>
>  err:
> @@ -89,7 +62,7 @@ void mmc_pwrseq_pre_power_on(struct mmc_host *host)
>  {
>         struct mmc_pwrseq *pwrseq =3D host->pwrseq;
>
> -       if (pwrseq && pwrseq->ops && pwrseq->ops->pre_power_on)
> +       if (pwrseq && pwrseq->ops->pre_power_on)
>                 pwrseq->ops->pre_power_on(host);
>  }
>
> @@ -97,7 +70,7 @@ void mmc_pwrseq_post_power_on(struct mmc_host *host=
)
>  {
>         struct mmc_pwrseq *pwrseq =3D host->pwrseq;
>
> -       if (pwrseq && pwrseq->ops && pwrseq->ops->post_power_on)
> +       if (pwrseq && pwrseq->ops->post_power_on)
>                 pwrseq->ops->post_power_on(host);
>  }
>
> @@ -105,7 +78,7 @@ void mmc_pwrseq_power_off(struct mmc_host *host)
>  {
>         struct mmc_pwrseq *pwrseq =3D host->pwrseq;
>
> -       if (pwrseq && pwrseq->ops && pwrseq->ops->power_off)
> +       if (pwrseq && pwrseq->ops->power_off)
>                 pwrseq->ops->power_off(host);
>  }
>
> @@ -113,8 +86,34 @@ void mmc_pwrseq_free(struct mmc_host *host)
>  {
>         struct mmc_pwrseq *pwrseq =3D host->pwrseq;
>
> -       if (pwrseq && pwrseq->ops && pwrseq->ops->free)
> -               pwrseq->ops->free(host);
> +       if (pwrseq) {
> +               if (pwrseq->ops->free)
> +                       pwrseq->ops->free(host);
> +
> +               host->pwrseq =3D NULL;
> +       }
>
> -       host->pwrseq =3D NULL;
>  }
> +
> +int mmc_pwrseq_register(struct mmc_pwrseq *pwrseq)
> +{
> +       if (!pwrseq || !pwrseq->ops || !pwrseq->dev)
> +               return -EINVAL;
> +
> +       mutex_lock(&pwrseq_list_mutex);
> +       list_add(&pwrseq->list, &pwrseq_list);
> +       mutex_unlock(&pwrseq_list_mutex);
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(mmc_pwrseq_register);
> +
> +void mmc_pwrseq_unregister(struct mmc_pwrseq *pwrseq)
> +{
> +       if (pwrseq) {
> +               mutex_lock(&pwrseq_list_mutex);
> +               list_del(&pwrseq->list);
> +               mutex_unlock(&pwrseq_list_mutex);
> +       }
> +}
> +EXPORT_SYMBOL_GPL(mmc_pwrseq_unregister);
> diff --git a/drivers/mmc/core/pwrseq.h b/drivers/mmc/core/pwrseq.h
> index 096da48..08a7d2d 100644
> --- a/drivers/mmc/core/pwrseq.h
> +++ b/drivers/mmc/core/pwrseq.h
> @@ -8,7 +8,10 @@
>  #ifndef _MMC_CORE_PWRSEQ_H
>  #define _MMC_CORE_PWRSEQ_H
>
> +#include <linux/mmc/host.h>
> +
>  struct mmc_pwrseq_ops {
> +       int (*alloc)(struct mmc_host *host);
>         void (*pre_power_on)(struct mmc_host *host);
>         void (*post_power_on)(struct mmc_host *host);
>         void (*power_off)(struct mmc_host *host);
> @@ -17,21 +20,21 @@ struct mmc_pwrseq_ops {
>
>  struct mmc_pwrseq {
>         struct mmc_pwrseq_ops *ops;
> +       struct device *dev;
> +       struct list_head list;
>  };
>
>  #ifdef CONFIG_OF
>
> +int mmc_pwrseq_register(struct mmc_pwrseq *pwrseq);
> +void mmc_pwrseq_unregister(struct mmc_pwrseq *pwrseq);
> +
>  int mmc_pwrseq_alloc(struct mmc_host *host);
>  void mmc_pwrseq_pre_power_on(struct mmc_host *host);
>  void mmc_pwrseq_post_power_on(struct mmc_host *host);
>  void mmc_pwrseq_power_off(struct mmc_host *host);
>  void mmc_pwrseq_free(struct mmc_host *host);
>
> -struct mmc_pwrseq *mmc_pwrseq_simple_alloc(struct mmc_host *host,
> -                                          struct device *dev);
> -struct mmc_pwrseq *mmc_pwrseq_emmc_alloc(struct mmc_host *host,
> -                                        struct device *dev);
> -
>  #else
>
>  static inline int mmc_pwrseq_alloc(struct mmc_host *host) { return 0=
; }
> diff --git a/drivers/mmc/core/pwrseq_emmc.c b/drivers/mmc/core/pwrseq=
_emmc.c
> index 7978fb7..75f7423 100644
> --- a/drivers/mmc/core/pwrseq_emmc.c
> +++ b/drivers/mmc/core/pwrseq_emmc.c
> @@ -9,6 +9,7 @@
>   */
>  #include <linux/delay.h>
>  #include <linux/kernel.h>
> +#include <linux/platform_device.h>
>  #include <linux/slab.h>
>  #include <linux/device.h>
>  #include <linux/err.h>
> @@ -48,14 +49,8 @@ static void mmc_pwrseq_emmc_free(struct mmc_host *=
host)
>
>         unregister_restart_handler(&pwrseq->reset_nb);
>         gpiod_put(pwrseq->reset_gpio);
> -       kfree(pwrseq);
>  }
>
> -static struct mmc_pwrseq_ops mmc_pwrseq_emmc_ops =3D {
> -       .post_power_on =3D mmc_pwrseq_emmc_reset,
> -       .free =3D mmc_pwrseq_emmc_free,
> -};
> -
>  static int mmc_pwrseq_emmc_reset_nb(struct notifier_block *this,
>                                     unsigned long mode, void *cmd)
>  {
> @@ -66,21 +61,14 @@ static int mmc_pwrseq_emmc_reset_nb(struct notifi=
er_block *this,
>         return NOTIFY_DONE;
>  }
>
> -struct mmc_pwrseq *mmc_pwrseq_emmc_alloc(struct mmc_host *host,
> -                                        struct device *dev)
> +static int mmc_pwrseq_emmc_alloc(struct mmc_host *host)
>  {
> -       struct mmc_pwrseq_emmc *pwrseq;
> -       int ret =3D 0;
> -
> -       pwrseq =3D kzalloc(sizeof(struct mmc_pwrseq_emmc), GFP_KERNEL=
);
> -       if (!pwrseq)
> -               return ERR_PTR(-ENOMEM);
> +       struct mmc_pwrseq_emmc *pwrseq =3D  to_pwrseq_emmc(host->pwrs=
eq);
>
> -       pwrseq->reset_gpio =3D gpiod_get(dev, "reset", GPIOD_OUT_LOW)=
;
> -       if (IS_ERR(pwrseq->reset_gpio)) {
> -               ret =3D PTR_ERR(pwrseq->reset_gpio);
> -               goto free;
> -       }
> +       pwrseq->reset_gpio =3D gpiod_get(host->pwrseq->dev,
> +                                       "reset", GPIOD_OUT_LOW);
> +       if (IS_ERR(pwrseq->reset_gpio))
> +               return PTR_ERR(pwrseq->reset_gpio);
>
>         /*
>          * register reset handler to ensure emmc reset also from
> @@ -91,10 +79,41 @@ struct mmc_pwrseq *mmc_pwrseq_emmc_alloc(struct m=
mc_host *host,
>         pwrseq->reset_nb.priority =3D 255;
>         register_restart_handler(&pwrseq->reset_nb);
>
> +       return 0;
> +}
> +
> +static struct mmc_pwrseq_ops mmc_pwrseq_emmc_ops =3D {
> +       .alloc =3D mmc_pwrseq_emmc_alloc,
> +       .post_power_on =3D mmc_pwrseq_emmc_reset,
> +       .free =3D mmc_pwrseq_emmc_free,
> +};
> +
> +static int mmc_pwrseq_emmc_probe(struct platform_device *pdev)
> +{
> +       struct mmc_pwrseq_emmc *pwrseq;
> +       struct device *dev =3D &pdev->dev;
> +
> +       pwrseq =3D devm_kzalloc(dev, sizeof(*pwrseq), GFP_KERNEL);
> +       if (!pwrseq)
> +               return -ENOMEM;
> +
>         pwrseq->pwrseq.ops =3D &mmc_pwrseq_emmc_ops;
> +       pwrseq->pwrseq.dev =3D dev;
>
> -       return &pwrseq->pwrseq;
> -free:
> -       kfree(pwrseq);
> -       return ERR_PTR(ret);
> +       return mmc_pwrseq_register(&pwrseq->pwrseq);
>  }
> +
> +static const struct of_device_id mmc_pwrseq_emmc_of_match[] =3D {
> +       { .compatible =3D "mmc-pwrseq-emmc",},
> +       {/* sentinel */},
> +};
> +
> +static struct platform_driver mmc_pwrseq_emmc_driver =3D {
> +       .probe =3D mmc_pwrseq_emmc_probe,
> +       .driver =3D {
> +               .name =3D "pwrseq_emmc",
> +               .of_match_table =3D mmc_pwrseq_emmc_of_match,
> +       },
> +};
> +
> +builtin_platform_driver(mmc_pwrseq_emmc_driver);
> diff --git a/drivers/mmc/core/pwrseq_simple.c b/drivers/mmc/core/pwrs=
eq_simple.c
> index c091f98..b04cc2d 100644
> --- a/drivers/mmc/core/pwrseq_simple.c
> +++ b/drivers/mmc/core/pwrseq_simple.c
> @@ -9,6 +9,7 @@
>   */
>  #include <linux/clk.h>
>  #include <linux/kernel.h>
> +#include <linux/platform_device.h>
>  #include <linux/slab.h>
>  #include <linux/device.h>
>  #include <linux/err.h>
> @@ -82,46 +83,66 @@ static void mmc_pwrseq_simple_free(struct mmc_hos=
t *host)
>         if (!IS_ERR(pwrseq->ext_clk))
>                 clk_put(pwrseq->ext_clk);
>
> -       kfree(pwrseq);
>  }
>
> -static struct mmc_pwrseq_ops mmc_pwrseq_simple_ops =3D {
> -       .pre_power_on =3D mmc_pwrseq_simple_pre_power_on,
> -       .post_power_on =3D mmc_pwrseq_simple_post_power_on,
> -       .power_off =3D mmc_pwrseq_simple_power_off,
> -       .free =3D mmc_pwrseq_simple_free,
> -};
> -
> -struct mmc_pwrseq *mmc_pwrseq_simple_alloc(struct mmc_host *host,
> -                                          struct device *dev)
> +int mmc_pwrseq_simple_alloc(struct mmc_host *host)
>  {
> -       struct mmc_pwrseq_simple *pwrseq;
> +       struct mmc_pwrseq_simple *pwrseq =3D to_pwrseq_simple(host->p=
wrseq);
> +       struct device *dev =3D host->pwrseq->dev;
>         int ret =3D 0;
>
> -       pwrseq =3D kzalloc(sizeof(*pwrseq), GFP_KERNEL);
> -       if (!pwrseq)
> -               return ERR_PTR(-ENOMEM);
> -
>         pwrseq->ext_clk =3D clk_get(dev, "ext_clock");
>         if (IS_ERR(pwrseq->ext_clk) &&
>             PTR_ERR(pwrseq->ext_clk) !=3D -ENOENT) {
> -               ret =3D PTR_ERR(pwrseq->ext_clk);
> -               goto free;
> +               return PTR_ERR(pwrseq->ext_clk);
> +
>         }
>
>         pwrseq->reset_gpios =3D gpiod_get_array(dev, "reset", GPIOD_O=
UT_HIGH);
>         if (IS_ERR(pwrseq->reset_gpios)) {
>                 ret =3D PTR_ERR(pwrseq->reset_gpios);
> -               goto clk_put;
> +               clk_put(pwrseq->ext_clk);
> +               return ret;
>         }
>
> +       return 0;
> +}
> +
> +static struct mmc_pwrseq_ops mmc_pwrseq_simple_ops =3D {
> +       .alloc =3D mmc_pwrseq_simple_alloc,
> +       .pre_power_on =3D mmc_pwrseq_simple_pre_power_on,
> +       .post_power_on =3D mmc_pwrseq_simple_post_power_on,
> +       .power_off =3D mmc_pwrseq_simple_power_off,
> +       .free =3D mmc_pwrseq_simple_free,
> +};
> +
> +static const struct of_device_id mmc_pwrseq_simple_of_match[] =3D {
> +       { .compatible =3D "mmc-pwrseq-simple",},
> +       {/* sentinel */},
> +};
> +
> +static int mmc_pwrseq_simple_probe(struct platform_device *pdev)
> +{
> +       struct mmc_pwrseq_simple *pwrseq;
> +       struct device *dev =3D &pdev->dev;
> +
> +       pwrseq =3D devm_kzalloc(dev, sizeof(*pwrseq), GFP_KERNEL);
> +       if (!pwrseq)
> +               return ERR_PTR(-ENOMEM);
> +
> +       pwrseq->pwrseq.dev =3D dev;
>         pwrseq->pwrseq.ops =3D &mmc_pwrseq_simple_ops;
>
> -       return &pwrseq->pwrseq;
> -clk_put:
> -       if (!IS_ERR(pwrseq->ext_clk))
> -               clk_put(pwrseq->ext_clk);
> -free:
> -       kfree(pwrseq);
> -       return ERR_PTR(ret);
> +       return mmc_pwrseq_register(&pwrseq->pwrseq);
>  }
> +
> +
> +static struct platform_driver mmc_pwrseq_simple_driver =3D {
> +       .probe =3D mmc_pwrseq_simple_probe,
> +       .driver =3D {
> +               .name =3D "pwrseq_simple",
> +               .of_match_table =3D mmc_pwrseq_simple_of_match,
> +       },
> +};
> +
> +builtin_platform_driver(mmc_pwrseq_simple_driver);
> --
> 1.9.1
>
