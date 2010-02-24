From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2] Enable DMA for Ricoh reader on Lenovo laptops
Date: Wed, 24 Feb 2010 12:00:38 -0800
Message-ID: <20100224120038.3f0ec412.akpm@linux-foundation.org>
References: <201002011111.13010.anarsoul@gmail.com>
	<1266249504.10662.5.camel@maxim-laptop>
	<201002151820.45110.anarsoul@gmail.com>
	<201002201049.48797.anarsoul@gmail.com>
	<1266704505.3748.6.camel@maxim-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:59629 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757907Ab0BXUAl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 24 Feb 2010 15:00:41 -0500
In-Reply-To: <1266704505.3748.6.camel@maxim-laptop>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: Vasily Khoruzhick <anarsoul@gmail.com>, linux-mmc@vger.kernel.org

On Sun, 21 Feb 2010 00:21:45 +0200 Maxim Levitsky <maximlevitsky@gmail.com> wrote:

> On Sat, 2010-02-20 at 10:49 +0200, Vasily Khoruzhick wrote: 
> > On 15 February 2010 18:20:39 Vasily Khoruzhick wrote:
> > 
> > > We need generic quirk for ricoh readers, see attached patch
> > 
> > Ping :)
> > Any chance to merge this patch? Should I resend it?
> 
> Since mmc system has no maintainer, maybe put that through -mm ?
> 

Yup.

But I'm seeing two patches in this thread, neither of which have useful
changelogs.  Please redo, add a changelog which explains what the
problem was and how the patch fixes it.  Retain cc's, acked-by's,
tested-by's and resend, please.

