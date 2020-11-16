Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DB58C64EBC
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Nov 2020 15:06:07 +0000 (UTC)
Received: from vger.kernel.org (unknown [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB3862419A
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Nov 2020 15:06:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="BJfunxCF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB3862419A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-mmc-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731346AbgKPPFk (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 16 Nov 2020 10:05:40 -0500
Received: from mail-dm6nam10on2081.outbound.protection.outlook.com ([40.107.93.81]:5793
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726236AbgKPPFj (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 16 Nov 2020 10:05:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IrOOis2ZkaEHVqGyP46wqh8BzQPnXmnbd58uut3rlYsdTIldM3KdFbbqUpiZCVdYd6JHacqcB+7dOH2C5CiAED1kwbC9AYf+GpWMdKcq1MGGSGK+XDke9nHnNI4cF/o43HxeqclouvKFksZbMQcrpekO5ppaduPlWWV331IQF5tj3lJdnw5wz9jiyIs8KQ2m5M4O/VGyXwsfDfPoMHQRx7YVsTnWFRNpEnjUvqAPPEX26jzkBMXyjy04xRHeCfa+c4U0C6uBUgeiNib8GI3zvXzqNsRPSAUHuXetBi6VEzGsHvw4vMbfrCg2UTuOo9RWxJ+sxurF0FZqvOgpEaBidw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D7umkqjbdYDKpjowREvP/18S9JrCnKsNmu0VXpmSDKg=;
 b=cTYqmLS4Zx65rM8QHhDIPwR+Nt6oEq/1Vwo55IdIqZRXuKyfNgrxdHmeo9cWJegTumzrmp6pEjes27HVkCityFvXO/Or4QWJXuU8QBketu5oyM1FTMgcMuXYo5lRKK7ljvg78CG7RFWEc6YDTlO8lFVitKr0V9M8gfRQagxtOmLk/nvgdKRLssK1/Kx0lU0oxQNUvJJLzEEQcsiRq1LzwwlfotAHpA2aOYn0JGpRN/HdS8BZAjTvZubJSvlUAP3GH9VqdRWeJCd81T6yItCTER+UiCiwx0ZwV5LPOz0eLyNOp/YvJ8ZhVXQysS4iL8l2K0OXr9LZd+1CyFxav1NkbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D7umkqjbdYDKpjowREvP/18S9JrCnKsNmu0VXpmSDKg=;
 b=BJfunxCFPReUnuLnZGQlB1E5CQyuJqUNT3ljZaUGNFU8kDc51AK3gMcwOem0IoRpcPrL7z8AIpU6IyIlLs1CAocOuU6iK0RUH+GeydhfYDGn79GLvntkXy6apm9gweTRAZB/242AO48Sb76A7s+L6hpyiRwwdj1Wm6/PjarkHQg=
Received: from MN2PR19CA0052.namprd19.prod.outlook.com (2603:10b6:208:19b::29)
 by MWHPR0201MB3515.namprd02.prod.outlook.com (2603:10b6:301:7e::36) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25; Mon, 16 Nov
 2020 15:05:35 +0000
Received: from BL2NAM02FT015.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:19b:cafe::65) by MN2PR19CA0052.outlook.office365.com
 (2603:10b6:208:19b::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25 via Frontend
 Transport; Mon, 16 Nov 2020 15:05:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BL2NAM02FT015.mail.protection.outlook.com (10.152.77.167) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3564.22 via Frontend Transport; Mon, 16 Nov 2020 15:05:34 +0000
Received: from xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Mon, 16 Nov 2020 07:04:16 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Mon, 16 Nov 2020 07:04:16 -0800
Envelope-to: git@xilinx.com,
 michal.simek@xilinx.com,
 linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 ulf.hansson@linaro.org,
 adrian.hunter@intel.com
Received: from [172.30.17.110] (port=50904)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1keg3D-0003NE-K8; Mon, 16 Nov 2020 07:04:15 -0800
Subject: Re: [PATCH v2 0/3] Bug Fixes to Tap Delay code in SDHCI Arasan driver
To:     Manish Narani <manish.narani@xilinx.com>,
        <michal.simek@xilinx.com>, <adrian.hunter@intel.com>,
        <ulf.hansson@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <git@xilinx.com>
References: <1605515565-117562-1-git-send-email-manish.narani@xilinx.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <d757b5f4-bd5a-e73f-b171-7b18f544ee2f@xilinx.com>
Date:   Mon, 16 Nov 2020 16:04:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <1605515565-117562-1-git-send-email-manish.narani@xilinx.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c50d089b-09b4-44cf-08c4-08d88a4111e1
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3515:
X-Microsoft-Antispam-PRVS: <MWHPR0201MB3515E746D1DE5DB5AF8E6FFBC6E30@MWHPR0201MB3515.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h/i5Z874zvcxKZ/tVjXDyRx2sUVG/v+/3tcYSP2Okt9ob0I/AfHiRWYjS+beFDZpyLBDxfwmF/HV6VwqNqtJYH3HdiJif1lY5IR78PPVr88uFD7ztZdah88gwbvJNxrutRetW7XBcsHB8x2RgX+dhkly3wnD5K8Pj/ePQ0NSbX1gGJAW1pPmpFQue7d/kI5rBq/SxIekZNqaeqtjtKVO85OhyJ1nRpDPU/bBtgA96KVtIq7D+G6E1anHAqwVQQN+KOZakRkjwtK15gaPh1PYM94lwrNCUnTu684JiwClxpq8gGON/jCLpfVOSOl+KJ+5CMCdTjjCFIbMg27+AwsoltdCXDW2KMlyC6f3MILD0iH0GAZcQtu8JXfFWddj7+kH0F2Wd763nI9PvagVuml5LBeWXDd/v80pnWQsx2vGc99YKiK2bI1IpQDrR4OFwYVeQyzX0PGjITdf05ljSG54WKK7f9HUoK4wedy7mH9s3VaTtq4rcup/xdqA1SkxHR8cr0mwbPvh8TqafaPK51+y3w==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(136003)(39860400002)(396003)(376002)(346002)(46966005)(107886003)(31686004)(70206006)(966005)(36756003)(336012)(426003)(8676002)(7636003)(82740400003)(83380400001)(31696002)(47076004)(2616005)(4744005)(4326008)(478600001)(356005)(8936002)(186003)(9786002)(44832011)(70586007)(5660300002)(82310400003)(2906002)(54906003)(26005)(316002)(110136005)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2020 15:05:34.7974
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c50d089b-09b4-44cf-08c4-08d88a4111e1
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT015.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0201MB3515
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org



On 16. 11. 20 9:32, Manish Narani wrote:
> This patch set consists a couple of minor bug fixes for SDHCI Arasan
> driver. The fixes are for tap delay programming where in some cases
> tuning is failing for some of the SD cards.
> 
> Changes in v2:
> 	- Fixed the eemi_ops call issue by replacing to an API call
> 	  directly
> 	- Merged https://lore.kernel.org/patchwork/patch/1336342/
> 	  with this series of patches
> 
> Manish Narani (3):
>   mmc: sdhci-of-arasan: Allow configuring zero tap values
>   mmc: sdhci-of-arasan: Use Mask writes for Tap delays
>   mmc: sdhci-of-arasan: Issue DLL reset explicitly
> 
>  drivers/mmc/host/sdhci-of-arasan.c | 51 +++++++++++-------------------
>  1 file changed, 19 insertions(+), 32 deletions(-)
> 

Acked-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal
