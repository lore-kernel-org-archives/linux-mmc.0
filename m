From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/4] Documentation: mmc: sdhci-of-arasan: Add clk_syscon
 as an optional one
Date: Fri, 2 Sep 2016 09:15:08 -0500
Message-ID: <20160902141508.GA20303@rob-hp-laptop>
References: <1472457779-7194-1-git-send-email-shawn.lin@rock-chips.com>
 <1472457779-7194-2-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1472457779-7194-2-git-send-email-shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ziyuan Xu <xzy.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On Mon, Aug 29, 2016 at 04:02:56PM +0800, Shawn Lin wrote:
> We introduced soc-ctl-syscon to do several things, for instance, update
> baseclk or update clkmul, etc. In odrder to access this physical block,
> we need to explicitly enable its clock. Currently we don't control this
> clock as we always add a CLK_IGNORE_UNUSED flag for it to indicate that
> we will not gate it even if not referenced. This is not a correct way since
> it is a clock parenting from clk_ahb which is used by sdhci-of-arasan now.
> Without enabling clk_ahb, the flag don't guarantee we could access
> soc-ctl-syscon. Moreover, we can't find a reason not to gate clk_syscon
> once we remove/power-down emmc controller. So let's add clk_syscon and
> enable/disable it explicitly when needed.
> 
> Signed-off-by: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
> 
> ---
> 
>  Documentation/devicetree/bindings/mmc/arasan,sdhci.txt | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> index 3404afa..b04eb02 100644
> --- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> @@ -33,6 +33,9 @@ Optional Properties:
>    - clock-output-names: If specified, this will be the name of the card clock
>      which will be exposed by this device.  Required if #clock-cells is
>      specified.
> +  - clock-names: From clock bindings: Although we treat clock-names as required
> +    property, there is still one, "clk_syscon", should be optional as it depends
> +    on whether we need to control soc-ctl-syscon or not.

No. This doesn't look right to me. The syscon is a separate block 
and the clock for it belongs in the syscon node itself. Probably there 
needs to be some sort of ref counting in the syscon so it can do 
runtime-pm.

Rob
