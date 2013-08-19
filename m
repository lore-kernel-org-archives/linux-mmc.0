From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 1/1] mmc: dw_mmc: Add IDMAC 64-bit address mode support
Date: Mon, 19 Aug 2013 20:39:00 +0200
Message-ID: <201308192039.01098.arnd@arndb.de>
References: <705D14B1C7978B40A723277C067CEDE2CD7D78@IN01WEMBXB.internal.synopsys.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:51961 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750961Ab3HSSjT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 19 Aug 2013 14:39:19 -0400
In-Reply-To: <705D14B1C7978B40A723277C067CEDE2CD7D78@IN01WEMBXB.internal.synopsys.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Prabu Thangamuthu <Prabu.T@synopsys.com>
Cc: Chris Ball <cjb@laptop.org>, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Wei WANG <wei_wang@realsil.com.cn>, Ludovic Desroches <ludovic.desroches@atmel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Manjunath M Bettegowda <Manjunath.MB@synopsys.com>

On Monday 19 August 2013, Prabu Thangamuthu wrote:
> 
> +#ifdef CONFIG_MMC_DW_IDMAC_64BIT_ADDRESS
> +       u32     des1;   /* Reserved */
> +
> +       u32     des2;   /* Buffer sizes */
> +#define IDMAC_SET_BUFFER1_SIZE(d, s) \
> +       ((d)->des2 = ((d)->des2 & 0x03ffe000) | ((s) & 0x1fff))
> +
> +       u32     des3;   /* Reserved */
> +
> +       u32     des4;   /* Lower 32-bits of Buffer Address Pointer 1*/
> +       u32     des5;   /* Upper 32-bits of Buffer Address Pointer 1*/
> +       u32     des6;   /* Lower 32-bits of Next Descriptor Address */
> +       u32     des7;   /* Upper 32-bits of Next Descriptor Address */
> +#else
>         u32             des1;   /* Buffer sizes */
>  #define IDMAC_SET_BUFFER1_SIZE(d, s) \
>         ((d)->des1 = ((d)->des1 & 0x03ffe000) | ((s) & 0x1fff))
> @@ -73,6 +86,7 @@ struct idmac_desc {
>         u32             des2;   /* buffer 1 physical address */
>  
>         u32             des3;   /* buffer 2 physical address */
> +#endif /* CONFIG_MMC_DW_IDMAC_64BIT_ADDRESS */

This is not a good idea: It means you cannot build the driver to support
both 32 and 64 bit at run-time. You have to remove all the #ifdef here
and replace it with runtime checks. You also need to update the binding
document to provide a way to detect which one is present in a given
system.

	Arnd
