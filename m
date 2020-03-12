Return-Path: <SRS0=Im6a=45=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B06C2BB1D
	for <linux-mmc@archiver.kernel.org>; Thu, 12 Mar 2020 15:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5133420674
	for <linux-mmc@archiver.kernel.org>; Thu, 12 Mar 2020 15:28:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ADovG4BR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbgCLP2g (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 12 Mar 2020 11:28:36 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:7878 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727455AbgCLP2g (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 12 Mar 2020 11:28:36 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e6a54c70002>; Thu, 12 Mar 2020 08:27:03 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 12 Mar 2020 08:28:35 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 12 Mar 2020 08:28:35 -0700
Received: from [10.2.172.79] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 12 Mar
 2020 15:28:35 +0000
Subject: Re: [PATCH v2 1/2] sdhci: tegra: Implement Tegra specific set_timeout
 callback
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Adrian Hunter <adrian.hunter@intel.com>,
        Bradley Bolen <bradleybolen@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        "Jon Hunter" <jonathanh@nvidia.com>,
        Aniruddha Tvs Rao <anrao@nvidia.com>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
References: <1583886030-11339-1-git-send-email-skomatineni@nvidia.com>
 <CAPDyKFpAgk0uboGXdmA_m1-2=GK2oRXVv+97ZFFFAtT-ZZo4fw@mail.gmail.com>
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
Message-ID: <7bf5bfb5-b07c-96d3-2c33-124085a36a65@nvidia.com>
Date:   Thu, 12 Mar 2020 08:28:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFpAgk0uboGXdmA_m1-2=GK2oRXVv+97ZFFFAtT-ZZo4fw@mail.gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1584026823; bh=20CmxRXQV14NK/AWzN5cjVv0G+jcfKKJHsLGW1THEX0=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=ADovG4BRKRpq/sgIlNDARFZ4ko1wfbqEB9VeDNZfevPxfK2VbKtn29YaHthii6+Un
         XjYDb9qBqjmsO2Fa9DrOQYUn8NmKv1QqYZ/xREDcSA8Y1vUem9PwNTJosMSX7082CL
         KryHBytg59ESxmiBhIY9XVI8V7MwiAu8eLFFD2Sov3efJEdp+Ji93cyS63BFnwm4P/
         7BPumYrK6nha3M/Gk6HmAj4hckZzXRuSywOFvVRIeFWhva0UZLXPQ+1nSUSQvrV53p
         ehmkoyigZ99w7cgnS8f1/Y9/ZD8TKa0du2G1QhJ8ZdmAQ95bz85JTxIT2xH+BoaZqg
         rWTMAc57K3zXQ==
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


On 3/12/20 6:08 AM, Ulf Hansson wrote:
> External email: Use caution opening links or attachments
>
>
> -trimmed cc list
>
> On Thu, 12 Mar 2020 at 00:51, Sowjanya Komatineni
> <skomatineni@nvidia.com> wrote:
>> Tegra host supports HW busy detection and timeouts based on the
>> count programmed in SDHCI_TIMEOUT_CONTROL register and max busy
>> timeout it supports is 11s in finite busy wait mode.
>>
>> Some operations like SLEEP_AWAKE, ERASE and flush cache through
>> SWITCH commands take longer than 11s and Tegra host supports
>> infinite HW busy wait mode where HW waits forever till the card
>> is busy without HW timeout.
>>
>> This patch implements Tegra specific set_timeout sdhci_ops to allow
>> switching between finite and infinite HW busy detection wait modes
>> based on the device command expected operation time.
>>
>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> Applied for next, thanks!
>
> We should probably tag this for stable as well, don't you think?
>
> Kind regards
> Uffe

Yes, we need this for stable as well. As this is applied for next, looks 
like can't re-send patch with tag.

Can you please help to add tag if you don't mind?

>
>
>> ---
>>   drivers/mmc/host/sdhci-tegra.c | 31 +++++++++++++++++++++++++++++++
>>   1 file changed, 31 insertions(+)
>>
>> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
>> index a25c3a4..fa8f6a4 100644
>> --- a/drivers/mmc/host/sdhci-tegra.c
>> +++ b/drivers/mmc/host/sdhci-tegra.c
>> @@ -45,6 +45,7 @@
>>   #define SDHCI_TEGRA_CAP_OVERRIDES_DQS_TRIM_SHIFT       8
>>
>>   #define SDHCI_TEGRA_VENDOR_MISC_CTRL                   0x120
>> +#define SDHCI_MISC_CTRL_ERASE_TIMEOUT_LIMIT            BIT(0)
>>   #define SDHCI_MISC_CTRL_ENABLE_SDR104                  0x8
>>   #define SDHCI_MISC_CTRL_ENABLE_SDR50                   0x10
>>   #define SDHCI_MISC_CTRL_ENABLE_SDHCI_SPEC_300          0x20
>> @@ -1227,6 +1228,34 @@ static u32 sdhci_tegra_cqhci_irq(struct sdhci_host *host, u32 intmask)
>>          return 0;
>>   }
>>
>> +static void tegra_sdhci_set_timeout(struct sdhci_host *host,
>> +                                   struct mmc_command *cmd)
>> +{
>> +       u32 val;
>> +
>> +       /*
>> +        * HW busy detection timeout is based on programmed data timeout
>> +        * counter and maximum supported timeout is 11s which may not be
>> +        * enough for long operations like cache flush, sleep awake, erase.
>> +        *
>> +        * ERASE_TIMEOUT_LIMIT bit of VENDOR_MISC_CTRL register allows
>> +        * host controller to wait for busy state until the card is busy
>> +        * without HW timeout.
>> +        *
>> +        * So, use infinite busy wait mode for operations that may take
>> +        * more than maximum HW busy timeout of 11s otherwise use finite
>> +        * busy wait mode.
>> +        */
>> +       val = sdhci_readl(host, SDHCI_TEGRA_VENDOR_MISC_CTRL);
>> +       if (cmd && cmd->busy_timeout >= 11 * HZ)
>> +               val |= SDHCI_MISC_CTRL_ERASE_TIMEOUT_LIMIT;
>> +       else
>> +               val &= ~SDHCI_MISC_CTRL_ERASE_TIMEOUT_LIMIT;
>> +       sdhci_writel(host, val, SDHCI_TEGRA_VENDOR_MISC_CTRL);
>> +
>> +       __sdhci_set_timeout(host, cmd);
>> +}
>> +
>>   static const struct cqhci_host_ops sdhci_tegra_cqhci_ops = {
>>          .write_l    = tegra_cqhci_writel,
>>          .enable = sdhci_tegra_cqe_enable,
>> @@ -1366,6 +1395,7 @@ static const struct sdhci_ops tegra210_sdhci_ops = {
>>          .set_uhs_signaling = tegra_sdhci_set_uhs_signaling,
>>          .voltage_switch = tegra_sdhci_voltage_switch,
>>          .get_max_clock = tegra_sdhci_get_max_clock,
>> +       .set_timeout = tegra_sdhci_set_timeout,
>>   };
>>
>>   static const struct sdhci_pltfm_data sdhci_tegra210_pdata = {
>> @@ -1403,6 +1433,7 @@ static const struct sdhci_ops tegra186_sdhci_ops = {
>>          .voltage_switch = tegra_sdhci_voltage_switch,
>>          .get_max_clock = tegra_sdhci_get_max_clock,
>>          .irq = sdhci_tegra_cqhci_irq,
>> +       .set_timeout = tegra_sdhci_set_timeout,
>>   };
>>
>>   static const struct sdhci_pltfm_data sdhci_tegra186_pdata = {
>> --
>> 2.7.4
>>
