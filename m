From: Koen Kooi <koen-QLwJDigV5abLmq1fohREcCpxlwaOVQ5f@public.gmane.org>
Subject: Re: [PATCH 3/3] ARM: OMAP2+: BBB DT: mark eMMC as non removable
Date: Fri, 13 Sep 2013 12:11:18 +0200
Message-ID: <ECFF9D09-1CA1-45E5-9965-A7F4BCC127BC@dominion.thruhere.net>
References: <cover.1379066249.git.nsekhar@ti.com> <f77adcf96d225b43e38058ddadcab76a9df6914a.1379066249.git.nsekhar@ti.com>
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <f77adcf96d225b43e38058ddadcab76a9df6914a.1379066249.git.nsekhar-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Cc: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Device Tree Mailing List <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux MMC Mailing List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org


Op 13 sep. 2013, om 12:09 heeft Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org> het volgende geschreven:

> Mark the eMMC module on BeagleBone black as non removable.
> 
> Signed-off-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>

Acked-by: Koen Kooi <koen-QLwJDigV5abLmq1fohREcCpxlwaOVQ5f@public.gmane.org>

> ---
> arch/arm/boot/dts/am335x-boneblack.dts |    1 +
> 1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/am335x-boneblack.dts b/arch/arm/boot/dts/am335x-boneblack.dts
> index f4703cf..58515dc 100644
> --- a/arch/arm/boot/dts/am335x-boneblack.dts
> +++ b/arch/arm/boot/dts/am335x-boneblack.dts
> @@ -25,6 +25,7 @@
> 	pinctrl-names = "default";
> 	pinctrl-0 = <&emmc_pins>;
> 	bus-width = <8>;
> +	non-removable;
> 	status = "okay";
> 	ti,vcc-aux-disable-is-sleep;
> };
> -- 
> 1.7.10.1
> 

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
