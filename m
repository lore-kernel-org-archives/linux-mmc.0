From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: sdhci-pxav3: dt: Support "broken-cd"/"wp-inverted" properties
Date: Tue, 11 Sep 2012 11:02:47 -0400
Message-ID: <87d31sy548.fsf@octavius.laptop.org>
References: <87mx0zzyin.fsf@octavius.laptop.org>
	<CAN1soZzebpiQB_7HW80xnqEqqVJumiDxPQ3jqx_8ezBRMr6TZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:60822 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759287Ab2IKPCw (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 11 Sep 2012 11:02:52 -0400
In-Reply-To: <CAN1soZzebpiQB_7HW80xnqEqqVJumiDxPQ3jqx_8ezBRMr6TZg@mail.gmail.com>
	(Haojian Zhuang's message of "Tue, 11 Sep 2012 22:29:48 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: linux-mmc@vger.kernel.org, Philip Rakity <prakity@marvell.com>, Zhangfei Gao <zhangfei.gao@marvell.com>

Hi,

On Tue, Sep 11 2012, Haojian Zhuang wrote:
> On Sun, Sep 9, 2012 at 11:05 AM, Chris Ball <cjb@laptop.org> wrote:
>> Signed-off-by: Chris Ball <cjb@laptop.org>
>> ---
>>  drivers/mmc/host/sdhci-pxav3.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
>> index a553b18..8a9b367 100644
>> --- a/drivers/mmc/host/sdhci-pxav3.c
>> +++ b/drivers/mmc/host/sdhci-pxav3.c
>> @@ -198,6 +198,12 @@ static struct sdhci_pxa_platdata *pxav3_get_mmc_pdata(struct device *dev)
>>         if (clk_delay_cycles > 0)
>>                 pdata->clk_delay_cycles = clk_delay_cycles;
>>
>> +       if (of_find_property(np, "broken-cd", NULL))
>> +               pdata->quirks |= SDHCI_QUIRK_BROKEN_CARD_DETECTION;
>> +
>> +       if (of_find_property(np, "wp-inverted", NULL))
>> +               pdata->quirks |= SDHCI_QUIRK_INVERTED_WRITE_PROTECT;
>> +
>>         return pdata;
>>  }
>>  #else
>
> Acked-by: Haojian Zhuang <haojian.zhuang@gmail.com>

Thanks, pushed to mmc-next for 3.7.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
