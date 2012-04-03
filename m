From: Saugata Das <saugata.das@linaro.org>
Subject: Re: [RFC] MMC-4.5 Power OFF Notify rework
Date: Tue, 3 Apr 2012 14:20:00 +0530
Message-ID: <CAKLKtzdmH6xFwQMAOkRzCvjxQg0zuEX27+HrrYCBEKzN1ht=BQ@mail.gmail.com>
References: <1333101747-3200-1-git-send-email-girish.shivananjappa@linaro.org>
	<CACRpkdYY1v_6rfPwDgSw+ncYy3iz8BGEHucHJmag+Vyuu7uk7w@mail.gmail.com>
	<CAKLKtzeaOFbjFdB_n0bHXOyFVMpPWw-sJLObfXTs-xE9TXc7cA@mail.gmail.com>
	<CACRpkdY1-n_pa+Da6uQFGFPPk1HP0FeyM=WiYOm4S6Yni3492g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:65512 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750838Ab2DCIuC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 3 Apr 2012 04:50:02 -0400
Received: by gghe5 with SMTP id e5so1630848ggh.19
        for <linux-mmc@vger.kernel.org>; Tue, 03 Apr 2012 01:50:01 -0700 (PDT)
In-Reply-To: <CACRpkdY1-n_pa+Da6uQFGFPPk1HP0FeyM=WiYOm4S6Yni3492g@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Girish K S <girish.shivananjappa@linaro.org>, linux-mmc@vger.kernel.org, patches@linaro.org, ulf.hansson@stericsson.com

On 2 April 2012 21:26, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Mon, Apr 2, 2012 at 10:47 AM, Saugata Das <saugata.das@linaro.org>=
 wrote:
>
>>>> + =A0 =A0 =A0 host->power_notify_type =3D MMC_HOST_PW_NOTIFY_LONG;
>>>
>>> This looks new, can you explain in the code as comments
>>> or in the commit message when SHORT and LONG notifications are
>>> used and why?
>>>
>>
>> The mmc_poweroff_notify with MMC_HOST_PW_NOTIFY_LONG will take longe=
r
>> time =A0to complete than MMC_HOST_PW_NOTIFY_SHORT. So, the idea is t=
hat
>> if we use mmc_poweroff_notify on suspend path, then we should use
>> MMC_HOST_PW_NOTIFY_SHORT and if we use mmc_poweroff_notify from the
>> shutdown path, then we should use MMC_HOST_PW_NOTIFY_LONG.
>>
>> We will add this in the description.
>
> OK sounds good.
>
>>>> @@ -1338,12 +1338,18 @@ static int mmc_suspend(struct mmc_host *ho=
st)
>>>> =A0 =A0 =A0 =A0BUG_ON(!host->card);
>>>>
>>>> =A0 =A0 =A0 =A0mmc_claim_host(host);
>>>> - =A0 =A0 =A0 if (mmc_card_can_sleep(host)) {
>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_card_sleep(host);
>>>> + =A0 =A0 =A0 if (host->caps2 & MMC_CAP2_POWER_OFF_VCCQ_DURING_SUS=
PEND) {
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_poweroff_notify(host);
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!err)
>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_card_set_sleep(h=
ost->card);
>>>> - =A0 =A0 =A0 } else if (!mmc_host_is_spi(host))
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>>>> + =A0 =A0 =A0 }
>>>> +
>>>> + =A0 =A0 =A0 if (mmc_card_can_sleep(host))
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_card_sleep(host);
>>>> + =A0 =A0 =A0 else if (!mmc_host_is_spi(host))
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_deselect_cards(host);
>>>
>>> Are you sure you should not deselect the card on an SPI host also i=
f
>>> you power off? (I'm just confused, better to ask...)
>>>
>>
>> eMMC does not support SPI mode. So, the POWER OFF NOTIFY, which is a=
n
>> eMMC feature, can not be used on SPI mode. The above code (which you
>> are referring) puts the eMMC to low power "standby" state with
>> mmc_deselect_cards if sleep is not allowed. This logic has not been
>> modified by the POWER OFF NOTIFY patch.
>
> OK I would add a small comment above the else if (!mmc_host_is_spi(ho=
st))
> such as /* SPI mode is only used external cards */ or so, it helsps w=
hen
> reading the code.
>

I understand but power off notify patch did not introduce this. May
be, we can add this comment in a different patch.

If no other comments, then we will resubmit this patch with
modification of the description.


> Yours,
> Linus Walleij
