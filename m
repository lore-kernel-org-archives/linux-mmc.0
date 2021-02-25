Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01597C433DB
	for <linux-mmc@archiver.kernel.org>; Thu, 25 Feb 2021 03:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6D7064EDB
	for <linux-mmc@archiver.kernel.org>; Thu, 25 Feb 2021 03:24:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236909AbhBYDYU (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 24 Feb 2021 22:24:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232723AbhBYDYR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 24 Feb 2021 22:24:17 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on062c.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0d::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C681C06174A;
        Wed, 24 Feb 2021 19:23:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HooQMv6Rqpj/odyIJq/M7GZLcOkwnS3AfB+BmTA0Cr7eytQEjfPYgLGrlobEcBa3h6F7MEsyR/bQtWOqXJir9E07nKmoMHB7ZQtL3EgW4RSZKgWBAqEj0ir0FbHT92JCcg0aS4d6gK78deYBWX8R7l7cCVuCHMmYzvxZwnQtFGxmzeN3XA4iCBOFo3a/5MC4ikXwAqz4+mYFbNeHj6pPnxYxs+K2Ar80KD7xBq56/rdJmf4kcDTnf9mYrI3K4cFTkBcy8bJ4df29ScUKBA3ER/MzZOpRsm3AGfGvBkS7pgd4vN8PGunmGGeXCKzmVeWLPKnRYS3iZz7OcgvnvQmv/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m+6a8icqAtDbcAG3YCK3+rKH0Kq0pZzuUvAjypeIuAg=;
 b=nnrHDQPpEajIT0gtoseq4lFCso25bO9MUgtdqRxl2NdiAIc6NMMwm/t4wz1LEA+nbHDbYNEmjCFTgi0K2oxw7I85+4H4TWWbhDdHCWsK7DRQ3V7vAmhz6CotLrDVO93uL5Gpg/3kd+acnYgFAFHNvIefcox3KCLCMGBnJtzalSOv9s8JGtKZb5pHimpXEaq+ZCUi50y1w2ZZ7Z5VekS9/5g6Ui6cuxN+DnAEHOrOvJ4396/DbB7d/G7hHEQByKHX/wEZNs5VT5uQT4sbZIQbBol3RPBbjzw6uWXdHleL6IIYq7a2uOpAG3Wd30zh5YCMcBOri0rIF1XfXt9YdEo43Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m+6a8icqAtDbcAG3YCK3+rKH0Kq0pZzuUvAjypeIuAg=;
 b=fTazeq3S0+qWfaa6zhFFIfOAvtd0nD8NoNAkLHd2JO/UHCe6gGINWwdGoOXPRLcc5uAJLb2xcmZvI7NCGsR7pszV7tQO8yzM44uSPq2P1NbUaCdwsWaRjCiXDVcgpVlCZOYP4BmsQ9rKrnh4XVLh7BuYlOqn5xsKbvv7TthduG4=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB7PR04MB4089.eurprd04.prod.outlook.com (2603:10a6:5:1b::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.31; Thu, 25 Feb
 2021 03:22:39 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d58c:d479:d094:43d0]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d58c:d479:d094:43d0%9]) with mapi id 15.20.3846.043; Thu, 25 Feb 2021
 03:22:39 +0000
From:   peng.fan@oss.nxp.com
To:     sboyd@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        ulf.hansson@linaro.org, adrian.hunter@intel.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 1/5] dt-bindings: mmc: fsl-imx-esdhc: add pinctrl bindings
Date:   Thu, 25 Feb 2021 11:10:00 +0800
Message-Id: <1614222604-27066-2-git-send-email-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1614222604-27066-1-git-send-email-peng.fan@oss.nxp.com>
References: <1614222604-27066-1-git-send-email-peng.fan@oss.nxp.com>
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: SGAP274CA0007.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::19)
 To DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SGAP274CA0007.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3890.19 via Frontend Transport; Thu, 25 Feb 2021 03:22:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4fe80409-192e-42cd-dc31-08d8d93c9a90
