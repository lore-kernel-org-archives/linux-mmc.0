From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: core: Prevent too long response times for suspend
Date: Fri, 21 Oct 2011 00:25:35 -0400
Message-ID: <m2zkgv7yyo.fsf@bob.laptop.org>
References: <1318514638-32452-1-git-send-email-ulf.hansson@stericsson.com>
	<CAKnu2MraxuB=cWme7OkX7k6K6c+1oNQ_+iJrswCw5YU0vjyayw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:33293 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751665Ab1JUEZr (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 21 Oct 2011 00:25:47 -0400
In-Reply-To: <CAKnu2MraxuB=cWme7OkX7k6K6c+1oNQ_+iJrswCw5YU0vjyayw@mail.gmail.com>
	(Linus Walleij's message of "Thu, 20 Oct 2011 00:09:12 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Ulf Hansson <ulf.hansson@stericsson.com>, linux-mmc@vger.kernel.org, Per Forlin <per.forlin@stericsson.com>, Lee Jones <lee.jones@linaro.org>

Hi,

On Wed, Oct 19 2011, Linus Walleij wrote:
>> While trying to suspend the mmc host there could still be
>> ongoing requests that we need to wait for. At the same time
>> a device driver must respond to a suspend request rather quickly.
>>
>> Instead of potentially wait "forever" by claiming the host we now
>> "try" to claim the host instead. If it fails, -EBUSY is returned.
>>
>> Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks very much, Ulf, pushed to mmc-next for 3.2.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
