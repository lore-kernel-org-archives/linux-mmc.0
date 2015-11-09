From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2] mmc: sdhci-msm: Boost controller core clock
Date: Mon, 9 Nov 2015 11:22:00 +0100
Message-ID: <CAPDyKFqZ+1Ax9e58b0K5B+tYoNtsC0uQS3zcQR7tu5TM+51nbw@mail.gmail.com>
References: <1436183618-15330-1-git-send-email-ivan.ivanov@linaro.org>
	<CAJAp7OjdiD_x0aU89HNq8PCiGqs+fvATHuVARxU4gE4yVusRNg@mail.gmail.com>
	<CAPDyKFpQ2oK49ZwaBuk9bUPDEpzSyic2d1L9Qj2t8D1+wmDYtA@mail.gmail.com>
	<20151106233913.GB30882@usrtlx11787.corpusers.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f174.google.com ([209.85.160.174]:32875 "EHLO
	mail-yk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753048AbbKIKWC (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 9 Nov 2015 05:22:02 -0500
Received: by ykdv3 with SMTP id v3so166725345ykd.0
        for <linux-mmc@vger.kernel.org>; Mon, 09 Nov 2015 02:22:00 -0800 (PST)
In-Reply-To: <20151106233913.GB30882@usrtlx11787.corpusers.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Cc: Bjorn Andersson <bjorn@kryo.se>, "Ivan T. Ivanov" <ivan.ivanov@linaro.org>, Georgi Djakov <georgi.djakov@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Peter Griffin <peter.griffin@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>

On 7 November 2015 at 00:39, Bjorn Andersson
<bjorn.andersson@sonymobile.com> wrote:
> On Fri 06 Nov 00:10 PST 2015, Ulf Hansson wrote:
>
>> On 6 November 2015 at 02:42, Bjorn Andersson <bjorn@kryo.se> wrote:
>> > On Mon, Jul 6, 2015 at 4:53 AM, Ivan T. Ivanov <ivan.ivanov@linaro.org> wrote:
>> >> Ensure SDCC is working with maximum clock otherwise card
>> >> detection could be extremely slow, up to 7 seconds.
>> >>
>> >> Signed-off-by: Ivan T. Ivanov <ivan.ivanov@linaro.org>
>> >> Reviewed-by: Georgi Djakov <georgi.djakov@linaro.org>
>> >> Acked-by: Stephen Boyd <sboyd@codeaurora.org>
>> >> ---
>> >>
>> >> Changes since v0:
>> >> - s/falied/failed in warning message.
>> >>
>> >>  drivers/mmc/host/sdhci-msm.c | 5 +++++
>> >>  1 file changed, 5 insertions(+)
>> >>
>> >> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
>> >> index 4a09f76..4bcee03 100644
>> >> --- a/drivers/mmc/host/sdhci-msm.c
>> >> +++ b/drivers/mmc/host/sdhci-msm.c
>> >> @@ -489,6 +489,11 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>> >>                 goto pclk_disable;
>> >>         }
>> >>
>> >> +       /* Vote for maximum clock rate for maximum performance */
>> >> +       ret = clk_set_rate(msm_host->clk, INT_MAX);
>> >> +       if (ret)
>> >> +               dev_warn(&pdev->dev, "core clock boost failed\n");
>> >> +
>> >
>> > On my 8974AC devices this results in GCC_SDCC1_APPS_CLK changing from
>> > 100MHz to 200MHz for my eMMC. Unfortunately this results in the
>> > following error:
>> >
>> > [    5.103241] mmcblk0: retrying because a re-tune was needed
>> > [    5.109270] mmcblk0: error -84 transferring data, sector 5816322,
>> > nr 2, cmd response 0x900, card status 0xc00
>> >
>> > Looking at the board specification it's stated that these card should
>> > run in DDR50, so I've tried specifying "max-frequency" in the dt. I
>> > verified in sdhci_set_clock() that we get a divisor of 4, but the
>> > result is a repetition of:
>>
>> I don't follow. Are you saying that changing the clock frequency to
>> 200MHz caused the card to be initialized in HS200 mode instead of
>> DDR50?
>>
>
> No, we clock the sdhci block at 100MHz, the host->max_clk is 200MHz and
> the divisor in sdhci_set_clock() becomes 1. So if I read this correctly
> we're running HS200 at 100MHz.
>
> Bumping the clock rate to 200MHz at the block doesn't affect the max_clk
> and hence we're trying to run the bus at 200MHz.
>
> I therefor tried to just set "max-frequency" to 50MHz, getting the
> divider to be 4 and the below error.
>
> So I assume it just happened to work at 100MHz, but 200MHz is way off
> from the 50MHz the board is designed and tested for.
>
>
> Unfortunately I don't have the equipment to measure these assumptions :/

Ahh, I see.

It seems like a reasonable assumption that the controller can't cope
with a higher clock rate than 100 MHz as "input" clock. That would
then mean that there are different versions of the controller, as it
seems like for some version it's fine with 200MHz and for some 100MHz.

According to the DT compatible strings, *one* version is currently
supported, "qcom,sdhci-msm-v4"...

I see two viable solutions. One would be to limit the clock rate
depending on the version of the controller (new compatible strings
needs to be added). Another one would be to limit the clock rate by
using the existing DT binding for max-frequency, and thus do a
clk_set_rate(mmc->f_max) during probe.

Both examples are being used in other host drivers. The mmci host
driver does it the first way and the sdhci_bcm_kona does it in the
other way.

What do you think?

Kind regards
Uffe
