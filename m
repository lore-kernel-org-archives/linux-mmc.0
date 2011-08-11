From: David Brown <davidb@codeaurora.org>
Subject: Re: [PATCH] mmc: Use pr_<level>, add and use mmc_<level>
Date: Thu, 11 Aug 2011 13:34:16 -0700
Message-ID: <20110811203416.GA12740@huya.qualcomm.com>
References: <1441985db03ab10b067332f7d4b75b607921441b.1313094012.git.joe@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1441985db03ab10b067332f7d4b75b607921441b.1313094012.git.joe@perches.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Joe Perches <joe@perches.com>
Cc: Pavel Pisa <ppisa@pikron.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, Daniel Walker <dwalker@fifo99.com>, Harald Welte <HaraldWelte@viatech.com>, Pierre Ossman <pierre@ossman.eu>, Chris Ball <cjb@laptop.org>, Alex Dubov <oakad@yahoo.com>, linux-arm-msm@vger.kernel.org, Bruce Chang <brucechang@via.com.tw>, Ian Molton <ian@mnementh.co.uk>, Ben Dooks <ben-linux@fluff.org>, Tony Olech <tony.olech@elandigitalsystems.com>, linux-omap@vger.kernel.org, David Brown <davidb@codeaurora.org>, linux-arm-kernel@lists.infradead.org, Nicolas Pitre <nico@fluxnic.net>, linux-usb@vger.kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Bryan Huntsman <bryanh@codeaurora.org>, Manuel Lauss <manuel.lauss@gmail.com>, Jarkko Lavinen <jarkko.lavinen@nokia.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>
List-Id: linux-mmc@vger.kernel.org

On Thu, Aug 11, 2011 at 01:21:24PM -0700, Joe Perches wrote:
> Use current logging styles.
> 
> Add an mmc_printk function to reduce overall size
> by centralizing the mmc_hostname use.
> 
> Because pr_fmt(fmt) KBUILD_MODNAME is used,
> some logging prefixes are changed.
> For instance from "SDIO:" to "mmc_core:"
> 
> Add macros for mmc_err, mmc_warn, and mmc_info.
> Convert printks with mmc_hostname to mmc_<level>.
> 
> Whitespace neatening around pr_<level>.
> Convert printk(KERN_DEBUG to pr_debug(
> Convert direct uses of DBG macros to pr_debug.
> Convert direct uses of DBGF to DBG.
> Coalesce long format strings.
> Add a few missing newlines to logging messages.
> 
> $ size drivers/mmc/built-in.o*
>    text	   data	    bss	    dec	    hex	filename
>   92530	   1608	    204	  94342	  17086	drivers/mmc/built-in.o.minimal.new
>   94229	   1608	    204	  96041	  17729	drivers/mmc/built-in.o.minimal.old
>  291831	   5152	  77344	 374327	  5b637	drivers/mmc/built-in.o.allyesconfig.new
>  293616	   5152	  78128	 376896	  5c040	drivers/mmc/built-in.o.allyesconfig.old
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  drivers/mmc/host/msm_sdcc.c     |  103 +++++++++----------

Acked-by: David Brown <davidb@codeaurora.org>

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
