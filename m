Return-Path: <SRS0=fQuC=DO=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 682F9C4363C
	for <linux-mmc@archiver.kernel.org>; Wed,  7 Oct 2020 08:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD70B2076C
	for <linux-mmc@archiver.kernel.org>; Wed,  7 Oct 2020 08:20:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="dsoK1iXr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbgJGIUe (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 7 Oct 2020 04:20:34 -0400
Received: from mail-co1nam11on2051.outbound.protection.outlook.com ([40.107.220.51]:17760
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725976AbgJGIUc (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 7 Oct 2020 04:20:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PXgU6fClCzz/1O547ABpiT4SWxdxA4ki7+NT5A2riPnqy4b1BLqqDw1P2iLI2yqHIfDh76bZRwCN3eqBvUjE2L+uQtfKLrZ2DmMnrzqdfzIHZTlG+MwsuWlmV9apNaofiU7Zs6jNAByg/O09Ie+PsrpegB70ixMxIB1fvnOUGQb3LYHiP3FQ2lnOzWhLiUk4J8JQbTQWx2iI0tAMgCDL8WtS74C1C8M/EQDbINXEl14gasKkOzvImhb9S2zRyTmE+420rl1bmsJtf2VAp0lJ07zzTpMn+yrjJEEO8479GfNGBBeGHliLnDXuypWNkATlg/yf7YhkF/Gy5/02oM9wDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NBdzuZSox5oQEpvSMsuzbRWWqK/+R/Wpk0skUjurODI=;
 b=QtEIoCCGjzYWdzU0L5oi4j/UMrw24VpZ+CPMxqa3TzvUXFeUkBSQPLDacHOlsH76AOHRnnF7/bHZq7tPmxOrMXc2Bx/RLyRyodZhQaPSmCwh7Bu5i5cPdT9PMdpaYzyS+LHRkBD5G6Eqr74WCcr5i0hGRdYtKb85BgPSRYZAi3eFA9WNlzrHOAOlVEUSCnLs729gLDEyNCmdo/c8ezN/X/vfactH6QYhR/VrNS49lNjrsVGS7JbZ8EJr0HDkR1LNEmDoJ2efLHvMtDHyUQ1Zwp2F+upXEZ4V5q4ZcAxX/nP+ON6a0fgYOkdsluRMUyfUmb13scjJZGCHwmN2+AUvpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=intel.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NBdzuZSox5oQEpvSMsuzbRWWqK/+R/Wpk0skUjurODI=;
 b=dsoK1iXr9qoVmOilFcqZs2Iq9bqQo3W4ky32U8NXzM0sd+gf3CSzyCtyHiK0hfHnrVx4xt3AjdGkizgOUAB5Q2HDnamVYSOhwf57rPD6Egn3MUb0jY2jdbJDVhs606VF7r+oVA4LCa41zPJ8PHzltQB07N5FqBXXnIJ26C8W6xg=
Received: from SN4PR0501CA0121.namprd05.prod.outlook.com
 (2603:10b6:803:42::38) by DM6PR02MB4812.namprd02.prod.outlook.com
 (2603:10b6:5:17::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Wed, 7 Oct
 2020 08:20:28 +0000
Received: from SN1NAM02FT008.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:42:cafe::fe) by SN4PR0501CA0121.outlook.office365.com
 (2603:10b6:803:42::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.15 via Frontend
 Transport; Wed, 7 Oct 2020 08:20:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT008.mail.protection.outlook.com (10.152.72.119) with Microsoft SMTP
 Server id 15.20.3433.39 via Frontend Transport; Wed, 7 Oct 2020 08:20:28
 +0000
Received: from [149.199.38.66] (port=39491 helo=smtp.xilinx.com)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1kQ4fw-0006Sr-3v; Wed, 07 Oct 2020 01:19:52 -0700
Received: from [127.0.0.1] (helo=localhost)
        by smtp.xilinx.com with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1kQ4gV-0006rh-QG; Wed, 07 Oct 2020 01:20:27 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp1.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 0978KPvT016340;
        Wed, 7 Oct 2020 01:20:25 -0700
Received: from [172.30.17.110]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1kQ4gS-0006oh-V9; Wed, 07 Oct 2020 01:20:25 -0700
Subject: Re: [PATCH v3 2/2] firmware: Keem Bay: Add support for Arm Trusted
 Firmware Service call
To:     muhammad.husaini.zulkifli@intel.com, adrian.hunter@intel.com,
        michal.simek@xilinx.com, sudeep.holla@arm.com,
        ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     lakshmi.bai.raja.subramanian@intel.com,
        wan.ahmad.zainie.wan.mohamad@intel.com, arnd@arndb.de
References: <20201006155549.3595-1-muhammad.husaini.zulkifli@intel.com>
 <20201006155549.3595-3-muhammad.husaini.zulkifli@intel.com>
From:   Michal Simek <michal.simek@xilinx.com>
Autocrypt: addr=michals@xilinx.com; keydata=
 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
 0Z1MQlmNcq2bhOMzTxuXX2NDzUZs4aqEyZQ=
Message-ID: <4677c614-ac00-fb69-d22c-54f9015249f4@xilinx.com>
Date:   Wed, 7 Oct 2020 10:20:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201006155549.3595-3-muhammad.husaini.zulkifli@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fd81aef2-f846-45d0-9b96-08d86a99d950
X-MS-TrafficTypeDiagnostic: DM6PR02MB4812:
X-Microsoft-Antispam-PRVS: <DM6PR02MB4812CB5EAA66D93A28658569C60A0@DM6PR02MB4812.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vVa+YgFUOc8gUUmHEOUV4/WNNNyacUpcT6b/u7AdSJ77aYA8Tg33SvNhNWu03+Cn9qc2iz4zBT28vir1ujSfq8JGaWIBr+oV3YITlU2twVzninnltrOKezWKeeqYFyLhlgU+vqpe3sshepfc83eT906yNldQu/gCEmU98zabS+TtUhgem3QIl4YcIvJAVUgFZKt/mllwcNCajy59sRmPtC8RQCo7P8E+yb9G1V2blors0bPNARV8Egz4kIGqqeA8r4wQ4r0anVsPquw5gfizh5PWsSZfxn1vEV3SC6uNz2i13wuhV9FLu4VslwGc98ISl8d4RysxFQxXrFdfc+/hjor5HutgI9Ot+sqocxGVuH0WLT3btESWOks0Kw4jVJCi/85oISZVWxABZ2Z8opicT0bfWqWQY/NMV1jnFtD+mNhekBb4PT+3gzWh4lltrPtD
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFS:(396003)(376002)(346002)(136003)(39850400004)(46966005)(70206006)(2616005)(6666004)(316002)(426003)(336012)(26005)(82310400003)(47076004)(31696002)(36756003)(83380400001)(356005)(81166007)(44832011)(70586007)(82740400003)(31686004)(478600001)(8936002)(8676002)(2906002)(4326008)(9786002)(186003)(5660300002)(7416002)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2020 08:20:28.1279
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd81aef2-f846-45d0-9b96-08d86a99d950
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT008.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4812
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

1. Keem Bay: in subject is wrong. Tools are working with it and you
should just use keembay: instead.

2. This should come first before actual change to keep the tree bisectable.

On 06. 10. 20 17:55, muhammad.husaini.zulkifli@intel.com wrote:
> From: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
> 
> Add header file to handle API function for device driver to communicate
> with Arm Trusted Firmware.
> 
> Signed-off-by: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
> ---
>  .../linux/firmware/intel/keembay_firmware.h   | 46 +++++++++++++++++++
>  1 file changed, 46 insertions(+)
>  create mode 100644 include/linux/firmware/intel/keembay_firmware.h
> 
> diff --git a/include/linux/firmware/intel/keembay_firmware.h b/include/linux/firmware/intel/keembay_firmware.h
> new file mode 100644
> index 000000000000..9adb8c87b788
> --- /dev/null
> +++ b/include/linux/firmware/intel/keembay_firmware.h
> @@ -0,0 +1,46 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + *  Intel Keembay SOC Firmware API Layer
> + *
> + *  Copyright (C) 2020-2021, Intel Corporation
> + *
> + *  Muhammad Husaini Zulkifli <Muhammad.Husaini.Zulkifli@intel.com>
> + */
> +
> +#ifndef __FIRMWARE_KEEMBAY_SMC_H__
> +#define __FIRMWARE_KEEMBAY_SMC_H__
> +
> +#include <linux/arm-smccc.h>
> +
> +/**

This is not a kernel doc comment. Just use /*

> + * This file defines API function that can be called by device driver in order to
> + * communicate with Arm Trusted Firmware.
> + */
> +
> +/* Setting for Keem Bay IO Pad Line Voltage Selection */
> +#define KEEMBAY_SET_SD_VOLTAGE_FUNC_ID	0x8200ff26

Sudeep: Don't we have any macros for composing these IDs?
nit: IMHO composing these IDs from macros would make more sense to me.


> +#define KEEMBAY_SET_1V8_VOLT		0x01

0x01 is just 1

> +#define KEEMBAY_SET_3V3_VOLT		0x00

0x00 is just 0

> +
> +#if IS_ENABLED(CONFIG_HAVE_ARM_SMCCC_DISCOVERY)
> +static int do_fw_invoke(u64 func_id, u64 arg0, u64 arg1)
> +{
> +	struct arm_smccc_res res;
> +
> +	arm_smccc_1_1_invoke(func_id, arg0, arg1, &res);
> +
> +	return res.a0;

I am not big fan of this error propagation in case of failure.

If smc fails you get via res.a0 SMCCC_RET_NOT_SUPPORTED which is defined
as -1 which is based on errno-base.h defined as EPERM.

That driver which Sudeep pointed you to is using EINVAL instead.

It means I would add a code to check it.


> +}
> +
> +int keembay_sd_voltage_selection(int volt)

as was reported by robot

> +{
> +	return do_fw_invoke(KEEMBAY_SET_SD_VOLTAGE_FUNC_ID, volt, 0);
> +}
> +#else
> +static inline int keembay_sd_voltage_selection(int volt)
> +{
> +	return -ENODEV;
> +}
> +#endif
> +
> +#endif /* __FIRMWARE_KEEMBAY_SMC_H__ */
> 

M
