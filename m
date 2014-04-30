From: Ben Dooks <ben@trinity.fluff.org>
Subject: Re: [PATCH 5/6] shmobile: TMIO: break register specs out from TMIO
 kernel driver
Date: Wed, 30 Apr 2014 18:58:12 +0100
Message-ID: <20140430175812.GX4400@trinity.fluff.org>
References: <1398877151-6965-1-git-send-email-ian.molton@codethink.co.uk>
 <1398877151-6965-6-git-send-email-ian.molton@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from trinity.fluff.org ([89.16.178.74]:38530 "EHLO trinity.fluff.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751498AbaD3S2I (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 30 Apr 2014 14:28:08 -0400
Content-Disposition: inline
In-Reply-To: <1398877151-6965-6-git-send-email-ian.molton@codethink.co.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ian Molton <ian.molton@codethink.co.uk>
Cc: linux-mmc@vger.kernel.org, grant.likely@linaro.org, chris@printf.net

On Wed, Apr 30, 2014 at 05:59:10PM +0100, Ian Molton wrote:
> 	Right now we have a public header stuffed full of register defs
> 	that ought to be private to the TMIO MMC driver.
> 
> 	Break out the definitions required for shmobiles bootloader.
> 
> 	This commit is in preparation for making the TMIO register defs
> 	private, as they should be.

No need to indent the patch description.
 
> Reviewed-by: Violeta Menendez <violeta.menendez@codethink.co.uk>
> Signed-off-by: Ian Molton <ian.molton@codethink.co.uk>
> ---
>  arch/arm/boot/compressed/sdhi-sh7372.c   |  2 +-
>  arch/arm/boot/compressed/sdhi-shmobile.c | 35 +++++++++++++++++++++++++++-----
>  arch/arm/boot/compressed/sdhi-shmobile.h |  2 ++
>  3 files changed, 33 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/boot/compressed/sdhi-sh7372.c b/arch/arm/boot/compressed/sdhi-sh7372.c
> index d279294..b05fba6 100644
> --- a/arch/arm/boot/compressed/sdhi-sh7372.c
> +++ b/arch/arm/boot/compressed/sdhi-sh7372.c
> @@ -81,7 +81,7 @@ asmlinkage void mmc_loader(unsigned short *buf, unsigned long len)
>  	/* load kernel */
>  	if (sdhi_boot_do_read(SDHI_BASE, high_capacity,
>  			      0, /* Kernel is at block 1 */
> -			      (len + TMIO_BBS - 1) / TMIO_BBS, buf))
> +			      (len + BB_SIZE - 1) / BB_SIZE, buf))
>  		goto err;
>  
>          /* Disable clock to SDHI1 hardware block */
> diff --git a/arch/arm/boot/compressed/sdhi-shmobile.c b/arch/arm/boot/compressed/sdhi-shmobile.c
> index bd3d469..48be885 100644
> --- a/arch/arm/boot/compressed/sdhi-shmobile.c
> +++ b/arch/arm/boot/compressed/sdhi-shmobile.c
> @@ -26,6 +26,17 @@
>  
>  #define RESP_CMD12		0x00000030
>  
> +#define CTL_SD_CMD		0x00
> +#define CTL_ARG_REG		0x04
> +#define CTL_RESPONSE		0x0c
> +#define CTL_STATUS		0x1c
> +#define CTL_IRQ_MASK		0x20
> +#define CTL_SD_CARD_CLK_CTL	0x24
> +#define CTL_SD_XFER_LEN		0x26
> +#define CTL_SD_MEM_CARD_OPT	0x28
> +#define CTL_RESET_SD		0xe0
> +#define CTL_CLK_AND_WAIT_CTL	0x138
> +
>  static inline u16 sd_ctrl_read16(void __iomem *base, int addr)
>  {
>          return __raw_readw(base + addr);
> @@ -48,6 +59,20 @@ static inline void sd_ctrl_write32(void __iomem *base, int addr, u32 val)
>  	__raw_writew(val >> 16, base + addr + 2);
>  }
>  
> +#define TMIO_STAT_CMDRESPEND    0x00000001
> +#define TMIO_STAT_DATAEND       0x00000004
> +#define TMIO_STAT_CMD_IDX_ERR   0x00010000
> +#define TMIO_STAT_CRCFAIL       0x00020000
> +#define TMIO_STAT_STOPBIT_ERR   0x00040000
> +#define TMIO_STAT_DATATIMEOUT   0x00080000
> +#define TMIO_STAT_RXOVERFLOW    0x00100000
> +#define TMIO_STAT_TXUNDERRUN    0x00200000
> +#define TMIO_STAT_CMDTIMEOUT    0x00400000
> +#define TMIO_STAT_RXRDY         0x01000000
> +#define TMIO_STAT_ILL_FUNC      0x20000000
> +#define TMIO_STAT_CMD_BUSY      0x40000000
> +#define TMIO_STAT_ILL_ACCESS    0x80000000
> +
>  #define ALL_ERROR (TMIO_STAT_CMD_IDX_ERR | TMIO_STAT_CRCFAIL |		\
>  		   TMIO_STAT_STOPBIT_ERR | TMIO_STAT_DATATIMEOUT |	\
>  		   TMIO_STAT_RXOVERFLOW | TMIO_STAT_TXUNDERRUN |	\
> @@ -236,7 +261,7 @@ static int sdhi_boot_do_read_single(void __iomem *base, int high_capacity,
>  		if (high_capacity)
>  			cmd.arg = block;
>  		else
> -			cmd.arg = block * TMIO_BBS;
> +			cmd.arg = block * BB_SIZE;
>  		cmd.flags = MMC_RSP_R1;
>  		err = sdhi_boot_request(base, &cmd);
>  		if (err)
> @@ -251,8 +276,8 @@ static int sdhi_boot_do_read_single(void __iomem *base, int high_capacity,
>  	if (err)
>  		return err;
>  
> -	sd_ctrl_write16(base, CTL_SD_XFER_LEN, TMIO_BBS);
> -	for (i = 0; i < TMIO_BBS / sizeof(*buf); i++)
> +	sd_ctrl_write16(base, CTL_SD_XFER_LEN, BB_SIZE);
> +	for (i = 0; i < BB_SIZE / sizeof(*buf); i++)
>  		*buf++ = sd_ctrl_read16(base, RESP_CMD12);
>  
>  	err = sdhi_boot_wait_resp_end(base);
> @@ -271,7 +296,7 @@ int sdhi_boot_do_read(void __iomem *base, int high_capacity,
>  
>  	for (i = 0; i < count; i++) {
>  		err = sdhi_boot_do_read_single(base, high_capacity, offset + i,
> -					       buf + (i * TMIO_BBS /
> +					       buf + (i * BB_SIZE /
>  						      sizeof(*buf)));
>  		if (err)
>  			return err;
> @@ -438,7 +463,7 @@ int sdhi_boot_init(void __iomem *base)
>  	{
>  		struct mmc_command cmd;
>  		cmd.opcode = MMC_SET_BLOCKLEN;
> -		cmd.arg = TMIO_BBS;
> +		cmd.arg = BB_SIZE;
>  		cmd.flags = MMC_RSP_R1;
>  		err = sdhi_boot_request(base, &cmd);
>  		if (err)
> diff --git a/arch/arm/boot/compressed/sdhi-shmobile.h b/arch/arm/boot/compressed/sdhi-shmobile.h
> index 92eaa09..d82e2d5 100644
> --- a/arch/arm/boot/compressed/sdhi-shmobile.h
> +++ b/arch/arm/boot/compressed/sdhi-shmobile.h
> @@ -3,6 +3,8 @@
>  
>  #include <linux/compiler.h>
>  
> +#define BB_SIZE 512
> +
>  int sdhi_boot_do_read(void __iomem *base, int high_capacity,
>  		      unsigned long offset, unsigned short count,
>  		      unsigned short *buf);
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Ben Dooks, ben@fluff.org, http://www.fluff.org/ben/

Large Hadron Colada: A large Pina Colada that makes the universe disappear.

