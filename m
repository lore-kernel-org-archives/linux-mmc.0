From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci: Restore behavior while creating OCR mask
Date: Mon, 8 Jun 2015 11:21:42 +0200
Message-ID: <CAPDyKFqS7tks=fkU8DiMCNBgahJLXavfgFzcv7EV0ncHNVay+w@mail.gmail.com>
References: <1433498817-16679-1-git-send-email-ulf.hansson@linaro.org>
	<CAD7vxxKGV__f-r3yc+=9g8=97DRFTEiwZH6Fj_6y3+9ze+VB3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f51.google.com ([209.85.192.51]:35463 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752968AbbFHJVn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 8 Jun 2015 05:21:43 -0400
Received: by qgg3 with SMTP id 3so21910701qgg.2
        for <linux-mmc@vger.kernel.org>; Mon, 08 Jun 2015 02:21:42 -0700 (PDT)
In-Reply-To: <CAD7vxxKGV__f-r3yc+=9g8=97DRFTEiwZH6Fj_6y3+9ze+VB3g@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tim Kryger <tim.kryger@gmail.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Yangbo Lu <yangbo.lu@freescale.com>

On 6 June 2015 at 20:52, Tim Kryger <tim.kryger@gmail.com> wrote:
> On Fri, Jun 5, 2015 at 3:06 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> Commit 3a48edc4bd68 ("mmc: sdhci: Use mmc core regulator infrastucture")
>> changed the behavior for how to assign the ocr_avail mask for the mmc
>> host. More precisely it started to mask the bits instead of assigning
>> them.
>>
>> Restore the behavior, but also make it clear that an OCR mask created
>> from an external regulator overrides the other ones.
>>
>> Fixes: 3a48edc4bd68 ("mmc: sdhci: Use mmc core regulator infrastucture")
>> Cc: Tim Kryger <tim.kryger@gmail.com>
>> Reported-by: Yangbo Lu <yangbo.lu@freescale.com>
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>> ---
>>  drivers/mmc/host/sdhci.c | 9 +++++----
>>  1 file changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index 1b4861d..706bb60 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -3256,13 +3256,14 @@ int sdhci_add_host(struct sdhci_host *host)
>>                                    SDHCI_MAX_CURRENT_MULTIPLIER;
>>         }
>>
>> -       /* If OCR set by external regulators, use it instead */
>> +       /* If OCR set by host, use it instead. */
>> +       if (host->ocr_mask)
>> +               ocr_avail = host->ocr_mask;
>> +
>> +       /* If OCR set by external regulators, give it highest prio. */
>>         if (mmc->ocr_avail)
>>                 ocr_avail = mmc->ocr_avail;
>>
>> -       if (host->ocr_mask)
>> -               ocr_avail &= host->ocr_mask;
>> -
>>         mmc->ocr_avail = ocr_avail;
>>         mmc->ocr_avail_sdio = ocr_avail;
>>         if (host->ocr_avail_sdio)
>> --
>> 1.9.1
>>
>
> The patch looks good.  Perhaps include this in the commit message.
>
> The OCR mask is determined by one of the following with this priority:
>
>   1. Supported ranges of external regulator if one supplies VDD
>   2. Host OCR mask if set by the driver (based on DT properties)
>   3. The capabilities reported by the controller itself
>
> Reviewed-by: Tim Kryger <tim.kryger@gmail.com>

Tim, thanks for you review!

I have applied the patch for my next branch and updated the commit
message according to your proposal.

Kind regards
Uffe
