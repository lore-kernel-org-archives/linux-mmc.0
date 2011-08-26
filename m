From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH] [RFC] ARM: shmobile: g4evm: Use multiple irq vectors
 for SDHI
Date: Fri, 26 Aug 2011 14:17:20 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1108261416330.25272@axis700.grange>
References: <1314353627-23079-1-git-send-email-horms@verge.net.au>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1314353627-23079-1-git-send-email-horms@verge.net.au>
Sender: linux-sh-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, Magnus Damm <magnus.damm@gmail.com>
List-Id: linux-mmc@vger.kernel.org

On Fri, 26 Aug 2011, Simon Horman wrote:

> This patch is based on "ARM: arch-shmobile: Use multiple irq vectors for SDHI"
> 
> It removes multiplexing of the SDHI vectors and names each IRQ source
> to allow the SDHI driver to used source-specific handlers.
> 
> This is untested as I do not have access to a working g4evm.
> 
> Signed-off-by: Simon Horman <horms@verge.net.au>
> 
> ---
> 
> Requires "mmc: sdhi: Allow specific IRQ sources to use corresponding handlers."
> 
> *** compile tested only ***
> ---
>  arch/arm/mach-shmobile/board-g4evm.c |   26 ++++++++++++++++++++++-
>  arch/arm/mach-shmobile/intc-sh7377.c |   36 ++++++++++++++++-----------------

This second file should not be here, right?

Thanks
Guennadi

