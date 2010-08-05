From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: MMC: [PATCH 0/2 v2] Two fixes for mmc system
Date: Thu, 5 Aug 2010 15:45:03 -0700
Message-ID: <20100805154503.42599438.akpm@linux-foundation.org>
References: <1280579825-6174-1-git-send-email-maximlevitsky@gmail.com>
	<1281015363.9324.35.camel@maxim-laptop>
	<20100805152219.ae41a175.akpm@linux-foundation.org>
	<1281047979.7148.2.camel@maxim-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:57723 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932934Ab0HEWpk (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Aug 2010 18:45:40 -0400
In-Reply-To: <1281047979.7148.2.camel@maxim-laptop>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: linux-mmc@vger.kernel.org, Lee Jones <lee.jones@canonical.com>, Adrian Hunter <adrian.hunter@nokia.com>

On Fri, 06 Aug 2010 01:39:39 +0300
Maxim Levitsky <maximlevitsky@gmail.com> wrote:

> On Thu, 2010-08-05 at 15:22 -0700, Andrew Morton wrote: 
> > On Thu, 05 Aug 2010 16:36:03 +0300
> > Maxim Levitsky <maximlevitsky@gmail.com> wrote:
> > 
> > > On Sat, 2010-07-31 at 15:37 +0300, Maxim Levitsky wrote: 
> > > > Hi,
> > > > 
> > > > This is resend of these patches.
> > > > Tell me if I don't need to resent the first patch, it doesn't much matter to me.
> > > > 
> > > > The second patch is slightly updated to plug last oportunety for a race.
> > > > Also fixed accident move of EXPORT_SYMBOL.
> > > 
> > > Any update? Comments?
> > > Will I see that upstream?
> > > 
> > 
> > I merged the update to [patch 2/2] two days ago - you should have
> > received the commit email?
> 
> I have seen message about merge to -mm, but I am asking about mainline.
> 

I merge in the second week of the -rc1 merge window.  I'm not presently
aware of any reason why these patches shouldn't be included.

