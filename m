From: Grant Grundler <grundler@google.com>
Subject: Re: [PATCH] mmc: block: Add new ioctl to send multi commands
Date: Thu, 10 Sep 2015 10:10:52 -0700
Message-ID: <CANEJEGsMM8c4fmSaZDzL59re99aNJk_qjo-10_UoD7josA6MDg@mail.gmail.com>
References: <1441811161-18513-1-git-send-email-jonathanh@nvidia.com>
	<1481090.IIYrKtDeR0@wuerfel>
	<55F06206.9040001@nvidia.com>
	<3546402.HsxrhMD6nc@wuerfel>
	<55F13E33.9000703@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f177.google.com ([209.85.160.177]:32971 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751464AbbIJRKx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 10 Sep 2015 13:10:53 -0400
Received: by ykei199 with SMTP id i199so64755422yke.0
        for <linux-mmc@vger.kernel.org>; Thu, 10 Sep 2015 10:10:52 -0700 (PDT)
In-Reply-To: <55F13E33.9000703@nvidia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Ulf Hansson <ulf.hansson@linaro.org>, Olof Johansson <olofj@chromium.org>, Seshagiri Holi <sholi@nvidia.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Thu, Sep 10, 2015 at 1:24 AM, Jon Hunter <jonathanh@nvidia.com> wrote:
...
>> - you have some implicit padding after the structure and should replace that
>>   with explictit pad bytes to extend the structure to a multiple of its
>>   alignment (8 bytes).
>
> Would padding with __u32 at the end be sufficient here? I assume the
> __u32 would be 32-bit aligned. However, was not sure if this would
> always be the case.

Is there something wrong with implicit padding?
Only one copy of the structure is passed to the kernel for any given call.

>>>> struct mmc_ioc_multi_cmd {
>>>>     __u64 num_of_cmds;
>>>>     struct mmc_ioc_cmd cmds[0];
>>>> };

I think this would work just as well. But doesn't "pointer to an
array" require 32-bit ioctl compat handling?
We were trying to avoid a 32-bit user space compatibility handler.

>>>> as I said, both are ugly. My first choice would have been the other one,
>>>> but I'm sure you have some reasons yourself.

Why do you prefer the alternative you proposed?

My guess is better type checking (and I would like that too). But
maybe there is something else?

cheers,
grant
