From: Gwendal Grignou <gwendal@chromium.org>
Subject: Re: [PATCH] mmc: core: Send SLEEP_NOTIFICATION for eMMC 5.x device
Date: Tue, 19 Dec 2017 17:57:12 -0800
Message-ID: <CAMHSBOU9YPsMZ0aGDy6v+p6GY5ndQrqpz4rt6G9M2aKj0MXcGw@mail.gmail.com>
References: <20171118010634.1111-1-gwendal@chromium.org> <CAPDyKFozbQR8MBKrN1CTnQ_G=_5v_FFd4YqGZVX9LjnwqZ=jEQ@mail.gmail.com>
 <CAPDyKFrSmX_MbErW71tjwQui6LExQUfHjWL6UVNuJekvgrCc7Q@mail.gmail.com> <CAPDyKFqH3w4j-K0QJj5o9ag42BTDxkpjT5DbqErcZxNK8-Da+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:37190 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751820AbdLTB5f (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Dec 2017 20:57:35 -0500
Received: by mail-wm0-f54.google.com with SMTP id f140so6957642wmd.2
        for <linux-mmc@vger.kernel.org>; Tue, 19 Dec 2017 17:57:35 -0800 (PST)
In-Reply-To: <CAPDyKFqH3w4j-K0QJj5o9ag42BTDxkpjT5DbqErcZxNK8-Da+w@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Gwendal Grignou <gwendal@chromium.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Avi Shchislowski <Avi.Shchislowski@sandisk.com>, Chris Ball <cjb@laptop.org>, Alex Lemberg <Alex.Lemberg@sandisk.com>, Thierry Escande <thierry.escande@collabora.com>

Ufe,

I have been side-tracked but will get back on it. I will be the worst
case scenario (lot of random write before suspend for different eMMC).
I also need to rework the wait for DAT0 to deassert instead of the
busy line as usual.

Gwendal.

On Fri, Dec 15, 2017 at 1:24 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 29 November 2017 at 15:14, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> [...]
>>
>>>>  static int mmc_poweroff_notify(struct mmc_card *card, unsigned int notify_type)
>>>>  {
>>>> -       unsigned int timeout = card->ext_csd.generic_cmd6_time;
>>>> +       unsigned int timeout;
>>>> +       bool use_busy_signal = true;
>>>>         int err;
>>>>
>>>> -       /* Use EXT_CSD_POWER_OFF_SHORT as default notification type. */
>>>> -       if (notify_type == EXT_CSD_POWER_OFF_LONG)
>>>> +       switch (notify_type) {
>>>> +       case EXT_CSD_POWER_OFF_LONG:
>>>>                 timeout = card->ext_csd.power_off_longtime;
>>>> +               break;
>>>> +       case EXT_CSD_SLEEP_NOTIFICATION:
>>>> +               timeout = card->ext_csd.sleep_notification_time;
>>>> +               use_busy_signal = false;
>>>
>>> This is wrong.
>>>
>>> If you set use_busy_signal to false, it means that we don't care about
>>> waiting for the card to stop signaling busy on DAT0 after setting
>>> EXT_CSD_SLEEP_NOTIFICATION. This then becomes a violation of the eMMC
>>> spec, because we must not issue a CMD5 before the card have stopped
>>> signaling busy.
>>>
>>> I realize that for those devices that don't support
>>> MMC_CAP_WAIT_WHILE_BUSY or have the ->card_busy() callback
>>> implemented, the consequence may be that mmc_poll_for_busy() may call
>>> mmc_delay() with a very big timeout. This could be a big problem, I
>>> guess.
>>
>> Well, it may also be a big problem even if the host supports
>> ->card_busy() and/or MMC_CAP_WAIT_WHILE_BUSY (but maybe not as big),
>> simply because we can't be waiting here for several seconds to allow
>> the card to deal with background operations.
>>
>> I guess we need to try and see what happens. Perhaps you can share
>> some data about the timeouts you get?
>>
>>>
>>>> +               break;
>>>> +       default:
>>>> +               /* Use EXT_CSD_POWER_OFF_SHORT as default notification type. */
>>>> +               timeout = card->ext_csd.generic_cmd6_time;
>>>> +       }
>>>>
>>>>         err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>>>>                         EXT_CSD_POWER_OFF_NOTIFICATION,
>>>> -                       notify_type, timeout, 0, true, false, false);
>>>> +                       notify_type, timeout, 0, use_busy_signal, false, false);
>>>>         if (err)
>>>>                 pr_err("%s: Power Off Notification timed out, %u\n",
>>>>                        mmc_hostname(card->host), timeout);
>>
>> [...]
>>
>> Kind regards
>> Uffe
>
> Gwendal, any news on this?
>
> As changes for the SLEEP_NOTIFICATION keeps being posted, clearly
> there is a need for us to deal with it in some way. I have been
> thinking of a fall-back solution, if we can't get it it work, but
> anyway I am eager to find a solution so we finally can sort this out.
>
> Kind regards
> Uffe
