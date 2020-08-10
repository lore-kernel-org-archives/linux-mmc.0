Return-Path: <SRS0=LKB8=BU=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD97CC433DF
	for <linux-mmc@archiver.kernel.org>; Mon, 10 Aug 2020 11:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6E2E206E9
	for <linux-mmc@archiver.kernel.org>; Mon, 10 Aug 2020 11:26:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbgHJL0N (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 10 Aug 2020 07:26:13 -0400
Received: from mga03.intel.com ([134.134.136.65]:38598 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726398AbgHJL0L (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 10 Aug 2020 07:26:11 -0400
IronPort-SDR: EPptgsOLsYiTkojSj1IXyEMbQUD9QD0ZojNA3FjbEIPnvzkL7Gfd7HMYnXvDJqMWtHv4o7ob9P
 2xJWX6+QIPFQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9708"; a="153479836"
X-IronPort-AV: E=Sophos;i="5.75,457,1589266800"; 
   d="scan'208";a="153479836"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2020 04:26:09 -0700
IronPort-SDR: BtZ7UfB88jiyKyPbbrXmQMAp8RgGyXnwwp++9ClmKCah7JnU0SAkXTcEY/uy9Ioh7oNbwDiJ3f
 4TWSs3FHfrBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,457,1589266800"; 
   d="scan'208";a="290319794"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.73]) ([10.237.72.73])
  by orsmga003.jf.intel.com with ESMTP; 10 Aug 2020 04:26:06 -0700
Subject: Re: [PATCH] mmc: host: sdhci-esdhc-imx: reset usdhc before sending
 tuning command for manual tuning method
To:     Bough Chen <haibo.chen@nxp.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc:     dl-linux-imx <linux-imx@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>
References: <1596714504-16313-1-git-send-email-haibo.chen@nxp.com>
 <d3e56b01-144b-17cf-d414-9e0d558b9bcc@intel.com>
 <VI1PR04MB52945822087D81437FA6CCC590490@VI1PR04MB5294.eurprd04.prod.outlook.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <35ec3920-2ddc-2880-49f8-8d0914c331b5@intel.com>
Date:   Mon, 10 Aug 2020 14:25:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <VI1PR04MB52945822087D81437FA6CCC590490@VI1PR04MB5294.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 7/08/20 4:50 am, Bough Chen wrote:
> 
>> -----Original Message-----
>> From: Adrian Hunter [mailto:adrian.hunter@intel.com]
>> Sent: 2020年8月6日 20:11
>> To: Bough Chen <haibo.chen@nxp.com>; ulf.hansson@linaro.org;
>> linux-mmc@vger.kernel.org
>> Cc: dl-linux-imx <linux-imx@nxp.com>; shawnguo@kernel.org;
>> s.hauer@pengutronix.de; kernel@pengutronix.de; festevam@gmail.com
>> Subject: Re: [PATCH] mmc: host: sdhci-esdhc-imx: reset usdhc before sending
>> tuning command for manual tuning method
>>
>> On 6/08/20 2:48 pm, haibo.chen@nxp.com wrote:
>>> From: Haibo Chen <haibo.chen@nxp.com>
>>>
>>> According to IC suggestion, everytime before sending the tuning
>>> command, need to reset the usdhc, so to reset the tuning circuit, to
>>> let every tuning command work well for the manual tuning method. For
>>> standard tuning method, IC already add the reset operation in the logic.
>>>
>>> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
>>> ---
>>>  drivers/mmc/host/sdhci-esdhc-imx.c | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c
>>> b/drivers/mmc/host/sdhci-esdhc-imx.c
>>> index a76b4513fbec..e4694eb1b914 100644
>>> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
>>> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
>>> @@ -990,6 +990,7 @@ static void esdhc_prepare_tuning(struct sdhci_host
>>> *host, u32 val)
>>>
>>>  	/* FIXME: delay a bit for card to be ready for next tuning due to errors */
>>>  	mdelay(1);
>>> +	sdhci_reset(host, SDHCI_RESET_ALL);
>>
>> Doesn't that reset all registers i.e. the entire ios state?
>>
> 
> Hi Adrian,
> For i.MX usdhc, RESET_ALL operation do not impact any register value, it just reset the internal logic setting. I already verified that.
> Here I just want to set the SDHCI_RESET_ALL bit, but I notice that the API sdhci_reset() will also touch the host->clock, so I'm not sure whether it is good enough to use this API directly. Any suggestion? At least, current patch can fix the manual tuning issue on imx7d/imx8qxp.

It might be safer to write SDHCI_RESET_ALL directly because, for your case,
it does not have exactly the same semantics as sdhci_reset().

It is up to you, but either way, it would be worth adding a comment.

> 
>>>
>>>  	reg = readl(host->ioaddr + ESDHC_MIX_CTRL);
>>>  	reg |= ESDHC_MIX_CTRL_EXE_TUNE | ESDHC_MIX_CTRL_SMPCLK_SEL |
>>>
> 

