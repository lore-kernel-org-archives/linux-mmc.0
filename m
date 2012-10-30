From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH] mmc: at91-mci: remove driver
Date: Tue, 30 Oct 2012 18:08:59 +0100
Message-ID: <509009AB.8040302@atmel.com>
References: <1351520875-31891-1-git-send-email-ludovic.desroches@atmel.com> <87625txrou.fsf@octavius.laptop.org> <20121030150113.GB19021@game.jcrosoft.org> <87ehkgov3a.fsf@octavius.laptop.org> <20121030153350.GC19021@game.jcrosoft.org> <87a9v4otqh.fsf@octavius.laptop.org> <20121030154309.GD19021@game.jcrosoft.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.242]:43148 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933825Ab2J3QI6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 30 Oct 2012 12:08:58 -0400
In-Reply-To: <20121030154309.GD19021@game.jcrosoft.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Chris Ball <cjb@laptop.org>, ludovic.desroches@atmel.com
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 10/30/2012 04:43 PM, Jean-Christophe PLAGNIOL-VILLARD :
> On 11:38 Tue 30 Oct     , Chris Ball wrote:
>> Hi,
>>
>> On Tue, Oct 30 2012, Jean-Christophe PLAGNIOL-VILLARD wrote:
>>> On 11:09 Tue 30 Oct     , Chris Ball wrote:
>>>> Hi,
>>>>
>>>> On Tue, Oct 30 2012, Jean-Christophe PLAGNIOL-VILLARD wrote:
>>>>>> Thanks!  Pushed to mmc-next for 3.8.
>>>>>
>>>>> if you don't mind I prefer to take it via at91
>>>>>
>>>>> I've a patch series that cleanup the platform_data it's difficult to merge
>>>>> with this one
>>>>
>>>> Hm, I don't understand why it should be difficult to merge.  Is it
>>>> because this patch modifies arch/arm/mach-at91/include/mach/board.h?
>>>>
>>>> If so, sounds like we should just take that change out of this patch
>>>> and have it go into your platform data cleanup patch, and then I can
>>>> merge the drivers/mmc change independently?  Let me know what you think.
>>> I'm modifing and moiving the board.h so this file will not exist anymore
>>>
>>> and the platform data are not anymore in arch/arm/mach-at91/include/mach/board.h
>>
>> Can we take the modification of board.h out of this patch, then,
>> leaving just the drivers/mmc/ changes?
> If you really insist but for changelog history and bisectable I'll prefer to
> do not do so

Why don't we leave the code already submitted in the mmc tree. It seems
that the conflict can be pretty easily handled in advance as it ends up
being a file removal...

So, I would not bother Chris with our own business and would just manage
the conflict later, in linux-next (maybe sending a little note to Stephen).

My $0.02.

Bye,
-- 
Nicolas Ferre
