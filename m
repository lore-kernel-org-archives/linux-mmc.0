Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB13C433DB
	for <linux-mmc@archiver.kernel.org>; Thu, 25 Feb 2021 03:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16CEB64EC4
	for <linux-mmc@archiver.kernel.org>; Thu, 25 Feb 2021 03:24:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235918AbhBYDXu (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 24 Feb 2021 22:23:50 -0500
Received: from mail-eopbgr40063.outbound.protection.outlook.com ([40.107.4.63]:28622
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232723AbhBYDXu (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 24 Feb 2021 22:23:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FWu0i/zb40KEGYua7u6obAeZSTiBv8+YQmdILuZQQwGkao9aY2rDl9/UupRN3f5MZP3Uo8ihqGKBjp/leUV4KhkNft+0EsU/Vqpj/NRJ470+z5f/mRWGVZ1ej4EjxCYB/+7IkAIDlYQBfI/rE6XyhgkgcS0oIUHe/bhchXN13zfMi09xgbssMeu+AgSK8Cpvn1Ng5YTdomoogYLetDslFwcF4tisTF7oS2jpjbWmYLrJl8XI/wgC7vBHieOFYpzOngsDflLlBOzq37csinQ4OUe0nXH34Ik5A6Px9WWsg8b+3zzKeKtKYOLuqKbL+9BQuhEVXhfsYo0T1frjtDzVXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lck6ZS8A2U9T+PdekfnW8U8SUFXIjFDjy5TRKWl5XXM=;
 b=Nzx3oAP37m5yDM9ysjXNKZhHtCxA3ZZSex+xI0lFrwrO5D/rlCvtYh2a5LpgVc26ju5f2nM8agH/4iedG0LKIt5lPSZvdKSKCD6N59XEy6xOB/FwvMkCzNXWBLKASsXnSY9x5fcfHVgpiRNjr643jFe2Pan1Pe9juNX3JcHk6sD7MpoaPChZUQHouThM6Qa42Kr0zubh9bi3aioIiyr09EhhU3q7fpdpLsdvrf57WAwvCrb0V6c9Y6BIp0Fe85JYIDNq03jIZtLe30ou9OTjnqptp0qTsgX0tNtogCSscrm2LIfXMC1iYCI+95Yu8jf4/HQ1UA4FZQAwUNBGStAWDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lck6ZS8A2U9T+PdekfnW8U8SUFXIjFDjy5TRKWl5XXM=;
 b=Qi1BDqQY1ZozV6lnsm0giqNX6Map9psX3K/S2ZqwFTWZWYVgM7YzaVpHpgNmSiASoYVrSxWho34v9QOd6PlAUk7kKq13TPQ01QiGLvW1KRN5XtztaEJG+qRATVEErlupGAgsaZ762r1e/SIVwCp4pNDFcYENjffg03p3CE17NC0=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DBAPR04MB7222.eurprd04.prod.outlook.com (2603:10a6:10:1af::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Thu, 25 Feb
 2021 03:22:59 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d58c:d479:d094:43d0]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d58c:d479:d094:43d0%9]) with mapi id 15.20.3846.043; Thu, 25 Feb 2021
 03:22:59 +0000
From:   peng.fan@oss.nxp.com
To:     sboyd@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        ulf.hansson@linaro.org, adrian.hunter@intel.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 5/5] mmc: sdhci-esdhc-imx: validate pinctrl before use it
Date:   Thu, 25 Feb 2021 11:10:04 +0800
Message-Id: <1614222604-27066-6-git-send-email-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1614222604-27066-1-git-send-email-peng.fan@oss.nxp.com>
References: <1614222604-27066-1-git-send-email-peng.fan@oss.nxp.com>
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: SGAP274CA0007.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::19)
 To DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SGAP274CA0007.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3890.19 via Frontend Transport; Thu, 25 Feb 2021 03:22:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f408410d-0c89-4925-92b8-08d8d93ca6cf
