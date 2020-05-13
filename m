Return-Path: <SRS0=M0Y2=63=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E475CA90AF
	for <linux-mmc@archiver.kernel.org>; Wed, 13 May 2020 10:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34B60205ED
	for <linux-mmc@archiver.kernel.org>; Wed, 13 May 2020 10:26:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="ORzVkcRD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731466AbgEMK0P (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 13 May 2020 06:26:15 -0400
Received: from mail-eopbgr690080.outbound.protection.outlook.com ([40.107.69.80]:9031
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728049AbgEMK0O (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 13 May 2020 06:26:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GHdXK6LWI3TH02OX3tkMbmrhi4Jmd5MCDEvW4hhKbFO9Ku7mg6quG8F/UEYf30tuciY9wH32rih9XXiNswU87AaiT/ubxpty1B0KJQNOxN6v/M8CVbyS/AOCV+KS/Mw1E6sCmtWoufuUFh0Y9CB/QfFJx3GfO92TqFwovaWfTbHq/gnA3jQptOBsExRkO73eBxeZG9SzfNEasUsX8BUH9n1wWyXaRpevs/37+G9yLSOFrDA7BMuwDWpVf4KN9DKil9gi2HOKqX5o+jTG4HG5Aulv1uT3Uzr77ijbFt34tX11q1jKKdWcBBtgsU8HisVl51O3Qq9PyIJt5RhnWgH7jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f79+y+kLzPv220hJvbm+ATvjbwvjH6rsPrWhoYr0XNY=;
 b=MudsFdzEZ25wJtA4jRN/LPMHhkYnfVPvabvW0t9OMWEFy+AiztkGe+eAPwVzy4cAAhCjO1pYzYq2TfmxTMe5IswKSzhxBOg+gumyWmBAWmKgXvtBQ1s0EdZJIHZgOWXrn8xtVZTIMNN+1zpYai5MDsNgpGLK8lzQat77W/968KUKfMCqgFXjleHCBTeXMBP6bZMjAG/YNYKFRVdgzfAWEYE0ZkJbS3BU1OjHO4WGuFOvUmUeDe8sJqgyhmptvSaH19o7bBqndv9Vj64eWR1OBR6K1giShSNSgWn4Ml5tJiwnll8xO7ZC4GLwIxV6SiHiWp0V8ogsL30U8E47eIVs+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f79+y+kLzPv220hJvbm+ATvjbwvjH6rsPrWhoYr0XNY=;
 b=ORzVkcRDt3PHwtf/Vi+LfFqr4UIAuBTsSbvWiI/OS9aZ2PaoSJou3uk+PJ2EKvS7Yn1fVp+C5lMy5/nHk7Hh+5lTUm0NMaZwXshwagGg15D731YrNJpq+IUSe8tyQe4iD5N+6tGbAhEkMkLmgeS5ZQ7z/rbi7SFvFCxN4ZaBTdc=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=synaptics.com;
Received: from BYAPR03MB3573.namprd03.prod.outlook.com (2603:10b6:a02:ae::15)
 by BYAPR03MB4472.namprd03.prod.outlook.com (2603:10b6:a03:d2::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.35; Wed, 13 May
 2020 10:26:12 +0000
Received: from BYAPR03MB3573.namprd03.prod.outlook.com
 ([fe80::d8fb:de22:43b7:fcb7]) by BYAPR03MB3573.namprd03.prod.outlook.com
 ([fe80::d8fb:de22:43b7:fcb7%7]) with mapi id 15.20.2979.033; Wed, 13 May 2020
 10:26:11 +0000
Date:   Wed, 13 May 2020 18:26:02 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: sdhci-of-dwcmshc: implement specific set_uhs_signaling
Message-ID: <20200513182602.3636a551@xhacker.debian>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYXPR01CA0063.jpnprd01.prod.outlook.com
 (2603:1096:403:a::33) To BYAPR03MB3573.namprd03.prod.outlook.com
 (2603:10b6:a02:ae::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (124.74.246.114) by TYXPR01CA0063.jpnprd01.prod.outlook.com (2603:1096:403:a::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.33 via Frontend Transport; Wed, 13 May 2020 10:26:10 +0000
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
X-Originating-IP: [124.74.246.114]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2c01aee5-fbca-4d5b-83c2-08d7f7280ec2
X-MS-TrafficTypeDiagnostic: BYAPR03MB4472:
X-Microsoft-Antispam-PRVS: <BYAPR03MB4472BFAE0C791D892ACE586CEDBF0@BYAPR03MB4472.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1443;
X-Forefront-PRVS: 0402872DA1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WUtsvfH1L8IcoWEUCNllFFQHJx6OZb3q1i6QvESGSf47v0GVOt7G549c+aKRDLaK9rYs9kClCo4V6th5oegnBECJdR9ichDrGjiigG0uYF6sFtrJUjlRnlxyUwfvD42HtFE2f1z221zn+A/SkYMsgyOrYjzODidGlYTtdOfHPjXS5D61pi1ZMWhWYNs0hK+CRcYyj5YrIWh8CZ2J0cyQkgTPnXyz+JoCeyxX/TEFTTOKCoRFvQQSTekCvHL28RX0gV/Ylk0jMRkV/Ut9CBKGcfKlqSwfYwHsrW8C4BHonPlbWmIpkYKiPSPWuowin1OHWcMj1hQsyrV0QjjENwTDj7mGcderMaScbMTmwDXgvcAsmIKt2CtRCdZrm1T8xeKp+v4ZvsamCNr+dp9TcRhC29P8apJ7q6KrJqW0/xl148NQHD8eo25UYYdYKJHNFxsDDN6QQvVD+qUAYaeLOKf6E7524udMeVcUoLK0jjKwPvh/rKWRM710TL5bIqvdWZlSuEoRgRZKuG16NvT4WvPm1DogAE5JxcQ1qb183e9PET0roVtaM1Exg8rH6bx9ZYaX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3573.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(136003)(376002)(366004)(39850400004)(346002)(33430700001)(66556008)(316002)(55016002)(6506007)(6666004)(478600001)(9686003)(956004)(7696005)(110136005)(52116002)(33440700001)(16526019)(26005)(186003)(8676002)(1076003)(2906002)(66476007)(8936002)(4326008)(66946007)(86362001)(5660300002)(133343001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: tEBK+BbSzXCljPcK8YnRCdjmxdhkFs93mf8yhoITSCz+YOIq9pKbLMANvWHBnRLtjQshjz7bfrRpIMbg8mmYWEywKQxBkkyPhMAn+FPCOdz22kSVyLh1A9wOX17ndyfo17uQ9z8kRYD6sdd8s4uZU8ObTwYyjvRKfgfrMDhCOAMWvrk03i+S45OIJkzSlHIeC9vGXXVkWnxmkplkjjMt1E+mNwot9kCm0C9UK1esml1ljGGBYZaGyirvzoUg+E42G0gc+bXxV+Bozglz1UnGFBE3HIziBxqvZq3tIbEQnmhqrPdjeU7kuyj0Qsy+NXSbXwTIzHy+yp/1hv0XpSVt4Mjg5NC+YQgS6nBQCZJzyq+rWXHceVt4e95qaQUwmj9pZk3gJ/lBR9w5o9VrtGDVKVJ3tpZkmSVVbMy0f/Eph2iX6MtWM43F5KcLCLRKqee40Xyn3fXXJMwaHU7EUTFENQDjHt6jbsd6VwScS9KzcuS0um74gUI79HHqrnaHUEWv
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c01aee5-fbca-4d5b-83c2-08d7f7280ec2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2020 10:26:11.8363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2XNewtEEbW0ly7LFmn1bVGEA3cNjUYk5Q/D3kkckKNBzT1W0qVr7R1V3dfH+fMdGsNeYXrLzbpCejT7ekt4/Og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4472
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

We need a different set_uhs_signaling implementation for
MMC_TIMING_MMC_HS and MMC_TIMING_MMC_HS400.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/mmc/host/sdhci-of-dwcmshc.c | 31 ++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index a5137845a1c7..a9ed0e006e06 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -16,6 +16,9 @@
 
 #include "sdhci-pltfm.h"
 
+/* DWCMSHC specific Mode Select value */
+#define DWCMSHC_CTRL_HS400		0x7
+
 #define BOUNDARY_OK(addr, len) \
 	((addr | (SZ_128M - 1)) == ((addr + len - 1) | (SZ_128M - 1)))
 
@@ -46,10 +49,36 @@ static void dwcmshc_adma_write_desc(struct sdhci_host *host, void **desc,
 	sdhci_adma_write_desc(host, desc, addr, len, cmd);
 }
 
+static void dwcmshc_set_uhs_signaling(struct sdhci_host *host,
+				      unsigned int timing)
+{
+	u16 ctrl_2;
+
+	ctrl_2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+	/* Select Bus Speed Mode for host */
+	ctrl_2 &= ~SDHCI_CTRL_UHS_MASK;
+	if ((timing == MMC_TIMING_MMC_HS200) ||
+	    (timing == MMC_TIMING_UHS_SDR104))
+		ctrl_2 |= SDHCI_CTRL_UHS_SDR104;
+	else if (timing == MMC_TIMING_UHS_SDR12)
+		ctrl_2 |= SDHCI_CTRL_UHS_SDR12;
+	else if ((timing == MMC_TIMING_UHS_SDR25) ||
+		 (timing == MMC_TIMING_MMC_HS))
+		ctrl_2 |= SDHCI_CTRL_UHS_SDR25;
+	else if (timing == MMC_TIMING_UHS_SDR50)
+		ctrl_2 |= SDHCI_CTRL_UHS_SDR50;
+	else if ((timing == MMC_TIMING_UHS_DDR50) ||
+		 (timing == MMC_TIMING_MMC_DDR52))
+		ctrl_2 |= SDHCI_CTRL_UHS_DDR50;
+	else if (timing == MMC_TIMING_MMC_HS400)
+		ctrl_2 |= DWCMSHC_CTRL_HS400;
+	sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
+}
+
 static const struct sdhci_ops sdhci_dwcmshc_ops = {
 	.set_clock		= sdhci_set_clock,
 	.set_bus_width		= sdhci_set_bus_width,
-	.set_uhs_signaling	= sdhci_set_uhs_signaling,
+	.set_uhs_signaling	= dwcmshc_set_uhs_signaling,
 	.get_max_clock		= sdhci_pltfm_clk_get_max_clock,
 	.reset			= sdhci_reset,
 	.adma_write_desc	= dwcmshc_adma_write_desc,
-- 
2.26.2