X-MS-TrafficTypeDiagnostic: DB7PR04MB4089:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB40898EF21C88D14B2F2C61DAC99E9@DB7PR04MB4089.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EaO17I9tIou648zh+Fgcw+0kXL403oQjCavkUWBpQz2ayqoCy+Z/MsewoHFZqhRiU1sHIRLWB5UArmhxry9OjcuTVqu4vF2OksMVM05k7LfQK+GEIdEiK1yJCu+sGrbot9W5pks33GNg0RG+VQiBCPm0ZzDg11S53TdiKEHjvNXOOY9DjI7hH+Xz/UFOddw4apN1BBLYBy9XhSgqy/rXU3hIFojp+D/tzqY4oaDvNytKCss9XI3iWyzilQUobaZ3MKdU2UH/HzWcBlNzaYk8Xy75qfeUCTyJe6gwvcO1Ys33U97wqKr/reuTS2ME2Pgr0dAtTtiQmkkjm5mj83X0tXFCZbei6gC74ExBX3e3FdUmXT7l8w+SZU9EY62P1olIQP9CHyoWi4sMzs2aicD39QZRGtuYFw5B/XzEZTZcFbaoijkO4NFJ6baffeM85o0/nmXkupb8cUyfWoMDsS05erY2x50Hi0yieYxoA03M5N5OioxlfSh5eZHliGT0gCcinDBMHHcT1mge7uTjSpSBbDUdxLCrdhc6XwWFLzs3rfMMDde/+Dc1z81mOZen5Gt8CtXD7irxKL8cd60xJ9aWyQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(136003)(376002)(39860400002)(346002)(6666004)(66946007)(316002)(8936002)(8676002)(66476007)(66556008)(2616005)(478600001)(52116002)(186003)(4326008)(86362001)(69590400012)(956004)(26005)(6506007)(6486002)(2906002)(7416002)(4744005)(16526019)(9686003)(5660300002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?baFyEwEykw8goRi6daJDHZaPEPahcQ1Ia3BuAHSpwUiuwjCFTDkuocuYxSxZ?=
 =?us-ascii?Q?HJQ9ioT84nPS3cg3bg6vGvTfuRzw5OPPpdEXopijKFBk2Ou8GzQyxAYRIZ0C?=
 =?us-ascii?Q?KB1Smu161pCwNo2VYF/17Rsn9ua77LcJTI9Yl0eGvSZibZscmAe0PeMJ13F0?=
 =?us-ascii?Q?7QBJZNly5YqUdHT87DxniEC54fcJOGJ3LlQafWXmjJ9rKhtBCcZoaJYI6DlW?=
 =?us-ascii?Q?Vnn6T0OeJvg0V2D0knc0GJDEHHcOTKo06wlnDMjSPu4AOKMAWor9F4yNZtU2?=
 =?us-ascii?Q?fcgrHZ9StHviz4pBJC/FL9BvRUQU0jmv9hrxuRbs68Pg39cqB/4KnLoKSrmG?=
 =?us-ascii?Q?wZLTubTdzCANPMfwsOFLX5YNEMQ3NfAAxE/LqY8F8ZrsZgIRinl0XP9Dkxg1?=
 =?us-ascii?Q?AJyz+PiUuife3FgLuUxFiGdx6IwAEKskuFDXEx+9718C52beErKHSQJKWi06?=
 =?us-ascii?Q?GfYPfU7uohP+KJdVLWKrSW2Q0vuxH2KtvzGwj0hH4nfS/SRq1xe+oO97dKW5?=
 =?us-ascii?Q?0MVAk64FZS2PW5SaBVinHYoZY7ps6EDwFS/02ys8x3IGfC70kOMO5qPmIdXF?=
 =?us-ascii?Q?H9dfevG7BOUtT1uJdlyfQO0IWvBFaThvRrVM/GRvd0pN9+dse1GW6z30DKyr?=
 =?us-ascii?Q?YQ1jAPgIjTqvPBg670MdmXV9XIkEG2046gDDhukkIvCNTFfWM+m8/WRopT/I?=
 =?us-ascii?Q?YIw7ssuxf5YhSMfyNX51K4QYcUXknKt0I5BwUjxtyzxjTKiMLS0hY70ZR7KX?=
 =?us-ascii?Q?zF4WSR4BBNVw+Ha85D/4088j/fUhC84wC4W43Nb1+tjSoMRlePkh0TR2rqBm?=
 =?us-ascii?Q?Ael//NCTMf8BqapQN/XrklLm1E57MmKrLg0ES9f/NGDoAGAHFs+/v5GrAMBj?=
 =?us-ascii?Q?igVzRTziDSDw8B0MRgB7Gd4/L0VJCokBLAVn4uMFR72mIzx/uK1ZhCynGthU?=
 =?us-ascii?Q?GYEA7u6X4XtdCY6UPii034MH2p6UMUUVk5ac40eiLAZ0cEKZb6phGYPxlnPB?=
 =?us-ascii?Q?QXgnUJwyzBpjmheg3O+8fAwRqqQKowhQOAug9lnVfPzrf1hSDplpkL+H1Zrg?=
 =?us-ascii?Q?x+qRl5H8o528Itiif+yQyhzYZ14y7kZ9KiYuA1W8FhHWFoVgTryiGpdoDBon?=
 =?us-ascii?Q?Z0bg27P1xNq0feZ3Ty9kp/9ofJSOrs+AzjVy0Dwa0ZckDyllAk/Ojl+7jvoK?=
 =?us-ascii?Q?A/lpx8rstvpCX7ZWTKaH/YQ8lcmOYscbm8yw/BEuMEGH9mUuZgz/MS7IOoCI?=
 =?us-ascii?Q?uh3SHjDJunib18PbJ9mIdvS8cmC9h4zV1lG4RmaMHd8+ojuYzAVX6P815tV+?=
 =?us-ascii?Q?WPk4Q5fCnPsGuMlDGMcyjOXU?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fe80409-192e-42cd-dc31-08d8d93c9a90
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2021 03:22:39.1863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gVWhCEPDtA8hU8zJ+4gfe6G0JPlUpDv8X9OdLSKRGN8TaQ+nvFnDZgVK8gfBkQOPUdeQyDCsLqAzfLOF6qPPLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4089
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add pinctrl bindings for fsl-imx-esdhc yaml

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
index 802c9df23752..a7fbd8cc1e38 100644
--- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
+++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
@@ -103,6 +103,15 @@ properties:
       Only eMMC HS400 mode need to take care of this property.
     default: 0
 
+  pinctrl-names:
+    minItems: 1
+    maxItems: 4
+    items:
+      - const: default
+      - const: state_100mhz
+      - const: state_200mhz
+      - const: sleep
+
 required:
   - compatible
   - reg
-- 
2.30.0

