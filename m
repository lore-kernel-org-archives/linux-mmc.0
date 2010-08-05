From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: MMC: [PATCH 0/2 v2] Two fixes for mmc system
Date: Thu, 5 Aug 2010 15:22:19 -0700
Message-ID: <20100805152219.ae41a175.akpm@linux-foundation.org>
References: <1280579825-6174-1-git-send-email-maximlevitsky@gmail.com>
	<1281015363.9324.35.camel@maxim-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:47404 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758231Ab0HEWW6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Aug 2010 18:22:58 -0400
In-Reply-To: <1281015363.9324.35.camel@maxim-laptop>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: linux-mmc@vger.kernel.org, Lee Jones <lee.jones@canonical.com>, Adrian Hunter <adrian.hunter@nokia.com>

On Thu, 05 Aug 2010 16:36:03 +0300
Maxim Levitsky <maximlevitsky@gmail.com> wrote:

> On Sat, 2010-07-31 at 15:37 +0300, Maxim Levitsky wrote: 
> > Hi,
> > 
> > This is resend of these patches.
> > Tell me if I don't need to resent the first patch, it doesn't much matter to me.
> > 
> > The second patch is slightly updated to plug last oportunety for a race.
> > Also fixed accident move of EXPORT_SYMBOL.
> 
> Any update? Comments?
> Will I see that upstream?
> 

I merged the update to [patch 2/2] two days ago - you should have
received the commit email?

