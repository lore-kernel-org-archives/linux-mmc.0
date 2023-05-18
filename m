Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1189C77B7D
	for <linux-mmc@archiver.kernel.org>; Thu, 18 May 2023 08:17:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbjERIR6 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 18 May 2023 04:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbjERIR5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 18 May 2023 04:17:57 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2087.outbound.protection.outlook.com [40.107.8.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D2FDA
        for <linux-mmc@vger.kernel.org>; Thu, 18 May 2023 01:17:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=loL76uCeo4/UEb1fqLVf0jU94jqOIbbbcZaS0uMbAUByT6XjJJDe/ByyaicF1sVdohHd7aDc2du4klvJ5Agsm0ZgCE/P1vzkB2N6xhObGayQtA6Z/ZLIvV5PkjGtddbVmeS84BsxFFKbkNrkxoiLMaLmJ4i+GBr5+iK67ncEoSBJtU1ne4vozg6Rna7zErsHkibSCkhbUkevlcvxGlM5Aj2jKvnZJz+Ybn24IeXF3iAu6DInNYVGDhBJ/3+oMRNABkBJGOtQBxEmORJzbojDxkBie+NTfgwtieseOkNaYJ+/VoPWL6q7NnHhIEWI8vl240bLlWydG14U7Ah5HditDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1aBe02MTKRQOv0Ma1J9LGLTKQzYjbFxTx03arXxe6tY=;
 b=hRpQ1pkZS+s8jxW228JoI5i8xg6w5nhLrMnfwx6QNYhiycCy7isbDs/MGWwEjXmWwwqHqcpYNP84g29z11uZfWfqnWJB0VJx12f1eZb4jxy/ulgLFGbHyvlwnqDYRiHF6eL+5fxpkkhj9WG0IvHQOjU5FzYOdHlGxhft63RjfU+JyJPSpE2EUewAxQ0rP4ARLwzQImyywGtvxpw8oQe0dcqhoIy5o36s1Nji/cV5ABItIbmFcQ5EgMvWX3NFr1ltWTh0hJ2fLiLlHEcNBNIpxohD4oiEp+VIXXqOeX7xNXErW156mWxkoY3H8Fo2M/201N6pyOFq8DeeTeFXCmr0hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1aBe02MTKRQOv0Ma1J9LGLTKQzYjbFxTx03arXxe6tY=;
 b=JdeTsWRysYYHDO18wqCU+wbc9tuKaxaiW2cYLc/RO4U7jByBFuIHUf+CNhfA5pbAlPsnAoLrV0xgMvTEHRzARDDVtiRk4qTppbpGfiUwLTlIIm9IJRS6IVzIuD3ppmoT4aolckD9PVYA1bsz+jI2bsTkKriN0lWalwVM13tUAHY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com (2603:10a6:5:21::30) by
 AS8PR04MB7573.eurprd04.prod.outlook.com (2603:10a6:20b:29e::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.17; Thu, 18 May 2023 08:17:53 +0000
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::60f8:95d:fce9:16cc]) by DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::60f8:95d:fce9:16cc%6]) with mapi id 15.20.6387.033; Thu, 18 May 2023
 08:17:52 +0000
