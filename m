From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 14/17] i2c: nomadik: Fixup deployment of runtime PM
Date: Mon, 10 Feb 2014 11:14:46 +0100
Message-ID: <CAPDyKFrWgB8z1rtWxU7AYvVsmNj_pfGbsozwgP_FzLODpmGRwQ@mail.gmail.com>
References: <1391529538-21685-1-git-send-email-ulf.hansson@linaro.org>
	<1391529538-21685-15-git-send-email-ulf.hansson@linaro.org>
	<CACRpkdZwoXf5ovmQEAN6Ugvz91+_i5uGqStR3MGXQeJGHitj3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CACRpkdZwoXf5ovmQEAN6Ugvz91+_i5uGqStR3MGXQeJGHitj3Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Alessandro Rubini <rubini-9wsNiZum9E8@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 5 February 2014 15:34, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> On Tue, Feb 4, 2014 at 4:58 PM, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
>
>> Since the device is active while a successful probe has been completed,
>> the reference counting for the clock will be screwed up and never reach
>> zero.
>>
>> The issue is resolved by implementing runtime PM callbacks and let them
>> handle the resources accordingly, including the clock.
>>
>> Cc: Alessandro Rubini <rubini-9wsNiZum9E8@public.gmane.org>
>> Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>> Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
>> Signed-off-by: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>
> Hm do I read it right as patch 13 breaks runtime PM by leaving
> the device active after probe() and this patch
> 14 fixes it again? Maybe these two patches should be squashed
> then.

You are right; but the driver will still be working, you just don't
get the benefit from inactivating the device at request inactivity -
as you pointed out.

The reason for why I wanted to do this as separate steps was to make
it easier for reviewing, otherwise the patch(es) would have been quite
big and messy. I am for sure open to  adopt to your proposal, but just
wanted to give you some more background, before I go ahead and send a
v2.

Kind regards
Ulf Hansson

>
> Yours,
> Linus Walleij
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
