Return-Path: <SRS0=8+sB=DW=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87B3EC433DF
	for <linux-mmc@archiver.kernel.org>; Thu, 15 Oct 2020 09:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 173FC22250
	for <linux-mmc@archiver.kernel.org>; Thu, 15 Oct 2020 09:41:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="dOz/+WjB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387837AbgJOJlq (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 15 Oct 2020 05:41:46 -0400
Received: from mail-eopbgr770054.outbound.protection.outlook.com ([40.107.77.54]:58030
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727988AbgJOJlq (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 15 Oct 2020 05:41:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W9sd2Fajd/RBANiP4gU6I1JFy9QjWlKO6CPKcycUgGc4aYUd4uhg4hXMEuIPNQ4r18z6o+tmy5hd+dBQ+Df4jD4nhbvybSJXZyyEhO672ZN3y9dzEQFUDQfziukEMplCHGSzg8x7bOtviJOhLY6GPlLVtsfvAdg5MtdxDk7aSse232zcrQnz0ft0tJ0lx+TrzhnlTWerzHWM9z/JDPWquNfsZaQBAeI9nHn1oD6vgB+7WXWzlH6Y26rToJdpUuTpYCG8DrKJPvLt+2yJu5Uie+5gRhJFgT3LEAb6Cqd3YAfArAezrJkbMRhXYApVTSNZ0OqgG0Cec30Z/f96VSBBhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w9Mo0KMGzvxoAyx3pYvS1dpRzZS6KTPnccPw0qmQb5Y=;
 b=RAq9wrT8ISihfQ3g5huK3N8t/JB1+G/2h+dDXA/HLPI0IqjNxOcBEHDK1GbL4NsnvE9DYpyoKpDoyA/vrmb47mlt69YuHbpGaazFY3kQsPNWwufwccN7sfSdgZeGVeinUdvyjzXnlCifO4qqj7ofWJe3t4CMN1k4LS5JG8csb9+Gp8LrKEcJXtjaNRPz8asHaeNb3RkTUMdD4RGp677G17qCg6S68RpR5n/F1NZpuxlTNc1BbXO6TuHVJmcCkRInd4yhIM458jxIEF29GcqmAOaggB+mvHqQz1uCKQ5wFMLLH8uMmoW+qOh8kKOp6PcRqKT4LG1eGeX8s2nSvaGUZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w9Mo0KMGzvxoAyx3pYvS1dpRzZS6KTPnccPw0qmQb5Y=;
 b=dOz/+WjBNxm9MSlfHGGNrb9pb8k6md7KP4eOtKkP549SNLhGBNFA63TVFMyfa9QQ9OjkibfUrNeELk2SuNcayHYh81mxh4oDInEYJICPpkP6tgTKmgXO5FQeqVJbkBUGgcd9I1YK7/UGduLpUTx1mAcEK5LnF8twl+KX0L9c/W0=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=synaptics.com;
Received: from DM6PR03MB4555.namprd03.prod.outlook.com (2603:10b6:5:102::17)
 by DM5PR03MB2444.namprd03.prod.outlook.com (2603:10b6:3:6c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.26; Thu, 15 Oct
 2020 09:41:42 +0000
Received: from DM6PR03MB4555.namprd03.prod.outlook.com
 ([fe80::e494:740f:155:4a38]) by DM6PR03MB4555.namprd03.prod.outlook.com
 ([fe80::e494:740f:155:4a38%7]) with mapi id 15.20.3477.020; Thu, 15 Oct 2020
 09:41:42 +0000
Date:   Thu, 15 Oct 2020 17:41:15 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] mmc: sdhci: Use Auto CMD Auto Select only when v4_mode
 is true
Message-ID: <20201015174115.4cf2c19a@xhacker.debian>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TY2PR01CA0012.jpnprd01.prod.outlook.com
 (2603:1096:404:a::24) To DM6PR03MB4555.namprd03.prod.outlook.com
 (2603:10b6:5:102::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (124.74.246.114) by TY2PR01CA0012.jpnprd01.prod.outlook.com (2603:1096:404:a::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21 via Frontend Transport; Thu, 15 Oct 2020 09:41:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b1d617ae-6034-4357-a5f0-08d870ee8599
X-MS-TrafficTypeDiagnostic: DM5PR03MB2444:
X-Microsoft-Antispam-PRVS: <DM5PR03MB244471F8F771572F94CCE089ED020@DM5PR03MB2444.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:131;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +o5zqqHosYUPEWnVvFVzEXBE1T4CoGTfnvLotynJpk0xVCaWxqR9vsEm7altjwdm1XLrhmUkErKnnq/TVyd6k+lYO41UoZR3IcnzKfLQwQFFEJfay4azV5iUHd4U8yOPOwDUTA1wiWgYS5ST78enJiva/q9YWlhnIgvx2iuO1puEeEl5EUsCVFODRex9jh2v/o6jUYXxzkTWaKT3rb3CdTuw9ugJwN8lQDNFO2626DmM7j8L1ntcmbVJgGu8faq9IAAFH4yGaknmebtU0q461Jknr2Pd30tONGzm+3nCd7/J/Qv6DBGpeeX01x5Dpgj8FCZR5ft/udsu9sVvSD0rgCjRBMNzMApi7a0oFqaDb/WAyphPEcr5yFB2JHC82ndS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4555.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(136003)(39860400002)(366004)(186003)(16526019)(956004)(26005)(1076003)(4326008)(2906002)(9686003)(34490700002)(55016002)(6506007)(5660300002)(86362001)(7696005)(83380400001)(8936002)(66946007)(66556008)(6666004)(66476007)(316002)(52116002)(110136005)(8676002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: thkUp+9XGbmVk5i4Ha2e/3oRzkkhWKY9i8K9QnGJcBYA4GFKtmnn+ptkXXIuXDNWo5Z6gXMLFj7A89TSISri+IMisvhygjpjUYMTOY/eJw64LzfqZYWi1UrgnIEAnq4aK/m3zuamPUsppmCrTU+jr4D7GBitkFRATEtSZb1OAke00ftK5g7YWAoj2lcTc91uw2HxNkt41oqB8qt68a4opNHd5fox2ACPaGGi0b6CEhvo2iPGdgP8VPLFfgU2i/wOcuOlhr5+FNuDAKFULHR6Il4jEx6SPOiXzVq7hu3XmAINz1XBG3wEStmP24Kycsuq61cwwLeGzow7wjOV5i/sPQ7LC0WfNZzR7s6x0A2eTJSec3Boc0hNmka2+evxXkigkjp/tT7WoKb0WJAXiuzq9fLVWirn9qk871hpMjqULExe8OvIMp1vhMmd0oFLm6o4KqY8U8PTmrmlLYHnBnjRgBTF6kiLTZwR1drt0WpSINhtG9gyiSj+pEUGz7t0EaJLsZqHQE5xJ3qNPUUQK33GlVRav8ZMHLjtQDximJYszMJzRVwx+Y0Blgp6SWCCGrjiY0aX1vNVT7g9IcFN/9yZUy2WYVETFkOgsvtsUtn9sKS88U0hEeFLf8RQkIuoDRTwuBs9Y4pIWupfol53XYlTzQ==
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1d617ae-6034-4357-a5f0-08d870ee8599
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB4555.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2020 09:41:42.2160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0dNnTmWd4qLOVyvfdVW6fzOaVT2hmVdMHLDUsqWAcf50Dop07fisy46sSTW5cS7F3WgUZrEVphmevVRWHX1Fqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB2444
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

sdhci-of-dwcmshc meets an eMMC read performance regression with below
command after commit 427b6514d095 ("mmc: sdhci: Add Auto CMD Auto
Select support"):

dd if=/dev/mmcblk0 of=/dev/null bs=8192 count=100000

Before the commit, the above command gives 120MB/s
After the commit, the above command gives 51.3 MB/s

So it looks like sdhci-of-dwcmshc expects Version 4 Mode for Auto
CMD Auto Select. Fix the performance degradation by ensuring v4_mode
is true to use Auto CMD Auto Select.

Fixes: 427b6514d095 ("mmc: sdhci: Add Auto CMD Auto Select support")
Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
Since v1:
  - add the performance degradation on sdhci-of-dwcmshc explanation in
    commit msg
  - add a comment in the code explaining we require Version 4 Mode because some
    controllers(e.g sdhci-of-dwcmshc) expect it that way.

 drivers/mmc/host/sdhci.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 592a55a34b58..3561ae8a481a 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1384,9 +1384,11 @@ static inline void sdhci_auto_cmd_select(struct sdhci_host *host,
 	/*
 	 * In case of Version 4.10 or later, use of 'Auto CMD Auto
 	 * Select' is recommended rather than use of 'Auto CMD12
-	 * Enable' or 'Auto CMD23 Enable'.
+	 * Enable' or 'Auto CMD23 Enable'. We require Version 4 Mode
+	 * here because some controllers (e.g sdhci-of-dwmshc) expect it.
 	 */
-	if (host->version >= SDHCI_SPEC_410 && (use_cmd12 || use_cmd23)) {
+	if (host->version >= SDHCI_SPEC_410 && host->v4_mode &&
+	    (use_cmd12 || use_cmd23)) {
 		*mode |= SDHCI_TRNS_AUTO_SEL;
 
 		ctrl2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
-- 
2.28.0

