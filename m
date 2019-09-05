From: Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH 07/11] mmc: core: WARN if SDIO IRQs are enabled for
 non-powered card in suspend
Date: Thu, 5 Sep 2019 10:38:13 -0700
Message-ID: <20190905173813.GL70797@google.com>
References: <20190903142207.5825-1-ulf.hansson@linaro.org>
 <20190903142207.5825-8-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190903142207.5825-8-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Douglas Anderson <dianders@chromium.org>, Shawn Lin <shawn.lin@rock-chips.com>, Jaehoon Chung <jh80.chung@samsung.com>, Yong Mao <yong.mao@mediatek.com>, Chaotian Jing <chaotian.jing@mediatek.com>, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Tue, Sep 03, 2019 at 04:22:03PM +0200, Ulf Hansson wrote:
> To make sure SDIO func drivers behaves correctly during system
> suspend/resume, let add a WARN_ON in case the condition is a non-powered
> SDIO card and there are some SDIO IRQs still being claimed.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/mmc/core/sdio.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
> index 8dd8fc32ecca..c557f1519b77 100644
> --- a/drivers/mmc/core/sdio.c
> +++ b/drivers/mmc/core/sdio.c
> @@ -951,6 +951,8 @@ static int mmc_sdio_pre_suspend(struct mmc_host *host)
>   */
>  static int mmc_sdio_suspend(struct mmc_host *host)
>  {
> +	WARN_ON(host->sdio_irqs && !mmc_card_keep_power(host));
> +
>  	/* Prevent processing of SDIO IRQs in suspended state. */
>  	mmc_card_set_suspended(host->card);
>  	cancel_delayed_work_sync(&host->sdio_irq_work);

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
