From: Yuvaraj Kumar <yuvaraj.cd@gmail.com>
Subject: Re: [PATCH 1/3] mmc: dw_mmc: use mmc_regulator_get_supply to handle regulators
Date: Fri, 27 Jun 2014 16:29:45 +0530
Message-ID: <CAKuRcOLDCFQnw01ReKqNNfiiCwSWwi6Rd7UZFph+JzK2CQ4T_w@mail.gmail.com>
References: <1403520321-2431-1-git-send-email-yuvaraj.cd@samsung.com>
	<1403520321-2431-2-git-send-email-yuvaraj.cd@samsung.com>
	<CAD=FV=UGjm9y3XoBgWKjw9kp9W=ZrwB-S6Lh7T_LBUgCQZn1ag@mail.gmail.com>
	<CAKuRcO+OaknUtj9mJ+SQJPMj70hdLTMkDYCXq4L5JdwzDKdj6g@mail.gmail.com>
	<CAD=FV=Vy5vRan0KEDFFwVO0omgsUMwJK6WwCsWxGYynzT-e5ig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <CAD=FV=Vy5vRan0KEDFFwVO0omgsUMwJK6WwCsWxGYynzT-e5ig@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>
Cc: linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Jaehoon Chung <jh80.chung@samsung.com>, Chris Ball <cjb@laptop.org>, Seungwon Jeon <tgih.jun@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Sonny Rao <sonnyrao@chromium.org>, Tomasz Figa <t.figa@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, sunil joshi <joshi@samsung.com>, ks.giri@samsung.com, Prashanth G <prashanth.g@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
List-Id: linux-mmc@vger.kernel.org

On Thu, Jun 26, 2014 at 9:48 PM, Doug Anderson <dianders@chromium.org> wrote:
> Yuvaraj,
>
> On Thu, Jun 26, 2014 at 4:21 AM, Yuvaraj Kumar <yuvaraj.cd@gmail.com> wrote:
>> Doug
>>
>> On Tue, Jun 24, 2014 at 11:30 PM, Doug Anderson <dianders@chromium.org> wrote:
>>> Yuvaraj,
>>>
>>> On Mon, Jun 23, 2014 at 3:45 AM, Yuvaraj Kumar C D <yuvaraj.cd@gmail.com> wrote:
>>>> This patch makes use of mmc_regulator_get_supply() to handle
>>>> the vmmc and vqmmc regulators.Also it moves the code handling
>>>> the these regulators to dw_mci_set_ios().It turned on the vmmc
>>>> and vqmmc during MMC_POWER_UP and MMC_POWER_ON,and turned off
>>>> during MMC_POWER_OFF.
>>>>
>>>> Signed-off-by: Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
>>>> ---
>>>>  drivers/mmc/host/dw_mmc.c |   71 ++++++++++++++++++++++-----------------------
>>>>  drivers/mmc/host/dw_mmc.h |    2 ++
>>>>  2 files changed, 36 insertions(+), 37 deletions(-)
>>>
>>> Perhaps you could CC me on the whole series for the next version since
>>> I was involved in privately reviewing previous versions?
>> It was just accidental missing you in the CC .Surely i will add you in
>> CC for next versions.
>>>
>>> Overall caveat for my review is that I'm nowhere near an SD/MMC expert.
>>>
>>>
>>>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>>>> index 1ac227c..f5cabce 100644
>>>> --- a/drivers/mmc/host/dw_mmc.c
>>>> +++ b/drivers/mmc/host/dw_mmc.c
>>>> @@ -937,6 +937,7 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>>>>         struct dw_mci_slot *slot = mmc_priv(mmc);
>>>>         const struct dw_mci_drv_data *drv_data = slot->host->drv_data;
>>>>         u32 regs;
>>>> +       int ret;
>>>>
>>>>         switch (ios->bus_width) {
>>>>         case MMC_BUS_WIDTH_4:
>>>> @@ -975,16 +976,41 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>>>>
>>>>         switch (ios->power_mode) {
>>>>         case MMC_POWER_UP:
>>>> +               if ((!IS_ERR(mmc->supply.vmmc)) &&
>>>> +                               !test_bit(DW_MMC_CARD_POWERED, &slot->flags)) {
>>>> +                       ret = regulator_enable(mmc->supply.vmmc);
>>>> +                       if (!ret)
>>>> +                               set_bit(DW_MMC_CARD_POWERED, &slot->flags);
>>>> +               }
>>>
>>> As per below, I'm not sure why you'd want to turn on vqmmc and vmmc at
>>> different times.
>> As you can see people's have different opinion on this.When i had a
>> look at the other drivers in the subsystem which does in the same flow
>> as above.However i will change in the next version.
>
> Given my self proclaimed lack of SD/MMC knowledge, if others have a
> good reason for doing them separate then you should do it that way.
> So far I haven't heard that reason but I certainly could be wrong.
>
>
>>>> @@ -225,6 +225,8 @@ struct dw_mci_slot {
>>>>         unsigned long           flags;
>>>>  #define DW_MMC_CARD_PRESENT    0
>>>>  #define DW_MMC_CARD_NEED_INIT  1
>>>> +#define DW_MMC_CARD_POWERED    2
>>>> +#define DW_MMC_IO_POWERED      3
>>>
>>> I don't really think you should have two bits here.  From my
>>> understanding of SD cards there should be very little reason to have
>>> vqmmc and vmmc not powered at the same time.
>> I think if i can use mmc_regulator_set_ocr(), we don't need additional
>> flag.But for tps65090 mmc_regulator_get_ocr() and
>> mmc_regulator_set_ocr() is failing as its a fixed-regulator.
>
> Can you explain more about what's failing?  It sure looks like mmc
> core is supposed to handle this given comments below
>
> /*
> * If we're using a fixed/static regulator, don't call
> * regulator_set_voltage; it would fail.
> */
tps65090 driver does not register through fixed regulator framework.It
uses normal regulator framework and supports only
enable/disable/is_enabled callbacks.Also it lacks certain callbacks
for list_voltage, get_voltage ,set_voltage etc.
[    2.306476] dwmmc_exynos 12220000.mmc: Failed getting OCR mask: -22
[    2.393403] dwmmc_exynos 12220000.mmc: could not set regulator OCR (-22)
For the above reason,regulator framework treats fet4 as unused
regulator and disables the vmmc regulator.
> voltage = regulator_get_voltage(supply);
>
> if (!regulator_can_change_voltage(supply))
>   min_uV = max_uV = voltage;
>
>
> -Doug
