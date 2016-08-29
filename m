From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-msm: Add pm_runtime and system PM support
Date: Mon, 29 Aug 2016 16:20:25 +0200
Message-ID: <CAPDyKFraYWS+ZFLAhRfnhVEac6j8+oyGz6AVwnCgvEHxxvvLpQ@mail.gmail.com>
References: <1466080509-24015-1-git-send-email-pramod.gurav@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1466080509-24015-1-git-send-email-pramod.gurav@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Pramod Gurav <pramod.gurav@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 16 June 2016 at 14:35, Pramod Gurav <pramod.gurav@linaro.org> wrote:
> Provides runtime PM callbacks to enable and disable clock resources
> when idle. Also support system PM callbacks to be called during system
> suspend and resume.
>
> Signed-off-by: Pramod Gurav <pramod.gurav@linaro.org>
> ---
>  drivers/mmc/host/sdhci-msm.c | 57 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index 0653fe7..f4394c8 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -18,6 +18,7 @@
>  #include <linux/of_device.h>
>  #include <linux/delay.h>
>  #include <linux/mmc/mmc.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/slab.h>
>
>  #include "sdhci-pltfm.h"
> @@ -549,6 +550,11 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>         if (ret)
>                 goto clk_disable;
>
> +       platform_set_drvdata(pdev, msm_host);
> +
> +       pm_runtime_set_active(&pdev->dev);
> +       pm_runtime_enable(&pdev->dev);

I think you need to move these a bit earlier, before calling sdhci_add_host().

Maybe it's just easier if you look at the sdhci-of-at91.c driver,
which behaves nicely around runtime PM deployment. You can probably
use the very similar code, except the ->runtime_suspend|resume()
callbacks.

And don't forget to deploy runtime PM support in the ->remove()
callback as well, again sdhci-of-at91 is a good reference.

[...]

Kind regards
Uffe
