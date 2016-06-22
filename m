From: Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 06/15] mmc: sdhci-of-arasan: Always power the PHY
 off/on when clock changes
Date: Wed, 22 Jun 2016 15:34:13 +0300
Message-ID: <576A85C5.2060700@intel.com>
References: <1466445414-11974-1-git-send-email-dianders@chromium.org>
 <1466445414-11974-7-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1466445414-11974-7-git-send-email-dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, xzy.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org, briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, groeck-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On 20/06/16 20:56, Douglas Anderson wrote:
> In commit 802ac39a5566 ("mmc: sdhci-of-arasan: fix set_clock when a phy
> is supported") we added code to power the PHY off and on whenever the
> clock was changed but we avoided doing the power cycle code when the
> clock was low speed.  Let's now do it always.
> 
> Although there may be other reasons for power cycling the PHY when the
> clock changes, one of the main reasons is that we need to give the DLL a
> chance to re-lock with the new clock.
> 
> One of the things that the DLL is for is tuning the Receive Clock in
> HS200 mode and STRB in HS400 mode.  Thus it is clear that we should make
> sure we power cycle the PHY (and wait for the DLL to lock) when we know
> we'll be in one of these two speed modes.  That's what the original code
> did, though it used the clock rate rather than the speed mode.  However,
> even in speed modes other than HS200,/HS400 the DLL is used for
> something since it can be clearly observed that the PHY doesn't function
> properly if you leave the DLL off.
> 
> Although it appears less important to power cycle the PHY and wait for
> the DLL to lock when not in HS200/HS400 modes (no bugs were reported),
> it still seems wise to let the locking always happen nevertheless.
> 
> Note: as part of this, we make sure that we never try to turn the PHY on
> when the clock is off (when the clock rate is 0).  The PHY cannot work
> when the clock is off since its DLL can't lock.
> 
> This change requires ("phy: rockchip-emmc: Increase lock time
> allowance") and will cause problems if picked without that change.
> 
> Signed-off-by: Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> Reviewed-by: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
> Tested-by: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>

Acked-by: Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
