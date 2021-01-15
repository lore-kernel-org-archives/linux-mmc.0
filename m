Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E29C433E0
	for <linux-mmc@archiver.kernel.org>; Fri, 15 Jan 2021 02:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C29BB23A7C
	for <linux-mmc@archiver.kernel.org>; Fri, 15 Jan 2021 02:56:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbhAOCz4 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 14 Jan 2021 21:55:56 -0500
Received: from mail-eopbgr00077.outbound.protection.outlook.com ([40.107.0.77]:38531
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726894AbhAOCz4 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 14 Jan 2021 21:55:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lJ4jwtM0X28sB6CQqUKEE6jOoXRWPgteQF/4MxhDmbX9tlVWQFHQwiQUFV3ZKABzVow5aHq81T53zbg+iCDfloEFw/Ix+T4gJsa2WiMdRcFIwB3wDmidYPkpuN/HR3TZ+CKPIvLxsT17OfB3Jw3+UBU3q+XDP8uuW4BGWgUQ7lmPyVXtxqsTEAHQnmjzrakBuLv7UwGrEbh7fETDYXcqGTFeOC9SatITJ7JEiTTzl/qepVnqs6UTS0xrPAP35Wwm3fgKrpN4qiKWSDbHzju9el6pDGBCySSKwUAXETiXReVR4KxkieV3X48ap1d+YpzqIbQHA2T8lyZaJo0jDT/VPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oDw0tsx8K+Btrx73PfUj0hSlKS3l8KQdV8eUXMyigKI=;
 b=FkhX26JFt8lt0WYewLiwowzBVhem7K7vRrowlS2vLsTjzdqz0kL8oXvUAzTug5Bi/it3qGKsSdCQAP9g2doVRm74y201e7CVMtrC6ZP+ZOXbHlhjbhAGF62IOqrgYN5DcrCLlrziXeiuydsVUVgh+wg72BQUcRhbuUKAA3gAYokpSRlnw5yLmIrqVhd2axec7wi1yAY+sPsEL9LhdOLVyW16JmS9Aawde6bev+N/78pSYhRPJ+MCjo/tGtB4a0RHTFtxRxOSJs4qeTyQlBxvFYBqzW+1swmV90aF+qdWpkOK+2Owx2vc97GywWyl9r0E+5ky11BG+nPVMdlneqjLpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oDw0tsx8K+Btrx73PfUj0hSlKS3l8KQdV8eUXMyigKI=;
 b=bXg0ev2GLQVQHTf5uBsfAUuKnHkMKiI2Nak1XPjplRF46HZiRzEoZyFKYaF32aaVHELgevmfHGpU6VZxnQo7SfnTfP42OMCsTBh+xP5XHUxB5j8f2buggnTzENfX6I8QwneqbracnG7ctpWXKOSJCNCUWnbJR5QynXQJQ/oIxY8=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB6PR04MB3013.eurprd04.prod.outlook.com (2603:10a6:6:4::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3742.12; Fri, 15 Jan 2021 02:55:07 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::c964:9:850a:fc5]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::c964:9:850a:fc5%10]) with mapi id 15.20.3742.012; Fri, 15 Jan 2021
 02:55:07 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>, Bough Chen <haobo.chen@nxp.com>,
        Alice Guo <alice.guo@nxp.com>
