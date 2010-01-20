From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH V2 5/10] omap: Add functions for dynamic remuxing of
 pins
Date: Tue, 19 Jan 2010 17:21:21 -0800
Message-ID: <20100120012120.GJ10318@atomide.com>
References: <20100117013250.17308.17861.sendpatchset@ahunter-work.research.nokia.com>
 <20100117013328.17308.2865.sendpatchset@ahunter-work.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20100117013328.17308.2865.sendpatchset@ahunter-work.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@nokia.com>
Cc: Madhusudhan Chikkature <madhu.cr@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap Mailing List <linux-omap@vger.kernel.org>, linux-mmc Mailing List <linux-mmc@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-mmc@vger.kernel.org

* Adrian Hunter <adrian.hunter@nokia.com> [100116 17:31]:
> From 33beb5bc36cba739971dc8919a6929925ad3dafc Mon Sep 17 00:00:00 2001
> From: Tony Lindgren <tony@atomide.com>
> Date: Wed, 13 Jan 2010 10:27:17 -0800
> Subject: [PATCH] omap: Add functions for dynamic remuxing of pins
> 
> Make the omap_mux_read and write available for board code,
> and rename omap_mux_set_board_signals into omap_mux_write_array.
> 
> In some cases we want to change the signals dynamically,
> mostly for power management.
> 
> Note that we cannot use the signal names as they are set
> __init to save memory.

I'll try to merge this as a fix since it fixes dynamic remuxing.

Adrian, can I add your Acked-by?

Regards,

Tony
 
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/mach-omap2/mux.c |   22 +++++++++++-----------
>  arch/arm/mach-omap2/mux.h |   24 ++++++++++++++++++++++++
>  2 files changed, 35 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
> index a8febd3..50298b4 100644
> --- a/arch/arm/mach-omap2/mux.c
> +++ b/arch/arm/mach-omap2/mux.c
> @@ -51,7 +51,7 @@ struct omap_mux_entry {
>  static unsigned long mux_phys;
>  static void __iomem *mux_base;
>  
> -static inline u16 omap_mux_read(u16 reg)
> +u16 omap_mux_read(u16 reg)
>  {
>  	if (cpu_is_omap24xx())
>  		return __raw_readb(mux_base + reg);
> @@ -59,7 +59,7 @@ static inline u16 omap_mux_read(u16 reg)
>  		return __raw_readw(mux_base + reg);
>  }
>  
> -static inline void omap_mux_write(u16 val, u16 reg)
> +void omap_mux_write(u16 val, u16 reg)
>  {
>  	if (cpu_is_omap24xx())
>  		__raw_writeb(val, mux_base + reg);
> @@ -67,6 +67,14 @@ static inline void omap_mux_write(u16 val, u16 reg)
>  		__raw_writew(val, mux_base + reg);
>  }
>  
> +void omap_mux_write_array(struct omap_board_mux *board_mux)
> +{
> +	while (board_mux->reg_offset !=  OMAP_MUX_TERMINATOR) {
> +		omap_mux_write(board_mux->value, board_mux->reg_offset);
> +		board_mux++;
> +	}
> +}
> +
>  #if defined(CONFIG_ARCH_OMAP24XX) && defined(CONFIG_OMAP_MUX)
>  
>  static struct omap_mux_cfg arch_mux_cfg;
> @@ -833,14 +841,6 @@ static void __init omap_mux_set_cmdline_signals(void)
>  	kfree(options);
>  }
>  
> -static void __init omap_mux_set_board_signals(struct omap_board_mux *board_mux)
> -{
> -	while (board_mux->reg_offset !=  OMAP_MUX_TERMINATOR) {
> -		omap_mux_write(board_mux->value, board_mux->reg_offset);
> -		board_mux++;
> -	}
> -}
> -
>  static int __init omap_mux_copy_names(struct omap_mux *src,
>  					struct omap_mux *dst)
>  {
> @@ -992,7 +992,7 @@ static void omap_mux_init_package(struct omap_mux *superset,
>  static void omap_mux_init_signals(struct omap_board_mux *board_mux)
>  {
>  	omap_mux_set_cmdline_signals();
> -	omap_mux_set_board_signals(board_mux);
> +	omap_mux_write_array(board_mux);
>  }
>  
>  #else
> diff --git a/arch/arm/mach-omap2/mux.h b/arch/arm/mach-omap2/mux.h
> index d8b4d5a..f8c2e7a 100644
> --- a/arch/arm/mach-omap2/mux.h
> +++ b/arch/arm/mach-omap2/mux.h
> @@ -147,6 +147,30 @@ u16 omap_mux_get_gpio(int gpio);
>  void omap_mux_set_gpio(u16 val, int gpio);
>  
>  /**
> + * omap_mux_read() - read mux register
> + * @mux_offset:		Offset of the mux register
> + *
> + */
> +u16 omap_mux_read(u16 mux_offset);
> +
> +/**
> + * omap_mux_write() - write mux register
> + * @val:		New mux register value
> + * @mux_offset:		Offset of the mux register
> + *
> + * This should be only needed for dynamic remuxing of non-gpio signals.
> + */
> +void omap_mux_write(u16 val, u16 mux_offset);
> +
> +/**
> + * omap_mux_write_array() - write an array of mux registers
> + * @board_mux:		Array of mux registers terminated by MAP_MUX_TERMINATOR
> + *
> + * This should be only needed for dynamic remuxing of non-gpio signals.
> + */
> +void omap_mux_write_array(struct omap_board_mux *board_mux);
> +
> +/**
>   * omap3_mux_init() - initialize mux system with board specific set
>   * @board_mux:		Board specific mux table
>   * @flags:		OMAP package type used for the board
> -- 
> 1.6.0.4
> 
