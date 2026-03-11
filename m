Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013054.outbound.protection.outlook.com [40.107.162.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052DF246798;
	Wed, 11 Mar 2026 09:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773222506; cv=fail; b=S/bR+FT+IvxqEl4d1PIqNnxxvuWr2Olx18bHInFxY1a2YsyYrReA0QeeUCu6PlLxNFJL7i+i3lnniWvFbb3tH6g/d7zgRSbR0KDuFhVRKe2ZJQjrTVF1gxKyeG3I2tc5TiJan0BcqT2Q8AWewWcQA/P171QCDrHdHZf5sLG70Bw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773222506; c=relaxed/simple;
	bh=sy6PHk2PPJy7GuC4URdcb2w4CaNpZbv8g4+5muVrr8E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jPNhRiBAcVHT5UUM2pI3K2AXHfLqxgbki5NeXi6FeVSZofJm3Bk5TWxhVSTQFwNrQzTlxSZqhpIBGcdpKH0sZoCyzE7z7maomkI+WdM8ubqJAkSP5wY0k2LKAXZoO1zab4gx9yaW9kY+k7IEG6k3QgiVTtjitWfEHXDhnAHxKPw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DEbXOzyg; arc=fail smtp.client-ip=40.107.162.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DEbXOzyg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LbQKoCUS3Cn3u0fFk6Lofej/nujYf0x01xD6DUxsB6PWqLj04rC5WpGLQrCd3leY9ed8BOx7gFQyqsN3wxPmeJGyFyBP0qWNv3cSEUNd96UK3MU8mF+KDHArka+OaSS2/P9hrJh1Ma6Y7vRp/uSi6gBj921iuR7cOk7OiajLyuyRLim4VywNbAmp/Y321osoq/Y9dqxMf0cOPeV/MOQEp2y8S90XccysyH5KpZsYsn6SlSnnuH7cFBnkXx8dWOM9EIrt44Jtf79CV6cn5Kgc/KAhalMvHmZByDTcfHpuA1gH8x9jMc9iDAnAMndVOwgK0U6DH3EuLgxAdGxREGsQHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=haJvVoLLYX7H6/gRzEEFi7D/pD2Trkl9NS0YICHSZcY=;
 b=NfgfF0cVb/kRk7gJvQB/kpXHF1gAlyetO20P7v7sHLFbQz+4ljakML+pA1t1cKhfm7hIjTctUt2eRj0zxC0PSXu2LSoOJfl4vYEfnGRbW3HZnQNualDbXxBvFVgcaUlHEaK7+S1qxHcCPdGUILyrvoi3DLH8+Les9PrxTUkKsyMc9zSmXRe1Tuh0/ABUBvhMjkHN9IZiO/fPrEulCU6Rpba3rIRQ9ZOxAfBXcm0IQsyvasqm1gNejqqoYbwKRFaJ4EvpvDhpktqXHYpWpR4krXGgmriPLFTBqoaGVbmdas70yEiWLvYZ7rIytbWiYeF/Z+pGOTnrWQ4Zj8kxnoD1AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=haJvVoLLYX7H6/gRzEEFi7D/pD2Trkl9NS0YICHSZcY=;
 b=DEbXOzyguo/jmz2+/ZLQRs++GueWrwnwTShgmQOnD9qzHzSVrPV/43PM65xbbS+yiZn8VeDh2rKGKabpITT50FOlyQMj8Pdp3nG+Fpx55KSV5csxBohLNg+ikHLXlQhEAqt/noE9KTUs6rwIsLBrbD+3H3TRrXXFaWP4zeaxaEjd3LeIJY1BXIXralgzFjffeOU++HrMfPbFOqtrMbKettIdjWYGegrIGtAeY9uYTlrsw74Eirj5pbPU0i9K9PRxm6THTrOjE/Yt8bxx/ajttSqREOtg/fovVPRSuXxjXgwEf4ChzQnM6BCVl3hSu4J/r0Ej58ZbCrzT1EKL6QTNyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com (2603:10a6:10:2d6::21)
 by VI0PR04MB10418.eurprd04.prod.outlook.com (2603:10a6:800:231::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Wed, 11 Mar
 2026 09:48:21 +0000
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::32c4:a8a7:1724:b754]) by DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::32c4:a8a7:1724:b754%6]) with mapi id 15.20.9678.023; Wed, 11 Mar 2026
 09:48:20 +0000
From: ziniu.wang_1@nxp.com
To: adrian.hunter@intel.com,
	ulf.hansson@linaro.org,
	haibo.chen@nxp.com
Cc: Frank.Li@nxp.com,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	imx@lists.linux.dev,
	linux-mmc@vger.kernel.org,
	s32@nxp.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/4] mmc: sdhci: fix timing selection for 1-bit bus width
Date: Wed, 11 Mar 2026 17:50:06 +0800
Message-Id: <20260311095009.1254556-2-ziniu.wang_1@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260311095009.1254556-1-ziniu.wang_1@nxp.com>
References: <20260311095009.1254556-1-ziniu.wang_1@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P190CA0015.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::20) To DU2PR04MB8567.eurprd04.prod.outlook.com
 (2603:10a6:10:2d6::21)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8567:EE_|VI0PR04MB10418:EE_
