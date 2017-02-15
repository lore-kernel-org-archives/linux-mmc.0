From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH] mmc: core: use eMMC lifetime info to warn user
Date: Wed, 15 Feb 2017 18:33:51 +0100
Message-ID: <92eb1604-9073-a32f-25bc-cf60c16eeba6@gmail.com>
References: <b3f67c2a-fbf7-b2fb-c05e-138fbdd77e39@gmail.com>
 <ba5d8572-23a0-3dd0-c8d3-d3dbbb83747f@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34069 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751905AbdBOReE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Feb 2017 12:34:04 -0500
Received: by mail-wr0-f196.google.com with SMTP id c4so6560380wrd.1
        for <linux-mmc@vger.kernel.org>; Wed, 15 Feb 2017 09:34:04 -0800 (PST)
In-Reply-To: <ba5d8572-23a0-3dd0-c8d3-d3dbbb83747f@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>, Jungseung Lee <js07.lee@samsung.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Am 15.02.2017 um 08:04 schrieb Shawn Lin:
> Hi Heiner,
> 
> On 2017/2/15 4:53, Heiner Kallweit wrote:
>> Now that the new lifetime parameters are available in struct mmc_ext_csd
>> we can use this information to warn the user if card is close to or
>> beyond end of its lifetime.
>>
> 
> This is really the user end argument that they could get it either from
> sysfs or whether user-space tools. I don't believe the user would look
> into the log but I assume you just add this for developers...
> 
Indeed it's something userspace tools should take care of.
However I'm not aware of any standard tools doing this (especially on
non-production systems), so I thought such a sysylog warning would be
a good idea.
But of course there might be other opinions on that.

>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>> ---
>>  drivers/mmc/core/bus.c | 16 ++++++++++++++++
>>  1 file changed, 16 insertions(+)
>>
>> diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
>> index 30124651..ab20d242 100644
>> --- a/drivers/mmc/core/bus.c
>> +++ b/drivers/mmc/core/bus.c
>> @@ -345,6 +345,22 @@ int mmc_add_card(struct mmc_card *card)
>>              uhs_bus_speed_mode, type, card->rca);
>>      }
>>
>> +    if (card->ext_csd.device_life_time_est_typ_a == 0xb ||
>> +        card->ext_csd.device_life_time_est_typ_b == 0xb)
>> +        pr_err("%s: memory has exceeded its life time",
>> +            mmc_hostname(card->host));
>> +    else if (card->ext_csd.device_life_time_est_typ_a == 0xa ||
>> +         card->ext_csd.device_life_time_est_typ_b == 0xa)
>> +        pr_warn("%s: memory has used more than 90%% of its life time\n",
>> +            mmc_hostname(card->host));
>> +
>> +    if (card->ext_csd.pre_eol_info == 3)
>> +        pr_err("%s: out of reserved blocks\n",
>> +            mmc_hostname(card->host));
>> +    else if (card->ext_csd.pre_eol_info == 2)
>> +        pr_warn("%s: more than 80%% of reserved blocks consumed\n",
>> +            mmc_hostname(card->host));
>> +
>>  #ifdef CONFIG_DEBUG_FS
>>      mmc_add_card_debugfs(card);
>>  #endif
>>
> 
> 

