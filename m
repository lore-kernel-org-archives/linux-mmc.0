From: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-pm] [PATCH] Fix the outstanding issue with hangs on insert/removal of mmc cards
Date: Fri, 11 Jun 2010 12:42:47 -0700 (PDT)
Message-ID: <536217.22740.qm@web180312.mail.gq1.yahoo.com>
References: <1276282801.8557.20.camel@maxim-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from n5.bullet.mail.gq1.yahoo.com ([67.195.9.85]:42554 "HELO
	n5.bullet.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1759554Ab0FKTms (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 11 Jun 2010 15:42:48 -0400
In-Reply-To: <1276282801.8557.20.camel@maxim-laptop>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>, Maxim Levitsky <maximlevitsky@gmail.com>
Cc: linux-pm <linux-pm@lists.linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Philip Langdale <philipl@overt.org>



--- On Fri, 6/11/10, Maxim Levitsky <maximlevitsky@gmail.com> wrote:
> After thinking a lot about how to fix properly the hangs
> caused by
> insert/removal of mmc card during suspend/resume, and default behavior
> of not trusting the card persistence over suspend,

Right; there are two types of driver:  ones
that can correctly report whether the card
has been removed ... and ones that can't  That
default behavior presumes the latter. 

The MMC/SD framework doesn't know about these
two types

(For
reference:  the easy way to do the former involves
setting up the GPIO used for card detect as a
(wakeup?) IRQ source.

> First of all there are 2 types of removal possible. First
> one happens
> when system detects that some device is gone. At that point
> there is
> really no point in syncing it.

One suggestion was syncing before suspend...
but that would require coordinating the
block layer and PM framework.  That seems
like it'd be generally a wise thing to do;
no point in losing the write cache, ever.


> The other type of removal is controlled removal, usually on user  request.





