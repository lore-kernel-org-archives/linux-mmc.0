From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 3/7] mmc: sdhci: Do not BUG on invalid vdd
Date: Fri, 27 Nov 2015 14:30:04 +0100
Message-ID: <CAPDyKFq8mhfhpCrOWv+Z0xtxvtvhcogi83WrfZnByWe97TPuuA@mail.gmail.com>
References: <1448539250-18769-1-git-send-email-adrian.hunter@intel.com>
	<1448539250-18769-4-git-send-email-adrian.hunter@intel.com>
	<371b41d66a9240958bb337dc3937f9c9@bgmail103.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f175.google.com ([209.85.160.175]:36492 "EHLO
	mail-yk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751504AbbK0NaF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 27 Nov 2015 08:30:05 -0500
Received: by ykdr82 with SMTP id r82so117750651ykd.3
        for <linux-mmc@vger.kernel.org>; Fri, 27 Nov 2015 05:30:04 -0800 (PST)
In-Reply-To: <371b41d66a9240958bb337dc3937f9c9@bgmail103.nvidia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Venu Byravarasu <vbyravarasu@nvidia.com>, Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, Chaotian Jing <chaotian.jing@mediatek.com>, Wenkai Du <wenkai.du@intel.com>

On 27 November 2015 at 06:08, Venu Byravarasu <vbyravarasu@nvidia.com> wrote:
>
>
>> -----Original Message-----
>> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
>> owner@vger.kernel.org] On Behalf Of Adrian Hunter
>> Sent: Thursday, November 26, 2015 5:31 PM
>> To: Ulf Hansson
>> Cc: linux-mmc; Jaehoon Chung; Chaotian Jing; Wenkai Du
>> Subject: [PATCH 3/7] mmc: sdhci: Do not BUG on invalid vdd
>>
>> The driver may not be able to set the power correctly but that is not a reason
>> to BUG().
>>
>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>> ---
>>  drivers/mmc/host/sdhci.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c index
>> 2b17cc1246ca..5f8b0766428c 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -1299,7 +1299,10 @@ static void sdhci_set_power(struct sdhci_host
>> *host, unsigned char mode,
>>                       pwr = SDHCI_POWER_330;
>>                       break;
>>               default:
>> -                     BUG();
>> +                     WARN(1, "%s: Invalid vdd %#x\n",
>> +                          mmc_hostname(host->mmc), vdd);
>> +                     pwr = 0;
>
> As pwr is initialized to 0 during declaration, don't see a need for above statement.
> However agree with your point that BUG can be replaced with a warn message.
>

I have updated the patch accordingly and added Venu's reviewed-by tag.

Kind regards
Uffe


>> +                     break;
>>               }
>>       }
>>
>> --
>> 1.9.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in the
>> body of a message to majordomo@vger.kernel.org More majordomo info at
>> http://vger.kernel.org/majordomo-info.html
> -----------------------------------------------------------------------------------
> This email message is for the sole use of the intended recipient(s) and may contain
> confidential information.  Any unauthorized review, use, disclosure or distribution
> is prohibited.  If you are not the intended recipient, please contact the sender by
> reply email and destroy all copies of the original message.
> -----------------------------------------------------------------------------------
