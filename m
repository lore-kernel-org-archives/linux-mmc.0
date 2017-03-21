From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v2 06/14] mmc: dw_mmc: simplify optional reset handling
Date: Tue, 21 Mar 2017 21:12:20 +0900
Message-ID: <22bbae56-e019-8be3-ffcc-ffcbe8d6ec53@samsung.com>
References: <20170315113139.17989-1-p.zabel@pengutronix.de>
 <CGME20170320092255eucas1p1459c023fd9b479c8e5323a6ac97dbf58@eucas1p1.samsung.com>
 <e70d77e9-bd60-a0f4-6510-48b72cb67624@samsung.com>
 <1490003602.2917.16.camel@pengutronix.de>
 <b80ceee9-40e7-f32b-d44a-00dd4e7f6461@samsung.com>
 <1490005679.2917.32.camel@pengutronix.de>
 <5f6c8c58-c4e4-39e6-2c29-e889bd6bf565@samsung.com>
 <1490007648.2917.41.camel@pengutronix.de>
 <CAPDyKFr-08ontZTfraOEAOROcb9pqFQkqzV4zMRA4OdsxXrvtQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <CAPDyKFr-08ontZTfraOEAOROcb9pqFQkqzV4zMRA4OdsxXrvtQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: Andrzej Hajda <a.hajda@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Szyprowski, Marek" <m.szyprowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi All,

On 03/21/2017 03:10 AM, Ulf Hansson wrote:
> On 20 March 2017 at 12:00, Philipp Zabel <p.zabel@pengutronix.de> wrote:
>> On Mon, 2017-03-20 at 11:49 +0100, Andrzej Hajda wrote:
>>> On 20.03.2017 11:27, Philipp Zabel wrote:
>> [...]
>>>> diff --git a/include/linux/reset.h b/include/linux/reset.h
>>>> index 86b4ed75359e8..c905ff1c21ec6 100644
>>>> --- a/include/linux/reset.h
>>>> +++ b/include/linux/reset.h
>>>> @@ -74,14 +74,14 @@ static inline struct reset_control *__of_reset_control_get(
>>>>                                     const char *id, int index, bool shared,
>>>>                                     bool optional)
>>>>  {
>>>> -   return ERR_PTR(-ENOTSUPP);
>>>> +   return optional ? NULL : ERR_PTR(-ENOTSUPP);
>>>>  }
>>>>
>>>>  static inline struct reset_control *__devm_reset_control_get(
>>>>                                     struct device *dev, const char *id,
>>>>                                     int index, bool shared, bool optional)
>>>>  {
>>>> -   return ERR_PTR(-ENOTSUPP);
>>>> +   return optional ? NULL : ERR_PTR(-ENOTSUPP);
>>>>  }
>>>>
>>>>  #endif /* CONFIG_RESET_CONTROLLER */
>>>> ---------->8----------
>>>
>>> In dw_mmc.c file there are also unconditional calls to
>>> reset_control_assert, with disabled RESET_CONTROLLER it will cause
>>> unexpected WARNs.
>>> Anyway if you change reset API as above I think you should remove all
>>> warns from reset stubs, because NULL reset is valid, but these warns are
>>> there for reason - contradiction.
>>
>> You are right, I have to let go of those, too.
> 
> 
> Until fixed, I have dropped the three changes from my next branch
> related to this. Please re-post when fixed.

I missed this patch. If resend the patch, i will check.

Best Regards,
Jaehoon Chung

> 
> Kind regards
> Uffe
> 
>>
>> regards
>> Philipp
>>
> 
> 
> 
