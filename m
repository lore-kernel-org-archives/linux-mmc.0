From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH v3 1/1] mmc: dw_mmc: Add IDMAC 64-bit address mode support
Date: Tue, 20 Aug 2013 16:55:36 +0900
Message-ID: <001901ce9d7a$a7ed49c0$f7c7dd40$%jun@samsung.com>
References: <705D14B1C7978B40A723277C067CEDE2CD7D78@IN01WEMBXB.internal.synopsys.com>
 <201308192039.01098.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:28127 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751782Ab3HTHzj (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Aug 2013 03:55:39 -0400
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MRT00L8UKOPVQ30@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 20 Aug 2013 16:55:37 +0900 (KST)
In-reply-to: <201308192039.01098.arnd@arndb.de>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Arnd Bergmann' <arnd@arndb.de>, 'Prabu Thangamuthu' <Prabu.T@synopsys.com>
Cc: 'Chris Ball' <cjb@laptop.org>, 'Jaehoon Chung' <jh80.chung@samsung.com>, 'Wei WANG' <wei_wang@realsil.com.cn>, 'Ludovic Desroches' <ludovic.desroches@atmel.com>, 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>, linux-mmc@vger.kernel.org, 'Manjunath M Bettegowda' <Manjunath.MB@synopsys.com>

Hi Prabu,

On Tue, August 20, 2013, Arnd Bergmann wrote:
> On Monday 19 August 2013, Prabu Thangamuthu wrote:
> >
> > +#ifdef CONFIG_MMC_DW_IDMAC_64BIT_ADDRESS
> > +       u32     des1;   /* Reserved */
> > +
> > +       u32     des2;   /* Buffer sizes */
> > +#define IDMAC_SET_BUFFER1_SIZE(d, s) \
> > +       ((d)->des2 = ((d)->des2 & 0x03ffe000) | ((s) & 0x1fff))
> > +
> > +       u32     des3;   /* Reserved */
> > +
> > +       u32     des4;   /* Lower 32-bits of Buffer Address Pointer 1*/
> > +       u32     des5;   /* Upper 32-bits of Buffer Address Pointer 1*/
> > +       u32     des6;   /* Lower 32-bits of Next Descriptor Address */
> > +       u32     des7;   /* Upper 32-bits of Next Descriptor Address */
> > +#else
> >         u32             des1;   /* Buffer sizes */
> >  #define IDMAC_SET_BUFFER1_SIZE(d, s) \
> >         ((d)->des1 = ((d)->des1 & 0x03ffe000) | ((s) & 0x1fff))
> > @@ -73,6 +86,7 @@ struct idmac_desc {
> >         u32             des2;   /* buffer 1 physical address */
> >
> >         u32             des3;   /* buffer 2 physical address */
> > +#endif /* CONFIG_MMC_DW_IDMAC_64BIT_ADDRESS */
> 
> This is not a good idea: It means you cannot build the driver to support
> both 32 and 64 bit at run-time. You have to remove all the #ifdef here
> and replace it with runtime checks. You also need to update the binding
> document to provide a way to detect which one is present in a given
> system.
>
I guess HCON register can be used to identify 32 or 64 bit, right?
You already used it.
	addr_config = (mci_readl(host, HCON) >> 27) & 0x01;

Then, CONFIG_MMC_DW_IDMAC_64BIT_ADDRESS could be removed.

Thanks,
Seungwon Jeon

