From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v3 11/15] mmc: sdhci-of-arasan: Add ability to export card
 clock
Date: Wed, 22 Jun 2016 15:35:06 +0300
Message-ID: <576A85FA.2000309@intel.com>
References: <1466445414-11974-1-git-send-email-dianders@chromium.org>
 <1466445414-11974-12-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1466445414-11974-12-git-send-email-dianders@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Douglas Anderson <dianders@chromium.org>, ulf.hansson@linaro.org, Heiko Stuebner <heiko@sntech.de>
Cc: kishon@ti.com, robh+dt@kernel.org, shawn.lin@rock-chips.com, xzy.xu@rock-chips.com, briannorris@chromium.org, linux-rockchip@lists.infradead.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, groeck@chromium.org, michal.simek@xilinx.com, soren.brinkmann@xilinx.com, geert@linux-m68k.org, wsa+renesas@sang-engineering.com, linus.walleij@linaro.org, horms+renesas@verge.net.au, andrei.pistirica@microchip.com, ludovic.desroches@atmel.com, stefan.wahren@i2se.com, yangbo.lu@freescale.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On 20/06/16 20:56, Douglas Anderson wrote:
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
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> Tested-by: Heiko Stuebner <heiko@sntech.de>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>
