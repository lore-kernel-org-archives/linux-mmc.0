From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH 0/6] mmc: Handle platform_get_irq's error checking and
 return
Date: Sat, 18 Nov 2017 08:19:47 +0000
Message-ID: <20171118081947.GX31757@n2100.armlinux.org.uk>
References: <1510950502-22565-1-git-send-email-arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pandora.armlinux.org.uk ([78.32.30.218]:49202 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1946081AbdKRIUX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 18 Nov 2017 03:20:23 -0500
Content-Disposition: inline
In-Reply-To: <1510950502-22565-1-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: ulf.hansson@linaro.org, carlo@caione.org, khilman@baylibre.com, ben-linux@fluff.org, adrian.hunter@intel.com, vireshk@kernel.org, maxime.ripard@free-electrons.com, wens@csie.org, linux-amlogic@lists.infradead.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Sat, Nov 18, 2017 at 01:58:16AM +0530, Arvind Yadav wrote:
> The platform_get_irq() function returns negative if an error occurs.
> zero or positive number on success. platform_get_irq() error checking
> for zero is not correct and and we must check its return value.

IRQ 0 is not a valid interrupt.  The correct test here is <= 0.
Please rework your patches for this.

Thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
