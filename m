Return-Path: <SRS0=N9dB=5P=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82EECC43331
	for <linux-mmc@archiver.kernel.org>; Mon, 30 Mar 2020 05:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F64E20780
	for <linux-mmc@archiver.kernel.org>; Mon, 30 Mar 2020 05:41:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="tcS1zyAW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728630AbgC3Flo (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 30 Mar 2020 01:41:44 -0400
Received: from mail-bn8nam11on2083.outbound.protection.outlook.com ([40.107.236.83]:6077
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728607AbgC3Flo (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 30 Mar 2020 01:41:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nr6QoQxEO7f016Qx5yICPgByQn4vUBKGcVJfT0tJR7Qg8UFpdSgbWDwBHmfNdHnzg7l5W0B+kGWwt1viMxiCuHVfaNFMqlQyJZgwXr4T3a2g22fs8F7oWHmE/6WJQTge8JzBAIOMDm/iKJJPGW9PLS6d0TB39K/gb4xX034dUVJElRQPBPywKQfC+j4f1mjxeBCezk/aIooHaT2gRBW4au9YhWkCaUf9ZpqYv0Hmkve5ck5Prn82awVB5hwt0Y9XbwLg+agGn3SbsaW1bVIqhMRiodZWqdZucvjnCmnwaoKuLxMBs6oWvLZhyrvqbPkLXGMiOvYyt6tNP5yJ3/KnKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=12AN7TBBvRxGaNwfMhxG4pxwd9twOMSP+/RvRJldvrA=;
 b=krHYrTcbrAr37dqSGxgBOcCt+i2/GQT3d21K28wZqnwtwvEA28bz0oSEfUDmyjBM0dxWBJpCHJwXwfzpgq8aAntD3/WXS5AKLbIznvfxCQxqtMO2yHTYSXy51XuLiX3CTgKXgXgx5jcsf09oKcyinno9WXBv+GrCM+A4AbAVVB2Zb8shq9+RyaNW4O1Js3ehqnrSltAVJkq7GgoAi+FJcI0aWsl2yl1WIuzDTZyTDn1LI3FqVBJVGZPhXnhEJRC1FvoiLgWN8oZlbnVWzuNw8PwEl0oX1gWujYZWBz8/ctRo/grulpqziRRloHV9OuA65q74+QONs1DUCM+IHp8x1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=arm.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=12AN7TBBvRxGaNwfMhxG4pxwd9twOMSP+/RvRJldvrA=;
 b=tcS1zyAWQGGj/WpC756DbJlx0Bky5uChoKTYHDyzVOxpr3VX6vnHhdiEf8ABjTfttuv1W6VgHL4FX0euAdvTBMhEvWAEhJ1ongW7E/lDiPeSjevtUUSjFmx1DPHeJQpoRFlGl/rfNU+dwFlFWXdwWYravKYcKXyvyT+Yf0SrIcU=
Received: from SN4PR0701CA0038.namprd07.prod.outlook.com
 (2603:10b6:803:2d::31) by BN7PR02MB3955.namprd02.prod.outlook.com
 (2603:10b6:406:f0::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Mon, 30 Mar
 2020 05:41:39 +0000
Received: from SN1NAM02FT012.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:2d:cafe::4c) by SN4PR0701CA0038.outlook.office365.com
 (2603:10b6:803:2d::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19 via Frontend
 Transport; Mon, 30 Mar 2020 05:41:39 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT012.mail.protection.outlook.com (10.152.72.95) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2856.17
 via Frontend Transport; Mon, 30 Mar 2020 05:41:38 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1jInB4-0005gm-Hk; Sun, 29 Mar 2020 22:41:38 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1jInAz-0003FY-EB; Sun, 29 Mar 2020 22:41:33 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1jInAp-0003Cp-Li; Sun, 29 Mar 2020 22:41:23 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id D7087121267; Mon, 30 Mar 2020 11:11:22 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        adrian.hunter@intel.com, michal.simek@xilinx.com
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        git@xilinx.com, Manish Narani <manish.narani@xilinx.com>
Subject: [PATCH v2 0/4] Add support for Xilinx Versal SDHCI in Arasan driver
Date:   Mon, 30 Mar 2020 11:11:15 +0530
Message-Id: <1585546879-91037-1-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(376002)(396003)(136003)(346002)(39850400004)(46966005)(6666004)(6266002)(356004)(316002)(2616005)(42186006)(336012)(426003)(8936002)(107886003)(186003)(4326008)(4744005)(6636002)(44832011)(81166006)(81156014)(5660300002)(36756003)(82740400003)(70206006)(478600001)(70586007)(2906002)(47076004)(26005)(8676002);DIR:OUT;SFP:1101;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf1f576d-198c-4eac-a033-08d7d46d049f
X-MS-TrafficTypeDiagnostic: BN7PR02MB3955:
X-Microsoft-Antispam-PRVS: <BN7PR02MB39554C40DA157847897DF52CC1CB0@BN7PR02MB3955.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 0358535363
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wh4VNKvFtAg6A8D38vzgP+LC83hNcyQf3TzeUj5p+2jCw21ULYULXXH4ZSHCVBVz3rVrHb9P5GgQLCa4LS4QWHnI7LMmALIBjOEgJzn9oXEbu6+gKLRISXjoooqBrxIea4NnkJQ5CnsZY/lv+luQykm359NQiInsMTf9x3SjaP143c5BjSrMSEFn3HFaeB0Qh5SVUJoJpD4lPHq43UC0PV9/Tz2xPTJfrglhoWMHQPfHIA896kwtDNJtCn5/T3ZTTBUaiQ/nSiH05H5o06Ir9Lcu30ANk/RkmDfWh1PivdMo5u4cm0TyWGFSydWYO8OtJ0U9gYr19wjlxMDjKj0r/srqlwQkaL5QEPBtGRC75HC3x3xmwuwtzrLAQFfovOof9RO+InyBujiHSeTQFw54tlmXJmCZqTnN1BDtHPvDBKRt8TjyRYFPnL60gfmlgu3QHXzzHoolMLn1yFAGvbOEpYeySZurtyk+8AVOD2fkvQ+68tClDqE66Pw/UNlNiiCXqIEaqC9bCT61z2xDuXofeQ==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2020 05:41:38.9188
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf1f576d-198c-4eac-a033-08d7d46d049f
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR02MB3955
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This patch series includes:
 -> Document the Xilinx Versal SD controller
 -> Add support for Versal SD Tap Delays
 -> Reorganizing the clock operations handling
 -> Resolve kernel-doc warnings

Changes in v2:
	- Addressed review comments given in v1
	- Changed clock operation handling for better modularity.
	- Changed comments to fix kernel-doc warnings

Manish Narani (4):
  dt-bindings: mmc: arasan: Document 'xlnx,versal-8.9a' controller
  sdhci: arasan: Add support for Versal Tap Delays
  mmc: sdhci-of-arasan: Modify clock operations handling
  mmc: sdhci-of-arasan: Fix kernel-doc warnings

 .../devicetree/bindings/mmc/arasan,sdhci.txt  |  15 +
 drivers/mmc/host/sdhci-of-arasan.c            | 473 +++++++++++++-----
 2 files changed, 361 insertions(+), 127 deletions(-)

-- 
2.17.1

