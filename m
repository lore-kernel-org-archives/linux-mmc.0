From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V4 4/4] mmc: pwrseq_simple: Add support for a reset GPIO pin
Date: Fri, 23 Jan 2015 18:01:32 +0100
Message-ID: <CAPDyKFqnU3OcyiDYPQ4pLRhOGkiEJ1nuwYSP_+qain63N9CEfg@mail.gmail.com>
References: <1421658784-11980-1-git-send-email-ulf.hansson@linaro.org>
	<1421658784-11980-5-git-send-email-ulf.hansson@linaro.org>
	<CABxcv=nGWPnkNz1tXJpaTUkroucDgVYzeCrEmZvA8xfzHzROvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CABxcv=nGWPnkNz1tXJpaTUkroucDgVYzeCrEmZvA8xfzHzROvg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Javier Martinez Canillas <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org>
Cc: "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Arend van Spriel <arend-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, NeilBrown <neilb-l3A5Bk7waGM@public.gmane.org>, Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 23 January 2015 at 16:56, Javier Martinez Canillas
<javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org> wrote:
> Hello Ulf,
>
> On Mon, Jan 19, 2015 at 10:13 AM, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
>>
>>  int mmc_pwrseq_simple_alloc(struct mmc_host *host, struct device *dev)
>>  {
>>         struct mmc_pwrseq_simple *pwrseq;
>> +       int ret = 0;
>>
>>         pwrseq = kzalloc(sizeof(struct mmc_pwrseq_simple), GFP_KERNEL);
>>         if (!pwrseq)
>>                 return -ENOMEM;
>>
>> +       pwrseq->reset_gpio = gpiod_get_index(dev, "reset", 0, GPIOD_OUT_HIGH);
>
> Any reason to not use the devm_gpiod_get_index() managed version instead?

This struct device don't have a bound driver to it. Thus this device
won't be freed automagically from the ->remove() or failed ->probe()
path.

>
> AFAICT mmc_free_host() will free the device so in that case you won't
> need to call gpiod_put() in mmc_pwrseq_simple_free().
>
> This will also make easier to extend pwrseq_simple to support multiple
> GPIOs like the DT binding implies.
>

Kind regards
Uffe
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
