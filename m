From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 06/11] Documentation: mmc: sdhci-of-arasan: Add ability
 to export card clock
Date: Fri, 10 Jun 2016 08:10:52 -0500
Message-ID: <20160610131052.GA9351@rob-hp-laptop>
References: <1465339484-969-1-git-send-email-dianders@chromium.org>
 <1465339484-969-7-git-send-email-dianders@chromium.org>
 <20160608201923.GA20683@rob-hp-laptop>
 <CAD=FV=WX_bu-dmALkSmPPrWeatfjJND3M59GJoVEr6bv0vLq9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAD=FV=WX_bu-dmALkSmPPrWeatfjJND3M59GJoVEr6bv0vLq9Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Kishon Vijay Abraham I <kishon@ti.com>, Heiko Stuebner <heiko@sntech.de>, Shawn Lin <shawn.lin@rock-chips.com>, Ziyuan Xu <xzy.xu@rock-chips.com>, Brian Norris <briannorris@chromium.org>, Adrian Hunter <adrian.hunter@intel.com>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Wed, Jun 08, 2016 at 01:52:20PM -0700, Doug Anderson wrote:
> Rob,
> 
> On Wed, Jun 8, 2016 at 1:19 PM, Rob Herring <robh@kernel.org> wrote:
> > On Tue, Jun 07, 2016 at 03:44:39PM -0700, Douglas Anderson wrote:
> >> Some SD/eMMC PHYs (like the PHY from Arasan that is designed to work
> >> with arasan,sdhci-5.1) need to know the card clock in order to function
> >> properly.  Let's expose this clock using a standard device tree
> >> mechanism so that the PHY can get access to and query the card clock.
> >
> > Need to know the clock freq or need the clock? The former doesn't need
> > to be in DT.
> 
> The PHY needs to know the card clock frequency.  This clock clock
> frequency is known nowhere else in the system except the SDHCI driver
> since the SDHCI component takes its input clock and applies some
> dividers to get the card clock.  In silicon, the SDHCI component and
> the PHY are separate and there is a physical clock signal going from
> the SDHCI component to the PHY component, so modeling this as a clock
> in in the device tree seems sane, doesn't it?

Yes, please just re-word it to make it clear there is a connection. With 
that,

Acked-by: Rob Herring <robh@kernel.org>
