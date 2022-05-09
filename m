Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 838CFC433EF
	for <linux-mmc@archiver.kernel.org>; Mon,  9 May 2022 10:32:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbiEIKgq (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 9 May 2022 06:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232494AbiEIKg2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 9 May 2022 06:36:28 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEBCB11AFD5;
        Mon,  9 May 2022 03:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652092354; x=1683628354;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hIsCP4FjDSnGHwqf621W+ZKgvM6jNyMg0I5DcCDJkig=;
  b=fvYulAZ4WfiGPJR22mxsfMmX/YpxHSyWmWBP4otz4KmzwswKXYUsIPNH
   4JAtALOY4yL1NE+CvxcXFk/7juEY4cS1cH6xKdoGYEqw95Ufn17Qyx9VS
   oTRY5Ytq1+DTwjs6xDRZIfeyjh5tKybXOXhtciLGCSK2TVt4NG5TpIY1y
   s=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 09 May 2022 03:32:32 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 03:32:32 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 9 May 2022 03:32:31 -0700
Received: from [10.216.5.153] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 9 May 2022
 03:32:25 -0700
Message-ID: <ec1cb361-d6b1-828c-98f4-ab2aac55ce80@quicinc.com>
Date:   Mon, 9 May 2022 16:02:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH V5 4/5] mmc: debugfs: Add debug fs error state entry for
 mmc driver
Content-Language: en-US
To:     Adrian Hunter <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <wsa+renesas@sang-engineering.com>,
        <yoshihiro.shimoda.uh@renesas.com>, <linus.walleij@linaro.org>,
        <digetx@gmail.com>, <briannorris@chromium.org>,
        <quic_riteshh@quicinc.com>
CC:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_asutoshd@quicinc.com>, <quic_rampraka@quicinc.com>,
        <quic_pragalla@quicinc.com>, <quic_sartgarg@quicinc.com>,
        <quic_nitirawa@quicinc.com>, <quic_sayalil@quicinc.com>,
        Liangliang Lu <quic_luliang@quicinc.com>,
        "Bao D . Nguyen" <quic_nguyenb@quicinc.com>
References: <1650902443-26357-1-git-send-email-quic_c_sbhanu@quicinc.com>
 <1650902443-26357-5-git-send-email-quic_c_sbhanu@quicinc.com>
 <ce5582e3-0d8d-f1cf-0d23-8fbf17226775@intel.com>
 <5c2a9eae-3ab2-1fa4-c7df-ba7384e07b24@quicinc.com>
 <9261a62d-e496-ba2b-74f4-627e0a5e6abe@intel.com>
From:   "Sajida Bhanu (Temp)" <quic_c_sbhanu@quicinc.com>
In-Reply-To: <9261a62d-e496-ba2b-74f4-627e0a5e6abe@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


On 5/9/2022 3:33 PM, Adrian Hunter wrote:
> On 9/05/22 12:42, Sajida Bhanu (Temp) wrote:
>> Hi,
>>
>> Thank you for the review.
>>
>> Please find the inline comments.
>>
>> Thanks,
>>
>> Sajida
>>
>> On 4/26/2022 1:24 PM, Adrian Hunter wrote:
>>
>>> On 25/04/22 19:00, Shaik Sajida Bhanu wrote:
>>>> Add debug fs entry error state to query eMMC and SD card errors statistics.
>>>> If any errors occurred in eMMC and SD card driver level then
>>>> err_state value will be set to 1.
>>>>
>>>> Signed-off-by: Liangliang Lu <quic_luliang@quicinc.com>
>>>> Signed-off-by: Sayali Lokhande <quic_sayalil@quicinc.com>
>>>> Signed-off-by: Bao D. Nguyen <quic_nguyenb@quicinc.com>
>>>> Signed-off-by: Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
>>>> ---
>>>>   drivers/mmc/core/debugfs.c | 25 +++++++++++++++++++++++++
>>>>   1 file changed, 25 insertions(+)
>>>>
>>>> diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
>>>> index 6aa5a60..2f5b63f 100644
>>>> --- a/drivers/mmc/core/debugfs.c
>>>> +++ b/drivers/mmc/core/debugfs.c
>>>> @@ -222,6 +222,29 @@ static int mmc_clock_opt_set(void *data, u64 val)
>>>>   
>>>>   DEFINE_DEBUGFS_ATTRIBUTE(mmc_clock_fops, mmc_clock_opt_get, mmc_clock_opt_set,
>>>>   	"%llu\n");
>>> A blank line would be nice here
>> Sure
>>>> +static int mmc_err_state_get(void *data, u64 *val)
>>>> +{
>>>> +	struct mmc_host *host = data;
>>>> +
>>>> +	if (!host)
>>>> +		return -EINVAL;
>>>> +
>>> I am not sure why you have left out some err_stats[].
>>> Why not all of them?  At least, it needs a comment to explain.
>> MMC_ERR_ICE_CFG --> we don't have ICE config.
> So err_stats[MMC_ERR_ICE_CFG]  would be zero and make
> no difference.
>
> If you are going to check all then you could loop
> through them
>
> 	*val = 0;
> 	for (i = 0; i < MMC_ERR_MAX; i++) {
> 		if (host->err_stats[i]) {
> 			*val = 1;
> 			break;
> 		}
> 	}
Sure Thanks
>> Remaining we need to update, Thank you for pointing.
>>
>>>> +	*val = host->err_stats[MMC_ERR_REQ_TIMEOUT] ||
>>>> +	       host->err_stats[MMC_ERR_ADMA] ||
>>>> +	       host->err_stats[MMC_ERR_CTRL_TIMEOUT] ||
>>>> +	       host->err_stats[MMC_ERR_UNEXPECTED_IRQ] ||
>>>> +	       host->err_stats[MMC_ERR_CMDQ_RED] ||
>>>> +	       host->err_stats[MMC_ERR_CMDQ_GCE] ||
>>>> +	       host->err_stats[MMC_ERR_CMDQ_ICCE] ||
>>>> +	       host->err_stats[MMC_ERR_DAT_TIMEOUT] ||
>>>> +	       host->err_stats[MMC_ERR_DAT_CRC] ||
>>>> +	       host->err_stats[MMC_ERR_CMD_CRC] ||
>>>> +	       host->err_stats[MMC_ERR_CMD_TIMEOUT];
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +DEFINE_SIMPLE_ATTRIBUTE(mmc_err_state, mmc_err_state_get, NULL, "%llu\n");
>>>>   
>>>>   static int mmc_err_stats_show(struct seq_file *file, void *data)
>>>>   {
>>>> @@ -289,6 +312,8 @@ void mmc_add_host_debugfs(struct mmc_host *host)
>>>>   	debugfs_create_file_unsafe("clock", S_IRUSR | S_IWUSR, root, host,
>>>>   				   &mmc_clock_fops);
>>>>   
>>>> +	debugfs_create_file("err_state", 0600, root, host,
>>>> +			    &mmc_err_state);
>>>>   	debugfs_create_file("err_stats", 0600, root, host,
>>>>   			    &mmc_err_stats_fops);
>>>>   
