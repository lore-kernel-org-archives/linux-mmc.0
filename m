From: Markos Chandras <Markos.Chandras@imgtec.com>
Subject: Re: [PATCH 1/3] dw_mmc: Don't loop when handling an interrupt
Date: Wed, 13 Mar 2013 14:27:52 +0000
Message-ID: <51408CE8.70406@imgtec.com>
References: <1363085593-22214-1-git-send-email-markos.chandras@imgtec.com> <002501ce1ff6$38e3c470$aaab4d50$%jun@samsung.com> <87a9q7fk9l.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:23762 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932101Ab3CMO16 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 13 Mar 2013 10:27:58 -0400
In-Reply-To: <87a9q7fk9l.fsf@octavius.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Seungwon Jeon <tgih.jun@samsung.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 'Jaehoon Chung' <jh80.chung@samsung.com>

On 03/13/2013 02:26 PM, Chris Ball wrote:
> Hi,
>
> On Wed, Mar 13 2013, Seungwon Jeon wrote:
>> On Tuesday, March 12, 2013, Markos Chandras wrote:
>>> There is no reason to loop when handling an interrupt. The "if" clauses
>>> will handle all of them sequentially. This also eliminates the extra loop
>>> we used to take with no pending interrupts and we ended up breaking out
>>> of the while loop.
>>>
>>> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
>>> Cc: Seungwon Jeon <tgih.jun@samsung.com>
>>
>> Acked-by: Seungwon Jeon <tgih.jun@samsung.com>
>>
>> You can add my ack to other patches.
>> However, could you change the subject prefix to 'mmc: dw_mmc' and resend?
>
> It's okay, I'll take care of that when applying this time.  Thanks!
>
> - Chris.
>

Hi Chris,

Ok thank you

Markos

