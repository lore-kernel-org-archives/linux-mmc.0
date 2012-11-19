From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: Standardise capability type
Date: Mon, 19 Nov 2012 06:58:03 -0500
Message-ID: <87mwydhkj8.fsf@octavius.laptop.org>
References: <1352896551-17948-1-git-send-email-lee.jones@linaro.org>
	<87haon99py.fsf@octavius.laptop.org> <20121119092725.GA553@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:55990 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751799Ab2KSL6N (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 19 Nov 2012 06:58:13 -0500
In-Reply-To: <20121119092725.GA553@gmail.com> (Lee Jones's message of "Mon, 19
	Nov 2012 09:27:25 +0000")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, arnd@arndb.de, linus.walleij@stericsson.com, linux-mmc@vger.kernel.org

Hi,

On Mon, Nov 19 2012, Lee Jones wrote:
>> > There are discrepancies with regards to how MMC capabilities
>> > are carried throughout the subsystem. Let's standardise them
>> > to elevate any confusion.
>> 
>> I think you meant "eliminate" here.  :)  Thanks,
>
> No, I meant alleviate. :)
>
> Do you want me to re-submit, or have you fixed up?

I already pushed with a change to "eliminate" -- I'll leave it like
that if that's okay.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
