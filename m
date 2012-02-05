From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: block: Init sysfs attr to fix lockdep warnings
Date: Sat, 04 Feb 2012 21:54:23 -0500
Message-ID: <m2ipjm6lcw.fsf@bob.laptop.org>
References: <1328110316-7593-1-git-send-email-ulf.hansson@stericsson.com>
	<CACRpkdZ5f3rBOkAW-UsrnfjWYkPPVvb3pJCuJiozL7Jso2RCrg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:51900 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754609Ab2BECyc (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 4 Feb 2012 21:54:32 -0500
In-Reply-To: <CACRpkdZ5f3rBOkAW-UsrnfjWYkPPVvb3pJCuJiozL7Jso2RCrg@mail.gmail.com>
	(Linus Walleij's message of "Wed, 1 Feb 2012 21:22:09 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Ulf Hansson <ulf.hansson@stericsson.com>, linux-mmc@vger.kernel.org, Per Forlin <per.forlin@stericsson.com>, Johan Rudholm <johan.rudholm@stericsson.com>, Lee Jones <lee.jones@linaro.org>, Rabin Vincent <rabin.vincent@stericsson.com>

Hi,

On Wed, Feb 01 2012, Linus Walleij wrote:
> On Wed, Feb 1, 2012 at 4:31 PM, Ulf Hansson <ulf.hansson@stericsson.com> wrote:
>
>> From: Rabin Vincent <rabin.vincent@stericsson.com>
>>
>> Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
>> Signed-off-by: Johan Rudholm <johan.rudholm@stericsson.com>
>> Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>
> This looks like it should go into stable, Chris will you add
> Cc: stable@kernel.org to this if/when you apply it?

Thanks, pushed to mmc-next for 3.3.

(Linus, the ro_lock support was added in 3.3-rc1, so there's no need for
stable@ here.)

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
