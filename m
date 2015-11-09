From: Georgi Djakov <georgi.djakov@linaro.org>
Subject: Re: [PATCH v2] mmc: sdhci-msm: Boost controller core clock
Date: Mon, 9 Nov 2015 19:09:02 +0200
Message-ID: <5640D32E.5050307@linaro.org>
References: <1436183618-15330-1-git-send-email-ivan.ivanov@linaro.org>
 <CAJAp7OjdiD_x0aU89HNq8PCiGqs+fvATHuVARxU4gE4yVusRNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:34043 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752580AbbKIRJI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 9 Nov 2015 12:09:08 -0500
Received: by wmnn186 with SMTP id n186so115685869wmn.1
        for <linux-mmc@vger.kernel.org>; Mon, 09 Nov 2015 09:09:06 -0800 (PST)
In-Reply-To: <CAJAp7OjdiD_x0aU89HNq8PCiGqs+fvATHuVARxU4gE4yVusRNg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Bjorn Andersson <bjorn@kryo.se>, "Ivan T. Ivanov" <ivan.ivanov@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>, Peter Griffin <peter.griffin@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>

On 11/06/2015 03:42 AM, Bjorn Andersson wrote:
> On Mon, Jul 6, 2015 at 4:53 AM, Ivan T. Ivanov <ivan.ivanov@linaro.org> wrote:
>> Ensure SDCC is working with maximum clock otherwise card
>> detection could be extremely slow, up to 7 seconds.
>>
>> Signed-off-by: Ivan T. Ivanov <ivan.ivanov@linaro.org>
>> Reviewed-by: Georgi Djakov <georgi.djakov@linaro.org>
>> Acked-by: Stephen Boyd <sboyd@codeaurora.org>
>> ---
>>
>> Changes since v0:
>> - s/falied/failed in warning message.
>>
>>  drivers/mmc/host/sdhci-msm.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
>> index 4a09f76..4bcee03 100644
>> --- a/drivers/mmc/host/sdhci-msm.c
>> +++ b/drivers/mmc/host/sdhci-msm.c
>> @@ -489,6 +489,11 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>>                 goto pclk_disable;
>>         }
>>
>> +       /* Vote for maximum clock rate for maximum performance */
>> +       ret = clk_set_rate(msm_host->clk, INT_MAX);
>> +       if (ret)
>> +               dev_warn(&pdev->dev, "core clock boost failed\n");
>> +
> 
> On my 8974AC devices this results in GCC_SDCC1_APPS_CLK changing from
> 100MHz to 200MHz for my eMMC. Unfortunately this results in the
> following error:
> 
> [    5.103241] mmcblk0: retrying because a re-tune was needed
> [    5.109270] mmcblk0: error -84 transferring data, sector 5816322,
> nr 2, cmd response 0x900, card status 0xc00
> 
> Looking at the board specification it's stated that these card should
> run in DDR50, so I've tried specifying "max-frequency" in the dt. I
> verified in sdhci_set_clock() that we get a divisor of 4, but the
> result is a repetition of:
> 
> [    1.702312] mmc1: Switching to 3.3V signalling voltage failed
> [    1.837987] mmc1: power class selection to bus width 8 ddr 0 failed
> [    1.846227] mmc1: error -110 whilst initialising MMC card
> [    1.946303] mmc1: Reset 0x1 never completed.
> 
> I tried to disable HS200 by specifying SDHCI_QUIRK2_BROKEN_HS200. This
> makes the card come up nicely again.
> 
> 
> Is there any other way to force the link to DDR50? Is it acceptable to
> expose the broken-hs200 quirk in dt so I can use that for now?
> 
> (The downstream fix used for this was apparently to just remove all
> other caps...)
> 

Hi Bjorn,
There are two dev_dbg lines in the driver. What do they print for
major and minor versions?

Thanks,
Georgi

