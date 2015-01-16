From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH V3 4/4] mmc: pwrseq_simple: Add support for a reset GPIO
 pin
Date: Fri, 16 Jan 2015 13:45:11 +0100
Message-ID: <20150116124511.GG18220@pengutronix.de>
References: <1421405273-19117-1-git-send-email-ulf.hansson@linaro.org>
 <1421405273-19117-5-git-send-email-ulf.hansson@linaro.org>
 <CAAObsKDm1iPAWgJpQwed8KufkxKwqTAFa5espfqq+jY13r+Ymw@mail.gmail.com>
 <CAPDyKFoLqmgTvJpFLrGZvxrfug+SyspsYaOYtf65CsZ7T991pA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44760 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755211AbbAPMp0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 16 Jan 2015 07:45:26 -0500
Content-Disposition: inline
In-Reply-To: <CAPDyKFoLqmgTvJpFLrGZvxrfug+SyspsYaOYtf65CsZ7T991pA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Alexandre Courbot <gnurou@gmail.com>, NeilBrown <neilb@suse.de>, Linus Walleij <linus.walleij@linaro.org>, Doug Anderson <dianders@chromium.org>, Olof Johansson <olof@lixom.net>, Mark Brown <broonie@kernel.org>, Arend van Spriel <arend@broadcom.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Fri, Jan 16, 2015 at 01:37:41PM +0100, Ulf Hansson wrote:
> On 16 January 2015 at 12:34, Tomeu Vizoso <tomeu.vizoso@collabora.com> wrote:
> > On 16 January 2015 at 11:47, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >>
> >>  int mmc_pwrseq_simple_alloc(struct mmc_host *host, struct device *dev)
> >>  {
> >>         struct mmc_pwrseq_simple *pwrseq;
> >> +       int ret = 0;
> >>
> >>         pwrseq = kzalloc(sizeof(struct mmc_pwrseq_simple), GFP_KERNEL);
> >>         if (!pwrseq)
> >>                 return -ENOMEM;
> >>
> >> +       pwrseq->reset_gpio = gpiod_get_index(dev, "reset", 0, GPIOD_OUT_HIGH);
> >> +       if (IS_ERR(pwrseq->reset_gpio) &&
> >> +               PTR_ERR(pwrseq->reset_gpio) != -ENOENT &&
> >> +               PTR_ERR(pwrseq->reset_gpio) != -ENOSYS) {
> >> +               ret = PTR_ERR(pwrseq->reset_gpio);
> >> +               goto free;
> >> +       }
> >> +
> >>         pwrseq->pwrseq.ops = &mmc_pwrseq_simple_ops;
> >>         host->pwrseq = &pwrseq->pwrseq;
> >>
> >>         return 0;
> >> +free:
> >> +       kfree(&pwrseq);
> >
> > Hi Ulf,
> >
> > this kfree looks a bit fishy (there's one more instance of it in
> > mmc_pwrseq_simple_free).
> 
> This is the error path, which means I need to clean up data that I
> have allocated.

I think Tomeu meant that the '&' must be removed.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
