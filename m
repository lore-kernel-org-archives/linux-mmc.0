From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH v3 11/12] arm64: dts: marvell: add sdhci support for
 Armada 7K/8K
Date: Fri, 9 Dec 2016 20:07:29 +0000
Message-ID: <20161209200729.GO14217@n2100.armlinux.org.uk>
References: <cover.e0137cef24a16a2c7d795548de554993595d4a98.1481279228.git-series.gregory.clement@free-electrons.com>
 <923c97f32a828b579756bf86946689ed54a0a174.1481279228.git-series.gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pandora.armlinux.org.uk ([78.32.30.218]:35972 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751674AbcLIUHp (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 9 Dec 2016 15:07:45 -0500
Content-Disposition: inline
In-Reply-To: <923c97f32a828b579756bf86946689ed54a0a174.1481279228.git-series.gregory.clement@free-electrons.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Andrew Lunn <andrew@lunn.ch>, Yehuda Yitschak <yehuday@marvell.com>, Marcin Wojtas <mw@semihalf.com>, Jason Cooper <jason@lakedaemon.net>, Hanna Hawa <hannah@marvell.com>, Kostya Porotchkin <kostap@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Ziji Hu <huziji@marvell.com>, Jimmy Xu <zmxu@marvell.com>, Doug Jones <dougj@marvell.com>, Ryan Gao <ygao@marvell.com>, Jisheng Zhang <jszhang@marvell.com>, Victor Gu <xigu@marvell.com>, "Wei(SOCP) Liu" <liuw@marvell.com>, Wilson Ding <dingwei@marvell.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gm>

On Fri, Dec 09, 2016 at 11:30:07AM +0100, Gregory CLEMENT wrote:
> Also enable it on the Armada 7040 DB board
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Hi,

Can this also be added to the cp110 on the 7k/8k SoCs as well, or does
it rely on other unmerged support?

Thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
