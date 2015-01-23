From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH V4 4/4] mmc: pwrseq_simple: Add support for a reset GPIO pin
Date: Fri, 23 Jan 2015 18:09:12 +0100
Message-ID: <CABxcv=mGPm4GnFtKOY--Ev0fJEezM86-vfDrERMtaNJkjnTNmQ@mail.gmail.com>
References: <1421658784-11980-1-git-send-email-ulf.hansson@linaro.org>
	<1421658784-11980-5-git-send-email-ulf.hansson@linaro.org>
	<CABxcv=nGWPnkNz1tXJpaTUkroucDgVYzeCrEmZvA8xfzHzROvg@mail.gmail.com>
	<CAPDyKFqnU3OcyiDYPQ4pLRhOGkiEJ1nuwYSP_+qain63N9CEfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wg0-f48.google.com ([74.125.82.48]:54519 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754081AbbAWRJO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 23 Jan 2015 12:09:14 -0500
Received: by mail-wg0-f48.google.com with SMTP id x12so8629457wgg.7
        for <linux-mmc@vger.kernel.org>; Fri, 23 Jan 2015 09:09:12 -0800 (PST)
In-Reply-To: <CAPDyKFqnU3OcyiDYPQ4pLRhOGkiEJ1nuwYSP_+qain63N9CEfg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Alexandre Courbot <gnurou@gmail.com>, Arend van Spriel <arend@broadcom.com>, Sascha Hauer <s.hauer@pengutronix.de>, Olof Johansson <olof@lixom.net>, Russell King <linux@arm.linux.org.uk>, Hans de Goede <hdegoede@redhat.com>, Doug Anderson <dianders@chromium.org>, NeilBrown <neilb@suse.de>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Mark Rutland <mark.rutland@arm.com>

Hello Ulf,

On Fri, Jan 23, 2015 at 6:01 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>
>> Any reason to not use the devm_gpiod_get_index() managed version instead?
>
> This struct device don't have a bound driver to it. Thus this device
> won't be freed automagically from the ->remove() or failed ->probe()
> path.
>

Right, I missed that. Thanks a lot for the clarification.

Best regards,
Javier
