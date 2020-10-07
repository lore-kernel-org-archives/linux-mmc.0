Return-Path: <SRS0=fQuC=DO=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 920CBC4363D
	for <linux-mmc@archiver.kernel.org>; Wed,  7 Oct 2020 13:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDFB321548
	for <linux-mmc@archiver.kernel.org>; Wed,  7 Oct 2020 13:58:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="c43xvpu6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728513AbgJGN65 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 7 Oct 2020 09:58:57 -0400
Received: from mail-dm6nam10on2054.outbound.protection.outlook.com ([40.107.93.54]:19808
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728467AbgJGN65 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 7 Oct 2020 09:58:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dcc9TyfrmIOW/0D/yexqY1fWsno0syxz8ztiV0Pg2SLouEcIPNZUOJJhBHy6g2EJ+e6IbbsZVq4qK84Yi0PDf8tatwIhe+n7LSqAuBojgIrFurIlkMW3IWM4ACfeUKM4hwI0IF08ZUb9ApyNfpiFNHmiOGXka92McepSVgNLyxN6BzNm/r1yde4EBUNlkEpkTAk/nlXlhPnfElJNkKbAGYiGhcgIBFOrsTooo1YjkT/yYMpLa/q2v75850jJYxte6GCEBspvAifOwKCRnK72dBUgii/GhjZJ/SAc0zaxzvAS/nygHanxC0qcpVxa3KDB4/x6yNu9VJxQ1VcvmWjY2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fTEIP01uuSXtw07HFHYNcv12VnQVothc4aoAw97JCK8=;
 b=eb/u8kSEveYvB6ZH/CC9st2ffYxYGjHF5n8mUfeKrzdg+FfduX1flHvM5Fe408gHdD6Xj1621QF4ElzjmAI/XdGoN6A/shOPndAfsLTLaOatq3uly0bR0EWJ+bHpPf7qS7+dsJwm9miH7O6NAZq8zibX5yo+OBJzMeehfnUahToN0oZLRwOy6kug25KkFpeuT2EES/Y9TMx6W4m6BHc1MMDkB4dtou6jUAzXqN6z1ZJyQRhY7MJDh1qtt5poLzkKKUF72pd/zdX6C9uwqS4TRa0HExoQGCJD2/uMMnbEVwhHIEiTe5wqlZY1lKwh8NB9mgWV1cILdiNm7Xl7vi2kXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=intel.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fTEIP01uuSXtw07HFHYNcv12VnQVothc4aoAw97JCK8=;
 b=c43xvpu6oEAD/Oem51rvICEMchHX2zNilbLXBkD1NtBW/XSSZgM9f/Mq+V4VHl8cWFrZFtMWUzcLb/g+iZc8i9O8xeDIwMHF5IAQyB4fdTdXTXwD9NuslDisYscRYyswUkGYP5FR33ComAfktt60PdAKk/LHeIAuPrY5ohNN8n0=
Received: from CY4PR19CA0038.namprd19.prod.outlook.com (2603:10b6:903:103::24)
 by BY5PR02MB6675.namprd02.prod.outlook.com (2603:10b6:a03:203::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.36; Wed, 7 Oct
 2020 13:58:53 +0000
Received: from CY1NAM02FT008.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:103:cafe::94) by CY4PR19CA0038.outlook.office365.com
 (2603:10b6:903:103::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.22 via Frontend
 Transport; Wed, 7 Oct 2020 13:58:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT008.mail.protection.outlook.com (10.152.75.59) with Microsoft SMTP
 Server id 15.20.3433.39 via Frontend Transport; Wed, 7 Oct 2020 13:58:52
 +0000
Received: from [149.199.38.66] (port=38439 helo=smtp.xilinx.com)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1kQ9xQ-0007C4-Es; Wed, 07 Oct 2020 06:58:16 -0700
Received: from [127.0.0.1] (helo=localhost)
        by smtp.xilinx.com with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1kQ9y0-0003Tn-Ge; Wed, 07 Oct 2020 06:58:52 -0700
Received: from xsj-pvapsmtp01 (mailman.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 097DwikD010920;
        Wed, 7 Oct 2020 06:58:44 -0700
Received: from [172.30.17.110]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1kQ9xr-0003SL-P5; Wed, 07 Oct 2020 06:58:44 -0700
Subject: Re: [PATCH v3 2/2] firmware: Keem Bay: Add support for Arm Trusted
 Firmware Service call
To:     "Zulkifli, Muhammad Husaini" <muhammad.husaini.zulkifli@intel.com>,
        Michal Simek <michal.simek@xilinx.com>,
        "Hunter, Adrian" <adrian.hunter@intel.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>,
        "Wan Mohamad, Wan Ahmad Zainie" 
        <wan.ahmad.zainie.wan.mohamad@intel.com>,
        "arnd@arndb.de" <arnd@arndb.de>
References: <20201006155549.3595-1-muhammad.husaini.zulkifli@intel.com>
 <20201006155549.3595-3-muhammad.husaini.zulkifli@intel.com>
 <4677c614-ac00-fb69-d22c-54f9015249f4@xilinx.com>
 <DM6PR11MB2876F93077CA6705EFAB2E4EB80A0@DM6PR11MB2876.namprd11.prod.outlook.com>
 <db60efac-c583-4b2a-3ad9-7bd93dfb5323@xilinx.com>
 <DM6PR11MB2876A16148E84AB8FFC0B7FAB80A0@DM6PR11MB2876.namprd11.prod.outlook.com>
From:   Michal Simek <michal.simek@xilinx.com>
Autocrypt: addr=michals@xilinx.com; keydata=
 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
 0Z1MQlmNcq2bhOMzTxuXX2NDzUZs4aqEyZQ=
Message-ID: <b29226d8-08ad-f708-73d7-1c4bb66e5767@xilinx.com>
Date:   Wed, 7 Oct 2020 15:58:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <DM6PR11MB2876A16148E84AB8FFC0B7FAB80A0@DM6PR11MB2876.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f825064-c72b-49fb-2f75-08d86ac91fd7
X-MS-TrafficTypeDiagnostic: BY5PR02MB6675:
X-Microsoft-Antispam-PRVS: <BY5PR02MB667579D9BAC09F510CE97F4CC60A0@BY5PR02MB6675.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YzicsA7FiF770SiKPkhDKK+YdmLBgDEFRFcQeAfHcHIPSugUpwrv1SabHougxskFfvJUsBVYvA3CL2hybeK0IuePfTR4Ju9nCAmZxPfctYQR3WgHipx7vhlgUyW2HAgOsMYmZQMzmC/QoDmrC651FlJuYe4ja4D925zydj9znP/jV/aCuiytyIhVXFQo6+dOXSqBviZ06F0P4nJ/WYiUQwKy8pauhjKz6YE0Oy0cfe1FPs26F8Palle1PlKVwRbcsX+l4yVDXFJkRVir0BmgYaCLkYmPykhhhGyB2PWB3ulfvNfLss8ecH8ivibjYZN3KtzYUzhEjGqIokoo5dVhQMr6LI7sb06xK9pB1zumEwob36SDmf9M6ScIqSBm6se0E742BbuK23CZre3YZCtzMOidXMbWyG09Bq9CweQPVaeMCskJ/bD1oIR6gX41UnZn
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFS:(396003)(39850400004)(346002)(136003)(376002)(46966005)(4326008)(7416002)(83380400001)(31686004)(316002)(54906003)(110136005)(478600001)(6666004)(81166007)(44832011)(53546011)(2906002)(8936002)(47076004)(82740400003)(36756003)(5660300002)(31696002)(9786002)(356005)(2616005)(26005)(426003)(336012)(8676002)(70586007)(186003)(82310400003)(70206006)(921003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2020 13:58:52.7972
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f825064-c72b-49fb-2f75-08d86ac91fd7
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT008.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6675
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

On 07. 10. 20 15:52, Zulkifli, Muhammad Husaini wrote:
> Hi,
> 
>> -----Original Message-----
>> From: Michal Simek <michal.simek@xilinx.com>
>> Sent: Wednesday, October 7, 2020 9:37 PM
>> To: Zulkifli, Muhammad Husaini <muhammad.husaini.zulkifli@intel.com>;
>> Michal Simek <michal.simek@xilinx.com>; Hunter, Adrian
>> <adrian.hunter@intel.com>; sudeep.holla@arm.com; ulf.hansson@linaro.org;
>> linux-mmc@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
>> kernel@vger.kernel.org
>> Cc: Raja Subramanian, Lakshmi Bai <lakshmi.bai.raja.subramanian@intel.com>;
>> Wan Mohamad, Wan Ahmad Zainie
>> <wan.ahmad.zainie.wan.mohamad@intel.com>; arnd@arndb.de
>> Subject: Re: [PATCH v3 2/2] firmware: Keem Bay: Add support for Arm Trusted
>> Firmware Service call
>>
>> Hi,
>>
>> On 07. 10. 20 15:21, Zulkifli, Muhammad Husaini wrote:
>>> Hi Michal,
>>>
>>> Thanks for the feedback. I replied inline
>>>
>>>> -----Original Message-----
>>>> From: Michal Simek <michal.simek@xilinx.com>
>>>> Sent: Wednesday, October 7, 2020 4:20 PM
>>>> To: Zulkifli, Muhammad Husaini <muhammad.husaini.zulkifli@intel.com>;
>>>> Hunter, Adrian <adrian.hunter@intel.com>; michal.simek@xilinx.com;
>>>> sudeep.holla@arm.com; ulf.hansson@linaro.org;
>>>> linux-mmc@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
>>>> linux-kernel@vger.kernel.org
>>>> Cc: Raja Subramanian, Lakshmi Bai
>>>> <lakshmi.bai.raja.subramanian@intel.com>;
>>>> Wan Mohamad, Wan Ahmad Zainie
>>>> <wan.ahmad.zainie.wan.mohamad@intel.com>; arnd@arndb.de
>>>> Subject: Re: [PATCH v3 2/2] firmware: Keem Bay: Add support for Arm
>>>> Trusted Firmware Service call
>>>>
>>>> Hi,
>>>>
>>>> 1. Keem Bay: in subject is wrong. Tools are working with it and you
>>>> should just use keembay: instead.
>>> Are you saying like this ?
>>> Keem Bay: Add support for Arm Trusted Firmware Service call
>>
>> like this:
>> firmware: keembay: Add support for Arm Trusted Firmware Service call
>>
>>>
>>>>
>>>> 2. This should come first before actual change to keep the tree bisectable.
>>> Noted. Done the changes
>>>>
>>>> On 06. 10. 20 17:55, muhammad.husaini.zulkifli@intel.com wrote:
>>>>> From: Muhammad Husaini Zulkifli
>>>>> <muhammad.husaini.zulkifli@intel.com>
>>>>>
>>>>> Add header file to handle API function for device driver to
>>>>> communicate with Arm Trusted Firmware.
>>>>>
>>>>> Signed-off-by: Muhammad Husaini Zulkifli
>>>>> <muhammad.husaini.zulkifli@intel.com>
>>>>> ---
>>>>>  .../linux/firmware/intel/keembay_firmware.h   | 46 +++++++++++++++++++
>>>>>  1 file changed, 46 insertions(+)
>>>>>  create mode 100644 include/linux/firmware/intel/keembay_firmware.h
>>>>>
>>>>> diff --git a/include/linux/firmware/intel/keembay_firmware.h
>>>>> b/include/linux/firmware/intel/keembay_firmware.h
>>>>> new file mode 100644
>>>>> index 000000000000..9adb8c87b788
>>>>> --- /dev/null
>>>>> +++ b/include/linux/firmware/intel/keembay_firmware.h
>>>>> @@ -0,0 +1,46 @@
>>>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>>>> +/*
>>>>> + *  Intel Keembay SOC Firmware API Layer
>>>>> + *
>>>>> + *  Copyright (C) 2020-2021, Intel Corporation
>>>>> + *
>>>>> + *  Muhammad Husaini Zulkifli <Muhammad.Husaini.Zulkifli@intel.com>
>>>>> + */
>>>>> +
>>>>> +#ifndef __FIRMWARE_KEEMBAY_SMC_H__
>>>>> +#define __FIRMWARE_KEEMBAY_SMC_H__
>>>>> +
>>>>> +#include <linux/arm-smccc.h>
>>>>> +
>>>>> +/**
>>>>
>>>> This is not a kernel doc comment. Just use /*
>>>>
>>>>> + * This file defines API function that can be called by device
>>>>> + driver in order to
>>>>> + * communicate with Arm Trusted Firmware.
>>>>> + */
>>>>> +
>>>>> +/* Setting for Keem Bay IO Pad Line Voltage Selection */
>>>>> +#define KEEMBAY_SET_SD_VOLTAGE_FUNC_ID	0x8200ff26
>>>>
>>>> Sudeep: Don't we have any macros for composing these IDs?
>>>> nit: IMHO composing these IDs from macros would make more sense to me.
>>>>
>>>>
>>>>> +#define KEEMBAY_SET_1V8_VOLT		0x01
>>>>
>>>> 0x01 is just 1
>>> Noted. Done the changes
>>>>
>>>>> +#define KEEMBAY_SET_3V3_VOLT		0x00
>>>>
>>>> 0x00 is just 0
>>> Noted. Done the changes
>>>>
>>>>> +
>>>>> +#if IS_ENABLED(CONFIG_HAVE_ARM_SMCCC_DISCOVERY)
>>>>> +static int do_fw_invoke(u64 func_id, u64 arg0, u64 arg1) {
>>>>> +	struct arm_smccc_res res;
>>>>> +
>>>>> +	arm_smccc_1_1_invoke(func_id, arg0, arg1, &res);
>>>>> +
>>>>> +	return res.a0;
>>>>
>>>> I am not big fan of this error propagation in case of failure.
>>>>
>>>> If smc fails you get via res.a0 SMCCC_RET_NOT_SUPPORTED which is
>>>> defined as
>>>> -1 which is based on errno-base.h defined as EPERM.
>>>>
>>>> That driver which Sudeep pointed you to is using EINVAL instead.
>>>>
>>>> It means I would add a code to check it.
>>>
>>> Yeah I changed to below line of codes. Is this Ok? Tested working.
>>> int keembay_sd_voltage_selection(int volt)
>>
>> static inline here shouldn't hurt.
> due to func() prototype " int keembay_sd_voltage_selection(int volt);" to solve warning issues by robot , I cannot set static inline here. 
> Will observed below error:
> 
> error: static declaration of ‘keembay_sd_voltage_selection’ follows non-static declaration
>  static inline int keembay_sd_voltage_selection(int volt).

Will take a look at when you send new version.

Thanks,
Michal


