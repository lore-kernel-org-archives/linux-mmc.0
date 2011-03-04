From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 1/3] mmc: skip detection of nonremovable cards on rescan -
 card removal detection regression
Date: Fri, 04 Mar 2011 14:25:30 +0900
Message-ID: <4D7077CA.3090307@samsung.com>
References: <1290921690-6133-1-git-send-email-ohad@wizery.com>
 <1290921690-6133-2-git-send-email-ohad@wizery.com>
 <20101217005123.GD17239@void.printf.net>
 <AANLkTi=ff=kkaRHOrDyoxOgw_Bt7raiPf3T=ed1=EveZ@mail.gmail.com>
 <1299205366.4999.3.camel@maxim-laptop> <m3mxlbobz0.fsf@pullcord.laptop.org>
 <1299207177.4999.10.camel@maxim-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:24408 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750740Ab1CDFZc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 4 Mar 2011 00:25:32 -0500
Received: from epmmp2 (mailout3.samsung.com [203.254.224.33])
 by mailout3.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LHI00EMLPQI1E20@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 04 Mar 2011 14:25:30 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LHI001FJPQI4Z@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 04 Mar 2011 14:25:30 +0900 (KST)
In-reply-to: <1299207177.4999.10.camel@maxim-laptop>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: Chris Ball <cjb@laptop.org>, Ohad Ben-Cohen <ohad@wizery.com>, linux-mmc@vger.kernel.org

Hi..

I agreed Chris's opinion..If use CONFIG_MMC_UNSAFE_RESUME, you can know to
occur some problem..so mentions to "DANGEROUS"
If card can be removed during suspend, i think we have too many cases.
So this configuration...i think good that use only non-removable card.
If you considered every case, you should not use UNSAFE_RESUME..

Regards,
Jaehoon Chung

Maxim Levitsky wrote:
> On Thu, 2011-03-03 at 21:28 -0500, Chris Ball wrote:
>> Hi,
>>
>> On Thu, Mar 03 2011, Maxim Levitsky wrote:
>>> This patch breaks the CONFIG_MMC_UNSAFE_RESUME, because it sets fake
>>> non-removeable flag, but the intended use of this option is to assume
>>> that card is not removed _during_ suspend,  and it can still be removed
>>> during normal use.
>>> With this commit, card removal isn't detected.
>> I guess we disagree about the semantics of CONFIG_MMC_UNSAFE_RESUME.
>> The Kconfig text says:
>>
>> config MMC_UNSAFE_RESUME
>>         bool "Assume MMC/SD cards are non-removable (DANGEROUS)"
>>
>> which I interpret as meaning that you should set MMC_UNSAFE_RESUME
>> *if you're using a card that cannot be removed*.  If your card *can* be
>> removed, then it would be extremely foolish to turn on MMC_UNSAFE_RESUME,
>> because then if someone removed your removable card during suspend and
>> modified it in another machine before resuming, you'd get massive
>> filesystem corruption.
> That is assuming that someone kindly inserted the card back, while
> system still was suspended, which is really unlikely, and besides, I
> know who uses my computer (me mostly) and I know what I am doing.
> 
> 
> The description also says:
> 
> "If you say Y here, the MMC layer will assume that all cards
> stayed in their respective slots during the suspend. The
> normal behaviour is to remove them at suspend and
> redetecting them at resume. Breaking this assumption will
> in most cases result in data corruption."
> 
> 
> I own my computer, and I don't need the OS to take the decisions for me.
> 
> I don't want to have FS corruption if I accidentally suspend the system
> with the card in the slot which could happen if that option is disabled.
> 
> 
> Best regards,
> 	Maxim Levitsky
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

