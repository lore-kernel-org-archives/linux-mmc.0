From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2] mmc: atmel-mci: adopt pinctrl support
Date: Mon, 10 Nov 2014 12:43:29 +0100
Message-ID: <CAPDyKFp6wXqP1x0uO12=mgrCsjvx4vfkr9cCJVAtjkFQ7s=q2A@mail.gmail.com>
References: <1415321293-17521-1-git-send-email-wenyou.yang@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1415321293-17521-1-git-send-email-wenyou.yang@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wenyou Yang <wenyou.yang@atmel.com>
Cc: Chris Ball <chris@printf.net>, Kevin Hilman <khilman@kernel.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Ludovic Desroches <ludovic.desroches@atmel.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On 7 November 2014 01:48, Wenyou Yang <wenyou.yang@atmel.com> wrote:
> Amend the atmel mci pin controller to optionally take a pin control
> handle and set the state of the pins to:
> - "default" on boot, resume and before performing an transfer.
> - "sleep" on suspend().
>
> This should make it possible to optimize energy usage for the pins
> both for the suspend/resume cycle.
>
> Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>

Thanks! Applied for next.

Kind regards
Uffe

> ---
> Hi Ulf,
>
> Thanks a lot.
>
> According to your advice, remove pinctrl_pm_select_default_state(&pdev->dev) from the _probe function.
>
> Best Regards,
> Wenyou Yang
>
>  drivers/mmc/host/atmel-mci.c |    5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
> index 4df1599..a7b59ba 100644
> --- a/drivers/mmc/host/atmel-mci.c
> +++ b/drivers/mmc/host/atmel-mci.c
> @@ -39,6 +39,7 @@
>  #include <linux/atmel_pdc.h>
>  #include <linux/pm.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/pinctrl/consumer.h>
>
>  #include <asm/cacheflush.h>
>  #include <asm/io.h>
> @@ -2568,6 +2569,8 @@ static int atmci_runtime_suspend(struct device *dev)
>
>         clk_disable_unprepare(host->mck);
>
> +       pinctrl_pm_select_sleep_state(dev);
> +
>         return 0;
>  }
>
> @@ -2575,6 +2578,8 @@ static int atmci_runtime_resume(struct device *dev)
>  {
>         struct atmel_mci *host = dev_get_drvdata(dev);
>
> +       pinctrl_pm_select_default_state(dev);
> +
>         return clk_prepare_enable(host->mck);
>  }
>  #endif
> --
> 1.7.9.5
>
