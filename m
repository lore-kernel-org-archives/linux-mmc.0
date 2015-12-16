From: "Ivan T. Ivanov" <ivan.ivanov@linaro.org>
Subject: Re: [PATCH v2] mmc: sdhci-msm: Boost controller core clock
Date: Wed, 16 Dec 2015 13:44:01 +0200
Message-ID: <942B071D-D7F6-4D20-916C-BBE9096146E9@linaro.org>
References: <1436183618-15330-1-git-send-email-ivan.ivanov@linaro.org> <CAJAp7OjdiD_x0aU89HNq8PCiGqs+fvATHuVARxU4gE4yVusRNg@mail.gmail.com> <CAPDyKFpQ2oK49ZwaBuk9bUPDEpzSyic2d1L9Qj2t8D1+wmDYtA@mail.gmail.com> <20151106233913.GB30882@usrtlx11787.corpusers.net> <CAPDyKFqZ+1Ax9e58b0K5B+tYoNtsC0uQS3zcQR7tu5TM+51nbw@mail.gmail.com> <20151110201841.GB24116@codeaurora.org> <CAPDyKFq-=dqJrDOLVeXN5P2aYC1v4Mwk+s=bKSDrobcBWnO+Lg@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:34600 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752471AbbLPLoG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Dec 2015 06:44:06 -0500
Received: by mail-wm0-f46.google.com with SMTP id l126so35638127wml.1
        for <linux-mmc@vger.kernel.org>; Wed, 16 Dec 2015 03:44:05 -0800 (PST)
In-Reply-To: <CAPDyKFq-=dqJrDOLVeXN5P2aYC1v4Mwk+s=bKSDrobcBWnO+Lg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>, Bjorn Andersson <bjorn.andersson@sonymobile.com>, Georgi Djakov <georgi.djakov@linaro.org>, Bjorn Andersson <bjorn@kryo.se>, Peter Griffin <peter.griffin@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>


> On Dec 16, 2015, at 12:18 PM, Ulf Hansson <ulf.hansson@linaro.org> wr=
ote:
>=20
> [...]
>=20
>>> It seems like a reasonable assumption that the controller can't cop=
e
>>> with a higher clock rate than 100 MHz as "input" clock. That would
>>> then mean that there are different versions of the controller, as i=
t
>>> seems like for some version it's fine with 200MHz and for some 100M=
Hz.
>>>=20
>>> According to the DT compatible strings, *one* version is currently
>>> supported, "qcom,sdhci-msm-v4"...
>>=20
>> The same version of hardware is there 4 times. The difference is
>> the maximum clock frequency supported by them is different. In
>> downstream kernels we've handled this by trimming the frequency
>> tables for the different controllers in the clock driver.
>> Setting the clock to INT_MAX will make it run at 400MHz, which
>> doesn't look to be supported by anything besides sdc1 on 8974ac.
>>=20
>>>=20
>>> I see two viable solutions. One would be to limit the clock rate
>>> depending on the version of the controller (new compatible strings
>>> needs to be added). Another one would be to limit the clock rate by
>>> using the existing DT binding for max-frequency, and thus do a
>>> clk_set_rate(mmc->f_max) during probe.
>>>=20
>>=20
>> I'd rather see that done via OPP tables in DT, but I suppose
>> max-frequency is fine too. We'll need to use OPPs soon enough
>> because there's a voltage associated with that frequency.
>>=20
>> In case you're wondering, the max frequency for sdc1 on 8974ac is
>> 400MHz. If it's just a plain 8974pro then the max frequency is
>> 200MHz. Otherwise, sdc2 maxes out at 200Mhz and sdc3 and sdc4 max
>> out at 100MHz.
>>=20
>=20
> I think we have reached a consensus on the viable options.
>=20
> As we haven't heard from Ivan, do someone want to send a patch for
> this or shall we just revert $subject patch (which I can deal with)?

I am following this discussion, but I am not sure what I could do.=20

If my understanding is correct, even if controllers report same version=
,
they don=E2=80=99t support 400MHz core clock.=20

Initial patch fixes real issue. I am voting for =E2=80=9Cmax-frequency=E2=
=80=9D DT property.

I don=E2=80=99t have 8974ac, so I can not test the change.

Regards,
Ivan

