From: Philip Rakity <prakity@marvell.com>
Subject: Re: [PATCH] mmc: support sdhci-mmp2
Date: Tue, 31 May 2011 08:57:05 -0700
Message-ID: <82677173-FCCF-4A3B-9563-517CF4E56D56@marvell.com>
References: <1306156882-12124-1-git-send-email-zhangfei.gao@marvell.com>
 <F4CA7B04-7898-4C6A-814E-DE84588E3C94@marvell.com>
 <BANLkTi=0VRXmqFrf-HuAoj4JAdg8KiF4qA@mail.gmail.com>
 <47E8F95D-7537-40D5-AD51-694EE4DCEEC3@marvell.com>
 <BANLkTikJU-WvOJ0yzKb0WUz+cNS7dDz3_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:57625 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932161Ab1EaP5S convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 31 May 2011 11:57:18 -0400
In-Reply-To: <BANLkTikJU-WvOJ0yzKb0WUz+cNS7dDz3_g@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei gao <zhangfei.gao@gmail.com>
Cc: Zhangfei Gao <zgao6@marvell.com>, Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@fluxnic.net>, Wolfram Sang <w.sang@pengutronix.de>, Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jun Nie <njun@marvell.com>, Raymond Wu <xywu@marvell.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Mark Brown <mark.brown314@gmail.com>, Shawn Guo <shawn.guo@linaro.org>


Hi Zhangfei,

<Snip>
>>>> 
>>>> It is probably better to NOT name the file sdhci-mmp2.c but
>>>> something like sdchi-pxaV3.c since other SoC's may use this controller.
>>> fine
>> 
>> The same renaming change is needed for the pxa9xx patch.
> Do you mean use sdhci-pxa9xx.c to replace sdhci-pxa910.c, pxa955 do
> not use the same driver, but it does not matter.

Give it a name that is not chip specific so the driver can be reused.
the name in the probe definition should be changed as well.

>>>>> +static struct platform_driver sdhci_mmp2_driver = {
>>>>> +       .driver         = {
>>>>> +               .name   = "sdhci-mmp2",

change to sdhci-pxaV3

>>>>> +               .owner  = THIS_MODULE,
>>>>> +       },
>>>>> +       .probe          = sdhci_mmp2_probe,
>>>>> +       .remove         = __devexit_p(sdhci_mmp2_remove),
>>>>> +#ifdef CONFIG_PM
>>>>> +       .suspend        = sdhci_mmp2_suspend,
>>>>> +       .resume         = sdhci_mmp2_resume,
>>>>> +#endif
>>>>> +};

for pxa910 and for pxa168 they use a sdhci-pxav2 controller and the code should be updated accordingly.

>>>>> \
>> 
>>> 
>>>>> +               | SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC;
>>> This quirk also not must?
>> 
>> It is NOT a must but it saves a needless memory access per ADMA transfer to fetch a
>> descriptor that says ADMA is done.  Since you are concerned about  the time 74 clocks
>> takes this quirk makes everything faster.
> For pxa955, this quirk must be set, otherwise it is not work properly.
> For mmp2, ADMA work well regardless of this quirk, it is OK if you
> think add this quirk would be efficiently,
> One general question is quirk should be added only for chip limitation?

The code is backwards in sdhci.c.  The original code assumed a extra descriptor was needed.
The quirk removed the limitation.  Strange use for a quirk to make things work as they should 
but preserved original behavior.

>> 
>>>>> +
>>>>> +       /* enable 1/8V DDR capable */
>>>>> +       host->mmc->caps |= MMC_CAP_1_8V_DDR;
>>>> 
>>>> 
>>>> missing cap for bus width testing CMD19 works on MMP2
>>> Will do the test of CMD19.
> Test CMD19 on mmp2 A2 with MMC_CAP_BUS_WIDTH_TEST, timeout occurs here.

check the chip revision that you have.  This is fixed in newer silicon.

>>>>> +       if (pdata && pdata->flags & PXA_FLAG_DISABLE_CLOCK_GATING) {
>>>>> +               u32 tmp = 0;
>>>>> +
>>>>> +               tmp = readl(host->ioaddr + MMP2_SD_FIFO_PARAM);
>>>>> +               tmp |= MMP2_DIS_PAD_SD_CLK_GATE;
>>>>> +               writel(tmp, host->ioaddr + MMP2_SD_FIFO_PARAM);
>>>>> +       }
>>>>> +}
>>>> 
>>>> One cannot know what card if being inserted or removed by a user
>>>> so the safest choice is to leave clock gating OFF by default.
>>>> 
>>>> PXA_FLAG_DISABLE_CLOCK_GATING should be renamed
>>>> to
>>>> PXA_FLAG_ENABLE_CLOCK_GATING.
>>>> 
>>>> If you have a card which is permanent then the flags should be used
>>>> to ENABLE clock gating.  Otherwise clock gating should be left OFF by default.
> Fine,
> My understanding is it is not a question, user have to know which slot
> should open/close clock gating, and set flag accordingly.
> Currently only 8787 require clock free running.

NO USER can know if a card requires clock gating or not.  There are other cards
that require no clock gating 8688 for example.



> Since you have add one workaround to use mmc_compare_ext_csds, so same
> result adding caps or not, timeout and use 1bit mode.

CMD19 maps the standard.  If no ext_csd they bus width test will make card work in 1 bit mode
when CMD19 might make it run in 4 or 8 bit mode.  CMD19 is best if supported.

>> \
>> not clear in my question.  Have you confirmed that when the controller is DEAD that
>> -1 is read from the INT STATUS register ?  I have never seen this.
>> Maybe there is a private register that can help.
> not see -1 either, not impact function.
> if you want to make sure, we can make the controller DEAD to have a try.

Thank You

>>>> +}
>>>> +
>>>> 
>> 
>> is the 740 us delay important  once per card insert ?  The code works as submitted and was tested
>> with the silicon design team.  The other option would be to enable the interrupt rather then wait but
>> in that case you will need to plumb the interrupt in.  Did not want to touch base code and
>> was not concerned about 740 us.
>> 
>> The mmc_delay value is WAY too high and should be lowered.
> mmc_delay will schedule out, so the value has no defect.

Not really -- it delays the start up time for the device with a value that is this high.  It does not effect the other
components.

> Finish 74 clocks during mmc_delay time could make the code simple, and
> solve the silicon issue.
> It is OK if you want to use polling, function is OK.

thank you -- in practice it just delays and never polls.  The code completes.  If you are concerned about the
time you can try lowering the 74 uSec delay.  at 400KHz the code takes 185 uSec rather than 740.  I wanted
to be safe with the value.  
> 
>> 
>> The 74 clock code is needed for any slot where a card can be plugged in.   You cannot assume it is
>> SD.  It could be mmc (or sdio) or combo.




>> 
>>>>> 
>>>> 
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>> 
>> 
>> 

