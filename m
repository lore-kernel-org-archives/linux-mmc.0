From: Jon Ringle <jonringle@gmail.com>
Subject: Re: wait_for_completion in mmc_wait_for_req_done never returns
Date: Thu, 1 May 2014 12:28:25 -0400
Message-ID: <CAMwGMjwQyDX2HEUNM0wnMZVN5sULKveF50bQEtKMTf6h3r4FMA@mail.gmail.com>
References: <8D4F0053-96FB-4ED3-B224-275E3CDDCFBC@gmail.com>
	<536252CD.3000400@codeaurora.org>
Reply-To: jon@ringle.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f45.google.com ([209.85.215.45]:65106 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751337AbaEAQ21 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 1 May 2014 12:28:27 -0400
Received: by mail-la0-f45.google.com with SMTP id pv20so2339985lab.32
        for <linux-mmc@vger.kernel.org>; Thu, 01 May 2014 09:28:25 -0700 (PDT)
In-Reply-To: <536252CD.3000400@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Konstantin Dorfman <kdorfman@codeaurora.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "schwidefsky@de.ibm.com" <schwidefsky@de.ibm.com>

On Thu, May 1, 2014 at 9:57 AM, Konstantin Dorfman
<kdorfman@codeaurora.org> wrote:
> On 03/01/14 18:03, Jon Ringle wrote:
>>
>> I'm porting an arm board from linux-3.10 to linux-3.12 and found that I
>> can no longer detect the SD card. I found that the
>> wait_for_completion(&mrq->completion) in
>> drivers/mmc/core/core.c:mmc_wait_for_req_done() is never returning.
>
>
> Can you post relevant kernel log file, so I'll try to understand the flow?
> What command is not getting completed? I suppose it is not data command.

This issue was caused by a bug in drivers/dma/edma.c and has already
been fixed in
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=5fc68a6cad658e45dca3e0a6607df3a8e5df4ef9

Jon
