From: Heiko Schocher <hs@denx.de>
Subject: Re: [Fwd: Re: [PATCH] arm, da8xx,
 mmc: set second MMC controllers default	queue]
Date: Thu, 08 Dec 2011 07:56:20 +0100
Message-ID: <4EE05F94.9050209@denx.de>
References: <4EDF061F.7080302@denx.de>
 <B6A220404B6BFC4BBD2AB91C54D39DF402BA5E@DBDE01.ent.ti.com>
Reply-To: hs@denx.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from b.relay.invitel.net ([62.77.203.4]:40535 "EHLO
	b.relay.invitel.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751040Ab1LHG4Z (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 8 Dec 2011 01:56:25 -0500
In-reply-to: <B6A220404B6BFC4BBD2AB91C54D39DF402BA5E@DBDE01.ent.ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Rajashekhara, Sudhakar" <sudhakar.raj@ti.com>
Cc: "Nori, Sekhar" <nsekhar@ti.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>

Hello Rajashekhara,

Rajashekhara, Sudhakar wrote:
> On Wed, Dec 07, 2011 at 11:52:23, Heiko Schocher wrote:
>> Hello Sekhar,
>>
>> here the forwarded comment from Ido Yariv to my patch. I tried
>> with current kernel MMC Controller 2 on my am1808 based board
>> without my fix, and it works fine, so no need for applying my
>> patch.
>>
>> Thanks
>> bye,
>> Heiko
>>
>> here the message from Ido:
>>
>> Betreff: Re: [PATCH] arm, da8xx, mmc: set second MMC controllers default queue
>> Datum: Mon, 5 Dec 2011 10:35:10 +0200
>> Von: Ido Yariv <ido@wizery.com>
>> An: hs@denx.de
>> CC: juha.kuikka@gmail.com
> 
> I think Ido replied to only you and Juha, that's why even I am not able to see his reply on the list.

Ah, yes, you are right, sorry missed that ...

>> Referenzen: <1322991210-20486-1-git-send-email-hs@denx.de>	<20111204102741.GL32400@WorkStation>	<4EDC7C00.30603@denx.de>
>>
>> Hi Heiko,
>>
>> On Dec 5, 2011 10:08 AM, "Heiko Schocher" <hs@denx.de> wro
>>> Ok ... patch not longer needed, but isn't it better to setup here
>>> immediately the right values? If so, I can sent a v2 with your
>>> suggested comment change.
>> These are just default values which will get overwritten later on, so im
>> not sure if it matters much. I guess it wouldn't hurt to use default_queue
>> instead of queue 1.
>>
> 
> It would have helped if you posted the complete message here but I figured
> this out. I assume that Ido's explanation is as below:

Hmm.. that was the complete message ...

> EDMA channel is allocated in MMC driver through the call to
> edma_alloc_channel() api and the last argument passed to this api is the
> event queue number. Currently the event queue number being passed is
> EVENTQ_DEFAULT. Inside edma_alloc_channel() there is a call to
> map_dmach_queue() which also takes event queue number as argument.
> map_dmach_queue() function initializes the event queue number to
> default_queue (being passed from platform data), if it is EVENTQ_DEFAULT.

Yep, fully correct.

> I wanted to know why MMC/SD was not working initially for you even with
> this piece of code? 

Because I tested with Linux-3.1 where this patch wasn't included ...

>> In any case, if you do chose to submit v2, the commit message should also
>> be changed if it doesnt really fix anything.
> 
> I would still say, your patch is the clean way of addressing the issue.
> May be you can modify the commit message as Ido has pointed out.

Ok, send a v2, thanks!

> Sekhar, do you have any comments?

bye,
Heiko
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
