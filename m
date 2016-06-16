From: Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH v2.1 07/11] mmc: sdhci-of-arasan: Add ability to export card clock
Date: Fri, 17 Jun 2016 01:54:54 +0200
Message-ID: <2078624.p3pqVZlzC3@phil>
References: <1466008675-9357-8-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1466008675-9357-8-git-send-email-dianders@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Douglas Anderson <dianders@chromium.org>
Cc: ulf.hansson@linaro.org, kishon@ti.com, robh+dt@kernel.org, shawn.lin@rock-chips.com, xzy.xu@rock-chips.com, briannorris@chromium.org, adrian.hunter@intel.com, linux-rockchip@lists.infradead.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, groeck@chromium.org, michal.simek@xilinx.com, soren.brinkmann@xilinx.com, geert@linux-m68k.org, wsa+renesas@sang-engineering.com, swarren@wwwdotorg.org, stefan.wahren@i2se.com, luisbg@osg.samsung.com, andrei.pistirica@microchip.com, chaotian.jing@mediatek.com, ludovic.desroches@atmel.com, yangbo.lu@freescale.com, horms+renesas@verge.net.au, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Am Mittwoch, 15. Juni 2016, 09:37:51 schrieb Douglas Anderson:
> Some SD/eMMC PHYs (like the PHY from Arasan that is designed to work
> with arasan,sdhci-5.1) need to know the card clock in order to function
> properly.  Let's add the ability to expose this clock.  Any PHY that
> needs to know the clock rate can add a reference and query the clock
> rate.
> 
> At the moment we register a CLK_GET_RATE_NOCACHE clock that simply
> allows querying the clock.  This allows us to be less intrusive with
> regards to the main SDHCI driver, which has complex logic for adjusting
> the SD clock.  Right now we always fully power cycle the PHY when the
> clock changes and that gives the PHY a good chance to query our clock.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

for me this looks very nice implementation-wise and I also didn't spot 
glaring things, so
Reviewed-by: Heiko Stuebner <heiko@sntech.de>

and as states in the original series, on a rk3399-evb
Tested-by: Heiko Stuebner <heiko@sntech.de>
