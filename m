From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 14/15] ARM: pxa: change SSP devices allocation
Date: Tue, 3 Apr 2018 09:06:46 +0200
Message-ID: <CAK8P3a2hYWO2eweg3zpR7iJoqtH4uxJLAxJAno7L96G7nA2HxQ@mail.gmail.com>
References: <20180402142656.26815-1-robert.jarzmik@free.fr>
 <20180402142656.26815-15-robert.jarzmik@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <20180402142656.26815-15-robert.jarzmik@free.fr>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Kate Stewart <kstewart@linuxfoundation.org>, Ulf Hansson <ulf.hansson@linaro.org>, alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>, IDE-ML <linux-ide@vger.kernel.org>, Networking <netdev@vger.kernel.org>, linux-mtd <linux-mtd@lists.infradead.org>, devel@driverdev.osuosl.org, Boris Brezillon <boris.brezillon@free-electrons.com>, Vinod Koul <vinod.koul@intel.com>, Richard Weinberger <richard@nod.at>, Takashi Iwai <tiwai@suse.com>, Russell King <linux@armlinux.org.uk>, Marek Vasut <marek.vasut@gmail.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Linux Media Mailing List <linux-media@vger.kernel.org>, Samuel Ortiz <samuel@sortiz.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Philippe Ombredanne <pombredanne@nexb.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, dmaengine@vger.kernel.org, Mark Brown <broonie@kernel.org>, Thomas
List-Id: linux-mmc@vger.kernel.org

On Mon, Apr 2, 2018 at 4:26 PM, Robert Jarzmik <robert.jarzmik@free.fr> wrote:

>
> +static struct pxa_ssp_info pxa_ssp_infos[] = {
> +       { .dma_chan_rx_name = "ssp1_rx", .dma_chan_tx_name = "ssp1_tx", },
> +       { .dma_chan_rx_name = "ssp1_rx", .dma_chan_tx_name = "ssp1_tx", },
> +       { .dma_chan_rx_name = "ssp2_rx", .dma_chan_tx_name = "ssp2_tx", },
> +       { .dma_chan_rx_name = "ssp2_rx", .dma_chan_tx_name = "ssp2_tx", },
> +       { .dma_chan_rx_name = "ssp3_rx", .dma_chan_tx_name = "ssp3_tx", },
> +       { .dma_chan_rx_name = "ssp3_rx", .dma_chan_tx_name = "ssp3_tx", },
> +       { .dma_chan_rx_name = "ssp4_rx", .dma_chan_tx_name = "ssp4_tx", },
> +       { .dma_chan_rx_name = "ssp4_rx", .dma_chan_tx_name = "ssp4_tx", },
> +};

This part looks odd to me, you're adding an extra level of indirection to
do two stages of lookups in some form of platform data.

Why can't you just always use "rx" and "tx" as the names here?

(also, I don't see why each line is duplicated, but I'm sure there's
an easy answer for that).

       Arnd
