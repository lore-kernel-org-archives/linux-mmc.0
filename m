From: Philip Rakity <prakity@marvell.com>
Subject: Re: [PATCH v4 2/5] mmc: support sdhci-pxav2.c
Date: Tue, 14 Jun 2011 08:00:01 -0700
Message-ID: <5BEA9179-AA1B-4C49-A090-1DC78B1DE5A1@marvell.com>
References: <1307526121-12059-1-git-send-email-zhangfei.gao@marvell.com>
 <1307526121-12059-3-git-send-email-zhangfei.gao@marvell.com>
 <0059AEB1-3536-4540-924A-A95C7F3AD21A@marvell.com>
 <BANLkTimeb-Ax99rQDYckLsVSncxhrh7amg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:55801 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751574Ab1FNPDX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 14 Jun 2011 11:03:23 -0400
In-Reply-To: <BANLkTimeb-Ax99rQDYckLsVSncxhrh7amg@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei gao <zhangfei.gao@gmail.com>
Cc: Zhangfei Gao <zgao6@marvell.com>, Eric Miao <eric.y.miao@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@fluxnic.net>, Qiming Wu <wuqm@marvell.com>, Jun Nie <njun@marvell.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Wolfram Sang <w.sang@pengutronix.de>, Haojian Zhuang <haojian.zhuang@gmail.com>, Raymond Wu <xywu@marvell.com>, Chris Ball <cjb@laptop.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Mark Brown <mark.brown314@gmail.com>


On Jun 13, 2011, at 11:07 PM, zhangfei gao wrote:

>>> +static void pxav2_set_private_registers(struct sdhci_host *host, u8 mask)
>>> +{
>>> +     struct platform_device *pdev = to_platform_device(mmc_dev(host->mmc));
>>> +     struct sdhci_pxa_platdata *pdata = pdev->dev.platform_data;
>>> +
>>> +     if (mask == SDHCI_RESET_ALL) {
>>> +             u16 tmp = 0;
>>> +
>>> +             /*
>>> +              * tune timing of read data/command when crc error happen
>>> +              * no performance impact
>>> +              */
>>> +             if (pdata->clk_delay_sel == 1) {
>>> +                     tmp = readw(host->ioaddr + SD_CLOCK_BURST_SIZE_SETUP);
>>> +
>>> +                     tmp &= ~(SDCLK_DELAY_MASK << SDCLK_DELAY_SHIFT);
>>> +                     tmp |= (pdata->clk_delay_cycles & SDCLK_DELAY_MASK)
>>> +                             << SDCLK_DELAY_SHIFT;
>>> +                     tmp &= ~(SDCLK_SEL_MASK << SDCLK_SEL_SHIFT);
>>> +                     tmp |= (1 & SDCLK_SEL_MASK) << SDCLK_SEL_SHIFT;
>>> +
>>> +                     writew(tmp, host->ioaddr + SD_CLOCK_BURST_SIZE_SETUP);
>>> +             }
>> 
>> There are 3 possible value for clk_delay_sel.
>> 
>> 0  == do not use clk_delay_cycles
>> 1 == use programmed clk_delay_cycles value (the code above)
>> all other values use the sd_clk which was used to drive the output
>> 
>> The code about only handles 2 of the 3 cases
> 
> pxa910/920 only require two cases.
> 1, clk_delay_sel = 1 with delay value.
> 2, use default setting and directly use sd_clk. clk_delay_sel = 3.
> 
>> 
>> suggest
>> 
>>        (if (pdata->clk_delay_sel) {
>>> +             if (pdata->clk_delay_sel == 1) {
>>> +                     tmp = readw(host->ioaddr + SD_CLOCK_BURST_SIZE_SETUP);
>>> +
>>> +                     tmp &= ~(SDCLK_DELAY_MASK << SDCLK_DELAY_SHIFT);
>>> +                     tmp |= (pdata->clk_delay_cycles & SDCLK_DELAY_MASK)
>>> +                             << SDCLK_DELAY_SHIFT;
>>> +                     tmp &= ~(SDCLK_SEL_MASK << SDCLK_SEL_SHIFT);
>>> +                     tmp |= 1 << SDCLK_SEL_SHIFT;
>>> +
>>> +                     writew(tmp, host->ioaddr + SD_CLOCK_BURST_SIZE_SETUP);
>>> +             } else {
>> 
>>> +                     tmp = readw(host->ioaddr + SD_CLOCK_BURST_SIZE_SETUP);
>>> +                     tmp &= ~(SDCLK_SEL_MASK << SDCLK_SEL_SHIFT);
>>> +                     tmp |= 2  << SDCLK_SEL_SHIFT;
>>> +                     writew(tmp, host->ioaddr + SD_CLOCK_BURST_SIZE_SETUP);
> The else is default setting on pxa910 after reset.
>>                   }
>>         }
>> 
>> Philip and Mark

If you are comfortable not support mode 0 then I am okay with this patch set.

Acked-by: Philip Rakity <prakity@marvell.com>
Acked-by: Mark F. Brown <mark.brown314@gmail.com>

>>> 
>> 
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>> 

