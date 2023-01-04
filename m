Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B53D4C4332F
	for <linux-mmc@archiver.kernel.org>; Wed,  4 Jan 2023 07:18:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233204AbjADHSi (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 4 Jan 2023 02:18:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbjADHSh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Jan 2023 02:18:37 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D3852E7
        for <linux-mmc@vger.kernel.org>; Tue,  3 Jan 2023 23:18:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kiu03ZGuN5Mh+FTfUKqeiuhOp81PuBmHTEt91F/AvB7sKAwycz9VPm/ZwqePXZCZ+mEumGLLI0Ny2FvdEyncTHQU9LhGPcG0eFajleMfuBhHiFKxr4KVprVTQ1muTcO2Vr78lyopE8IsTVMbtld24hM8TdIWjcZpbarSvxUnsHcccGBqBK0o4YK2QsjVJJ3TRw7JabW4ZfK7OluKKclmacurjwdL8Nbic9+TXAzm3nSFTKzqiYdIp05S+5T0mEsQ/pfl1WmlQDCGHzTDnOmHlu0iG3MuXcvp53g3GO6ADb/w/pBPPRgPF1+MpFE3JkM42rV/VQuADneuI/1S/8Cn2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tHbTyuRncT7SOFPKL1MdwGXIEXgBR2iKPD9pobouA0I=;
 b=b1CgaRwtgYWXJZbAMpwyLqWpoAplgrGmBERbp3G4clzbtIfE0ecWnB9t1z4J4UG++vSV35idRddZGbyIee7ZwJGOr+53+RfNUYPt0AhNPm0oIVL381Tg27U9kBvUdROVHLL3XVb7C50C06wBHjG/YwdnD1COITNDOvLuNU9ySjXUlVs37FM5U/nxbL6454D8KmrRbN9As46dn86QcW2c/rJpeBc1lZuC/Oo5UC/Vn6Jhu+6yIlESv3O/ftwTOowZbHusk5QYsYsdu2oiXvKmfZ8pagYTSKj76FLrmq+7keqmdr+GewzwaS2UBYyagEwnKBG1+n32vaQm64feqs2G7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=denx.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tHbTyuRncT7SOFPKL1MdwGXIEXgBR2iKPD9pobouA0I=;
 b=Jl8dsbLbk+ilUWcxLmDIuO2A7/Rp3wQtAqNKtMiUT+RAc4rSKH4DUYMEnQf16aXAUsyBlmGfybu33rMqTxTNkp8nt9Gf0bcHRHdNnWrNu28tNbeZUiJ7hIaRjUW6vh+EcG/ETNLPKjPgw4ABrAOPkaiNqSgDbSaQrKTApmCJ/bs=
Received: from MW4PR04CA0163.namprd04.prod.outlook.com (2603:10b6:303:85::18)
 by MN2PR12MB4207.namprd12.prod.outlook.com (2603:10b6:208:1d9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 07:18:33 +0000
Received: from CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:85:cafe::68) by MW4PR04CA0163.outlook.office365.com
 (2603:10b6:303:85::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.14 via Frontend
 Transport; Wed, 4 Jan 2023 07:18:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT054.mail.protection.outlook.com (10.13.174.70) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5986.14 via Frontend Transport; Wed, 4 Jan 2023 07:18:32 +0000
Received: from [10.254.241.50] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 4 Jan
 2023 01:18:27 -0600
Message-ID: <62828df4-4249-39b3-fc35-ee3cf33b95ba@amd.com>
Date:   Wed, 4 Jan 2023 08:18:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] mmc: sdhci-of-arasan: Override
 SDHCI_RETUNING_TIMER_COUNT_MASK on ZynqMP
Content-Language: en-US
To:     Marek Vasut <marex@denx.de>,
        Adrian Hunter <adrian.hunter@intel.com>,
        <linux-mmc@vger.kernel.org>
CC:     Michal Simek <michal.simek@xilinx.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20221025191500.149167-1-marex@denx.de>
 <2b523371-7eeb-25f2-8879-76bbf028f4bb@intel.com>
 <c3d62448-fd1c-066c-aa53-2df7eae1555d@denx.de>
 <ebf570a1-3d2f-85d7-3a29-540caf9f576d@intel.com>
 <8958eb65-e873-a760-5ca4-a51b36f5e23d@denx.de>
 <873d21fa-d9ff-ee94-40a1-3354850c8865@intel.com>
 <2db4c424-74fa-24a6-852d-10d7a18a0541@amd.com>
 <2138356e-f101-0ca2-faae-b3bda5539f05@denx.de>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <2138356e-f101-0ca2-faae-b3bda5539f05@denx.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT054:EE_|MN2PR12MB4207:EE_
X-MS-Office365-Filtering-Correlation-Id: 4067ca26-cda2-4098-dcb8-08daee23e349
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f8IRRDBJGDfMNRyThjDLypBNi2Jl0s0ex332wk2Q1YVMO85qH9N6Ge9+2mPfaUemTGy5iSKwsiwyIQ3iu8fopcye0FyPXdxqicLSR9H66ntKurFJvf0e6RW3LYohRDiALB2Y10cykS82XDfz03B5O4qrNsl4aMobFVSHG50BWGgG+6ODiw2EFOG2Z9YPBMZUA3YbOkCzZeUJINIbLTIX1V/8rLE0biu93fMxmHqgUZaTXhfI2Z81pdfHRHdyrsDfnCcdTljTzaH3N4fKuBoDqgHY+O+edNUAblCNEMD4nszcXwBezBevuqFJ2qcQ2V/3YCx4XlnfKGLEm/IcVA5SCUgDiHQSutBIPjy6yePgtCkS0FSLFDBqlbZus6GDfE0Sh+9ufUsbClZ7Bw28j1gFa/CJans2HLXMT/gK1jDYpTj3Ar5JDJ/abo6xZJYSyA8ODy+SdI9jsqnurCtLtrpgwmjFIcDMht4T5Invw9ros17NVxyZYm9tUIBi7OCyS+EI5jhafiYXDRLYoJPiSysCQpI2N4TOHmcUufIXjh8Ji05Kxofx+Lh6X9zl+CG+CczLD+9J6ZDb2UnIrSjiwvKq/b8ni0Tcoo60pZmXsnjeGghr79LtdHNNMp4dJIUpd0FRrvNPzVwau8EwQ3teDh0k8fsAR9HUNlCPHa8Zbux5xR7ZzsMExxVb4D4BUxhh5XggQB+BEUlB4ZasH2YF9x7eKc6QqOdkegIojmr7t4207L1a4Dp58ljO1uGWyeTXhc1Z3ShxiQVK1Tz6cI3JlwfxBk90GeKvpSr/TR5eyfpElvs=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(346002)(136003)(39860400002)(451199015)(40470700004)(36840700001)(46966006)(4326008)(5660300002)(41300700001)(316002)(8936002)(70586007)(8676002)(54906003)(110136005)(66899015)(2906002)(70206006)(44832011)(16576012)(6666004)(966005)(478600001)(186003)(26005)(53546011)(31686004)(16526019)(31696002)(40480700001)(86362001)(426003)(36860700001)(2616005)(47076005)(83380400001)(336012)(36756003)(82740400003)(356005)(81166007)(82310400005)(40460700003)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 07:18:32.9318
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4067ca26-cda2-4098-dcb8-08daee23e349
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4207
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org



On 1/3/23 21:35, Marek Vasut wrote:
> On 1/2/23 09:24, Michal Simek wrote:
>>
>>
>> On 12/30/22 13:57, Adrian Hunter wrote:
>>> On 30/12/22 08:42, Marek Vasut wrote:
>>>> On 12/29/22 13:51, Adrian Hunter wrote:
>>>>> On 26/10/22 12:20, Marek Vasut wrote:
>>>>>> On 10/26/22 08:07, Adrian Hunter wrote:
>>>>>>> On 25/10/22 22:15, Marek Vasut wrote:
>>>>>>>> On Xilinx ZynqMP, the reg_capabilities (SDIO) Register
>>>>>>>>
>>>>>>>> https://www.xilinx.com/htmldocs/registers/ug1087/sdio___reg_capabilities.html#
>>>>>>>> Absolute Address  0x00FF160040 (SD0)
>>>>>>>> Reset Value       0x280737EC6481
>>>>>>>>
>>>>>>>> really reads 0x200737EC6481 . The interesting part is the
>>>>>>>> top 32 bits, which are SDHCI_CAPABILITIES_1 = 0x2007. The
>>>>>>>> missing 0x800 is SDHCI_RETUNING_TIMER_COUNT_MASK=0, which
>>>>>>>> makes the SDHCI core disable retuning timer.
>>>>>>>>
>>>>>>>> Fix this up here by explicitly setting tuning_count to 8
>>>>>>>> as it should be, otherwise an eMMC might fail in various
>>>>>>>> thermal conditions
>>>>>>>>
>>>>>>>> Note that the diff is best shown with -w option, this makes it
>>>>>>>> visible what happened with !sdhci_arasan->has_cqe conditional,
>>>>>>>> which is placed between sdhci_setup_host() and __sdhci_add_host()
>>>>>>>> calls. Since sdhci_add_host() is also a sequence of these two
>>>>>>>> calls and host->tuning_count must be overriden before calling
>>>>>>>
>>>>>>> overriden -> overridden
>>>>>>
>>>>>> Fixed
>>>>>>
>>>>>>>> __sdhci_add_host(), call the two calls separately and do all
>>>>>>>> the adjustments between them in either case.
>>>>>>>>
>>>>>>>> Signed-off-by: Marek Vasut <marex@denx.de>
>>>>>>>> ---
>>>>>>>> Cc: Michal Simek <michal.simek@xilinx.com>
>>>>>>>> Cc: Adrian Hunter <adrian.hunter@intel.com>
>>>>>>>> Cc: Ulf Hansson <ulf.hansson@linaro.org>
>>>>>>>> Cc: linux-arm-kernel@lists.infradead.org
>>>>>>>> To: linux-mmc@vger.kernel.org
>>>>>>>> ---
>>>>>>>>     drivers/mmc/host/sdhci-of-arasan.c | 57 ++++++++++++++++++++----------
>>>>>>>>     1 file changed, 38 insertions(+), 19 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/mmc/host/sdhci-of-arasan.c 
>>>>>>>> b/drivers/mmc/host/sdhci-of-arasan.c
>>>>>>>> index 3997cad1f793d..465498f2a7c0f 100644
>>>>>>>> --- a/drivers/mmc/host/sdhci-of-arasan.c
>>>>>>>> +++ b/drivers/mmc/host/sdhci-of-arasan.c
>>>>>>>> @@ -1521,37 +1521,56 @@ static int sdhci_arasan_register_sdclk(struct 
>>>>>>>> sdhci_arasan_data *sdhci_arasan,
>>>>>>>>         return 0;
>>>>>>>>     }
>>>>>>>>     -static int sdhci_arasan_add_host(struct sdhci_arasan_data 
>>>>>>>> *sdhci_arasan)
>>>>>>>> +static int sdhci_arasan_add_host(struct sdhci_arasan_data *sdhci_arasan,
>>>>>>>> +                 struct device *dev)
>>>>>>>>     {
>>>>>>>>         struct sdhci_host *host = sdhci_arasan->host;
>>>>>>>>         struct cqhci_host *cq_host;
>>>>>>>>         bool dma64;
>>>>>>>>         int ret;
>>>>>>>>     -    if (!sdhci_arasan->has_cqe)
>>>>>>>> -        return sdhci_add_host(host);
>>>>>>>> -
>>>>>>>>         ret = sdhci_setup_host(host);
>>>>>>>>         if (ret)
>>>>>>>>             return ret;
>>>>>>>>     -    cq_host = devm_kzalloc(host->mmc->parent,
>>>>>>>> -                   sizeof(*cq_host), GFP_KERNEL);
>>>>>>>> -    if (!cq_host) {
>>>>>>>> -        ret = -ENOMEM;
>>>>>>>> -        goto cleanup;
>>>>>>>> -    }
>>>>>>>> +    /*
>>>>>>>> +     * On Xilinx ZynqMP, the reg_capabilities (SDIO) Register
>>>>>>>> +     *
>>>>>>>> +     * 
>>>>>>>> https://www.xilinx.com/htmldocs/registers/ug1087/sdio___reg_capabilities.html#
>>>>>>>> +     * Absolute Address  0x00FF160040 (SD0)
>>>>>>>> +     * Reset Value         0x280737EC6481
>>>>>>>> +     *
>>>>>>>> +     * really reads 0x200737EC6481 . The interesting part is the
>>>>>>>> +     * top 32 bits, which are SDHCI_CAPABILITIES_1 = 0x2007. The
>>>>>>>> +     * missing 0x800 is SDHCI_RETUNING_TIMER_COUNT_MASK=0, which
>>>>>>>> +     * makes the SDHCI core disable retuning timer.
>>>>>>>
>>>>>>> Are you aware that caps can be changed in DT via "sdhci-caps" and
>>>>>>> "sdhci-caps-mask" ?
>>>>>>
>>>>>> No, I wasn't aware of those.
>>>>>>
>>>>>> Is that the preferred approach to this fix, over handling it in the driver ?
>>>>>
>>>>> I guess ideally.  Mainline does not really need the driver
>>>>> fix because it seems it can be done by DT.  Older kernels
>>>>> are a separate issue really.
>>>>>
>>>>>>
>>>>>> I think the driver-side fix would be preferable, because it also fixes 
>>>>>> systems which use legacy DTs without the sdhci-caps properties, which 
>>>>>> would be all ZynqMP systems thus far.
>>>>>
>>>>> You could backport support of the properties "sdhci-caps"
>>>>> and "sdhci-caps-mask".
>>>>
>>>> This won't help. Vivado (the xilinx FPGA design tool) is capable of 
>>>> generating DTs, so you can end up with a combination of new Linux kernel and 
>>>> old generated DT, which is still missing the sdhci-caps/sdhci-caps-mask .
>>>
>>> That is a bit sad.  You might want to push for changing that situation.
>>>
>>> Send an updated patch then.
>>>
>>
>> Xilinx Device Tree Generator, which is the tool for DT generation, was never 
>> designed to be directly used without any change. It was designed to help you 
>> to describe the system as much as possible. It means you get the base and you 
>> need to change things which are not properly described. That's why just do it.
> 
> I am under the impression that petalinux does pull the XSA from Vivado and 
> directly builds U-Boot and Linux with DT somehow derived from the XSA, maybe 
> using DTG ?
> 
> (note that I am not using petalinux)

They do use it but they are not keeping backward compatibility that's why they 
don't need to solve this problem.

Thanks,
Michal

