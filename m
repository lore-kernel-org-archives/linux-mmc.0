From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 08/11] Documentation: phy: Let the rockchip eMMC PHY
 get an exported card clock
Date: Thu, 16 Jun 2016 13:42:30 -0500
Message-ID: <20160616184230.GA18869@rob-hp-laptop>
References: <1465859076-4868-1-git-send-email-dianders@chromium.org>
 <1465859076-4868-9-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1465859076-4868-9-git-send-email-dianders@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Douglas Anderson <dianders@chromium.org>
Cc: ulf.hansson@linaro.org, kishon@ti.com, Heiko Stuebner <heiko@sntech.de>, shawn.lin@rock-chips.com, xzy.xu@rock-chips.com, briannorris@chromium.org, adrian.hunter@intel.com, linux-rockchip@lists.infradead.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Mon, Jun 13, 2016 at 04:04:32PM -0700, Douglas Anderson wrote:
> As of an earlier change in this series ("Documentation: mmc:
> sdhci-of-arasan: Add ability to export card clock") the SDHCI driver
> used on Rockchip SoCs can now expose its clock.  Let's now specify that
> the PHY can use it.
> 
> Letting the PHY get access to this clock means it can adjust
> phyctrl_frqsel field appropriately.  Although the Rockchip PHY appears
> slightly different than the reference Arasan one, you can see that the
> Arasan datasheet [1] had it defined as:
>   Select the frequency range of DLL operation:
>   3b'000 => 200MHz to 170 MHz
>   3b'001 => 170MHz to 140 MHz
>   3b'010 => 140MHz to 110 MHz
>   3b'011 => 110MHz to 80MHz
>   3b'100 => 80MHz to 50 MHz
>   3b'101 => 275Mhz to 250MHz
>   3b'110 => 250MHz to 225MHz
>   3b'111 => 225MHz to 200MHz
> 
> On the Rockchip version of the PHY we have less granularity but the idea
> is the same.
> 
> [1]: https://arasan.com/wp-content/media/eMMC-5-1-Total-Solution_Rev-1-3.pdf
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> Changes in v2:
> - List out clocks and clock names (Rob)
> 
>  Documentation/devicetree/bindings/phy/rockchip-emmc-phy.txt | 9 +++++++++
>  1 file changed, 9 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
