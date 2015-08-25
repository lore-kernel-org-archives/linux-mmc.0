From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] pwrseq: bind pinctrl pins before using the gpios
Date: Tue, 25 Aug 2015 14:06:54 +0200
Message-ID: <CAPDyKFqMOr5DwDcOjDTUV4Eaqp4VK1Q-Dt2_KcG-GtsNOr8JkQ@mail.gmail.com>
References: <1439812687-18259-1-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1439812687-18259-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 17 August 2015 at 13:58, Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
> Some of the pin-controllers like the Qualcomms "qcom,pm8921", which
> require a pinconf to be setup to use pins as gpios. Using the pins
> directly without pinconf setup would result in incorrect output voltage
> or load settings. On the other hand pwrseq code does not configure the
> pinctrl by default as it does not go thru the driver core.
>
> This patch adds a call to pinctrl_bind_pins() to bind pins which
> are going to be used as gpios.
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Thanks, applied for next! I add the "mmc:" to the prefix of the commit
message header.

Kind regards
Uffe

> ---
>  drivers/mmc/core/pwrseq.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/mmc/core/pwrseq.c b/drivers/mmc/core/pwrseq.c
> index 4c1d175..6e5d8b3 100644
> --- a/drivers/mmc/core/pwrseq.c
> +++ b/drivers/mmc/core/pwrseq.c
> @@ -12,6 +12,7 @@
>  #include <linux/err.h>
>  #include <linux/of.h>
>  #include <linux/of_platform.h>
> +#include <linux/pinctrl/devinfo.h>
>
>  #include <linux/mmc/host.h>
>
> @@ -65,6 +66,10 @@ int mmc_pwrseq_alloc(struct mmc_host *host)
>                 goto err;
>         }
>
> +       ret = pinctrl_bind_pins(&pdev->dev);
> +       if (ret)
> +               goto err;
> +
>         match = mmc_pwrseq_find(np);
>         if (IS_ERR(match)) {
>                 ret = PTR_ERR(match);
> --
> 1.9.1
>
