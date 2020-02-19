Return-Path: <SRS0=5cIg=4H=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE687C34050
	for <linux-mmc@archiver.kernel.org>; Wed, 19 Feb 2020 12:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C727F24677
	for <linux-mmc@archiver.kernel.org>; Wed, 19 Feb 2020 12:28:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="S8PEUFSC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbgBSM2u (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 19 Feb 2020 07:28:50 -0500
Received: from mail-mw2nam12on2081.outbound.protection.outlook.com ([40.107.244.81]:38650
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726491AbgBSM2u (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 19 Feb 2020 07:28:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eDKwHAOkR+LJg2dSDMNF3Hn7O4/wqqrh8nlp5yLr71ZzYzcOOffiio5JbZKyPv54SA5hDXnZRzJ7ANGyAjRK1dKe7Up/LJkcrcGd4oaSnKVnHS9kvbUoFpINLuKqI40z/jrYIcsGFSTM++7dnI/D5pUWHkgnj4In3hme6a9OkSs9cnAucOUJXdkPcRK8IA2Y/dZh8/p5jgPv8ZGugAWHxiTaeiKs44EAhpFWxrKi2ds5OfIO3Dp35MJga3YG5IsTX61/6JsWOznV87qlUc0BtNKJDefFmzEFjlJXmU+MALJxHkF2XzVwK6KnWTq3rogJaY14Pb0OKrH97znQKn1LsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E58wuQu/fKXuTAg0heh2qA0UF98tN3F9EFXdgWH5mOc=;
 b=XnC54JcX+dBL4RUms/uK6Dclr72IlwxVEleBDfjGeJg2fLKdxFAr+G7mz3jlznjrXbdpm9oOLEZLpQ7zUOajAWgavRfAXb07bMX8qA+i8nGaXx+Hs0xoxEanpUz4fBYH9aJjaPVEcCAdBWyf1X9CF3cyVrxsNBwU4A/H3H++q8FeWOz3T3Ec5hnsYAtkyYRBfwBEp0NFj0aBZnCo65Q7w4GFc9YB0q2E7oZG7wGYaN7zzm/pUfkCfeuD84cP3xK25jfnntlmP3+QeA2XWzDolVlEuNjKSzIH+d5tKmHkyURNzI9USWCVfvM4rAfwUKEgMk5MBh9TCUWQ0lz5j4XadQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E58wuQu/fKXuTAg0heh2qA0UF98tN3F9EFXdgWH5mOc=;
 b=S8PEUFSCRgBUFZPn+VcViIP6eYLa8xaiJVI77BinbSHfuEh36yylvEoycw2EFVwIiCY2ZMZ66lQ52EXoui+6zset3pi2c2s59D0cDAFdkOSQOo/DmCY9fQpvBn95aRRm/geB3BWsKcDH+d5F7GttWOr9m7aJl+GK0Q95jJTOtJ0=
Received: from MWHPR02CA0010.namprd02.prod.outlook.com (2603:10b6:300:4b::20)
 by BYAPR02MB5125.namprd02.prod.outlook.com (2603:10b6:a03:67::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.24; Wed, 19 Feb
 2020 12:28:47 +0000
Received: from BL2NAM02FT060.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::206) by MWHPR02CA0010.outlook.office365.com
 (2603:10b6:300:4b::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend
 Transport; Wed, 19 Feb 2020 12:28:46 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT060.mail.protection.outlook.com (10.152.76.124) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2729.22
 via Frontend Transport; Wed, 19 Feb 2020 12:28:46 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1j4OT7-0006bu-PM; Wed, 19 Feb 2020 04:28:45 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1j4OT2-00064S-Lk; Wed, 19 Feb 2020 04:28:40 -0800
Received: from xsj-pvapsmtp01 (xsj-smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 01JCSdA1016691;
        Wed, 19 Feb 2020 04:28:39 -0800
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1j4OT1-00064F-2Q; Wed, 19 Feb 2020 04:28:39 -0800
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 419FE1211E6; Wed, 19 Feb 2020 17:58:38 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        michal.simek@xilinx.com, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        git@xilinx.com, Manish Narani <manish.narani@xilinx.com>
Subject: [PATCH 0/2] Add support for Xilinx Versal SDHCI in Arasan driver
Date:   Wed, 19 Feb 2020 17:58:31 +0530
Message-Id: <1582115313-115667-1-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(39860400002)(396003)(376002)(136003)(189003)(199004)(6666004)(356004)(81156014)(2616005)(8676002)(70586007)(4744005)(81166006)(316002)(186003)(4326008)(36756003)(44832011)(426003)(70206006)(5660300002)(8936002)(26005)(6266002)(336012)(107886003)(2906002)(478600001)(42186006);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB5125;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b5ce6b66-751b-43cf-a295-08d7b537440f
X-MS-TrafficTypeDiagnostic: BYAPR02MB5125:
X-Microsoft-Antispam-PRVS: <BYAPR02MB5125BF2ABB8D9E8E5215FB48C1100@BYAPR02MB5125.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-Forefront-PRVS: 0318501FAE
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MRDCwsPLHXh7wmv9/C3lafIJal37aXotrPbphuVfqbxqxuCZ+F4bP6uddneRCkRxCR9MyF1DGtZKO+/cgIX6ApMMPPNblcz/QbnftSeonkkDQHR2vn8UGTxfMRbAiLSWFKW/t51uf23leNs2WvcdqYZmaNrfPeN3AFG1jLcKdzSn64I88id77K1b6cxTpxWXYopmsVi2j38vdQ8xwbxDH/iaL8j+x/UUmD5VdC3idFEuwTHThSaMVYJGB2EwsOiUQgp69XOLHkSBuKkoYVAIR537nmag62nO9ts5YB61ltE1hJwC2X9BvABImggLs0l7G0T+/fh3A5YafyaQI6DC5AhFYsaIJ9CRdVHA3PTWaUVUXJ7SKZfJl2KErEtSVuPHPB3DvbJ0DSacJICvrXG0eGdtfYz7R2cBqDAdF5ptfFWmspNuDJKuIXpI9TNeeQUJ
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2020 12:28:46.4187
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5ce6b66-751b-43cf-a295-08d7b537440f
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5125
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This patch series includes:
 -> Document the Xilinx Versal SD controller
 -> Add support for Versal SD Tap Delays

Manish Narani (2):
  dt-bindings: mmc: arasan: Document 'xlnx,versal-8.9a' controller
  sdhci: arasan: Add support for Versal Tap Delays

 .../devicetree/bindings/mmc/arasan,sdhci.txt  |  15 ++
 drivers/mmc/host/sdhci-of-arasan.c            | 176 +++++++++++++++++-
 2 files changed, 189 insertions(+), 2 deletions(-)

-- 
2.17.1

