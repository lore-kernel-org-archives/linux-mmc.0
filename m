From: Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [patch 077/232] sdio: fix read buffer overflow
Date: Thu, 01 Oct 2009 15:11:37 +0100
Message-ID: <4AC4B899.9000701@cam.ac.uk>
References: <200909222345.n8MNj9kq013725@imap1.linux-foundation.org> <4AC47F84.20806@cam.ac.uk> <4AC48E8E.6030808@csr.com> <4AC48FA1.409@csr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ppsw-7.csi.cam.ac.uk ([131.111.8.137]:51337 "EHLO
	ppsw-7.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932542AbZJAOfI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Oct 2009 10:35:08 -0400
In-Reply-To: <4AC48FA1.409@csr.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: David Vrabel <david.vrabel@csr.com>
Cc: akpm@linux-foundation.org, roel.kluin@gmail.com, linux-mmc@vger.kernel.org, "libertas-dev@lists.infradead.org" <libertas-dev@lists.infradead.org>

David Vrabel wrote:
> David Vrabel wrote:
>> It's harmless if the tuple contains fewer so I think we should just try
>> and parse as many strings as possible.  Does this patch fix your regression?
> 
> I spelt the field name wrong in the comment.  Use this patch instead,
> please.
Works for me, so Tested-by: Jonathan Cameron <jic23@cam.ac.uk>

I guess it's just a question of posting it as a normal patch and seeing if
anyone screams.

Thanks,

Jonathan
