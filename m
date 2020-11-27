Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D6DC2D0E4
	for <linux-mmc@archiver.kernel.org>; Fri, 27 Nov 2020 07:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15DBF21D81
	for <linux-mmc@archiver.kernel.org>; Fri, 27 Nov 2020 07:12:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="ezEUj0pU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392686AbgK0HMd (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 27 Nov 2020 02:12:33 -0500
Received: from mail-co1nam11on2089.outbound.protection.outlook.com ([40.107.220.89]:5472
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730898AbgK0HMc (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 27 Nov 2020 02:12:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R10wp5vRfF3Mt6Qg24GxKgfQCsYJYnMSUumSYFT3gvVIw5Ap+D1+c45Kv3Glal+Z7P25xyFIjH2QmdK+7srn7XdtYRja8xnxt8uX/wbhAs7C/g5eo1IIihF1xixlgB56oLpmOKkhQKArrrS7rYg7LSViUNt2WdHpB+dgIJfAkH6jAL0g2+wXJFTbkPNcmKfAOpKoa5jFRB3/nyPgGjqh6ceFkz7UzMxUw/JroV0XXhdlOp9lmIMfV1QRo+o5/JmGF3RtVOEuw8qIBYRrRenLntpgpECCZjmfxdSon+SSZIcrwpZymsbPKpTF2tg5QmtsLdsJHTM5yA/I9krelmF6Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4BTUJml5kghztAk3D5KYz1DBk66bQ5bghfq0rkmPaCU=;
 b=fijgP50gNvswX+EkWtWT+mwqcUYgk3hGjxM7eVyRFr5CR3RQNYE3mDImxTb9lgrGB4xgUo35XEv0B2vkKFYp+F3dy0XgJ/CVi/M2VcH1T6+a31l7lmUddlaS7ZL592RQXOtKk17KGuWD2BZWTMBWO+cNfn8MzB7OlTLBbwSH6aM2IGhU+PgM1qgSC3BQfnhSR6jg3+RvOBs6wmwTujeFLmEwwM98Cxl+SyjOlbitjAT2MWvFR9QRIcy/jzcDixMzIFu/UNBMdExh+dHXTOnkgpYDrJxEDYMg219ff/H/sVuv7VV07ooMd/dKtjLJY5oND1cj6POjDu0ZwDwXrBhn9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=linaro.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4BTUJml5kghztAk3D5KYz1DBk66bQ5bghfq0rkmPaCU=;
 b=ezEUj0pUeZtssxUQ+PFXcMG4RisszlRVPEVVXs5M6tuG5uIynf7MnicuCc8j6crqxYB9TzoIC/eAcPummJ5/iAem9uYzvWeEGsgqxuO0zxgg2DQ8kR/LHvZ/ZMtVjnI262eUOVrba1rtBXYGIVUIG4JTY4t5h3y6R0lvWFSGS2o=
Received: from MN2PR15CA0060.namprd15.prod.outlook.com (2603:10b6:208:237::29)
 by DM6PR02MB6396.namprd02.prod.outlook.com (2603:10b6:5:1fc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.23; Fri, 27 Nov
 2020 07:12:28 +0000
Received: from BL2NAM02FT025.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:237:cafe::58) by MN2PR15CA0060.outlook.office365.com
 (2603:10b6:208:237::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend
 Transport; Fri, 27 Nov 2020 07:12:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BL2NAM02FT025.mail.protection.outlook.com (10.152.77.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3589.20 via Frontend Transport; Fri, 27 Nov 2020 07:12:27 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Thu, 26 Nov 2020 23:12:12 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Thu, 26 Nov 2020 23:12:12 -0800
Envelope-to: git@xilinx.com,
 michal.simek@xilinx.com,
 ulf.hansson@linaro.org,
 adrian.hunter@intel.com,
 linux-mmc@vger.kernel.org,
 pthomas8589@gmail.com
Received: from [172.30.17.109] (port=54868)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1kiXvP-0005ku-9d; Thu, 26 Nov 2020 23:12:11 -0800
Subject: Re: mmc: sdhci-of-arasan: Issue DLL reset explicitly
To:     Paul Thomas <pthomas8589@gmail.com>, <linux-mmc@vger.kernel.org>,
        "Michal Simek" <michal.simek@xilinx.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Ulf Hansson" <ulf.hansson@linaro.org>
References: <CAD56B7cpMcuu_+9bxQ0zCsr489J9Te268aOeQTC32rOeF1hG+A@mail.gmail.com>
CC:     git <git@xilinx.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <9e5da13d-cb0d-3190-11d1-556d05178966@xilinx.com>
Date:   Fri, 27 Nov 2020 08:12:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <CAD56B7cpMcuu_+9bxQ0zCsr489J9Te268aOeQTC32rOeF1hG+A@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ad3916ad-c132-410a-f1dd-08d892a3cc78
X-MS-TrafficTypeDiagnostic: DM6PR02MB6396:
X-Microsoft-Antispam-PRVS: <DM6PR02MB63967D6D12A56749B9D568B0C6F80@DM6PR02MB6396.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lv9D46M4NyKtHuK+tVcItJtdkJv1Yogl4jejWET2WxgDYxdOrNiJziCMR0QewvORWentmSRSFG+dRjJZfOhQKNZMdwk9guq27pFCIHM0GaNX8OcqKVfqQWY+Nia4QHccW2ESRNdCVs40QvxDHAuvzFPIeqRx0c1slO1nLQJ1Z8sXFF+4LthCnc08u9ybQ/VJPmDEqLlNoHf+rzNkuWE2Wbkl8OtC8I0NBowLvRbcftbVtV9/lk9xkTa50CCifQ5RdhjFiHczO/7rPXir2ZOa4KGaHur5m3SohsVIxRv46O3zRoGMMMsVjHY4dmflb5W0HxsEawiBgn4ddCeXYhCsbjXryMvq85GTKKadwGAEeg6W8yjY7aMRWv1wrXTb2Gaw6Wn9pz0BzZYgZIL4gv923ksMHcMftfSyB3ABi0BTF9Kv5YyvIaSHNv4piXKnu3WxxdLvwrJTvQmzqncMgjOLDncttc21vuBiDx3dW5Ha63Yul5TNvrcGUmuVRerHGSjf38M+HvxjsPMfDyLrkbixYg==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(136003)(39860400002)(396003)(376002)(346002)(46966005)(70206006)(8676002)(70586007)(31696002)(8936002)(107886003)(47076004)(44832011)(6666004)(5660300002)(7636003)(316002)(356005)(83380400001)(36906005)(110136005)(26005)(336012)(82740400003)(4744005)(31686004)(966005)(2616005)(2906002)(9786002)(186003)(478600001)(426003)(82310400003)(4326008)(36756003)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2020 07:12:27.9308
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad3916ad-c132-410a-f1dd-08d892a3cc78
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT025.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6396
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Paul, +Manish

On 27. 11. 20 4:49, Paul Thomas wrote:
> Hi Everyone,
> 
> The recent commit d06d60d5 'mmc: sdhci-of-arasan: Issue DLL reset
> explicitly' seems to break the eMMC on our zynqmp boards, we get
> messages like this:
> mmc0: error -110 whilst initialising MMC card
> We're using the XCZU2EG-1SFVC784I parts [1]. I see that this is moving
> the DLL reset out of ATF. So part of the issue might be that we're
> using the 2019.1 ATF version.
> 
> thanks,
> Paul
> 
> [1] Enclustra modules:
> https://www.enclustra.com/en/products/system-on-chip-modules/mercury-xu5/
> 

Can you please try any latest version if that fix your problem?

Manish: Please take look at this issue and try to replicate it.

Thanks,
Michal
