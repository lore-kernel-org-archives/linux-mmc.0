Return-Path: <SRS0=oXoI=6N=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E8EC83004
	for <linux-mmc@archiver.kernel.org>; Wed, 29 Apr 2020 14:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6402B208FE
	for <linux-mmc@archiver.kernel.org>; Wed, 29 Apr 2020 14:09:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="O50usi51"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbgD2OJY (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 29 Apr 2020 10:09:24 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:62764 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727042AbgD2OJY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 29 Apr 2020 10:09:24 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588169362; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=oqkl5dyEFXLh5o1+jemKoDEKA7Qj+7kD+96nQn1zpQE=; b=O50usi51rkWy5/AH407Mzvo1MIZAITYMQXWJKQ5g9ERBklkB3FwuyrvJG6lkUc2Kp9sSn3aZ
 IeVRXSf9DSV2JlFIG12K0vLfCujktsV0ruu6ungXQiBrHIreLu53Z2WbOz22B8UKdfNqgE6N
 Yfm85mSfoASBZz2zEuqXT1bGSiQ=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyJiYTcxMiIsICJsaW51eC1tbWNAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ea98a86.7f33de13e458-smtp-out-n02;
 Wed, 29 Apr 2020 14:09:10 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id CD247C433F2; Wed, 29 Apr 2020 14:09:09 +0000 (UTC)
Received: from [10.131.182.194] (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E9BACC433CB;
        Wed, 29 Apr 2020 14:09:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E9BACC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH v3 09/17] mmc: sdhci-msm: Fix error handling for
 dev_pm_opp_of_add_table()
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Pradeep P V K <ppvk@codeaurora.org>,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
References: <1588080785-6812-1-git-send-email-rnayak@codeaurora.org>
 <1588080785-6812-10-git-send-email-rnayak@codeaurora.org>
 <CAPDyKFrGQvcCB1wfv=iqk66uja3faMRF1gGMSE2VhB8gJcO=sg@mail.gmail.com>
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <15efa375-cf1e-b793-1d3e-29ca0a547522@codeaurora.org>
Date:   Wed, 29 Apr 2020 19:39:03 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFrGQvcCB1wfv=iqk66uja3faMRF1gGMSE2VhB8gJcO=sg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


On 4/28/2020 11:59 PM, Ulf Hansson wrote:
> On Tue, 28 Apr 2020 at 15:39, Rajendra Nayak <rnayak@codeaurora.org> wrote:
>>
>> Even though specifying OPP's in device tree is optional, ignoring all errors
>> reported by dev_pm_opp_of_add_table() means we can't distinguish between a
>> missing OPP table and a wrong/buggy OPP table. While missing OPP table
>> (dev_pm_opp_of_add_table() returns a -ENODEV in such case) can be ignored,
>> a wrong/buggy OPP table in device tree should make the driver error out.
>>
>> while we fix that, lets also fix the variable names for opp/opp_table to
>> avoid confusion and name them opp_table/has_opp_table instead.
>>
>> Suggested-by: Matthias Kaehlcke <matthias@chromium.org>
>> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
>> Cc: Ulf Hansson <ulf.hansson@linaro.org>
>> Cc: Pradeep P V K <ppvk@codeaurora.org>
>> Cc: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
>> Cc: linux-mmc@vger.kernel.org
> 
> Is this a standalone patch that I queue up via my mmc tree?

Hi Ulf, yes, its a standalone patch which applies on top of the one
you already have in your tree. No other dependencies.

> 
> Kind regards
> Uffe
> 
>> ---
>>   drivers/mmc/host/sdhci-msm.c | 27 ++++++++++++++++-----------
>>   1 file changed, 16 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
>> index 8a055dd..97758fa 100644
>> --- a/drivers/mmc/host/sdhci-msm.c
>> +++ b/drivers/mmc/host/sdhci-msm.c
>> @@ -244,8 +244,8 @@ struct sdhci_msm_host {
>>          struct clk_bulk_data bulk_clks[4]; /* core, iface, cal, sleep clocks */
>>          unsigned long clk_rate;
>>          struct mmc_host *mmc;
>> -       struct opp_table *opp;
>> -       bool opp_table;
>> +       struct opp_table *opp_table;
>> +       bool has_opp_table;
>>          bool use_14lpp_dll_reset;
>>          bool tuning_done;
>>          bool calibration_done;
>> @@ -1967,15 +1967,20 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>>          }
>>          msm_host->bulk_clks[0].clk = clk;
>>
>> -       msm_host->opp = dev_pm_opp_set_clkname(&pdev->dev, "core");
>> -       if (IS_ERR(msm_host->opp)) {
>> -               ret = PTR_ERR(msm_host->opp);
>> +       msm_host->opp_table = dev_pm_opp_set_clkname(&pdev->dev, "core");
>> +       if (IS_ERR(msm_host->opp_table)) {
>> +               ret = PTR_ERR(msm_host->opp_table);
>>                  goto bus_clk_disable;
>>          }
>>
>>          /* OPP table is optional */
>> -       if (!dev_pm_opp_of_add_table(&pdev->dev))
>> -               msm_host->opp_table = true;
>> +       ret = dev_pm_opp_of_add_table(&pdev->dev);
>> +       if (!ret) {
>> +               msm_host->has_opp_table = true;
>> +       } else if (ret != -ENODEV) {
>> +               dev_err(&pdev->dev, "Invalid OPP table in Device tree\n");
>> +               goto opp_cleanup;
>> +       }
>>
>>          /* Vote for maximum clock rate for maximum performance */
>>          ret = dev_pm_opp_set_rate(&pdev->dev, INT_MAX);
>> @@ -2133,9 +2138,9 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>>          clk_bulk_disable_unprepare(ARRAY_SIZE(msm_host->bulk_clks),
>>                                     msm_host->bulk_clks);
>>   opp_cleanup:
>> -       if (msm_host->opp_table)
>> +       if (msm_host->has_opp_table)
>>                  dev_pm_opp_of_remove_table(&pdev->dev);
>> -       dev_pm_opp_put_clkname(msm_host->opp);
>> +       dev_pm_opp_put_clkname(msm_host->opp_table);
>>   bus_clk_disable:
>>          if (!IS_ERR(msm_host->bus_clk))
>>                  clk_disable_unprepare(msm_host->bus_clk);
>> @@ -2154,9 +2159,9 @@ static int sdhci_msm_remove(struct platform_device *pdev)
>>
>>          sdhci_remove_host(host, dead);
>>
>> -       if (msm_host->opp_table)
>> +       if (msm_host->has_opp_table)
>>                  dev_pm_opp_of_remove_table(&pdev->dev);
>> -       dev_pm_opp_put_clkname(msm_host->opp);
>> +       dev_pm_opp_put_clkname(msm_host->opp_table);
>>          pm_runtime_get_sync(&pdev->dev);
>>          pm_runtime_disable(&pdev->dev);
>>          pm_runtime_put_noidle(&pdev->dev);
>> --
>> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
>> of Code Aurora Forum, hosted by The Linux Foundation

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
