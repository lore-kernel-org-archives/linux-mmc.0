From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc-utils: small fixes of output
Date: Thu, 16 May 2013 07:17:11 +0900
Message-ID: <51940967.8020309@samsung.com>
References: <1368599284-28499-1-git-send-email-mario.schuknecht@dresearch-fe.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:21328 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751103Ab3EOWRO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 15 May 2013 18:17:14 -0400
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MMV006AX1WILVJ0@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 16 May 2013 07:17:13 +0900 (KST)
In-reply-to: <1368599284-28499-1-git-send-email-mario.schuknecht@dresearch-fe.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mario Schuknecht <mario.schuknecht@dresearch-fe.de>
Cc: cjb@laptop.org, linux-mmc@vger.kernel.org

Looks good to me.

Acked-by: Jaehoon Chung <jh80.chung@samsung.com>

On 05/15/2013 03:28 PM, Mario Schuknecht wrote:
> Improve "extcsd read" output of the registers.
> Right-shift by 3 of EXT_CSD_BOOT_CFG_EN bits.
> Expand the EXT_CSD_BOOT_CFG_ACC bit mask to 0x7.
> Add case 3 RPMB partition.
> 
> Signed-off-by: Mario Schuknecht <mario.schuknecht@dresearch-fe.de>
> ---
>  mmc.h      |    2 +-
>  mmc_cmds.c |    7 +++++--
>  2 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/mmc.h b/mmc.h
> index c863751..a01c079 100644
> --- a/mmc.h
> +++ b/mmc.h
> @@ -70,7 +70,7 @@
>  #define EXT_CSD_BOOT_INFO_ALT		(1<<0)
>  #define EXT_CSD_BOOT_CFG_ACK		(1<<6)
>  #define EXT_CSD_BOOT_CFG_EN		(0x38)
> -#define EXT_CSD_BOOT_CFG_ACC		(0x03)
> +#define EXT_CSD_BOOT_CFG_ACC		(0x07)
>  #define EXT_CSD_RST_N_EN_MASK		(0x03)
>  #define EXT_CSD_HW_RESET_EN		(0x01)
>  #define EXT_CSD_HW_RESET_DIS		(0x02)
> diff --git a/mmc_cmds.c b/mmc_cmds.c
> index b407f65..96a1cb5 100644
> --- a/mmc_cmds.c
> +++ b/mmc_cmds.c
> @@ -613,7 +613,7 @@ int do_read_extcsd(int nargs, char **argv)
>  		ext_csd[181]);
>  	reg = ext_csd[EXT_CSD_BOOT_CFG];
>  	printf("Boot configuration bytes [PARTITION_CONFIG: 0x%02x]\n", reg);
> -	switch (reg & EXT_CSD_BOOT_CFG_EN) {
> +	switch ((reg & EXT_CSD_BOOT_CFG_EN)>>3) {
>  	case 0x0:
>  		printf(" Not boot enable\n");
>  		break;
> @@ -637,8 +637,11 @@ int do_read_extcsd(int nargs, char **argv)
>  	case 0x2:
>  		printf(" R/W Boot Partition 2\n");
>  		break;
> +	case 0x3:
> +		printf(" R/W Replay Protected Memory Block (RPMB)\n");
> +		break;
>  	default:
> -		printf(" Access to General Purpuse partition %d\n",
> +		printf(" Access to General Purpose partition %d\n",
>  			(reg & EXT_CSD_BOOT_CFG_ACC) - 3);
>  		break;
>  	}
> 

