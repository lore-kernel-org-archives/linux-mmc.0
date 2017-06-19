From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 12/16] mmc: host: omap_hsmmc: Add support to set IODELAY
 values
Date: Sun, 18 Jun 2017 23:02:57 -0700
Message-ID: <20170619060256.GK3730@atomide.com>
References: <20170616124544.15046-1-kishon@ti.com>
 <20170616124544.15046-13-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:49656 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751053AbdFSGDB (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 19 Jun 2017 02:03:01 -0400
Content-Disposition: inline
In-Reply-To: <20170616124544.15046-13-kishon@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, nsekhar@ti.com, Russell King <linux@armlinux.org.uk>, Ravikumar Kattekola <rk@ti.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Kishon Vijay Abraham I <kishon@ti.com> [170616 05:47]:
> The data manual of J6/J6 Eco recommends to set different IODELAY values
> depending on the mode in which the MMC/SD is enumerated in order to
> ensure IO timings are met.
> 
> Add support to set the IODELAY values depending on the various MMC
> modes using the pinctrl APIs.

This does not seem to apply against Linux next for me for
the binding. Fixing that, compile fails for me with:

drivers/mmc/host/omap_hsmmc.c:2384:13: error:
'struct omap_hsmmc_platform_data' has no member named 'version'

So will wait for updates before giving this a try.

Regards,

Tony
