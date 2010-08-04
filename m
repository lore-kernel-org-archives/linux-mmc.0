From: Zang Roy-R61911 <r61911@freescale.com>
Subject: RE: [PATCH 1/3 v2] sdhci: Add auto CMD12 support for eSDHC driver
Date: Wed, 4 Aug 2010 10:57:00 +0800
Message-ID: <83024545B35D6445A690EFD603E7869A07EFE1@zch01exm23.fsl.freescale.net>
References: <20100803164346.69a63557.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe002.messaging.microsoft.com ([65.55.88.12]:41933 "EHLO
	TX2EHSOBE004.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758199Ab0HDC5G convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 3 Aug 2010 22:57:06 -0400
Received: from mail41-tx2 (localhost.localdomain [127.0.0.1])	by
 mail41-tx2-R.bigfish.com (Postfix) with ESMTP id 7DF0FB0357	for
 <linux-mmc@vger.kernel.org>; Wed,  4 Aug 2010 02:57:05 +0000 (UTC)
Received: from TX2EHSMHS038.bigfish.com (unknown [10.9.14.249])	by
 mail41-tx2.bigfish.com (Postfix) with ESMTP id 49F0415D004F	for
 <linux-mmc@vger.kernel.org>; Wed,  4 Aug 2010 02:57:05 +0000 (UTC)
Received: from az33smr02.freescale.net (az33smr02.freescale.net
 [10.64.34.200])	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP id
 o742v3t7006447	for <linux-mmc@vger.kernel.org>; Tue, 3 Aug 2010 19:57:03
 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
 [10.192.129.207])	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id
 o742v8m4022880	for <linux-mmc@vger.kernel.org>; Tue, 3 Aug 2010 21:57:08
 -0500 (CDT)
Content-Class: urn:content-classes:message
In-Reply-To: <20100803164346.69a63557.akpm@linux-foundation.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mmc@vger.kernel.org, linuxppc-dev@ozlabs.org

 

> -----Original Message-----
> From: Andrew Morton [mailto:akpm@linux-foundation.org] 
> Sent: Wednesday, August 04, 2010 7:44 AM
> To: Zang Roy-R61911
> Cc: linux-mmc@vger.kernel.org; linuxppc-dev@ozlabs.org
> Subject: Re: [PATCH 1/3 v2] sdhci: Add auto CMD12 support for 
> eSDHC driver
> 
> On Tue, 3 Aug 2010 11:11:10 +0800
> Roy Zang <tie-fei.zang@freescale.com> wrote:
> 
> > --- a/drivers/mmc/host/sdhci.h
> > +++ b/drivers/mmc/host/sdhci.h
> > @@ -240,6 +240,8 @@ struct sdhci_host {
> >  #define SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN		(1<<25)
> >  /* Controller cannot support End Attribute in NOP ADMA 
> descriptor */
> >  #define SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC		(1<<26)
> > +/* Controller uses Auto CMD12 command to stop the transfer */
> > +#define SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12		(1<<27)
> 
> This becomes 1<<29 in my tree.
It also works.
> 
> We're about to run out.  
:-(
>What happens then?
Rewrite the code to extend some bits, I suppose.
Roy

