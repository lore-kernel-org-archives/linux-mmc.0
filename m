From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH v2 4/4] arm/dts: OMAP3: Add mmc controller nodes and board
 data
Date: Fri, 09 Mar 2012 15:06:56 +0530
Message-ID: <4F59CF38.6090706@ti.com>
References: <1329998490-27555-1-git-send-email-rnayak@ti.com> <1329998490-27555-5-git-send-email-rnayak@ti.com> <20120223185718.GZ18185@atomide.com> <4F470B71.1020308@ti.com> <20120224184859.GN18185@atomide.com> <20120309054608.647473E0901@localhost> <alpine.DEB.2.00.1203082348200.26656@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.00.1203082348200.26656@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>, Grant Likely <grant.likely@secretlab.ca>, linux-omap@vger.kernel.org, linaro-dev@lists.linaro.org, balajitk@ti.com, devicetree-discuss@lists.ozlabs.org, linux-mmc@vger.kernel.org, cjb@laptop.org, linux-arm-kernel@lists.infradead.org, "Cousson, Benoit" <b-cousson@ti.com>
List-Id: linux-mmc@vger.kernel.org

Hi Paul,

On Friday 09 March 2012 12:21 PM, Paul Walmsley wrote:
> On Thu, 8 Mar 2012, Grant Likely wrote:
>
>> Yes, absolutely use separate compatible values.  It is always important
>> to be specific as to the silicon implementing the IP.
>
> In that case, it is probably best to use the full chip name in the
> compatible string, e.g., omap2420 or omap2430 rather than just "omap2".

Since omap2420 and omap2430 have different MMC controllers (and these
bindings only cover the hsmmc controller used in 2430 and beyond, I
haven't done the bindings for the legacy one yet), the idea was
to differentiate between omap2420 and omap2430 by using
compatible of "ti,omap2-hsmmc" for the High-Speed controller used in
OMAP2 (2430) and "ti,omap2-mmc" for the legacy one used in OMAP2 (2420).
Does that sound good to you?

> Particularly in the case of "OMAP3," which is a largely meaningless group
> these days with AM33xx, OMAP34xx, OMAP36xx, and AM3517, many of which are
> quite different from each other...

But these bindings are specific and limited to HSMMC module which is
not quite different in the different SoC variants. There is a single
driver to handle hsmmc module on all the SoCs which does not need to
differentiate which SoC it is on.

regards,
Rajendra

>
>
> - Paul

