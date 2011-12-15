From: Hein_Tibosch <hein_tibosch@yahoo.es>
Subject: Re: [PATCH V2] mmc: core: Add host capability check for power class
Date: Thu, 15 Dec 2011 17:57:18 +0800
Message-ID: <4EE9C47E.6040101@yahoo.es>
References: <1323921517-31241-1-git-send-email-girish.shivananjappa@linaro.org> <CADGdYn5MYLD4ReuBZuF7QCkJo34aDhGsDpDWX_S3DuKNk9J85Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <CADGdYn5MYLD4ReuBZuF7QCkJo34aDhGsDpDWX_S3DuKNk9J85Q@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: amit kachhap <amit.kachhap@linaro.org>
Cc: Girish K S <girish.shivananjappa@linaro.org>, linux-mmc@vger.kernel.org, patches@linaro.org, linux-samsung-soc@vger.kernel.org, subhashj@codeaurora.org, Chris Ball <cjb@laptop.org>
List-Id: linux-mmc@vger.kernel.org

On 12/15/2011 2:03 PM, amit kachhap wrote:

> On Thu, Dec 15, 2011 at 9:28 AM, Girish K S
> <girish.shivananjappa@linaro.org> wrote:
>> This patch adds a check whether the host supports maximum current value
>> obtained from the device's extended csd register for a selected interface
>> voltage and frequency.
>>
>> cc: Chris Ball <cjb@laptop.org>
>> Signed-off-by: Girish K S <girish.shivananjappa@linaro.org>
>> ---
>> Changes in v2:
>>        deleted a unnecessary if else condition identified by subhash J
>> Changes in v1:
>>       reduced the number of comparisons as per Hein's suggestion
>>
>>  drivers/mmc/core/mmc.c   |   19 +++++++++++++++++++
>>  include/linux/mmc/card.h |    4 ++++
>>  2 files changed, 23 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>> index 006e932..b9ef777 100644
>> --- a/drivers/mmc/core/mmc.c
>> +++ b/drivers/mmc/core/mmc.c
>> @@ -688,6 +688,25 @@ static int mmc_select_powerclass(struct mmc_card *card,
>>                pwrclass_val = (pwrclass_val & EXT_CSD_PWR_CL_4BIT_MASK) >>
>>                                EXT_CSD_PWR_CL_4BIT_SHIFT;
>>
>> +       if (pwrclass_val >= MMC_MAX_CURRENT_800)
> Hi girish,
>
> These checks can be made like ,
> if (pwrclass_val > MMC_MAX_CURRENT_800)
>         pwrclass_val = MMC_MAX_CURRENT_800;
> Applicable in all below conditional checks.
Hi both,

Suppose pwrclass_val == MMC_MAX_CURRENT_800 (13),
then with

+       if (pwrclass_val > MMC_MAX_CURRENT_800)
+               pwrclass_val = MMC_MAX_CURRENT_800;
+       else if (pwrclass_val > MMC_MAX_CURRENT_600)
+               pwrclass_val = MMC_MAX_CURRENT_600;

it would get a value of MMC_MAX_CURRENT_600, which is too low

Hein
