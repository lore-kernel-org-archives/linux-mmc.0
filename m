Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73749C4338F
	for <linux-mmc@archiver.kernel.org>; Fri, 20 Aug 2021 11:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B44160231
	for <linux-mmc@archiver.kernel.org>; Fri, 20 Aug 2021 11:06:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240106AbhHTLHO (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 20 Aug 2021 07:07:14 -0400
Received: from mga14.intel.com ([192.55.52.115]:29562 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240410AbhHTLGr (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 20 Aug 2021 07:06:47 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10081"; a="216484032"
X-IronPort-AV: E=Sophos;i="5.84,337,1620716400"; 
   d="scan'208";a="216484032"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2021 04:06:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,337,1620716400"; 
   d="scan'208";a="680060478"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.174]) ([10.237.72.174])
  by fmsmga006.fm.intel.com with ESMTP; 20 Aug 2021 04:06:07 -0700
Subject: Re: [PATCH] mmc: sdhci: correct the tuning command handle for PIO
 mode
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     haibo.chen@nxp.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org
Cc:     linux-imx@nxp.com
References: <1628858041-1911-1-git-send-email-haibo.chen@nxp.com>
 <76af88e2-d068-dafc-9b17-cd590b3f8953@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <c368ffc9-4752-500b-edd9-676d7f73e2ad@intel.com>
Date:   Fri, 20 Aug 2021 14:06:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <76af88e2-d068-dafc-9b17-cd590b3f8953@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 20/08/21 2:04 pm, Adrian Hunter wrote:
> On 13/08/21 3:34 pm, haibo.chen@nxp.com wrote:
>> From: Haibo Chen <haibo.chen@nxp.com>
>>
>> If sdhci use PIO mode, and use mmc_send_tuning() to send the
>> tuning command, system will stuck because of the storm irq
>> of sdhci. For PIO mode, use mmc_send_tuning(), it will trigger
>> buffer_read_ready interrupt and data transfer complete interrupt.
>> In current code logic, it will directly return in sdhci_data_irq,
>> can not call the sdhci_transfer_pio(). So the buffer_read_ready
>> interrupt storm happen. So for standard tuning method, need to
>> excluse this case.
>>
>> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> 
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Although there are unnecessary parenthesis around !host->data

> 
>> ---
>>  drivers/mmc/host/sdhci.c | 10 ++++++++--
>>  1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index aba6e10b8605..acee54b368b0 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -3278,8 +3278,14 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
>>  {
>>  	u32 command;
>>  
>> -	/* CMD19 generates _only_ Buffer Read Ready interrupt */
>> -	if (intmask & SDHCI_INT_DATA_AVAIL) {
>> +	/*
>> +	 * CMD19 generates _only_ Buffer Read Ready interrupt if
>> +	 * use sdhci_send_tuning.
>> +	 * Need to exclude this case: PIO mode and use mmc_send_tuning,
>> +	 * If not, sdhci_transfer_pio will never be called, make the
>> +	 * SDHCI_INT_DATA_AVAIL always there, stuck in irq storm.
>> +	 */
>> +	if ((intmask & SDHCI_INT_DATA_AVAIL) && (!host->data)) {
>>  		command = SDHCI_GET_CMD(sdhci_readw(host, SDHCI_COMMAND));
>>  		if (command == MMC_SEND_TUNING_BLOCK ||
>>  		    command == MMC_SEND_TUNING_BLOCK_HS200) {
>>
> 

