From: Ladislav Michl <Ladislav.Michl@seznam.cz>
Subject: Re: [PATCH v4] mmc-omap: Add support for 16-bit and 32-bit
	registers
Date: Mon, 23 Nov 2009 20:12:24 +0100
Message-ID: <20091123191224.GA2076@localhost.localdomain>
References: <1258993439-4787-1-git-send-email-darkstar6262@gmail.com>
Reply-To: Ladislav Michl <ladis@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1258993439-4787-1-git-send-email-darkstar6262@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
To: Cory Maccarrone <darkstar6262@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, Marek Belisko <marek.belisko@open-nandra.com>
List-Id: linux-mmc@vger.kernel.org

On Mon, Nov 23, 2009 at 08:23:59AM -0800, Cory Maccarrone wrote:
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
> +	unsigned		reg_shift:2;
Ah, there is no valid reason to make it bitfield, right? Whole struct is
not well layed wtr alignment, but please do not make it any worse. That is
my last complain, I swear ;-). Thank you for your patience.

Other than that, tested on OMAP5910 and it works now (though it needs
additional patch, see here:
http://thread.gmane.org/gmane.linux.kernel.mmc/649).

Tested-by: Ladislav Michl <ladis@linux-mips.org>

Best regards,
	ladis
