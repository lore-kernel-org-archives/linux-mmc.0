From: Ladislav Michl <Ladislav.Michl@seznam.cz>
Subject: Re: [PATCH v3] mmc-omap: Add support for 16-bit and 32-bit
	registers
Date: Mon, 23 Nov 2009 14:25:55 +0100
Message-ID: <20091123132555.GA12983@localhost.localdomain>
References: <1258924585.10992.1.camel@runt>
Reply-To: Ladislav Michl <ladis@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.seznam.cz ([77.75.72.43]:46219 "EHLO smtp.seznam.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756997AbZKWMZy (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 23 Nov 2009 07:25:54 -0500
Content-Disposition: inline
In-Reply-To: <1258924585.10992.1.camel@runt>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Cory Maccarrone <darkstar6262@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org

On Sun, Nov 22, 2009 at 01:16:25PM -0800, Cory Maccarrone wrote:
> The omap850 and omap730 use 16-bit registers instead of 32-bit, requiring
> a modification of the register addresses in the mmc-omap driver.  To resolve
> this, a bit shift is performed on base register addresses, either by 1 or 2
> bits depending on the CPU in use.  This yields the correct registers for
> each CPU.
[...]
> @@ -167,6 +168,8 @@ struct mmc_omap_host {
>  	spinlock_t		clk_lock;     /* for changing enabled state */
>  	unsigned int            fclk_enabled:1;
>  
> +	unsigned		reg_shift:1;
> +
[...]
Here you made reg_shift one bit wide variable...

> @@ -1490,6 +1493,8 @@ static int __init mmc_omap_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> +	host->reg_shift = (cpu_is_omap7xx() ? 1 : 2);
> +
...and here you are possibly trying to set second bit of that variable. It does
not work.

And sorry to ask again. This very driver works reliable and there are no
timeouts like this
mmci-omap mmci-omap.0: command timeout (CMD8)
mmci-omap mmci-omap.0: command timeout (CMD5)
mmci-omap mmci-omap.0: command timeout (CMD5)
mmci-omap mmci-omap.0: command timeout (CMD5)
mmci-omap mmci-omap.0: command timeout (CMD5)
mmci-omap mmci-omap.0: command timeout (CMD55)
mmci-omap mmci-omap.0: command timeout (CMD55)
mmci-omap mmci-omap.0: command timeout (CMD55)
mmci-omap mmci-omap.0: command timeout (CMD55)
while detecting MMC card on OMAP730? (because I can see them on 5910). This question
is unrelated to your patch.

	ladis
