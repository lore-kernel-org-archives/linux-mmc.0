From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/4] mmc: bcm2835: Fix DMA channel leak on probe error
Date: Mon, 28 Jan 2019 13:03:12 +0100
Message-ID: <CAPDyKFrFhnP-46wYd+JSpM4xR8fLm_jpynSURbmDsz6NwRuVvA@mail.gmail.com>
References: <9b09dda9817f61a0cfb3991abf11abb1fe7f41c9.1547911374.git.lukas@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <9b09dda9817f61a0cfb3991abf11abb1fe7f41c9.1547911374.git.lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rpi-kernel/>
List-Post: <mailto:linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "linux-rpi-kernel" <linux-rpi-kernel-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
Cc: Frank Pavlic <f.pavlic-XB/JSsFECOqzQB+pC5nmwQ@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On Sat, 19 Jan 2019 at 16:31, Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org> wrote:
>
> The BCM2835 MMC host driver requests a DMA channel on probe but neglects
> to release the channel in the probe error path.  The channel may
> therefore be leaked, in particular if devm_clk_get() causes probe
> deferral.  Fix it.
>
> Fixes: 660fc733bd74 ("mmc: bcm2835: Add new driver for the sdhost controller.")
> Signed-off-by: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
> Cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org # v4.12+
> Cc: Frank Pavlic <f.pavlic-XB/JSsFECOqzQB+pC5nmwQ@public.gmane.org>

Applied for fixes and added Stefan's tested-by tag, thanks!

For the rest of the series, I am expecting a you to re-post a v2.

Kind regards
Uffe



> ---
>  drivers/mmc/host/bcm2835.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/mmc/host/bcm2835.c b/drivers/mmc/host/bcm2835.c
> index 50293529d6de..c9e7aa50bb0a 100644
> --- a/drivers/mmc/host/bcm2835.c
> +++ b/drivers/mmc/host/bcm2835.c
> @@ -1431,6 +1431,8 @@ static int bcm2835_probe(struct platform_device *pdev)
>
>  err:
>         dev_dbg(dev, "%s -> err %d\n", __func__, ret);
> +       if (host->dma_chan_rxtx)
> +               dma_release_channel(host->dma_chan_rxtx);
>         mmc_free_host(mmc);
>
>         return ret;
> --
> 2.20.1
>
