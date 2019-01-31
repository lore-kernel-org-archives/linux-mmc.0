From: Faiz Abbas <faiz_abbas@ti.com>
Subject: Re: [PATCH 1/7] mmc: sdhci: add support for using external DMA
 devices
Date: Thu, 31 Jan 2019 18:02:03 +0530
Message-ID: <708d8bb6-6c64-b63d-398f-19c7f784020c@ti.com>
References: <CAG2=9p_mUyY=hKLN4E-ZUaJNueE-h5hHKDnJV5cG5kjtLsEgPA@mail.gmail.com>
 <20190130110548.19151-1-zhang.chunyan@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190130110548.19151-1-zhang.chunyan@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Chunyan Zhang <zhang.chunyan@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, Chunyan Zhang <zhang.lyra@gmail.com>
List-Id: linux-mmc@vger.kernel.org

Chunyan,

On 30/01/19 4:35 PM, Chunyan Zhang wrote:
> Some standard SD host controllers can support both external dma
> controllers as well as ADMA/SDMA in which the SD host controller
> acts as DMA master. TI's omap controller is the case as an example.
> 
> Currently the generic SDHCI code supports ADMA/SDMA integrated in
> the host controller but does not have any support for external DMA
> controllers implemented using dmaengine, meaning that custom code is
> needed for any systems that use an external DMA controller with SDHCI.
> 
> Fixes by Faiz Abbas <faiz_abbas@ti.com>:
> 1. Map scatterlists before dmaengine_prep_slave_sg()
> 2. Use dma_async() functions inside of the send_command() path and
> synchronize once at the start of each request.
> 
> Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> ---
> Changes from the last version:
> * Moved sdhci_set_timeout() from _prepare_data() to its caller -
>   sdhci_send_command();
> * Factor out a new function sdhci_reset_data() which deal with sanity
>   checks for mmc_data and reset for host->data, these processes were
>   in _prepare_data();
> * Factor out a new function sdhci_set_block_info() for configuring data
>   blocks which were processing at bottom of _prepare_data();
> * Added a new tasklet and functions for handling external dma  error case;
> * Removed sdhci_external_dma_cleanup() which is not used;
> * Added an empty sdhci_external_dma_channel definition for
>   !IS_ENABLED(CONFIG_MMC_SDHCI_EXTERNAL_DMA);
> * Addressed some other comments from Adrian:
> - Removed check for MMC_SET_BLOCK_COUNT, left checking !cmd->data only
>   which is enough.

There should have been a v2 in the patch description. It lets reviewers
know that they have seen this patch before and its not the same thing. I
would have preferred you had me test this before posting it to the
mailing list. Otherwise there should be a "not tested" in the description.

> ---
>  drivers/mmc/host/Kconfig |   3 +
>  drivers/mmc/host/sdhci.c | 333 +++++++++++++++++++++++++++++++++++----
>  drivers/mmc/host/sdhci.h |  10 ++
>  3 files changed, 317 insertions(+), 29 deletions
[snip]

> +static void sdhci_external_dma_prepare_data(struct sdhci_host *host,
> +					    struct mmc_command *cmd)
> +{
> +	struct mmc_data *data = cmd->data;
> +	struct dma_chan *chan = sdhci_external_dma_channel(host, data);
chan is not being used in this function.
> +
> +	if (!sdhci_external_dma_setup(host, cmd)) {
> +		__sdhci_external_dma_prepare_data(host, cmd);
>  	} else {
> -		sdhci_writew(host, data->blocks, SDHCI_BLOCK_COUNT);
> +		sdhci_external_dma_release(host);
> +		pr_err("%s: Cannot use external DMA, switch to the DMA/PIO which standard SDHCI provides.\n",
> +		       mmc_hostname(host->mmc));
> +		sdhci_prepare_data(host, cmd);
> +	}
> +}
> +
> +static void sdhci_external_dma_pre_transfer(struct sdhci_host *host,
> +					    struct mmc_command *cmd)
> +{
> +	struct dma_chan *chan;

I think you wanted to initialize this one.

> +
> +	if (!cmd->data)
> +		return;
> +
> +	chan = sdhci_external_dma_channel(host, cmd->data);
> +	if (chan)
> +		dma_async_issue_pending(chan);
> +}
> +
> +static bool sdhci_external_dma_request_done(struct sdhci_host *host)
> +{
> +	struct mmc_request *mrq;
> +	struct dma_chan *chan;
> +	int i;
> +
> +	spin_lock_irqsave(&host->lock, flags);

flags is not declared.

> +
> +	for (i = 0; i < SDHCI_MAX_MRQS; i++) {
> +		mrq = host->mrqs_done[i];
> +		if (mrq)
> +			break;
>  	}
> +
> +	spin_unlock_irqrestore(&host->lock, flags);
> +
> +	if (!mrq)
> +		return true;
> +
> +	sdhci_tasklet_finish(host);

This doesn't even build. sdhci_tasklet_finish is declared below this. In
the future, if you don't have a platform to test things on, at least
build and use checkpatch before posting it to the mailing list.

Should we even be calling a tasklet callback function directly?
Shouldn't we do a tasklet_schedule()?

Thanks,
Faiz
