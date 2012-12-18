From: Chris Ball <cjb@laptop.org>
Subject: Re: [RESEND PATCH v4] mmc: fix async request mechanism for sequential read scenarios
Date: Tue, 18 Dec 2012 11:19:03 -0500
Message-ID: <87mwxb72q0.fsf@octavius.laptop.org>
References: <n@samsung.com>
	<1355149430-17496-1-git-send-email-kdorfman@codeaurora.org>
	<001c01cddc51$c9cc3f00$5d64bd00$%jun@samsung.com>
	<50D09324.1000502@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:32974 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932093Ab2LRQTJ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 18 Dec 2012 11:19:09 -0500
In-Reply-To: <50D09324.1000502@codeaurora.org> (Konstantin Dorfman's message
	of "Tue, 18 Dec 2012 18:00:36 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Konstantin Dorfman <kdorfman@codeaurora.org>
Cc: Seungwon Jeon <tgih.jun@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Per Forlin <per.lkml@gmail.com>

Hi,

On Tue, Dec 18 2012, Konstantin Dorfman wrote:
>>>> @@ -1374,6 +1367,8 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
>>>>   		mmc_queue_bounce_post(mq_rq);
>>>>
>>>>   		switch (status) {
>>>> +		case MMC_BLK_NEW_REQUEST:
>>>> +			BUG(); /* should never get here */
>> Is there any case to reach here?
>> I didn't find it.
>> 
> Correct. But since there is no "default:" in this switch, compiler
> demands all values of the 'status' variable present. So, we need this
> BUG() here or we need to introduce "default:".

Please avoid using BUG() entirely (both here and elsewhere).  It crashes
the entire MMC stack, which means it crashes the machine entirely if
you're booted from eMMC/SD.  There is almost always something better
that can be done than crashing the machine.

default: and pr_err() sound fine here.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
