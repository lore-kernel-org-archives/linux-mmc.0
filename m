From: Bing Zhao <bzhao@marvell.com>
Subject: RE: [patch 077/232] sdio: fix read buffer overflow
Date: Tue, 6 Oct 2009 14:49:12 -0700
Message-ID: <477F20668A386D41ADCC57781B1F704306DDD5C274@SC-VEXCH1.marvell.com>
References: <200909222345.n8MNj9kq013725@imap1.linux-foundation.org>
	<4AC47F84.20806@cam.ac.uk> <4AC48E8E.6030808@csr.com>	<4AC48FA1.409@csr.com>
 <4AC4B899.9000701@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from galiil.marvell.com ([199.203.130.254]:59712 "EHLO
	galiil.marvell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757292AbZJFVzS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 6 Oct 2009 17:55:18 -0400
In-Reply-To: <4AC4B899.9000701@cam.ac.uk>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jonathan Cameron <jic23@cam.ac.uk>, David Vrabel <david.vrabel@csr.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "roel.kluin@gmail.com" <roel.kluin@gmail.com>, "libertas-dev@lists.infradead.org" <libertas-dev@lists.infradead.org>

Hi,

> -----Original Message-----
> From: libertas-dev-bounces@lists.infradead.org [mailto:libertas-dev-bounces@lists.infradead.org] On
> Behalf Of Jonathan Cameron
> Sent: Thursday, October 01, 2009 7:12 AM
> To: David Vrabel
> Cc: linux-mmc@vger.kernel.org; akpm@linux-foundation.org; roel.kluin@gmail.com; libertas-
> dev@lists.infradead.org
> Subject: Re: [patch 077/232] sdio: fix read buffer overflow
> 
> David Vrabel wrote:
> > David Vrabel wrote:
> >> It's harmless if the tuple contains fewer so I think we should just try
> >> and parse as many strings as possible.  Does this patch fix your regression?
> >
> > I spelt the field name wrong in the comment.  Use this patch instead,
> > please.
> Works for me, so Tested-by: Jonathan Cameron <jic23@cam.ac.uk>
> 
> I guess it's just a question of posting it as a normal patch and seeing if
> anyone screams.

This patch works for me too.

Tested-by: Bing Zhao <bzhao@marvell.com>

Thanks,

Bing

> 
> Thanks,
> 
> Jonathan
> 
> _______________________________________________
> libertas-dev mailing list
> libertas-dev@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/libertas-dev
