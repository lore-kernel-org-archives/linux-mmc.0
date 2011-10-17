From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH V8] mmc: core: Add Power Off Notify Feature eMMC 4.5
Date: Mon, 17 Oct 2011 08:47:14 -0400
Message-ID: <m262jn944t.fsf@bob.laptop.org>
References: <1318487656-8566-1-git-send-email-girish.shivananjappa@linaro.org>
	<m2lisofsov.fsf@bob.laptop.org>
	<CAGxe1ZHgHMEzBq=eDiPUhPmQZSM33WGA9HLs_ejWnsxpLC1mTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:56577 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753402Ab1JQMr0 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 17 Oct 2011 08:47:26 -0400
In-Reply-To: <CAGxe1ZHgHMEzBq=eDiPUhPmQZSM33WGA9HLs_ejWnsxpLC1mTQ@mail.gmail.com>
	(Girish K. S.'s message of "Mon, 17 Oct 2011 10:34:58 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Girish K S <girish.shivananjappa@linaro.org>
Cc: linux-mmc@vger.kernel.org, patches@linaro.org, linux-samsung-soc@vger.kernel.org, Jaehoon Chung <jh80.chung@samsung.com>

Hi Girish,

On Mon, Oct 17 2011, Girish K S wrote:
>>> + if (card != NULL && mmc_card_mmc(card) &&
>>
>> != NULL is unnecessary.
>
> This is required. Let me explain the scenario where i felt it is necessary.

I'm not saying that you shouldn't test whether card is NULL -- I'm
saying that "if (card && mmc_card_mmc(card) && " would perform this
test with fewer characters, and be idiomatic for the kernel.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
