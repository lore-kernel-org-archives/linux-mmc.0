From: Nikita Yushchenko <nikita.yoush@yandex.ru>
Subject: Re: mmc idle time bkops?
Date: Mon, 16 Mar 2015 22:46:16 +0300
Message-ID: <55073308.7090501@yandex.ru>
References: <550098CE.1010407@yandex.ru> <bdb5de1e1c2c1cfacdf02ba8f44025a3.squirrel@www.codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from forward3h.cmail.yandex.net ([87.250.230.18]:51637 "EHLO
	forward3h.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933789AbbCPTzk (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Mar 2015 15:55:40 -0400
In-Reply-To: <bdb5de1e1c2c1cfacdf02ba8f44025a3.squirrel@www.codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: merez@codeaurora.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Maya.

Thanks for the information.

There are thoughts that missing support for "non-urgent" bkops request
could be reason of unexpected slowdowns of eMMC i/o that customer is
observing. Thus the interest on the current status.

However, no particular projects or needs yet.

Nikita

> Hi Nikita,
> 
> The patch got stuck for a while as there was a request to use the runtime
> PM framework for implementing the idle time BKOPs and I didn't have the
> ability to test it back then.
> We plan to re-implement and test in the upcoming few months (aim to July).
> Do you have a need for this feature in an earlier date or it can wait for
> july?
> 
> Thanks,
> Maya
> 
>> Hi
>>
>> Some months ago, you've been working on "idle time bkops" feature. The
>> latest (v6) sign of this work I could found is [1]
>>
>> [1] https://lkml.org/lkml/2013/4/14/29
>>
>> However this did not land in mainline, also no replies, and no sign of
>> any follow-up...  Complete mystery what has happened to this effort :(
>>
>> What is the latest status of "idle time bkops" functionality?
>> Is any working implementation available?
>>
>> TIA,
>> Nikita Yushchenko
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> 
> 

