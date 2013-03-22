From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: block: fix the host's claim-release in special request
Date: Fri, 22 Mar 2013 13:05:16 -0400
Message-ID: <871ub7mkkz.fsf@octavius.laptop.org>
References: <001101ce207b$91e60440$b5b20cc0$%jun@samsung.com>
	<CA+20K0DxMmq67gWR4igtdOMdO+h19JqbEMH1=Wsp1v9cKPKkZQ@mail.gmail.com>
	<CAPDyKFo2dkEp4n3gcwKbJ0NB+G_zAiKwPLxsBaZXJFvqQ1JFiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:34044 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161016Ab3CVRFU (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 22 Mar 2013 13:05:20 -0400
In-Reply-To: <CAPDyKFo2dkEp4n3gcwKbJ0NB+G_zAiKwPLxsBaZXJFvqQ1JFiQ@mail.gmail.com>
	(Ulf Hansson's message of "Thu, 14 Mar 2013 15:49:27 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Johan Rudholm <jrudholm@gmail.com>, Seungwon Jeon <tgih.jun@samsung.com>, linux-mmc@vger.kernel.org, Konstantin Dorfman <kdorfman@codeaurora.org>

Hi,

On Thu, Mar 14 2013, Ulf Hansson wrote:
>> 2013/3/14 Seungwon Jeon <tgih.jun@samsung.com>:
>>> For normal request mmc_blk_issue_rq is called twice with asynchronous
>>> transfer(cur and prev). Host's claim and release can be done in each
>>> mmc_blk_issue_rq. However, Special request is currently excluded in
>>> asynchronous transfer. After special request is finished, if there is
>>> no new request, mmc_release_host won't be called in mmc_blk_issue_rq.
>>> The problem is founded during mmc_suspend.
>>>
>>> [<c0541124>] (__schedule+0x0/0x78c) from [<c05419e8>] (schedule+0x38/0x78)
>>> [<c05419b0>] (schedule+0x0/0x78) from [<c03a843c>]
>>> (__mmc_claim_host+0xac/0x1b4)
>>> [<c03a8390>] (__mmc_claim_host+0x0/0x1b4) from [<c03ac98c>]
>>> (mmc_suspend+0x28/0x9c)
>>> [<c03ac964>] (mmc_suspend+0x0/0x9c) from [<c03aad24>]
>>> (mmc_suspend_host+0xb4/0x194)
>>> ...
>>>
>>> Reported-by: Johan Rudholm <jrudholm@gmail.com>
>>> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
>>
>> Thank you for the quick response and fix! This fixes the problem. So
>> please include my
>>
>> Tested-by: Johan Rudholm <johan.rudholm@stericsson.com>
>
> Chris, could you send this for the 3.9 rc, since it is a bugfix?

Thanks, pushed to mmc-next for 3.9-rc.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
