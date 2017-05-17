From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH] mmc: sdhci-xenon: kill xenon_clean_phy()
Date: Wed, 17 May 2017 13:56:02 +0200
Message-ID: <20170517115602.GD19968@lunn.ch>
References: <20170516061720.1755-1-jszhang@marvell.com>
 <20170516122211.GA27959@lunn.ch>
 <20170517171726.2ede556d@xhacker>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([178.209.37.122]:33304 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752159AbdEQL4O (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 17 May 2017 07:56:14 -0400
Content-Disposition: inline
In-Reply-To: <20170517171726.2ede556d@xhacker>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jisheng Zhang <jszhang@marvell.com>
Cc: adrian.hunter@intel.com, huziji@marvell.com, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

> As pointed out by RMK, the sdhci-xenon driver is merged in current 4.12-rc1,
> so we just need to apply this fix in later rcN.

Yep. It helps the maintainer if you point this out in the patch, after
the ---.

    Andrew
