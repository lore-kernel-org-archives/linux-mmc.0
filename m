From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v2 2/4] mmc: sdhci: remove #indef CONFIG_PM around
 function declarations
Date: Mon, 14 Aug 2017 13:29:49 +0300
Message-ID: <e7e49120-ffcc-27a4-5533-d6e83e25c9df@intel.com>
References: <1501724656-12435-1-git-send-email-yamada.masahiro@socionext.com>
 <1501724656-12435-3-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:42340 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752896AbdHNKgQ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 14 Aug 2017 06:36:16 -0400
In-Reply-To: <1501724656-12435-3-git-send-email-yamada.masahiro@socionext.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>, linux-mmc@vger.kernel.org
Cc: Piotr Sroka <piotrs@cadence.com>, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>

On 03/08/17 04:44, Masahiro Yamada wrote:
> We need not surround declarations with #ifdef.  Besides, drivers may
> want to call these from PM callbacks marked with __maybe_unused.

No, we use #ifdef not __maybe_unused, and removing the #ifdef is misleading.

> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
> Changes in v2:
>   - Newly added
> 
>  drivers/mmc/host/sdhci.h | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 0469fa191493..773b38127da2 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -709,15 +709,11 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios);
>  int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
>  				      struct mmc_ios *ios);
>  void sdhci_enable_sdio_irq(struct mmc_host *mmc, int enable);
> -
> -#ifdef CONFIG_PM
>  int sdhci_suspend_host(struct sdhci_host *host);
>  int sdhci_resume_host(struct sdhci_host *host);
>  void sdhci_enable_irq_wakeups(struct sdhci_host *host);
>  int sdhci_runtime_suspend_host(struct sdhci_host *host);
>  int sdhci_runtime_resume_host(struct sdhci_host *host);
> -#endif
> -
>  void sdhci_cqe_enable(struct mmc_host *mmc);
>  void sdhci_cqe_disable(struct mmc_host *mmc, bool recovery);
>  bool sdhci_cqe_irq(struct sdhci_host *host, u32 intmask, int *cmd_error,
> 

