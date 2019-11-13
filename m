From: Marc Gonzalez <marc.w.gonzalez@free.fr>
Subject: Re: [PATCH 2/3] mmc: mmci: Bail out from odd DMA on Ux500
Date: Wed, 13 Nov 2019 11:29:23 +0100
Message-ID: <1f500a2b-5c81-5423-4e56-61566919cbb9@free.fr>
References: <20191113075335.31775-1-linus.walleij@linaro.org>
 <20191113075335.31775-3-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20191113075335.31775-3-linus.walleij@linaro.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Linus Walleij <linus.walleij@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Stephan Gerhold <stephan@gerhold.net>, MMC <linux-mmc@vger.kernel.org>, Russell King <rmk+kernel@armlinux.org.uk>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Niklas Cassel <niklas.cassel@linaro.org>, Ludovic Barre <ludovic.barre@st.com>, Brian Masney <masneyb@onstation.org>
List-Id: linux-mmc@vger.kernel.org

On 13/11/2019 08:53, Linus Walleij wrote:

> The Ux500 (at least) can only deal with DMA transactions
> starting and ending on an even 4-byte aligned address.
> 
> The problem isn't in the DMA engine of the system as such:
> the problem is in the state machine of the MMCI block that
> has some features to handle single bytes but it seems like
> it doesn't quite work.
> 
> This problem is probably caused by most of the testing
> being done on mass storage, which will be 512-bytes aligned
> blocks placed neatly in pages and practically never run into
> this situation.
> 
> On SDIO (for example in WiFi adapters) this situation is
> common.
> 
> By avoiding any such transfers with a special vendor flag,
> we can bail out to PIO when an odd transfer is detected
> while keeping DMA for large transfers of evenly aligned
> packages also for SDIO.
> 
> Cc: Ludovic Barre <ludovic.barre@st.com>
> Cc: Brian Masney <masneyb@onstation.org>
> Cc: Stephan Gerhold <stephan@gerhold.net>
> Cc: Niklas Cassel <niklas.cassel@linaro.org>
> Cc: Russell King <rmk+kernel@armlinux.org.uk>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v3:
> - New patch in v3 after discussion with Ulf
> ---
>  drivers/mmc/host/mmci.c | 21 +++++++++++++++++++++
>  drivers/mmc/host/mmci.h | 10 ++++++++++
>  2 files changed, 31 insertions(+)
> 
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index 3ffcdf78a428..a08cd845dddc 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -185,6 +185,7 @@ static struct variant_data variant_ux500 = {
>  	.irq_pio_mask		= MCI_IRQ_PIO_MASK,
>  	.start_err		= MCI_STARTBITERR,
>  	.opendrain		= MCI_OD,
> +	.only_long_aligned_dma	= true,
>  	.init			= mmci_variant_init,
>  };
>  
> @@ -219,6 +220,7 @@ static struct variant_data variant_ux500v2 = {
>  	.irq_pio_mask		= MCI_IRQ_PIO_MASK,
>  	.start_err		= MCI_STARTBITERR,
>  	.opendrain		= MCI_OD,
> +	.only_long_aligned_dma	= true,
>  	.init			= ux500v2_variant_init,
>  };
>  
> @@ -829,6 +831,25 @@ static int _mmci_dmae_prep_data(struct mmci_host *host, struct mmc_data *data,
>  	if (data->blksz * data->blocks <= variant->fifosize)
>  		return -EINVAL;
>  
> +	/*
> +	 * Handle the variants with DMA that is broken such that start and
> +	 * end address must be aligned on a long (32bit) boundary for the DMA
> +	 * to work. If this occurs, fall back to PIO.
> +	 */

Nit: why use 'long' as a synonym for "32 bits" ?

Why not name the field "only_32b_aligned_dma" ?

(The size of C's long int is implementation-defined; most 64-bit platforms
have a 64-bit long int.)

Perhaps the ship has already sailed -- what with readl/writel...

Regards.
