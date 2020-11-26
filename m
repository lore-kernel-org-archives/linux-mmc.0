Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F4FC63697
	for <linux-mmc@archiver.kernel.org>; Thu, 26 Nov 2020 11:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DAB221D46
	for <linux-mmc@archiver.kernel.org>; Thu, 26 Nov 2020 11:18:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="BtxJ2k95"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388995AbgKZLSF (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 26 Nov 2020 06:18:05 -0500
Received: from mail-eopbgr40073.outbound.protection.outlook.com ([40.107.4.73]:56710
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388990AbgKZLSF (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 26 Nov 2020 06:18:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lfy4p9Ii5NP2SYEHgqkn+gxBBhD97w/jEHKFP9/x++0C8DIrhMs0LMxdQbwiVDSZqYUgSQfBlaDTe4ULltl45Xjr5sDba8nCvoPLzlvlU9Vg/Zaebwm+H9IEsg7cqnTtGIVCNeL2kwthicBam4SRTIbsjiNCeAnfTHTi6qVPfKZD89LFZOkaJky4PexQgCBgkSdoZzIslgyC25h1chQjk3sC5oA9zIAWRHPdIGkChOxa7gaPLhLhVT0ZiRB8ayfjpb22nv+X108u4nc3bUVaLYN8rEJ4pShGMo8r7sARKHRu0S9yVtT5HaId2g4c4XljW+fkYAy+Ux5Yzoq8gLM0Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=taCkw/lL1qNb99YRmwtzbQ6pYpazLoz6NqnHrvlRqWY=;
 b=TQi/Z+TUnfMTONlNTznN/6pZxG8UJTfP7484O05Pq086nuaVDQxpVP8YBF/YRXZNgTtuuGP28twhIjCJB4mehVoRTRxo56bTuU5ZAOWGg2OqYiQTEWBqxIksdwCmogIzdxHmVSvJpPJQJ13/Qiadyc39ryWbJdHk/lzwb7GaXc+lnj3AGtCzZvyaJRAWDevjG2Q47T+gpWv1wphfpmqWkhP8hbyCSuvQPwzax5bYyYECMhtWs2X3RARBTEOjwF+QrwPjRSTJHIaiIWOTSfMVX1w+MICh2GvYhfOdE527jhwfqJpt/vEbJglJni8Kf1+6hgoJzZwrBi58rbZHtMP8+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=taCkw/lL1qNb99YRmwtzbQ6pYpazLoz6NqnHrvlRqWY=;
 b=BtxJ2k95XGPEYiBWr1CKiTrglf4yr7U6dR8j1g9tBZkd5RnTC3nx0zojHhqHZmCwUJSiKhOBw499rlt3qItWEMbFtbQHHx8ebOd8P6IseKimSkffU3IYwFRVVd1K60h/B/Nsk6li7QsXXe4UwrwUWhxfN1m3V8Zb6DijQOSlbZ8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR04MB5206.eurprd04.prod.outlook.com (2603:10a6:20b:12::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.22; Thu, 26 Nov
 2020 11:17:14 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3cfc:a92e:75ad:ce4a]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3cfc:a92e:75ad:ce4a%3]) with mapi id 15.20.3611.025; Thu, 26 Nov 2020
 11:17:14 +0000
From:   Dong Aisheng <aisheng.dong@nxp.com>
To:     devicetree@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-mmc@vger.kernel.org, Dong Aisheng <aisheng.dong@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>
Subject: [PATCH RESEND v4 18/18] arm64: defconfig: add imx8qm mek support
Date:   Thu, 26 Nov 2020 18:59:00 +0800
Message-Id: <20201126105900.26658-19-aisheng.dong@nxp.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20201126105900.26658-1-aisheng.dong@nxp.com>
References: <20201126105900.26658-1-aisheng.dong@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: SG2PR03CA0160.apcprd03.prod.outlook.com
 (2603:1096:4:c9::15) To AM6PR04MB4966.eurprd04.prod.outlook.com
 (2603:10a6:20b:2::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from b29396-OptiPlex-7040.ap.freescale.net (119.31.174.66) by SG2PR03CA0160.apcprd03.prod.outlook.com (2603:1096:4:c9::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3632.7 via Frontend Transport; Thu, 26 Nov 2020 11:17:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8ad3782e-cba3-440b-e70b-08d891fcd303
X-MS-TrafficTypeDiagnostic: AM6PR04MB5206:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB5206AF9F2260D5FE265B9F4C80F90@AM6PR04MB5206.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:120;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E3JA5Ce3WEjgMQ57+J2ewqZjqGVXeOz+PGufZQ2xi7sZXJIP7uFpO8hiAUBXUJtV79hIZVoMBzDw+zG8kuTKhmc5cC810p0D1lPUzR3MJM7Y2+i2EnbUMaIvuaXa3IKNtWOB3tddyePjev5nZgr3FyS4nZri5xE3QO8IexJWKuzvSXb8h3/d3v6wSQEPsjZhDiPEeT0TZcVuBMKLKwqfZN0FWHrOvcKUyzgSk1XzO33PdoQNVAQqlfKpPoRa/9xx1m8220i3Ptrh+dqnDK/a0IG+GriMGBH5bA3rzCdlZArcSFJdLLmkbwITt7OdkFakuwsVekdQtItI5n8ycMd1AsdIbEi0LaFGsXKgJL8uUpKfcjo53bTXQTU5UYwTb/yI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(396003)(39860400002)(346002)(376002)(6666004)(4326008)(8676002)(86362001)(6916009)(8936002)(1076003)(66476007)(4744005)(2616005)(478600001)(956004)(2906002)(66556008)(6506007)(36756003)(5660300002)(316002)(186003)(16526019)(66946007)(26005)(83380400001)(54906003)(6486002)(52116002)(6512007)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 8SeJARioNE3AJDj9fzGshJhZksdt6kdkDRNLoPvvE+L0dsqlBycb2yQFxc3DLISGrR06rv4J67ZUTmhchbP+j39bPwG4MRHOnm5fFS5fcv7rvizOZ83VFZWEzw/4ggTBtJhBKgx9g1Gsm0d5yWQ4xwyybR1hmbNuXMfEOn9LWnNBcEzOHDg1jNSYz5TsI2gsagaOmWgjsF+sNHdm+gbI1O3kyVY2A5gz0ZpRLrMFpa4wrvS9nT5V5REcVvF3GapSj0iXjnTeTvvwpYgnlUIEpoipiAfVfDSPNG/9jFzLATJ3C85+nNANiatiKdne++MX/LPzO1sn5qUnqO3aernQd97zhtSE+QH3BOu+tCtB0iTEmHmDIOi36RjeZ+4eXWvREs2QRRE6TGvx+3YGw765N3Ruc5nURd75GoWOYCzZBJsexzVfD5cOjsXBCf9k7XTonLMQAqGm6VhSkkzJNd7LQpvC0ILTzZGYp3+wBVcYkJdWuChm7hnywNdRx1+a3bi3v7NJ7ToGdwybaWzkod0pLlVgucdslpVN5MNk4mOJh8b5yKS9pPVoMy/wD1XlvSvWA3dr4KLKZrRA48Oa60RvQhMnZcNyDIJUHWyM44HbtO4NsORbJWy19CrxTGaJUD13de9pA6sCW30Car6qOj4OdyUsQJPkmdgk9+gx33zs+YRsBC+lqG6OKu8GMOPmFrPHRONsrf9GrcnIQC2+fyFGQfatjdmuseH9+84uAcP2e3K3l0jYvMAFDewgg0qnic91Z/KZv0puUhrGyj/9cPW+8EoV8vY8tGm0DbTqYxVab5WotsTX3goQomUjLHLtyr8NOsKfKMhPslnZq/+KhOI31O17S/G0wwcdUB33fXfmlq8jwOxE+8Cr3DlOhrJ0m6HP0Wrh3iW7XBL+wiCZTaiyDw==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ad3782e-cba3-440b-e70b-08d891fcd303
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4966.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2020 11:17:13.4677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nzuWA6OlB/zQd53my53RJ6AACCFHNEe7bYP7xy4GqiRAu9fy/j38Qq+C/qKwvc6ajC62dmgXl+OTpAdD6dL6KQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5206
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Except MX8QM pinctrl driver is missing, all other necessary drivers
for a booting are reused from MX8QXP which are already enabled
in defconfig.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>

---
ChangeLog:
v2->v3:
 * add more commit messages
v1->v2:
 * no changes
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 821b21a56ad7..587f2f296f77 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -481,6 +481,7 @@ CONFIG_PINCTRL_IMX8MM=y
 CONFIG_PINCTRL_IMX8MN=y
 CONFIG_PINCTRL_IMX8MP=y
 CONFIG_PINCTRL_IMX8MQ=y
+CONFIG_PINCTRL_IMX8QM=y
 CONFIG_PINCTRL_IMX8QXP=y
 CONFIG_PINCTRL_IMX8DXL=y
 CONFIG_PINCTRL_IPQ8074=y
-- 
2.23.0

