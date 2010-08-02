From: Zang Roy-R61911 <r61911@freescale.com>
Subject: RE: [PATCH 3/3 v2] mmc: Add ESDHC weird voltage bits workaround
Date: Mon, 2 Aug 2010 14:19:58 +0800
Message-ID: <83024545B35D6445A690EFD603E7869A07ED05@zch01exm23.fsl.freescale.net>
References: <1280461977-2023-1-git-send-email-tie-fei.zang@freescale.com> <20100730070624.GB20351@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from db3ehsobe002.messaging.microsoft.com ([213.199.154.140]:30359
	"EHLO DB3EHSOBE002.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752493Ab0HBGUL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 2 Aug 2010 02:20:11 -0400
Received: from mail56-db3 (localhost.localdomain [127.0.0.1])	by
 mail56-db3-R.bigfish.com (Postfix) with ESMTP id 9777F1A80505	for
 <linux-mmc@vger.kernel.org>; Mon,  2 Aug 2010 06:20:09 +0000 (UTC)
Received: from DB3EHSMHS004.bigfish.com (unknown [10.3.81.246])	by
 mail56-db3.bigfish.com (Postfix) with ESMTP id 4DEEF13005F	for
 <linux-mmc@vger.kernel.org>; Mon,  2 Aug 2010 06:20:09 +0000 (UTC)
Received: from az33smr02.freescale.net (az33smr02.freescale.net
 [10.64.34.200])	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP id
 o726K2sv026305	for <linux-mmc@vger.kernel.org>; Sun, 1 Aug 2010 23:20:07
 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
 [10.192.129.207])	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id
 o726K7qA019786	for <linux-mmc@vger.kernel.org>; Mon, 2 Aug 2010 01:20:08
 -0500 (CDT)
Content-Class: urn:content-classes:message
In-Reply-To: <20100730070624.GB20351@oksana.dev.rtsoft.ru>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Anton Vorontsov <cbouatmailru@gmail.com>
Cc: linux-mmc@vger.kernel.org, linuxppc-dev@ozlabs.org, akpm@linux-foundation.org

 

> -----Original Message-----
> From: Anton Vorontsov [mailto:cbouatmailru@gmail.com] 
> Sent: Friday, July 30, 2010 15:06 PM
> To: Zang Roy-R61911
> Cc: linux-mmc@vger.kernel.org; linuxppc-dev@ozlabs.org; 
> akpm@linux-foundation.org
> Subject: Re: [PATCH 3/3 v2] mmc: Add ESDHC weird voltage bits 
> workaround
> 
> On Fri, Jul 30, 2010 at 11:52:57AM +0800, Roy Zang wrote:
> > P4080 ESDHC controller does not support 1.8V and 3.0V 
> voltage. but the
> > host controller capabilities register wrongly set the bits.
> > This patch adds the workaround to correct the weird voltage 
> setting bits.
> > 
> > Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
> > ---
> [...]
> > diff --git a/drivers/mmc/host/sdhci-of-core.c 
> b/drivers/mmc/host/sdhci-of-core.c
> > index 0c30242..1f3913d 100644
> > --- a/drivers/mmc/host/sdhci-of-core.c
> > +++ b/drivers/mmc/host/sdhci-of-core.c
> > @@ -164,6 +164,10 @@ static int __devinit 
> sdhci_of_probe(struct of_device *ofdev,
> >  	if (sdhci_of_wp_inverted(np))
> >  		host->quirks |= SDHCI_QUIRK_INVERTED_WRITE_PROTECT;
> >  
> > +	if (of_device_is_compatible(np, "fsl,p4080-esdhc"))
> > +		host->quirks |= (SDHCI_QUIRK_QORIQ_NO_VDD_180
> > +				|SDHCI_QUIRK_QORIQ_NO_VDD_300);
> > +
> 
> It should be two properties, something like sdhci,no-vdd-180
> and sdhci,no-vdd-300. But it might be even better: we have
> voltage-ranges for mmc-spi case, see
> Documentation/powerpc/dts-bindings/mmc-spi-slot.txt.
> 
> If voltage-ranges specified, then we use it, not capabilities
> register.
> 
> For p4080 it will be 'voltage-ranges = <3200 3400>;'. So, with
> voltage-ranges we can do fine grained VDD control without
> introducing anything new.
why not
               voltage-ranges = <3300 3300>;
?
Roy

