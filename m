From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: atmel-mci causing oops?
Date: Mon, 27 Feb 2012 12:28:16 +0900
Message-ID: <003801ccf4ff$d821bfb0$88653f10$%jun@samsung.com>
References: <201202270949.23934.me@danielpalmer.co.uk>
 <003401ccf4ef$67e3b880$37ab2980$%jun@samsung.com>
 <201202271057.28579.me@danielpalmer.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:45687 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753367Ab2B0D2S (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 26 Feb 2012 22:28:18 -0500
Received: from epcpsbgm1.samsung.com (mailout4.samsung.com [203.254.224.34])
 by mailout4.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0M0100H8Q8B4ABI0@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 27 Feb 2012 12:28:16 +0900 (KST)
Received: from DOTGIHJUN01 ([12.23.118.161])
 by mmp2.samsung.com (Oracle Communications Messaging Exchange Server 7u4-19.01
 64bit (built Sep  7 2010)) with ESMTPA id <0M0100AZQ8B4YJC0@mmp2.samsung.com>
 for linux-mmc@vger.kernel.org; Mon, 27 Feb 2012 12:28:16 +0900 (KST)
In-reply-to: <201202271057.28579.me@danielpalmer.co.uk>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Daniel Palmer' <me@danielpalmer.co.uk>
Cc: linux-mmc@vger.kernel.org

Daniel Palmer <me@danielpalmer.co.uk> wrote:
> On Monday, February 27, 2012 10:30:35 AM Seungwon Jeon wrote:
> > Hi.
> >
> > CONFIG_HIGHMEM is enabled in 3.3rc5?
> > I think your problem is similar to the following commit.
> > "mmc: dw_mmc: Fix PIO mode with support of highmem"(fc66a7bb13806c0)
> >
> 
> Hi,
> 
> Thank you for your input. CONFIG_HIGHMEM isn't enabled, but CONFIG_SPARSEMEM
> is (The SAM9G45 has two banks of RAM with a hole in the middle). Could that be
> an issue? Without it I can only access 128MB of 256MB of RAM, but I can test
> if it works.
I'm not sure.
Is there any trace information of kernel?

Thanks,
Seungwon Jeon.

> 
> Cheers,
> 
> Daniel
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

