Return-Path: <SRS0=ypud=CJ=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D523C433E2
	for <linux-mmc@archiver.kernel.org>; Mon, 31 Aug 2020 15:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4051A207EA
	for <linux-mmc@archiver.kernel.org>; Mon, 31 Aug 2020 15:09:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbgHaPI5 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 31 Aug 2020 11:08:57 -0400
Received: from mga04.intel.com ([192.55.52.120]:31340 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728148AbgHaPI4 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 31 Aug 2020 11:08:56 -0400
IronPort-SDR: PRx6sGSWTPBDkMdNq1Bu7dU6Ng2UE1P5G5czGu1x/t5U9dS6qgd6tSTJBs1Xnq1jI3ML1qXvwb
 g9yuWA/yt+mQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9730"; a="154395463"
X-IronPort-AV: E=Sophos;i="5.76,376,1592895600"; 
   d="scan'208";a="154395463"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2020 08:08:55 -0700
IronPort-SDR: FpZMj+8szrHvtzbhfmvek8LRdW5wMgZEh8InhUSTO3IOotFu7l7r9F9F27k5o8mkpPafnUBsVv
 lLKy3V4lYrCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,376,1592895600"; 
   d="scan'208";a="281671788"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.73]) ([10.237.72.73])
  by fmsmga007.fm.intel.com with ESMTP; 31 Aug 2020 08:08:47 -0700
Subject: Re: Broadcom WiFi SDIO performance regression after commit "mmc:
 sdhci: Remove finish_tasklet"
To:     Dmitry Osipenko <digetx@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        brcm80211-dev-list@cypress.com,
        brcm80211-dev-list.pdl@broadcom.com,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <5cf1af89-6026-09ad-7f20-82e19ad49fa1@gmail.com>
 <9332715c-6ee5-fce3-8b93-305823d5a551@intel.com>
 <eec0c7d2-87f3-1213-dec1-bb34c5bde35a@gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <379c7435-a940-c427-305d-c4fa5f1970d6@intel.com>
Date:   Mon, 31 Aug 2020 18:08:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <eec0c7d2-87f3-1213-dec1-bb34c5bde35a@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 27/08/20 12:36 pm, Dmitry Osipenko wrote:
> 27.08.2020 09:45, Adrian Hunter пишет:
>> On 27/08/20 9:07 am, Dmitry Osipenko wrote:
>>> Hello!
>>>
>>> I was debugging WiFi performance problems on Acer A500 tablet device
>>> that has BCM4329 WiFi chip which is connected to NVIDIA Terga20 SoC via
>>> SDIO and found that the following commit causes a solid 5-10 Mbit/s of
>>> WiFi throughput regression after 5.2 kernel:
>>
>> What is that in percentage terms?
> 
> That is about 20%.
> 
>>> commit c07a48c2651965e84d35cf193dfc0e5f7892d612
>>> Author: Adrian Hunter <adrian.hunter@intel.com>
>>> Date:   Fri Apr 5 15:40:20 2019 +0300
>>>
>>>     mmc: sdhci: Remove finish_tasklet
>>>
>>>     Remove finish_tasklet. Requests that require DMA-unmapping or
>>> sdhci_reset
>>>     are completed either in the IRQ thread or a workqueue if the
>>> completion is
>>>     not initiated by the IRQ.
>>>
>>> Reverting the offending commit on top of recent linux-next resolves the
>>> problem.
>>>
>>> Ulf / Adrian, do you have any ideas what could be done in regards to
>>> restoring the SDIO performance? Should we just revert the offending commit?
>>>
>>
>> Unfortunately I think we are past the point of returning to the tasklet.
>>
>> sdhci can complete requests in the irq handler but only if ->pre_req() and
>> ->post_req() are used, which is not supported by SDIO at present.  pre_req
>> and post_req were introduced to reduce latency for the block driver, so it
>> seems reasonable perhaps to look at using them in SDIO as well.
>>
> 
> I'll try to take a look at pre/post_req(), but I'm not very familiar
> with the MMC code, so it may take quite some time. Will be great if you
> could help with making a patch that I could test!
> 

You could start by seeing if using pre/post_req helps at all, as below.
If that doesn't help, then it might need more analysis.


diff --git a/drivers/mmc/core/sdio_ops.c b/drivers/mmc/core/sdio_ops.c
index 93d346c01110..4c229dd2b6e5 100644
--- a/drivers/mmc/core/sdio_ops.c
+++ b/drivers/mmc/core/sdio_ops.c
@@ -121,6 +121,7 @@ int mmc_io_rw_extended(struct mmc_card *card, int write, unsigned fn,
 	struct sg_table sgtable;
 	unsigned int nents, left_size, i;
 	unsigned int seg_size = card->host->max_seg_size;
+	int err;
 
 	WARN_ON(blksz == 0);
 
@@ -170,28 +171,32 @@ int mmc_io_rw_extended(struct mmc_card *card, int write, unsigned fn,
 
 	mmc_set_data_timeout(&data, card);
 
-	mmc_wait_for_req(card->host, &mrq);
+	mmc_pre_req(card->host, &mrq);
 
-	if (nents > 1)
-		sg_free_table(&sgtable);
+	mmc_wait_for_req(card->host, &mrq);
 
 	if (cmd.error)
-		return cmd.error;
-	if (data.error)
-		return data.error;
-
-	if (mmc_host_is_spi(card->host)) {
+		err = cmd.error;
+	else if (data.error)
+		err = data.error;
+	else if (mmc_host_is_spi(card->host))
 		/* host driver already reported errors */
-	} else {
-		if (cmd.resp[0] & R5_ERROR)
-			return -EIO;
-		if (cmd.resp[0] & R5_FUNCTION_NUMBER)
-			return -EINVAL;
-		if (cmd.resp[0] & R5_OUT_OF_RANGE)
-			return -ERANGE;
-	}
+		err = 0;
+	else if (cmd.resp[0] & R5_ERROR)
+		err = -EIO;
+	else if (cmd.resp[0] & R5_FUNCTION_NUMBER)
+		err = -EINVAL;
+	else if (cmd.resp[0] & R5_OUT_OF_RANGE)
+		err = -ERANGE;
+	else
+		err = 0;
 
-	return 0;
+	mmc_post_req(card->host, &mrq, err);
+
+	if (nents > 1)
+		sg_free_table(&sgtable);
+
+	return err;
 }
 
 int sdio_reset(struct mmc_host *host)


