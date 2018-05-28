From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sunxi: mark PM functions as __maybe_unused
Date: Mon, 28 May 2018 13:04:16 +0200
Message-ID: <CAPDyKFoyBZ=k5UQyTmgkPd+30Htymw99Xeh3C+bDPo+VGyjrNw@mail.gmail.com>
References: <20180525210752.1794502-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180525210752.1794502-1-arnd@arndb.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On 25 May 2018 at 23:07, Arnd Bergmann <arnd@arndb.de> wrote:
> The newly added runtime-pm functions cause a harmless warning
> when CONFIG_PM is disabled:
>
> drivers/mmc/host/sunxi-mmc.c:1452:12: error: 'sunxi_mmc_runtime_suspend' defined but not used [-Werror=unused-function]
>  static int sunxi_mmc_runtime_suspend(struct device *dev)
>             ^~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/mmc/host/sunxi-mmc.c:1435:12: error: 'sunxi_mmc_runtime_resume' defined but not used [-Werror=unused-function]
>  static int sunxi_mmc_runtime_resume(struct device *dev)
>
> This marks them as __maybe_unused to shut up the warning.

Most mmc drivers uses #ifdef CONFIG_PM instead of the __maybe_unused() option.

It's not a big deal, but consistency is always good. Would you mind changing?

Br
Uffe

>
> Fixes: 9a8e1e8cc2c0 ("mmc: sunxi: Add runtime_pm support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/mmc/host/sunxi-mmc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> index 97c6b79b7d6f..837888b96bd3 100644
> --- a/drivers/mmc/host/sunxi-mmc.c
> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -1432,7 +1432,7 @@ static int sunxi_mmc_remove(struct platform_device *pdev)
>         return 0;
>  }
>
> -static int sunxi_mmc_runtime_resume(struct device *dev)
> +static int __maybe_unused sunxi_mmc_runtime_resume(struct device *dev)
>  {
>         struct mmc_host *mmc = dev_get_drvdata(dev);
>         struct sunxi_mmc_host *host = mmc_priv(mmc);
> @@ -1449,7 +1449,7 @@ static int sunxi_mmc_runtime_resume(struct device *dev)
>         return 0;
>  }
>
> -static int sunxi_mmc_runtime_suspend(struct device *dev)
> +static int __maybe_unused sunxi_mmc_runtime_suspend(struct device *dev)
>  {
>         struct mmc_host *mmc = dev_get_drvdata(dev);
>         struct sunxi_mmc_host *host = mmc_priv(mmc);
> --
> 2.9.0
>
