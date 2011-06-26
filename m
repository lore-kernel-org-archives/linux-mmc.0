From: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] mmc: sdio: fix runtime PM path during driver removal
Date: Sun, 26 Jun 2011 14:50:50 +0300
Message-ID: <BANLkTi=JcXG04coTJCA=fvwxXzuRsYzT4Q@mail.gmail.com>
References: <1307662827-16618-1-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1307662827-16618-1-git-send-email-ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Cc: linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Hi Chris,

On Fri, Jun 10, 2011 at 2:40 AM, Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org> wrote:
> After commit e1866b3 "PM / Runtime: Rework runtime PM handling
> during driver removal" was introduced, the driver core stopped
> incrementing the runtime PM usage counter of the device during
> the invocation of the ->remove() callback.
>
> This indirectly broke SDIO's runtime PM path during driver removal,
> because no one calls _put_sync() anymore after ->remove() completes.
>
> This means that the power of runtime-PM-managed SDIO cards is kept
> high after their driver is removed (even if it was powered down
> beforehand).
>
> Fix that by directly calling _put_sync() when the last usage
> counter is downref'ed by the SDIO bus.

Can you please take this 1-liner into 3.0-rc ?

It fixes SDIO runtime PM after a breakage was introduced in 3.0.

Thanks,
Ohad.
--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
