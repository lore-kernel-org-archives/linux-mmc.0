From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH V4 4/4] mmc: pwrseq_simple: Add support for a reset GPIO pin
Date: Thu, 5 Mar 2015 10:05:36 +0100
Message-ID: <CACRpkdabrcQu3xtzGrWhBfkPuMdFutFh790eGpxjbKtw8ObVRA@mail.gmail.com>
References: <1421658784-11980-1-git-send-email-ulf.hansson@linaro.org>
	<1421658784-11980-5-git-send-email-ulf.hansson@linaro.org>
	<CAAVeFuJjU-fsknYdMZ1c+aOEmc2rFy=z35S584DfHBLvUm=OAQ@mail.gmail.com>
	<CAPDyKFonXw2NDbEw9CoRj7Sncgm_FUki+cc7j3q=xVZRrJHBkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oi0-f47.google.com ([209.85.218.47]:38723 "EHLO
	mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754249AbbCEJFh (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Mar 2015 04:05:37 -0500
Received: by oiax69 with SMTP id x69so10589006oia.5
        for <linux-mmc@vger.kernel.org>; Thu, 05 Mar 2015 01:05:37 -0800 (PST)
In-Reply-To: <CAPDyKFonXw2NDbEw9CoRj7Sncgm_FUki+cc7j3q=xVZRrJHBkg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Alexandre Courbot <gnurou@gmail.com>, Rojhalat Ibrahim <imr@rtschenk.de>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Arend van Spriel <arend@broadcom.com>, Sascha Hauer <s.hauer@pengutronix.de>, Olof Johansson <olof@lixom.net>, Russell King <linux@arm.linux.org.uk>, Hans de Goede <hdegoede@redhat.com>, Doug Anderson <dianders@chromium.org>, NeilBrown <neilb@suse.de>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Mark Rutland <mark.rutland@arm.com>

On Wed, Feb 11, 2015 at 5:34 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 10 February 2015 at 10:12, Alexandre Courbot <gnurou@gmail.com> wrote:

>> This code would be a great candidate to use this GPIO array API, but
>> since it is not in -next yet (should happen soon though) you might
>> want to consider doing it later.

This is now in my git and -next, I can take patches to pwrseq if Ulf
ACKs them to go through my GPIO tree.

Yours,
Linus Walleij
