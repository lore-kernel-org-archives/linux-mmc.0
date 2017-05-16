From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH] mmc: sdhci-xenon: kill xenon_clean_phy()
Date: Tue, 16 May 2017 13:48:25 +0100
Message-ID: <20170516124825.GF22219@n2100.armlinux.org.uk>
References: <20170516061720.1755-1-jszhang@marvell.com>
 <20170516122211.GA27959@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pandora.armlinux.org.uk ([78.32.30.218]:46988 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751943AbdEPMsn (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 16 May 2017 08:48:43 -0400
Content-Disposition: inline
In-Reply-To: <20170516122211.GA27959@lunn.ch>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jisheng Zhang <jszhang@marvell.com>, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, adrian.hunter@intel.com, linux-kernel@vger.kernel.org, huziji@marvell.com, linux-arm-kernel@lists.infradead.org

On Tue, May 16, 2017 at 02:22:11PM +0200, Andrew Lunn wrote:
> If the memory has been allocated using the devm_ API, calling kfree
> here is wrong, and can lead to a double free.
> 
> So this patch should probably have a fixes: tag. Should it also goto
> stable?

No, sdhci-xenon has only hit mainline during the recent merge window,
so it's not in any kernel other than 4.12-rc1.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
