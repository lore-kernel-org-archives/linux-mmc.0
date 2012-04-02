From: Saugata Das <saugata.das@linaro.org>
Subject: Re: [RFC] MMC-4.5 Power OFF Notify rework
Date: Mon, 2 Apr 2012 14:17:02 +0530
Message-ID: <CAKLKtzeaOFbjFdB_n0bHXOyFVMpPWw-sJLObfXTs-xE9TXc7cA@mail.gmail.com>
References: <1333101747-3200-1-git-send-email-girish.shivananjappa@linaro.org>
	<CACRpkdYY1v_6rfPwDgSw+ncYy3iz8BGEHucHJmag+Vyuu7uk7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:43686 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751258Ab2DBIrD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 2 Apr 2012 04:47:03 -0400
Received: by wibhj6 with SMTP id hj6so2420627wib.1
        for <linux-mmc@vger.kernel.org>; Mon, 02 Apr 2012 01:47:02 -0700 (PDT)
In-Reply-To: <CACRpkdYY1v_6rfPwDgSw+ncYy3iz8BGEHucHJmag+Vyuu7uk7w@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Girish K S <girish.shivananjappa@linaro.org>, linux-mmc@vger.kernel.org, patches@linaro.org, ulf.hansson@stericsson.com

On 30 March 2012 21:19, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Fri, Mar 30, 2012 at 12:02 PM, Girish K S
> <girish.shivananjappa@linaro.org> wrote:
>
>> This is a rework of the existing POWER OFF NOTIFY patch. The current=
 problem
>> with the patch comes from the ambiguity on the usage of POWER OFF NO=
TIFY
>> together with SLEEP and misunderstanding on the usage of MMC_POWER_O=
=46F
>> power_mode from mmc_set_ios in different host controller drivers.
>>
>> This new patch works around this problem by adding a new host CAP,
>> MMC_CAP2_POWER_OFF_VCCQ_DURING_SUSPEND, which when set sends a
>> POWER OFF NOTIFY from mmc_suspend instead of SLEEP. It is expected t=
hat host
>> controller drivers will set this CAP, if they switch off both Vcc an=
d Vccq
>> from MMC_POWER_OFF condition within mmc_set_ios. However, note that =
there
>> is no harm in sending MMC_POWER_NOTIFY even if Vccq is not switched =
off.
>>
>> This patch also sends POWER OFF NOTIFY from power management routine=
s (e.g.
>> mmc_power_save_host, mmc_pm_notify/PM_SUSPEND_PREPARE, mmc_stop_host=
), which
>> does reinitialization of the eMMC on the return path of the power ma=
nagement
>> routines (e.g. mmc_power_restore_host, mmc_pm_notify/PM_POST_RESTORE=
,
>> mmc_start_host).
>>
>> Signed-off-by: Saugata Das <saugata.das@linaro.org>
>> Signed-off-by: Girish K S <girish.shivananjappa@linaro.org>
>
> Overall this looks good!
>
> I think it may be possible to split the patch.
> First a patch that moves mmc_card_set_sleep() and mmc_card_clr_sleep(=
)
> into mmc_card_sleep() and mmc_card_awake(), which is a good
> refactoring in its own right. Then a patch doing the rest of the chan=
ges.
>
> (But that's no big deal to me if Chris is OK with this.)
>
>> -static void mmc_poweroff_notify(struct mmc_host *host)
>> +int mmc_poweroff_notify(struct mmc_host *host)
>
> So now this function will return an errorcode if notification fails,
> maybe add some kerneldoc...
>
>> @@ -2112,7 +2096,8 @@ int mmc_power_save_host(struct mmc_host *host)
>>
>> =A0 =A0 =A0 =A0if (host->bus_ops->power_save)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D host->bus_ops->power_save(hos=
t);
>> -
>> + =A0 =A0 =A0 host->power_notify_type =3D MMC_HOST_PW_NOTIFY_SHORT;
>> + =A0 =A0 =A0 mmc_poweroff_notify(host);
>
> So no risk in ignoring poweroff notification failure here I guess..
> (Just thinking aloud.)
>
>> @@ -2135,7 +2120,7 @@ int mmc_power_restore_host(struct mmc_host *ho=
st)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_bus_put(host);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
>> =A0 =A0 =A0 =A0}
>> -
>> + =A0 =A0 =A0 host->power_notify_type =3D MMC_HOST_PW_NOTIFY_LONG;
>
> This looks new, can you explain in the code as comments
> or in the commit message when SHORT and LONG notifications are
> used and why?
>

The mmc_poweroff_notify with MMC_HOST_PW_NOTIFY_LONG will take longer
time  to complete than MMC_HOST_PW_NOTIFY_SHORT. So, the idea is that
if we use mmc_poweroff_notify on suspend path, then we should use
MMC_HOST_PW_NOTIFY_SHORT and if we use mmc_poweroff_notify from the
shutdown path, then we should use MMC_HOST_PW_NOTIFY_LONG.

We will add this in the description.

>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>> index 02914d6..885ad61 100644
>> --- a/drivers/mmc/core/mmc.c
>> +++ b/drivers/mmc/core/mmc.c
>> @@ -1338,12 +1338,18 @@ static int mmc_suspend(struct mmc_host *host=
)
>> =A0 =A0 =A0 =A0BUG_ON(!host->card);
>>
>> =A0 =A0 =A0 =A0mmc_claim_host(host);
>> - =A0 =A0 =A0 if (mmc_card_can_sleep(host)) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_card_sleep(host);
>> + =A0 =A0 =A0 if (host->caps2 & MMC_CAP2_POWER_OFF_VCCQ_DURING_SUSPE=
ND) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_poweroff_notify(host);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!err)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_card_set_sleep(hos=
t->card);
>> - =A0 =A0 =A0 } else if (!mmc_host_is_spi(host))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 if (mmc_card_can_sleep(host))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_card_sleep(host);
>> + =A0 =A0 =A0 else if (!mmc_host_is_spi(host))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_deselect_cards(host);
>
> Are you sure you should not deselect the card on an SPI host also if
> you power off? (I'm just confused, better to ask...)
>

eMMC does not support SPI mode. So, the POWER OFF NOTIFY, which is an
eMMC feature, can not be used on SPI mode. The above code (which you
are referring) puts the eMMC to low power "standby" state with
mmc_deselect_cards if sleep is not allowed. This logic has not been
modified by the POWER OFF NOTIFY patch.

>> +
>> +out:
>
> So if I understand correctly we power off if possible, else we
> set the card to sleep. (Looks good.)
>
>> =A0 =A0 =A0 =A0mmc_claim_host(host);
>> - =A0 =A0 =A0 if (mmc_card_is_sleep(host->card)) {
>> + =A0 =A0 =A0 if (mmc_card_is_sleep(host->card))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D mmc_card_awake(host);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_card_clr_sleep(host->card);
>> - =A0 =A0 =A0 } else
>> + =A0 =A0 =A0 else
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D mmc_init_card(host, host->ocr=
, host->card);
>
> So a powered-off card will be reinitialized here, nice!
>
> Yours,
> Linus Walleij
