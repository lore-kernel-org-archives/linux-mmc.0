From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: mxs-mmc: Enable MMC_CAP_ERASE
Date: Mon, 18 Mar 2019 11:52:01 +0100
Message-ID: <CAPDyKFrpZ8ok8w_ezH+3rHZ=Q68Y=OauH2jfu-6CqyESdK4dFA@mail.gmail.com>
References: <1552580302-11393-1-git-send-email-stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1552580302-11393-1-git-send-email-stefan.wahren@i2se.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, 14 Mar 2019 at 17:18, Stefan Wahren <stefan.wahren@i2se.com> wrote:
>
> According to the i.MX23/28 reference manuals both mmc interfaces support
> the MMC_ERASE command. So enable this capability in the driver to allow
> erase/discard/trim requests.
>
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/mxs-mmc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
> index 4f06fb0..c021d43 100644
> --- a/drivers/mmc/host/mxs-mmc.c
> +++ b/drivers/mmc/host/mxs-mmc.c
> @@ -648,7 +648,8 @@ static int mxs_mmc_probe(struct platform_device *pdev)
>         /* set mmc core parameters */
>         mmc->ops = &mxs_mmc_ops;
>         mmc->caps = MMC_CAP_SD_HIGHSPEED | MMC_CAP_MMC_HIGHSPEED |
> -                   MMC_CAP_SDIO_IRQ | MMC_CAP_NEEDS_POLL | MMC_CAP_CMD23;
> +                   MMC_CAP_SDIO_IRQ | MMC_CAP_NEEDS_POLL | MMC_CAP_CMD23 |
> +                   MMC_CAP_ERASE;
>
>         host->broken_cd = of_property_read_bool(np, "broken-cd");
>
> --
> 2.7.4
>
