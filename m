From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2] mmc: sdhci-msm: Boost controller core clock
Date: Wed, 16 Dec 2015 14:49:35 +0100
Message-ID: <CAPDyKFrrRkoHkSJnwgju4TfxXW9i24SJt3q=ZApuV4Lyux69UA@mail.gmail.com>
References: <1436183618-15330-1-git-send-email-ivan.ivanov@linaro.org>
	<CAJAp7OjdiD_x0aU89HNq8PCiGqs+fvATHuVARxU4gE4yVusRNg@mail.gmail.com>
	<CAPDyKFpQ2oK49ZwaBuk9bUPDEpzSyic2d1L9Qj2t8D1+wmDYtA@mail.gmail.com>
	<20151106233913.GB30882@usrtlx11787.corpusers.net>
	<CAPDyKFqZ+1Ax9e58b0K5B+tYoNtsC0uQS3zcQR7tu5TM+51nbw@mail.gmail.com>
	<20151110201841.GB24116@codeaurora.org>
	<CAPDyKFq-=dqJrDOLVeXN5P2aYC1v4Mwk+s=bKSDrobcBWnO+Lg@mail.gmail.com>
	<942B071D-D7F6-4D20-916C-BBE9096146E9@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f182.google.com ([209.85.220.182]:35687 "EHLO
	mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754166AbbLPNtg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Dec 2015 08:49:36 -0500
Received: by mail-qk0-f182.google.com with SMTP id u65so44438747qkh.2
        for <linux-mmc@vger.kernel.org>; Wed, 16 Dec 2015 05:49:35 -0800 (PST)
In-Reply-To: <942B071D-D7F6-4D20-916C-BBE9096146E9@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Ivan T. Ivanov" <ivan.ivanov@linaro.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>, Bjorn Andersson <bjorn.andersson@sonymobile.com>, Georgi Djakov <georgi.djakov@linaro.org>, Bjorn Andersson <bjorn@kryo.se>, Peter Griffin <peter.griffin@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>

On 16 December 2015 at 12:44, Ivan T. Ivanov <ivan.ivanov@linaro.org> w=
rote:
>
>> On Dec 16, 2015, at 12:18 PM, Ulf Hansson <ulf.hansson@linaro.org> w=
rote:
>>
>> [...]
>>
>>>> It seems like a reasonable assumption that the controller can't co=
pe
>>>> with a higher clock rate than 100 MHz as "input" clock. That would
>>>> then mean that there are different versions of the controller, as =
it
>>>> seems like for some version it's fine with 200MHz and for some 100=
MHz.
>>>>
>>>> According to the DT compatible strings, *one* version is currently
>>>> supported, "qcom,sdhci-msm-v4"...
>>>
>>> The same version of hardware is there 4 times. The difference is
>>> the maximum clock frequency supported by them is different. In
>>> downstream kernels we've handled this by trimming the frequency
>>> tables for the different controllers in the clock driver.
>>> Setting the clock to INT_MAX will make it run at 400MHz, which
>>> doesn't look to be supported by anything besides sdc1 on 8974ac.
>>>
>>>>
>>>> I see two viable solutions. One would be to limit the clock rate
>>>> depending on the version of the controller (new compatible strings
>>>> needs to be added). Another one would be to limit the clock rate b=
y
>>>> using the existing DT binding for max-frequency, and thus do a
>>>> clk_set_rate(mmc->f_max) during probe.
>>>>
>>>
>>> I'd rather see that done via OPP tables in DT, but I suppose
>>> max-frequency is fine too. We'll need to use OPPs soon enough
>>> because there's a voltage associated with that frequency.
>>>
>>> In case you're wondering, the max frequency for sdc1 on 8974ac is
>>> 400MHz. If it's just a plain 8974pro then the max frequency is
>>> 200MHz. Otherwise, sdc2 maxes out at 200Mhz and sdc3 and sdc4 max
>>> out at 100MHz.
>>>
>>
>> I think we have reached a consensus on the viable options.
>>
>> As we haven't heard from Ivan, do someone want to send a patch for
>> this or shall we just revert $subject patch (which I can deal with)?
>
> I am following this discussion, but I am not sure what I could do.
>
> If my understanding is correct, even if controllers report same versi=
on,
> they don=E2=80=99t support 400MHz core clock.

Correct.

>
> Initial patch fixes real issue. I am voting for =E2=80=9Cmax-frequenc=
y=E2=80=9D DT property.

I don't have any strong opinion, so I am fine with that approach.

That means at ->probe() we need to consider whether "host->f_max" has
been obtained via DT (mmc_of_parse() parses the "max-frequency" DT
property).
If that's the case, we can choose between two solutions.

1) Consider f_max as the correct value to set via clk_set_rate() and
if f_max isn't available, fall back to a lower "default" frequency to
make sure we are safe.
2) Consider f_max as an upper limit. That means if f_max isn't
available we use INT_MAX instead.

Both alternatives requires DTB to be updated, but option 1) may be
safer as it should allow all cards to be functional, although running
in a lower frequency potentially affecting throughput.

But again, I don't care much, alternative 2 is okay by me as well.

>
> I don=E2=80=99t have 8974ac, so I can not test the change.
>

Let's hope for some help here then!

Kind regards
Uffe
