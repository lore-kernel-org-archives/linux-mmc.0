From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] ARM: dts: am571x-idk: Fix GPIO polarity for MMC1
 card detect
Date: Thu, 10 Aug 2017 08:13:29 -0700
Message-ID: <20170810151329.GC8569@atomide.com>
References: <20170808052057.24433-1-kishon@ti.com>
 <20170809220800.GJ3934@atomide.com>
 <f75b361c-a8a8-f6c0-dd8a-cca5522e5181@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <f75b361c-a8a8-f6c0-dd8a-cca5522e5181@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Russell King <linux@armlinux.org.uk>, Ulf Hansson <ulf.hansson@linaro.org>, nsekhar@ti.com, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

* Kishon Vijay Abraham I <kishon@ti.com> [170810 00:46]:
> Tony,
> 
> On Thursday 10 August 2017 03:38 AM, Tony Lindgren wrote:
> > * Kishon Vijay Abraham I <kishon@ti.com> [170807 22:22]:
> >> The GPIO polarity for MMC1 card detect is set to '0' which means
> >> active-high. However the polarity should be active-low. Fix it
> >> here.
> > 
> > Can these wait for v4.14 merge window or do these fix known
> > issues?
> 
> These can go in the next merge window. I didn't observe any issue without this
> in omap_hsmmc driver.

OK applying both into omap-for-v4.14/dt thanks.

Tony
