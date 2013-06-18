From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: "exclude asynchronous transfer" patch causes boot fail
Date: Tue, 18 Jun 2013 21:33:45 +0900
Message-ID: <001701ce6c20$134cda00$39e68e00$%jun@samsung.com>
References: <CAMLZHHRt=ajakDx6ZFRVx8CUKNojury5fX8R+gBhhJTOstQ6Xg@mail.gmail.com>
 <CAMLZHHRzvXucfoUn9ZqVv7Z9Q8oDbZu5-O9t8dJ=YpSjbbzXHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:43410 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932160Ab3FRMdr (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Jun 2013 08:33:47 -0400
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MOL00GWY9KAIED0@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 18 Jun 2013 21:33:46 +0900 (KST)
In-reply-to: <CAMLZHHRzvXucfoUn9ZqVv7Z9Q8oDbZu5-O9t8dJ=YpSjbbzXHg@mail.gmail.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Daniel Drake' <dsd@laptop.org>, linux-mmc@vger.kernel.org

On Saturday, June 15, 2013, Daniel Drake wrote:
> On Mon, Jun 10, 2013 at 1:53 PM, Daniel Drake <dsd@laptop.org> wrote:
> > Testing the latest linus kernel on OLPC XO-4 (sdhci-pxav3), boot
> > fails. Userspace does start, and I see that systemd is starting a few
> > services (feels a bit slower than usual), then it hangs still while
> > loading initial services - I don't even get to a shell prompt.
> >
> > git-bisect shows the following commit introduces the problem:
> >
> > commit 369d321ed1baa7748e770aaaae4d8effad699633
> > Author: Seungwon Jeon <tgih.jun@samsung.com>
> > Date:   Wed Dec 26 10:40:17 2012 +0900
> >
> >     mmc: queue: exclude asynchronous transfer for special request
> 
> I realised that I wasn't testing linus master as I thought I was - I
> was some way back in the history.
> Updating to the latest makes the issue go away. I guess this was already fixed.
Okay.
For reference, there is no difference with between REQ_DISCARD and REG_FLUSH
in mmc_blk_issue_rq()'s handling.

Thanks,
Seungwon Jeon
> 
> Thanks
> Daniel

