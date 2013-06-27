From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: core: Update the ext-csd.rev check for eMMC5.1
Date: Thu, 27 Jun 2013 10:39:21 -0400
Message-ID: <87fvw3sjmu.fsf@octavius.laptop.org>
References: <1369129124-31128-1-git-send-email-yuvaraj.cd@samsung.com>
	<CAD=FV=UknLh3ud6aQ8mzK8H0mXDR+uVqeeyWF6zgyZTnBuq2bA@mail.gmail.com>
	<CAD=FV=V_=vduQHRXKfqC7O6Oz6H++-rckAkULPtkT7URHRcVLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:60230 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753774Ab3F0Oj0 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 27 Jun 2013 10:39:26 -0400
In-Reply-To: <CAD=FV=V_=vduQHRXKfqC7O6Oz6H++-rckAkULPtkT7URHRcVLQ@mail.gmail.com> (Doug
	Anderson's message of "Wed, 22 May 2013 17:08:25 -0700")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Doug Anderson <dianders@google.com>
Cc: Yuvaraj Kumar C D <yuvaraj.cd@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>

Hi,

On Wed, May 22 2013, Doug Anderson wrote:
> Correction,
>
> On Wed, May 22, 2013 at 5:06 PM, Doug Anderson <dianders@google.com> wrote:
>> Yavaraj,
>>
>> On Tue, May 21, 2013 at 2:38 AM, Yuvaraj Kumar C D <yuvaraj.cd@gmail.com> wrote:
>>> With the new eMMC5.1 spec,there is a new EXT_CSD register with
>>> the revision number(EXT_CSD_REV) 7.This patch updates the check
>>> for ext-csd.rev number as 7.
>>>
>>> Signed-off-by: Alim Akhtar <alim.akthar@samsung.com>
>>> Signed-off-by: Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
>>> ---
>>>  drivers/mmc/core/mmc.c |    2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> Looks reasonable.
>>
>> Reviewed-by: Doug Anderson <dianders@chromium.org>
>
> ...with the caveat the Alim's email address be corrected.
>
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>

Thanks, pushed to mmc-next for 3.11 with the corrected signoff.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
