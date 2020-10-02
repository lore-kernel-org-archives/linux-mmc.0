Return-Path: <SRS0=YnZp=DJ=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C7AC4363D
	for <linux-mmc@archiver.kernel.org>; Fri,  2 Oct 2020 08:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FBB52074B
	for <linux-mmc@archiver.kernel.org>; Fri,  2 Oct 2020 08:23:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="c2yFtsQ3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbgJBIXV (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 2 Oct 2020 04:23:21 -0400
Received: from mail-dm6nam12on2069.outbound.protection.outlook.com ([40.107.243.69]:3424
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725961AbgJBIXV (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 2 Oct 2020 04:23:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FovGKDM8KNne2LoKxTs+7BNOjQVMUrZ4cRzIZ7JVK+AEz4NiOsRyhucURAhErPEYUTEApHy5pPKX/qFNP1ji2SW/TnCJ+eMmMkayj8bFni45cPYaNowwL1Eoejpab+FlDUO66CRpX4QQBg2GxCXFd3RSdEw3aTt3AECWAzvvWZPEKAwgLPo4uxZNxzn+CGzQf85TlWW5JhWdyW8r2cAhQY/BOjqdDnPD5/K0xSvCF+3yuNaiLiD73LLH6FobBIwV204bqU2luRm+WbP/uxdVWPb+BzQpFP4KZ8Kf88FlUEgDVEvuJxFDl4dzakUt9QJAttmut9F1BAtsK+jQxWgM7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+KwM4+gSAa3TtOm6brtBfuV1TXRWdUHyDIwxlDnT3EI=;
 b=gJHKHsSvnUTHKsIXRAm5r7hzTHOaytkNWQUFPmbWI+qBggFtQfr9K5o/r+ICxmI/DREGgsHZgB0skmkhDJNxA3RRGDd5/YYox5N9webS5LOzk+F7HEyT8UzawZnrXWvibRLP0E0qRRphGo+Pg7MXL2910z64+qB6NNZrpStWy4zgUfdc6mCkmiKomPT97Sn9/Xkiu01EQk8+lMKlah/TzQlJySQm7qNSO661kw24LM0RMWSw1Ibw8oErH0UNpGTLClUKFgOIkytSTfyqobKXoUlGqvJK7lej6/f1MHLMRFkiY4YVe9Vyl4jChk/6eGXrB+lEsbOUrm9SRiwxZYAXRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=arm.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+KwM4+gSAa3TtOm6brtBfuV1TXRWdUHyDIwxlDnT3EI=;
 b=c2yFtsQ3sKW3kMdoCgcFkRzHnVpme3jQRoWC20/TOxcwNpDLMlA8qWz/v4+Bpx+VqATbHWjf4FJyYrkpiObWIxHOdRlXHrcZNnZqs2CAgqdOAOLVslZdf2fA4qCIY7wTzTq0fchMu357DwvU31O78LcACLfltoTEsc8SV/k8DEo=
Received: from SA9PR03CA0009.namprd03.prod.outlook.com (2603:10b6:806:20::14)
 by MWHPR0201MB3532.namprd02.prod.outlook.com (2603:10b6:301:77::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.35; Fri, 2 Oct
 2020 08:23:13 +0000
Received: from SN1NAM02FT057.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:20:cafe::6f) by SA9PR03CA0009.outlook.office365.com
 (2603:10b6:806:20::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22 via Frontend
 Transport; Fri, 2 Oct 2020 08:23:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT057.mail.protection.outlook.com (10.152.73.105) with Microsoft SMTP
 Server id 15.20.3412.21 via Frontend Transport; Fri, 2 Oct 2020 08:23:13
 +0000
Received: from [149.199.38.66] (port=58498 helo=smtp.xilinx.com)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1kOGKy-0008UK-AC; Fri, 02 Oct 2020 01:22:44 -0700
Received: from [127.0.0.1] (helo=localhost)
        by smtp.xilinx.com with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1kOGLQ-0005yM-Nr; Fri, 02 Oct 2020 01:23:12 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp1.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 0928N6Th005601;
        Fri, 2 Oct 2020 01:23:06 -0700
Received: from [172.30.17.110]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1kOGLJ-0005wh-Sz; Fri, 02 Oct 2020 01:23:06 -0700
Subject: Re: [PATCH v2 2/3] firmware: Keem Bay: Add support for Arm Trusted
 Firmware Service call
To:     Sudeep Holla <sudeep.holla@arm.com>,
        muhammad.husaini.zulkifli@intel.com
Cc:     adrian.hunter@intel.com, michal.simek@xilinx.com,
        ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        lakshmi.bai.raja.subramanian@intel.com, arnd@arndb.de,
        wan.ahmad.zainie.wan.mohamad@intel.com
References: <20201001142149.23445-1-muhammad.husaini.zulkifli@intel.com>
 <20201001142149.23445-3-muhammad.husaini.zulkifli@intel.com>
 <20201001153526.GD906@bogus>
From:   Michal Simek <michal.simek@xilinx.com>
Autocrypt: addr=michals@xilinx.com; keydata=
 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
 0Z1MQlmNcq2bhOMzTxuXX2NDzUZs4aqEyZQ=
Message-ID: <ce2bcac9-8341-d7c1-0652-309ca4e9413c@xilinx.com>
Date:   Fri, 2 Oct 2020 10:23:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201001153526.GD906@bogus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 14e052d7-4d8c-4c4a-ff58-08d866ac678d
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3532:
X-Microsoft-Antispam-PRVS: <MWHPR0201MB3532EEE0379A9031FD15CB79C6310@MWHPR0201MB3532.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tnJZprcQN40dZF0O29yZOWdBhW1Dssgpf//mHB6pbds49yhPh1aNO7vENEhj2Fc+CpwaXFBu1fvt6yiYbXF4MhTfagS5XwKOTrEuZFi5x7ekhszbZZnnV7821SD6/g0DI6oBkdmk7kVvWJgzvhna6MrvN6tPSRfAInAl5Bs9SFNskET8tHUe/o0mFDJzGhweGvJWgxV1rQn8UdelSQlZaFHN3VPeyiFMkhlpmk1WiYozznu4z8/eFzID/DgH/v8ImXW7Cg5gxNv5CU8iSSbxwQ7TM7Ehsf7roIsiByU7iWJFHIdqdQxrcqaFuQ+QP/OoGnaFyAjc4+mWGk1l+7HWIjYYmH1jPWChlIOVtWPgODoJKTQRwyja+0fWhE3nf9n6+QzWUJ+olllGyDA2nir6eVULW89JCt1RWc1tpq9WChhtqxxT7rrvftWl0t9Tc5c6
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFS:(396003)(376002)(39860400002)(346002)(136003)(46966005)(44832011)(82310400003)(4326008)(31686004)(316002)(2906002)(36756003)(5660300002)(31696002)(83380400001)(356005)(2616005)(7416002)(70206006)(478600001)(70586007)(426003)(82740400003)(186003)(26005)(8676002)(9786002)(8936002)(47076004)(6666004)(81166007)(336012)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2020 08:23:13.0552
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14e052d7-4d8c-4c4a-ff58-08d866ac678d
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT057.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0201MB3532
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Sudeep,

On 01. 10. 20 17:35, Sudeep Holla wrote:
> On Thu, Oct 01, 2020 at 10:21:48PM +0800, muhammad.husaini.zulkifli@intel.com wrote:
>> From: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
>>
>> Add generic firmware driver for Keem Bay SOC to support
>> Arm Trusted Firmware Services call.
>>
>> Signed-off-by: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
>> ---
>>  drivers/firmware/Kconfig                   |   1 +
>>  drivers/firmware/Makefile                  |   1 +
>>  drivers/firmware/intel/Kconfig             |  14 +++
>>  drivers/firmware/intel/Makefile            |   4 +
>>  drivers/firmware/intel/keembay_smc.c       | 119 +++++++++++++++++++++
>>  include/linux/firmware/intel/keembay_smc.h |  27 +++++
>>  6 files changed, 166 insertions(+)
>>  create mode 100644 drivers/firmware/intel/Kconfig
>>  create mode 100644 drivers/firmware/intel/Makefile
>>  create mode 100644 drivers/firmware/intel/keembay_smc.c
>>  create mode 100644 include/linux/firmware/intel/keembay_smc.h
>>
>> diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
>> index fbd785dd0513..41de77d2720e 100644
>> --- a/drivers/firmware/Kconfig
>> +++ b/drivers/firmware/Kconfig
>> @@ -305,5 +305,6 @@ source "drivers/firmware/psci/Kconfig"
>>  source "drivers/firmware/smccc/Kconfig"
>>  source "drivers/firmware/tegra/Kconfig"
>>  source "drivers/firmware/xilinx/Kconfig"
>> +source "drivers/firmware/intel/Kconfig"
>>  
>>  endmenu
>> diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
>> index 99510be9f5ed..00f295ab9860 100644
>> --- a/drivers/firmware/Makefile
>> +++ b/drivers/firmware/Makefile
>> @@ -33,3 +33,4 @@ obj-y				+= psci/
>>  obj-y				+= smccc/
>>  obj-y				+= tegra/
>>  obj-y				+= xilinx/
>> +obj-y				+= intel/
>> diff --git a/drivers/firmware/intel/Kconfig b/drivers/firmware/intel/Kconfig
>> new file mode 100644
>> index 000000000000..b2b7a4e5410b
>> --- /dev/null
>> +++ b/drivers/firmware/intel/Kconfig
>> @@ -0,0 +1,14 @@
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +menu "Intel Firmware Drivers"
>> +
>> +config KEEMBAY_FIRMWARE
>> +	bool "Enable Keem Bay firmware interface support"
>> +	depends on HAVE_ARM_SMCCC
> 
> What is the version of SMCCC implemented ?
> If SMCCC v1.1+, use HAVE_ARM_SMCCC_DISCOVERY
> 
>> +	default n
>> +	help
>> +	  Firmware interface driver is used by device drivers
>> +	  to communicate with the arm-trusted-firmware
>> +	  for platform management services.
>> +	  If in doubt, say "N".
>> +
>> +endmenu
>> diff --git a/drivers/firmware/intel/Makefile b/drivers/firmware/intel/Makefile
>> new file mode 100644
>> index 000000000000..e6d2e1ea69a7
>> --- /dev/null
>> +++ b/drivers/firmware/intel/Makefile
>> @@ -0,0 +1,4 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Makefile for Intel firmwares
>> +
>> +obj-$(CONFIG_KEEMBAY_FIRMWARE) = keembay_smc.o
>> diff --git a/drivers/firmware/intel/keembay_smc.c b/drivers/firmware/intel/keembay_smc.c
>> new file mode 100644
>> index 000000000000..24013cd1f5da
>> --- /dev/null
>> +++ b/drivers/firmware/intel/keembay_smc.c
>> @@ -0,0 +1,119 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + *  Copyright (C) 2020-2021, Intel Corporation
>> + */
>> +
>> +#include <linux/arm-smccc.h>
>> +#include <linux/init.h>
>> +#include <linux/module.h>
>> +#include <linux/of_platform.h>
>> +
>> +#include <linux/firmware/intel/keembay_smc.h>
>> +
>> +static noinline int do_fw_call_fail(u64 arg0, u64 arg1)
>> +{
>> +	return -ENODEV;
>> +}
>> +
>> +/**
>> + * Simple wrapper functions to be able to use a function pointer
>> + * Invoke do_fw_call_smc or others in future, depending on the configuration
>> + */
>> +static int (*do_fw_call)(u64, u64) = do_fw_call_fail;
>> +
>> +/**
>> + * do_fw_call_smc() - Call system-level platform management layer (SMC)
>> + * @arg0:		Argument 0 to SMC call
>> + * @arg1:		Argument 1 to SMC call
>> + *
>> + * Invoke platform management function via SMC call.
>> + *
>> + * Return: Returns status, either success or error
>> + */
>> +static noinline int do_fw_call_smc(u64 arg0, u64 arg1)
>> +{
>> +	struct arm_smccc_res res;
>> +
>> +	arm_smccc_smc(arg0, arg1, 0, 0, 0, 0, 0, 0, &res);
>> +
>> +	return res.a0;
>> +}
>> +
>> +/**
>> + * keembay_sd_voltage_selection() - Set the IO Pad voltage
>> + * @volt: voltage selection either 1.8V or 3.3V
>> + *
>> + * This function is used to set the IO Line Voltage
>> + *
>> + * Return: 0 for success, Invalid for failure
>> + */
>> +int keembay_sd_voltage_selection(int volt)
>> +{
>> +	return do_fw_call(KEEMBAY_SIP_FUNC_ID, volt);
> 
> 
> What are the other uses of this KEEMBAY_SIP_* ?
> For now I tend to move this to the driver making use of it using
> arm_smccc_1_1_invoke directly if possible. I don't see the need for this
> to be separate driver. But do let us know the features implemented in the
> firmware. If it is not v1.1+, reasons for not upgrading as you need v1.1
> for some CPU errata implementation.

This driver has been created based on my request to move it out the mmc
driver. It looks quite hacky to have arm_smccc_res and call
arm_smccc_smc() also with some IDs where it is visible that the part of
ID is just based on any spec.
Also in v1 he is just calling SMC. But maybe there is going a need to
call HVC instead which is something what device driver shouldn't decide
that's why IMHO doing step via firmware driver is much better approach.
Of course if there is a better/cleaner way how this should be done I am
happy to get more information about it.

Thanks,
Michal



