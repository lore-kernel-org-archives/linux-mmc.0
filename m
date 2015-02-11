From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V4 3/4] mmc: pwrseq: Initial support for the simple MMC
 power sequence provider
Date: Wed, 11 Feb 2015 05:28:42 +0100
Message-ID: <CAPDyKFrdpknrMa62Vz4dfKaFMTdF-uXaAz3pkw_3qwNvHy49SQ@mail.gmail.com>
References: <1421658784-11980-1-git-send-email-ulf.hansson@linaro.org>
	<1421658784-11980-4-git-send-email-ulf.hansson@linaro.org>
	<CAAVeFu+ubZZGQd=zPPYm--PVCO9q-A3503Y5g50+sU4ztxU+iA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f179.google.com ([209.85.216.179]:39777 "EHLO
	mail-qc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751000AbbBKE2n (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Feb 2015 23:28:43 -0500
Received: by mail-qc0-f179.google.com with SMTP id r5so1023317qcx.10
        for <linux-mmc@vger.kernel.org>; Tue, 10 Feb 2015 20:28:43 -0800 (PST)
In-Reply-To: <CAAVeFu+ubZZGQd=zPPYm--PVCO9q-A3503Y5g50+sU4ztxU+iA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alexandre Courbot <gnurou@gmail.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Arend van Spriel <arend@broadcom.com>, Sascha Hauer <s.hauer@pengutronix.de>, Olof Johansson <olof@lixom.net>, Russell King <linux@arm.linux.org.uk>, Hans de Goede <hdegoede@redhat.com>, Doug Anderson <dianders@chromium.org>, NeilBrown <neilb@suse.de>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Mark Rutland <mark.rutland@arm.com>

[...]

>> +int mmc_pwrseq_simple_alloc(struct mmc_host *host, struct device *dev)
>> +{
>> +       struct mmc_pwrseq_simple *pwrseq;
>> +
>> +       pwrseq = kzalloc(sizeof(struct mmc_pwrseq_simple), GFP_KERNEL);
>> +       if (!pwrseq)
>> +               return -ENOMEM;
>> +
>> +       pwrseq->pwrseq.ops = &mmc_pwrseq_simple_ops;
>> +       host->pwrseq = &pwrseq->pwrseq;
>
> How about making this function return a struct mmc_pwrseq * so this
> last line can be moved to mmc_pwrseq_alloc() instead of requiring all
> power sequences to do it?
>
> The same applies to
>
>     host->pwrseq = NULL;
>
> in mmc_pwrseq_simple_free(), which could be done in mmc_pwrseq_free() it seems.

Thanks for reviewing!

I like you suggestion, though $subject patch is already part of the PR for 3.20.

Feel free to send a patch, I would happily apply it.

Kind regards
Uffe
