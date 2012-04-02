From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [RFC] MMC-4.5 Power OFF Notify rework
Date: Mon, 2 Apr 2012 17:56:21 +0200
Message-ID: <CACRpkdY1-n_pa+Da6uQFGFPPk1HP0FeyM=WiYOm4S6Yni3492g@mail.gmail.com>
References: <1333101747-3200-1-git-send-email-girish.shivananjappa@linaro.org>
	<CACRpkdYY1v_6rfPwDgSw+ncYy3iz8BGEHucHJmag+Vyuu7uk7w@mail.gmail.com>
	<CAKLKtzeaOFbjFdB_n0bHXOyFVMpPWw-sJLObfXTs-xE9TXc7cA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:44669 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751568Ab2DBP4W convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 2 Apr 2012 11:56:22 -0400
Received: by yenl12 with SMTP id l12so1270082yen.19
        for <linux-mmc@vger.kernel.org>; Mon, 02 Apr 2012 08:56:22 -0700 (PDT)
In-Reply-To: <CAKLKtzeaOFbjFdB_n0bHXOyFVMpPWw-sJLObfXTs-xE9TXc7cA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Saugata Das <saugata.das@linaro.org>
Cc: Girish K S <girish.shivananjappa@linaro.org>, linux-mmc@vger.kernel.org, patches@linaro.org, ulf.hansson@stericsson.com

On Mon, Apr 2, 2012 at 10:47 AM, Saugata Das <saugata.das@linaro.org> w=
rote:

>>> + =A0 =A0 =A0 host->power_notify_type =3D MMC_HOST_PW_NOTIFY_LONG;
>>
>> This looks new, can you explain in the code as comments
>> or in the commit message when SHORT and LONG notifications are
>> used and why?
>>
>
> The mmc_poweroff_notify with MMC_HOST_PW_NOTIFY_LONG will take longer
> time =A0to complete than MMC_HOST_PW_NOTIFY_SHORT. So, the idea is th=
at
> if we use mmc_poweroff_notify on suspend path, then we should use
> MMC_HOST_PW_NOTIFY_SHORT and if we use mmc_poweroff_notify from the
> shutdown path, then we should use MMC_HOST_PW_NOTIFY_LONG.
>
> We will add this in the description.

OK sounds good.

>>> @@ -1338,12 +1338,18 @@ static int mmc_suspend(struct mmc_host *hos=
t)
>>> =A0 =A0 =A0 =A0BUG_ON(!host->card);
>>>
>>> =A0 =A0 =A0 =A0mmc_claim_host(host);
>>> - =A0 =A0 =A0 if (mmc_card_can_sleep(host)) {
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_card_sleep(host);
>>> + =A0 =A0 =A0 if (host->caps2 & MMC_CAP2_POWER_OFF_VCCQ_DURING_SUSP=
END) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_poweroff_notify(host);
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!err)
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_card_set_sleep(ho=
st->card);
>>> - =A0 =A0 =A0 } else if (!mmc_host_is_spi(host))
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>>> + =A0 =A0 =A0 }
>>> +
>>> + =A0 =A0 =A0 if (mmc_card_can_sleep(host))
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_card_sleep(host);
>>> + =A0 =A0 =A0 else if (!mmc_host_is_spi(host))
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_deselect_cards(host);
>>
>> Are you sure you should not deselect the card on an SPI host also if
>> you power off? (I'm just confused, better to ask...)
>>
>
> eMMC does not support SPI mode. So, the POWER OFF NOTIFY, which is an
> eMMC feature, can not be used on SPI mode. The above code (which you
> are referring) puts the eMMC to low power "standby" state with
> mmc_deselect_cards if sleep is not allowed. This logic has not been
> modified by the POWER OFF NOTIFY patch.

OK I would add a small comment above the else if (!mmc_host_is_spi(host=
))
such as /* SPI mode is only used external cards */ or so, it helsps whe=
n
reading the code.

Yours,
Linus Walleij
