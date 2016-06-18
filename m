From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH v2 11/11] arm64: dts: rockchip: Provide emmcclk to PHY for rk3399
Date: Sat, 18 Jun 2016 14:07:50 +0200
Message-ID: <4254489.Jmszz7Rk1t@diego>
References: <1465859076-4868-1-git-send-email-dianders@chromium.org> <1465859076-4868-12-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1465859076-4868-12-git-send-email-dianders@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Douglas Anderson <dianders@chromium.org>
Cc: ulf.hansson@linaro.org, kishon@ti.com, robh+dt@kernel.org, shawn.lin@rock-chips.com, xzy.xu@rock-chips.com, briannorris@chromium.org, adrian.hunter@intel.com, linux-rockchip@lists.infradead.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, catalin.marinas@arm.com, will.deacon@arm.com, jay.xu@rock-chips.com, zhengxing@rock-chips.com, wxt@rock-chips.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Am Montag, 13. Juni 2016, 16:04:35 schrieb Douglas Anderson:
> Previous changes in this series allowed exposing the card clock from the
> rk3399 SDHCI device and allowed consuming the card clock in the rk3399
> eMMC PHY.  Hook things up in the main rk3399 dtsi file.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

as the whole devicetree-part of the emmc addition is in my queue for 4.8, I'll 
pick this patch after everything else has gone into some tree.


Heiko
