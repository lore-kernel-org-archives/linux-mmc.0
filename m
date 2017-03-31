From: Hu Ziji <huziji-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v7 00/13] mmc: Add support to Marvell Xenon SD Host
 Controller
Date: Fri, 31 Mar 2017 10:09:58 +0800
Message-ID: <8ebf11c8-f8e0-e4bb-ed70-f8c2e68aa787@marvell.com>
References: <cover.51071caa64e5df81264a91b9a81ed1e94f47d2c4.1490886907.git-series.gregory.clement@free-electrons.com>
 <20170330185639.GI7909@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170330185639.GI7909-l+eeeJia6m9URfEZ8mYm6t73F7V6hmMc@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King - ARM Linux <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jimmy Xu <zmxu-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Mike Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Victor Gu <xigu-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Doug Jones <dougj-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jisheng Zhang <jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Yehuda Yitschak <yehuday-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Marcin Wojtas <mw-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>, Kostya Porotchkin <kostap-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Hanna Hawa <hannah-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ryan Gao <ygao-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, "Wei(SOCP) Liu" <liuw-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWNGWvitb5QawA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Hi Russell,

On 2017/3/31 2:56, Russell King - ARM Linux wrote:
> ----------------------------------------------------------------------
> On Thu, Mar 30, 2017 at 05:22:52PM +0200, Gregory CLEMENT wrote:
>> - Remove parse of child node mmc-card. Wait for a better solution.
> 
> So for mcbin, I have:
> 
> &ap_sdhci0 {
>         bus-width = <8>;
>         marvell,xenon-emmc;
>         marvell,xenon-phy-type = "emmc 5.1 phy";
>         /*
>          * Not stable in HS modes - phy needs "more calibration", so add
>          * the "slow-mode" and disable SDR104, SDR50 and DDR50 modes.
>          */
>         marvell,xenon-phy-slow-mode;
>         no-1-8-v;
>         non-removable;
>         status = "okay";
>         vqmmc-supply = <&v_vddo_h>;
> 
>         #address-cells = <1>;
>         #size-cells = <0>;
>         mmccard: mmccard@0 {
>                 compatible = "mmc-card";
>                 reg = <0>;
>         };
> };
> 
> Does this mean the "mmccard" bit is no longer required - or is it required
> for the eMMC to be detected but is no longer supported by the driver?
> 

	Based on the implementation in this release, "mmccard" is no longer required.

	More details:
	eMMC Vqmmc in Xenon is fixed without a regulator. Thus 1.8V Signaling Enable bit
	in SDHC doesn't work.
	As a result, Xenon driver has to skip sdhci_start_signal_voltage_switch() to avoid
	checking 1.8V signaling enable bit when setting signaling voltage.

	Previously, we use "mmccard" to inform Xenon driver that it is an eMMC card
	and therefore sdhci_start_signal_voltage_switch() is skipped.

	Currently, Xenon driver directly checks if Vqmmc regulator is provided.
	Skip sdhci_start_signal_voltage_switch() if Vqmmc is fixed.
	In my own opinion, it is more direct and clear, than checking eMMC card type. 

	Thank you.

Best regards,
Hu Ziji

> Thanks.
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
