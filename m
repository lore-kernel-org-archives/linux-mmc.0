From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH v2 05/11] arm64: dts: rockchip: Add soc-ctl-syscon to sdhci for rk3399
Date: Sat, 18 Jun 2016 14:49:24 +0200
Message-ID: <8241867.c5NxmDgk2P@diego>
References: <1465859076-4868-1-git-send-email-dianders@chromium.org> <1465859076-4868-6-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:59112 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751015AbcFRMts (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 18 Jun 2016 08:49:48 -0400
In-Reply-To: <1465859076-4868-6-git-send-email-dianders@chromium.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Douglas Anderson <dianders@chromium.org>
Cc: ulf.hansson@linaro.org, kishon@ti.com, robh+dt@kernel.org, shawn.lin@rock-chips.com, xzy.xu@rock-chips.com, briannorris@chromium.org, adrian.hunter@intel.com, linux-rockchip@lists.infradead.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, catalin.marinas@arm.com, will.deacon@arm.com, zhengxing@rock-chips.com, jay.xu@rock-chips.com, wxt@rock-chips.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Am Montag, 13. Juni 2016, 16:04:29 schrieb Douglas Anderson:
> On rk3399 we'd like to be able to properly set corecfg registers in the
> Arasan SDHCI component.  Specify the syscon to enable that.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

as the whole devicetree-part of the emmc addition is in my queue for 4.8, I'll 
pick this patch after everything else has gone into some tree.


Heiko
