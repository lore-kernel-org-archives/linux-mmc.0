From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2] mmc: sdhci-msm: Boost controller core clock
Date: Mon, 16 Nov 2015 12:50:05 +0100
Message-ID: <CAPDyKFr2OyUPKjhN2=Yif=TzWoaHoKeBxYfBExxJhNCwnuhQdg@mail.gmail.com>
References: <1436183618-15330-1-git-send-email-ivan.ivanov@linaro.org>
	<CAJAp7OjdiD_x0aU89HNq8PCiGqs+fvATHuVARxU4gE4yVusRNg@mail.gmail.com>
	<CAPDyKFpQ2oK49ZwaBuk9bUPDEpzSyic2d1L9Qj2t8D1+wmDYtA@mail.gmail.com>
	<20151106233913.GB30882@usrtlx11787.corpusers.net>
	<CAPDyKFqZ+1Ax9e58b0K5B+tYoNtsC0uQS3zcQR7tu5TM+51nbw@mail.gmail.com>
	<20151110201841.GB24116@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f171.google.com ([209.85.160.171]:34002 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751628AbbKPLuG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Nov 2015 06:50:06 -0500
Received: by ykfs79 with SMTP id s79so234376177ykf.1
        for <linux-mmc@vger.kernel.org>; Mon, 16 Nov 2015 03:50:05 -0800 (PST)
In-Reply-To: <20151110201841.GB24116@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Bjorn Andersson <bjorn.andersson@sonymobile.com>, Bjorn Andersson <bjorn@kryo.se>, "Ivan T. Ivanov" <ivan.ivanov@linaro.org>, Georgi Djakov <georgi.djakov@linaro.org>, Peter Griffin <peter.griffin@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>

[...]

>> Ahh, I see.
>>
>> It seems like a reasonable assumption that the controller can't cope
>> with a higher clock rate than 100 MHz as "input" clock. That would
>> then mean that there are different versions of the controller, as it
>> seems like for some version it's fine with 200MHz and for some 100MHz.
>>
>> According to the DT compatible strings, *one* version is currently
>> supported, "qcom,sdhci-msm-v4"...
>
> The same version of hardware is there 4 times. The difference is
> the maximum clock frequency supported by them is different. In
> downstream kernels we've handled this by trimming the frequency
> tables for the different controllers in the clock driver.
> Setting the clock to INT_MAX will make it run at 400MHz, which
> doesn't look to be supported by anything besides sdc1 on 8974ac.
>
>>
>> I see two viable solutions. One would be to limit the clock rate
>> depending on the version of the controller (new compatible strings
>> needs to be added). Another one would be to limit the clock rate by
>> using the existing DT binding for max-frequency, and thus do a
>> clk_set_rate(mmc->f_max) during probe.
>>
>
> I'd rather see that done via OPP tables in DT, but I suppose
> max-frequency is fine too. We'll need to use OPPs soon enough
> because there's a voltage associated with that frequency.

Okay, thanks for sharing the details.

>
> In case you're wondering, the max frequency for sdc1 on 8974ac is
> 400MHz. If it's just a plain 8974pro then the max frequency is
> 200MHz. Otherwise, sdc2 maxes out at 200Mhz and sdc3 and sdc4 max
> out at 100MHz.

When you say that sdc1 supports 400MHz, what does that mean? That it
actually can cope with that clock rate when communicating with the MMC
card?

This makes me wonder how you deal with power management (DVFS).

For example when you have the possibility to gate this clock (at
request inactivity) when the rate is set to 400 MHz and OPP is
increased, how will then that clock gating affect the OPP?

Kind regards
Uffe
