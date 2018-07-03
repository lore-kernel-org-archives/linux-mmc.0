From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] libertas: fix suspend and resume for SDIO connected cards
Date: Tue, 3 Jul 2018 06:51:26 +0200
Message-ID: <CAPDyKFo9M0jbAy=trp8NAUSRpi85P=QWpy2mTL7yzeKcbQhS7w@mail.gmail.com>
References: <20180627185845.31799-1-daniel@zonque.org> <CAPDyKFr7snWsk=194u4nKs4301tUARByuEPSFop_fzxn6HVQDQ@mail.gmail.com>
 <dac693d9-b6f4-fac6-3cfa-ccfc4a6172c6@zonque.org> <87o9fp8z2o.fsf@purkki.adurom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87o9fp8z2o.fsf-5ukZ45wKbUHoml4zekdYB16hYfS7NtTn@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, libertas-dev-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On 2 July 2018 at 16:57, Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org> wrote:
> Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org> writes:
>
>> On Friday, June 29, 2018 05:39 PM, Ulf Hansson wrote:
>>> On 27 June 2018 at 20:58, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org> wrote:
>>>> Prior to commit 573185cc7e64 ("mmc: core: Invoke sdio func driver's PM
>>>> callbacks from the sdio bus"), the MMC core used to call into the power
>>>> management functions of SDIO clients itself and removed the card if the
>>>> return code was non-zero. IOW, the mmc handled errors gracefully and didn't
>>>> upchain them to the pm core.
>>>>
>>>> Since this change, the mmc core relies on generic power management
>>>> functions which treat all errors as a reason to cancel the suspend
>>>> immediately. This causes suspend attempts to fail when the libertas
>>>> driver is loaded.
>>>>
>>>> To fix this, power down the card explicitly in if_sdio_suspend() when we
>>>> know we're about to lose power and return success. Also set a flag in these
>>>> cases, and power up the card again in if_sdio_resume().
>>>>
>>>> Signed-off-by: Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>
>>>> Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>>>> Cc: Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>
>>>
>>> Looks good to me! Should be a candidate for stable as well!?
>>
>> Thanks!
>>
>> Yeah, it should probably get a
>>
>> Fixes: 573185cc7e64 ("mmc: core: Invoke sdio func driver's PM
>> callbacks from the sdio bus")
>>
>> as well.
>
> So I'll queue this for wireless-drivers-next and add:
>
> Fixes: 573185cc7e64 ("mmc: core: Invoke sdio func driver's PM callbacks from the sdio bus")
> Cc: <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>
> Ok?

That's fine by me.

Kind regards
Uffe
