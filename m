From: NamJae Jeon <linkinjeon@gmail.com>
Subject: Re: RFC : mmc : Use wait_for_completion_timeout() instead of
 wait_for_completion in case of multiple write blocks.
Date: Mon, 5 Sep 2011 09:30:05 +0900
Message-ID: <CAKYAXd-3NVWhU73cri5bj8aT7hGLEVZC9EMX6dshLp6o40acnw@mail.gmail.com>
References: <CAKYAXd_QrgHHdiev-Vxt=FrwkJg-3qfjxzqkPmgLbwZ=U4358Q@mail.gmail.com>
	<CACRpkdYkk+W98RoCCwRWXyF+_1_H9gujxHLCPnqtPMn401fZvg@mail.gmail.com>
	<CAKYAXd8VUAZ1gL-MZx7y6+nORJ4m2U+SFyzF2duB-9NUcbqBQw@mail.gmail.com>
	<CAKnu2Mq=4Y=hiv-R7PvPyYCYmo9enu6_FPcoT089LxSa=_xMhw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:41074 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753570Ab1IEAaG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 4 Sep 2011 20:30:06 -0400
In-Reply-To: <CAKnu2Mq=4Y=hiv-R7PvPyYCYmo9enu6_FPcoT089LxSa=_xMhw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Chris Ball <cjb@laptop.org>, Kyungmin Park <kmpark@infradead.org>, Sebastian Rasmussen <Sebastian.Rasmussen@stericsson.com>, Ulf Hansson <Ulf.Hansson@stericsson.com>

2011/9/4 Linus Walleij <linus.walleij@linaro.org>:
> 2011/9/2 NamJae Jeon <linkinjeon@gmail.com>:
>
>> We should consider DMA situation. As I know, host controller can not
>> rise timeout interrupt in write not read in DMA status.
>
> Which host controller are you talking about?
As I know, this controller is using on many ARM core. I can not
disclose the information in my situation.

>
>> host
>> controller can just know whether card is finish to program to use busy
>> line. If unstable card is holding busy line while writing using DMA,
>> hang problem will happen by wait_for_completion.
>> so I think that mmc driver need some exception to avoid this problem.
>
> Yes you can add a timeout in the driver itself. Just set up
> a common timer, no big deal.
>
> Yours,
> Linus Walleij
>

I didn't decide, how much timeout should I add ? first, I think that I
try to add timeout_ns * the number of blocks. but If timeout_ns is 1.6
sec and the number of blocks is 512, the timeout will be very long. or
If I just add 10*HZ(10 sec), Is it proper ?
Would you advise more for me ?

Thanks.
