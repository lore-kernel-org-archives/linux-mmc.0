From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] libertas: fix return codes in if_sdio_suspend()
Date: Wed, 27 Jun 2018 10:50:39 +0200
Message-ID: <CAPDyKFrns=_H=9L2vwH+oZ=mdL6QrqbDtGtVDZMOdtW7=K6kJg@mail.gmail.com>
References: <20180626204834.14278-1-daniel@zonque.org> <950add1e-ec3a-a179-ff49-b49b3a748bcb@zonque.org>
 <CAPDyKFp-KkHbqR4+vOL2XZnAcXPPCJ7snW=2wFoz82UckPFW1w@mail.gmail.com> <3f91c902-4aef-77cb-6fa1-d90cb1bc4aab@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <3f91c902-4aef-77cb-6fa1-d90cb1bc4aab-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>
Cc: Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, libertas-dev-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On 27 June 2018 at 10:31, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org> wrote:
> On Wednesday, June 27, 2018 09:54 AM, Ulf Hansson wrote:
>>
>> On 26 June 2018 at 22:50, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org> wrote:
>>>
>>> On Tuesday, June 26, 2018 10:48 PM, Daniel Mack wrote:
>
>
>>>> @@ -1321,7 +1334,7 @@ static int if_sdio_suspend(struct device *dev)
>>>>          if (ret)
>>>>                  return ret;
>>>>    -     ret = lbs_suspend(card->priv);
>>>> +       ret = lbs_suspend(priv);
>>>>          if (ret)
>>>>                  return ret;
>>>>    @@ -1336,6 +1349,9 @@ static int if_sdio_resume(struct device *dev)
>>>>          dev_info(dev, "%s: resume: we're back\n", sdio_func_id(func));
>>>>    +     if (card->priv->power_up_on_resume)
>>>> +               if_sdio_power_on(card);
>>>> +
>>
>>
>> To guarantee firmware is loaded, don't you need the below as well?
>>
>> wait_event(card->pwron_waitq, priv->fw_ready);
>
>
> Hmm, yes. I should probably just be calling into if_sdio_power_restore().

You don't want to mess up the runtime PM counter though.

>
> I'll test that and resend the patch.

Great!

Kind regards
Uffe
