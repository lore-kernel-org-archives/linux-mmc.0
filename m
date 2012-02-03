From: Namjae Jeon <linkinjeon@gmail.com>
Subject: Re: [RESEND PATCH V3] mmc: core: Detect card removal on I/O error
Date: Fri, 3 Feb 2012 20:00:33 +0900
Message-ID: <CAKYAXd8oBqXPbDdH8YyncstM+VE92fzhF1QoH7kC4=-aG2mpdA@mail.gmail.com>
References: <1328261593-6112-1-git-send-email-ulf.hansson@stericsson.com>
	<4F2BB82B.7000400@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:36530 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755922Ab2BCLAf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 3 Feb 2012 06:00:35 -0500
Received: by bkcjm19 with SMTP id jm19so2955586bkc.19
        for <linux-mmc@vger.kernel.org>; Fri, 03 Feb 2012 03:00:33 -0800 (PST)
In-Reply-To: <4F2BB82B.7000400@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Ulf Hansson <ulf.hansson@stericsson.com>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Adrian Hunter <adrian.hunter@intel.com>, Per Forlin <per.forlin@stericsson.com>, Johan Rudholm <johan.rudholm@stericsson.com>, Lee Jones <lee.jones@linaro.org>

2012/2/3 Jaehoon Chung <jh80.chung@samsung.com>:
> On 02/03/2012 06:33 PM, Ulf Hansson wrote:
>
>> To prevent I/O as soon as possible at card removal, a new
>> detect work is re-scheduled without a delay to let a rescan
>> remove the card device as soon a possible.
>>
>> Additionally, MMC_CAP2_DETECT_ON_ERR can now be used to handle
>> "slowly" removed cards that a scheduled detect work did not
>> detect as removed. To prevent further I/O requests for these
>> lingering removed cards, check if card has been removed and then
>> schedule a detect work to properly remove it.
>>
>> Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
>> ---
>>
>> Changes in v3:
>> =C2=A0 =C2=A0 =C2=A0 - Check for card is NULL and minor code simplif=
ications.
>>
>> Changes in v2:
>> =C2=A0 =C2=A0 =C2=A0 - Updated according to review comments.
>> =C2=A0 =C2=A0 =C2=A0 - Merging two patches for this feature into one=
=2E
>>
>> ---
>> =C2=A0drivers/mmc/core/core.c =C2=A0| =C2=A0 24 ++++++++++++++++++++=
+---
>> =C2=A0include/linux/mmc/host.h | =C2=A0 =C2=A01 +
>> =C2=A02 files changed, 22 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>> index bec0bf2..9645e8c 100644
>> --- a/drivers/mmc/core/core.c
>> +++ b/drivers/mmc/core/core.c
>> @@ -2077,18 +2077,36 @@ int _mmc_detect_card_removed(struct mmc_host=
 *host)
>> =C2=A0int mmc_detect_card_removed(struct mmc_host *host)
>> =C2=A0{
>> =C2=A0 =C2=A0 =C2=A0 struct mmc_card *card =3D host->card;
>> + =C2=A0 =C2=A0 int ret;
>>
>> =C2=A0 =C2=A0 =C2=A0 WARN_ON(!host->claimed);
>> +
>> + =C2=A0 =C2=A0 if (!card)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 1;
>> +
>> + =C2=A0 =C2=A0 ret =3D mmc_card_removed(card);
>
> this function called mmc_detect_card_removed(card->host) in block.c.
> then card isn't NULL..isn't?
> Just wondering... :)
If we think this function is used anywhere else next time, it is reason=
able.
And old code also checked null.
>
> Best Regards,
> Jaehoon Chung
>
>> =C2=A0 =C2=A0 =C2=A0 /*
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0* The card will be considered unchanged u=
nless we have been asked to
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0* detect a change or host requires pollin=
g to provide card detection.
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
>> - =C2=A0 =C2=A0 if (card && !host->detect_change && !(host->caps & M=
MC_CAP_NEEDS_POLL))
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return mmc_card_removed(=
card);
>> + =C2=A0 =C2=A0 if (!host->detect_change && !(host->caps & MMC_CAP_N=
EEDS_POLL) &&
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 !(host->caps2 & MMC_CAP2_DETECT_ON_ERR=
))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;
>>
>> =C2=A0 =C2=A0 =C2=A0 host->detect_change =3D 0;
>> + =C2=A0 =C2=A0 if (!ret) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D _mmc_detect_card=
_removed(host);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 /*
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0* Schedule a detect work as soon as possible to let a
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0* rescan handle the card removal.
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0*/
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 cancel_delayed_work(&host->detect);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 mmc_detect_change(host, 0);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> + =C2=A0 =C2=A0 }
>>
>> - =C2=A0 =C2=A0 return _mmc_detect_card_removed(host);
>> + =C2=A0 =C2=A0 return ret;
>> =C2=A0}
>> =C2=A0EXPORT_SYMBOL(mmc_detect_card_removed);
>>
>> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
>> index dd13e05..368a2b9 100644
>> --- a/include/linux/mmc/host.h
>> +++ b/include/linux/mmc/host.h
>> @@ -257,6 +257,7 @@ struct mmc_host {
>> =C2=A0#define MMC_CAP2_HS200_1_2V_SDR =C2=A0 =C2=A0 =C2=A0(1 << 6) =C2=
=A0 =C2=A0 =C2=A0 =C2=A0/* can support */
>> =C2=A0#define MMC_CAP2_HS200 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 (MMC_CAP2_HS200_1_8V_SDR | \
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0MMC_CAP2_HS200_1_2V_SDR)
>> +#define MMC_CAP2_DETECT_ON_ERR =C2=A0 =C2=A0 =C2=A0 (1 << 7) =C2=A0=
 =C2=A0 =C2=A0 =C2=A0/* On I/O err check card removal */
>>
>> =C2=A0 =C2=A0 =C2=A0 mmc_pm_flag_t =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 pm_caps; =C2=A0 =C2=A0 =C2=A0 =C2=A0/* supported pm features */
>> =C2=A0 =C2=A0 =C2=A0 unsigned int =C2=A0 =C2=A0 =C2=A0 =C2=A0power_n=
otify_type;
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
