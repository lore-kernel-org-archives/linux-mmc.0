From: Markos Chandras <Markos.Chandras@imgtec.com>
Subject: Re: [PATCH 1/3] dw_mmc: Don't loop when handling an interrupt
Date: Wed, 13 Mar 2013 14:26:46 +0000
Message-ID: <51408CA6.9040504@imgtec.com>
References: <1363085593-22214-1-git-send-email-markos.chandras@imgtec.com> <002501ce1ff6$38e3c470$aaab4d50$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="EUC-KR"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:23742 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756411Ab3CMO0v (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 13 Mar 2013 10:26:51 -0400
In-Reply-To: <002501ce1ff6$38e3c470$aaab4d50$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 'Jaehoon Chung' <jh80.chung@samsung.com>, 'Chris Ball' <cjb@laptop.org>

On 03/13/2013 02:22 PM, Seungwon Jeon wrote:
> On Tuesday, March 12, 2013, Markos Chandras wrote:
>> There is no reason to loop when handling an interrupt. The "if" clauses
>> will handle all of them sequentially. This also eliminates the extra loop
>> we used to take with no pending interrupts and we ended up breaking out
>> of the while loop.
>>
>> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
>> Cc: Seungwon Jeon <tgih.jun@samsung.com>
> 
> Acked-by: Seungwon Jeon <tgih.jun@samsung.com>
> 
> You can add my ack to other patches.
> However, could you change the subject prefix to 'mmc: dw_mmc' and resend?
> 
> Thanks,
> Seungwon Jeon
> 

Hi Seungwon,

Thanks. Ok I will fix the title and send them again.

Markos

