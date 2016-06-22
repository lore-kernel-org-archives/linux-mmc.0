From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH v3 09/15] arm64: dts: rockchip: Add soc-ctl-syscon to sdhci for rk3399
Date: Wed, 22 Jun 2016 18:30:54 +0200
Message-ID: <8631197.YoqKIsMN0l@diego>
References: <1466445414-11974-1-git-send-email-dianders@chromium.org> <1466445414-11974-10-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:55772 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752078AbcFVQbc (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 22 Jun 2016 12:31:32 -0400
In-Reply-To: <1466445414-11974-10-git-send-email-dianders@chromium.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Douglas Anderson <dianders@chromium.org>
Cc: ulf.hansson@linaro.org, kishon@ti.com, robh+dt@kernel.org, shawn.lin@rock-chips.com, xzy.xu@rock-chips.com, briannorris@chromium.org, adrian.hunter@intel.com, linux-rockchip@lists.infradead.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, groeck@chromium.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, catalin.marinas@arm.com, will.deacon@arm.com, wxt@rock-chips.com, zhengxing@rock-chips.com, jay.xu@rock-chips.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Am Montag, 20. Juni 2016, 10:56:48 schrieb Douglas Anderson:
> On rk3399 we'd like to be able to properly set corecfg registers in the
> Arasan SDHCI component.  Specify the syscon to enable that.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Tested-by: Heiko Stuebner <heiko@sntech.de>

applied to my dts64-branch for 4.8

Thanks
Heiko
