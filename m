From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-msm: fix x86 build error
Date: Tue, 10 Oct 2017 12:58:26 +0200
Message-ID: <CAPDyKFpPUovhhFSiMtk2KhGuJ0dq8xrRvwkPZ-0QMeKLuti0_Q@mail.gmail.com>
References: <20171010091427.2244260-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171010091427.2244260-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ritesh Harjani <riteshh@codeaurora.org>, Sahitya Tummala <stummala@codeaurora.org>, Venkat Gopalakrishnan <venkatg@codeaurora.org>, Subhash Jadavani <subhashj@codeaurora.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Vijay Viswanath <vviswana@codeaurora.org>, Pramod Gurav <pramod.gurav@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 10 October 2017 at 11:14, Arnd Bergmann <arnd@arndb.de> wrote:
> The __WARN_printf() function is not portable across architectures
> and causes a compile-time error on x86 and others that don't use
> the asm-generic version of asm/bug.h:
>
> drivers/mmc/host/sdhci-msm.c: In function 'sdhci_msm_check_power_status':
> drivers/mmc/host/sdhci-msm.c:1066:4: error: implicit declaration of function '__WARN_printf'; did you mean '__dev_printk'? [-Werror=implicit-function-declaration]
>     __WARN_printf("%s: pwr_irq for req: (%d) timed out\n",
>     ^~~~~~~~~~~~~
>
> I assume that dev_warn() is the function that was meant to be used
> here, so I'm changing it over to that.
>
> Fixes: 6cdf3287f490 ("mmc: sdhci-msm: Add sdhci msm register write APIs which wait for pwr irq")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks, applied for next! Removing the fixes tag, but kept the
information, as the hash no longer exists due to a re-base of my tree.

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-msm.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index 85a882b4c541..3fb7d2eec93f 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -1063,8 +1063,9 @@ static void sdhci_msm_check_power_status(struct sdhci_host *host, u32 req_type)
>                 if (!wait_event_timeout(msm_host->pwr_irq_wait,
>                                 msm_host->pwr_irq_flag,
>                                 msecs_to_jiffies(MSM_PWR_IRQ_TIMEOUT_MS)))
> -                       __WARN_printf("%s: pwr_irq for req: (%d) timed out\n",
> -                                       mmc_hostname(host->mmc), req_type);
> +                       dev_warn(&msm_host->pdev->dev,
> +                                "%s: pwr_irq for req: (%d) timed out\n",
> +                                mmc_hostname(host->mmc), req_type);
>         }
>         pr_debug("%s: %s: request %d done\n", mmc_hostname(host->mmc),
>                         __func__, req_type);
> --
> 2.9.0
>
