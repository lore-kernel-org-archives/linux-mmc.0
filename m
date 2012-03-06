From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] mmc: omap_hsmmc: Fix Unbalanced pm_runtime_enable warning
Date: Mon, 05 Mar 2012 16:09:28 -0800
Message-ID: <87obsaio93.fsf@ti.com>
References: <20120305234240.GQ12083@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20120305234240.GQ12083@atomide.com> (Tony Lindgren's message of
 "Mon, 5 Mar 2012 15:42:41 -0800")
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>, Chris Ball <cjb@laptop.org>
Cc: linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Tony Lindgren <tony@atomide.com> writes:

> mmc: omap_hsmmc: Fix Unbalanced pm_runtime_enable warning
>
> Otherwise we can get following warning when re-loading the
> omap_hsmmc driver module when gpio_twl4030 module is not
> loaded:
>
> omap_hsmmc omap_hsmmc.0: Unbalanced pm_runtime_enable!
> omap_hsmmc omap_hsmmc.0: Unable to grab MMC CD IRQ
> omap_hsmmc: probe of omap_hsmmc.0 failed with error -22
>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>
> Kevin, maybe take a look and see if this is correct and
> fits into your PM branches?

Looks right to me:

Acked-by: Kevin Hilman <khilman@ti.com>

But this is a fix to the driver itself, so Chris should queue this in
mmc-next.

Chris, can you take this one?

Kevin


>
> Tony
>
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -2146,6 +2146,7 @@ err_irq_cd_init:
>  err_irq:
>  	pm_runtime_mark_last_busy(host->dev);
>  	pm_runtime_put_autosuspend(host->dev);
> +	pm_runtime_disable(host->dev);
>  	clk_put(host->fclk);
>  	if (host->got_dbclk) {
>  		clk_disable(host->dbclk);
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
