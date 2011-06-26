From: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] mmc: sdio: fix runtime PM path during driver removal
Date: Sun, 26 Jun 2011 11:09:43 -0400
Message-ID: <m2tybceiiw.fsf@bob.laptop.org>
References: <1307662827-16618-1-git-send-email-ohad@wizery.com>
	<BANLkTi=JcXG04coTJCA=fvwxXzuRsYzT4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <BANLkTi=JcXG04coTJCA=fvwxXzuRsYzT4Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org> (Ohad
	Ben-Cohen's message of "Sun, 26 Jun 2011 14:50:50 +0300")
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
Cc: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Hi Ohad,

On Sun, Jun 26 2011, Ohad Ben-Cohen wrote:
> On Fri, Jun 10, 2011 at 2:40 AM, Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org> wrote:
>> After commit e1866b3 "PM / Runtime: Rework runtime PM handling
>> during driver removal" was introduced, the driver core stopped
>> incrementing the runtime PM usage counter of the device during
>> the invocation of the ->remove() callback.
>>
>> This indirectly broke SDIO's runtime PM path during driver removal,
>> because no one calls _put_sync() anymore after ->remove() completes.
>>
>> This means that the power of runtime-PM-managed SDIO cards is kept
>> high after their driver is removed (even if it was powered down
>> beforehand).
>>
>> Fix that by directly calling _put_sync() when the last usage
>> counter is downref'ed by the SDIO bus.
>
> Can you please take this 1-liner into 3.0-rc ?
>
> It fixes SDIO runtime PM after a breakage was introduced in 3.0.

Merged, thanks.  I'll be sending a pull request on my for-linus branch
shortly:

http://git.kernel.org/?p=linux/kernel/git/cjb/mmc.git;a=shortlog;h=refs/heads/for-linus

- Chris.
-- 
Chris Ball   <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>   <http://printf.net/>
One Laptop Per Child
--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
