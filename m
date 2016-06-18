From: Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH v2 06/11] Documentation: mmc: sdhci-of-arasan: Add ability to export card clock
Date: Sat, 18 Jun 2016 20:02:44 +0200
Message-ID: <5140493.iC6MOixRVW@phil>
References: <1465859076-4868-1-git-send-email-dianders@chromium.org> <1465859076-4868-7-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:60053 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751583AbcFRSDQ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 18 Jun 2016 14:03:16 -0400
In-Reply-To: <1465859076-4868-7-git-send-email-dianders@chromium.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Douglas Anderson <dianders@chromium.org>
Cc: ulf.hansson@linaro.org, kishon@ti.com, robh+dt@kernel.org, shawn.lin@rock-chips.com, xzy.xu@rock-chips.com, briannorris@chromium.org, adrian.hunter@intel.com, linux-rockchip@lists.infradead.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux-kernel@vger.kernel.org

Am Montag, 13. Juni 2016, 16:04:30 schrieb Douglas Anderson:
> Some SD/eMMC PHYs (like the PHY from Arasan that is designed to work
> with arasan,sdhci-5.1) need to know the card clock frequency in order to
> function properly.  Physically in a SoC this clock is exported from the
> SDHCI IP block to the PHY IP block and the PHY needs to know the speed.
> Let's export the SDHCI card clock using a standard device tree mechanism
> so that the PHY can get access to it and query the card clock frequency.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Acked-by: Rob Herring <robh@kernel.org>

Doug and me talked about how to solve this beforehand, so obviously I'm in 
favour of doing it like this :-)

Reviewed-by: Heiko Stuebner <heiko@sntech.de>
