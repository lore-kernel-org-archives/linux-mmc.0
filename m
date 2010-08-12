From: Zang Roy-R61911 <r61911@freescale.com>
Subject: RE: [PATCH 1/2] mmc: change ACMD12 to AUTO_CMD12 for more clear
Date: Thu, 12 Aug 2010 12:00:29 +0800
Message-ID: <3850A844E6A3854C827AC5C0BEC7B60A0565B8@zch01exm23.fsl.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe006.messaging.microsoft.com ([216.32.180.16]:18916
	"EHLO VA3EHSOBE009.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750731Ab0HLEA4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 12 Aug 2010 00:00:56 -0400
Received: from mail120-va3 (localhost.localdomain [127.0.0.1])	by
 mail120-va3-R.bigfish.com (Postfix) with ESMTP id E2B5F14B01B2	for
 <linux-mmc@vger.kernel.org>; Thu, 12 Aug 2010 04:00:55 +0000 (UTC)
Received: from VA3EHSMHS020.bigfish.com (unknown [10.7.14.245])	by
 mail120-va3.bigfish.com (Postfix) with ESMTP id 621DD5D004C	for
 <linux-mmc@vger.kernel.org>; Thu, 12 Aug 2010 04:00:55 +0000 (UTC)
Received: from az33smr02.freescale.net (az33smr02.freescale.net
 [10.64.34.200])	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP id
 o7C40WjU002675	for <linux-mmc@vger.kernel.org>; Wed, 11 Aug 2010 21:00:46
 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
 [10.192.129.207])	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id
 o7C40bP2006597	for <linux-mmc@vger.kernel.org>; Wed, 11 Aug 2010 23:00:37
 -0500 (CDT)
Content-Class: urn:content-classes:message
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zang Roy-R61911 <R61911@freescale.com>, akpm@linux-foundation.org, linux-mmc@vger.kernel.org
Cc: linuxppc-dev@ozlabs.org, mirqus@gmail.com, cbouatmailru@gmail.com, grant.likely@secretlab.ca, Kumar Gala <galak@kernel.crashing.org>

 

> -----Original Message-----
> From: Zang Roy-R61911 
> Sent: Wednesday, August 11, 2010 12:47 PM
> To: Zang Roy-R61911; akpm@linux-foundation.org; 
> linux-mmc@vger.kernel.org
> Cc: linuxppc-dev@ozlabs.org; mirqus@gmail.com; 
> cbouatmailru@gmail.com; grant.likely@secretlab.ca
> Subject: RE: [PATCH 1/2] mmc: change ACMD12 to AUTO_CMD12 for 
> more clear
> 
>  
> 
> > -----Original Message-----
> > From: Zang Roy-R61911 
> > Sent: Tuesday, August 10, 2010 17:47 PM
> > To: akpm@linux-foundation.org; linux-mmc@vger.kernel.org
> > Cc: linuxppc-dev@ozlabs.org; mirqus@gmail.com; 
> > cbouatmailru@gmail.com; grant.likely@secretlab.ca
> > Subject: [PATCH 1/2] mmc: change ACMD12 to AUTO_CMD12 for more clear
> > 
> > Change ACMD12 to AUTO_CMD12 to reduce the confusion.
> > ACMD12 might be confused with MMC/SD App CMD 12 (CMD55+CMD12 combo).
> > 
> > Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
> > ---
> >  drivers/mmc/host/sdhci-of-core.c |    2 +-
> >  drivers/mmc/host/sdhci.c         |    8 ++++----
> >  drivers/mmc/host/sdhci.h         |   10 +++++-----
> >  3 files changed, 10 insertions(+), 10 deletions(-)
> Andrew, 
> Could you help to pick up this minor fix?
> Thanks.
> Roy
Any update?
Thanks.
Roy

