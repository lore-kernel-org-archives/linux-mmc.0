Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29428C4167B
	for <linux-mmc@archiver.kernel.org>; Mon,  2 Jan 2023 08:25:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbjABIYt (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 2 Jan 2023 03:24:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231559AbjABIYT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 2 Jan 2023 03:24:19 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C73BD4
        for <linux-mmc@vger.kernel.org>; Mon,  2 Jan 2023 00:24:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RtLsY2I/IgSl1uRpi0H4I2u9wSWihnLJqcViMGd9nDJAYkmA30frg61OCIk06dowMXWpl7KL+fNCXdX+xLrhDhxiZG/6pM9k6yTpGAqpNo7YjmvFtyDq3jsiIGV2A5fGntETo9SJx8biXct35TsPmRAlMtiTTvj/yRuB1JQ2CvWMG36lp3OOa9pE+xNQZPjZtB7psg/7ONH6Kt7nKOcOWkUs4s4CBFBWW3n75aJ0lowoRQVmvR3n0zDy5iQoty+jAnSCRKnf9LznyauOPpgO4B/2WEEcFudHgj0lGEbY+GBrUpIeA1jNBW3wuxLLHh0SL9o/ywxLxamS9QiBU6O+ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EtsB0InTVlTOrR3Tvr+AjXKmrZgDWhysO9exc9vt77Y=;
 b=fhKO0vprMtdVgB/jiUvXICadAIo4btHObpV2lZV+Uzi+6SFtZ900GG7MU53p3YlNd55SwCkaFv46/eXV2je043tZWobAii2S30i1GPQXcii2JtIcQKos6BMW9At+oLKyyieBiL3FDQV4T4lJ/msoePhBs21M5T+l9k5JARcpoEljTtGGO2QK+jmMXuwa1CiitdB5MiRY0LySjvzm3Dn7hqDfhfM94I3uid5FgUvmx9C52djjBJ/QOygSm09P/3BW/pVihomKl69RnXtXg4FwBJn2Q/jpNkV9zhpGxpFvg6qJAXMlDKpNoUCgjjgfOp72QUO7T9/VYg+/05VJ+LFw/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EtsB0InTVlTOrR3Tvr+AjXKmrZgDWhysO9exc9vt77Y=;
 b=wLxpke1wRYnZp+CwERxCrsAxdk6wrWPoHkV73/UVuXrdFJbdHCmusSTLhLaMytFPksmlsCOVLfqtTgUHOl3ZeHtisld/UZq20BnanmEI4tcUwYY3VJG79dtAouVc42oZYj2RLYEUVUGIh2KefTRiCUZv98QtVgcUmK3tG++M8RI=
Received: from MW2PR16CA0068.namprd16.prod.outlook.com (2603:10b6:907:1::45)
 by SA1PR12MB7367.namprd12.prod.outlook.com (2603:10b6:806:2b5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Mon, 2 Jan
 2023 08:24:14 +0000
Received: from CO1NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::48) by MW2PR16CA0068.outlook.office365.com
 (2603:10b6:907:1::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5966.19 via Frontend
 Transport; Mon, 2 Jan 2023 08:24:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT004.mail.protection.outlook.com (10.13.175.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5966.18 via Frontend Transport; Mon, 2 Jan 2023 08:24:13 +0000
Received: from [10.254.241.50] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 2 Jan
 2023 02:24:10 -0600
Message-ID: <2db4c424-74fa-24a6-852d-10d7a18a0541@amd.com>
Date:   Mon, 2 Jan 2023 09:24:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] mmc: sdhci-of-arasan: Override
 SDHCI_RETUNING_TIMER_COUNT_MASK on ZynqMP
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Marek Vasut <marex@denx.de>, <linux-mmc@vger.kernel.org>
CC:     Michal Simek <michal.simek@xilinx.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20221025191500.149167-1-marex@denx.de>
 <2b523371-7eeb-25f2-8879-76bbf028f4bb@intel.com>
 <c3d62448-fd1c-066c-aa53-2df7eae1555d@denx.de>
 <ebf570a1-3d2f-85d7-3a29-540caf9f576d@intel.com>
 <8958eb65-e873-a760-5ca4-a51b36f5e23d@denx.de>
 <873d21fa-d9ff-ee94-40a1-3354850c8865@intel.com>
Content-Language: en-US
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <873d21fa-d9ff-ee94-40a1-3354850c8865@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT004:EE_|SA1PR12MB7367:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e676fe3-a07f-415f-7581-08daec9abb5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t1jistt2Dao6EMJsDtWLtR8H2uPfb1C6buisGMruSZ/Zporsue3B0lXBh2gTw/+haAQJjEYZna/Z65NO5hXgBcw8NS1fIAFgAWHFtPc+mO8HDJLW0QNaRsXsqciM1rd9PrWMdy5XuXB8JvDIDWNWvp8cwTql0DJTXl56pF9PI3sG5/x6h69PCSiZMj0sagJMNOq/9nE/WPTFhxWBA/fp4x6+7Ks+bdv9QffI9MSoMUJUM/w+9m+A+HNt66XYSnq/811vtPK+IBbeb2fRSxXQY3M1Wr3eKPi0IujrDzqp9b9dhaqB2yIaX7v0PBwwMNJiRa6SrYCqMFbG2T38JtMON9harC9enVMm8zdE6oMsh/e6jpr0qS3r5tocGvzu7Se88HOI95ce7EEVRsyVdyvbJu6NUyZJKGxLanUsamfs/00Ql4EdtqwoSi/9ujkWCeOGRjQ+1mjzuKMGJCgZY4UTZQNMrSlUnxz+Jcbv8R1fk9Swio6aGYk0/1A7py9VnGmn7F25l4C6eSttFl5/J72B+5naFXswt+QUaVCK7T+mn8ATQIcrF+ZXVKLR1FuUUL/1GfHUtIh3NHkR9ieAVkBkKQ/tmwaPGO5UGQBO6AISCTbgsvM8Hnt1odMWZgGOOUqt55nH60RoScYFKRQkHHQiEIrBj93JZNomqQl4IAXwo7MNCNAzxbCl3IbzD3ztloPf8dzFEI8ZDVrRwQKBZoSjP2I01izmOfd+596YZuPbaGe1LWjcXHEAAQ+hJLNwVj3uIHyI0sowi7e1cI1z4z+2hxBdYP553VNB4MlxdYixQ14F98FJK98hRM192vOtRyqv
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(396003)(136003)(39860400002)(451199015)(36840700001)(46966006)(40470700004)(186003)(26005)(83380400001)(16526019)(336012)(426003)(47076005)(44832011)(2616005)(31696002)(86362001)(40480700001)(40460700003)(82310400005)(36860700001)(356005)(36756003)(81166007)(82740400003)(31686004)(110136005)(316002)(16576012)(66899015)(2906002)(54906003)(4326008)(41300700001)(8936002)(5660300002)(8676002)(70586007)(70206006)(478600001)(6666004)(53546011)(966005)(22166006)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2023 08:24:13.7392
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e676fe3-a07f-415f-7581-08daec9abb5b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7367
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org



On 12/30/22 13:57, Adrian Hunter wrote:
> On 30/12/22 08:42, Marek Vasut wrote:
>> On 12/29/22 13:51, Adrian Hunter wrote:
>>> On 26/10/22 12:20, Marek Vasut wrote:
>>>> On 10/26/22 08:07, Adrian Hunter wrote:
>>>>> On 25/10/22 22:15, Marek Vasut wrote:
>>>>>> On Xilinx ZynqMP, the reg_capabilities (SDIO) Register
>>>>>>
>>>>>> https://www.xilinx.com/htmldocs/registers/ug1087/sdio___reg_capabilities.html#
>>>>>> Absolute Address  0x00FF160040 (SD0)
>>>>>> Reset Value       0x280737EC6481
>>>>>>
>>>>>> really reads 0x200737EC6481 . The interesting part is the
>>>>>> top 32 bits, which are SDHCI_CAPABILITIES_1 = 0x2007. The
>>>>>> missing 0x800 is SDHCI_RETUNING_TIMER_COUNT_MASK=0, which
>>>>>> makes the SDHCI core disable retuning timer.
>>>>>>
>>>>>> Fix this up here by explicitly setting tuning_count to 8
>>>>>> as it should be, otherwise an eMMC might fail in various
>>>>>> thermal conditions
>>>>>>
>>>>>> Note that the diff is best shown with -w option, this makes it
>>>>>> visible what happened with !sdhci_arasan->has_cqe conditional,
>>>>>> which is placed between sdhci_setup_host() and __sdhci_add_host()
>>>>>> calls. Since sdhci_add_host() is also a sequence of these two
>>>>>> calls and host->tuning_count must be overriden before calling
>>>>>
>>>>> overriden -> overridden
>>>>
>>>> Fixed
>>>>
>>>>>> __sdhci_add_host(), call the two calls separately and do all
>>>>>> the adjustments between them in either case.
>>>>>>
>>>>>> Signed-off-by: Marek Vasut <marex@denx.de>
>>>>>> ---
>>>>>> Cc: Michal Simek <michal.simek@xilinx.com>
>>>>>> Cc: Adrian Hunter <adrian.hunter@intel.com>
>>>>>> Cc: Ulf Hansson <ulf.hansson@linaro.org>
>>>>>> Cc: linux-arm-kernel@lists.infradead.org
>>>>>> To: linux-mmc@vger.kernel.org
>>>>>> ---
>>>>>>     drivers/mmc/host/sdhci-of-arasan.c | 57 ++++++++++++++++++++----------
>>>>>>     1 file changed, 38 insertions(+), 19 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
>>>>>> index 3997cad1f793d..465498f2a7c0f 100644
>>>>>> --- a/drivers/mmc/host/sdhci-of-arasan.c
>>>>>> +++ b/drivers/mmc/host/sdhci-of-arasan.c
>>>>>> @@ -1521,37 +1521,56 @@ static int sdhci_arasan_register_sdclk(struct sdhci_arasan_data *sdhci_arasan,
>>>>>>         return 0;
>>>>>>     }
>>>>>>     -static int sdhci_arasan_add_host(struct sdhci_arasan_data *sdhci_arasan)
>>>>>> +static int sdhci_arasan_add_host(struct sdhci_arasan_data *sdhci_arasan,
>>>>>> +                 struct device *dev)
>>>>>>     {
>>>>>>         struct sdhci_host *host = sdhci_arasan->host;
>>>>>>         struct cqhci_host *cq_host;
>>>>>>         bool dma64;
>>>>>>         int ret;
>>>>>>     -    if (!sdhci_arasan->has_cqe)
>>>>>> -        return sdhci_add_host(host);
>>>>>> -
>>>>>>         ret = sdhci_setup_host(host);
>>>>>>         if (ret)
>>>>>>             return ret;
>>>>>>     -    cq_host = devm_kzalloc(host->mmc->parent,
>>>>>> -                   sizeof(*cq_host), GFP_KERNEL);
>>>>>> -    if (!cq_host) {
>>>>>> -        ret = -ENOMEM;
>>>>>> -        goto cleanup;
>>>>>> -    }
>>>>>> +    /*
>>>>>> +     * On Xilinx ZynqMP, the reg_capabilities (SDIO) Register
>>>>>> +     *
>>>>>> +     * https://www.xilinx.com/htmldocs/registers/ug1087/sdio___reg_capabilities.html#
>>>>>> +     * Absolute Address  0x00FF160040 (SD0)
>>>>>> +     * Reset Value         0x280737EC6481
>>>>>> +     *
>>>>>> +     * really reads 0x200737EC6481 . The interesting part is the
>>>>>> +     * top 32 bits, which are SDHCI_CAPABILITIES_1 = 0x2007. The
>>>>>> +     * missing 0x800 is SDHCI_RETUNING_TIMER_COUNT_MASK=0, which
>>>>>> +     * makes the SDHCI core disable retuning timer.
>>>>>
>>>>> Are you aware that caps can be changed in DT via "sdhci-caps" and
>>>>> "sdhci-caps-mask" ?
>>>>
>>>> No, I wasn't aware of those.
>>>>
>>>> Is that the preferred approach to this fix, over handling it in the driver ?
>>>
>>> I guess ideally.  Mainline does not really need the driver
>>> fix because it seems it can be done by DT.  Older kernels
>>> are a separate issue really.
>>>
>>>>
>>>> I think the driver-side fix would be preferable, because it also fixes systems which use legacy DTs without the sdhci-caps properties, which would be all ZynqMP systems thus far.
>>>
>>> You could backport support of the properties "sdhci-caps"
>>> and "sdhci-caps-mask".
>>
>> This won't help. Vivado (the xilinx FPGA design tool) is capable of generating DTs, so you can end up with a combination of new Linux kernel and old generated DT, which is still missing the sdhci-caps/sdhci-caps-mask .
> 
> That is a bit sad.  You might want to push for changing that situation.
> 
> Send an updated patch then.
> 

Xilinx Device Tree Generator, which is the tool for DT generation, was never 
designed to be directly used without any change. It was designed to help you to 
describe the system as much as possible. It means you get the base and you need 
to change things which are not properly described. That's why just do it.

Thanks,
Michal
