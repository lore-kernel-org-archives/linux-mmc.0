From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] RFC: mmc: core: Increase delay for voltage to stabilize
 from 3.3V to 1.8V
Date: Wed, 13 May 2015 15:06:47 +0200
Message-ID: <CAPDyKFpkLhC7k+HNCYV_U7M6B615o4RgFktJ1wCXd_SxT0xiQg@mail.gmail.com>
References: <1431467171-12937-1-git-send-email-dianders@chromium.org>
	<20150513110915.GG3066@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f177.google.com ([209.85.216.177]:33709 "EHLO
	mail-qc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965001AbbEMNGs (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 13 May 2015 09:06:48 -0400
Received: by qcvo8 with SMTP id o8so21767064qcv.0
        for <linux-mmc@vger.kernel.org>; Wed, 13 May 2015 06:06:47 -0700 (PDT)
In-Reply-To: <20150513110915.GG3066@sirena.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Doug Anderson <dianders@chromium.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Johan Rudholm <johan.rudholm@axis.com>, Adrian Hunter <adrian.hunter@intel.com>, Tim Kryger <tim.kryger@gmail.com>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Andrew Gabbasov <andrew_gabbasov@mentor.com>, Sascha Hauer <s.hauer@pengutronix.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 13 May 2015 at 13:09, Mark Brown <broonie@kernel.org> wrote:
> On Tue, May 12, 2015 at 02:46:11PM -0700, Doug Anderson wrote:
>> Since the regulator used for the SDMMC IO voltage is not expected to
>> draw a lot of current, most systems will probably use an inexpensive
>> LDO for it.  LDO regulators apparently have the feature that they
>> don't actively drive the voltage down--they wait for other components
>> in the system to drag the voltage down.  Thus they will transition
>> faster under heavy loads and slower under light loads.
>
> What a LDO is doing is basically just charging up a capacitor - the
> regulation consists of monitoring the voltage on the capacitor and
> opening a transistor to charge the capacitor when the voltage droops too
> much.
>
>> From experimental evidence, we've seen the voltage change fail if the
>> card doesn't detect that the voltage fell to less than about 2.3V when
>> we turn on the clock.  On one device (that admittedly had a 47K CMD
>> pullup instead of a 10K CMD pullup) we saw that the voltage was just
>> about 2.3V after 5ms and thus the voltage change would sometimes fail.
>> Doubling the delay gave margin and made the voltage change work 100%
>> of the time, despite the slightly weaker CMD pull.
>
>> At the moment submitting this as an RFC patch since my problem _could_
>> be fixed by increasing the pull strength (or using a smaller
>> capacitor).  However being a little bit more lenient to strange
>> hardware could also be a good thing.
>
> Right, and this is probably going beyond the delays that the regulator
> API is handling since it's not something the regulator hardware is
> actively managing.

Thanks for elaborating from the regulator perspective. So may I apply
your ack for this one?

Kind regards
Uffe
