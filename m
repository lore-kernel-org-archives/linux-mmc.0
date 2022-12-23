Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81CA9C4332F
	for <linux-mmc@archiver.kernel.org>; Fri, 23 Dec 2022 02:50:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235667AbiLWCuF (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 22 Dec 2022 21:50:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiLWCuE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 22 Dec 2022 21:50:04 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2064.outbound.protection.outlook.com [40.107.21.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B862180A
        for <linux-mmc@vger.kernel.org>; Thu, 22 Dec 2022 18:50:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jk0rOlaEsA7hUF1NJRPaK0o1fdTkJy3mgzKG2HY+IVJTxA3ZBtv5lJvsT+GhEYcPv6nDP7eMLCsk29Iqt81xqGaxlgVPGJ5mcbMuN5jBtHQXPjFtlf4DRygW3YG5KQcjLMwyMmfFWLH4j01j3OKKO1H+0sir0xLvVpTkUdz8actySog/7VuYUMwJTHj3+fofBtT7jaJ0QCVts+gXcWG6hEq0B70g2HudgHYLlxLx+gcgJNtl9IRU6VMVSsaGyd8XRPl8xQlp5SedHC6St4orYSwvtr3RNkZPStDxVkW3nJwtnT8qoid2NVk7SSrgLR31sj7Z/s3mZtuc0fsMnGiufw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hyRdKYCOdidg+61mIpPunhwNXlj8w1M66vVXfX7S0zM=;
 b=h3U4qVqZGAjyGqUmq0ruRG+sKvZ7dftK06J6fd2injBgkUZIll6W61R7L4I7CBPX2ir8xIv9EPNhrGypNj3lUCDzeN+0LLHlEEO06xJzTJEEwPIGFPhEAEvTrODq387fXIFg3CfU/e+0R1dyj1u+XQrgS1V2mVix6xviMIrVRfONyXbwaav0P5UOGgMQ911AOFEFoMBD9Y8bhZtEnyXP//x9Jdkcbk6jE5uaQsErJnueOiHuPxTKsXj0BfJq5N1EdysgUU9xf8ZFz0J9745BNWRiIo28za4ynDsPKBaT4XJ3gIfJWg9zMP+8vFB5j4qA5QRcPdMxXuYpFrafBX1Hww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hyRdKYCOdidg+61mIpPunhwNXlj8w1M66vVXfX7S0zM=;
 b=KyFoRz+jv0oCejNqh6ulrSzVT1k9tCZBr3J5mSFJ+xnHqz9Mr7CFy3BkqqW2UZmEh18aQM5KS7KP6/gjTyzUjqgYQ/zcdtJ3vSHuBIYgE771ZKjYT88nCMk728y6P6IEtj0JgVn+6l5urEZgVR+mJ1anR3M4HSDe0qd8BDeDBw8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com (2603:10a6:5:21::30) by
 PA4PR04MB7709.eurprd04.prod.outlook.com (2603:10a6:102:e3::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5944.13; Fri, 23 Dec 2022 02:49:59 +0000
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::7479:76ef:8e5:da0b]) by DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::7479:76ef:8e5:da0b%6]) with mapi id 15.20.5924.016; Fri, 23 Dec 2022
 02:49:59 +0000
From:   haibo.chen@nxp.com
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-mmc@vger.kernel.org,
        kgroeneveld@lenbrook.com, haibo.chen@nxp.com
