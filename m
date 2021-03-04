Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DFE4C4332B
	for <linux-mmc@archiver.kernel.org>; Thu,  4 Mar 2021 15:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8F7464FD6
	for <linux-mmc@archiver.kernel.org>; Thu,  4 Mar 2021 15:18:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234095AbhCDPRk (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 4 Mar 2021 10:17:40 -0500
Received: from z11.mailgun.us ([104.130.96.11]:25462 "EHLO z11.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232334AbhCDPRb (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 4 Mar 2021 10:17:31 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1614871032; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=dyltIQ8oRrwKvMEyJ11sgR7hrRe+moPL6rUKrk/x2wk=;
 b=sQXYWaxXNp+Qf1Iz/L7Z98exnrA2ikVhT/9hAr/498bCX38nG6xNOftlHEhizSoIGtRA4xrr
 SCma+m+j4hk8/nYyrvXAI3m/B/gorgkzmu2PgpyijUe1SaRQQhNEXcyOsT5cdB4cH1Gnoovi
 hUs5njDOODQpBau+aZIz/G/Ejvk=
X-Mailgun-Sending-Ip: 104.130.96.11
X-Mailgun-Sid: WyJiYTcxMiIsICJsaW51eC1tbWNAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 6040f9d4c862e1b9fd27f3f6 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 04 Mar 2021 15:16:36
 GMT
Sender: pragalla=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9B837C43461; Thu,  4 Mar 2021 15:16:36 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: pragalla)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9EED9C433CA;
        Thu,  4 Mar 2021 15:16:35 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 04 Mar 2021 20:46:35 +0530
From:   pragalla@codeaurora.org
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Pradeep P V K <pragalla@qti.qualcomm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Sahitya Tummala <stummala@codeaurora.org>,
        Ram Prakash Gupta <rampraka@codeaurora.org>,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        linux-mmc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2] mmc: sdhci: Check for reset prior to DMA address unmap
In-Reply-To: <CAPDyKFqFNr7AiOdVP07XS=CKpMbDKC7n0gMPu0516fgH3=S18Q@mail.gmail.com>
References: <1614760331-43499-1-git-send-email-pragalla@qti.qualcomm.com>
 <CAPDyKFqFNr7AiOdVP07XS=CKpMbDKC7n0gMPu0516fgH3=S18Q@mail.gmail.com>
Message-ID: <3962320b58beaa4626ed69b3120d4246@codeaurora.org>
X-Sender: pragalla@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 2021-03-04 19:19, Ulf Hansson wrote:
> On Wed, 3 Mar 2021 at 09:32, Pradeep P V K <pragalla@qti.qualcomm.com> 
> wrote:
>> 
>> From: Pradeep P V K <pragalla@codeaurora.org>
>> 
>> For data read commands, SDHC may initiate data transfers even before 
>> it
>> completely process the command response. In case command itself fails,
>> driver un-maps the memory associated with data transfer but this 
>> memory
>> can still be accessed by SDHC for the already initiated data transfer.
>> This scenario can lead to un-mapped memory access error.
>> 
>> To avoid this scenario, reset SDHC (when command fails) prior to
>> un-mapping memory. Resetting SDHC ensures that all in-flight data
>> transfers are either aborted or completed. So we don't run into this
>> scenario.
>> 
>> Swap the reset, un-map steps sequence in sdhci_request_done().
>> 
>> Changes since V1:
>> - Added an empty line and fixed the comment style.
>> - Retained the Acked-by signoff.
>> 
>> Suggested-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
>> Signed-off-by: Pradeep P V K <pragalla@codeaurora.org>
>> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Hi Uffe,
> 
> Seems like it might be a good idea to tag this for stable? I did that,
> but awaiting for your confirmation.
> 
Yes, this fix is applicable for all stable starting from 4.9 (n/a for 
4.4).
Kindly go ahead.

> So, applied for next, thanks!
> 
> Kind regards
> Uffe
> 
Thanks and Regards,
Pradeep

> 
>> ---
>>  drivers/mmc/host/sdhci.c | 60 
>> +++++++++++++++++++++++++-----------------------
>>  1 file changed, 31 insertions(+), 29 deletions(-)
>> 
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index 646823d..130fd2d 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -2998,6 +2998,37 @@ static bool sdhci_request_done(struct 
>> sdhci_host *host)
>>         }
>> 
>>         /*
>> +        * The controller needs a reset of internal state machines
>> +        * upon error conditions.
>> +        */
>> +       if (sdhci_needs_reset(host, mrq)) {
>> +               /*
>> +                * Do not finish until command and data lines are 
>> available for
>> +                * reset. Note there can only be one other mrq, so it 
>> cannot
>> +                * also be in mrqs_done, otherwise host->cmd and 
>> host->data_cmd
>> +                * would both be null.
>> +                */
>> +               if (host->cmd || host->data_cmd) {
>> +                       spin_unlock_irqrestore(&host->lock, flags);
>> +                       return true;
>> +               }
>> +
>> +               /* Some controllers need this kick or reset won't work 
>> here */
>> +               if (host->quirks & SDHCI_QUIRK_CLOCK_BEFORE_RESET)
>> +                       /* This is to force an update */
>> +                       host->ops->set_clock(host, host->clock);
>> +
>> +               /*
>> +                * Spec says we should do both at the same time, but 
>> Ricoh
>> +                * controllers do not like that.
>> +                */
>> +               sdhci_do_reset(host, SDHCI_RESET_CMD);
>> +               sdhci_do_reset(host, SDHCI_RESET_DATA);
>> +
>> +               host->pending_reset = false;
>> +       }
>> +
>> +       /*
>>          * Always unmap the data buffers if they were mapped by
>>          * sdhci_prepare_data() whenever we finish with a request.
>>          * This avoids leaking DMA mappings on error.
>> @@ -3060,35 +3091,6 @@ static bool sdhci_request_done(struct 
>> sdhci_host *host)
>>                 }
>>         }
>> 
>> -       /*
>> -        * The controller needs a reset of internal state machines
>> -        * upon error conditions.
>> -        */
>> -       if (sdhci_needs_reset(host, mrq)) {
>> -               /*
>> -                * Do not finish until command and data lines are 
>> available for
>> -                * reset. Note there can only be one other mrq, so it 
>> cannot
>> -                * also be in mrqs_done, otherwise host->cmd and 
>> host->data_cmd
>> -                * would both be null.
>> -                */
>> -               if (host->cmd || host->data_cmd) {
>> -                       spin_unlock_irqrestore(&host->lock, flags);
>> -                       return true;
>> -               }
>> -
>> -               /* Some controllers need this kick or reset won't work 
>> here */
>> -               if (host->quirks & SDHCI_QUIRK_CLOCK_BEFORE_RESET)
>> -                       /* This is to force an update */
>> -                       host->ops->set_clock(host, host->clock);
>> -
>> -               /* Spec says we should do both at the same time, but 
>> Ricoh
>> -                  controllers do not like that. */
>> -               sdhci_do_reset(host, SDHCI_RESET_CMD);
>> -               sdhci_do_reset(host, SDHCI_RESET_DATA);
>> -
>> -               host->pending_reset = false;
>> -       }
>> -
>>         host->mrqs_done[i] = NULL;
>> 
>>         spin_unlock_irqrestore(&host->lock, flags);
>> --
>> 2.7.4
>> 
