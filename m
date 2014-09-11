From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] fix mmc hang during boot on socfpga
Date: Thu, 11 Sep 2014 11:14:11 +0900
Message-ID: <54110573.3070304@samsung.com>
References: <20140909121902.GA22965@amd>
 <CAOesGMgvqvQw2WzdQWQ7NSE_CKgH0MR-46UABkck0cQbpV4P=g@mail.gmail.com>
 <20140909205618.GA32688@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:49011 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751222AbaIKCOO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 10 Sep 2014 22:14:14 -0400
In-reply-to: <20140909205618.GA32688@amd>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Pavel Machek <pavel@denx.de>, Olof Johansson <olof@lixom.net>
Cc: Seungwon Jeon <tgih.jun@samsung.com>, Chris Ball <chris@printf.net>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, =?windows-1252?Q?Marek_Va=9Aut?= <marex@denx.de>

Hi, Pavel.

On 09/10/2014 05:56 AM, Pavel Machek wrote:
> On Tue 2014-09-09 10:32:14, Olof Johansson wrote:
>> On Tue, Sep 9, 2014 at 5:19 AM, Pavel Machek <pavel@ucw.cz> wrote:
>>>
>>> Without this patch, boot hangs when trying to mount root filesystem on
>>> socfpga platform in about 50% cases.
>>
>> I think this should have a better description than this -- this is too
>> vague. Did it use to always work, is this a new failure? You enable
>> some more error checking and improved stop handling, why was the
>> previous one inadequate on this platform?
> 
> I don't think it ever worked reliably. I don't know what is different
> for socfpga, or if it is broken on other platforms, too. I have two
> socfpga boards here, but no other dw_mmc board.

I didn't know what error is occurred at your board. But i guess it looks like HLE error, right?
Or you can share how booting is failed. than i think we can discuss more detailedly about your problem.


Best Regards,
Jaehoon Chung

> 
> Patch was separated from rocketboards.org repository.
> 
> Hope this helps,
> 
> 									Pavel
> 

