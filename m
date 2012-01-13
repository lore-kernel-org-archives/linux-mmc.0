From: Anton Vorontsov <cbouatmailru@gmail.com>
Subject: Re: [PATCH 3/5 v4] ESDHC: Power management for ESDHC
Date: Fri, 13 Jan 2012 15:50:13 +0400
Message-ID: <20120113115013.GB8837@oksana.dev.rtsoft.ru>
References: <1325827997-27490-1-git-send-email-r66093@freescale.com>
 <1325827997-27490-2-git-send-email-r66093@freescale.com>
 <1325827997-27490-3-git-send-email-r66093@freescale.com>
 <1325827997-27490-4-git-send-email-r66093@freescale.com>
 <8A2FC72B45BB5A4C9F801431E06AE48F11669367@039-SN1MPN1-005.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:55176 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757967Ab2AMLuR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 13 Jan 2012 06:50:17 -0500
Received: by bkvi17 with SMTP id i17so1966247bkv.19
        for <linux-mmc@vger.kernel.org>; Fri, 13 Jan 2012 03:50:16 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <8A2FC72B45BB5A4C9F801431E06AE48F11669367@039-SN1MPN1-005.039d.mgd.msft.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Huang Changming-R66093 <r66093@freescale.com>
Cc: Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Fri, Jan 13, 2012 at 02:36:50AM +0000, Huang Changming-R66093 wrote:
> Hi, Anton,
> Could you have any comment about this serial patch?

On this one,

Acked-by: Anton Vorontsov <cbouatmailru@gmail.com>

Thanks,

> Thanks
> Jerry Huang
> 
> > -----Original Message-----
> > From: Huang Changming-R66093
> > Sent: Friday, January 06, 2012 1:33 PM
> > To: linux-mmc@vger.kernel.org
> > Cc: Huang Changming-R66093; Jiang Yutang-B14898; Chris Ball
> > Subject: [PATCH 3/5 v4] ESDHC: Power management for ESDHC
> > 
> > From: Jerry Huang <Chang-Ming.Huang@freescale.com>
> > 
> > For FSL ESDHC controllor, when enter the sleep, the controller will power
> > off,
> > therefore the register will lost its valuse, and driver should save value
> > of
> > register during suspend and used during resume.
> > 
> > Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
> > Signed-off-by: Jiang Yutang <b14898@freescale.com>
> > CC: Chris Ball <cjb@laptop.org>

-- 
Anton Vorontsov
Email: cbouatmailru@gmail.com
