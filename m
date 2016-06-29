From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 3/3] phy: rockchip-emmc: Wait even longer for the DLL to
 lock
Date: Wed, 29 Jun 2016 19:20:31 +0530
Message-ID: <5773D227.6010502@ti.com>
References: <1467049167-14628-1-git-send-email-dianders@chromium.org>
 <1467049167-14628-4-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1467049167-14628-4-git-send-email-dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org, briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org



On Monday 27 June 2016 11:09 PM, Douglas Anderson wrote:
> Two times out of 2000 reboots I ran into the error message
> "rockchip_emmc_phy_power: dllrdy timeout".  Presumably there is some
> corner case where the DLL just takes a little longer to timeout.  Let's
> give it even more time to handle these corner cases.
> 
> Signed-off-by: Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>

Acked-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
> ---
>  drivers/phy/phy-rockchip-emmc.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/phy/phy-rockchip-emmc.c b/drivers/phy/phy-rockchip-emmc.c
> index a2aa6aca7dec..fd57345ffed2 100644
> --- a/drivers/phy/phy-rockchip-emmc.c
> +++ b/drivers/phy/phy-rockchip-emmc.c
> @@ -206,8 +206,18 @@ static int rockchip_emmc_phy_power(struct phy *phy, bool on_off)
>  	 * per the math: 10.2 us * (50000000 Hz / 100000 Hz) => 5.1 ms
>  	 * Hopefully we won't be running at 100 kHz, but we should still make
>  	 * sure we wait long enough.
> +	 *
> +	 * NOTE: There appear to be corner cases where the DLL seems to take
> +	 * extra long to lock for reasons that aren't understood.  In some
> +	 * extreme cases we've seen it take up to over 10ms (!).  We'll be
> +	 * generous and give it 50ms.  We still busy wait here because:
> +	 * - In most cases it should be super fast.
> +	 * - This is not called lots during normal operation so it shouldn't
> +	 *   be a power or performance problem to busy wait.  We expect it
> +	 *   only at boot / resume.  In both cases, eMMC is probably on the
> +	 *   critical path so busy waiting a little extra time should be OK.
>  	 */
> -	timeout = jiffies + msecs_to_jiffies(10);
> +	timeout = jiffies + msecs_to_jiffies(50);
>  	do {
>  		udelay(1);
>  
> 
