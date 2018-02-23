From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Subject: Re: [PATCH v2] mmc: dw_mmc: Fix the DTO timeout overflow
 calculation for 32-bit systems
Date: Fri, 23 Feb 2018 11:24:34 +0800
Message-ID: <20180223112434.20bb1c2c@xhacker.debian>
References: <20180222133418.29336-1-Evgeniy.Didin@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180222133418.29336-1-Evgeniy.Didin@synopsys.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-snps-arc/>
List-Post: <mailto:linux-snps-arc@lists.infradead.org>
List-Help: <mailto:linux-snps-arc-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=subscribe>
Sender: "linux-snps-arc" <linux-snps-arc-bounces@lists.infradead.org>
Errors-To: linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org
To: Evgeniy Didin <Evgeniy.Didin@synopsys.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Vineet Gupta <Vineet.Gupta1@synopsys.com>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, linux-mmc@vger.kernel.org, Douglas Anderson <dianders@chromium.org>, stable@vger.kernel.org, linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org, Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
List-Id: linux-mmc@vger.kernel.org

On Thu, 22 Feb 2018 16:34:18 +0300 Evgeniy Didin wrote:

> In commit 9d9491a7da2a ("mmc: dw_mmc: Fix the DTO timeout calculation") have been made
> changes which cause multiply overflow for 32-bit systems.
> The broken timeout calculations caused false interrupt latency warnings
> and stacktrace splat (such as below) when accessing the SD Card.
> 
> | Running :  4M-check-reassembly-tcp-cmykw2-rotatew2.out -v0 -w1
> | -  Info: Finished target initialization.
> | mmcblk0: error -110 transferring data, sector 320544, nr 2048, cmd response
> |  0x900, card status 0x0
> | mmc_host mmc0: Bus speed (slot 0) = 50000000Hz (slot req 400000Hz, actual
> | 396825HZ div = 63)
> | mmc_host mmc0: Bus speed (slot 0) = 50000000Hz (slot req 25000000Hz, actual
> |  25000000HZ div = 1)
> | ------------[ cut here ]------------
> | softirq: huh, entered softirq 6 TASKLET 6f6a9412 with preempt_count 00000101,
> | exited with 00000100?
> | WARNING: CPU: 2 PID: 0 at ../lib/scatterlist.c:652 sg_miter_next+0x28/0x20c
> | Modules linked in:
> | CPU: 2 PID: 0 Comm: swapper/2 Not tainted 4.15.0 #57
> |
> | Stack Trace:
> |  arc_unwind_core.constprop.1+0xd0/0xf4
> |  dump_stack+0x68/0x80
> |  warn_slowpath_null+0x4e/0xec
> |  sg_miter_next+0x28/0x20c
> |  dw_mci_read_data_pio+0x44/0x190
> |  dw_mmc f000a000.mmc: Unexpected interrupt latency
> |   dw_mci_interrupt+0x3ee/0x530
> |  __handle_irq_event_percpu+0x56/0x150
> |  handle_irq_event+0x34/0x78
> |  handle_level_irq+0x8e/0x120
> |  generic_handle_irq+0x1c/0x2c
> |  idu_cascade_isr+0x30/0x6c
> |  __handle_domain_irq+0x72/0xc8
> |  ret_from_exception+0x0/0x8
> |---[ end trace 2a58c9af6c25fe51 ]---
> 
> Lets cast this multiply to u64 type which prevents overflow.
> 
> Tested-by: Vineet Gupta <Vineet.Gupta1@synopsys.com>
> Fixes: ARC STAR 9001306872 HSDK, sdio: board crashes when copying big files
> 
> Signed-off-by: Evgeniy Didin <Evgeniy.Didin@synopsys.com>
> 
> CC: Alexey Brodkin <abrodkin@synopsys.com>
> CC: Eugeniy Paltsev <paltsev@synopsys.com>
> CC: Douglas Anderson <dianders@chromium.org>
> CC: Ulf Hansson <ulf.hansson@linaro.org>
> CC: linux-kernel@vger.kernel.org
> CC: linux-snps-arc@lists.infradead.org
> Cc: <stable@vger.kernel.org> #  9d9491a7da2a mmc: dw_mmc: Fix the DTO timeout calculation
> ---
> Changes since v1:
> -uint64_t switched to u64
> -changed commit message
>  drivers/mmc/host/dw_mmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 0aa39975f33b..1a0b9751c67c 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -1944,7 +1944,7 @@ static void dw_mci_set_drto(struct dw_mci *host)
>  	drto_div = (mci_readl(host, CLKDIV) & 0xff) * 2;
>  	if (drto_div == 0)
>  		drto_div = 1;
> -	drto_ms = DIV_ROUND_UP(MSEC_PER_SEC * drto_clks * drto_div,
> +	drto_ms = DIV_ROUND_UP((u64)MSEC_PER_SEC * drto_clks * drto_div,
>  			       host->bus_hz);

DIV_ROUND_UP_ULL?

>  
>  	/* add a bit spare time */
