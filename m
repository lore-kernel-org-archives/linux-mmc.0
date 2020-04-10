Return-Path: <SRS0=BsGh=52=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1385C2BA2B
	for <linux-mmc@archiver.kernel.org>; Fri, 10 Apr 2020 06:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8170720757
	for <linux-mmc@archiver.kernel.org>; Fri, 10 Apr 2020 06:57:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="Jbt1SNno"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725991AbgDJG5d (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 10 Apr 2020 02:57:33 -0400
Received: from mail-eopbgr750082.outbound.protection.outlook.com ([40.107.75.82]:62478
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725858AbgDJG5d (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 10 Apr 2020 02:57:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IJacz07x4lXTgVHDDXyxJb8vmg1YUnPBP/xwnvXLqzIZGwZJVEhrHGAvPmnWgWXorg6kXsL7mWwePICBg4or301YSdosM6WuZ3tb5Yyt2lht+se17enzzebiPs9MWDI+L5lQeKH7+QI21t0aem/OPYvMZSDhhOfYRKmv7ck80h/LkvOKfLNO95mh/4ViwZFcwLrCRt8+QMy2TtWN3S4FcVDyyEQUQv6RbXOPir+cLGd6jEegc45N+O4Np/s6BdgHGrXLIusEgY3E0efPgDwIJ0EvHkjY4dB/jG2lAmowf487CmryXWf0F22iVmPIkfInGC/kUL7eVa+tWgrrGzdm+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dCCDBuxeoMLuySe7Kgg6v3LWqFCKhJcN/FtZK+jb4mc=;
 b=hwW/AFREum6olPzqYjfo2B/bbw++jTTuj0SIz3I4mSr+H1peuIuhqwIYAhH3azyg40Pjv0yTF6ecZU19xF4fw8LpoAOeyrsLaw+J/Duox7RaB86v0g6S4lPb4jt/9CN3/+DCDz8JJRwHx2FxmXRDWQnDIPKeiQOnoBqzCmjKYa368Lx7TXSOLd4pQ0fOhB9fTzDeYraMUxQM/tgYDQn//9gnY5V//kdog6MVvtlhCZ3EtdbhVd+T1+CLlS2bDHMq+GwUwTzbopCyvL64sW/JCDITxnMepfULQSzo3QnknyfYgQc3TBKTWg2rVUoTSuCzMbRncuzvMxV5/JAmTIwSdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dCCDBuxeoMLuySe7Kgg6v3LWqFCKhJcN/FtZK+jb4mc=;
 b=Jbt1SNnoopuXjh5Hn4AaPhh+NZHwR8OCADpnbP7Omnzf9xegyqr97H1PowIsEVQdLEEOkhb7dBmBgwwrzV6F3HhvtAHe29tFXM5mooqIZrVV4l/jo3Av0Wi2cnx77Hvw/WoxipCQ/Q3P2XwOeEbUT7faVx/YpzsXsidxl674Zrs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from BYAPR03MB3573.namprd03.prod.outlook.com (2603:10b6:a02:ae::15)
 by BYAPR03MB3525.namprd03.prod.outlook.com (2603:10b6:a02:ab::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.17; Fri, 10 Apr
 2020 06:57:30 +0000
Received: from BYAPR03MB3573.namprd03.prod.outlook.com
 ([fe80::d8fb:de22:43b7:fcb7]) by BYAPR03MB3573.namprd03.prod.outlook.com
 ([fe80::d8fb:de22:43b7:fcb7%7]) with mapi id 15.20.2900.015; Fri, 10 Apr 2020
 06:57:29 +0000
Date:   Fri, 10 Apr 2020 14:57:12 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: sd: use HIGH_SPEED_BUS_SPEED in mmc_sd_switch_hs()
Message-ID: <20200410145643.630b0731@xhacker.debian>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HK0PR03CA0120.apcprd03.prod.outlook.com
 (2603:1096:203:b0::36) To BYAPR03MB3573.namprd03.prod.outlook.com
 (2603:10b6:a02:ae::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (124.74.246.114) by HK0PR03CA0120.apcprd03.prod.outlook.com (2603:1096:203:b0::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.16 via Frontend Transport; Fri, 10 Apr 2020 06:57:28 +0000
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
X-Originating-IP: [124.74.246.114]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7776f193-9e55-4915-db22-08d7dd1c6f6f
X-MS-TrafficTypeDiagnostic: BYAPR03MB3525:
X-Microsoft-Antispam-PRVS: <BYAPR03MB3525524AE8DF95ABF14E952BEDDE0@BYAPR03MB3525.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-Forefront-PRVS: 0369E8196C
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3573.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(136003)(366004)(396003)(346002)(376002)(39860400002)(5660300002)(956004)(9686003)(1076003)(7696005)(8936002)(16526019)(8676002)(316002)(81156014)(66556008)(6916009)(186003)(52116002)(66476007)(66946007)(6506007)(86362001)(478600001)(4326008)(6666004)(26005)(4744005)(2906002)(55016002);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TIuZnQ4erIMSAbFYG8xDCApQvzEtKpSzF/V8SNbDQkpxstX55rnGOdAwdxt8/8H1mlNEyNNDtLFsgPQuyksYcKH8/TJ2l5n/JXU2C2E9vfDu7ZVBF+lt4cN8DxFkEyZt/dz609qHVerxKQIvD7RiyaSb92DmhjWtiUrb2WaeOC7rSHTWS0esB25rKP7RtwpL3W99QcIcZQfSHWdd17umEb/IvwzpoGFY/QINosyF/Smmf8iLuoVBCSaKEGNLn5SKk7/tuWHzMgAPTpNShvC1CUACV1XlWvEdcP4FZY9gri/nCBGZk8L8Ir4qf1z6hZWzSXGlh4f1XycRXxkp6NmVjyXZNnIs+Tno+TFq3E+pWGG3jLVtXH4qoPvR9d/aMpDnCShnaXiSJ+9mvxdWrNnnCwGFRPofvtNyw7oSgB+S/MZkCpR52T8+EqTfz+rWHtYT
X-MS-Exchange-AntiSpam-MessageData: ygsherBEcPaEu6NiEmHwsF4oq7/CiC5/X1n8BtqqYPh5OMYnEZGk0pPPWRqsIyYQ8N/7wDls3Ge7Jg+w07fnSjTLmhuHx9c7yrtbErAznLz8zlHWrqslvAU0vFWVxrxAhBkiKZf89IzJMy38ebY41Q==
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7776f193-9e55-4915-db22-08d7dd1c6f6f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2020 06:57:29.8406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nUG4cM5Mne9wCqisTnNTD8wf1ZBCkAS64M4RU9epwT6fZw1S51zLGGAYmo83IdH2tcWPU0PwgDRm8YDc26Gq6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB3525
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Use the well defined HIGH_SPEED_BUS_SPEED macro in mmc_sd_switch_hs()
to make code more readable.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/mmc/core/sd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 76c7add367d5..43de3190d718 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -376,11 +376,11 @@ int mmc_sd_switch_hs(struct mmc_card *card)
 	if (!status)
 		return -ENOMEM;
 
-	err = mmc_sd_switch(card, 1, 0, 1, status);
+	err = mmc_sd_switch(card, 1, 0, HIGH_SPEED_BUS_SPEED, status);
 	if (err)
 		goto out;
 
-	if ((status[16] & 0xF) != 1) {
+	if ((status[16] & 0xF) != HIGH_SPEED_BUS_SPEED) {
 		pr_warn("%s: Problem switching card into high-speed mode!\n",
 			mmc_hostname(card->host));
 		err = 0;
-- 
2.26.0

