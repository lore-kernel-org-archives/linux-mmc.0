From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [PATCH 2/7] mmc: Don't use PF_MEMALLOC
Date: Tue, 17 Nov 2009 11:38:02 +0100
Message-ID: <200911171138.02458.oliver@neukum.org>
References: <20091117161551.3DD4.A69D9226@jp.fujitsu.com> <20091117102903.7cb45ff3@lxorguk.ukuu.org.uk> <28c262360911170232i307144cnb4ddea2a5389bd8e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp-out003.kontent.com ([81.88.40.217]:35833 "EHLO
	smtp-out003.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753150AbZKQKh7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Nov 2009 05:37:59 -0500
In-Reply-To: <28c262360911170232i307144cnb4ddea2a5389bd8e@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Minchan Kim <minchan.kim@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>, LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, linux-mmc@vger.kernel.org

Am Dienstag, 17. November 2009 11:32:36 schrieb Minchan Kim:
> On Tue, Nov 17, 2009 at 7:29 PM, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > On Tue, 17 Nov 2009 16:17:50 +0900 (JST)
> >
> > KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com> wrote:
> >> Non MM subsystem must not use PF_MEMALLOC. Memory reclaim need few
> >> memory, anyone must not prevent it. Otherwise the system cause
> >> mysterious hang-up and/or OOM Killer invokation.
> >
> > So now what happens if we are paging and all our memory is tied up for
> > writeback to a device or CIFS etc which can no longer allocate the memory
> > to complete the write out so the MM can reclaim ?
> >
> > Am I missing something or is this patch set not addressing the case where
> > the writeback thread needs to inherit PF_MEMALLOC somehow (at least for
> > the I/O in question and those blocking it)
> 
> I agree.
> At least, drivers for writeout is proper for using PF_MEMALLOC, I think.

For the same reason error handling should also use it, shouldn't it?

	Regards
		Oliver
