From: Zang Roy-R61911 <r61911@freescale.com>
Subject: RE: [PATCH 1/2] mmc: change ACMD12 to AUTO_CMD12 for more clear
Date: Tue, 17 Aug 2010 14:48:28 +0800
Message-ID: <3850A844E6A3854C827AC5C0BEC7B60A07C66F@zch01exm23.fsl.freescale.net>
References: <3850A844E6A3854C827AC5C0BEC7B60A056400@zch01exm23.fsl.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe003.messaging.microsoft.com ([65.55.88.13]:37691 "EHLO
	TX2EHSOBE005.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755996Ab0HQGsy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Aug 2010 02:48:54 -0400
Received: from mail154-tx2 (localhost.localdomain [127.0.0.1])	by
 mail154-tx2-R.bigfish.com (Postfix) with ESMTP id 9DABDDC81A9	for
 <linux-mmc@vger.kernel.org>; Tue, 17 Aug 2010 06:48:53 +0000 (UTC)
Received: from TX2EHSMHS013.bigfish.com (unknown [10.9.14.246])	by
 mail154-tx2.bigfish.com (Postfix) with ESMTP id 6F4AA1070050	for
 <linux-mmc@vger.kernel.org>; Tue, 17 Aug 2010 06:48:53 +0000 (UTC)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP id o7H6mX9j004516	for
 <linux-mmc@vger.kernel.org>; Mon, 16 Aug 2010 23:48:43 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
 [10.192.129.207])	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id
 o7H72eaS018498	for <linux-mmc@vger.kernel.org>; Tue, 17 Aug 2010 02:02:41
 -0500 (CDT)
Content-Class: urn:content-classes:message
In-Reply-To: <3850A844E6A3854C827AC5C0BEC7B60A056400@zch01exm23.fsl.freescale.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zang Roy-R61911 <R61911@freescale.com>, akpm@linux-foundation.org, linux-mmc@vger.kernel.org
Cc: linuxppc-dev@ozlabs.org, mirqus@gmail.com, cbouatmailru@gmail.com, grant.likely@secretlab.ca

 

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
Any update on these two patches?
Thanks.
Roy

