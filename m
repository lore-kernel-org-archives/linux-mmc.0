From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH v4 11/12] arm64: dts: marvell: add sdhci support for
 Armada 7K/8K
Date: Thu, 22 Dec 2016 10:45:02 +0000
Message-ID: <20161222104502.GV14217@n2100.armlinux.org.uk>
References: <cover.67d726f70f6bd48d38a2023513f2711080bc66c8.1481651244.git-series.gregory.clement@free-electrons.com>
 <2564fe18eb9cc8a0a1a3311cdf7e7141f35211bd.1481651244.git-series.gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <2564fe18eb9cc8a0a1a3311cdf7e7141f35211bd.1481651244.git-series.gregory.clement@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Andrew Lunn <andrew@lunn.ch>, Ulf Hansson <ulf.hansson@linaro.org>, "Wei(SOCP) Liu" <liuw@marvell.com>, Jason Cooper <jason@lakedaemon.net>, Hanna Hawa <hannah@marvell.com>, linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Nadav Haklai <nadavh@marvell.com>, Ziji Hu <huziji@marvell.com>, Jimmy Xu <zmxu@marvell.com>, Victor Gu <xigu@marvell.com>, Ryan Gao <ygao@marvell.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Doug Jones <dougj@marvell.com>, Jisheng Zhang <jszhang@marvell.com>, Kostya Porotchkin <kostap@marvell.com>, Marcin Wojtas <mw@semihalf.com>, Wilson Ding <dingwei@marvell.com>, linux-arm-kernel@lists.infradead.org, Yehuda Yitschak <yehuday@marvell.com>
List-Id: linux-mmc@vger.kernel.org

On Tue, Dec 13, 2016 at 06:48:40PM +0100, Gregory CLEMENT wrote:
> diff --git a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
> index 7b6136182ad0..181e8c5de3bf 100644
> --- a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
> @@ -229,6 +229,15 @@
>  
>  			};
>  
> +			ap_sdhci0: sdhci@6e0000 {
> +				compatible = "marvell,armada-7000-sdhci";
> +				reg = <0x6e0000 0x300>;
> +				interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
> +				clock-names = "core";
> +				clocks = <&cpm_syscon0 1 4>;

This seems to be the wrong clock - how can the AP SDHCI core be connected
to the CPM syscon (which is on a different die.)

I think you first need a patch to add this clock to the AP syscon...

Thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
