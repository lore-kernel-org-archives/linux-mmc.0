From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: mmc: Fix HS setting in mmc_hs400_to_hs200()
Date: Tue, 5 Feb 2019 15:42:22 +0200
Message-ID: <4c8a616f-f424-fd58-43c5-d6042665bc58@intel.com>
References: <1548921212-5219-1-git-send-email-chaotian.jing@mediatek.com>
 <CAPDyKFruCCs_un1oR-gd1P=ZGryyHwKuY0SkvLO2=Jm1bGV6sQ@mail.gmail.com>
 <1548985091.10251.26.camel@mhfsdcap03>
 <CAPDyKFqHJn9uVkd5z4D5JvNKOtbn3E3SwL_WSgLb1=Lw1SgyUg@mail.gmail.com>
 <0e95e1a1-843e-38ea-c4bb-e6c48432ea7c@intel.com>
 <CAPDyKFrvSgK0Om7GUJ143j=U2xDG4n6z6Ym-1znbtMbaw==HkQ@mail.gmail.com>
 <c9120e57-ad7c-174d-c155-0186e0b9c359@intel.com>
 <CAPDyKFotLzLxW=Wq6hCPFmwTQ=T43rJV9h=+p5jfgrMBe=d8BA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFotLzLxW=Wq6hCPFmwTQ=T43rJV9h=+p5jfgrMBe=d8BA@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chaotian Jing <chaotian.jing@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>, Shawn Lin <shawn.lin@rock-chips.com>, Simon Horman <horms+renesas@verge.net.au>, Kyle Roeschley <kyle.roeschley@ni.com>, Hongjie Fang <hongjiefang@asrmicro.com>, Harish Jenny K N <harish_kandiga@mentor.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-mediatek@lists.infradead.org, srv_heupstream <srv_heupstream@mediatek.com>
List-Id: linux-mmc@vger.kernel.org