Subject: [PATCH v3 0/2] fix the sdio device DATA/CMD CRC and Timeout issue after tuning
Date:   Fri, 23 Dec 2022 10:50:20 +0800
Message-Id: <20221223025022.1893102-1-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:4:194::12) To DB7PR04MB4010.eurprd04.prod.outlook.com
 (2603:10a6:5:21::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4010:EE_|PA4PR04MB7709:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e583553-90fb-44b4-5a30-08dae49061cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WTRvPikUL4cVCD3XwfbG6ixEiZPd6mw6sEqLkNutSwo64JLQ1AUuQbEmeRRcz4ipeZktmwh0DrSwn7AtOBXHyBPZL+V7sT5wMzeH3h39kVc8arfgYO9jwfwxwTQV8YyBPJauQvDXr7R7ygIt7zJrakGbtQXTDfDTh1ZwUFqECzz5A3kqYAhUNwt84BDf9GHMwYnDcnUzWsyvkzZsTK4gBpw/kk/gHCp4dmLox5bYVVtv3n50a5SiFoNSD3to7074hRcJkB+qOGvE1Kpa2KbBMeapc42+vsq5i5i+q9c6o4P6Ac9NDw31MO4x11e1BbU5oxxly8oPmjOUTR4IUmlBdWECwUj15TGpgmLrUm44iFOJ6MZFH4laG+lj/g2LvPc6EV1/n5zQxi8Y4lahCrcj/MzRU9weuygrJHGAypC0Jq9/9D2ZfVaWI22/6K75irHtou+dTp2GUswWP6LtcUbYFUkKBu+KxQTmA53PVW/Rq7N4M0oEM4M7kc7CHiVeWebhIQOfe+qhnhCO6QhWqeOp2n7Vwf4xCk0TNmMP+Pjmni+rwy8shh7P3Bem20oBtn4FyZUj9fmdpD15yNP/AaSorFVU6z2JKHGSLVNRI6yxyP5DkDKthlM5vi6/SGlXq+5AiS8i+598vo3TrA+EowkA31ssopyTc6AqjCbgbTme7e9asw1jQzHgqYEeP1JO1rppjBoFjkBd7PDD6pkPC2HZew==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4010.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(346002)(376002)(366004)(39860400002)(451199015)(2906002)(38100700002)(38350700002)(36756003)(86362001)(52116002)(1076003)(6506007)(6666004)(26005)(9686003)(6512007)(186003)(6486002)(2616005)(478600001)(83380400001)(4744005)(5660300002)(41300700001)(8936002)(4326008)(66946007)(66556008)(66476007)(8676002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NmGEzpshjwFk3JY3aJdaA1SYBvjGIsSx/55H9Wjgw3bcOTZVAgycfPIeyiqy?=
 =?us-ascii?Q?eoAlxUaMSlEy0PGE3aykC8G8Vuny1N1nb3KeoscBhPl7GoaO3RNidHYbY8+k?=
 =?us-ascii?Q?KYehfhgQXReHyZTjHLpnTSqkUuRy0Hqk8KTkMj75TSIn98wMrl7cFHdfRbSm?=
 =?us-ascii?Q?DlEPRE/txXjPzpHwXp25+yFzre9JLwkDw0UE+0gG53kW/UfG25pXBdvY8I9F?=
 =?us-ascii?Q?x2k3FQHErx9lXXE1/V+XZTAwXKv9ntn3Ga2Jsf5mYBAYJPVvqwxWLlxvo2Oo?=
 =?us-ascii?Q?OoAkkcBgtZN2O0r6v6aNz+XOZdQtjpIHea+5ywNsJl6Lm6/vY148lg9h66v8?=
 =?us-ascii?Q?udZHq3sB195lJZKzeXJ4/i5Xelyh89TKr+qVPnG82fFpmpO0A8s5pq9OTPEl?=
 =?us-ascii?Q?BdHYzgHHS0S2VXD9h5ShuBn5KLzZ6eivhVnIzLLJFh92rn5LRbuUETnRXnNt?=
 =?us-ascii?Q?njDDAruhLTpKxFzVjiVIAb79lfOTC+oFOFjV9sDjBJboIFeyDC/p8W4KD7lK?=
 =?us-ascii?Q?/GxCSUAZgScf3bzJ6I77CxdrGV+B7PSNnddZlR6fU6vqSI1R2bYW5w4Guoew?=
 =?us-ascii?Q?b/27/+d6h51ex7SGnGAZJgRxQ7E4gcmOGDqmXOdXnkf9HxPcWht9YlKaLamR?=
 =?us-ascii?Q?WDXNd2HkLBzYQ7JBbxvJIf0n1Y8xkJLG1fo0QQucD+qpz8RDwKyJ4OwklPWL?=
 =?us-ascii?Q?X9YSx7NEa9kHCYg02i+gVPacDyzp/HMg+VUBFwigflwdtO6Jjn46xaIDJ4Xb?=
 =?us-ascii?Q?qi9CKJV5eeHcf4u0iZUM3sW3jmBw7rt4LHrpyn4Hye//vzaqUd7QOGe7Wes0?=
 =?us-ascii?Q?CKy8qmFPC7rHrUK7l7gMAmiDF/ktWkqBm9hUefmFGa4Lnqq6KbnuuECPneWW?=
 =?us-ascii?Q?ahznLMdY/z13gdo7vwG5jfu7SumiEDb0eoswpPV20pyiHC0hk86Iq0sd31FJ?=
 =?us-ascii?Q?VlnJBQR2QQV73c+hyba6z7ybALXrHDoq9UE52Y/VS4ZwttfHp6gB+GoeCb6B?=
 =?us-ascii?Q?Ao413eSIRchGf0Aa/ys34hRaOa4VF7aDvjZZrNA/kgyXfFZhJPTB9HMuTWx3?=
 =?us-ascii?Q?2vVuns2wVsQebCEbsm1RsVRS54Kd8pDVQ/Xm4EFZqlx/1UTKCybHqQ+piUGJ?=
 =?us-ascii?Q?pI9H65F91I19s+pZmvx/yN2f7F72jtQ/gtX/K5WaThwV2V6UC0HoHnAzzKDk?=
 =?us-ascii?Q?NSrkyRKSM/fhTUc3Bjz31VteuuQp2bNaoLHa+tWV6L1ZqCenLs0QrHC5b9zc?=
 =?us-ascii?Q?P5sIc+bsSIpoGH6VnXf6K0c95w/IudrLem6Q/YErDDW8v3KJCaE/lFCDS2Cp?=
 =?us-ascii?Q?EfPIdhPDisClXGsgnSu0TZwIgqQKyfEf6p8HnzcH7znoA3Aw3hOmCHFkh5PD?=
 =?us-ascii?Q?gUCEAG7baC27lUlmPKPCtHRQ7S1tdXr6ANIos/2Y6RxFZhO4c/UzPIqPpDE4?=
 =?us-ascii?Q?wE2hdOoxAXog0rrDdVHvN0I1wBYNNzXIU0IuHJaU5jJM79ble9xEIsf4JXjy?=
 =?us-ascii?Q?qdjrrgImST3RqKdXyusXm7HrGSvewvoLw8sVXkEuNg5oym/U7RbNvzAMLR73?=
 =?us-ascii?Q?k07H6vJ5AYnqslx57Yq5xVc6Vn64fqd8WBKvVi4T?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e583553-90fb-44b4-5a30-08dae49061cd
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4010.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2022 02:49:59.7523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R6VWD4F3aFdoDtOvh48J20gcXbKW0VurNmC4d8bvcElou4YOr7lVaRUThHajiaipUDHUWLBT8RLBh14Swdj+Zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7709
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

V3:
  - involve init_card() callback instead of change the common code.

V2:
  - drop the dts/dt-binding change, since this is one IC limitation,
    so handle this directlly in driver.
  - simply the auto tuning code logic.
  - To detect the SDIO device in host driver side, add some change
    in common code, move host->card = card a bit upper.

Haibo Chen (2):
  mmc: sdhci-esdhc-imx: simplify the auto tuning logic
  mmc: sdhci-esdhc-imx: only enable DAT[0] and CMD line auto tuning for
    SDIO device

 drivers/mmc/host/sdhci-esdhc-imx.c | 66 ++++++++++++++++++++++++++----
 1 file changed, 57 insertions(+), 9 deletions(-)

-- 
2.34.1

