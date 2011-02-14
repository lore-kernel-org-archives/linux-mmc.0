From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 2/2] mach-mmp: Support for SD/MMC clock adjustment in
	brownstone
Date: Mon, 14 Feb 2011 15:46:01 +0000
Message-ID: <20110214154601.GA31103@n2100.arm.linux.org.uk>
References: <9C2307EC-8314-40D5-A33B-38834F0F4698@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:44459 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754185Ab1BNPqZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Feb 2011 10:46:25 -0500
Content-Disposition: inline
In-Reply-To: <9C2307EC-8314-40D5-A33B-38834F0F4698@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Mark Brown <markb@marvell.com>, Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>

On Sun, Feb 13, 2011 at 10:56:22PM -0800, Philip Rakity wrote:
> 
> Set timing for brownstone for SD/MMC cards to enable detection
> timing adjustments are needed when speed > 25MHz
> remove limitation on maximum speed of 25MHz
> 
> Signed-off-by: Philip Rakity <prakity@marvell.com>
> ---
>  arch/arm/mach-mmp/brownstone.c |   10 +++++++++-
>  1 files changed, 9 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-mmp/brownstone.c b/arch/arm/mach-mmp/brownstone.c
> index 0e92fd7..35afe60 100644
> --- a/arch/arm/mach-mmp/brownstone.c
> +++ b/arch/arm/mach-mmp/brownstone.c
> @@ -178,14 +178,22 @@ static struct i2c_board_info brownstone_twsi1_info[] = {
>  };
>  
>  static struct sdhci_pxa_platdata mmp2_sdh_platdata_mmc0 = {
> -	.max_speed	= 25000000,
> +	.adjust_clocks	= 1,
> +	.clk_select	= 1,
> +	.clk_delay	= 31,
>  };
>  
>  static struct sdhci_pxa_platdata mmp2_sdh_platdata_mmc1 = {
> +	.adjust_clocks	= 1,
> +	.clk_select	= 1,
> +	.clk_delay	= 15,
>  	.flags		= PXA_FLAG_CARD_PERMANENT,
>  };
>  
>  static struct sdhci_pxa_platdata mmp2_sdh_platdata_mmc2 = {
> +	.adjust_clocks	= 1,
> +	.clk_select	= 1,
> +	.clk_delay	= 31,

You create the new fields in patch 1 and then add values to them in patch 2.
However, they remain unused, so it's impossible to see what the point of
creating them was.