X-MS-Office365-Filtering-Correlation-Id: 981cc0d9-b41f-4b82-a817-08de7f535435
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|52116014|376014|38350700014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	dKb93g+Lc/wE/KBux9q9GaCj4Ze+cwT9c45rZBB/y2EoS75Nw724yPwvlpA3golnXYhCG7XV16b65Ivfv4VXZUZ6HOnH3QaQdvNlacP2hHWQKbonrZU/G+DTDFIakcdEM4SNWAGRESr6+U8xmOZMO7iB6JnNVlL1SIY3BREagZ41UYzyOLf9WNUmpHUCEe+paHNr/z5LQRJDo4S8iA9dZXQXH46f9wIYw9263mW5dWd2zMwUP9p93SjuC3VYpNLmWLjyP6XF/NTItFoVdD0+y4JpDjyTKpfA98LhZ+Gg2pPAr6kzvn5xT9vcglVWbe+Epz3BFmSmMC0pkD1WscF7vWUyctJ1Ph0tvT8AvR22qG76muaEEd4BwhsKa1ntZ0Iw9oGwL1vZdraueIeZiU7IT//aSwGZJeCRhmF2tMmTxu8lz9WLtCseR3I19vKGI70nhzO6fXXrpl03k8FSj9z2VqexKa+6gjcCIFiWaDa8Xc9ANpi8/pMruHJrxmOcE3SJoSmITAySD1x7fegcw7miI3vC1yEELwXkrRpsXowxoXQ4wSTMUl7hI+F3NQjmFVSv6TYpHKgiOikyNRzHzZNsRmBvXOwtFvovwoulgCaOxaZeIVJyA+gsH8KXYODbXh8d+cguOIPIw5QrXnwfACJbB1ZHNzqsY1ojg0jpCe2SO0sZZ7pekgEN1N2pGppHPD8qPvRoEm+NL+lGCUaJ7j6VCbDr4sVS636wA+0MM3wWTKqdZAGPi08kWHFjVB9EbkmmO4F0VjBCX+8NYdPSGACiVby46vv1o49jfsrvJrBweEI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8567.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(52116014)(376014)(38350700014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gLCFgZ9GpfhjetfrhJq4Wd9CHBg5P65kOisH695EIFwK8AP4pFi36DC+5q3M?=
 =?us-ascii?Q?NVwjusbkGlgX20547Ho4JMZlt1FO6khFkqHmM4vxe4SBuoDfIMhUQXK3gOSZ?=
 =?us-ascii?Q?qorymCwja2SFjmt7nfFYtgpNAxThcZO6cDoeUVOZxY/TOzODXOtn57xn/v9e?=
 =?us-ascii?Q?SO9cKHoEdgy2isPmfvkz+9f9Vi+Nw5rMdJKXGr0OB2pfxujvFCfq8f0+1yPl?=
 =?us-ascii?Q?uibojSteTgRMPqHXirDsUqTxCwEeCElUyC3FAegjgN5ONt4uUX39ss78QGos?=
 =?us-ascii?Q?NqydI4taDV8WWsh9jgQsSc6fP5OUgux4ExhAjsv8eK1hRVcznnDUD6WMjBQV?=
 =?us-ascii?Q?gg/GOCAN5lYrqOYcEzOoGdXULACsZ4VJQy1jGLsO6AOBt4R0cIxWoQ15/XFL?=
 =?us-ascii?Q?1EKFNlvUP4+8rOWlm4lCDpaiTKP3MR/8Yp3s70S6CLHgJ4j4seGb8Gw0UMFg?=
 =?us-ascii?Q?IyMu1CEq5bxP+zFA/U0jmACp1XPxx7hGyyD0lZDWWFhDKfRDnOuUyAVU8HR+?=
 =?us-ascii?Q?2A/aUItRdmTGszT/Kxkkr58K0M4ofm+AWnTeTv3K2LeQ4rxIzDjOjQtUlzEO?=
 =?us-ascii?Q?x37tin1UTOtYe9vAdHfgF9OPZA5+3Xih5fL3JWgx3TJMF59FG5hA0ATJa43A?=
 =?us-ascii?Q?0gSAQCNJh+XfNANTtEwXTv++z9oABXyt5O4YH/2QTAxcF8ZewsYJJsrxI+RC?=
 =?us-ascii?Q?st+N2w827jfTGtoFZ01cDnmd+Lqo5U9jiZFdhFdQV+X/bP0tJesw+OYpTpfc?=
 =?us-ascii?Q?7yu9hn4cdFCqJrwG8sx3yzMJAVGGklmG/m/s2PP3cJ0dwdbaovKn/5ovM8U4?=
 =?us-ascii?Q?nubDBUE7TCDj2htFNgyRZ1erGVF8Juei7icAk0dDNrZfUT5vRPNLu+e4QlW2?=
 =?us-ascii?Q?gpYELjH+S/aBt+FynNRLY49mu+adUv/7wYWBa+xmvTyKkUH73dfAE6czp8M8?=
 =?us-ascii?Q?zHppKSInn3xxXwV5z7YvzFb7WQO8UfhpvOGUS2xgk6PNFW7WJbVHdwe2JWG5?=
 =?us-ascii?Q?ipCHkhXQm5/gwfk5h+HwXW6mT1PqVZo3qxHj9Zbq8YMMzeLiUHAJcM7kj2a1?=
 =?us-ascii?Q?PLOXlMczgJwxAhQ+8SZY0CFfSoSwUhY0AR5qYKPVntV/SfP+w7TWmI+z/nPn?=
 =?us-ascii?Q?4ZmPs0oBhrwK9ck3M7nT96F9l5O2kzuJIGT98MxhbP/5BiPOKobKLL7zm4Pn?=
 =?us-ascii?Q?ffjJgTkGvZ8wKZsedbaHE0icJBLJ3ISVFAzHgol33/JOWcxx85Nls+3kmTi+?=
 =?us-ascii?Q?KUlpD7Dq4bmI536w3gcV8aIlrFRnhUC0484N+9ZSQexhRMfUquZSdxNdWZR5?=
 =?us-ascii?Q?sfn4HsrystDyrMzaEtxS39tlN5Xl8CeO/A7MOwv6qyueZmZ82b1oMDu4jDFJ?=
 =?us-ascii?Q?DXefzjiE7VTPRnosbV7PccVAoASTJewadDtV8Qv5TIQu5SW39U5cyjDtPYMF?=
 =?us-ascii?Q?uCcy1pHOjKOB3yx7N10QPmmt/QmYdNT0i9h74GXV5KgRf/1is4sdarrJaoZG?=
 =?us-ascii?Q?P13r4hg0KBbDrVFOsHfd/cD1Ussw+KXBERid1/4Lcu0HZ0HoGGZ6A43uPQIG?=
 =?us-ascii?Q?cP3D00rND9X3P8UPLRVl5nfGEjy1iwBC+DOicjK27v+zrl0KdX2FCGwYXAFs?=
 =?us-ascii?Q?8wPy6+nRpYHLUO+DLfLwid1YYxv6dPWBRRDe5pJNv0FJaUqF63cHMejXCq6d?=
 =?us-ascii?Q?yVQQuibXrY9rThSks5sT3RJoKz2vjC+tszstISvD6jFJzxoYxLXWgg5ewe+W?=
 =?us-ascii?Q?eQI7Vr3BiQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 981cc0d9-b41f-4b82-a817-08de7f535435
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8567.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 09:48:20.8780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MJPffBOkHTZClVVuYd/SLb8+DOGosZIZx2J/lb/hcWqpkJY3zs/Lud7Q6f13RqvcD/p/6az9IEdrOLJKcIgOZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10418

