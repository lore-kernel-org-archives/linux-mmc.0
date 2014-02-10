From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 14/17] i2c: nomadik: Fixup deployment of runtime PM
Date: Mon, 10 Feb 2014 11:16:53 +0100
Message-ID: <CAPDyKFphK8Zo1i7=w-n-VbGWpmLvUZs_U2Ekq0NCeqVxZ7VKvw@mail.gmail.com>
References: <1391529538-21685-1-git-send-email-ulf.hansson@linaro.org>
	<1391529538-21685-15-git-send-email-ulf.hansson@linaro.org>
	<CAOMZO5CzUuQrmbk6FpFGR56jHBtW-1d_AGcdgB2xyMG0Nkf+Fw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAOMZO5CzUuQrmbk6FpFGR56jHBtW-1d_AGcdgB2xyMG0Nkf+Fw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Alessandro Rubini <rubini-9wsNiZum9E8@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-i2c <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 5 February 2014 15:45, Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> On Tue, Feb 4, 2014 at 1:58 PM, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
>
>> +static int nmk_i2c_runtime_resume(struct device *dev)
>> +{
>> +       struct amba_device *adev = to_amba_device(dev);,
>> +       struct nmk_i2c_dev *nmk_i2c = amba_get_drvdata(adev);
>> +
>> +       clk_prepare_enable(nmk_i2c->clk);
>
> Previously the code was checking the return value from
> clk_prepare_enable(). You should keep the check here.

Will fix in v2! Thanks for reviewing!

Kind regards
Ulf Hansson

>
> Regards,
>
> Fabio Estevam
