From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: s3cmci: Register cpufreq notifier only on S3C24xx
Date: Wed, 6 Jul 2016 18:21:01 +0200
Message-ID: <CAPDyKFpO0xdLxC5u3G4gYa0uVMdXRj0-aOpC+wEZ9UP=tkO=qA@mail.gmail.com>
References: <1467031923-10415-1-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1467031923-10415-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Ben Dooks <ben-linux@fluff.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-mmc@vger.kernel.org

On 27 June 2016 at 14:52, Krzysztof Kozlowski <k.kozlowski@samsung.com> wrote:
> The driver registered for CPU frequency transitions to recalculate its
> clock when ARM clock frequency changes (ratio between frequencies of
> ARM's parent clock (fclk) and clock for peripherals remains fixed).
>
> This is needed only on S3C24xx platform when cpufreq driver is enabled
> so limit the ifdef to respective cpufreq Kconfig.
>
> Suggested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/s3cmci.c | 2 +-
>  drivers/mmc/host/s3cmci.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/s3cmci.c b/drivers/mmc/host/s3cmci.c
> index 39814f3dc96f..c531deef3258 100644
> --- a/drivers/mmc/host/s3cmci.c
> +++ b/drivers/mmc/host/s3cmci.c
> @@ -1365,7 +1365,7 @@ static struct s3c24xx_mci_pdata s3cmci_def_pdata = {
>          .no_detect = 1,
>  };
>
> -#ifdef CONFIG_CPU_FREQ
> +#ifdef CONFIG_ARM_S3C24XX_CPUFREQ
>
>  static int s3cmci_cpufreq_transition(struct notifier_block *nb,
>                                      unsigned long val, void *data)
> diff --git a/drivers/mmc/host/s3cmci.h b/drivers/mmc/host/s3cmci.h
> index cc2e46cb5c64..30c2c0dd1bc8 100644
> --- a/drivers/mmc/host/s3cmci.h
> +++ b/drivers/mmc/host/s3cmci.h
> @@ -74,7 +74,7 @@ struct s3cmci_host {
>         struct dentry           *debug_regs;
>  #endif
>
> -#ifdef CONFIG_CPU_FREQ
> +#ifdef CONFIG_ARM_S3C24XX_CPUFREQ
>         struct notifier_block   freq_transition;
>  #endif
>  };
> --
> 1.9.1
>
