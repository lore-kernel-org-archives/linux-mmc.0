From: Balaji T K <balajitk@ti.com>
Subject: Re: [PATCH v7 1/4] mmc: omap_hsmmc: Enable SDIO IRQ.
Date: Fri, 7 Mar 2014 20:42:01 +0530
Message-ID: <5319E1C1.9000107@ti.com>
References: <1393331866-28307-1-git-send-email-afenkart@gmail.com> <1393331866-28307-2-git-send-email-afenkart@gmail.com> <5310C1AC.5060301@ti.com> <CALtMJEA9opDbEb1HRbA3CdOc3UigrpeD1bhaNAgyEKehsBDvgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45564 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752718AbaCGPM0 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 7 Mar 2014 10:12:26 -0500
In-Reply-To: <CALtMJEA9opDbEb1HRbA3CdOc3UigrpeD1bhaNAgyEKehsBDvgg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andreas Fenkart <afenkart@gmail.com>
Cc: Chris Ball <cjb@laptop.org>, Tony Lindgren <tony@atomide.com>, Grant Likely <grant.likely@secretlab.ca>, Felipe Balbi <balbi@ti.com>, Daniel Mack <zonque@gmail.com>, Kumar Gala <galak@codeaurora.org>, linux-doc@vger.kernel.org, linux-mmc <linux-mmc@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>

On Wednesday 05 March 2014 02:00 PM, Andreas Fenkart wrote:
> Hi,
>
> 2014-02-28 18:04 GMT+01:00 Balaji T K <balajitk@ti.com>:
>> On Tuesday 25 February 2014 06:07 PM, Andreas Fenkart wrote:
>>>
>>> For now, only support SDIO interrupt if we are booted with
>>> DT. This is because some platforms need special quirks. And
>>> we don't want to add new legacy mux platform init code
>>> callbacks any longer as we are moving to DT based booting
>>> anyways.
>>>
>>> Signed-off-by: Andreas Fenkart <afenkart@gmail.com>
>>>
>>> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
>>> index a5a38cc..bd3bb0c 100644
>>> --- a/drivers/mmc/host/omap_hsmmc.c
>>> +++ b/drivers/mmc/host/omap_hsmmc.c
>>
>>
>> <snip>
>>
>>
>>> @@ -1705,7 +1757,18 @@ static void omap_hsmmc_debugfs(struct mmc_host
>>> *mmc)
>>>    #endif
>>>
>>>    #ifdef CONFIG_OF
>>> -static u16 omap4_reg_offset = 0x100;
>>> +struct of_data {
>>> +       u16 offset;
>>> +       int flags;
>>> +};
>>> +
>>
>> Hi Andreas,
>>
>> struct of_data declaration needs to be moved out of #ifdef CONFIG_OF
>> for !CONFIG_OF build.
> should be fixed with new version
>
>>
>> I tried testing this patch series on am335x, I see throughput in the
>> range of KBs. Will give another try with Tony's version.
> KB sounds really bad, even with polling I have > 5MBytes/s.
>
> Could you pls paste
> # cat /sys/kernel/debug/mmc0/regs
>
Hi,

Find below debug reg dump

mmc0:
sdio irq        enabled
pinmux config   sdio
ctx_loss:       1

regs:
CON:            0x00000600
PSTATE:         0x01f70000
HCTL:           0x00000d06
SYSCTL:         0x000d0087
IE:             0x00000100
ISE:            0x00000100
CAPA:           0x06e10080