From: Luke Wang <ziniu.wang_1@nxp.com>

When 1-bit bus width is used with HS200/HS400 capabilities set,
mmc_select_hs200() returns 0 without actually switching. This
causes mmc_select_timing() to skip mmc_select_hs(), leaving eMMC
in legacy mode (26MHz) instead of High Speed SDR (52MHz).

Per JEDEC eMMC spec section 5.3.2, 1-bit mode supports High Speed
SDR. Drop incompatible HS200/HS400/UHS/DDR caps early so timing
selection falls through to mmc_select_hs() correctly.

Fixes: f2119df6b7646 ("mmc: sd: add support for signal voltage switch procedure")
Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
---
 drivers/mmc/host/sdhci.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index b1a3cd574c84..605be55f8d2d 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -4539,8 +4539,15 @@ int sdhci_setup_host(struct sdhci_host *host)
 	 * their platform code before calling sdhci_add_host(), and we
 	 * won't assume 8-bit width for hosts without that CAP.
 	 */
-	if (!(host->quirks & SDHCI_QUIRK_FORCE_1_BIT_DATA))
+	if (host->quirks & SDHCI_QUIRK_FORCE_1_BIT_DATA) {
+		host->caps1 &= ~(SDHCI_SUPPORT_SDR104 | SDHCI_SUPPORT_SDR50 | SDHCI_SUPPORT_DDR50);
+		if (host->quirks2 & SDHCI_QUIRK2_CAPS_BIT63_FOR_HS400)
+			host->caps1 &= ~SDHCI_SUPPORT_HS400;
+		mmc->caps2 &= ~(MMC_CAP2_HS200 | MMC_CAP2_HS400 | MMC_CAP2_HS400_ES);
+		mmc->caps &= ~(MMC_CAP_DDR | MMC_CAP_UHS);
+	} else {
 		mmc->caps |= MMC_CAP_4_BIT_DATA;
+	}
 
 	if (host->quirks2 & SDHCI_QUIRK2_HOST_NO_CMD23)
 		mmc->caps &= ~MMC_CAP_CMD23;
-- 
2.34.1

