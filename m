From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] ARM: dts: am571x-idk: Fix GPIO polarity for MMC1
 card detect
Date: Wed, 9 Aug 2017 15:08:01 -0700
Message-ID: <20170809220800.GJ3934@atomide.com>
References: <20170808052057.24433-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170808052057.24433-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Russell King <linux@armlinux.org.uk>, Ulf Hansson <ulf.hansson@linaro.org>, nsekhar@ti.com, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

* Kishon Vijay Abraham I <kishon@ti.com> [170807 22:22]:
> The GPIO polarity for MMC1 card detect is set to '0' which means
> active-high. However the polarity should be active-low. Fix it
> here.

Can these wait for v4.14 merge window or do these fix known
issues?

Regards,

Tony
