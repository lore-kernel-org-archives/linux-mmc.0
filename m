From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v2 4/4] arm/dts: OMAP3: Add mmc controller nodes and board data
Date: Thu, 08 Mar 2012 22:46:08 -0700
Message-ID: <20120309054608.647473E0901@localhost>
References: <1329998490-27555-1-git-send-email-rnayak@ti.com> <1329998490-27555-5-git-send-email-rnayak@ti.com> <20120223185718.GZ18185@atomide.com> <4F470B71.1020308@ti.com> <20120224184859.GN18185@atomide.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:58256 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750876Ab2CIFqM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 9 Mar 2012 00:46:12 -0500
Received: by iagz16 with SMTP id z16so1763714iag.19
        for <linux-mmc@vger.kernel.org>; Thu, 08 Mar 2012 21:46:11 -0800 (PST)
In-Reply-To: <20120224184859.GN18185@atomide.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, linaro-dev@lists.linaro.org, balajitk@ti.com, devicetree-discuss@lists.ozlabs.org, linux-mmc@vger.kernel.org, cjb@laptop.org, linux-arm-kernel@lists.infradead.org

On Fri, 24 Feb 2012 10:49:00 -0800, Tony Lindgren <tony@atomide.com> wrote:
> * Rajendra Nayak <rnayak@ti.com> [120223 19:29]:
> > On Friday 24 February 2012 12:27 AM, Tony Lindgren wrote:
> > >>--- a/arch/arm/boot/dts/omap3.dtsi
> > >>+++ b/arch/arm/boot/dts/omap3.dtsi
> > >>@@ -113,5 +113,31 @@
> > >>  			#size-cells =<0>;
> > >>  			ti,hwmods = "i2c3";
> > >>  		};
> > >>+
> > >>+		mmc1: mmc@1 {
> > >>+			compatible = "ti,omap2-hsmmc";
> > >>+			ti,hwmods = "mmc1";
> > >>+			ti,dual-volt;
> > >>+		};
> > >>+
> > >>+		mmc2: mmc@2 {
> > >>+			compatible = "ti,omap2-hsmmc";
> > >>+			ti,hwmods = "mmc2";
> > >>+		};
> > >>+
> > >>+		mmc3: mmc@3 {
> > >>+			compatible = "ti,omap2-hsmmc";
> > >>+			ti,hwmods = "mmc3";
> > >>+		};
> > >>+
> > >>+		mmc4: mmc@4 {
> > >>+			compatible = "ti,omap2-hsmmc";
> > >>+			ti,hwmods = "mmc4";
> > >>+		};
> > >>+
> > >>+		mmc5: mmc@5 {
> > >>+			compatible = "ti,omap2-hsmmc";
> > >>+			ti,hwmods = "mmc5";
> > >>+		};
> > >>  	};
> > >>  };
> > >
> > >These all should all be "ti,omap3-hsmmc" I guess?
> > 
> > Well, I defined the binding such that both omap2 and omap3
> > can use the same compatible "ti,omap2-hsmmc" since there is
> > no difference in the way they are defined or handled. If thats
> > confusing, I can have separate compatibles.
> > Btw, I guess we do the same with a few other re-used IPs as well,
> > I just checked and mcpsi does the same.
> 
> Yeah let's use separate compatibles to avoid confusion.
> For omap2 we also have the ti,omap2-mmc in addition to
> ti,omap2-hsmmc..

Yes, absolutely use separate compatible values.  It is always important
to be specific as to the silicon implementing the IP.  The omap3 instance
can also carry the omap2 string in its compatible list:

	compatible = "ti,omap3-hsmmc", "ti,omap2-hsmmc";

g.
