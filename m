From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 00/11] omap_hsmmc: voltage switching and tuning
Date: Wed, 5 Aug 2015 03:43:56 -0700
Message-ID: <20150805104355.GE16878@atomide.com>
References: <1438242394-25599-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1438242394-25599-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: ulf.hansson@linaro.org, afenkart@gmail.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, nsekhar@ti.com, mugunthanvnm@ti.com
List-Id: linux-mmc@vger.kernel.org

* Kishon Vijay Abraham I <kishon@ti.com> [150730 00:49]:
> Patch series implements voltage switching and tuning for omap_hsmmc
> driver.
> 
> Did basic read/write test in J6, J6 Eco, Beagle-x15, AM437x EVM,
> Beaglebone black, OMAP5 uEVM and OMAP4 PANDA.

Your tests are missing omap3?

I suggest you add some omap3 tests in general as otherwise you are
only testing a subset of the driver features and completely missing
things like rutnime PM and save and restore for the deeper idle
states.

Regards,

Ton
