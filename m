From: Grant Grundler <grundler@chromium.org>
Subject: Re: [PATCH] mmc: sdhci: remove mdelay in eMMC tuning
Date: Tue, 13 May 2014 18:13:30 -0700
Message-ID: <CANEJEGt1-BYD2kaHJisQ=YBj6k4CJU5-7_bjW+M5TZ_yuMY_TQ@mail.gmail.com>
References: <1399427558-8478-1-git-send-email-nsanders@chromium.org>
	<CAPDyKFpsm_M2oY3OuVHZ-MCNezT6xwo-HPwfo1pxfrw5ySKfOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f182.google.com ([209.85.214.182]:41712 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752364AbaENBNb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 13 May 2014 21:13:31 -0400
Received: by mail-ob0-f182.google.com with SMTP id wn1so1358447obc.41
        for <linux-mmc@vger.kernel.org>; Tue, 13 May 2014 18:13:30 -0700 (PDT)
In-Reply-To: <CAPDyKFpsm_M2oY3OuVHZ-MCNezT6xwo-HPwfo1pxfrw5ySKfOg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <cjb@laptop.org>
Cc: Nick Sanders <nsanders@chromium.org>, linux-mmc <linux-mmc@vger.kernel.org>, Grant Grundler <grundler@chromium.org>, Doug Anderson <dianders@chromium.org>, Chang-Eun Choi-SSI <cu.choi@ssi.samsung.com>

On Wed, May 7, 2014 at 1:35 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 7 May 2014 03:52, Nick Sanders <nsanders@chromium.org> wrote:
>> This patch removes an unneccesary 1ms mdelay in the HS200 tuning
>> loop, called 40 times per retuning. Currently this causes a latency
>> of >40ms on any emmc accesses triggering wake from runtime PM,
>> which can occur for a significant portion of reads on a mostly idle system.
>
> Aha, so you are actually using "MMC_CAP_RUNTIME_RESUME" here - cool :-).
>
> I suppose those patches that enables the "cap" has not reached
> mainline yet. Any plans on sending them?
>
>>
>> The delay is left in place for SD Cards, which use
>> MMC_SEND_TUNING_BLOCK rather than MMC_SEND_TUNING_BLOCK_HS200.
>> I'm not able to find evidence that this is required for SD in the
>> specs I have access to, however this delay has been present from
>> initial checkin for SD so I have preserved the original behavior for
>> compatibility.
>>
>> This has been verified to fix observed glitching on local audio
>> playback and recording on apps with inbuilt assumptions on storage
>> latency.
>>
>> Signed-off-by: Nick Sanders <nsanders@chromium.org>
>> Reviewed-by: Grant Grundler <grundler@chromium.org>
>> Reviewed-by: Doug Anderson <dianders@chromium.org>
>
> Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Ulf,
Is your ACK enough to get this to land upstream or does cjb need to
respond it's been accepted?

It doesn't appear to have landed in mmc-next branch yet:
    http://git.kernel.org/cgit/linux/kernel/git/cjb/mmc.git/log/?h=mmc-next

apologies if it appears I am being impatient...but it's been almost a week now.

thanks,
grant

>
>> ---
>>  drivers/mmc/host/sdhci.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index df6d85a..05ffac2 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -1987,7 +1987,10 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
>>                 ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
>>                 tuning_loop_counter--;
>>                 timeout--;
>> -               mdelay(1);
>> +
>> +               /* eMMC spec does not require a delay between tuning cycles */
>> +               if (opcode == MMC_SEND_TUNING_BLOCK)
>> +                       mdelay(1);
>>         } while (ctrl & SDHCI_CTRL_EXEC_TUNING);
>>
>>         /*
>> --
>> 1.9.1.423.g4596e3a
>>
