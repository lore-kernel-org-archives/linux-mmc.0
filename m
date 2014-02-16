From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V2 11/17] i2c: nomadik: Convert to devm functions
Date: Sun, 16 Feb 2014 14:44:07 +0100
Message-ID: <CAPDyKFrt6QJVSypP5iD_oVxRUvNhzxGcbZ703zR1K8gwJ5uCeQ@mail.gmail.com>
References: <1392300547-23365-1-git-send-email-ulf.hansson@linaro.org>
	<20140215150345.GD2579@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140215150345.GD2579@katana>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Alessandro Rubini <rubini-9wsNiZum9E8@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 15 February 2014 16:03, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:
> On Thu, Feb 13, 2014 at 03:09:02PM +0100, Ulf Hansson wrote:
>> Use devm_* functions to simplify code and error handling.
>>
>> Cc: Alessandro Rubini <rubini-9wsNiZum9E8@public.gmane.org>
>> Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>> Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
>> Signed-off-by: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>> ---
>>
>> Changes in v2:
>>       Rebased on top of latest i2c-nomadik branch.
>
> Since this depends on Linus' patch already, I think it would be cleaner
> if I pick this kinda unrelated (but wanted) devm patch, and ack the
> PM stuff. If this for some reason makes things more complicated, I can
> also simply ack this one.

I think we will end up having merge conflicts, especially for the
changes in the probe function if we decide to split it.

Would a way forward be to let you carry all the patches through your
tree? I believe all but patch 17 can be safely merged. It is only this
one that depends on the changes in the amba bus, so we can put this
one on hold for a while.

Another option would be if you drop Linus' patch from you branch and
let him collect all the patches in a pull request instead?

I happy with whatever we thinks are easiest. :-)

>
>> -     dev->virtbase = ioremap(adev->res.start, resource_size(&adev->res));
>> +     dev->virtbase = devm_ioremap(&adev->dev, adev->res.start,
>> +                             resource_size(&adev->res));
>>       if (!dev->virtbase) {
>>               ret = -ENOMEM;
>
> IS_ERR()!

Will fix in a v2!

>

Thanks!

Kind regards
Ulf Hansson
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
