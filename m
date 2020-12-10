Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AFC2C4167B
	for <linux-mmc@archiver.kernel.org>; Thu, 10 Dec 2020 08:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 078E423D9A
	for <linux-mmc@archiver.kernel.org>; Thu, 10 Dec 2020 08:56:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731476AbgLJI4P (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 10 Dec 2020 03:56:15 -0500
Received: from mail-co1nam11on2082.outbound.protection.outlook.com ([40.107.220.82]:61792
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731463AbgLJI4G (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 10 Dec 2020 03:56:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fikhLL3J24E3QQoH2GuijSeTkcwSUJh68RkGpsfGL/iso2WpPguU1ClUbS7b+x3lra+MzurchyCtmLCZPy1UnT7yYWUCeojR3l08hIoTEygeMCeNqABzEBv78OYwgJsZsgOiD9Pbo4tkEJqCdpyvb+2cGrC3q3j2+XrheEqGZDBMrjYZSwjHxZWUZmFJQgQ4YjqBFp4u5i8zg0XfWFVcEJB5nc5PixOLIOJEcV18MP1shX7gzepQ6d/jj2/V82WNWJBw2d1w1QElTl5QYDk4GgpgQMd2YH4buBIaP902KFcMorlVhj7HM3h0d2DaMGMTK2N6X+CGURziEiRggaa4yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HCyDnFCdhOMjKJYaVtPXo6Biu4oISSf9NaYfiCXEhy0=;
 b=Msm6rflapzuJCooRWPwotGZyKwB0oXJOUwkX2cydlTqAoFJSoVj4EsBHHVmHlAtdeJQxhr0TDBQ8PV64ntTR8uE8wNhaNVi6nLL+5STPZXMFCubM4cB9mxLWgCw0EEyDKdrklBcsQP2CgH8KKa6plbvi6BuQQKlwe+kC64gLrMnIgdHYjP1MzHYEYXvrzZn4ah6Bav7U8CstbaW9zLYcoZX+L/fIz/l/BQmgi38mNoUhiuNfwt9E2IGMEN68DBXZQVskqNx14qOc2l0mtqORuVrGP6Pi1M9uylhEcVcOuOFPtMiuD+v6MSV22+H+/xY9y43Ives+7/tBsYWJrc3HaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HCyDnFCdhOMjKJYaVtPXo6Biu4oISSf9NaYfiCXEhy0=;
 b=fHxlPR838zHjZp4fUBySmjIRrzw3vuZxBfoA9PAFNAlsmrUX48+hya+rDB90bhy3O1kndtVUKmIX6KMNgMYemXfrkXRIV7yqPBDLV6Kbqx1u158yktBBvTXBcxVrA+glEs5sAIIgCG39Mm/LQA3rqzkPHjpLDI8QzdZUt1l+37g=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=synaptics.com;
Received: from SN2PR03MB2383.namprd03.prod.outlook.com (2603:10b6:804:d::23)
 by SA0PR03MB5482.namprd03.prod.outlook.com (2603:10b6:806:b3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Thu, 10 Dec
 2020 08:55:19 +0000
Received: from SN2PR03MB2383.namprd03.prod.outlook.com
 ([fe80::412b:8366:f594:a39]) by SN2PR03MB2383.namprd03.prod.outlook.com
 ([fe80::412b:8366:f594:a39%9]) with mapi id 15.20.3654.012; Thu, 10 Dec 2020
 08:55:19 +0000
Date:   Thu, 10 Dec 2020 16:55:10 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: sdhci-of-dwcmshc: set SDHCI_QUIRK2_PRESET_VALUE_BROKEN
Message-ID: <20201210165510.76b917e5@xhacker.debian>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.147.44.204]
X-ClientProxiedBy: BYAPR07CA0077.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::18) To SN2PR03MB2383.namprd03.prod.outlook.com
 (2603:10b6:804:d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (192.147.44.204) by BYAPR07CA0077.namprd07.prod.outlook.com (2603:10b6:a03:12b::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend Transport; Thu, 10 Dec 2020 08:55:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d79a2efc-36a9-45bb-2dae-08d89ce95238
X-MS-TrafficTypeDiagnostic: SA0PR03MB5482:
X-Microsoft-Antispam-PRVS: <SA0PR03MB548273637A7F853F163F93F8EDCB0@SA0PR03MB5482.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:983;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ujV3AHPd7uqhMoLzvhkmgXNHB/37yzn7HYPSfdJwhBNUBivL2+s704DsoD5xRpcZ4AsfGEVhvSg9+pWfeP+O7OeRumuf+L5QbxpwnM033BuYtRjGpAGfgR8NBnZXixlvo9Oi/sAmv8OnucIjcPCi2LqHlqkC0U2lzVVVw1oDoyBEy1qbPgi3UZUhiXHeOKvT8jyKFEkQcFaaxfQ4onTsSR6PwfeLRIj+aDTGUh5HnggvwUms2zH3NNbkuQ4H1IQVMAPFHkf6EcSyXbBGjTkov0GOEa9CCPey645RpXqwDXMg23udg2Qdnoq3KjF454zWQyJOqx/oPJxVwxUsx4QGwK+qqraWsgSOYTef5c3bK6OTpRtjPAiBTzX+t4HzIB/YHmz11UA8isj/vLCQOgqc4+oCYr5T+woKeKUOaBbOUTY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN2PR03MB2383.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(366004)(26005)(66946007)(7696005)(8676002)(52116002)(186003)(4326008)(110136005)(66556008)(6506007)(4744005)(9686003)(55016002)(66476007)(86362001)(8936002)(2906002)(956004)(34490700003)(5660300002)(83380400001)(16526019)(1076003)(6666004)(508600001)(133343001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?6noJ3znUO6gb97FKEGBA3XlfZeet5DZl9Fhb4bZIbk1FL9ZP+Kn5A3qRT99r?=
 =?us-ascii?Q?IjT+H9baIbqPxQ2Qv1vlF0atg+jEhcFOu6pYUn2n5KVOFbZ8wcqR1+mvf1Dl?=
 =?us-ascii?Q?AVkrKt5Tm1W79hutGXCz/lEuPRM/FITbYSBwMY/B3rbn2sNgA9xpWKwymGlS?=
 =?us-ascii?Q?uYYP9IvAa8lnPe05MF3ZI6OoLu7av/nOSN2+hUnIkVUQIrdY3KeC5dBfyxwF?=
 =?us-ascii?Q?pKLAiMl965cIkyLq+ZVvrnycH3Z+3k+sPd1czeGPNzr0WZI4SIAg9HHKQ3YY?=
 =?us-ascii?Q?ztAg1PZ9yER68A5GKniGjqa3NDqyiry2VuypIeKv5ILPtfX7MP9zfVV34jTQ?=
 =?us-ascii?Q?JXj+y/dYmH0cIHVIIytEt6jle+G6A5FezGI4KOB/s6ga2LccYm3FwyjgOLtM?=
 =?us-ascii?Q?D1ONOB25+BU+Csiw60s3A64JZY5mn0ObYq7NwrrjbtwLMQrTWYz97I1oav8y?=
 =?us-ascii?Q?LbO3MSFiRjmsqRq/uC4MpRINKaei/62JipF4+19VPhLWRKTr8yySDbN/ChDJ?=
 =?us-ascii?Q?H3430CBVl4RG4XbOl9r+r81a03cwRhqz8g/OScrO9SN/bLtHdsjJoSk2tZFb?=
 =?us-ascii?Q?FJWpOmiBF1wz+Faj9WjJze5G9HuM08QpnwdmtHvlGQMxtEIwg6C5FtlijtlA?=
 =?us-ascii?Q?OEgg3q2yqpkFCNCn6rJlAUet5Rny1CV9Mks1l01hiLwroCfthjvFIw3z82Vh?=
 =?us-ascii?Q?FIn4DjgEx02ZpBdisgGVDh+rmAlt+HN48FlxsSL3annGktKsJk9wunDGEcNO?=
 =?us-ascii?Q?fYF6UjZtYibBKrl1B4gwM9BTAKe2XNfOBXm1eTN2ocUn5420F+0jLdVuETw1?=
 =?us-ascii?Q?AlY9V4UOchheqoDTK9DqBQMeQ6Jw3MJR5gyE4uC+k4q12o65P6dGroxz8MXu?=
 =?us-ascii?Q?AeDnGVw6Ugzx1nSkSZWo6xzzaROoOQJaGtdxWTzsnbgEs5i2k+cMkzEiHSYQ?=
 =?us-ascii?Q?TU5KJ/4M7GmYTSKpM+FBaESMXbTwveGxL8PQcAD5PYuJamljX1TLg9LrSaEs?=
 =?us-ascii?Q?QyOK?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-AuthSource: SN2PR03MB2383.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2020 08:55:19.2482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-Network-Message-Id: d79a2efc-36a9-45bb-2dae-08d89ce95238
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jrO5oYcEPFh5Pv/KESAgxSRwEHboETTqFS9AED7ZYPOwo0ZQbTODh2ZSLaG4d4quspqQjjnmc4SvQEYu6Lvznw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR03MB5482
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The SDHCI_PRESET_FOR_* registers are not set(all read as zeros), so
set the quirk.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/mmc/host/sdhci-of-dwcmshc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index 4b673792b5a4..500040253de2 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -87,6 +87,7 @@ static const struct sdhci_ops sdhci_dwcmshc_ops = {
 static const struct sdhci_pltfm_data sdhci_dwcmshc_pdata = {
 	.ops = &sdhci_dwcmshc_ops,
 	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
+	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
 };
 
 static int dwcmshc_probe(struct platform_device *pdev)
-- 
2.29.2

