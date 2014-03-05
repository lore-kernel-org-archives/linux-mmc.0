From: Andreas Fenkart <afenkart@gmail.com>
Subject: Re: [PATCH v7 1/4] mmc: omap_hsmmc: Enable SDIO IRQ.
Date: Wed, 5 Mar 2014 09:30:57 +0100
Message-ID: <CALtMJEA9opDbEb1HRbA3CdOc3UigrpeD1bhaNAgyEKehsBDvgg@mail.gmail.com>
References: <1393331866-28307-1-git-send-email-afenkart@gmail.com>
	<1393331866-28307-2-git-send-email-afenkart@gmail.com>
	<5310C1AC.5060301@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <5310C1AC.5060301@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: Balaji T K <balajitk@ti.com>
Cc: Chris Ball <cjb@laptop.org>, Tony Lindgren <tony@atomide.com>, Grant Likely <grant.likely@secretlab.ca>, Felipe Balbi <balbi@ti.com>, Daniel Mack <zonque@gmail.com>, Kumar Gala <galak@codeaurora.org>, linux-doc@vger.kernel.org, linux-mmc <linux-mmc@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi,

2014-02-28 18:04 GMT+01:00 Balaji T K <balajitk@ti.com>:
> On Tuesday 25 February 2014 06:07 PM, Andreas Fenkart wrote:
>>
>> For now, only support SDIO interrupt if we are booted with
>> DT. This is because some platforms need special quirks. And
>> we don't want to add new legacy mux platform init code
>> callbacks any longer as we are moving to DT based booting
>> anyways.
>>
>> Signed-off-by: Andreas Fenkart <afenkart@gmail.com>
>>
>> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
>> index a5a38cc..bd3bb0c 100644
>> --- a/drivers/mmc/host/omap_hsmmc.c
>> +++ b/drivers/mmc/host/omap_hsmmc.c
>
>
> <snip>
>
>
>> @@ -1705,7 +1757,18 @@ static void omap_hsmmc_debugfs(struct mmc_host
>> *mmc)
>>   #endif
>>
>>   #ifdef CONFIG_OF
>> -static u16 omap4_reg_offset = 0x100;
>> +struct of_data {
>> +       u16 offset;
>> +       int flags;
>> +};
>> +
>
> Hi Andreas,
>
> struct of_data declaration needs to be moved out of #ifdef CONFIG_OF
> for !CONFIG_OF build.
should be fixed with new version

>
> I tried testing this patch series on am335x, I see throughput in the
> range of KBs. Will give another try with Tony's version.
KB sounds really bad, even with polling I have > 5MBytes/s.

Could you pls paste
# cat /sys/kernel/debug/mmc0/regs

Thanks for testing.
