From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] mmc: jz4740: don't wait for PRG_DONE after stop command
 with R1 response
Date: Tue, 29 Apr 2014 13:28:23 +0200
Message-ID: <535F8CD7.9060703@metafoo.de>
References: <1398760353-12507-1-git-send-email-alex.smith@imgtec.com> <CAPDyKFpAbLzhHBuzCnpTjRR9XC=H1uB71wFDkDg9drHfBMeMyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp-out-063.synserver.de ([212.40.185.63]:1052 "EHLO
	smtp-out-008.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S933540AbaD2LfG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Apr 2014 07:35:06 -0400
In-Reply-To: <CAPDyKFpAbLzhHBuzCnpTjRR9XC=H1uB71wFDkDg9drHfBMeMyw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Alex Smith <alex.smith@imgtec.com>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, James Hogan <james.hogan@imgtec.com>

On 04/29/2014 01:07 PM, Ulf Hansson wrote:
> On 29 April 2014 10:32, Alex Smith <alex.smith@imgtec.com> wrote:
>> As of commit bcc3e1726d ("mmc: block: Use R1 responses for stop cmds for
>> read requests"), stop commands for reads do not have MMC_RSP_BUSY set.
>> In this case we should not wait for a PRG_DONE IRQ after sending the
>> stop command: it will not get raised when the busy flag is not set,
>> causing the request to fail with a timeout.
>>
>> Signed-off-by: Alex Smith <alex.smith@imgtec.com>
>> Cc: Lars-Peter Clausen <lars@metafoo.de>
>> Cc: Ulf Hansson <ulf.hansson@linaro.org>
>> Cc: Chris Ball <chris@printf.net>
>> Cc: James Hogan <james.hogan@imgtec.com>
>
> Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
>

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

