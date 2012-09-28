From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH V2 1/2] mmc: sdhci-spear: add device tree bindings
Date: Fri, 28 Sep 2012 06:58:15 -0400
Message-ID: <871uhmv2go.fsf@octavius.laptop.org>
References: <cb66033bd923920daefc57570381f978d6e37168.1348828070.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:38549 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757489Ab2I1K6W (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 28 Sep 2012 06:58:22 -0400
In-Reply-To: <cb66033bd923920daefc57570381f978d6e37168.1348828070.git.viresh.kumar@linaro.org>
	(Viresh Kumar's message of "Fri, 28 Sep 2012 15:58:22 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: spear-devel@list.st.com, linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, sr@denx.de

Hi,

On Fri, Sep 28 2012, Viresh Kumar wrote:
> This adds simple DT bindings for SDHCI SPEAr controller. It uses cd-gpios from
> common mmc bindings.
>
> This also fixes spear300-evb.dts with correct name for card detect binding.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> V1->V2:
> - Use cd-gpios instead of int-gpio as binding for card detect gpio.
> - Fix spear300-evb.dts binding name for cd-gpios
> - Removed power-gpio from DT bindings and code, must be handled via regulators
>
>  .../devicetree/bindings/mmc/sdhci-spear.txt        | 18 +++++++
>  arch/arm/boot/dts/spear300-evb.dts                 |  3 +-
>  arch/arm/boot/dts/spear320-evb.dts                 |  2 -
>  drivers/mmc/host/sdhci-spear.c                     | 57 +++++++++++++++++++++-
>  4 files changed, 74 insertions(+), 6 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-spear.txt

Thanks, pushed to mmc-next for 3.7.

It might be possible to remove sdhci-spear.c in the future -- all it's
doing at the moment is the card_power_gpio handling (which should be a
regulator) and cd-gpio handling (which can be done by core/slot-gpio.c).
So perhaps sdhci-pltfm can handle SPEAr hosts directly, once we move the
platdata users away from card_power_gpio.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
