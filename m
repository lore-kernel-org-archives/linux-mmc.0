From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 12/16] mmc: host: omap_hsmmc: Add support to set IODELAY
 values
Date: Mon, 19 Jun 2017 07:33:39 -0700
Message-ID: <20170619143338.GN3730@atomide.com>
References: <20170616124544.15046-1-kishon@ti.com>
 <20170616124544.15046-13-kishon@ti.com>
 <20170619060256.GK3730@atomide.com>
 <810fba3e-a488-fa0d-5639-47f1c76ea2b6@ti.com>
 <20170619072523.GL3730@atomide.com>
 <3149f88d-c33f-0d3e-aabe-ac6f840bb41c@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:51506 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750733AbdFSOdn (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 19 Jun 2017 10:33:43 -0400
Content-Disposition: inline
In-Reply-To: <3149f88d-c33f-0d3e-aabe-ac6f840bb41c@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, nsekhar@ti.com, Russell King <linux@armlinux.org.uk>, Ravikumar Kattekola <rk@ti.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Kishon Vijay Abraham I <kishon@ti.com> [170619 00:55]:
> Hi Tony,
> 
> On Monday 19 June 2017 12:55 PM, Tony Lindgren wrote:
> > * Kishon Vijay Abraham I <kishon@ti.com> [170618 23:37]:
> >> Hi Tony,
> >>
> >> On Monday 19 June 2017 11:32 AM, Tony Lindgren wrote:
> >>> * Kishon Vijay Abraham I <kishon@ti.com> [170616 05:47]:
> >>>> The data manual of J6/J6 Eco recommends to set different IODELAY values
> >>>> depending on the mode in which the MMC/SD is enumerated in order to
> >>>> ensure IO timings are met.
> >>>>
> >>>> Add support to set the IODELAY values depending on the various MMC
> >>>> modes using the pinctrl APIs.
> >>>
> >>> This does not seem to apply against Linux next for me for
> >>> the binding. Fixing that, compile fails for me with:
> >>>
> >>> drivers/mmc/host/omap_hsmmc.c:2384:13: error:
> >>> 'struct omap_hsmmc_platform_data' has no member named 'version'
> >>
> >> This series has a dependency with
> >> https://www.spinics.net/lists/arm-kernel/msg586215.html series
> >>
> >> *version* member is added in patch with $subject
> >> "ARM: OMAP2+: Add pdata-quirks for MMC/SD on DRA74x EVM"
> > 
> > Ah sorry I keep forgetting that. Looks like the only thing
> > pending with that series is that you were going to send
> > an update for omap3-overo-base.
> 
> I've sent that as a separate patch [1]. But I can resend the entire series if
> that's what you'd prefer.

Oh sorry I had already untagged that thread, I probably did
not notice your updated patch. It's best to resend that series
right after -rc1 so we get it to Linux next for few weeks
of testing. Right now there's a dependency to the related
MMC patches, and patch 8/8 conflicts with the unused regulator
removal patch.

Regards,

Tony

> [1] -> http://www.spinics.net/lists/devicetree/msg180747.html
