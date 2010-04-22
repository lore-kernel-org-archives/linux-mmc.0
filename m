From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH 2/7] OMAP4-HSMMC: Adding HSMMC support for OMAP4430
	Board file
Date: Thu, 22 Apr 2010 07:35:01 +0100
Message-ID: <20100422063500.GA8623@flint.arm.linux.org.uk>
References: <63411.10.24.255.18.1271873995.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:36017 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759224Ab0D3T7N (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 30 Apr 2010 15:59:13 -0400
Content-Disposition: inline
In-Reply-To: <63411.10.24.255.18.1271873995.squirrel@dbdmail.itg.ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: kishore kadiyala <kishore.kadiyala@ti.com>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, madhu.cr@ti.com, jarkko.lavinen@nokia.com, tony@atomide.com, santosh.shilimkar@ti.com

On Wed, Apr 21, 2010 at 11:49:55PM +0530, kishore kadiyala wrote:
> @@ -99,6 +110,17 @@ static struct regulator_consumer_supply sdp4430_vmmc_supply[]
>  	},
>  };
> 
> +static int __init sdp4430_mmc_init(void)
> +{
> +	omap2_hsmmc_init(mmc);
> +
> +	/* link regulators to MMC adapters ... we "know" the
> +	 * regulators will be set up only *after* we return.
> +	 */
> +	sdp4430_vmmc_supply[0].dev = mmc[0].dev;
> +	sdp4430_vmmc_supply[1].dev = mmc[1].dev;
> +	return 0;
> +}

There should be a blank line between functions.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
