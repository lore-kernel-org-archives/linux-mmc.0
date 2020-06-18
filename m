Return-Path: <SRS0=gCHa=77=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAACDC433E0
	for <linux-mmc@archiver.kernel.org>; Thu, 18 Jun 2020 08:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA02920B1F
	for <linux-mmc@archiver.kernel.org>; Thu, 18 Jun 2020 08:52:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="G7ACgFy2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728828AbgFRIw1 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 18 Jun 2020 04:52:27 -0400
Received: from mail-dm6nam11on2068.outbound.protection.outlook.com ([40.107.223.68]:6016
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728452AbgFRIwZ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 18 Jun 2020 04:52:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lFE9MirtL046gGRMAq9Dp/a2vK0SGIx5X11dKRCWT+8PFzpAccKuC9uAQE86+2uKEF9tL7n9FEQVlSbNP3F4nGuHsX1Rly96r1rAaByIcP8486UfZw5WfSckIzi9dlsH7R2jQqsy+v1FE67n5Eci8fwXghkEsD6BPxpz5bqU6YW6rKkTtWtg93V617F4iMLYkvXxYV9qcpoJZi/DWWRCE6SSYvy+m76KrG+b97p9Al297UMpwy/VKIUIQ4hf3vAQsGx70DPQkalkXqeOmeXwLrluBGBQWnR6iDadevr9u02B7EHKoCnO6VPd3wseCu8iiqXrX7w2ndWkoncwIJRmqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ffB1lzgZxCR1LCJC6OT09gnPCL0YmhbLBfU/MVyWW0U=;
 b=NSCLooCSDMQSQNFRwEVeD1Vz9w+QUmQXnB3agSAu4QBfk3iLKrNcw3n62E9gXqvd6JrrDkc9G6es9pG2hbym9S9tl1TWmL+YjF/LA27+9OdKU/OdUTzCTV17M4Az1XIy+3Hm53JrltnhLZb82Zp27cAxtgCJB+IDv6JPNi4G6aWAnpS+ba/WLJyj1dVTUaS9HiZHXbP9VB/ATjs2bRtGOCtbnL7tgiyNBk3ZvJc7GCqHk3KQJjBw4zREw2ozEt/cwx7hqPEj/56iI2VHkQIgv20NQvp3M654Yonxig5dUsxKEQPVlSPSlAPMeCkejGMU4DU5tQM5n+vabHJ9aEJHkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ffB1lzgZxCR1LCJC6OT09gnPCL0YmhbLBfU/MVyWW0U=;
 b=G7ACgFy2voLaUP9KIHD19nUpYVSAN3R/QQMEaxghJ7OZfClUSSACpkXzhbVqZAeQbrvdPCmnWbWJgudgzNmrbz2Lr7pwibP97UMCx+LbnEB7mt7UAxCQGUvhADfFWkM7rJnwgEQSZ+KLzsP2UIons2S/8CP7ChWevxwXzTOOim8=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=synaptics.com;
Received: from BYAPR03MB3573.namprd03.prod.outlook.com (2603:10b6:a02:ae::15)
 by BY5PR03MB5186.namprd03.prod.outlook.com (2603:10b6:a03:221::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Thu, 18 Jun
 2020 08:52:21 +0000
Received: from BYAPR03MB3573.namprd03.prod.outlook.com
 ([fe80::d1ae:8ea7:ea:8998]) by BYAPR03MB3573.namprd03.prod.outlook.com
 ([fe80::d1ae:8ea7:ea:8998%7]) with mapi id 15.20.3088.028; Thu, 18 Jun 2020
 08:52:21 +0000
Date:   Thu, 18 Jun 2020 16:52:07 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: mmc: pwrseq: Fix syntax errors in device tree
 examples
Message-ID: <20200618165207.512dc59f@xhacker.debian>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYAPR01CA0073.jpnprd01.prod.outlook.com
 (2603:1096:404:2c::13) To BYAPR03MB3573.namprd03.prod.outlook.com
 (2603:10b6:a02:ae::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (124.74.246.114) by TYAPR01CA0073.jpnprd01.prod.outlook.com (2603:1096:404:2c::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend Transport; Thu, 18 Jun 2020 08:52:19 +0000
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
X-Originating-IP: [124.74.246.114]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1585ed13-5909-4262-5368-08d81364e991
X-MS-TrafficTypeDiagnostic: BY5PR03MB5186:
X-Microsoft-Antispam-PRVS: <BY5PR03MB5186AA9928B0AA44FED50235ED9B0@BY5PR03MB5186.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-Forefront-PRVS: 0438F90F17
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o80C70TE/2pXw6eyGCLGbAEQDT1PovMNRPLMVSIFEWV0ywIrSCX4L54iMZZuvHUDMfhoLk/Z/uIrhZ0l4His2WCewaTIvUuSaflQH5eSwIjyAwgJne1b88XHtdEHliSc5WmWmUyGHPdN+HJ3JPVb7IfytIXF/oFXeWpp5hBmk8oNrpNV4QP/SPI69RwxpWwuxHkqfwdBemScODUnUGulRt6E6tiPHKSeSQ7PtAUaB/3SQjtxY3Og/LchrVdv63jSLZ6/NN5i6gDB/qporkELS/oPDkLIEX7JBdmVVgnht47HHBbPohadKldTFsDgNx9ES+vbtATADDlNVhAOpXsOUw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3573.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(396003)(346002)(376002)(366004)(39860400002)(956004)(83380400001)(6506007)(478600001)(86362001)(1076003)(8676002)(8936002)(52116002)(6666004)(7696005)(55016002)(186003)(26005)(2906002)(4326008)(9686003)(66556008)(110136005)(5660300002)(316002)(66946007)(16526019)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: Y424hfWP5YzXq1cG4Y5EsOB6hokx6nyTsKWHSehqfk936mrxkXM+frPLkcbAIEe0PDVRXJ8fCoONK6TEvMKiki1oMnOpT8SHrc0+6HtChbjLc6CbgwScbLSt/XO5YIfqUu5pVpB5cScN5wabGigIF24R8EIZalUmhdlRYKj1pg9v+d2pi5RgWKGZoA56dtBNI17TsnvrYWtS58sdH6W8rohcxK84whuX5segM4DzWTIOMOn9peeMzJ2xCZYuiibRlt5QlW5eH/ZubXayEsbT898Nj4srJClLKQymB6EmYB0IZt8Q+gEc8BxkB3yRRgy+4saZKzHXvp5+Ue2ghSu6XJr0f+FBjCbYnYfKNoBaNUG+C7V1Lt7O4DG72uCdQf1fCyLwxEgIj1yzOguSyFn/fo88/ZzD2cZCo0/yt37SGXJFMfKsoOV3PiAK8Ks45cdCKNkXbmij0aV3xokdfLAlstobJ4KSFj6pdR67yITxcwjsvQIZrSYwiJ84aadJ2kxx
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1585ed13-5909-4262-5368-08d81364e991
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2020 08:52:21.2276
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f6GkZbpqdJ8p8KH20i5Bmwi4LtimrCDq1HU1RYNO7J/bN66Gbtegy92Q6vmfX3YqkYkQyfpf1XeD1aTFkbAWSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5186
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

A ";" is missing in the pwrseq dt examples, fix them.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 Documentation/devicetree/bindings/mmc/mmc-pwrseq-emmc.txt   | 2 +-
 Documentation/devicetree/bindings/mmc/mmc-pwrseq-sd8787.txt | 2 +-
 Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/mmc-pwrseq-emmc.txt b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-emmc.txt
index 3d965d57e00b..c4fb06bf0bc2 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-pwrseq-emmc.txt
+++ b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-emmc.txt
@@ -22,4 +22,4 @@ Example:
 	sdhci0_pwrseq {
 		compatible = "mmc-pwrseq-emmc";
 		reset-gpios = <&gpio1 12 GPIO_ACTIVE_LOW>;
-	}
+	};
diff --git a/Documentation/devicetree/bindings/mmc/mmc-pwrseq-sd8787.txt b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-sd8787.txt
index 22e9340e4ba2..8204374546e1 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-pwrseq-sd8787.txt
+++ b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-sd8787.txt
@@ -13,4 +13,4 @@ Example:
 		compatible = "mmc-pwrseq-sd8787";
 		powerdown-gpios = <&twl_gpio 0 GPIO_ACTIVE_LOW>;
 		reset-gpios = <&twl_gpio 1 GPIO_ACTIVE_LOW>;
-	}
+	};
diff --git a/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt
index 9029b45b8a22..bcbe8e947459 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt
+++ b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt
@@ -28,4 +28,4 @@ Example:
 		reset-gpios = <&gpio1 12 GPIO_ACTIVE_LOW>;
 		clocks = <&clk_32768_ck>;
 		clock-names = "ext_clock";
-	}
+	};
-- 
2.27.0