From:   haibo.chen@nxp.com
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org
Cc:     linux-imx@nxp.com, haibo.chen@nxp.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com
Subject: [PATCH 1/2] mmc: sdhci-esdhc-imx: enable IPG clock before register access during suspend/resume
Date:   Thu, 18 May 2023 16:20:34 +0800
Message-Id: <20230518082035.335112-1-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0127.apcprd02.prod.outlook.com
 (2603:1096:4:188::7) To DB7PR04MB4010.eurprd04.prod.outlook.com
 (2603:10a6:5:21::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4010:EE_|AS8PR04MB7573:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ffdca60-f12d-42f0-1d03-08db57786017
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3wcXBeIywSoebaez/x4kqp5ZtQC7qO83YcssUaSz+WBuCZryDf/dgA2aiZjOdIA02qvVqa5+vrXUxwZ1DCJZ7kxWkiKZXta+MjbRr6F0MTtOhXg1A++dfvAEySCaYc9totSYT5RK1JF8edI/x0upQ0DhMc9EQOzeh6vARLgyjzxg79DeIH2kK4K4kztv8WavlZS5IP16QnHeVt1wik/6AQP0XWfbYWvOTi+AV7T/Jc4JpN5inLxcGi1wHmEYHRe/VIpjYWq8cJh4wYHtJ0nUwc0g0Ggg7QdN8JwQTZNVzAIrCFc+5z50b8zbYfBlWwZmKI2gOr7dfCLKEaO5S6GEcfnzhkjE2jmdNJd5hAarrz+dMx5/fDQ7na6QVZaLXCMQWJemTNsdh7yRBrmHDc1EPNizaMhQMceSPpNZ/FRIz4OwqisnUilvHea0F2eUgveNPzWodY67zrEJ8xGNa/ByqRLSmb3d42DLIWWyv8VzlOJyesuxcfjL8DxlGGqEE1QTClBrerQK7eWiK1uWlsYLX4AMXB3L8yObn2UOITMJ6EiWEgYXkUBrcr0t89YZTTCNmOgt4Qtmu3zyGwGLssLeY3X3wmf2X2FSGwG2oiDZ+rASLLkD3pdTk5+uuAAcVExH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4010.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(376002)(396003)(346002)(136003)(451199021)(86362001)(83380400001)(41300700001)(36756003)(5660300002)(8676002)(38100700002)(316002)(66476007)(4326008)(38350700002)(66556008)(2906002)(66946007)(186003)(6506007)(1076003)(6512007)(9686003)(26005)(8936002)(15650500001)(2616005)(6486002)(6666004)(478600001)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jwT6oXInQugSpRGRy2TpytLMDef5TAvZHLFWMKAHvnKaHgHAo8mtZZvG6jsq?=
 =?us-ascii?Q?CNOz58beCey2pzEwxL0ftlujZCcZrwTUnsWh51dMI9FpXYFUTxwApaPZJQ8f?=
 =?us-ascii?Q?aftiX730yTnS4e+Ix7yQ0nR4C9sn0vHcKIZ97aNSnxqMSfYyVk/60nlavqvm?=
 =?us-ascii?Q?yNbGRxedmpo9GXUvWPHoXYrP/rRZIgmHG2jmgwivIiqtgu0VjAyn+P8b3RpB?=
 =?us-ascii?Q?+19t3UgSvXxwO0V5lEp+FzZ6S9JYyVs26vnU7cbBtzqmVxIDaKCFIRSR5bkO?=
 =?us-ascii?Q?QCzzDjd9EGIcyvSP7+tO9XbVg+Al6J/9R+lrjzqldLKpwUntb38UPuOmj4pt?=
 =?us-ascii?Q?Ffaleomdkc4TQKImC0w1Tv2e7fpUXcs785/Jdhz9WJEGXcpr3fdXPTNSvxrk?=
 =?us-ascii?Q?O+Dm56sowPN3tC+G80G7UF5sawKbtDNGv8JCr6g0la/F5qyhYtGE9XrlTLtp?=
 =?us-ascii?Q?loCAxUEMzimZ55QYN8VY/Vva0ju8GwhP4WymJIxtKMjHp/HIpiLZ7G+JTQwl?=
 =?us-ascii?Q?qSZitMNSfTb8eQDI2e+Z6/jN7GO72Ne2duauIye21J/rqZC1vY9AcNM0+JbJ?=
 =?us-ascii?Q?4qTGGL0wLgRJmBo5yrD86x44ep3S7+1vgdpgaHLW3/2j099fJfyNgRz3f3Qt?=
 =?us-ascii?Q?D3Thv42+bLpGOe+E5JCZSI7xH6W/p8YQ4dgiGeKDb4mPH9dyPM+tmfSCtvHW?=
 =?us-ascii?Q?WapDp0NfdPLz/JewAs2J4/jHlKbvN/Gq6DMUG0leoq5Zp+yoPSb0SKuI5zXy?=
 =?us-ascii?Q?WOk5wH3zqTkAGqskefrTFkPh4s5O/q3L74YYaFtXwQmoPrBvANChQ0ythoK2?=
 =?us-ascii?Q?1sGfNQIlT4Rp2wEsJj47jQ1+6ltilJ96u5Dy4sq81Ed/7lkjdu7U66SpKc17?=
 =?us-ascii?Q?b2BJcH2HF5USOy0FDUdBjFpncT2JKR9mNoYB7deQuSwJG1yFz/32aZ8vJF9o?=
 =?us-ascii?Q?7Sp/8/f7ZKQNGuTzN9kDxO7O8pqEd/J0YlUSz+wrIfPKsBiJa4UGQY28V/G2?=
 =?us-ascii?Q?BoIBs2TTmgGUYGe+XFhQH8Dog2fZqb7wkevbeBnhBLH8xtpa3MdWTM/HMdIl?=
 =?us-ascii?Q?p12RftMj0H4jSO80v4lMWFhEJyym6erhmYXgp9j5zoGMP9U3NbOpEjnbWGje?=
 =?us-ascii?Q?O7KksqNckuH5GtKVtzHLTx6dh4UJLPBWgH4sSugufYgvXDQCZ17pGrU8w7MV?=
 =?us-ascii?Q?45vg71bn91APd1vzLzHv0l+bCMLQhKZRNrgLmv5+YBJpWXfUX3L+qqlnN73f?=
 =?us-ascii?Q?FP+JfoFcIxr6JMt0Ms9sGDZ8J6glq10/10DVrZ6r0wvtDGwFoea9bSL6kDe/?=
 =?us-ascii?Q?kg2Hju5ZmKllc7NuQIHUbkVgt/cVRTbqAgb2MfXyZBYeKaa7k6uPMOtky9IT?=
 =?us-ascii?Q?8QMhyXu0wKkYSwmswltgVclbutYV0395LPhfYdEBCO8M8Q+zlqdJ2IfyTomj?=
 =?us-ascii?Q?sptOa2NCbeM1i9HO6H6ALx04sPN51KkbKsZewqwOHq+/kbUtDR/PuyEoCdmb?=
 =?us-ascii?Q?EPc8172exPz3+2BMry34BEiUUT2yVpJfj3y2dYhQbGsb5LE2qt2IZOrgoCza?=
 =?us-ascii?Q?6rd4Zz1M3haPkIf6KhjczH7cA2S6G5WWs7HtAlYz?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ffdca60-f12d-42f0-1d03-08db57786017
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4010.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 08:17:52.4713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mRAHOjvu4JMIvTEpjeUjfdGUN3VJ4cwD0eUUL+wrYOZ6lY3o8MTBcTv4DsNwtlZqXyRm7WPsWhuILNOWMIDpBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7573
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

During suspend/resume, need to access usdhc register, so need
to enable IPG clock to avoid bus error.

Find this issue when a card slot do not insert a card, so when
system suspend, sdhci_esdhc_runtime_resume() will not be called
before sdhci_esdhc_suspend(), so will meet system hung or bus err
once access usdhc register.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
The first thing I do is try to merge the sdhci_esdhc_suspend() into
current sdhci_esdhc_runtime_suspend(), but find some obstacles:
1, sdhci_esdhc_imx_hwinit() is called in original sdhci_esdhc_resume(),
   it will clear the DLL config, which after remove to sdhci_esdhc_runtime_resume,
   will finally impact the DDR50 timing.
2, if merge, everytime after sdhci_esdhc_runtime_resume, will do re-tuning,
   this is unnecessary for the normal runtime PM case without power lost.
3, the CD gpio wakeup. Seems strange to enable the CD gpio wakeup in
   sdhci_esdhc_runtime_suspend().

So, finally I drop this merge method, and directly add change in the original
sdhci_esdhc_suspend()/sdhci_esdhc_resume().
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index eebf94604a7f..4cf42a028bb9 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1836,6 +1836,8 @@ static int sdhci_esdhc_suspend(struct device *dev)
 	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
 	int ret;
 
+	pm_runtime_get_sync(dev);
+
 	if (host->mmc->caps2 & MMC_CAP2_CQE) {
 		ret = cqhci_suspend(host->mmc);
 		if (ret)
@@ -1855,6 +1857,8 @@ static int sdhci_esdhc_suspend(struct device *dev)
 	if (ret)
 		return ret;
 
+	pm_runtime_force_suspend(dev);
+
 	ret = pinctrl_pm_select_sleep_state(dev);
 	if (ret)
 		return ret;
@@ -1873,6 +1877,8 @@ static int sdhci_esdhc_resume(struct device *dev)
 	if (ret)
 		return ret;
 
+	pm_runtime_force_resume(dev);
+
 	/* re-initialize hw state in case it's lost in low power mode */
 	sdhci_esdhc_imx_hwinit(host);
 
@@ -1886,6 +1892,8 @@ static int sdhci_esdhc_resume(struct device *dev)
 	if (!ret)
 		ret = mmc_gpio_set_cd_wake(host->mmc, false);
 
+	pm_runtime_put_autosuspend(dev);
+
 	return ret;
 }
 #endif
-- 
2.34.1

