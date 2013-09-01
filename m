From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH V2 1/7] mmc: lock: Use the kernel "KEYS" subsystem to get a card's password
Date: Sun, 01 Sep 2013 22:08:17 +0100
Message-ID: <8661ukckse.fsf@void.printf.net>
References: <1377893665-26754-1-git-send-email-alcooperx@gmail.com>
	<1377893665-26754-2-git-send-email-alcooperx@gmail.com>
	<86li3gcr0x.fsf@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:54381 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752286Ab3IAVIT (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 1 Sep 2013 17:08:19 -0400
In-Reply-To: <86li3gcr0x.fsf@void.printf.net> (Chris Ball's message of "Sun,
	01 Sep 2013 19:53:34 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Al Cooper <alcooperx@gmail.com>, linux-mmc@vger.kernel.org, ulf.hansson@linaro.org

Hi,

On Sun, Sep 01 2013, Chris Ball wrote:
>> +config MMC_LOCK
>> +	bool "MMC/SD password based card lock/unlock"
>> +	select KEYS
>> +	help
>> +	  This will add the ability to lock/unlock SD and MMC cards.
>> +
>> +	  If unsure, say N.
>
> Is there a good reason to have this behind a Kconfig entry, rather
> than just enabled for everyone?  I'm happy to just enable it if we
> don't expect any downside.

Well, I guess it's the dependency on the KEYS subsystem.  I can see
that some people would like to build embedded devices with MMC but
without KEYS.  It's a shame to have this code go entirely untested
by most of our users, though..

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
