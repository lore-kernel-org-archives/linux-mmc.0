From: Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH] libertas: call into generic suspend code before turning off power
Date: Tue, 09 Oct 2018 16:36:30 +0300
Message-ID: <87efczqm1t.fsf@purkki.adurom.net>
References: <20181008200357.10819-1-daniel@zonque.org>
        <CAPDyKFoo-gnjUg9Khc3EPm=cvHgyR_VNW8xgjP1Tea7wjRfvSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAPDyKFoo-gnjUg9Khc3EPm=cvHgyR_VNW8xgjP1Tea7wjRfvSw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
        (Ulf Hansson's message of "Tue, 9 Oct 2018 09:43:38 +0200")
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, "linux-mmc@vger.kernel.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, libertas-dev-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> writes:

> On 8 October 2018 at 22:03, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org> wrote:
>> When powering down a SDIO connected card during suspend, make sure to call
>> into the generic lbs_suspend() function before pulling the plug. This will
>> make sure the card is successfully deregistered from the system to avoid
>> communication to the card starving out.
>>
>> Fixes: 7444a8092906 ("libertas: fix suspend and resume for SDIO connected cards")
>> Signed-off-by: Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>
>
> Reviewed-by: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>
> BTW, if you need this to reach 4.19 I have already queued some other
> mmc fixes so I can take this as well, if it helps. I need and ack of
> course.

I'm not planning to send anything to 4.19 anymore and this is so simple
that hopefully it cause any conflicts with -next patches, so feel free
to do that:

Acked-by: Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>

-- 
Kalle Valo
