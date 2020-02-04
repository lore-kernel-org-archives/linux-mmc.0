Return-Path: <SRS0=92ZL=3Y=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C9F0C2D0B1
	for <linux-mmc@archiver.kernel.org>; Tue,  4 Feb 2020 11:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E781C20730
	for <linux-mmc@archiver.kernel.org>; Tue,  4 Feb 2020 11:42:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="E3SJUBhx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbgBDLmX (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 4 Feb 2020 06:42:23 -0500
Received: from mail-mw2nam10on2073.outbound.protection.outlook.com ([40.107.94.73]:62561
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727090AbgBDLmX (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 4 Feb 2020 06:42:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G8Ba+SaHTWikRDYm8eKaEfkxUcvTDec3P8j2nBC7HI5xzWvswUXiVUz3g7sCtum9cWhhcl7uLn0hId/zcHaJN+ytatXk/rNmnOOdOrT9QAU4ADklYA6pEKkMuJyn9h36FME7dihmZNC3NrrTlsG7h+iQC4300JQmoaaFsBEJfjMNylMb1NJKbjDD4NCkrerlrMvP1w55USVFt5k3iP2ea+hRvOHrlVuaTQhCM7jjVXFELdLNETaRn3Yy1bgC7vSiWZcKyyF4Qz9Jva8VBJc6J+nBORMf5j+BrP3RJGN7n1SXoYBkz1EsRKsG+dfyHumP2wWvO2gZMsjEmeNCk1JLqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/cS22fnWaVy8Pq1+U8ogdSiAxzLC4chXId3BGsU8CwM=;
 b=Tia7+okaFfts6KZtKs03bafhRm8U1T4INtBdbvuqH9Xe4Hxasw0R77OUQzGZDW8JcYbsUF78b82I54kIPSUr2s1Ok5Sn8e833Bwd4T+yEqYTJ6B8MscjoZsavn2ZlOL3frxSmYUAhnwQ2HpFbWusdhbECnS9xkzj7RgZbGHV7q0C8f9/zPUgCtJcSz466Czl8qKUodC7MFq3gBehNa1RkZt7dOLa/OIj6E8cG9m5MNbESx0NuhmhV029V6W3l1KnfZeZuu8OJvGgvs11flCO3WnQM36wEveAUqOSujrvRwBaQSewhsGDgNZIDskzBMhC8KHXAQ+yT3ZI3AIUwLPZ+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/cS22fnWaVy8Pq1+U8ogdSiAxzLC4chXId3BGsU8CwM=;
 b=E3SJUBhxyT5P6ynUNjgTxesFl7M2mu0NutdrSQsHZ4GJr7RvMiA9tX8hgyjfHwDioMkfkky72ao5WuGALEg2SyEDyjSjsOQKz4kSJot38NZFlqZAX6yceiaS7JhYoWGgwEDy1lhAsaEXLg+9P2evm9LIa7l2qaCvds3IVawgmpg=
Received: from CY4PR02CA0047.namprd02.prod.outlook.com (2603:10b6:903:117::33)
 by SN4PR0201MB3597.namprd02.prod.outlook.com (2603:10b6:803:45::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.32; Tue, 4 Feb
 2020 11:42:19 +0000
Received: from BL2NAM02FT047.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::208) by CY4PR02CA0047.outlook.office365.com
 (2603:10b6:903:117::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.30 via Frontend
 Transport; Tue, 4 Feb 2020 11:42:19 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT047.mail.protection.outlook.com (10.152.77.9) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2686.25
 via Frontend Transport; Tue, 4 Feb 2020 11:42:18 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1iywaw-0000V0-6t; Tue, 04 Feb 2020 03:42:18 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1iywar-0008T6-31; Tue, 04 Feb 2020 03:42:13 -0800
Received: from [172.30.17.107]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1iywaj-0008Nh-H4; Tue, 04 Feb 2020 03:42:05 -0800
Subject: Re: [PATCH 4/4] sdhci: arasan: Remove quirk for broken base clock
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Manish Narani <manish.narani@xilinx.com>,
        michal.simek@xilinx.com, ulf.hansson@linaro.org,
        jolly.shah@xilinx.com, rajan.vaja@xilinx.com,
        nava.manne@xilinx.com, tejas.patel@xilinx.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
References: <1579602095-30060-1-git-send-email-manish.narani@xilinx.com>
 <1579602095-30060-5-git-send-email-manish.narani@xilinx.com>
 <99fd3904-37fa-f070-f7ac-e1dcb5bf43de@intel.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <0d7e7a44-91dc-baef-5dcf-4ff683e98581@xilinx.com>
Date:   Tue, 4 Feb 2020 12:42:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <99fd3904-37fa-f070-f7ac-e1dcb5bf43de@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(346002)(39860400002)(136003)(189003)(199004)(6636002)(26005)(44832011)(426003)(5660300002)(2616005)(31686004)(8936002)(8676002)(110136005)(316002)(81166006)(81156014)(31696002)(356004)(6666004)(70586007)(70206006)(9786002)(4744005)(336012)(53546011)(186003)(478600001)(36756003)(2906002)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:SN4PR0201MB3597;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ec9219d4-353f-4cd4-6c09-08d7a9674a4d
X-MS-TrafficTypeDiagnostic: SN4PR0201MB3597:
X-Microsoft-Antispam-PRVS: <SN4PR0201MB35975CB8BDD94906FD7A4D60C6030@SN4PR0201MB3597.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-Forefront-PRVS: 03030B9493
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AtZ3l6fEs1pW/zp+IIuEkwLS6ssCW3p7bBtJq5TUNfXkvrQppKDlIG3xzV7ggEhP3Icy5pZ90gWhR5mjwagRKmmkPnvhukiDv/sXAWgu975b9UVRVpTbtn59IY5Xh+4YjxJow21U+zT1ovEA+AcTxqohX/sIOj6CPFy5QghuUMJdUjLwDbat1Nhn4t5VxB6w8fo3eZWDcmtSKO54vQWk6V6Lel7/PD9TlfJANMDFtfOJp5rMrXarxpNs95uKJodXAaL2uBA1HEit0PbVFlwmQoJWJ0v41RJxJGDpwKr0JqK7Gv3l51A7ZU1nHeRYTijY8PX8pau2n0KMBwGXPNnl8ZMaKIqC22b8r0JwcLFakF+vegfin5oK2gs8mK2krW0WTW6dvEBt585g5HM7xwEmrfXWjrjBKchopMBdmJHBqDScFkeumatV1UzNPzIsIkfm
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2020 11:42:18.7756
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec9219d4-353f-4cd4-6c09-08d7a9674a4d
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0201MB3597
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 03. 02. 20 12:31, Adrian Hunter wrote:
> On 21/01/20 12:21 pm, Manish Narani wrote:
>> This patch removes quirk which indicates a broken base clock. This was
>> making the kernel report wrong base clock of ~187MHz instead of 200MHz
>> even as the measurement on the hardware was showing 200MHz.
>>
>> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
>> State: pending
> 
> Huh?

It shouldn't be here. It is internal patch labeling.
Manish: Please send v2 with all lines you got and remove this above.

> 
> Otherwise:
> 
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

These patches requires firmware changes. Feel free to take it directly
via your tree. If you want me to take it via arm-soc tree please let me
know.

Thanks,
Michal
