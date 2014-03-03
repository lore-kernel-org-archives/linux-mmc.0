From: Jon Ringle <jonringle@gmail.com>
Subject: Re: wait_for_completion in mmc_wait_for_req_done never returns
Date: Mon, 3 Mar 2014 01:32:05 -0500
Message-ID: <CAMwGMjyEWoiTcT6C_7oYFRQfa-x0BMLnhWNmQ31aJHyoCiS9og@mail.gmail.com>
References: <8272F2D9-5168-421C-93F4-E4FE6FFA5E23@gmail.com>
Reply-To: jon@ringle.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f48.google.com ([209.85.215.48]:40218 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750987AbaCCGcH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 3 Mar 2014 01:32:07 -0500
Received: by mail-la0-f48.google.com with SMTP id gf5so4332189lab.35
        for <linux-mmc@vger.kernel.org>; Sun, 02 Mar 2014 22:32:05 -0800 (PST)
In-Reply-To: <8272F2D9-5168-421C-93F4-E4FE6FFA5E23@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: "schwidefsky@de.ibm.com" <schwidefsky@de.ibm.com>

My apologizes for the noise. I had a buggy bisect run script. The
mentioned commit here is not the source of the problem I am
encountering.

Jon

On Sat, Mar 1, 2014 at 11:10 AM, Jon Ringle <jonringle@gmail.com> wrote:
> I'm porting an arm board from linux-3.10 to linux-3.12 and found that I can no longer detect the SD card. I found that the wait_for_completion(&mrq->completion) in drivers/mmc/core/core.c:mmc_wait_for_req_done() is never returning.
>
> I was able to bisect the problem to this commit:
>   0244ad004a54e39308d495fee0a2e637f8b5c317 is the first bad commit
>   commit 0244ad004a54e39308d495fee0a2e637f8b5c317
>   Author: Martin Schwidefsky <schwidefsky@de.ibm.com>
>   Date:   Fri Aug 30 09:39:53 2013 +0200
>
>   Remove GENERIC_HARDIRQ config option
>
>   After the last architecture switched to generic hard irqs the config
>   options HAVE_GENERIC_HARDIRQS & GENERIC_HARDIRQS and the related code
>   for !CONFIG_GENERIC_HARDIRQS can be removed.
>
>   Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
>
> I'm not sure what I should do to fix the problem. Does anyone have any suggestions?
>
> Thanks,
> Jon Ringle
