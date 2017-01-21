From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v5 01/12] clk: apn806: Add eMMC clock to system
 controller driver
Date: Fri, 20 Jan 2017 16:16:48 -0800
Message-ID: <20170121001648.GJ20800@codeaurora.org>
References: <cover.8527229dae6c124f24c5e637430c2cdc86f80392.1484154449.git-series.gregory.clement@free-electrons.com>
 <e84d52dfbd9f7d2a14a5ec9d53918119fdc90404.1484154449.git-series.gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <e84d52dfbd9f7d2a14a5ec9d53918119fdc90404.1484154449.git-series.gregory.clement@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Jimmy Xu <zmxu@marvell.com>, Andrew Lunn <andrew@lunn.ch>, Ulf Hansson <ulf.hansson@linaro.org>, Mike Turquette <mturquette@baylibre.com>, linux-kernel@vger.kernel.org, Nadav Haklai <nadavh@marvell.com>, Ziji Hu <huziji@marvell.com>, Victor Gu <xigu@marvell.com>, Doug Jones <dougj@marvell.com>, linux-clk@vger.kernel.org, Jisheng Zhang <jszhang@marvell.com>, Yehuda Yitschak <yehuday@marvell.com>, Marcin Wojtas <mw@semihalf.com>, Kostya Porotchkin <kostap@marvell.com>, Hanna Hawa <hannah@marvell.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, devicetree@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Russell King <rmk+kernel@armlinux.org.uk>, Rob Herring <robh+dt@kernel.org>, Ryan Gao <ygao@marvell.com>, "Wei(SOCP) Liu" <liuw@marvell.com>, linux-arm-kernel@lists.infradead.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-mmc@vger.ke
List-Id: linux-mmc@vger.kernel.org

On 01/11, Gregory CLEMENT wrote:
> From: Konstantin Porotchkin <kostap@marvell.com>
> 
> Add fixed clock of 400MHz to system controller driver.  This clock is
> used as SD/eMMC clock source.
> 
> Signed-off-by: Konstantin Porotchkin <kostap@marvell.com>
> Reviewed-by: Omri Itach <omrii@marvell.com>
> Reviewed-by: Hanna Hawa <hannah@marvell.com>
> [fixed up conflicts, added error handling --rmk]
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---

Acked-by: Stephen Boyd <sboyd@codeaurora.org>

> diff --git a/drivers/clk/mvebu/ap806-system-controller.c b/drivers/clk/mvebu/ap806-system-controller.c
> index 8181b919f062..0a785076b0c6 100644
> --- a/drivers/clk/mvebu/ap806-system-controller.c
> +++ b/drivers/clk/mvebu/ap806-system-controller.c
> @@ -117,6 +117,17 @@ static int ap806_syscon_clk_probe(struct platform_device *pdev)
>  		goto fail3;
>  	}
>  
> +	/* eMMC Clock is fixed clock divided by 3 */
> +	of_property_read_string_index(np, "clock-output-names",
> +				      4, &name);

This could check for failure and not register the clk if the name
isn't there? Then dts can be backwards compatible.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