>  2 files changed, 41 insertions(+), 21 deletions(-)
> 
> diff --git a/arch/arm/mach-shmobile/board-g4evm.c b/arch/arm/mach-shmobile/board-g4evm.c
> index 8e3c555..60721f1 100644
> --- a/arch/arm/mach-shmobile/board-g4evm.c
> +++ b/arch/arm/mach-shmobile/board-g4evm.c
> @@ -209,7 +209,18 @@ static struct resource sdhi0_resources[] = {
>  		.flags  = IORESOURCE_MEM,
>  	},
>  	[1] = {
> -		.start  = evt2irq(0x0e00), /* SDHI0 */
> +		.name   = SH_MOBILE_SDHI_IRQ_CARD_DETECT,
> +		.start  = evt2irq(0x0e00) /* SDHI0_SDHI0I0 */,
> +		.flags  = IORESOURCE_IRQ,
> +	},
> +	[2] = {
> +		.name   = SH_MOBILE_SDHI_IRQ_SDCARD,
> +		.start  = evt2irq(0x0e20) /* SDHI0_SDHI0I1 */,
> +		.flags  = IORESOURCE_IRQ,
> +	},
> +	[3] = {
> +		.name   = SH_MOBILE_SDHI_IRQ_SDIO,
> +		.start  = evt2irq(0x0e40) /* SDHI0_SDHI0I2 */,
>  		.flags  = IORESOURCE_IRQ,
>  	},
>  };
> @@ -236,7 +247,18 @@ static struct resource sdhi1_resources[] = {
>  		.flags  = IORESOURCE_MEM,
>  	},
>  	[1] = {
> -		.start  = evt2irq(0x0e80), /* SDHI1 */
> +		.name   = SH_MOBILE_SDHI_IRQ_CARD_DETECT,
> +		.start  = evt2irq(0x0e80) /* SDHI1_SDHI0I0 */,
> +		.flags  = IORESOURCE_IRQ,
> +	},
> +	[2] = {
> +		.name   = SH_MOBILE_SDHI_IRQ_SDCARD,
> +		.start  = evt2irq(0x0ea0) /* SDHI1_SDHI0I1 */,
> +		.flags  = IORESOURCE_IRQ,
> +	},
> +	[3] = {
> +		.name   = SH_MOBILE_SDHI_IRQ_SDIO,
> +		.start  = evt2irq(0x0ec0) /* SDHI1_SDHI0I2 */,
>  		.flags  = IORESOURCE_IRQ,
>  	},
>  };
> diff --git a/arch/arm/mach-shmobile/intc-sh7377.c b/arch/arm/mach-shmobile/intc-sh7377.c
> index fe45154..6395687 100644
> --- a/arch/arm/mach-shmobile/intc-sh7377.c
> +++ b/arch/arm/mach-shmobile/intc-sh7377.c
> @@ -27,8 +27,6 @@
>  
>  enum {
>  	UNUSED_INTCA = 0,
> -	ENABLED,
> -	DISABLED,
>  
>  	/* interrupt sources INTCA */
>  	IRQ0A, IRQ1A, IRQ2A, IRQ3A, IRQ4A, IRQ5A, IRQ6A, IRQ7A,
> @@ -51,8 +49,8 @@ enum {
>  	MSIOF2, MSIOF1,
>  	SCIFA4, SCIFA5, SCIFB,
>  	FLCTL_FLSTEI, FLCTL_FLTENDI, FLCTL_FLTREQ0I, FLCTL_FLTREQ1I,
> -	SDHI0,
> -	SDHI1,
> +	SDHI0_SDHI0I0, SDHI0_SDHI0I1, SDHI0_SDHI0I2, SDHI0_SDHI0I3,
> +	SDHI1_SDHI1I0, SDHI1_SDHI1I1, SDHI1_SDHI1I2, SDHI1_SDHI1I3,
>  	MSU_MSU, MSU_MSU2,
>  	IRREM,
>  	MSUG,
> @@ -87,7 +85,7 @@ enum {
>  	/* interrupt groups INTCA */
>  	DMAC_1, DMAC_2,	DMAC2_1, DMAC2_2, DMAC3_1, DMAC3_2, SHWYSTAT,
>  	AP_ARM1, AP_ARM2, USBHS, SPU2, FLCTL, IIC1,
> -	ICUSB, ICUDMC
> +	ICUSB, ICUDMC, SDHI0, SDHI1,
>  };
>  
>  static struct intc_vect intca_vectors[] __initdata = {
> @@ -130,10 +128,10 @@ static struct intc_vect intca_vectors[] __initdata = {
>  	INTC_VECT(SCIFB, 0x0d60),
>  	INTC_VECT(FLCTL_FLSTEI, 0x0d80), INTC_VECT(FLCTL_FLTENDI, 0x0da0),
>  	INTC_VECT(FLCTL_FLTREQ0I, 0x0dc0), INTC_VECT(FLCTL_FLTREQ1I, 0x0de0),
> -	INTC_VECT(SDHI0, 0x0e00), INTC_VECT(SDHI0, 0x0e20),
> -	INTC_VECT(SDHI0, 0x0e40), INTC_VECT(SDHI0, 0x0e60),
> -	INTC_VECT(SDHI1, 0x0e80), INTC_VECT(SDHI1, 0x0ea0),
> -	INTC_VECT(SDHI1, 0x0ec0), INTC_VECT(SDHI1, 0x0ee0),
> +	INTC_VECT(SDHI0_SDHI0I0, 0x0e00), INTC_VECT(SDHI0_SDHI0I1, 0x0e20),
> +	INTC_VECT(SDHI0_SDHI0I2, 0x0e40), INTC_VECT(SDHI0_SDHI0I3, 0x0e60),
> +	INTC_VECT(SDHI1_SDHI1I0, 0x0e80), INTC_VECT(SDHI1_SDHI1I1, 0x0ea0),
> +	INTC_VECT(SDHI1_SDHI1I2, 0x0ec0), INTC_VECT(SDHI1_SDHI1I3, 0x0ee0),
>  	INTC_VECT(MSU_MSU, 0x0f20), INTC_VECT(MSU_MSU2, 0x0f40),
>  	INTC_VECT(IRREM, 0x0f60),
>  	INTC_VECT(MSUG, 0x0fa0),
> @@ -200,6 +198,10 @@ static struct intc_group intca_groups[] __initdata = {
>  	INTC_GROUP(SHWYSTAT, SHWYSTAT_RT, SHWYSTAT_HS, SHWYSTAT_COM),
>  	INTC_GROUP(ICUSB, ICUSB_ICUSB0, ICUSB_ICUSB1),
>  	INTC_GROUP(ICUDMC, ICUDMC_ICUDMC1, ICUDMC_ICUDMC2),
> +	INTC_GROUP(SDHI0, SDHI0_SDHI0I0, SDHI0_SDHI0I1,
> +		   SDHI0_SDHI0I2, SDHI0_SDHI0I3),
> +	INTC_GROUP(SDHI1, SDHI1_SDHI1I0, SDHI1_SDHI1I1,
> +		   SDHI1_SDHI1I2, SDHI1_SDHI1I3)
>  };
>  
>  static struct intc_mask_reg intca_mask_registers[] __initdata = {
> @@ -234,10 +236,10 @@ static struct intc_mask_reg intca_mask_registers[] __initdata = {
>  	  { SCIFB, SCIFA5, SCIFA4, MSIOF1,
>  	    0, 0, MSIOF2, 0 } },
>  	{ 0xe694009c, 0xe69400dc, 8, /* IMR7A / IMCR7A */
> -	  { DISABLED, ENABLED, ENABLED, ENABLED,
> +	  { SDHI0_SDHI0I3, SDHI0_SDHI0I2, SDHI0_SDHI0I1, SDHI0_SDHI0I0,
>  	    FLCTL_FLTREQ1I, FLCTL_FLTREQ0I, FLCTL_FLTENDI, FLCTL_FLSTEI } },
>  	{ 0xe69400a0, 0xe69400e0, 8, /* IMR8A / IMCR8A */
> -	  { DISABLED, ENABLED, ENABLED, ENABLED,
> +	  { SDHI1_SDHI1I3, SDHI1_SDHI1I2, SDHI1_SDHI1I1, SDHI1_SDHI1I0,
>  	    TTI20, USBDMAC_USHDMI, 0, MSUG } },
>  	{ 0xe69400a4, 0xe69400e4, 8, /* IMR9A / IMCR9A */
>  	  { CMT1_CMT13, CMT1_CMT12, CMT1_CMT11, CMT1_CMT10,
> @@ -337,14 +339,10 @@ static struct intc_mask_reg intca_ack_registers[] __initdata = {
>  	  { IRQ24A, IRQ25A, IRQ26A, IRQ27A, IRQ28A, IRQ29A, IRQ30A, IRQ31A } },
>  };
>  
> -static struct intc_desc intca_desc __initdata = {
> -	.name = "sh7377-intca",
> -	.force_enable = ENABLED,
> -	.force_disable = DISABLED,
> -	.hw = INTC_HW_DESC(intca_vectors, intca_groups,
> -			   intca_mask_registers, intca_prio_registers,
> -			   intca_sense_registers, intca_ack_registers),
> -};
> +static DECLARE_INTC_DESC_ACK(intca_desc, "sh7377-intca",
> +			     intca_vectors, intca_groups,
> +			     intca_mask_registers, intca_prio_registers,
> +			     intca_sense_registers, intca_ack_registers);
>  
>  /* this macro ignore entry which is also in INTCA */
>  #define __IGNORE(a...)
> -- 
> 1.7.5.4
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
