Return-Path: <SRS0=DFdp=DV=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D95CC433DF
	for <linux-mmc@archiver.kernel.org>; Wed, 14 Oct 2020 10:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F273B2072D
	for <linux-mmc@archiver.kernel.org>; Wed, 14 Oct 2020 10:33:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="eiSA6onB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbgJNKdS (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 14 Oct 2020 06:33:18 -0400
Received: from mail-eopbgr760052.outbound.protection.outlook.com ([40.107.76.52]:1444
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726307AbgJNKdS (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 14 Oct 2020 06:33:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d16RgDEAC8bp6JoBDV6VCO/f4yzr7nXHp4D/lgf97nMjnluBLCtiLyd8VzMjWtE0OkfUAYHA40W0S3sZnUHTaZ3IV6PediSLLemlWOGLuzZ9wkYFn2lJLg6OVsS++vwshk+OV6q9TkytMYb/MRn8KOZAYr1n5b8Z24mmjjsPQyp5HAgQWisD+e7cRmvvb8bvTz7YCexnkr+TbmUVht0dKf4j+R4+GCnQfjgXInfdC/DidS05SaDzmAPxxJLSK7j89C157E073vilR14Tl301DdJQVmeq8VLEmjyfBaJ5EN7vXCZ3LJjcIb2SaDPOLH+sHsJD1IBMpZBAIsgZ3QIGEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q4zNa36/j5O+EQ4uB3gZnsO268u5cVB4EymDRpYEEzU=;
 b=C6cbSDb05kdHiuGfgQ+pMUOwFDPqfN+A63tPqWfycm/AeaeDfZPJmFoQs0iDnzeoP3V87AUXKNCiYPqAYqTVUgpE5nkAdkc5NK9E8rjd5+LNQT8NQjLdH268sbcsg+eTHgANYVEwUl9SIRP/f2uq002B2fd198kE81VmB+UbenrUgIbtPowWQ+VYf3EgRW1KwduQYJtL+s59dRrSqgM+NlTudRqM9oB3vpukcMx7lY2YVu3moVdDPBnF7nnpAgLIZBO3GKdrSfz+Yw25pTtBFb1Ffbh/RJFWRHUC/ryl1ob99tTap7AIsFCBBYwRdehETWH4ZPmOcqQSxcatvv/3Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q4zNa36/j5O+EQ4uB3gZnsO268u5cVB4EymDRpYEEzU=;
 b=eiSA6onB0xD+75fFHDx6z1JSxH1a9w9jxRWoeHm/HINJqS2o7y0GN5+toh5jp6h9STNg0qUlgaYoMWQuCeIsBFpxDjWcrgiGiB6d7oVPz2BgIRHiQJyH8r2VgZInVA0z0tpbxWT8VkCsRuPWfDyLqF91vzFVFPnxtEt4v2o8CFc=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=synaptics.com;
Received: from DM6PR03MB4555.namprd03.prod.outlook.com (2603:10b6:5:102::17)
 by DM5PR03MB3114.namprd03.prod.outlook.com (2603:10b6:4:41::38) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.23; Wed, 14 Oct
 2020 10:33:15 +0000
Received: from DM6PR03MB4555.namprd03.prod.outlook.com
 ([fe80::e494:740f:155:4a38]) by DM6PR03MB4555.namprd03.prod.outlook.com
 ([fe80::e494:740f:155:4a38%7]) with mapi id 15.20.3477.020; Wed, 14 Oct 2020
 10:33:15 +0000
Date:   Wed, 14 Oct 2020 18:32:30 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: [PATCH] mmc: sdhci: Use Auto CMD Auto Select only when v4_mode is
 true
Message-ID: <20201014183212.475a789d@xhacker.debian>
In-Reply-To: <87a39115-5843-a6a3-7564-e36ae1f16903@intel.com>
References: <20201013190851.715df9ad@xhacker.debian>
        <CAPDyKFo-Q-+wK1RjtTyoC42_M7UL-HteKwzLmWR-ctD6oKc=rA@mail.gmail.com>
        <87a39115-5843-a6a3-7564-e36ae1f16903@intel.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.147.44.15]
X-ClientProxiedBy: BY3PR04CA0001.namprd04.prod.outlook.com
 (2603:10b6:a03:217::6) To DM6PR03MB4555.namprd03.prod.outlook.com
 (2603:10b6:5:102::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (192.147.44.15) by BY3PR04CA0001.namprd04.prod.outlook.com (2603:10b6:a03:217::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21 via Frontend Transport; Wed, 14 Oct 2020 10:33:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 73e3dde4-41f9-40c7-1efb-08d8702c8ef2
X-MS-TrafficTypeDiagnostic: DM5PR03MB3114:
X-Microsoft-Antispam-PRVS: <DM5PR03MB31148A6F3A9A53EFE71A6A97ED050@DM5PR03MB3114.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NDDALdW0ilyatN8V+TanNGigddNMJW5VxKNi0XNN++oi3XQKnNU+G1APkeB0TGOar6AJrTRhNBmZ84qUUJG/VETluVtXQ1/Qoz3fMgu5pprB4WN3NhmPubDan605SUmvIT1k60UFWK0LI2bJGXyz/J5A/QXMTXTPMCTT1C3MPq2eKJWq2ikyi+FRKvpU0CHvs3DP4UKu/BLcODZKN6BStBrODtcCq/BAFprvQXlhSie4hhCZWCTWCluA9aMbVcELI+s6qXyU2OXuja7SPK8Ryi75GnK+HPUUPJEufK1NmxyjPKJH0plHWUk1S9M9+M2fWO3QfZ+6S0pT0DkuGDgCPw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4555.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(366004)(39860400002)(136003)(396003)(316002)(110136005)(1076003)(55016002)(83380400001)(6666004)(4744005)(2906002)(8676002)(478600001)(8936002)(186003)(66476007)(9686003)(4326008)(66946007)(66556008)(86362001)(6506007)(16526019)(956004)(26005)(7696005)(52116002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 5+nudL8Z7Ol1Si3edUqfdRd29I/WsSUGH4Y6GhZZtA8L1OxUsorIlT0cUc4wojmuAJdU8920uxruqy4WbVMKHDyL7sMUA96puf9bGYVcpAJp1I9cUKqaHWnDcAC1K8mITwNM340gXUmeKncteowj0PEonQKGAE4ZC5jUEO+84EJouKuslvVB5wBc29H2z9vDU/05MPOElxrlCgnsSnuV5YcTWmo2OW+bCuoA7crIwGpF8xw+RROK+1OV2mn2FSRiIQTQU/fdcwhiBC4sAfyKm61TzQH4x7nhuoSM04ttBCHQ5u3eWqhvnsRpNT3/ySu1KvvY8oqlXA42EYgAnsq3JShP3CPsPkDfTHgbquFMm3Rf+1/C5HZMpo8zFdVnQCJzRR/y+jSTGqndWBjgDKXG3llhQM+OqjjZ5z63PFa2OBdhFjCjq2bDYeYLGXisn1XPtec/DBVdRdpoJAi0zznHx4+iHzlAGTsrDZjd5n+vafSwN+3Zmn4nCNuWXK+Ne0vEhJ3WCrU9s1SBiI7zZBZoTeVgiOqosxB5i9nAWP67pI7PN82Q0aAMcvb5gqYqtmHpxQ7jTi3iQs9eWxJxquR9mXGisrG9wr3dOUe64obRdAh3Ud8E8zpUiLAfnT2vBpqK+wQUHWyO5r4WkLlHFw61/A==
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73e3dde4-41f9-40c7-1efb-08d8702c8ef2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB4555.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2020 10:33:15.5397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +ULP+LLflsyIPLlg2pZOw3nG1gkPlnzeLFIet9O3ItYr4FwIn7WfOAvMSaap5ND8zqJtzfjeYTyUd/pysTDbeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB3114
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Auto CMD Auto Select can only be used when v4_mode is enabled.

Fixes: 427b6514d095 ("mmc: sdhci: Add Auto CMD Auto Select support")
Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/mmc/host/sdhci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 592a55a34b58..5e0ec5df4074 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1386,7 +1386,8 @@ static inline void sdhci_auto_cmd_select(struct sdhci_host *host,
 	 * Select' is recommended rather than use of 'Auto CMD12
 	 * Enable' or 'Auto CMD23 Enable'.
 	 */
-	if (host->version >= SDHCI_SPEC_410 && (use_cmd12 || use_cmd23)) {
+	if (host->version >= SDHCI_SPEC_410 && host->v4_mode &&
+	    (use_cmd12 || use_cmd23)) {
 		*mode |= SDHCI_TRNS_AUTO_SEL;
 
 		ctrl2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
-- 
2.28.0

