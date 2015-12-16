From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2] mmc: sdhci-msm: Boost controller core clock
Date: Wed, 16 Dec 2015 11:18:42 +0100
Message-ID: <CAPDyKFq-=dqJrDOLVeXN5P2aYC1v4Mwk+s=bKSDrobcBWnO+Lg@mail.gmail.com>
References: <1436183618-15330-1-git-send-email-ivan.ivanov@linaro.org>
	<CAJAp7OjdiD_x0aU89HNq8PCiGqs+fvATHuVARxU4gE4yVusRNg@mail.gmail.com>
	<CAPDyKFpQ2oK49ZwaBuk9bUPDEpzSyic2d1L9Qj2t8D1+wmDYtA@mail.gmail.com>
	<20151106233913.GB30882@usrtlx11787.corpusers.net>
	<CAPDyKFqZ+1Ax9e58b0K5B+tYoNtsC0uQS3zcQR7tu5TM+51nbw@mail.gmail.com>
	<20151110201841.GB24116@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151110201841.GB24116@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>, Bjorn Andersson <bjorn.andersson@sonymobile.com>, Georgi Djakov <georgi.djakov@linaro.org>, "Ivan T. Ivanov" <ivan.ivanov@linaro.org>
Cc: Bjorn Andersson <bjorn@kryo.se>, Peter Griffin <peter.griffin@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

[...]

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
>
> In case you're wondering, the max frequency for sdc1 on 8974ac is
> 400MHz. If it's just a plain 8974pro then the max frequency is
> 200MHz. Otherwise, sdc2 maxes out at 200Mhz and sdc3 and sdc4 max
> out at 100MHz.
>

I think we have reached a consensus on the viable options.

As we haven't heard from Ivan, do someone want to send a patch for
this or shall we just revert $subject patch (which I can deal with)?

Kind regards
Uffe
