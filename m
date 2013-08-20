From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH v3 1/1] mmc: dw_mmc: Add IDMAC 64-bit address mode support
Date: Tue, 20 Aug 2013 18:56:33 +0900
Message-ID: <001d01ce9d8b$8d4e7fb0$a7eb7f10$%jun@samsung.com>
References: <705D14B1C7978B40A723277C067CEDE2CD7D78@IN01WEMBXB.internal.synopsys.com>
 <201308192039.01098.arnd@arndb.de>
 <001901ce9d7a$a7ed49c0$f7c7dd40$%jun@samsung.com>
 <705D14B1C7978B40A723277C067CEDE2CD7EC6@IN01WEMBXB.internal.synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:29652 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750791Ab3HTJ4g (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Aug 2013 05:56:36 -0400
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MRT00EEXQA2ITH0@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 20 Aug 2013 18:56:34 +0900 (KST)
In-reply-to: <705D14B1C7978B40A723277C067CEDE2CD7EC6@IN01WEMBXB.internal.synopsys.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Prabu Thangamuthu' <Prabu.T@synopsys.com>, 'Arnd Bergmann' <arnd@arndb.de>
Cc: 'Chris Ball' <cjb@laptop.org>, 'Jaehoon Chung' <jh80.chung@samsung.com>, 'Wei WANG' <wei_wang@realsil.com.cn>, 'Ludovic Desroches' <ludovic.desroches@atmel.com>, 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>, linux-mmc@vger.kernel.org, 'Manjunath M Bettegowda' <Manjunath.MB@synopsys.com>

On Tue, August 20, 2013, Prabu Thangamuthu wrote:
> Hi Arnd, Seungwon Jeon,
> 
> > On Tue, August 20, 2013, Seungwon Jeon wrote:
> > Hi Prabu,
> >
> > On Tue, August 20, 2013, Arnd Bergmann wrote:
> > > On Monday 19 August 2013, Prabu Thangamuthu wrote:
> > > >
> > > > +#ifdef CONFIG_MMC_DW_IDMAC_64BIT_ADDRESS
> > > > +       u32     des1;   /* Reserved */
> > > > +
> > > > +       u32     des2;   /* Buffer sizes */
> > > > +#define IDMAC_SET_BUFFER1_SIZE(d, s) \
> > > > +       ((d)->des2 = ((d)->des2 & 0x03ffe000) | ((s) & 0x1fff))
> > > > +
> > > > +       u32     des3;   /* Reserved */
> > > > +
> > > > +       u32     des4;   /* Lower 32-bits of Buffer Address Pointer 1*/
> > > > +       u32     des5;   /* Upper 32-bits of Buffer Address Pointer 1*/
> > > > +       u32     des6;   /* Lower 32-bits of Next Descriptor Address */
> > > > +       u32     des7;   /* Upper 32-bits of Next Descriptor Address */
> > > > +#else
> > > >         u32             des1;   /* Buffer sizes */
> > > >  #define IDMAC_SET_BUFFER1_SIZE(d, s) \
> > > >         ((d)->des1 = ((d)->des1 & 0x03ffe000) | ((s) & 0x1fff)) @@
> > > > -73,6 +86,7 @@ struct idmac_desc {
> > > >         u32             des2;   /* buffer 1 physical address */
> > > >
> > > >         u32             des3;   /* buffer 2 physical address */
> > > > +#endif /* CONFIG_MMC_DW_IDMAC_64BIT_ADDRESS */
> > >
> > > This is not a good idea: It means you cannot build the driver to
> > > support both 32 and 64 bit at run-time. You have to remove all the
> > > #ifdef here and replace it with runtime checks. You also need to
> > > update the binding document to provide a way to detect which one is
> > > present in a given system.
> 
> OK, I will modify the code to support both 32-bit and 64-bit at run-time based on
> hardware capability.
> 
> 
> > I guess HCON register can be used to identify 32 or 64 bit, right?
> > You already used it.
> > 	addr_config = (mci_readl(host, HCON) >> 27) & 0x01;
> >
> > Then, CONFIG_MMC_DW_IDMAC_64BIT_ADDRESS could be removed.
> 
> You are correct. HCON register 27th bit is used to decide 32-bit or 64-bit support.
> But, this bit is reserved in older IP versions and it is valid from IP version 2.70a onwards only.
Yes, 27th is reserved bit filed. If it's read in old version host, it could be '0' by reset value.
Then, we can decide that this host supports only 32-bit address anyway?
If right, we don't need to get version.


> So, I will consider both IP version and HCON register 27th bit to provide run-time support.
> 
> Thank you Arnd and Seungwon Jeo for your valuable comments.
> 
> 
Thanks,
Seungwon Jeon

