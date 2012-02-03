From: Jae hoon Chung <jh80.chung@gmail.com>
Subject: Re: [RESEND PATCH V3] mmc: core: Detect card removal on I/O error
Date: Fri, 3 Feb 2012 20:49:42 +0900
Message-ID: <CAELcNGS84rcdXoGw4_3Na9LBdkxDn05E9aUL2k92edmbpWi-_w@mail.gmail.com>
References: <1328261593-6112-1-git-send-email-ulf.hansson@stericsson.com>
	<4F2BB82B.7000400@samsung.com>
	<CAKYAXd8oBqXPbDdH8YyncstM+VE92fzhF1QoH7kC4=-aG2mpdA@mail.gmail.com>
	<4F2BC2A0.9080805@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:60518 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752196Ab2BCLto convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 3 Feb 2012 06:49:44 -0500
Received: by bkcjm19 with SMTP id jm19so2993296bkc.19
        for <linux-mmc@vger.kernel.org>; Fri, 03 Feb 2012 03:49:42 -0800 (PST)
In-Reply-To: <4F2BC2A0.9080805@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: Namjae Jeon <linkinjeon@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Adrian Hunter <adrian.hunter@intel.com>, Per FORLIN <per.forlin@stericsson.com>, Johan RUDHOLM <johan.rudholm@stericsson.com>, Lee Jones <lee.jones@linaro.org>

2012/2/3 Ulf Hansson <ulf.hansson@stericsson.com>:
> Namjae Jeon wrote:
>>
>> 2012/2/3 Jaehoon Chung <jh80.chung@samsung.com>:
>>>
>>> On 02/03/2012 06:33 PM, Ulf Hansson wrote:
>>>
>>>> To prevent I/O as soon as possible at card removal, a new
>>>> detect work is re-scheduled without a delay to let a rescan
>>>> remove the card device as soon a possible.
>>>>
>>>> Additionally, MMC_CAP2_DETECT_ON_ERR can now be used to handle
>>>> "slowly" removed cards that a scheduled detect work did not
>>>> detect as removed. To prevent further I/O requests for these
>>>> lingering removed cards, check if card has been removed and then
>>>> schedule a detect work to properly remove it.
>>>>
>>>> Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
>>>> ---
>>>>
>>>> Changes in v3:
>>>> =A0 =A0 =A0- Check for card is NULL and minor code simplifications=
=2E
>>>>
>>>> Changes in v2:
>>>> =A0 =A0 =A0- Updated according to review comments.
>>>> =A0 =A0 =A0- Merging two patches for this feature into one.
>>>>
>>>> ---
>>>> =A0drivers/mmc/core/core.c =A0| =A0 24 +++++++++++++++++++++---
>>>> =A0include/linux/mmc/host.h | =A0 =A01 +
>>>> =A02 files changed, 22 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>>>> index bec0bf2..9645e8c 100644
>>>> --- a/drivers/mmc/core/core.c
>>>> +++ b/drivers/mmc/core/core.c
>>>> @@ -2077,18 +2077,36 @@ int _mmc_detect_card_removed(struct mmc_ho=
st
>>>> *host)
>>>> =A0int mmc_detect_card_removed(struct mmc_host *host)
>>>> =A0{
>>>> =A0 =A0 =A0struct mmc_card *card =3D host->card;
>>>> + =A0 =A0 int ret;
>>>>
>>>> =A0 =A0 =A0WARN_ON(!host->claimed);
>>>> +
>>>> + =A0 =A0 if (!card)
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 return 1;
>>>> +
>>>> + =A0 =A0 ret =3D mmc_card_removed(card);
>>>
>>> this function called mmc_detect_card_removed(card->host) in block.c=
=2E
>>> then card isn't NULL..isn't?
>>> Just wondering... :)
>
>
> Yes, if called from block device thread (block.c) card is always pres=
ent.
>
>
>> If we think this function is used anywhere else next time, it is
>> reasonable.
>> And old code also checked null.
>
>
> That is why I also agree that this should be checked. It is an export=
ed
> function and who know if it is going to used from some other context =
in
> future.
I agree this...thanks for Mr.Jeon and Ulf's reply..
>
>
>>> Best Regards,
>>> Jaehoon Chung
>>>
>>>> =A0 =A0 =A0/*
>>>> =A0 =A0 =A0 * The card will be considered unchanged unless we have=
 been asked
>>>> to
>>>> =A0 =A0 =A0 * detect a change or host requires polling to provide =
card
>>>> detection.
>>>> =A0 =A0 =A0 */
>>>> - =A0 =A0 if (card && !host->detect_change && !(host->caps &
>>>> MMC_CAP_NEEDS_POLL))
>>>> - =A0 =A0 =A0 =A0 =A0 =A0 return mmc_card_removed(card);
>>>> + =A0 =A0 if (!host->detect_change && !(host->caps & MMC_CAP_NEEDS=
_POLL) &&
>>>> + =A0 =A0 =A0 =A0 !(host->caps2 & MMC_CAP2_DETECT_ON_ERR))
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>>>>
>>>> =A0 =A0 =A0host->detect_change =3D 0;
>>>> + =A0 =A0 if (!ret) {
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D _mmc_detect_card_removed(host);
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 if (ret) {
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Schedule a detect w=
ork as soon as possible to
>>>> let a
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* rescan handle the c=
ard removal.
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cancel_delayed_work(&hos=
t->detect);
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_detect_change(host, =
0);
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>>>> + =A0 =A0 }
>>>>
>>>> - =A0 =A0 return _mmc_detect_card_removed(host);
>>>> + =A0 =A0 return ret;
>>>> =A0}
>>>> =A0EXPORT_SYMBOL(mmc_detect_card_removed);
>>>>
>>>> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
>>>> index dd13e05..368a2b9 100644
>>>> --- a/include/linux/mmc/host.h
>>>> +++ b/include/linux/mmc/host.h
>>>> @@ -257,6 +257,7 @@ struct mmc_host {
>>>> =A0#define MMC_CAP2_HS200_1_2V_SDR =A0 =A0 =A0(1 << 6) =A0 =A0 =A0=
 =A0/* can support */
>>>> =A0#define MMC_CAP2_HS200 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (MMC_CAP2_HS=
200_1_8V_SDR | \
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MMC_CA=
P2_HS200_1_2V_SDR)
>>>> +#define MMC_CAP2_DETECT_ON_ERR =A0 =A0 =A0 (1 << 7) =A0 =A0 =A0 =A0=
/* On I/O err
>>>> check card removal */
>>>>
>>>> =A0 =A0 =A0mmc_pm_flag_t =A0 =A0 =A0 =A0 =A0 pm_caps; =A0 =A0 =A0 =
=A0/* supported pm features */
>>>> =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0power_notify_type;
>>>
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-mmc=
" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.htm=
l
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
