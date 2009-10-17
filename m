From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: MMC_CAP_SDIO_IRQ for omap 3430
Date: Sat, 17 Oct 2009 08:30:23 +0200
Message-ID: <4AD9647F.3010505@googlemail.com>
References: <4b73d43f0910151330q6c5cae7sa2a5948b586cc215@mail.gmail.com>	 <4AD81DC2.4080607@googlemail.com>	 <42153.192.168.10.89.1255715021.squirrel@dbdmail.itg.ti.com>	 <4AD8C959.1000004@googlemail.com>	 <004701ca4ea5$aeacefe0$544ff780@am.dhcp.ti.com> <4b73d43f0910161426l7600f424w5b8345d16790dd21@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f218.google.com ([209.85.220.218]:62487 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750839AbZJQGbV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 17 Oct 2009 02:31:21 -0400
In-Reply-To: <4b73d43f0910161426l7600f424w5b8345d16790dd21@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: John Rigby <jcrigby@gmail.com>
Cc: Madhusudhan <madhu.cr@ti.com>, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, Steve Sakoman <sakoman@gmail.com>

John Rigby wrote:
> It appears to never get cleared in the status register.

In the OMAP status register, correct? (just to get the correct 
understanding)

> I added some printks to sdio_irq.c to print the pending interrupts in
> the SDIO_CCCR_INTx register for the card and there are no pending
> interrupts so I don't think it is a card driver or card issue.

Ok, in other words, this does mean that the card has no interrupt 
asserted any more (i.e. it is acknowledged by upper layers, e.g. 
libertas driver), but OMAP thinks there is still an interrupt. Right? 
This would mean it is an OMAP/omap_hsmmc.c issue. Right?

> It would be funny if the TRM was wrong and the CIRQ bit is really
> cleared by writing 1 to it.  I'll try that.

Have you checked if

- IBG (and 4 bit mode) is correctly set before the first interrupt is 
fired (just to make sure that we don't have a function calling order 
issue)?

- your HW design has a pull up on DAT1 line (as required by the SD 
physical spec)?

Best regards

Dirk

> On Fri, Oct 16, 2009 at 3:14 PM, Madhusudhan <madhu.cr@ti.com> wrote:
>>
>>> -----Original Message-----
>>> From: Dirk Behme [mailto:dirk.behme@googlemail.com]
>>> Sent: Friday, October 16, 2009 2:28 PM
>>> To: Madhusudhan Chikkature
>>> Cc: linux-mmc@vger.kernel.org; John Rigby; linux-omap@vger.kernel.org;
>>> Steve Sakoman
>>> Subject: Re: MMC_CAP_SDIO_IRQ for omap 3430
>>>
>>> Madhusudhan Chikkature wrote:
>>>> Hi Dirk,
>>>>
>>>> I am inlining the patch so that it helps review.
>>> ...
>>>> @@ -1165,8 +1178,15 @@ static void omap_hsmmc_set_ios(struct mm
>>>>             break;
>>>>     case MMC_BUS_WIDTH_4:
>>>>             OMAP_HSMMC_WRITE(host->base, CON, con & ~DW8);
>>>> -           OMAP_HSMMC_WRITE(host->base, HCTL,
>>>> -                   OMAP_HSMMC_READ(host->base, HCTL) | FOUR_BIT);
>>>> +           if (mmc_card_sdio(host->mmc->card)) {
>>>>
>>>> I wish it could be moved to "enable_sdio_irq" so that we can avoid
>>> inclusion of
>>>> card.h and checking the type of card in the host controller driver.
>>> Yes, this would be the real clean way. But ...
>>>
>>>> But the
>>>> dependancy on 4-bit seems to be a problem here.
>>> ... most probably we have to find a workaround until (if ever?) above
>>> clean implementation is available.
>>>
>>> What we need is after SDIO mode and bus width is known, and before the
>>> first interrupt comes, to set IBG.
>>>
>>>> On the problems being discussed on testing is the interrupt source
>>> geting
>>>> cleared at the SDIO card level upon genaration of the CIRQ? If not it
>>> remains
>>>> asserted.
>>> Yes, this seems to be exactly the problem John reports in his follow
>>> up mail.
>>>
>>> Any hint how to clear SDIO interrupt?
>>>
>> On the controller side I guess it is cleared when you pass "disable" in the
>> enable_sdio_irq" fn. This happens when you call mmc_signal_sdio_irq.
>>
>> I am not too sure about how it gets disabled from the card side. I see that
>> SDIO core has a function "sdio_release_irq" which is used by the sdio uart
>> driver. The usage of this could give a clue.
>>
>> Regards,
>> Madhu
>>
>>> Many thanks
>>>
>>> Dirk
>>>
>>>> +                   OMAP_HSMMC_WRITE(host->base, HCTL,
>>>> +                                    OMAP_HSMMC_READ(host->base, HCTL)
>>>> +                                    | IBG | FOUR_BIT);
>>>> +           } else {
>>>> +                   OMAP_HSMMC_WRITE(host->base, HCTL,
>>>> +                                    OMAP_HSMMC_READ(host->base, HCTL)
>>>> +                                    | FOUR_BIT);
>>>> +           }
>>>>             break;
>>>>     case MMC_BUS_WIDTH_1:
>>>>             OMAP_HSMMC_WRITE(host->base, CON, con & ~DW8);
>>>> @@ -1512,6 +1532,24 @@ static int omap_hsmmc_disable_fclk(struc
>>>>     return 0;
>>>>  }
>>>>
>>>> +static void omap_hsmmc_enable_sdio_irq(struct mmc_host *mmc, int
>>> enable)
>>>> +{
>>>> +   struct omap_hsmmc_host *host = mmc_priv(mmc);
>>>> +   u32 ie, ise;
>>>> +
>>>> +   ise = OMAP_HSMMC_READ(host->base, ISE);
>>>> +   ie  = OMAP_HSMMC_READ(host->base, IE);
>>>> +
>>>> +   if (enable) {
>>>> +           OMAP_HSMMC_WRITE(host->base, ISE, ise | CIRQ_ENABLE);
>>>> +           OMAP_HSMMC_WRITE(host->base, IE,  ie  | CIRQ_ENABLE);
>>>> +   } else {
>>>> +           OMAP_HSMMC_WRITE(host->base, ISE, ise & ~CIRQ_ENABLE);
>>>> +           OMAP_HSMMC_WRITE(host->base, IE,  ie  & ~CIRQ_ENABLE);
>>>> +   }
>>>> +
>>>> +}
>>>> +
>>>>  static const struct mmc_host_ops omap_hsmmc_ops = {
>>>>     .enable = omap_hsmmc_enable_fclk,
>>>>     .disable = omap_hsmmc_disable_fclk,
>>>> @@ -1519,7 +1557,7 @@ static const struct mmc_host_ops omap_hs
>>>>     .set_ios = omap_hsmmc_set_ios,
>>>>     .get_cd = omap_hsmmc_get_cd,
>>>>     .get_ro = omap_hsmmc_get_ro,
>>>> -   /* NYET -- enable_sdio_irq */
>>>> +   .enable_sdio_irq = omap_hsmmc_enable_sdio_irq,
>>>>  };
>>>>
>>>>  static const struct mmc_host_ops omap_hsmmc_ps_ops = {
>>>> @@ -1529,7 +1567,7 @@ static const struct mmc_host_ops omap_hs
>>>>     .set_ios = omap_hsmmc_set_ios,
>>>>     .get_cd = omap_hsmmc_get_cd,
>>>>     .get_ro = omap_hsmmc_get_ro,
>>>> -   /* NYET -- enable_sdio_irq */
>>>> +   .enable_sdio_irq = omap_hsmmc_enable_sdio_irq,
>>>>  };
>>>>
>>>>  #ifdef CONFIG_DEBUG_FS
>>>> @@ -1734,7 +1772,7 @@ static int __init omap_hsmmc_probe(struc
>>>>     mmc->max_seg_size = mmc->max_req_size;
>>>>
>>>>     mmc->caps |= MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED |
>>>> -                MMC_CAP_WAIT_WHILE_BUSY;
>>>> +                MMC_CAP_WAIT_WHILE_BUSY | MMC_CAP_SDIO_IRQ;
>>>>
>>>>     if (mmc_slot(host).wires >= 8)
>>>>             mmc->caps |= MMC_CAP_8_BIT_DATA;
>>>>
>>>>
>>>>
>>>>
>>>>
>>>>> John Rigby wrote:
>>>>>> I have seen several discussions about lack of sdio irq support in the
>>>>>> hsmmc driver but no patches.  Has anyone on this list implemented this
>>>>>> and/or can anyone point me to patches?
>>>>> What a coincidence ;)
>>>>>
>>>>> I'm currently working on this. See attachment what I currently have.
>>>>> It is compile tested only against recent omap linux head. I don't have
>>>>> a board using SDIO at the moment, so no real testing possible :(
>>>>>
>>>>> Some background, maybe it helps people to step in:
>>>>>
>>>>> Gumstix OMAP3 based Overo air board connects Marvell 88W8686 wifi by
>>>>> MMC port 2 in 4 bit configuration [1]. The wifi performance is quite
>>>>> bad (~100kB/s). There is some rumor that this might be SDIO irq
>>>>> related [2]. There was an attempt to fix this [3] already, but this
>>>>> doesn't work [4]. Having this, I started to look into it.
>>>>>
>>>>> I used [3], the TI Davinci driver [5] (supporting SDIO irq), the SDIO
>>>>> Simplified Specification [6] and the OMAP35x TRM [7] as starting
>>> points.
>>>>> Unfortunately, the Davinci MMC registers and irqs are different
>>>>> (Davinci has a dedicated SDIO irq). But combining [3] and [5] helps to
>>>>> get an idea what has to be done.
>>>>>
>>>>> I think the main issues of [3] were that it doesn't enable IBG for 4
>>>>> bit mode ([6] chapter 8.1.2) and that mmc_omap_irq() doesn't reset the
>>>>> irq bits.
>>>>>
>>>>> Topics I still open:
>>>>>
>>>>> - Is it always necessary to deal with IE _and_ ISE register? I'm not
>>>>> totally clear what the difference between these two registers are ;)
>>>>> And in which order they have to be set.
>>>>>
>>>>> - Davinci driver [5] in line 1115 checks for data line to call
>>>>> mmc_signal_sdio_irq() for irq enable.
>>>>>
>>>>> - Davinci driver deals with SDIO in xfer_done() (line 873)
>>>>>
>>>>> - Davinci driver sets block size to 64 if SDIO in line 701
>>>>>
>>>>> It would be quite nice if anybody likes to comment on attachment and
>>>>> help testing.
>>>>>
>>>>> Many thanks and best regards
>>>>>
>>>>> Dirk
>>>>>
>>>>> [1] http://gumstix.net/wiki/index.php?title=Overo_Wifi
>>>>>
>>>>> [2] http://groups.google.com/group/beagleboard/msg/14e822778c5eeb56
>>>>>
>>>>> [3] http://groups.google.com/group/beagleboard/msg/d0eb69f4c20673be
>>>>>
>>>>> [4] http://groups.google.com/group/beagleboard/msg/5cdfe2a319531937
>>>>>
>>>>> [5]
>>>>> http://arago-project.org/git/projects/?p=linux-
>>> davinci.git;a=blob;f=drivers/mmc/host/davinci_mmc.c;h=1bf0587250614c6d8abf
>>> e02028b96e0e47148ac8;hb=HEAD
>>>>> [6] http://www.sdcard.org/developers/tech/sdio/sd_bluetooth_spec/
>>>>>
>>>>> [7] http://focus.ti.com/lit/ug/spruf98c/spruf98c.pdf
>>>>>
>>>>>
>>>>
>>>>
>>
>>
> 

