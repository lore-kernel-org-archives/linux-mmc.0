From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 21/32] mmc: bcm2835-sdhost: Add new driver for the internal SD controller.
Date: Thu, 02 Jun 2016 00:18:52 +0200
Message-ID: <4715245.LFBOAeJdHc@wuerfel>
References: <1464817421-8519-1-git-send-email-kraxel@redhat.com> <1464817421-8519-22-git-send-email-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464817421-8519-22-git-send-email-kraxel@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: linux-rpi-kernel@lists.infradead.org, Eric Anholt <eric@anholt.net>, Ulf Hansson <ulf.hansson@linaro.org>, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, open list <linux-kernel@vger.kernel.org>, "open list:MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND..." <linux-mmc@vger.kernel.org>, "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On Wednesday, June 1, 2016 11:43:30 PM CEST Gerd Hoffmann wrote:

> +static void bcm2835_sdhost_reset_internal(struct bcm2835_host *host)
> +{
> +	u32 temp;
> +
> +	bcm2835_sdhost_set_power(host, false);
> +
> +	bcm2835_sdhost_write(host, 0, SDCMD);
> +	bcm2835_sdhost_write(host, 0, SDARG);
> +	bcm2835_sdhost_write(host, 0xf00000, SDTOUT);
> +	bcm2835_sdhost_write(host, 0, SDCDIV);
> +	bcm2835_sdhost_write(host, 0x7f8, SDHSTS); /* Write 1s to clear */
> +	bcm2835_sdhost_write(host, 0, SDHCFG);
> +	bcm2835_sdhost_write(host, 0, SDHBCT);
> +	bcm2835_sdhost_write(host, 0, SDHBLC);
> +
> +	/* Limit fifo usage due to silicon bug */
> +	temp = bcm2835_sdhost_read(host, SDEDM);
> +	temp &= ~((SDEDM_THRESHOLD_MASK << SDEDM_READ_THRESHOLD_SHIFT) |
> +		  (SDEDM_THRESHOLD_MASK << SDEDM_WRITE_THRESHOLD_SHIFT));
> +	temp |= (FIFO_READ_THRESHOLD << SDEDM_READ_THRESHOLD_SHIFT) |
> +		(FIFO_WRITE_THRESHOLD << SDEDM_WRITE_THRESHOLD_SHIFT);
> +	bcm2835_sdhost_write(host, temp, SDEDM);
> +	mdelay(10);
> +	bcm2835_sdhost_set_power(host, true);
> +	mdelay(10);

Are you sure you cannot use msleep() here?

> +	host->clock = 0;
> +	bcm2835_sdhost_write(host, host->hcfg, SDHCFG);
> +	bcm2835_sdhost_write(host, host->cdiv, SDCDIV);
> +	mmiowb();
> +}

What is the barrier for? Same question for all the other instances

> +
> +static void bcm2835_sdhost_reset(struct mmc_host *mmc)
> +{
> +	struct bcm2835_host *host = mmc_priv(mmc);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&host->lock, flags);
> +	bcm2835_sdhost_reset_internal(host);
> +	spin_unlock_irqrestore(&host->lock, flags);
> +}

The spinlock seems to only protect the reset from happening concurrently
with bcm2835_sdhost_dma_complete() here. So if you ensure that this
function is no longer pending, you can probably use msleep() above.

> +static void bcm2835_sdhost_set_ios(struct mmc_host *mmc, struct mmc_ios *ios);

Maybe rearrange the order of the functions to avoid forward declarations?

> +	spin_lock_init(&host->lock);
> +
> +	if (IS_ERR_OR_NULL(host->dma_chan_tx) ||
> +	    IS_ERR_OR_NULL(host->dma_chan_rx)) {
> +		pr_err("%s: unable to initialise DMA channels. Falling back to PIO\n",
> +		       mmc_hostname(mmc));

When are these ever NULL?

> +	/* Parse OF address directly to get the physical address for
> +	 * DMA to our registers.
> +	 */
> +	host->phys_addr = be32_to_cpup(of_get_address(pdev->dev.of_node, 0,
> +						      NULL, NULL));

This looks broken on 64-bit systems when #address-cells=<2>, or if there
is an intermediate bus with a non-empty ranges property.

What's wrong with platform_get_resource(pdev, IORESOURCE_MEM, 0)?

	Arnd
