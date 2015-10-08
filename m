From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/8] mmc: sdhci-pxav3: remove broken clock base quirk for
 Armada 38x sdhci driver
Date: Thu, 8 Oct 2015 19:35:46 +0200
Message-ID: <CAPDyKFrdZPbmK1Gtw8f-uKeYGbZLdfTtsCnLPUPC1XFa8Xmb1A@mail.gmail.com>
References: <1444094562-31165-1-git-send-email-mw@semihalf.com>
 <1444094562-31165-2-git-send-email-mw@semihalf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1444094562-31165-2-git-send-email-mw@semihalf.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Marcin Wojtas <mw@semihalf.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, Tawfik Bayouk <tawfik@marvell.com>, jaz@semihalf.com, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "# 4.0+" <stable@vger.kernel.org>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, Gregory Clement <gregory.clement@free-electrons.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-mmc@vger.kernel.org

On 6 October 2015 at 03:22, Marcin Wojtas <mw@semihalf.com> wrote:
> From: Nadav Haklai <nadavh@marvell.com>
>
> shci-pxav3 driver is enabling by default the
> SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN quirk. However this quirk is not
> required for Armada 38x and leads to wrong clock setting in the divider.
>
> Signed-off-by: Nadav Haklai <nadavh@marvell.com>
> Signed-off-by: Marcin Wojtas <mw@semihalf.com>
> Cc: <stable@vger.kernel.org> # v4.2

Thanks, applied for fixes!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-pxav3.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
> index 946d37f..976cddd 100644
> --- a/drivers/mmc/host/sdhci-pxav3.c
> +++ b/drivers/mmc/host/sdhci-pxav3.c
> @@ -135,6 +135,7 @@ static int armada_38x_quirks(struct platform_device *pdev,
>         struct sdhci_pxa *pxa = pltfm_host->priv;
>         struct resource *res;
>
> +       host->quirks &= ~SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN;
>         host->quirks |= SDHCI_QUIRK_MISSING_CAPS;
>         res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
>                                            "conf-sdio3");
> --
> 1.8.3.1
>
