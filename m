From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 03/17] mmc: mmci: Mask IRQs for all variants during
 runtime suspend
Date: Tue, 18 Feb 2014 17:36:52 +0100
Message-ID: <CAPDyKFq3uAoo7p-7hZgBmMJ4jf9A7dC0aUZJYUE0z1Qq5W=0bw@mail.gmail.com>
References: <1391529538-21685-1-git-send-email-ulf.hansson@linaro.org>
	<1391529538-21685-4-git-send-email-ulf.hansson@linaro.org>
	<20140218160542.GH21483@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140218160542.GH21483-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Alessandro Rubini <rubini-9wsNiZum9E8@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 18 February 2014 17:05, Russell King - ARM Linux
<linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org> wrote:
> On Tue, Feb 04, 2014 at 04:58:44PM +0100, Ulf Hansson wrote:
>> In runtime suspended state, we are not expecting IRQs and thus we can
>> safely mask them, not only for pwrreg_nopower variants but for all.
>>
>> Obviously we then also need to make sure we restore the IRQ mask while
>> becoming runtime resumed.
>
> So, what happens when this patch is applied, and a SDIO card is attached
> which expects to receive interrupts at any moment?

Currently, no variant implements SDIO irq.

The SDIO irq polling mode from the sdio core will still be functional,
as of today. So, this patch will not break SDIO.

>
> Given that I've run into this during the last week with a SDHCI controller,
> I'm not that thrilled with other interfaces doing the same broken thing.

If we add SDIO irq support to mmci in future; parts of that
implementation includes a re-route of DAT1 to a GPIO irq when entering
runtime suspend state. The mmci HW will in runtime suspend state, not
be responsible for handling irqs, which is the same as of today.

Kind regards
Ulf Hansson

>
> --
> FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
> in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
> Estimate before purchase was "up to 13.2Mbit".
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
