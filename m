From: Daniel Drake <dsd@laptop.org>
Subject: Re: "exclude asynchronous transfer" patch causes boot fail
Date: Fri, 14 Jun 2013 15:17:54 -0600
Message-ID: <CAMLZHHRzvXucfoUn9ZqVv7Z9Q8oDbZu5-O9t8dJ=YpSjbbzXHg@mail.gmail.com>
References: <CAMLZHHRt=ajakDx6ZFRVx8CUKNojury5fX8R+gBhhJTOstQ6Xg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f180.google.com ([209.85.216.180]:46985 "EHLO
	mail-qc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751030Ab3FNVR4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 14 Jun 2013 17:17:56 -0400
Received: by mail-qc0-f180.google.com with SMTP id a1so571712qcx.25
        for <linux-mmc@vger.kernel.org>; Fri, 14 Jun 2013 14:17:54 -0700 (PDT)
In-Reply-To: <CAMLZHHRt=ajakDx6ZFRVx8CUKNojury5fX8R+gBhhJTOstQ6Xg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: tgih.jun@samsung.com

On Mon, Jun 10, 2013 at 1:53 PM, Daniel Drake <dsd@laptop.org> wrote:
> Testing the latest linus kernel on OLPC XO-4 (sdhci-pxav3), boot
> fails. Userspace does start, and I see that systemd is starting a few
> services (feels a bit slower than usual), then it hangs still while
> loading initial services - I don't even get to a shell prompt.
>
> git-bisect shows the following commit introduces the problem:
>
> commit 369d321ed1baa7748e770aaaae4d8effad699633
> Author: Seungwon Jeon <tgih.jun@samsung.com>
> Date:   Wed Dec 26 10:40:17 2012 +0900
>
>     mmc: queue: exclude asynchronous transfer for special request

I realised that I wasn't testing linus master as I thought I was - I
was some way back in the history.
Updating to the latest makes the issue go away. I guess this was already fixed.

Thanks
Daniel
