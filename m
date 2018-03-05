From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v4] mmc: dw_mmc: Fix the DTO/CTO timeout overflow
 calculation for 32-bit systems
Date: Mon, 5 Mar 2018 09:46:09 +0100
Message-ID: <CAPDyKFrfo1S5xFRp7T+ayO2rEk7mxu1LgykUZuAMGevq+u6RLg@mail.gmail.com>
References: <20180228115318.20154-1-Evgeniy.Didin@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180228115318.20154-1-Evgeniy.Didin@synopsys.com>
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
Cc: Jisheng Zhang <Jisheng.Zhang@synaptics.com>, Shawn Lin <shawn.lin@rock-chips.com>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Douglas Anderson <dianders@chromium.org>, "# 4.0+" <stable@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, linux-snps-arc@lists.infradead.org, Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, Vineet Gupta <Vineet.Gupta1@synopsys.com>
List-Id: linux-mmc@vger.kernel.org

On 28 February 2018 at 12:53, Evgeniy Didin <Evgeniy.Didin@synopsys.com> wrote:
> In commit 9d9491a7da2a ("mmc: dw_mmc: Fix the DTO timeout calculation") and
> commit 4c2357f57dd5 ("mmc: dw_mmc: Fix the CTO timeout calculation")
> have been made changes which cause multiply overflow for 32-bit systems.
> The broken timeout calculations leads to unexpected ETIMEDOUT errors and
> causes stacktrace splat (such as below) during normal data exchange
> with SD-card.
>
> | Running :  4M-check-reassembly-tcp-cmykw2-rotatew2.out -v0 -w1
> | -  Info: Finished target initialization.
> | mmcblk0: error -110 transferring data, sector 320544, nr 2048, cmd response
> |  0x900, card status 0x0
>
> DIV_ROUND_UP_ULL helps to escape usage of __udivdi3() from libgcc and so
> code gets compiled on all 32-bit platforms as opposed to usage
> of DIV_ROUND_UP when we may only compile stuff on a very few arches.
>
> Lets cast this multiply to u64 type which prevents overflow.
>
> Tested-by: Vineet Gupta <Vineet.Gupta1@synopsys.com>
> Reported-by: Vineet Gupta <Vineet.Gupta1@synopsys.com> # ARC STAR 9001306872 HSDK, sdio: board crashes when copying big files
> Fixes: 9d9491a7da2a ("mmc: dw_mmc: Fix the DTO timeout calculation")
> Fixes: 4c2357f57dd5 ("mmc: dw_mmc: Fix the CTO timeout calculation")
>
> Signed-off-by: Evgeniy Didin <Evgeniy.Didin@synopsys.com>
>
> CC: Alexey Brodkin <abrodkin@synopsys.com>
> CC: Eugeniy Paltsev <paltsev@synopsys.com>
> CC: Douglas Anderson <dianders@chromium.org>
> CC: Ulf Hansson <ulf.hansson@linaro.org>
> CC: Andy Shevchenko <andy.shevchenko@gmail.com>
> CC: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> CC: Shawn Lin <shawn.lin@rock-chips.com>
> CC: Vineet Gupta <Vineet.Gupta1@synopsys.com>
> CC: linux-kernel@vger.kernel.org
> CC: linux-snps-arc@lists.infradead.org
> Cc: <stable@vger.kernel.org>

Thanks, applied for fixes! I took the liberty to remove this cc-list
and did some additional minor cleanups of the change log.

Kind regards
Uffe

> ---
> Changes since v3:
> -Switch DIV_ROUND_UP macro to DIV_ROUND_UP_ULL
> -Make one patch from two patches
> -Modify commit message
>
> Changes sinve v2:
> -add fix for cto_ms
>
> Changes since v1:
> -uint64_t switched to u64
>
>  drivers/mmc/host/dw_mmc.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 0aa39975f33b..cba534d4c81b 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -409,7 +409,9 @@ static inline void dw_mci_set_cto(struct dw_mci *host)
>         cto_div = (mci_readl(host, CLKDIV) & 0xff) * 2;
>         if (cto_div == 0)
>                 cto_div = 1;
> -       cto_ms = DIV_ROUND_UP(MSEC_PER_SEC * cto_clks * cto_div, host->bus_hz);
> +
> +       cto_ms = DIV_ROUND_UP_ULL((u64)MSEC_PER_SEC * cto_clks * cto_div,
> +                                 host->bus_hz);
>
>         /* add a bit spare time */
>         cto_ms += 10;
> @@ -1944,8 +1946,9 @@ static void dw_mci_set_drto(struct dw_mci *host)
>         drto_div = (mci_readl(host, CLKDIV) & 0xff) * 2;
>         if (drto_div == 0)
>                 drto_div = 1;
> -       drto_ms = DIV_ROUND_UP(MSEC_PER_SEC * drto_clks * drto_div,
> -                              host->bus_hz);
> +
> +       drto_ms = DIV_ROUND_UP_ULL((u64)MSEC_PER_SEC * drto_clks * drto_div,
> +                                  host->bus_hz);
>
>         /* add a bit spare time */
>         drto_ms += 10;
> --
> 2.11.0
>
