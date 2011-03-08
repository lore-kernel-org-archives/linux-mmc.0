From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: export function mmc_do_release_host
Date: Tue, 08 Mar 2011 14:40:07 -0500
Message-ID: <m3aah5qu3s.fsf@pullcord.laptop.org>
References: <1299330464-12938-1-git-send-email-linus.walleij@stericsson.com>
	<AANLkTikrxkc59kp3O=JwPcv9gtQ59odNiQWhBHkoQ=cU@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:51807 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752374Ab1CHTmT (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 8 Mar 2011 14:42:19 -0500
In-Reply-To: <AANLkTikrxkc59kp3O=JwPcv9gtQ59odNiQWhBHkoQ=cU@mail.gmail.com>
	(Linus Walleij's message of "Tue, 8 Mar 2011 20:20:52 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-mmc@vger.kernel.org

Hi Linus,

On Tue, Mar 08 2011, Linus Walleij wrote:
> 2011/3/5 Linus Walleij <linus.walleij@stericsson.com>:
>
>> From: Ulf Hansson <ulf.hansson@stericsson.com>
>>
>> When using mmc_try_claim_host the corresponding release
>> function is mmc_do_release_host, which then also must
>> be exported.
>
> Is this one OK Chris? Not much said about it but looks
> harmless to me...

Yes, they're both in my queue and look reasonable to me; I'm just giving
people a chance to comment on them (it's only been one full business day
since these were submitted!) before merging.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
