From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 1/3] mmc: dw_mmc: use mmc_regulator_get_supply to handle
 regulators
Date: Tue, 01 Jul 2014 13:25:25 +0900
Message-ID: <53B23835.3010204@samsung.com>
References: <1403520321-2431-1-git-send-email-yuvaraj.cd@samsung.com>
 <1403520321-2431-2-git-send-email-yuvaraj.cd@samsung.com>
 <CAD=FV=UGjm9y3XoBgWKjw9kp9W=ZrwB-S6Lh7T_LBUgCQZn1ag@mail.gmail.com>
 <CAKuRcO+OaknUtj9mJ+SQJPMj70hdLTMkDYCXq4L5JdwzDKdj6g@mail.gmail.com>
 <CAD=FV=Vy5vRan0KEDFFwVO0omgsUMwJK6WwCsWxGYynzT-e5ig@mail.gmail.com>
 <53B15476.4030000@samsung.com>
 <CAD=FV=WCFFvb1+d3XEhTNXgzSksC__t4g1OLvhO-iDXSHHPFsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <CAD=FV=WCFFvb1+d3XEhTNXgzSksC__t4g1OLvhO-iDXSHHPFsQ@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: Yuvaraj Kumar <yuvaraj.cd@gmail.com>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Chris Ball <cjb@laptop.org>, Seungwon Jeon <tgih.jun@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Sonny Rao <sonnyrao@chromium.org>, Tomasz Figa <t.figa@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, sunil joshi <joshi@samsung.com>, ks.giri@samsung.com, Prashanth G <prashanth.g@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
List-Id: linux-mmc@vger.kernel.org

Hi Doug.

On 07/01/2014 12:06 AM, Doug Anderson wrote:
> Jaehoon,
> 
> On Mon, Jun 30, 2014 at 5:13 AM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>> On 06/27/2014 01:18 AM, Doug Anderson wrote:
>>> Yuvaraj,
>>>
>>> On Thu, Jun 26, 2014 at 4:21 AM, Yuvaraj Kumar <yuvaraj.cd@gmail.com> wrote:
>>>> Doug
>>>>
>>>> On Tue, Jun 24, 2014 at 11:30 PM, Doug Anderson <dianders@chromium.org> wrote:
>>>>> Yuvaraj,
>>>>>
>>>>> On Mon, Jun 23, 2014 at 3:45 AM, Yuvaraj Kumar C D <yuvaraj.cd@gmail.com> wrote:
>>>>>> This patch makes use of mmc_regulator_get_supply() to handle
>>>>>> the vmmc and vqmmc regulators.Also it moves the code handling
>>>>>> the these regulators to dw_mci_set_ios().It turned on the vmmc
>>>>>> and vqmmc during MMC_POWER_UP and MMC_POWER_ON,and turned off
>>>>>> during MMC_POWER_OFF.
>>>>>>
>>>>>> Signed-off-by: Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
>>>>>> ---
>>>>>>  drivers/mmc/host/dw_mmc.c |   71 ++++++++++++++++++++++-----------------------
>>>>>>  drivers/mmc/host/dw_mmc.h |    2 ++
>>>>>>  2 files changed, 36 insertions(+), 37 deletions(-)
>>>>>
>>>>> Perhaps you could CC me on the whole series for the next version since
>>>>> I was involved in privately reviewing previous versions?
>>>> It was just accidental missing you in the CC .Surely i will add you in
>>>> CC for next versions.
>>>>>
>>>>> Overall caveat for my review is that I'm nowhere near an SD/MMC expert.
>>>>>
>>>>>
>>>>>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>>>>>> index 1ac227c..f5cabce 100644
>>>>>> --- a/drivers/mmc/host/dw_mmc.c
>>>>>> +++ b/drivers/mmc/host/dw_mmc.c
>>>>>> @@ -937,6 +937,7 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>>>>>>         struct dw_mci_slot *slot = mmc_priv(mmc);
>>>>>>         const struct dw_mci_drv_data *drv_data = slot->host->drv_data;
>>>>>>         u32 regs;
>>>>>> +       int ret;
>>>>>>
>>>>>>         switch (ios->bus_width) {
>>>>>>         case MMC_BUS_WIDTH_4:
>>>>>> @@ -975,16 +976,41 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>>>>>>
>>>>>>         switch (ios->power_mode) {
>>>>>>         case MMC_POWER_UP:
>>>>>> +               if ((!IS_ERR(mmc->supply.vmmc)) &&
>>>>>> +                               !test_bit(DW_MMC_CARD_POWERED, &slot->flags)) {
>>>>>> +                       ret = regulator_enable(mmc->supply.vmmc);
>>>>>> +                       if (!ret)
>>>>>> +                               set_bit(DW_MMC_CARD_POWERED, &slot->flags);
>>>>>> +               }
>>>>>
>>>>> As per below, I'm not sure why you'd want to turn on vqmmc and vmmc at
>>>>> different times.
>>>> As you can see people's have different opinion on this.When i had a
>>>> look at the other drivers in the subsystem which does in the same flow
>>>> as above.However i will change in the next version.
>>>
>>> Given my self proclaimed lack of SD/MMC knowledge, if others have a
>>> good reason for doing them separate then you should do it that way.
>>> So far I haven't heard that reason but I certainly could be wrong.
>>
>> At first time, i had believed nothing problem that it turns on vmmc and vqmmc at different time.
>> It could have the potential problem.
> 
> OK.  As I said I'm nowhere near an expert on SD/MMC, so if there's
> something out there that says that turning vmmc on before vqmmc is the
> right thing to do then I guess that's the answer.  I would still be
> very curious to get more details on what the potential problem is.
> Could you provide a reference to documentation that says vmmc should
> be on before vqmmc or describe a situation where it's important?

Actually i didn't have any documentation.
According to eMMC spec, vmmc and vqmmc should be used with same power supply.
In this case, it will turn on vmmc and vqmmc at same time.
If vqmmc is used with the I/O power supply, the sequence isn't important, 
but vmmc and vqmmc need to wait until stabling the power.

I didn't know Potential problem is what problem.
(Potential problem is mentioned from our H/W team member. H/W mis-operating?)
I didn't have the expert H/W knowledge.

Thanks!

Bset Regards,
Jaehoon Chung

> 
> Thanks!
> 
> -Doug
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
