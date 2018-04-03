From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 02/15] ARM: pxa: add dma slave map
Date: Tue, 3 Apr 2018 08:51:37 +0200
Message-ID: <CAK8P3a3pSitVqfiF2LK0cMrAKLOeCWXXJBLeVc5f_Tg=vALkUA@mail.gmail.com>
References: <20180402142656.26815-1-robert.jarzmik@free.fr>
 <20180402142656.26815-3-robert.jarzmik@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <20180402142656.26815-3-robert.jarzmik@free.fr>
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
Cc: Ulf Hansson <ulf.hansson@linaro.org>, alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>, IDE-ML <linux-ide@vger.kernel.org>, Networking <netdev@vger.kernel.org>, linux-mtd <linux-mtd@lists.infradead.org>, devel@driverdev.osuosl.org, Boris Brezillon <boris.brezillon@free-electrons.com>, Vinod Koul <vinod.koul@intel.com>, Richard Weinberger <richard@nod.at>, Takashi Iwai <tiwai@suse.com>, Russell King <linux@armlinux.org.uk>, Marek Vasut <marek.vasut@gmail.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Linux Media Mailing List <linux-media@vger.kernel.org>, Samuel Ortiz <samuel@sortiz.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, dmaengine@vger.kernel.org, Mark Brown <broonie@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Nicolas
List-Id: linux-mmc@vger.kernel.org

On Mon, Apr 2, 2018 at 4:26 PM, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
> +
> +static const struct dma_slave_map pxa_slave_map[] = {
> +       /* PXA25x, PXA27x and PXA3xx common entries */
> +       { "pxa-pcm-audio", "ac97_mic_mono", PDMA_FILTER_PARAM(LOWEST, 8) },
> +       { "pxa-pcm-audio", "ac97_aux_mono_in", PDMA_FILTER_PARAM(LOWEST, 9) },
> +       { "pxa-pcm-audio", "ac97_aux_mono_out", PDMA_FILTER_PARAM(LOWEST, 10) },
> +       { "pxa-pcm-audio", "ac97_stereo_in", PDMA_FILTER_PARAM(LOWEST, 11) },
> +       { "pxa-pcm-audio", "ac97_stereo_out", PDMA_FILTER_PARAM(LOWEST, 12) },
> +       { "pxa-pcm-audio", "ssp1_rx", PDMA_FILTER_PARAM(LOWEST, 13) },
> +       { "pxa-pcm-audio", "ssp1_tx", PDMA_FILTER_PARAM(LOWEST, 14) },
> +       { "pxa-pcm-audio", "ssp2_rx", PDMA_FILTER_PARAM(LOWEST, 15) },
> +       { "pxa-pcm-audio", "ssp2_tx", PDMA_FILTER_PARAM(LOWEST, 16) },
> +       { "pxa2xx-ir", "rx", PDMA_FILTER_PARAM(LOWEST, 17) },
> +       { "pxa2xx-ir", "tx", PDMA_FILTER_PARAM(LOWEST, 18) },
> +       { "pxa2xx-mci.0", "rx", PDMA_FILTER_PARAM(LOWEST, 21) },
> +       { "pxa2xx-mci.0", "tx", PDMA_FILTER_PARAM(LOWEST, 22) },


> +       { "smc911x.0", "rx", PDMA_FILTER_PARAM(LOWEST, -1) },
> +       { "smc911x.0", "tx", PDMA_FILTER_PARAM(LOWEST, -1) },
> +       { "smc91x.0", "data", PDMA_FILTER_PARAM(LOWEST, -1) },

This one is interesting, as you are dealing with an off-chip device,
and the channel number is '-'1. How does this even work? Does it
mean

> +       /* PXA25x specific map */
> +       { "pxa25x-ssp.0", "rx", PDMA_FILTER_PARAM(LOWEST, 13) },
> +       { "pxa25x-ssp.0", "tx", PDMA_FILTER_PARAM(LOWEST, 14) },
> +       { "pxa25x-nssp.1", "rx", PDMA_FILTER_PARAM(LOWEST, 15) },
> +       { "pxa25x-nssp.1", "tx", PDMA_FILTER_PARAM(LOWEST, 16) },
> +       { "pxa25x-nssp.2", "rx", PDMA_FILTER_PARAM(LOWEST, 23) },
> +       { "pxa25x-nssp.2", "tx", PDMA_FILTER_PARAM(LOWEST, 24) },
> +       { "pxa-pcm-audio", "nssp2_rx", PDMA_FILTER_PARAM(LOWEST, 15) },
> +       { "pxa-pcm-audio", "nssp2_tx", PDMA_FILTER_PARAM(LOWEST, 16) },
> +       { "pxa-pcm-audio", "nssp3_rx", PDMA_FILTER_PARAM(LOWEST, 23) },
> +       { "pxa-pcm-audio", "nssp3_tx", PDMA_FILTER_PARAM(LOWEST, 24) },
> +
> +       /* PXA27x specific map */
> +       { "pxa-pcm-audio", "ssp3_rx", PDMA_FILTER_PARAM(LOWEST, 66) },
> +       { "pxa-pcm-audio", "ssp3_tx", PDMA_FILTER_PARAM(LOWEST, 67) },
> +       { "pxa27x-camera.0", "CI_Y", PDMA_FILTER_PARAM(HIGHEST, 68) },
> +       { "pxa27x-camera.0", "CI_U", PDMA_FILTER_PARAM(HIGHEST, 69) },
> +       { "pxa27x-camera.0", "CI_V", PDMA_FILTER_PARAM(HIGHEST, 70) },
> +
> +       /* PXA3xx specific map */
> +       { "pxa-pcm-audio", "ssp4_rx", PDMA_FILTER_PARAM(LOWEST, 2) },
> +       { "pxa-pcm-audio", "ssp4_tx", PDMA_FILTER_PARAM(LOWEST, 3) },
> +       { "pxa2xx-mci.1", "rx", PDMA_FILTER_PARAM(LOWEST, 93) },
> +       { "pxa2xx-mci.1", "tx", PDMA_FILTER_PARAM(LOWEST, 94) },
> +       { "pxa3xx-nand", "data", PDMA_FILTER_PARAM(LOWEST, 97) },
> +       { "pxa2xx-mci.2", "rx", PDMA_FILTER_PARAM(LOWEST, 100) },
> +       { "pxa2xx-mci.2", "tx", PDMA_FILTER_PARAM(LOWEST, 101) },
> +};

Since more than half the entries in here are chip specific, maybe it would be
better to split that table into three and have a copy for each one in
arch/arm/mach-pxa/pxa{25x.27x.3xx}.c? Does that mean it's actually
a memory-to-memory transfer with a device being on the external
SRAM interface?

       Arnd
