From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2] mmc: sdhci-msm: Boost controller core clock
Date: Wed, 18 Nov 2015 09:04:07 +0100
Message-ID: <CAPDyKFr=5dVLrgLmz21vBOBfbY2Kaj0h58K8_Vb7JHQ-WnhPTA@mail.gmail.com>
References: <1436183618-15330-1-git-send-email-ivan.ivanov@linaro.org>
	<CAJAp7OjdiD_x0aU89HNq8PCiGqs+fvATHuVARxU4gE4yVusRNg@mail.gmail.com>
	<CAPDyKFpQ2oK49ZwaBuk9bUPDEpzSyic2d1L9Qj2t8D1+wmDYtA@mail.gmail.com>
	<20151106233913.GB30882@usrtlx11787.corpusers.net>
	<CAPDyKFqZ+1Ax9e58b0K5B+tYoNtsC0uQS3zcQR7tu5TM+51nbw@mail.gmail.com>
	<20151110201841.GB24116@codeaurora.org>
	<CAPDyKFr2OyUPKjhN2=Yif=TzWoaHoKeBxYfBExxJhNCwnuhQdg@mail.gmail.com>
	<20151118013827.GC32672@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20151118013827.GC32672@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Bjorn Andersson <bjorn.andersson@sonymobile.com>, Bjorn Andersson <bjorn@kryo.se>, "Ivan T. Ivanov" <ivan.ivanov@linaro.org>, Georgi Djakov <georgi.djakov@linaro.org>, Peter Griffin <peter.griffin@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 18 November 2015 at 02:38, Stephen Boyd <sboyd@codeaurora.org> wrote:
> On 11/16, Ulf Hansson wrote:
>> [...]
>>
>>
>> >
>> > In case you're wondering, the max frequency for sdc1 on 8974ac is
>> > 400MHz. If it's just a plain 8974pro then the max frequency is
>> > 200MHz. Otherwise, sdc2 maxes out at 200Mhz and sdc3 and sdc4 max
>> > out at 100MHz.
>>
>> When you say that sdc1 supports 400MHz, what does that mean? That it
>> actually can cope with that clock rate when communicating with the MMC
>> card?
>
> I suspect there must be some internal divider in the sdc IP
> itself so that it doesn't put out 400MHz on the bus, but I really
> don't know. What I mean is that the clock going into the IP from
> the clock controller is running at 400MHz, after it goes into the
> IP it could be divided, etc. before exiting the SoC on some pin.

Okay, got it!

>
>>
>> This makes me wonder how you deal with power management (DVFS).
>>
>> For example when you have the possibility to gate this clock (at
>> request inactivity) when the rate is set to 400 MHz and OPP is
>> increased, how will then that clock gating affect the OPP?
>
> Sorry I'm not really following the question here. The gate will
> disable the clock in the clock controller, cutting the signal off
> upstream of the sdc IP. When we do DVFS we'll stop considering
> this clock as part of the overall power level for the voltage
> associated with the frequency. When all other clocks that are
> using the same voltage and are on and running at frequencies that
> don't need that high of voltage we can reduce the voltage and
> drop down to something lower.

Sorry for being a bit vague, but you kind of answered my question, thanks!

I haven't been following DVFS evolution lately, but one of my earlier
concern was the how to use clk rate change notifiers to deal with OPP
transitions.

As in this case the clock rate would be fixed, and thus we can't use
the clk rate change notifiers to trigger an OPP change. But I guess
there is a solution to that then?

Kind regards
Uffe