X-MS-TrafficTypeDiagnostic: DBAPR04MB7222:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBAPR04MB7222285E2EE003B18C9AB8A9C99E9@DBAPR04MB7222.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:546;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WNvVANhwfWvA3vTXVH/e9+IIOctca6BZ9rNhErMK1S8tq+XrweGG9Dc9nCqlJb73iNXHHK6fB0/jvjYtFmrmzlWa9Pwm/Bz3KUbcdOyNsrGjarDY8lB3vWWj/6gwxiXblmafGPaTWaJzw7cYgzR2UDksEtdTa0ux+NirVxq2t0DudXv0TVA8Mr1zOgg5sq0MD5zqVKu8e6t/bx0S0ZjUdbhYkT2CJhtG4NUDUaKokW7ljAy7uw9d+k5oZsqDdHmTCDO0DaYhNKVjh5uZmBwqMZXpd8z5gYTY4p/I2CMomPgy8SEAQGXXnn0DqRytceVMwYN2vjlGze2ZjC4mq7whkWqtmXsnH1tg3RRvT/dEGEnI10aOKgzA6Nkes4WfD7njm0USP3NcpkTgrtDBhN7R/kp/CGHezsYzPDIEHhW95K/vTaDfoF4OIhswIvbBPecIJ0+TqzmLLoDK59nYQA85UNMPC5WZEFjSaKW93lcTnFHATE6wmOnn9sSPvCpFD6CtnsINydHgDPPcprXTSbXuSCql7SY4fTdBkKExehuR4n7C75ubF9tseIj8WqB6serpbNRCQzde/76yyjRSOYWvhg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(39860400002)(366004)(396003)(26005)(6486002)(5660300002)(66556008)(66946007)(66476007)(478600001)(86362001)(7416002)(956004)(6506007)(2906002)(6512007)(2616005)(6666004)(9686003)(83380400001)(16526019)(8676002)(69590400012)(4326008)(316002)(186003)(52116002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?SPGrzSHYtxpOYXFVSfTyy66FHRj2o6w1AckK8GddO5z9yrG6rmlPqGcUBLVL?=
 =?us-ascii?Q?ezlwdu4QQiKNGP897BsVZqH/Ed3+JLk+7HLRZYYEypP6kxcgxv7xSZRCF5FR?=
 =?us-ascii?Q?wrOY5knBcOKPlGbH2m55+jn2zhzC+9p6zSHv73JA622NGxM5EWr6dt/ibMVV?=
 =?us-ascii?Q?vRcIxHvulPu3Y6oww+LxwJ8TLA+1ygeEfey5Usdh1CMGrh/lDA3/THaDUblC?=
 =?us-ascii?Q?3iXJxpXM6n03p/C3Gn2Y+/moVvmbQ4YNWFU9XXOctaNb5sBhjnUFzUSn8/9o?=
 =?us-ascii?Q?mWZuB72YPzByQAk6krZnRkorrpng8zTOmKJUqFFagoma08PZCi+BiAXfIFiC?=
 =?us-ascii?Q?B4mqzzCr3lCBnXevDYVBaC+O/DxbRbqAWvSC14yMUcL2kcPapddeXoM/dC4M?=
 =?us-ascii?Q?Bl0oOgvZEoF/QiGR5MxBXq/CUWnJL6miCcdDYqtbLQxLWJ2PXlg96DigA1y3?=
 =?us-ascii?Q?WF90A8ooC5SzCiJ0gENyRNPUZxN7G+5VFXjsBFYxyedg9O4HyVEfHOapk8w1?=
 =?us-ascii?Q?TPnWS3Pa+yHP3RaqAkcI8mEGoVqYJoH7TegP3laaeVem3OBeMDZwDNDyb/Os?=
 =?us-ascii?Q?M+Ht7iDh2q5zgtikyZogYigLoCFy4p6zbSSbCmimRXFe7nn3YtgUQi5QqHE7?=
 =?us-ascii?Q?B5ugDOxhM3PZRDFHh2o5G78lSWCZMvkU8DI5Cpm2ELajC02NvjgkHv8Nvxk+?=
 =?us-ascii?Q?JSh/4gYmJhRXbfryOMf+pNn6Clpv5g5sqJ5K0E69k8mdlonaBtnchQq36dfM?=
 =?us-ascii?Q?Jbj6xUxwKjk4eded56FOTsaSL/l3uipU/xAB9b+TIPfydXxtHGyo8IaBh0p4?=
 =?us-ascii?Q?OEivjRbxIG+cRXuvK1Is6EXTFuLPrO/ifUc96/QIVpIn5ZqgfjsZ+neYDHw+?=
 =?us-ascii?Q?cDljirM0nOS5sbddehYrnFQaBrhx7triJiEJPTk1NqHVnU9iFeRnkPO/tCrh?=
 =?us-ascii?Q?HL25nrHjlvW1swCzxxsarpmrGnSqV2URJ87yPuZDxDmVLCkbUvDTlnrIeXgZ?=
 =?us-ascii?Q?RoKkX3WxdhClWJDYcVtaEistmvSQYUKDBlsFp2C53Qlv+p7F5uf5bXavtHeM?=
 =?us-ascii?Q?bkA5YfF3tPVzQ74s1aRsadHtVdlBGFZd69I5ID2hCF2OJxWxtbHRg+HTpwjN?=
 =?us-ascii?Q?CSdKAB1PJb5UU315qZR8KMqGLLfwSwvUF+0vfPwhB0OUFGDI5lDVOqVl8McO?=
 =?us-ascii?Q?YwMQyRs0XGM+JUY1KMSCA6MLf+nWH/YsaFfuj14Rm8DlpIoZDKxlJm0LHRCI?=
 =?us-ascii?Q?02zZoUvksZTHzf31zlbOJe7IHN+5AJNaW3WImdCCkIFuk4Ij8cbKDjOQtpmC?=
 =?us-ascii?Q?VZxRwQ+qNqfcWfDZcElAu7l4?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f408410d-0c89-4925-92b8-08d8d93ca6cf
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2021 03:22:59.6659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: srLEI1leelfHm0DpJBd0oAWo12FUorhLW++ZzNpobwY4S6b4EYeM8YH/eozEZAQqMIQykXSVJXvq4HCkJdSptA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7222
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
index a20459744d21..94327988da91 100644
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
2.30.0

