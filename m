Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B980C7618D
	for <linux-mmc@archiver.kernel.org>; Thu,  6 Apr 2023 12:49:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjDFMt4 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 6 Apr 2023 08:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236387AbjDFMtz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 6 Apr 2023 08:49:55 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 380757ED2
        for <linux-mmc@vger.kernel.org>; Thu,  6 Apr 2023 05:49:43 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 336ATw9q027880;
        Thu, 6 Apr 2023 13:45:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=zT5xwQSUkWp9peu1emk0ObpqbLoHMLcORF6k156EZm8=;
 b=qRBhvsdqeH40V5Oj/NTPYvoKlDy+YMCXJNbxidYNKmNbbeYHUVyQdU79hx+Gr6bdri29
 D1tNkh0AVo4UbwqFRCpPaaJN0vZo3c4RiEtuWUhoZqPKo2z+on/GcEoXl46hDv0J/7Wn
 TgJbGQBGTbDmWLJprY9jobLkY/561TKJeFF3xN3df5MjD50UvsgFJ0fl/ISbBY6co9VW
 UGJK4fqvXCtDpHhZgYTPnwuT6av1DPeEZL0JeqzvdIyVgah8pOR2RUuCAkRsjMY7/1Ff
 UyQocXvQDpRwLfEXEOPjPZe5Im7jaoag8bb3YRrvQfVbcd4XOUkELF301g/nQAN21obQ HQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ps5k5gtf7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Apr 2023 13:45:01 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2DF9F10003A;
        Thu,  6 Apr 2023 13:45:01 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 14B6021ED5D;
        Thu,  6 Apr 2023 13:45:01 +0200 (CEST)
Received: from [10.201.21.210] (10.201.21.210) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Thu, 6 Apr
 2023 13:44:58 +0200
Message-ID: <059a7da3-31e2-bd45-d640-ad604145acac@foss.st.com>
Date:   Thu, 6 Apr 2023 13:44:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [Linux-stm32] [PATCH 00/13] Fix busydetect on Ux500 PL180/MMCI
Content-Language: en-US
From:   Yann Gautier <yann.gautier@foss.st.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Stefan Hansson <newbyte@disroot.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     <linux-mmc@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20230405-pl180-busydetect-fix-v1-0-28ac19a74e5e@linaro.org>
 <7d1b13cb-9588-d4c3-73ac-ac6a5a1dacdf@foss.st.com>
In-Reply-To: <7d1b13cb-9588-d4c3-73ac-ac6a5a1dacdf@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.201.21.210]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-06_06,2023-04-06_01,2023-02-09_01
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 4/6/23 11:27, Yann Gautier wrote:
> On 4/5/23 08:50, Linus Walleij wrote:
>> This series fixes a pretty serious problem in the MMCI
>> busy detect handling, discovered only after going up and
>> down a ladder of refactorings.
>>
>> The code is written expecting the Ux500 busy detect
>> to fire two interrupts: one at the start of the busy
>> signalling and one at the end of the busy signalling.
>>
>> The root cause of the problem seen on some devices
>> is that only the first IRQ arrives, and then the device
>> hangs, waiting perpetually for the next IRQ to arrive.
>>
>> This is eventually solved by adding a timeout using
>> a delayed work that fire after 10 ms if the busy detect
>> has not stopped at this point. (Other delay spans can
>> be suggested.) This is the last patch in the series.
>>
>> I included the rewrite of the entire busy detect logic
>> to use a state machine as this makes it way easier to
>> debug and will print messages about other error
>> conditions as well.
>>
>> The problem affects especially the Skomer
>> (Samsung GT-I9070) and Kyle (Samsung SGH-I407).
>>
>> It is fine to just apply this for the -next kernel,
>> despite it fixes the busy detect that has been broken
>> for these devices for a while, we can think about
>> backporting a simpler version of the timeout for
>> stable kernels if we want.
>>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>> ---
>> Linus Walleij (13):
>>        mmc: mmci: Only call busy_complete if callback defined
>>        mmc: mmci: Clear busy_status when starting command
>>        mmc: mmci: Unwind big if() clause
>>        mmc: mmci: Stash status while waiting for busy
>>        mmc: mmci: Break out error check in busy detect
>>        mmc: mmci: Make busy complete state machine explicit
>>        mmc: mmci: Retry the busy start condition
>>        mmc: mmci: Use state machine state as exit condition
>>        mmc: mmci: Use a switch statement machine
>>        mmc: mmci: Break out a helper function
>>        mmc: mmci: mmci_card_busy() from state machine
>>        mmc: mmci: Drop end IRQ from Ux500 busydetect
>>        mmc: mmci: Add busydetect timeout
>>
>>   drivers/mmc/host/mmci.c             | 165 
>> +++++++++++++++++++++++++++---------
>>   drivers/mmc/host/mmci.h             |  17 ++++
>>   drivers/mmc/host/mmci_stm32_sdmmc.c |   6 +-
>>   3 files changed, 149 insertions(+), 39 deletions(-)
>> ---
>> base-commit: fe15c26ee26efa11741a7b632e9f23b01aca4cc6
>> change-id: 20230405-pl180-busydetect-fix-66a0360d398a
>>
>> Best regards,
> 
> Hi Linus,
> 
> With this series, it is no more possible to switch to UHS modes on 
> STM32MP1. I will add some traces and try to see what's wrong or missing 
> to have it working again.
> I've tested on STM32MP157F-EV1 board and got those traces:
> [    3.186504] mmc0: Skipping voltage switch
> [    3.302170] mmc0: new high speed SDHC card at address aaaa
> 
> Whereas with the previous version I had:
> [    1.882084] mmc0: new ultra high speed DDR50 SDHC card at address aaaa
> [    1.899142] mmcblk0: mmc0:aaaa SC16G 14.8 GiB
> 
> On STM32MP13 that can do SDR104 (tested on an internal board), it fails 
> to initialized the card:
> [    3.194072] mmc0: error -110 whilst initialising SD card
> 
> When adding some dynamic debug traces, I can see this in the trace:
> [   78.039648] mmc0: Signal voltage switch failed, power cycling card
> 
> I'll try to add more traces to see what happens exactly.
> 
> 
> Best regards,
> Yann


Hi,

The issue occurs in  mmc_set_uhs_voltage(), when calling 
host->ops->card_busy(), which is mmci_card_busy() for this driver.
It is expected here to return busy after the SD_SWITCH_VOLTAGE (CMD11),
but host->busy_state = 0 in mmci_card_busy(), so it return 0.

A possible correction, but that may break what you've done, could be:

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 3ff6655a56d1..006fd84090ac 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -340,13 +340,10 @@ static int mmci_card_busy(struct mmc_host *mmc)
         unsigned long flags;
         int busy = 0;

-       if (host->ops->busy_complete) {
-               if ((host->busy_state == MMCI_BUSY_IDLE) ||
-                   (host->busy_state == MMCI_BUSY_DONE))
-                       return 0;
-               else
-                       return 1;
-       }
+       if (host->ops->busy_complete &&
+           host->busy_state != MMCI_BUSY_IDLE &&
+           host->busy_state != MMCI_BUSY_DONE)
+               return 1;

         spin_lock_irqsave(&host->lock, flags);


The SD-card is now properly detected (and in SDR104 mode) on STM32MP13 
board.


Best regards,
Yann
