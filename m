Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA54C388F9
	for <linux-mmc@archiver.kernel.org>; Wed, 11 Nov 2020 08:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 538F0206CA
	for <linux-mmc@archiver.kernel.org>; Wed, 11 Nov 2020 08:18:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="EYGs6QQJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725468AbgKKISV (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 11 Nov 2020 03:18:21 -0500
Received: from mail-bn8nam11on2081.outbound.protection.outlook.com ([40.107.236.81]:14145
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725860AbgKKISV (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 11 Nov 2020 03:18:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JwWXCQbZgbFBbyZJ3evw5OlJu6ckF1WO4rgkGbEqCou0nR70tUaOekziHdEYhyDEQ7jjbF/zEI8u11yBkwIzKa9NAjcRmtyXNDbIL8AcBwNrkVA6OtE6W2IcLtG04Jyj07TrIvm5mMXphH4tUypz6gagvUSMIuRyqAqDXeUM4HSIUu3wpCBU9gKiYm3UQ9Pop6vDS+YA5jYJZ2DsLwzPYaFra9fDcTf2yLdxFo9iHAENpyIQZyRgKHsRJyyIDedIKf9nqJNw1dJ4ZCloERsgd/K/GSHbcPanj/8DIrh1aDjd8eQDwrXv1s83NN6bu+9j3JZ4u9anjkh8U/unexxfjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U7KuCpsY11RCeRdLdaM+BCVygdUifS4UJ2uqSqFS/LU=;
 b=eFPDIwoapXr0GDPXbpfZ5U3qvEjbJ7Zp/Mh4v3X/SU40yatHmwevIIgt9DSXmikzrDp8BGtVvdCpV8LX7GX1n8/LS9Qs7M16sLibD5BfddimaM79I93EvDaOoJ3gV0K5o6+M+KZb+WyAm+xp+gElscbUx47E2OXyLZvAc86tYNhFRlvJvtMtPrGaTlo+cfltqOEO6cGabLH8hvehkXjhTvduJicQmOIdCE+/2QJekmWLEKVI2c4Y6EBn5zDe+uxy2ADqOWgP4uarVuHjpEIs5aQveJU37kouJfcgqhLgewb+slo0GLFiTyXM6nwynYFHzpgMxXp/kPcD1OhBIrZKjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=denx.de smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U7KuCpsY11RCeRdLdaM+BCVygdUifS4UJ2uqSqFS/LU=;
 b=EYGs6QQJsWgXM9nPpER3/UC0qv4GKYDO7EZm5daVr/dtL8HAdaWQFtszwjutP/j7mLxNAeRm2qWqhc9ZtFZNh0NWIZfdsT0wmi7KCT6sdclRgKVRrlPAUBn17ffjilIQLupuxNOC7FbUqZQiJ0LmtDfmm6MUHCk1G7+bnkWb0B0=
Received: from CY4PR22CA0074.namprd22.prod.outlook.com (2603:10b6:903:ad::12)
 by BYAPR02MB5944.namprd02.prod.outlook.com (2603:10b6:a03:124::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.24; Wed, 11 Nov
 2020 08:18:15 +0000
Received: from CY1NAM02FT035.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:ad:cafe::b1) by CY4PR22CA0074.outlook.office365.com
 (2603:10b6:903:ad::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend
 Transport; Wed, 11 Nov 2020 08:18:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; denx.de; dkim=none (message not signed)
 header.d=none;denx.de; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 CY1NAM02FT035.mail.protection.outlook.com (10.152.75.186) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3564.22 via Frontend Transport; Wed, 11 Nov 2020 08:18:14 +0000
Received: from xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Wed, 11 Nov 2020 00:18:01 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Wed, 11 Nov 2020 00:18:01 -0800
Envelope-to: git@xilinx.com,
 michal.simek@xilinx.com,
 marex@denx.de,
 linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 ulf.hansson@linaro.org,
 adrian.hunter@intel.com
Received: from [172.30.17.110] (port=33896)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1kclKK-0000Th-Tz; Wed, 11 Nov 2020 00:18:01 -0800
Subject: Re: [PATCH] mmc: sdhci-of-arasan: Allow configuring zero tap values
To:     Michal Simek <michal.simek@xilinx.com>,
        Manish Narani <manish.narani@xilinx.com>,
        <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <git@xilinx.com>,
        Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>,
        Marek Vasut <marex@denx.de>
References: <1605030122-52196-1-git-send-email-manish.narani@xilinx.com>
 <b04e5acd-d832-3bc5-d76c-24966045833d@xilinx.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <9be673d2-44dc-af04-6f44-f1ff84a1e19d@xilinx.com>
Date:   Wed, 11 Nov 2020 09:17:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <b04e5acd-d832-3bc5-d76c-24966045833d@xilinx.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db562497-3908-437a-add3-08d8861a55df
X-MS-TrafficTypeDiagnostic: BYAPR02MB5944:
X-Microsoft-Antispam-PRVS: <BYAPR02MB5944E503F4A751F68C6CE36AC6E80@BYAPR02MB5944.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rs7HNGp5Y6w1kHUg5XIhYfC1NMGX2uD1OnkRz1o0ytxXbfx5+jZfPfqT5G/ShOCkebmrSypEEPQdhMO62uNxQ9EizBYL7KnzABLsirNPtthi1IV+X/pyjNOcQ3RTCO4DBKIibobOah6usCtxMTB3+ULmETz7ZPqPLOGmcjRmq8JtZhyKuyPBoVl89UMIh0e46UWErKNMphFE0tEnoq00wNPtcn8xVMjnAAB2oyVkw79Um0J3UCRKZMhvP2F/rqnz6qIKTOBoE7q3gvQljmg4ITUR3+VtiuZUfvy4LmAWsMcylR/l8r1m1kEdAYkbjHg1ReiK27qXvG0RakYmvG0cMX8ut5gH8R53X6JGR7wROuhFrnpTB8QbG4s4Y+0iEHbSi3Lm+y7wYkQ/z8Mj3XXBo9KJCyw7QFetGJWjeG6H6dNg/MP3VBHN+fCWgkUy0X4T23qzHJgZ8yPukL0ZrhLBEg==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(396003)(346002)(376002)(136003)(39860400002)(46966005)(2906002)(82310400003)(336012)(8936002)(83380400001)(8676002)(186003)(26005)(426003)(36756003)(70586007)(31686004)(70206006)(47076004)(82740400003)(356005)(7636003)(54906003)(110136005)(4326008)(4744005)(5660300002)(6666004)(9786002)(36906005)(31696002)(44832011)(2616005)(316002)(478600001)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2020 08:18:14.0280
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db562497-3908-437a-add3-08d8861a55df
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT035.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5944
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org



On 11. 11. 20 8:59, Michal Simek wrote:
> +Marek
> 
> On 10. 11. 20 18:42, Manish Narani wrote:
>> Allow configuring the Output and Input tap values with zero to avoid
>> failures in some cases (one of them is SD boot mode) where the output
>> and input tap values may be already set to non-zero.
>>
>> Signed-off-by: Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
>> Signed-off-by: Manish Narani <manish.narani@xilinx.com>

Please add also fixed tag to get this to LTS kernel.

Thanks,
Michal
