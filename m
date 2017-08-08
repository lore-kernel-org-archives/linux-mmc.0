From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: mmc: fix switch to 1V8 for hs400es mode
Date: Tue, 8 Aug 2017 12:12:30 +0200
Message-ID: <CAPDyKFpE+=wYYd9Giub9eKCD5Jf9Z-Now8T9jBataGE3teD82w@mail.gmail.com>
References: <1499418535-10161-1-git-send-email-haibo.chen@nxp.com> <ebe80597-2f95-1e08-937a-255153bfb3fb@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <ebe80597-2f95-1e08-937a-255153bfb3fb@rock-chips.com>
Sender: stable-owner@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Haibo Chen <haibo.chen@nxp.com>, "# 4.0+" <stable@vger.kernel.org>, Doug Anderson <dianders@chromium.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 11 July 2017 at 02:38, Shawn Lin <shawn.lin@rock-chips.com> wrote:
> Hi Haibo,
>
> On 2017/7/7 17:08, Haibo Chen wrote:
>>
>> Change the default err value to -EINVAL, otherwise signal voltage
>> will not change to 1V8 if card or controller only support 1V8 for
>> HS400ES mode.
>>
>
> This description is misleading as hs400(es) must be running under
> 1.8v vqmmc. But the patch itself is correct.
>
>
>> Fixes: commit 1720d3545b77 ("mmc: core: switch to 1V8 or 1V2 for hs400es
>> mode")
>> Cc: <stable@vger.kernel.org>
>> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
>> ---
>>   drivers/mmc/core/mmc.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>> index 92c6167..336a950 100644
>> --- a/drivers/mmc/core/mmc.c
>> +++ b/drivers/mmc/core/mmc.c
>> @@ -1289,7 +1289,7 @@ int mmc_hs400_to_hs200(struct mmc_card *card)
>>   static int mmc_select_hs400es(struct mmc_card *card)
>>   {
>>         struct mmc_host *host = card->host;
>> -       int err = 0;
>> +       int err = -EINVAL;
>>         u8 val;
>>         if (!(host->caps & MMC_CAP_8_BIT_DATA)) {
>>
>

Seems like Haibo has been busy. Shawn, if you think it's important,
could you pick up this and re-submit?

Kind regards
Uffe