Subject: [PATCH] mmc: sdhci-esdhc-imx: validate pinctrl before use it
Date:   Fri, 15 Jan 2021 11:24:23 +0800
Message-Id: <20210115032423.15108-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.28.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: SG2PR03CA0085.apcprd03.prod.outlook.com
 (2603:1096:4:7c::13) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by SG2PR03CA0085.apcprd03.prod.outlook.com (2603:1096:4:7c::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.6 via Frontend Transport; Fri, 15 Jan 2021 02:55:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8b393ace-f25a-4346-bfa6-08d8b900f6cb
X-MS-TrafficTypeDiagnostic: DB6PR04MB3013:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB6PR04MB3013A72C30BB01F747CEBA11C9A70@DB6PR04MB3013.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:546;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1d6yKk5wyRpcW4OFb923+M02fPNrgt+TnJgsQ94OqsRFMfQnIbUBK3Kqk+e0SpYgc50pGmiQQeavMGbhTv8GzdOmCZkNC+gSGXLOeb1hfzgnIqJF8/+tjmBAtmVcsHcOVj64dt5ZQA5y5ZxtwZVC/0Pg+4R+SlacJ/1Sx8qtngOF/JI6xLkgzqhKgEp82ZoqOREMJWiZeWKUdHjtwTw9RG7gHZk7VmrGGE0Vlwe5dK1DHxQjFBrKy+FeqpBeerLk/+xGNKcK3Oq+xXuBvtJMMQJdahha8zN01xEfYPIBKNsuBtytzIiPl9LxlKYq/Key6JElhQCtn7nBl84qJPY1icMLDWuM7Ab9WSZbHB75zcSuh8Nm02buYBJ9xulBpc2cuMQOZzH8PadyDt3mS7hTVw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(376002)(396003)(346002)(136003)(186003)(8676002)(16526019)(6512007)(6486002)(4326008)(1076003)(66946007)(86362001)(66476007)(6666004)(8936002)(2906002)(83380400001)(66556008)(956004)(2616005)(478600001)(6506007)(26005)(5660300002)(54906003)(52116002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?wOOVPwhZFHypLGLU6Y/pMzI51mb0eIchZUXXw2qpnDd/HSTkGzmLrpnVhGqF?=
 =?us-ascii?Q?OIxgPkBOP8bFl/L7Xb/ydA+tfhayC+0rvW/dtqNC4HjiL1mnK8pzGYHvISHG?=
 =?us-ascii?Q?b8FslK6fIDffchuV7P43aaHozY2EZALL6ZPc343hpekLQMlMP5LH86pMw4qg?=
 =?us-ascii?Q?xVZhZ/dkA+Lg5VmhSZogENPOU0s1k5BIJVKBx4F3KBCDajCSPK66DH1jdd0h?=
 =?us-ascii?Q?RlUmApBUUoTlOrGQGRLy8dIqhupgjSxsuqgoSWl5xUVzrfIQeNUWwkOcGdmD?=
 =?us-ascii?Q?hj0QBumGPuX4+dA3ju01di6kPfq3DFu47ZF99mgm3ltzlIKtqtSGs+JR8Tjh?=
 =?us-ascii?Q?4rpeGe5iD2GUn/flcrHr8Te3hVzpsFWIdYrIA52Ht+TiV2b/2/xyJqUl72rt?=
 =?us-ascii?Q?xl042TW3OETkd69+3CULTgqV0GABmsiX74PL7Gvv7gRSAMhwPwPQWMArj8fq?=
 =?us-ascii?Q?eMHExpWdxroQRR+080vJ5fnF3LDbZ7K5poiNFQk3MLaJzdaZEjnx57FhXM/z?=
 =?us-ascii?Q?BDPe+wXNBiVKEKA6KfFQXUsaCj6z9QMKnhn356XjDdhcQix39QC437LKV96F?=
 =?us-ascii?Q?WSFeHP+UuzM0FNa5v9bDyZyqz8d5vDrCsWOBJlBfUSUwRFnW7jTa1cCgIsxB?=
 =?us-ascii?Q?Xd9C42DdQ41zlZBo3qPzYXecg5XJa7x0XvEfMExbBBWFV2GaDFrI6BbiW42+?=
 =?us-ascii?Q?T+sOD+2Ej2db7WcsDC1cBsvZYUFOXQddCyE4fIq9cvVl85wxP6hwPNASNX3T?=
 =?us-ascii?Q?cLb5QFJSSw+Y9R5IQmzM/kQxQyLbI9RLB/WuammwKoSV2QNZRaqeHIhJCnJ3?=
 =?us-ascii?Q?YdLQwxZF5T+Biy6o3mI4N7WlXuFd8fuOOfwmUQSV/WFr1Zmr19BbnZwIlp1s?=
 =?us-ascii?Q?vVLv/PsxiCFwpQh3dk548y65jo6iePXIDH5nVASkl5jN1RSJ9byoLrEwdgou?=
 =?us-ascii?Q?bzJXv1z1Rd/LrmzPX9ojsOEUw//+OrXrq7at4gl6R80JwjeoRCi5wpxIhvGW?=
 =?us-ascii?Q?v9DP?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b393ace-f25a-4346-bfa6-08d8b900f6cb
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2021 02:55:06.9489
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mt/hC7gcY+mXfewx0W3QPn2bAZNZ2RlU/S54y371EYLR3uyE0ySSwZgGfkntCyDsd3Jhhul1cafTPia+oE8vGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB3013
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

When imx_data->pinctrl is not a valid pointer, pinctrl_lookup_state
will trigger kernel panic.

When we boot Dual OS on Jailhouse hypervisor, we let the 1st Linux to
configure pinmux ready for the 2nd OS, so the 2nd OS not have pinctrl
settings.

Similar to this commit b62eee9f804e ("mmc: sdhci-esdhc-imx: no fail when no pinctrl available").

Reviewed-by: Bough Chen <haobo.chen@nxp.com>
Reviewed-by: Alice Guo <alice.guo@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 16ed19f47939..11d3a2244b36 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1488,7 +1488,7 @@ sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
 
 	mmc_of_parse_voltage(np, &host->ocr_mask);
 
-	if (esdhc_is_usdhc(imx_data)) {
+	if (esdhc_is_usdhc(imx_data) && !IS_ERR(imx_data->pinctrl)) {
 		imx_data->pins_100mhz = pinctrl_lookup_state(imx_data->pinctrl,
 						ESDHC_PINCTRL_STATE_100MHZ);
 		imx_data->pins_200mhz = pinctrl_lookup_state(imx_data->pinctrl,
-- 
2.28.0

