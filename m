From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: core: Quirk for long data read time
Date: Fri, 11 Nov 2011 21:37:18 -0500
Message-ID: <87sjluhxr5.fsf@laptop.org>
References: <1320309852-21893-1-git-send-email-stefan.xk.nilsson@stericsson.com>
	<CAKnu2Mqr2Vi8f3KkgmQxywucAS9BN4rY-SxSOiFd5oV06sZ12w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:45954 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750809Ab1KLChU (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 11 Nov 2011 21:37:20 -0500
In-Reply-To: <CAKnu2Mqr2Vi8f3KkgmQxywucAS9BN4rY-SxSOiFd5oV06sZ12w@mail.gmail.com>
	(Linus Walleij's message of "Thu, 3 Nov 2011 12:32:06 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Stefan Nilsson XK <stefan.xk.nilsson@stericsson.com>, linux-mmc@vger.kernel.org, Per Forlin <per.forlin@stericsson.com>, Ulf Hansson <ulf.hansson@stericsson.com>

Hi,

On Thu, Nov 03 2011, Linus Walleij wrote:
> 2011/11/3 Stefan Nilsson XK <stefan.xk.nilsson@stericsson.com>:
>
>> Adds a quirk that sets the data read timeout to a fixed value instead
>> of relying on the information in the CSD. The timeout value choosen
>> is 300ms since that has proven enough for the problematic cards found,
>> but could be increased if other cards require this.
>>
>> This patch also enables this quirk for certain Micron cards known to
>> have this problem.
>>
>> Signed-off-by: Stefan Nilsson XK <stefan.xk.nilsson@stericsson.com>
>> Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
>
> And I thought it was enough with *people* who didn't deliver stuff
> they promised in due time, now even *memory cards* miss their
> own promised deadlines.... :-)
>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>
> This should go into stable as well right?

Thanks, pushed to mmc-next for 3.2 with Linus W's ACK and a stable@ tag.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
