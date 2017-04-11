From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 2/2] mmc: sdhci: provide isr for card-detect interrupts
Date: Tue, 11 Apr 2017 13:31:16 +0300
Message-ID: <772c085c-beba-cfe8-23ca-0c46a96145fe@intel.com>
References: <20170411102056.2869-1-jszhang@marvell.com>
 <20170411102056.2869-3-jszhang@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170411102056.2869-3-jszhang@marvell.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jisheng Zhang <jszhang@marvell.com>, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On 11/04/17 13:20, Jisheng Zhang wrote:
> We found one issue on BG4CT platforms with GPIO for sdcar card detect
> interrupt: remove sdcard when there's read write access to the sdcard,
> sometimes the card remove event can't be handled for a long time, so
> the  system still think the sdcard is still plugged in. It turns out
> that the sdhci_card_event() is missing in common slot gpio's card
> detect isr.

->card_event() is called by mmc_rescan().  Why is that too late?

> 
> We fix this issue by providing sdhci's own isr for card-detect
> interrupts. In this own isr, we call sdhci_card_event() then process
> the change of state.

Why doesn't every other host controller have this problem?

> 
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> ---
>  drivers/mmc/host/sdhci.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 63bc33a54d0d..b6c5021a5892 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2777,6 +2777,16 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
>  	return result;
>  }
>  
> +static irqreturn_t sdhci_cd_irq(int irq, void *dev_id)
> +{
> +	struct mmc_host *mmc = dev_id;
> +	struct sdhci_host *host = mmc_priv(mmc);
> +
> +	mmc->ops->card_event(mmc);
> +	mmc_detect_change(host->mmc, msecs_to_jiffies(200));
> +	return IRQ_HANDLED;
> +}
> +
>  static irqreturn_t sdhci_thread_irq(int irq, void *dev_id)
>  {
>  	struct sdhci_host *host = dev_id;
> @@ -3617,6 +3627,8 @@ int __sdhci_add_host(struct sdhci_host *host)
>  
>  	sdhci_init(host, 0);
>  
> +	mmc_gpio_set_cd_isr(mmc, sdhci_cd_irq);
> +
>  	ret = request_threaded_irq(host->irq, sdhci_irq, sdhci_thread_irq,
>  				   IRQF_SHARED,	mmc_hostname(mmc), host);
>  	if (ret) {
> 
