From: Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH 02/11] mmc: dw_mmc: Re-store SDIO IRQs mask at system
 resume
Date: Wed, 4 Sep 2019 17:14:22 -0700
Message-ID: <20190905001422.GH70797@google.com>
References: <20190903142207.5825-1-ulf.hansson@linaro.org>
 <20190903142207.5825-3-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190903142207.5825-3-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Douglas Anderson <dianders@chromium.org>, Shawn Lin <shawn.lin@rock-chips.com>, Jaehoon Chung <jh80.chung@samsung.com>, Yong Mao <yong.mao@mediatek.com>, Chaotian Jing <chaotian.jing@mediatek.com>, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Tue, Sep 03, 2019 at 04:21:58PM +0200, Ulf Hansson wrote:
> In cases when SDIO IRQs have been enabled, runtime suspend is prevented by
> the driver. However, this still means dw_mci_runtime_suspend|resume() gets
> called during system suspend/resume, via pm_runtime_force_suspend|resume().
> This means during system suspend/resume, the register context of the dw_mmc
> device most likely loses its register context, even in cases when SDIO IRQs
> have been enabled.
> 
> To re-enable the SDIO IRQs during system resume, the dw_mmc driver
> currently relies on the mmc core to re-enable the SDIO IRQs when it resumes
> the SDIO card, but this isn't the recommended solution. Instead, it's
> better to deal with this locally in the dw_mmc driver, so let's do that.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/mmc/host/dw_mmc.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index eea52e2c5a0c..f114710e82b4 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -3460,6 +3460,10 @@ int dw_mci_runtime_resume(struct device *dev)
>  	/* Force setup bus to guarantee available clock output */
>  	dw_mci_setup_bus(host->slot, true);
>  
> +	/* Re-enable SDIO interrupts. */
> +	if (sdio_irq_enabled(host->slot->mmc))
> +		__dw_mci_enable_sdio_irq(host->slot, 1);
> +
>  	/* Now that slots are all setup, we can enable card detect */
>  	dw_mci_enable_cd(host);

Looks reasonable to me, besides the bikeshedding over
'sdio_irq_enabled' (in "mmc: core: Add helper function to indicate
if SDIO IRQs is enabled").

One thing I wonder is why this change is only needed for dw_mmc and
mtk-sd, but not for others like sunxi_mmc. Any insights for a SDIO
newb?
