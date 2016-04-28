From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sunxi: Disable eMMC HS-DDR (MMC_CAP_1_8V_DDR) for
 Allwinner A80
Date: Thu, 28 Apr 2016 12:38:28 +0200
Message-ID: <CAPDyKFo4xBpS=4nQzeaRs8HsBRSBsrQEuSvRPjgoQVvPUFK7jA@mail.gmail.com>
References: <1461685046-24798-1-git-send-email-wens@csie.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1461685046-24798-1-git-send-email-wens@csie.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On 26 April 2016 at 17:37, Chen-Yu Tsai <wens@csie.org> wrote:
> eMMC HS-DDR no longer works on the A80, despite it working when support
> for this developed.
>
> Disable it for now.
>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Thanks, applied for fixes!

Kind regards
Uffe

> ---
>
> Hi,
>
> When i worked on this it was working, but now it isn't. Unfortunately I
> don't have my old tree to do a proper bisect. I probably won't have time
> to dig into this issue before v4.6 release, so it's best to disable it
> on the A80 for now.
>
> Thanks.
>
> ---
>  drivers/mmc/host/sunxi-mmc.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> index 8372a413848c..7fc8b7aa83f0 100644
> --- a/drivers/mmc/host/sunxi-mmc.c
> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -1129,6 +1129,11 @@ static int sunxi_mmc_probe(struct platform_device *pdev)
>                                   MMC_CAP_1_8V_DDR |
>                                   MMC_CAP_ERASE | MMC_CAP_SDIO_IRQ;
>
> +       /* TODO MMC DDR is not working on A80 */
> +       if (of_device_is_compatible(pdev->dev.of_node,
> +                                   "allwinner,sun9i-a80-mmc"))
> +               mmc->caps &= ~MMC_CAP_1_8V_DDR;
> +
>         ret = mmc_of_parse(mmc);
>         if (ret)
>                 goto error_free_dma;
> --
> 2.8.1
>