On 5/02/19 3:06 PM, Ulf Hansson wrote:
> On Mon, 4 Feb 2019 at 14:42, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> On 4/02/19 12:54 PM, Ulf Hansson wrote:
>>> On Mon, 4 Feb 2019 at 10:58, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>>>
>>>> On 1/02/19 10:10 AM, Ulf Hansson wrote:
>>>>> On Fri, 1 Feb 2019 at 02:38, Chaotian Jing <chaotian.jing@mediatek.com> wrote:
>>>>>>
>>>>>> On Thu, 2019-01-31 at 16:58 +0100, Ulf Hansson wrote:
>>>>>>> On Thu, 31 Jan 2019 at 08:53, Chaotian Jing <chaotian.jing@mediatek.com> wrote:
>>>>>>>>
>>>>>>>> mmc_hs400_to_hs200() begins with the card and host in HS400 mode.
>>>>>>>> Therefore, any commands sent to the card should use HS400 timing.
>>>>>>>> It is incorrect to reduce frequency to 50Mhz before sending the switch
>>>>>>>> command, in this case, only reduce clock frequency to 50Mhz but without
>>>>>>>> host timming change, host is still in hs400 mode but clock changed from
>>>>>>>> 200Mhz to 50Mhz, which makes the tuning result unsuitable and cause
>>>>>>>> the switch command gets response CRC error.
>>>>>>>
>>>>>>> According the eMMC spec there is no violation by decreasing the clock
>>>>>>> frequency like this. We can use whatever value <=200MHz.
>>>>>>>
>>>>>>> However, perhaps in practice this becomes an issue, due to the tuning
>>>>>>> for HS400 has been done on the "current" frequency.
>>>>>>>
>>>>>>> As as start, I think you need to clarify this in the changelog.
>>>>>>>
>>>>>> Yes, reduce clock frequency to 50Mhz is no Spec violation, but it may
>>>>>> cause __mmc_switch() gets response CRC error, decreasing the clock but
>>>>>> without HOST mode change, on the host side, host driver do not know
>>>>>> what's operation the core layer want to do and can only set current bus
>>>>>> clock to 50Mhz, without tuning parameter change, it has a chance lead to
>>>>>> response CRC error. even lower clock frequency, but with the wrong
>>>>>> tuning parameter setting(the setting is of hs400 tuning @200Mhz).
>>>>>
>>>>> Right, makes sense.
>>>>>
>>>>>>>>
>>>>>>>> this patch refers to mmc_select_hs400(), make the reduce clock frequency
>>>>>>>> after card timing change.
>>>>>>>>
>>>>>>>> Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
>>>>>>>> ---
>>>>>>>>  drivers/mmc/core/mmc.c | 8 ++++----
>>>>>>>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>>>>>>>> index da892a5..21b811e 100644
>>>>>>>> --- a/drivers/mmc/core/mmc.c
>>>>>>>> +++ b/drivers/mmc/core/mmc.c
>>>>>>>> @@ -1239,10 +1239,6 @@ int mmc_hs400_to_hs200(struct mmc_card *card)
>>>>>>>>         int err;
>>>>>>>>         u8 val;
>>>>>>>>
>>>>>>>> -       /* Reduce frequency to HS */
>>>>>>>> -       max_dtr = card->ext_csd.hs_max_dtr;
>>>>>>>> -       mmc_set_clock(host, max_dtr);
>>>>>>>> -
>>>>>>>
>>>>>>> As far as I can tell, the reason to why we change the clock frequency
>>>>>>> *before* the call to __mmc_switch() below, is probably to try to be on
>>>>>>> the safe side and conform to the spec.
>>>>>>>
>>>>>> Agree, it Must be more safe with lower clock frequency, but the
>>>>>> precondition is to make the host side recognize current timing is not
>>>>>> HS400 mode. it has no method to find a safe setting to ensure no
>>>>>> response CRC error when reduce clock from 200Mhz to 50Mhz.
>>>>>>> However, I think you have a point, as the call to __mmc_switch(),
>>>>>>> passes the "send_status" parameter as false, no other command than the
>>>>>>> CMD6 is sent to the card.
>>>>>>>
>>>>>> yes, the send status command was sent only after __mmc_switch() done.
>>>>>>>>         /* Switch HS400 to HS DDR */
>>>>>>>>         val = EXT_CSD_TIMING_HS;
>>>>>>>>         err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_HS_TIMING,
>>>>>>>> @@ -1253,6 +1249,10 @@ int mmc_hs400_to_hs200(struct mmc_card *card)
>>>>>>>>
>>>>>>>>         mmc_set_timing(host, MMC_TIMING_MMC_DDR52);
>>>>>>>>
>>>>>>>> +       /* Reduce frequency to HS */
>>>>>>>> +       max_dtr = card->ext_csd.hs_max_dtr;
>>>>>>>> +       mmc_set_clock(host, max_dtr);
>>>>>>>> +
>>>>>>>
>>>>>>> Perhaps it's even more correct to change the clock frequency before
>>>>>>> the call to mmc_set_timing(host, MMC_TIMING_MMC_DDR52). Otherwise you
>>>>>>> will be using the DDR52 timing in the controller, but with a too high
>>>>>>> frequency.
>>>>>>>
>>>>>> for Our host, it has no impact to change the clock before or after
>>>>>> change timing, as the mmc_set_timing() is only for host side, not
>>>>>> related to MMC card side and no commands sent do card before the
>>>>>> timing/clock change completed.
>>>>>
>>>>> Alright. After a second thought, it actually looks more consistent
>>>>> with mmc_select_hs400() to do it after, as what you propose in
>>>>> $subject patch.
>>>>>
>>>>> So, let's keep it as is.
>>>>>
>>>>>>>>         err = mmc_switch_status(card);
>>>>>>>>         if (err)
>>>>>>>>                 goto out_err;
>>>>>>>> --
>>>>>>>> 1.8.1.1.dirty
>>>>>>>>
>>>>>>>
>>>>>>> Finally, it sounds like you are trying to fix a real problem, can you
>>>>>>> please provide some more information what is happening when the
>>>>>>> problem occurs at your side?
>>>>>>>
>>>>>> Yes, I got a problem with new kernel version. with
>>>>>> commit:57da0c042f4af52614f4bd1a148155a299ae5cd8, this commit makes
>>>>>> re-tuning every time when access RPMB partition.
>>>>>
>>>>> Okay, could you please add this as fixes tag for the next version of the patch.
>>>>>
>>>>>>
>>>>>> in fact, our host tuning result of hs400 is very stable and almost never
>>>>>> get response CRC error with clock frequency at 200Mhz. but cannot ensure
>>>>>> this tuning result also suitable when running at HS400 mode @50Mhz. as I
>>>>>> mentioned before, the host side does not know the reason of reduce clock
>>>>>> frequency to 50Mhz at HS400 mode, so what's the host side can do is only
>>>>>> reduce the bus clock to 50Mhz, even it can just only set the tuning
>>>>>> setting to default when clock frequency lower than 50Mhz, but both card
>>>>>> & host side are still at HS400 mode, still cannot ensure this setting is
>>>>>> suitable.
>>>>>
>>>>> Right, thanks for clarifying.
>>>>>
>>>>> So I am expecting a new version with a fixes tag and some
>>>>> clarification of the changelog, then I am ready to apply this to give
>>>>> it some test.
>>>>
>>>> The switch from HS400 mode is done for tuning at times when CRC errors are a
>>>> possibility e.g. after a CRC error during transfer.  So if the frequency is
>>>> not to be reduced, then some mitigation is needed for the possibility that
>>>> the CMD6 response itself will have a CRC error.
>>>
>>> That's a good point!
>>>
>>> However, how can we know that a CMD6 command is successfully
>>> completed, if there is CRC errors detected during the transmission? I
>>> guess we can't!?
>>
>> Yes, in that case, the only option is to assume the CMD6 was successful,
>> like in
>>
>>   commit ef3d232245ab7a1bf361c52449e612e4c8b7c5ab
>>   Author: Adrian Hunter <adrian.hunter@intel.com>
>>   Date:   Fri Dec 2 13:16:35 2016 +0200
>>
>>       mmc: mmc: Relax checking for switch errors after HS200 switch
> 
> Well, relaxing the check for switch errors, is to me a different
> thing. This means we are first doing the CMD6, then allowing the
> following status command (CMD13) to have CRC errors. Actually, even
> the spec mention this as a case to consider. I guess it's because the
> card internally have switched to a new speed mode timing.
> 
> Allowing CRC errors for the actual CMD6 sound more fragile to me. Of
> course, we can always try and see what happens.
> 
> Chaotian, can you give it a go? Somehow, change the call to
> __mmc_switch() in mmc_hs400_to_hs200(), so the CMD6 doesn't have the
> CRC flag set.
> 
>>
>> If we are going to do that, then we could stick with lowering the frequency
>> first.
> 
> Let's see what Chaotian's test may show.
> 
>>
>> Also I wonder if the mediatek driver could change to fixed sampling in
>> ->set_ios() when the frequency drops for HS400 mode?
> 
> Well, this sounds like a generic problem so if this is a possible
> generic solution that would be great.
> 
> Is this what sdhci is doing already?

Not at present, but some drivers seem to be adjusting their settings for
HS400 based on the frequency e.g. sdhci_msm_hs400()
