From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 3/8] mmc: sdhci-pxav3: fix error handling of
 armada_38x_quirks
Date: Thu, 8 Oct 2015 19:35:58 +0200
Message-ID: <CAPDyKFrA1NKDY=z=MMSXeW_naVCAAJnMa_ZfDqo1-tnpbNCoRg@mail.gmail.com>
References: <1444094562-31165-1-git-send-email-mw@semihalf.com>
 <1444094562-31165-4-git-send-email-mw@semihalf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1444094562-31165-4-git-send-email-mw@semihalf.com>
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
> In case of armada_38x_quirks error, all clocks should be cleaned-up, same
> as after mv_conf_mbus_windows failure.
>
> Signed-off-by: Marcin Wojtas <mw@semihalf.com>
> Cc: <stable@vger.kernel.org> # v4.2

Thanks, applied for fixes!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-pxav3.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
> index 89a9e49..f5edf9d 100644
> --- a/drivers/mmc/host/sdhci-pxav3.c
> +++ b/drivers/mmc/host/sdhci-pxav3.c
> @@ -402,7 +402,7 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
>         if (of_device_is_compatible(np, "marvell,armada-380-sdhci")) {
>                 ret = armada_38x_quirks(pdev, host);
>                 if (ret < 0)
> -                       goto err_clk_get;
> +                       goto err_mbus_win;
>                 ret = mv_conf_mbus_windows(pdev, mv_mbus_dram_info());
>                 if (ret < 0)
>                         goto err_mbus_win;
> --
> 1.8.3.1
>
