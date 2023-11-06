Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F65CC4167D
	for <linux-mmc@archiver.kernel.org>; Mon,  6 Nov 2023 06:35:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbjKFGfe (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 6 Nov 2023 01:35:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbjKFGfd (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Nov 2023 01:35:33 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C1CE1;
        Sun,  5 Nov 2023 22:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699252531; x=1730788531;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rkeD9beioJ3ZQPx/PpMCCYUgdpP+5HTzczEs3MjCoL0=;
  b=N+fJEjNGomtHDq0ioDX+5rik1lxdJXOwtQR2Kl8WC40ZfNap2Sqnhbwa
   /PY/NKnM+dEyvyJMqRQhfEceac+3D8xhPGShwj8dEBczdEnHEdnAso6Q1
   Uinq+0y21mkOjbBjvvXyJjL9C+goBzTGr7uVch8v6uwJa84Uy/0O9kcLt
   6CdgJAMC1Q0IXCd2SBXam5nRHthIAffEAWPoWxp6urt0KKRop4TGoFyx0
   7X312ppxC39l4Mtw4+wHNtlxWDdKgTMuPN80n5sB5LmiN7UsNnIPd8dSI
   AjcB0IXhEFwNGPuyiAfnqhuYZl4y7yUMWQEH1kQFKxHzAdYbkC1ccaDJf
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="388098764"
X-IronPort-AV: E=Sophos;i="6.03,280,1694761200"; 
   d="scan'208";a="388098764"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2023 22:35:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="765857678"
X-IronPort-AV: E=Sophos;i="6.03,280,1694761200"; 
   d="scan'208";a="765857678"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.215.231])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2023 22:35:26 -0800
Message-ID: <8bc2daa3-55ad-44ea-9205-40fb09852561@intel.com>
Date:   Mon, 6 Nov 2023 08:35:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 3/6] mmc: block: Be sure to wait while busy in CQE
 error recovery
To:     Avri Altman <Avri.Altman@wdc.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        =?UTF-8?Q?Kornel_Dul=C4=99ba?= <korneld@chromium.org>,
        Radoslaw Biernacki <biernacki@google.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Asutosh Das <quic_asutoshd@quicinc.com>
Cc:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Bhavya Kapoor <b-kapoor@ti.com>,
        Kamal Dasu <kamal.dasu@broadcom.com>,
        Al Cooper <alcooperx@gmail.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>,
        Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>,
        Victor Shih <victor.shih@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Thierry Reding <thierry.reding@gmail.com>,
        Aniruddha Tvs Rao <anrao@nvidia.com>,
        Chun-Hung Wu <chun-hung.wu@mediatek.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20231103084720.6886-1-adrian.hunter@intel.com>
 <20231103084720.6886-4-adrian.hunter@intel.com>
 <DM6PR04MB65753B3B797430DF05959210FCA5A@DM6PR04MB6575.namprd04.prod.outlook.com>
Content-Language: en-US
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <DM6PR04MB65753B3B797430DF05959210FCA5A@DM6PR04MB6575.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 3/11/23 12:48, Avri Altman wrote:
>> STOP command does not guarantee to wait while busy, but subsequent
>> command MMC_CMDQ_TASK_MGMT to discard the queue will fail if the
>> card is busy, so be sure to wait by employing mmc_poll_for_busy().
> Doesn't the Task Discard Sequence expects you to check CQDPT[i]==1
> before sending MMC_CMDQ_TASK_MGMT to discard task id i?

We do not clear individual tasks.  Instead the MMC_CMDQ_TASK_MGMT is
sent with the op-code to "discard entire queue", which will also
work even if the queue is empty. Refer JESD84-B51A,
6.6.39.6 CMDQ_TASK_MGMT and Table 43 — Task Management op-codes.

> 
> Thanks,
> Avri
> 
>>
>> Fixes: 72a5af554df8 ("mmc: core: Add support for handling CQE requests")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>> ---
>>  drivers/mmc/core/core.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c index
>> 3d3e0ca52614..befde2bd26d3 100644
>> --- a/drivers/mmc/core/core.c
>> +++ b/drivers/mmc/core/core.c
>> @@ -553,6 +553,8 @@ int mmc_cqe_recovery(struct mmc_host *host)
>>         cmd.busy_timeout = MMC_CQE_RECOVERY_TIMEOUT;
>>         mmc_wait_for_cmd(host, &cmd, 0);
>>
>> +       mmc_poll_for_busy(host->card, MMC_CQE_RECOVERY_TIMEOUT,
>> true,
>> + MMC_BUSY_IO);
>> +
>>         memset(&cmd, 0, sizeof(cmd));
>>         cmd.opcode       = MMC_CMDQ_TASK_MGMT;
>>         cmd.arg          = 1; /* Discard entire queue */
>> --
>> 2.34.1
> 

