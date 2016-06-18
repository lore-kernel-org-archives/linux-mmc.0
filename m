From: Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH v2 04/11] mmc: sdhci-of-arasan: Properly set corecfg_baseclkfreq on rk3399
Date: Sat, 18 Jun 2016 19:59:47 +0200
Message-ID: <2413456.oe4vm1F1Mq@phil>
References: <1465859076-4868-1-git-send-email-dianders@chromium.org> <1465859076-4868-5-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:60000 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751480AbcFRSA0 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 18 Jun 2016 14:00:26 -0400
In-Reply-To: <1465859076-4868-5-git-send-email-dianders@chromium.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Douglas Anderson <dianders@chromium.org>
Cc: ulf.hansson@linaro.org, kishon@ti.com, robh+dt@kernel.org, shawn.lin@rock-chips.com, xzy.xu@rock-chips.com, briannorris@chromium.org, adrian.hunter@intel.com, linux-rockchip@lists.infradead.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, michal.simek@xilinx.com, soren.brinkmann@xilinx.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Am Montag, 13. Juni 2016, 16:04:28 schrieb Douglas Anderson:
> In the the earlier change in this series ("Documentation: mmc:
> sdhci-of-arasan: Add soc-ctl-syscon for corecfg regs") we can see the
> mechansim for specifying a syscon to properly set corecfg registers in
> sdhci-of-arasan.  Now let's use this mechanism to properly set
> corecfg_baseclkfreq on rk3399.
> 
> From [1] the corecfg_baseclkfreq is supposed to be set to:
>   Base Clock Frequency for SD Clock.
>   This is the frequency of the xin_clk.
> 
> This is a relatively easy thing to do.  Note that we assume that xin_clk
> is not dynamic and we can check the clock at probe time.  If any real
> devices have a dynamic xin_clk future patches could register for
> notifiers for the clock.
> 
> At the moment, setting corecfg_baseclkfreq is only supported for rk3399
> since we need a specific map for each implementation.  The code is
> written in a generic way that should make this easy to extend to other
> SoCs.  Note that a specific compatible string for rk3399 is already in
> use and so we add that to the table to match rk3399.
> 
> [1]:
> https://arasan.com/wp-content/media/eMMC-5-1-Total-Solution_Rev-1-3.pdf
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

this looks nice and versatile for other socs hopefully using that in the 
future.

Reviewed-by: Heiko Stuebner <heiko@sntech.de>
