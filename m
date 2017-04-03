From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v7 06/13] dt: bindings: Add bindings for Marvell Xenon SD
 Host Controller
Date: Mon, 3 Apr 2017 11:19:26 -0500
Message-ID: <20170403161926.wfj7foddu33gxuae@rob-hp-laptop>
References: <cover.51071caa64e5df81264a91b9a81ed1e94f47d2c4.1490886907.git-series.gregory.clement@free-electrons.com>
 <ecacddaa5d38b678e1c8c95b56f65f4a39527ead.1490886907.git-series.gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <ecacddaa5d38b678e1c8c95b56f65f4a39527ead.1490886907.git-series.gregory.clement@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Mike Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Ziji Hu <huziji@marvell.com>, Jimmy Xu <zmxu@marvell.com>, Jisheng Zhang <jszhang@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Ryan Gao <ygao@marvell.com>, Doug Jones <dougj@marvell.com>, Victor Gu <xigu@marvell.com>, "Wei(SOCP) Liu" <liuw@marvell.com>, Wilson Ding <dingwei@marvell.c>
List-Id: linux-mmc@vger.kernel.org

On Thu, Mar 30, 2017 at 05:22:58PM +0200, Gregory CLEMENT wrote:
> From: Hu Ziji <huziji@marvell.com>
> 
> Marvell Xenon SDHC can support eMMC/SD/SDIO.
> Add Xenon-specific properties.
> Also add properties for Xenon PHY setting.
> 
> Signed-off-by: Hu Ziji <huziji@marvell.com>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.txt | 170 +++++++-
>  1 file changed, 170 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.txt

I acked v6 and it seems like a minor change, though I had to search for 
both because there is no revision history nor explanation why you didn't 
add my ack.

Acked-by: Rob Herring <robh@kernel.org> 
