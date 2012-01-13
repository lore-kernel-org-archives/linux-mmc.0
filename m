From: Anton Vorontsov <cbouatmailru@gmail.com>
Subject: Re: [PATCH 1/5 v2] ESDHC: add PIO mode support
Date: Fri, 13 Jan 2012 15:56:00 +0400
Message-ID: <20120113115600.GD8837@oksana.dev.rtsoft.ru>
References: <1325827997-27490-1-git-send-email-r66093@freescale.com>
 <1325827997-27490-2-git-send-email-r66093@freescale.com>
 <8A2FC72B45BB5A4C9F801431E06AE48F11669338@039-SN1MPN1-005.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:33854 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751683Ab2AML4E (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 13 Jan 2012 06:56:04 -0500
Received: by bkvi17 with SMTP id i17so1969719bkv.19
        for <linux-mmc@vger.kernel.org>; Fri, 13 Jan 2012 03:56:03 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <8A2FC72B45BB5A4C9F801431E06AE48F11669338@039-SN1MPN1-005.039d.mgd.msft.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Huang Changming-R66093 <r66093@freescale.com>
Cc: Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Fri, Jan 13, 2012 at 02:35:57AM +0000, Huang Changming-R66093 wrote:
> Hi, Anton,
> Could you have any comment about this serial patch?

Acked-by: Anton Vorontsov <cbouatmailru@gmail.com>

Thanks!

> Thanks
> Jerry Huang
> > -----Original Message-----
> > From: Huang Changming-R66093
> > Sent: Friday, January 06, 2012 1:33 PM
> > To: linux-mmc@vger.kernel.org
> > Cc: Huang Changming-R66093; Gao Guanhua-B22826; Chris Ball
> > Subject: [PATCH 1/5 v2] ESDHC: add PIO mode support
> > 
> > From: Jerry Huang <Chang-Ming.Huang@freescale.com>
> > 
> > For some FSL ESDHC controller(e.g. P2020E, Rev1.0), the SDHC can not work
> > on DMA mode because of the hardware bug, so we set a broken dma flag and
> > use PIO mode.
> > 
> > Signed-off-by: Gao Guanhua <B22826@freescale.com>
> > Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
> > CC: Chris Ball <cjb@laptop.org>
> > ---

-- 
Anton Vorontsov
Email: cbouatmailru@gmail.com
