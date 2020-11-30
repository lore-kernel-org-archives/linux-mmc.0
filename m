Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBCB8C64E8A
	for <linux-mmc@archiver.kernel.org>; Mon, 30 Nov 2020 14:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 598DC20656
	for <linux-mmc@archiver.kernel.org>; Mon, 30 Nov 2020 14:26:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="DoIGQlHd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgK3O0d (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 30 Nov 2020 09:26:33 -0500
Received: from mail-bn8nam11on2046.outbound.protection.outlook.com ([40.107.236.46]:50119
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726811AbgK3O0d (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 30 Nov 2020 09:26:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=anOLdqBl1Qnyy3gzreeSAJb1OklykwEfXWvd1Pm4XQcYT1UYvDt6JcQeuR8E0kGwXPt19PitnrGWJ/D9Ak1hy7pp003yDdd5AJssyMqSy0vATdxyrvn83Ihh1VOiLua0/KWTeOxRrkHX2F1SWyzSVju+ts3T6insASo8QxJuxdxa3eldetGxGeKzYhKMMXMeJc1LUFZAjN6JtRw7vUi5gJ41mX/k+SwohgVvFJps720us0aMpV6Kq911EylvGhUqM3L/cRDWwgqhCzPXcJa5LaaeUYoagfCmx3Hl8xv2GFQ8xUY8hSUyOzpb8zqCojyDzYB5ZD/vDGhvYeua3XKBHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EIsW9VE/qv6EBt2A3YAvX1CfJpB9VjWjRAXo6ePMvpU=;
 b=idxBcFGAbPJMZnJycA4vvCK1etB28dgpi0OybW5If/MOnYBvY+UxvfLx4OSu66juSVgwvyV6EKbW6gpwPtfewYKD+WfTCrCW/4PZVkOAm54iP2kuZstJFDE8BRnkt5/rmhlj0xtjSEoYQgeCtcwh78aYXmpkyhkBg2HnGed28OCXB5UHpISgoZ9b88wYHLKURUEVmhZvFBpIS7lMA9LDtpP7ZBvVQrpJai7tdv8iIouOHGZ01y2V8n69+m5IE2RBhFWm+IiYuHDkJ+BzH+eDC20r95C2HAo/gwgONQ/MfJZWRXWs7WMEOO21o1UOQEmkGGtpR8BmORavdW/PcWXQ4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EIsW9VE/qv6EBt2A3YAvX1CfJpB9VjWjRAXo6ePMvpU=;
 b=DoIGQlHdVMBUX3akC2vQm2dzu423FknatUODNMJWzwEl85aGUHAMZaFC1tSqS5iDo4+W1xvH5BAcnvIFPiiEbDM3P0S2WvfFgxRbY5Wikr3D6sn4VbSiJT8jU1uU0o0LWR3HzrTlbC1FRzN3/Zc1u2uCxXc7EDUqG/H49i85cXc=
Received: from MN2PR03CA0012.namprd03.prod.outlook.com (2603:10b6:208:23a::17)
 by BN7PR02MB4210.namprd02.prod.outlook.com (2603:10b6:406:fe::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.31; Mon, 30 Nov
 2020 14:25:38 +0000
Received: from BL2NAM02FT040.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:23a:cafe::77) by MN2PR03CA0012.outlook.office365.com
 (2603:10b6:208:23a::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend
 Transport; Mon, 30 Nov 2020 14:25:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BL2NAM02FT040.mail.protection.outlook.com (10.152.77.193) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3611.27 via Frontend Transport; Mon, 30 Nov 2020 14:25:38 +0000
Received: from xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Mon, 30 Nov 2020 06:25:37 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Mon, 30 Nov 2020 06:25:37 -0800
Envelope-to: MNARANI@xilinx.com,
 linux-mmc@vger.kernel.org,
 ulf.hansson@linaro.org,
 pthomas8589@gmail.com
Received: from [172.30.17.109] (port=34452)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1kjk7V-0008Na-4Y; Mon, 30 Nov 2020 06:25:37 -0800
Subject: Re: mmc: sdhci-of-arasan: recent commits
To:     Paul Thomas <pthomas8589@gmail.com>,
        Manish Narani <MNARANI@xilinx.com>
CC:     Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
References: <CAD56B7ffLtOBb5+conqGHymMr=xpROCrZm_7p_oPC-L7e5iX-Q@mail.gmail.com>
 <CAPDyKFrAu9B7Uuqp8=uFpOGBcsyDCcntg267bboyG4w_H76umg@mail.gmail.com>
 <BYAPR02MB5896061C9EEE0F95BDFD7287C1F50@BYAPR02MB5896.namprd02.prod.outlook.com>
 <CAD56B7cCqcBUjX9gJeo_S2BrLE4bTzc_nEouy88xQMsgpV3xSg@mail.gmail.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <0b3c8f99-db5a-b54e-0905-903af307cc05@xilinx.com>
Date:   Mon, 30 Nov 2020 15:25:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <CAD56B7cCqcBUjX9gJeo_S2BrLE4bTzc_nEouy88xQMsgpV3xSg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9c4cfd97-7e5f-4038-1548-08d8953bcf4d
X-MS-TrafficTypeDiagnostic: BN7PR02MB4210:
X-Microsoft-Antispam-PRVS: <BN7PR02MB4210F91AE11305E2C9AFB964C6F50@BN7PR02MB4210.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cQxHN/mH4k8tULIjM+oQiXhwikD2PNUklco6mmeWvnbsU7khwxdREuo/n/QcMbxs9e5VgBXGRGtH0W6cTb0bJ3XbgZF8ImFA/Iw2rXTxpClSmY8BIf/fudKl3eGTQ70J4iQwCbdz3HOV7c8DLNPkdlZSH7S3HOk3hx07cSxHdQ45+e3SpkxLupIRkJ25NQNmQ5uDXYoDJyQTytSeQ59FjbAGdHYJ+qQUiSFpObwRWJJc8mM9oXUExwVGZPw8DdT3kQFI+USnv67BTkr3DzMHbNAO3aqMhV9ZGgArAr6Ybj8FfUekxVczQIgvqTRYFIcwm+Tk5LfGO/SGhqBlPuL4mA+6UVtCc1hiW3Yknmp0gNOw+QTr/PDk3UpffdZyYFxf7E3UR9yYILbxvusNvbff8fgS9WMVNh+VlIL6vJHVq68srdPqS3RtOhybE4dQ6WO5XpZ8oJU+J5FJHojrvUu8W1FUtmYnRA81nLrQWedC1x9uj51PJymcH9jolMk+7rOzqEBIKSp+aW8etvu8pWjFOw==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(39860400002)(136003)(46966005)(6636002)(26005)(186003)(8936002)(426003)(70206006)(70586007)(44832011)(2616005)(9786002)(31686004)(82740400003)(53546011)(47076004)(2906002)(336012)(966005)(8676002)(5660300002)(31696002)(4326008)(110136005)(54906003)(316002)(478600001)(36906005)(36756003)(82310400003)(83380400001)(7636003)(356005)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2020 14:25:38.5060
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c4cfd97-7e5f-4038-1548-08d8953bcf4d
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT040.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR02MB4210
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi, +getting linux-mmc back

On 30. 11. 20 15:21, Paul Thomas wrote:
> Yes! This fixes it. Thanks.
> 
> -Paul
> 
> On Mon, Nov 30, 2020 at 12:18 AM Manish Narani <MNARANI@xilinx.com> wrote:
>>
>> Hi Paul,
>>
>>
>>> -----Original Message-----
>>> From: Ulf Hansson <ulf.hansson@linaro.org>
>>> Sent: Thursday, November 26, 2020 6:34 PM
>>> To: Paul Thomas <pthomas8589@gmail.com>
>>> Cc: Manish Narani <MNARANI@xilinx.com>
>>> Subject: Re: mmc: sdhci-of-arasan: recent commits
>>>
>>> On Wed, 25 Nov 2020 at 22:07, Paul Thomas <pthomas8589@gmail.com>
>>> wrote:
>>>>
>>>> Hello,
>>>>
>>>> I've been playing the the a 5.10 kernel, trying to do some real-time
>>>> testing. Anyway the recent commits:
>>>> mmc: sdhci-of-arasan: Issue DLL reset explicitly
>>>> mmc: sdhci-of-arasan: Use Mask writes for Tap delays
>>>> mmc: sdhci-of-arasan: Allow configuring zero tap values
>>>> Seem to break the emmc for at least some of our boards I get this error:
>>>> mmc0: error -110 whilst initialising MMC card
>>
>> Thanks for reporting.
>>
>> There was another fix in the firmware driver for the DLL reset issue.
>> https://lore.kernel.org/patchwork/patch/1338926/
>>
>> Could you please let me know if this was included in your build for testing?
>> If not, could you please test with the same?

This patch is the part of v5.10-rc6.

Thanks,
Michal
