From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v2] mmc: core: Fix init_card in 52Mhz
Date: Fri, 9 Oct 2015 10:57:53 +0300
Message-ID: <56177381.9020509@intel.com>
References: <1444288147-24013-1-git-send-email-chaotian.jing@mediatek.com>
 <CAPDyKFqrjP3-y+ucm5ybwXefsDLOYcPF9XqMciwhRkjD5NXLBg@mail.gmail.com>
 <56166988.20900@intel.com>
 <CAPDyKFoWWMXC-DECqhw=EXerid5toWKxr4uLq0WevPo8LrrDqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:22184 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755675AbbJIIAx (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 9 Oct 2015 04:00:53 -0400
In-Reply-To: <CAPDyKFoWWMXC-DECqhw=EXerid5toWKxr4uLq0WevPo8LrrDqw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chaotian Jing <chaotian.jing@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, Fabio Estevam <fabio.estevam@freescale.com>, Johan Rudholm <johan.rudholm@axis.com>, Gwendal Grignou <gwendal@chromium.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-mediatek@lists.infradead.org, srv_heupstream <srv_heupstream@mediatek.com>, Sascha Hauer <kernel@pengutronix.de>

On 08/10/15 16:35, Ulf Hansson wrote:
> On 8 October 2015 at 15:03, Adrian Hunter <adrian.hunter@intel.com> wrote:
>> On 08/10/15 13:59, Ulf Hansson wrote:
>>> On 8 October 2015 at 09:09, Chaotian Jing <chaotian.jing@mediatek.com> wrote:
>>>> Suppose that we got a data crc error, and it triggers the mmc_reset.
>>>> mmc_reset will call mmc_send_status to see if HW reset was supported.
>>>> before issue CMD13, it will do retune, and if EMMC was in HS400 mode,
>>>> it will reduce frequency to 52Mhz firstly, then results in card init
>>>> was doing at 52Mhz.
>>>> The mmc_send_status was originally only done for mmc_test, so if retune
>>>> needed, do not call mmc_send_status.
>>>>
>>>> Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
>>>> Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
>>>> ---
>>>>  drivers/mmc/card/mmc_test.c | 6 ++++++
>>>>  drivers/mmc/core/mmc.c      | 2 +-
>>>>  2 files changed, 7 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/mmc/card/mmc_test.c b/drivers/mmc/card/mmc_test.c
>>>> index b78cf5d..2f78bfb 100644
>>>> --- a/drivers/mmc/card/mmc_test.c
>>>> +++ b/drivers/mmc/card/mmc_test.c
>>>> @@ -2272,6 +2272,12 @@ static int mmc_test_hw_reset(struct mmc_test_card *test)
>>>>         if (!mmc_card_mmc(card) || !mmc_can_reset(card))
>>>>                 return RESULT_UNSUP_CARD;
>>>>
>>>> +       if (host->need_retune) {
>>>> +               pr_info("%s: cannot test hw reset because retune needed\n",
>>>> +                       mmc_hostname(test->card->host));
>>>> +               return RESULT_FAIL;
>>>> +       }
>>>> +
>>>>         err = mmc_hw_reset(host);
>>>>         if (!err)
>>>>                 return RESULT_OK;
>>>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>>>> index e726903..647c96d 100644
>>>> --- a/drivers/mmc/core/mmc.c
>>>> +++ b/drivers/mmc/core/mmc.c
>>>> @@ -1938,7 +1938,7 @@ static int mmc_reset(struct mmc_host *host)
>>>>         host->ops->hw_reset(host);
>>>>
>>>>         /* If the reset has happened, then a status command will fail */
>>>> -       if (!mmc_send_status(card, &status)) {
>>>> +       if (!host->need_retune && !mmc_send_status(card, &status)) {
>>>
>>> No, this seem like the wrong solution! The main purpose of mmc_reset()
>>> is to try to reset and re-initiate the card, to make it operational
>>> again.
>>>
>>> I can't find a good reason to why we want to do a mmc_send_status() at
>>> this point, as even if it succeeds it will only tell us that the card
>>> has not been "hw-reset". No matter what, we should still try to make
>>> it fully operational again and thus give mmc_init_card() a try.
>>>
>>> >From this reasoning, I suggest we remove the call to mmc_send_status()
>>> from this path, as that will also address your issue with CRC errors
>>> in combination with re-tune.
>>
>> Then you need to remove the hw_reset test from mmc_test.  Refer:
>>
>>         http://marc.info/?l=linux-mmc&m=144360165906544&w=2
>>
> 
> I realize that the test becomes a bit different, but I don't think it's useless.
> 
> If we add a check for MMC_CAP_HW_RESET and verify that the
> host->ops->hw_reset exists, then we can assume that the "hw_reset"
> sequence has executed. And if mmc_init_card() fails, that would
> probably mean that the reset also failed, right?

In the test case, the card is in a working state.  Generally I would then
expect reinitialization to work irrespective of whether or not the hardware
is actually reset.

Here are some other options:
	1. have mmc_test hook the host->ops->hw_reset() fn and do the send_status
itself.
	2. have mmc_test set a flag on the card that it is being tested
and only do the send_status if the flag is set
	3. remove the send_status call and rename the mmc_test from "eMMC hardware
reset" to just "Reset test (doesn't check hw reset did reset)"

