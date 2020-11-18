Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 644D2C5519F
	for <linux-mmc@archiver.kernel.org>; Wed, 18 Nov 2020 18:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3673246AD
	for <linux-mmc@archiver.kernel.org>; Wed, 18 Nov 2020 18:25:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="J4ulbCvi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbgKRSZE (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 18 Nov 2020 13:25:04 -0500
Received: from mail-mw2nam10on2083.outbound.protection.outlook.com ([40.107.94.83]:28513
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726020AbgKRSZE (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 18 Nov 2020 13:25:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hdg4J394prKaz0Un2KG8N5cCu7btP+7AVpzoOemkgmfuW3CAys9O36aZY96i4zk+lGCITpym3/K7Y7LOlgoh7hOvmDsJGr3H3zCscCe7tvEIw1s4ewI5B9S3CdvLj1t4lsTbdwiLOEsNY6TZsjLzMVb8tejRXsklqbmafZAaS66cZ8q4cvblJ7GGxYNwF36wKZL7gEY6Rcb6mamBg+ptsBMhONiRQrLotyP6KOeBBkBkIb092bIxMnbJxKt1DyxD5k+A9eZfwlpddCCWNaqhBOJBHLQJmCYPJp6H9xq4fCO9vZRIdDgFWzt4/Qvj8/o8M2zgtawjHPmA8yUIyJLl0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qUDTZ0c4JaUVqA5RyiRdUoCO2ux4l53hxJWiJpJ57tU=;
 b=esrz9kO07QOyfsC3XK3sraauZC8AJ9b7VaEBE3C3cMHJ2HgyU8dCx+N+UXSljX8sLwx9/hFEpqGfhpzg0GKNrkHx0WI2HbCq1iHUKB9fRM+hBoLGVI2OS/A5PVq7WfOpW/nNooYDuSCVh8S+sNbTIh7X7Vt5rIeXJZ/zPzgFcs7AnC2vcOFbIOunsySVc8vNfh3MFG2SvOrLbdhLeE1lthDu+RMJG79b1g1GMFoMVrQoySv3NOvHaW2v1TyfGpcBvFzxlvVO1HioFtJbEldKKTpQeETukv15tLz5MKlqrYU0P2AMVVDIZNxoMPq98iOrHLNVAZMyNLTQ9Tu8LYxtBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qUDTZ0c4JaUVqA5RyiRdUoCO2ux4l53hxJWiJpJ57tU=;
 b=J4ulbCviz7/UE8NVPDYKDce1r5oxgpajfYqhz7ovLDLv+cwGLLG5Hwa2O6pGa1/AXenfFAAeA0O7RnRvDzsFJZUxWZRFYeeBy9+0KqCl+b57TjpX5oNYtJUsn/eaMdGt09hMVpzEAnt57IMDXjN3ipHpyEk8MG5O0PxZzHa++as=
Received: from CY4PR14CA0039.namprd14.prod.outlook.com (2603:10b6:903:101::25)
 by BYAPR02MB5416.namprd02.prod.outlook.com (2603:10b6:a03:a4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.21; Wed, 18 Nov
 2020 18:25:01 +0000
Received: from CY1NAM02FT025.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:101:cafe::78) by CY4PR14CA0039.outlook.office365.com
 (2603:10b6:903:101::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20 via Frontend
 Transport; Wed, 18 Nov 2020 18:25:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 CY1NAM02FT025.mail.protection.outlook.com (10.152.75.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3564.22 via Frontend Transport; Wed, 18 Nov 2020 18:25:00 +0000
Received: from xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Wed, 18 Nov 2020 10:24:32 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Wed, 18 Nov 2020 10:24:32 -0800
Envelope-to: git@xilinx.com,
 michal.simek@xilinx.com,
 linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 adrian.hunter@intel.com,
 ulf.hansson@linaro.org
Received: from [172.30.17.110] (port=41868)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1kfS87-0003sV-CS; Wed, 18 Nov 2020 10:24:31 -0800
Subject: Re: [PATCH] mmc: sdhci-of-arasan: Add pinctrl support to the driver
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Manish Narani <manish.narani@xilinx.com>
CC:     Michal Simek <michal.simek@xilinx.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        <git@xilinx.com>
References: <1605680495-37483-1-git-send-email-manish.narani@xilinx.com>
 <CAPDyKFr7KTf7jUAuPj=0NZ1sty+y7ySV8PkdrKFXPVthJ=VJVQ@mail.gmail.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <aeb44b64-5ff6-5662-2761-0e804708ce8a@xilinx.com>
Date:   Wed, 18 Nov 2020 19:24:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <CAPDyKFr7KTf7jUAuPj=0NZ1sty+y7ySV8PkdrKFXPVthJ=VJVQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 20ed5a8d-f2be-47f7-11a4-08d88bef4340
X-MS-TrafficTypeDiagnostic: BYAPR02MB5416:
X-Microsoft-Antispam-PRVS: <BYAPR02MB5416591E09B9284505C98346C6E10@BYAPR02MB5416.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5GmcxtV75o5Tzjc20Z6l5DnjzIurAIpqiif+FiMj4McB8OvlCE/vofdnOBFzaVjWZ7I2hUUmDfM6bZ+X2vGIJpTk8Frcu7FNWSKKcQD3khpdIOQZlYx8+pMRl9O/JwNkS4QvIWv9PXThfZyhBhfV8eGVbddEa9HQ5DUVjAJu5f2oOrVitUjF7AlJ4YsNwVGkrQVjsiErs7oJ+AIK4GSK5nSaxLqdoUlnH8Wikfzszn4bgo9nre7a2c4nxoAj+eEQEy9Gpy/ojyvzRS9/G5Qxzuog+iN9XvHEtZx9wKRkfudbqq2b4kGCe0Hz9ckavghVNRDaQDj1ilvhqXVFG7qxBFBScWKqimeFc+KjM4rOmPj4pAdHgvEf7JuGIjfIQ1C/hLu2RPltYPnsacCFQfxso0FubQloGuOvBpMJzOFXwuz9TpYRmoTpfOq619AebiJJPAHCDleRzf186e6vcSX3AQ==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(39860400002)(376002)(46966005)(107886003)(83380400001)(82310400003)(36756003)(186003)(31696002)(4326008)(26005)(8676002)(110136005)(6636002)(5660300002)(6666004)(54906003)(478600001)(9786002)(2616005)(36906005)(8936002)(2906002)(44832011)(82740400003)(316002)(70206006)(47076004)(7636003)(31686004)(356005)(336012)(70586007)(426003)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2020 18:25:00.3917
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20ed5a8d-f2be-47f7-11a4-08d88bef4340
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT025.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5416
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org



On 18. 11. 20 16:43, Ulf Hansson wrote:
> On Wed, 18 Nov 2020 at 07:22, Manish Narani <manish.narani@xilinx.com> wrote:
>>
>> Driver should be able to handle optional pinctrl setting.
>>
>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
>> ---
>>  drivers/mmc/host/sdhci-of-arasan.c | 24 ++++++++++++++++++++++++
>>  1 file changed, 24 insertions(+)
>>
>> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
>> index 829ccef87426..f788cc9d5914 100644
>> --- a/drivers/mmc/host/sdhci-of-arasan.c
>> +++ b/drivers/mmc/host/sdhci-of-arasan.c
>> @@ -23,6 +23,7 @@
>>  #include <linux/regmap.h>
>>  #include <linux/of.h>
>>  #include <linux/firmware/xlnx-zynqmp.h>
>> +#include <linux/pinctrl/consumer.h>
>>
>>  #include "cqhci.h"
>>  #include "sdhci-pltfm.h"
>> @@ -135,6 +136,8 @@ struct sdhci_arasan_clk_data {
>>   * @clk_ops:           Struct for the Arasan Controller Clock Operations.
>>   * @soc_ctl_base:      Pointer to regmap for syscon for soc_ctl registers.
>>   * @soc_ctl_map:       Map to get offsets into soc_ctl registers.
>> + * @pinctrl:           Per-device pin control state holder.
>> + * @pins_default:      Pinctrl state for a device.
>>   * @quirks:            Arasan deviations from spec.
>>   */
>>  struct sdhci_arasan_data {
>> @@ -149,6 +152,8 @@ struct sdhci_arasan_data {
>>
>>         struct regmap   *soc_ctl_base;
>>         const struct sdhci_arasan_soc_ctl_map *soc_ctl_map;
>> +       struct pinctrl  *pinctrl;
>> +       struct pinctrl_state *pins_default;
>>         unsigned int    quirks;
>>
>>  /* Controller does not have CD wired and will not function normally without */
>> @@ -1619,6 +1624,25 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>>                 goto unreg_clk;
>>         }
>>
>> +       sdhci_arasan->pinctrl = devm_pinctrl_get(&pdev->dev);
>> +       if (!IS_ERR(sdhci_arasan->pinctrl)) {
>> +               sdhci_arasan->pins_default =
>> +                       pinctrl_lookup_state(sdhci_arasan->pinctrl,
>> +                                            PINCTRL_STATE_DEFAULT);
>> +               if (IS_ERR(sdhci_arasan->pins_default)) {
>> +                       dev_err(&pdev->dev, "Missing default pinctrl config\n");
>> +                       ret = PTR_ERR(sdhci_arasan->pins_default);
>> +                       goto unreg_clk;
>> +               }
>> +
>> +               ret = pinctrl_select_state(sdhci_arasan->pinctrl,
>> +                                          sdhci_arasan->pins_default);
>> +               if (ret) {
>> +                       dev_err(&pdev->dev, "could not select default state\n");
>> +                       goto unreg_clk;
>> +               }
>> +       }
> 
> Isn't all this already taken care of via pinctrl_bind_pins() called by
> driver core during probe?
> 

Thanks for the hint.
Manish: Can you please check it?

Thanks,
Michal
