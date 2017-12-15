From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: core: Send SLEEP_NOTIFICATION for eMMC 5.x device
Date: Fri, 15 Dec 2017 10:24:47 +0100
Message-ID: <CAPDyKFqH3w4j-K0QJj5o9ag42BTDxkpjT5DbqErcZxNK8-Da+w@mail.gmail.com>
References: <20171118010634.1111-1-gwendal@chromium.org> <CAPDyKFozbQR8MBKrN1CTnQ_G=_5v_FFd4YqGZVX9LjnwqZ=jEQ@mail.gmail.com>
 <CAPDyKFrSmX_MbErW71tjwQui6LExQUfHjWL6UVNuJekvgrCc7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f47.google.com ([209.85.214.47]:43202 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755578AbdLOJYt (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 15 Dec 2017 04:24:49 -0500
Received: by mail-it0-f47.google.com with SMTP id u62so18098807ita.2
        for <linux-mmc@vger.kernel.org>; Fri, 15 Dec 2017 01:24:48 -0800 (PST)
In-Reply-To: <CAPDyKFrSmX_MbErW71tjwQui6LExQUfHjWL6UVNuJekvgrCc7Q@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Gwendal Grignou <gwendal@chromium.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Avi Shchislowski <Avi.Shchislowski@sandisk.com>, Chris Ball <cjb@laptop.org>, Alex Lemberg <Alex.Lemberg@sandisk.com>, Thierry Escande <thierry.escande@collabora.com>

On 29 November 2017 at 15:14, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> [...]
>
>>>  static int mmc_poweroff_notify(struct mmc_card *card, unsigned int notify_type)
>>>  {
>>> -       unsigned int timeout = card->ext_csd.generic_cmd6_time;
>>> +       unsigned int timeout;
>>> +       bool use_busy_signal = true;
>>>         int err;
>>>
>>> -       /* Use EXT_CSD_POWER_OFF_SHORT as default notification type. */
>>> -       if (notify_type == EXT_CSD_POWER_OFF_LONG)
>>> +       switch (notify_type) {
>>> +       case EXT_CSD_POWER_OFF_LONG:
>>>                 timeout = card->ext_csd.power_off_longtime;
>>> +               break;
>>> +       case EXT_CSD_SLEEP_NOTIFICATION:
>>> +               timeout = card->ext_csd.sleep_notification_time;
>>> +               use_busy_signal = false;
>>
>> This is wrong.
>>
>> If you set use_busy_signal to false, it means that we don't care about
>> waiting for the card to stop signaling busy on DAT0 after setting
>> EXT_CSD_SLEEP_NOTIFICATION. This then becomes a violation of the eMMC
>> spec, because we must not issue a CMD5 before the card have stopped
>> signaling busy.
>>
>> I realize that for those devices that don't support
>> MMC_CAP_WAIT_WHILE_BUSY or have the ->card_busy() callback
>> implemented, the consequence may be that mmc_poll_for_busy() may call
>> mmc_delay() with a very big timeout. This could be a big problem, I
>> guess.
>
> Well, it may also be a big problem even if the host supports
> ->card_busy() and/or MMC_CAP_WAIT_WHILE_BUSY (but maybe not as big),
> simply because we can't be waiting here for several seconds to allow
> the card to deal with background operations.
>
> I guess we need to try and see what happens. Perhaps you can share
> some data about the timeouts you get?
>
>>
>>> +               break;
>>> +       default:
>>> +               /* Use EXT_CSD_POWER_OFF_SHORT as default notification type. */
>>> +               timeout = card->ext_csd.generic_cmd6_time;
>>> +       }
>>>
>>>         err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>>>                         EXT_CSD_POWER_OFF_NOTIFICATION,
>>> -                       notify_type, timeout, 0, true, false, false);
>>> +                       notify_type, timeout, 0, use_busy_signal, false, false);
>>>         if (err)
>>>                 pr_err("%s: Power Off Notification timed out, %u\n",
>>>                        mmc_hostname(card->host), timeout);
>
> [...]
>
> Kind regards
> Uffe

Gwendal, any news on this?

As changes for the SLEEP_NOTIFICATION keeps being posted, clearly
there is a need for us to deal with it in some way. I have been
thinking of a fall-back solution, if we can't get it it work, but
anyway I am eager to find a solution so we finally can sort this out.

Kind regards
Uffe
