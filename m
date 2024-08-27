Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010015.outbound.protection.outlook.com [52.101.128.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBEB12F5B1;
	Tue, 27 Aug 2024 07:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724744073; cv=fail; b=bsl+7MKJ9KIaJQLG4Da7PKfNOOtdhtC61KZuHD3db4zIEKNWAmN0K3Btt3Zoqatxdw/tELn5RKR+tbp51NB0/dsCp+QEW3PWpD3dJh/Gw8ORISpOZK0kCJp7saW2ULy3vDB90YsjtP/Y+qWaw5Y9wPFlSqlJN90vTHE3ULpu3A0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724744073; c=relaxed/simple;
	bh=W6QeVfXOGQstDWtk9Pl8J3Un2WwTui7lFp3894HdIxk=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=MGwIICGHQxLXpGiE3rKe5T86RWwFCXsaXy0RO4Mg5cBvq3fdsCSjDQknhHbdwms6s4VyhMbpXW7AIbXZ6C4F5w/5LTRh+yXY3M/0oLiwk5gMagVVBgzIWxGvm9oRAnBc7Ce+tEwwpUjJPH4yKjwPNcU6fLBxrEGBMl5s9zdtAbY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=JwJVu6vj; arc=fail smtp.client-ip=52.101.128.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="JwJVu6vj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qua1adcucsK9u2K8oV7LsGc+PuoLV5rjelacHs8ieivf0lAggeMehd3wOulkQTUFq1ujTmPfX9IJ+/kHJA1dw3c20stNAFcHE8q66fFnshYXTurHF2wDEnvttlvZlxCJPnjY4BwfTRj7oqNMgr05PX0kKP8qozDKUkmu7FGaWIwSzcZMm2kmstX9epXi6EQRCIQrhVjmw5UQ5NHvtftnpQ1vzlQxxbWlUO+9250XrBidR3G2VX+Wc6nauZFTbpBaFw9bRDX/8DGjyTxpchasly2CX3zYCl7EZNVO/KI/BE5uM3R4QxHlt20jNrBuEm66VHGrRRVYBTcmm9PUmC4/Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GvW19c7vl0ednZb1zDP0yE3D6UwZmpFMQbG+0z+reKI=;
 b=xeXiF6sgC/y+w7hptKmq/dbxSrobiEWkng/HHSqZaibQC8MgLFf2js3EBvjYEBl31Xk4COdWXRQGrfL61QbfDdrcAizr9Bsj4HFndRNXNrRTINNC2ZO8JAy4RR9shLrntblOFhzPUE3auFDFNqX960N4TLn4mKKC5MkgNkIXxb5sZYikKDHkyNi11IqBWQloJO60GThGPmYtnsc5o1E+RQHTlTSKxCqav3vRhkO4sXrDZ/xq5X0j+bc0sCt2adoJAhS6RieWs81Dt/TOGFrckcvH/wdRWo7I7H27NfGpGSXXJVS/GLlLnZRkrXARe/n/90lchP9TVoXK0bs+nk6Txg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GvW19c7vl0ednZb1zDP0yE3D6UwZmpFMQbG+0z+reKI=;
 b=JwJVu6vjDUFY7uM0ieWMPJJsvkNSiHI4LuV8aLbUQW/LEGcweoW40jhw2Bi2OHWzBDwDCoS9KZmpEwam27g7tODCcx2KLd4HxsiDNkLmF3+AwOo8vbl9znMmVTy4dJhFersUz6ie3FYeTN0KTXyXsHT1v0J4/MU0ERZYLBpPh3pYobBnBZL8BfFos+K6x3DbDHlZ2OhcpS7aStAzAoFNE0xuYk3Z4EEIRYAzxboTaVWa5Lfsvut50/PzuZeh8XJfsbiiC5yy/OpCniwePPdXkmPDKxaJJExBkVYIBKCdgL/GFx0N7if5vTpMNYsDn2yinLHbA7rZaqpMSQsH5jEFCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB5178.apcprd06.prod.outlook.com (2603:1096:400:1f7::12)
 by SI6PR06MB7102.apcprd06.prod.outlook.com (2603:1096:4:244::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Tue, 27 Aug
 2024 07:34:25 +0000
Received: from TYZPR06MB5178.apcprd06.prod.outlook.com
 ([fe80::f6de:c016:c33a:318]) by TYZPR06MB5178.apcprd06.prod.outlook.com
 ([fe80::f6de:c016:c33a:318%4]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 07:34:25 +0000
From: zhangxirui <xirui.zhang@vivo.com>
To: Robert Richter <rric@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Taichi Sugaya <sugaya.taichi@socionext.com>,
	Takao Orito <orito.takao@socionext.com>,
	Michal Simek <michal.simek@amd.com>,
	zhangxirui <xirui.zhang@vivo.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bastien Curutchet <bastien.curutchet@bootlin.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/9] mmc: convert to devm_clk_get_enabled() API
Date: Tue, 27 Aug 2024 01:48:38 -0600
Message-Id: <20240827074857.2671808-1-xirui.zhang@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:3:17::17) To TYZPR06MB5178.apcprd06.prod.outlook.com
 (2603:1096:400:1f7::12)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB5178:EE_|SI6PR06MB7102:EE_
X-MS-Office365-Filtering-Correlation-Id: ed7d8f13-45f0-485a-109c-08dcc66aacf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7416014|921020|38350700014|43062017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?II5pZYAv5Zr9vz/GS49vmxAdjfb4VQ7vJxKknvuIxvlLKzbs8gI473rm13RT?=
 =?us-ascii?Q?lFeqquOoVzI81jPJB44pKRfgFAX7fGa4tk4Cub4RH2K+jrVKjJyuhk20v2iU?=
 =?us-ascii?Q?nD7cyrLPUl/X3n4yWLjgeVfD8VJ0dpfcFfxI5OOZBr0f7hu8TWFnETxcm8E8?=
 =?us-ascii?Q?3IEg8wEASiG8RJcF1GsK14xPFOYXjQKx6QtL8H5VyhxNVlj6XOlgIXxJ0TcI?=
 =?us-ascii?Q?vFzVL2x5m/DFtx3t25OlRFdWk3jA1pHASDjxJiD7QwCvEcPsa1lEGOeMwO6w?=
 =?us-ascii?Q?5EnGHTyixHJYyovOkcVwcwuUFxQS9m0byTeKMkIFdWiZM23eaKNue2T9f9zT?=
 =?us-ascii?Q?Wrzf6RZdejKIG4HfZRnDHgypAZ3sYS7BlO+6bSIE1UvaS1RKNjd7A6fG0+wQ?=
 =?us-ascii?Q?U4C/JmwW8Q6xFI8nypxxQJwILoDIw4kPDZhpQmJmegTuXDhtlNlWgBYSkKIE?=
 =?us-ascii?Q?s0pDmpXXN6w3nimxTIkEUji3gyQya6YIQn8qaB77PZpgUDkeYEozlGEXc7JK?=
 =?us-ascii?Q?R3Zyqo+0ePVUYdIApF2WJC3v0VYeN5iR5PfJMvw+pTqkDSaoxUjWmPJSVsWe?=
 =?us-ascii?Q?BzvvZkJ0ILDz6dWmOGGyY6YRkBX6Ag5qLUonGukte8Wd+AcSGFNR5aTbcz0D?=
 =?us-ascii?Q?fNKRsEGY4py7W+5rW291B99DeQ8kcmzRYQrQ+I5mlbBUtYtTKPmikANmiiVD?=
 =?us-ascii?Q?fw8OWfHUMynqzJO5M37an7yZhFpSWIetI0gPc1S+8eKsui3c0AxZXdJ62vOy?=
 =?us-ascii?Q?yeTvb7r2USfrk9VZ1Mt0xCnmsMKLtgOlM6Fd9QqEY3s4TP/kFkBlYzq7GAbh?=
 =?us-ascii?Q?/66WCM0/Snj9jvK180RJtr3IEgpg/APRB7EtT96oyTQ8tCNtPv4N3dUAlJ55?=
 =?us-ascii?Q?Z7O50ojWTWqwLEAe2i6524FbOho/DeUEe12aIoVgPYj2yhUtGRN/evNDBvVi?=
 =?us-ascii?Q?ylbhGJ05RlE+VydsQUWWZMq6p2tN01JKTObZKfnKgl+s6Enzovzhk27xfM/Z?=
 =?us-ascii?Q?K6O3bXvjBWa7ShErTqpy7Qc/tr7sYRI7RBqCDt4Fv/CLb+eWhT6NjCGSVvaP?=
 =?us-ascii?Q?YuFZGSBKqSNvZjVnw1XdkYiFl6jI+DGt0ko5PPiHxokfUeCILJ7WeLhr55i+?=
 =?us-ascii?Q?ahYU4t59AxTVFAavOwQqo6y/PQ4AaAEhrHyH34zwQHWW5hrycOZtKSZbDBmI?=
 =?us-ascii?Q?X7G3gvaOJnjEV+XjgG0UrHw3bfL1pF+/WzlZwZFrlNtuxW/0fXIScg01QzZO?=
 =?us-ascii?Q?lE+qM0cr+jSE1mY5nWt8j8LC0PeHT0/BbAL+0yh1UM+tD+c+1KB3pkD89JeU?=
 =?us-ascii?Q?9+GTuLP7n0sT/gQCdBU8pSn51QgqEUFCIOXM5RQVrYTUok52WbMD1q/VXNd8?=
 =?us-ascii?Q?F3nafd5ANCz5PiyaChVHpi7lWdXPc5B1boA8CEcr5Nb5PNspkrzvig6z5/QN?=
 =?us-ascii?Q?rxaJPnxQXMvLQoxw8AbPZXcD+UrcHduB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB5178.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(921020)(38350700014)(43062017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5t0UqZLEGZ/RkDUhdULQNJPay6QTugkl+6cw/MQwSGFFM3Y3fC9h+WcE+tG7?=
 =?us-ascii?Q?B2euiXhzYk+7srxZhcpg2QytRbZin8xNI7XYE/FoSDwlzCfj1uj4PhyISuwg?=
 =?us-ascii?Q?cuR+hq+nD3bbBV7sPTmGJYmFLbxzESGpjXFh+3KiyjjyxK9WJxBBNj4CiuYB?=
 =?us-ascii?Q?PNDzpUsjCsBkJorRe5eYbJ0fqikbZOMzmb1R5gLvu7UveD+vZnAOLuDBsjDj?=
 =?us-ascii?Q?yhAIkAjCC+dC2yKlQ/Y4Htm561tAKlcTQ/IN8WrN5gwGqNxQyM2F/BohsXC7?=
 =?us-ascii?Q?mU+cAR8RR6w1H3pYST7yPKHrJUAkm662rzTDHof/2HcP7Im5EEornegTL3Wl?=
 =?us-ascii?Q?FnMj25KSeTSBWFy0P3eS1E5gQAmPN9l937Tj3DRakN7WgoVmb5j63sQgiUIP?=
 =?us-ascii?Q?Hf0vKql4pAgUjM4NWAN5g3m7wLTwm1QsDCa8ZTXGfkgcFOuo2A3h2V4UdIU+?=
 =?us-ascii?Q?Xlnh0yGjTuv1hWzwBj1t1HVAc8azdQHEFGJSJrDjSoDyR5cE0o9EhKxi8znU?=
 =?us-ascii?Q?8ElnlVWt6WS0v5GUS40MIPCiT+pR8bQ1AU6Ab5Dn7erBhzGkgYyeMtDl2Lrx?=
 =?us-ascii?Q?WuLYf6YkcaVnTxm+/vJCm38+Kse1eG/c2Zsyttcp4lVoopED7TXCD+8JBjJj?=
 =?us-ascii?Q?XsldeTdt+vt12DwlfMNZXSdGb0qxPHsZXvmj++0yWzzA3gKbnKdH9JXOg95A?=
 =?us-ascii?Q?D2gEU98o5GqyASBojIgvdaTx/DTh6brMFhwtW+q1wcaBAlIf9BzHdJaCEQZM?=
 =?us-ascii?Q?lLQgz0uJycI3H2Cybyo5gidDQqRONKblgbSk8FMHsbN1WgAj2pWiNQJGacsk?=
 =?us-ascii?Q?39FOU0Web4orR6Zg3sQXCZi8hu64OfRyR9s0dTLUA9aCkgG1kDwlIBMntt9F?=
 =?us-ascii?Q?n3q3aEI5oMrffSVdhcrkNI/YqYhXfN+x72rchwI4gWm3C601C0nl0RmB8kYl?=
 =?us-ascii?Q?Bm3S7sm7hIrEyxXwyDgMcbTdiuzoZgqWSjZdCFleJZuITLz8qa8B/140lXw3?=
 =?us-ascii?Q?a7Xobg7XNTd4R8YVfJUBN7f00OgFpy7IRE4dejmZkUlWvg/BZB0XyZGIzE2J?=
 =?us-ascii?Q?IT6EVWS7c2QFM3tIHlZ4ssDamxF6CrDL7oKSj3lBo9wCwKWB3LX5RAi0NKXm?=
 =?us-ascii?Q?HHjsI0dpAy2wha2QggMAgRanjSeQa07NXcs8G5STYfhm3be65vBmHUycduj1?=
 =?us-ascii?Q?iQdPyI4fDsMqfQW208tvfqVmvh7mMoXEqG4By9r6ZkxxULolB3FqCxug5Ags?=
 =?us-ascii?Q?nfe1fBXKcogc+A4XlvJCmACz241qJmZCf6kSax7ti+hCV6lREXaloYfEsn1w?=
 =?us-ascii?Q?g10raW4SNp0l3Pb34BAELnTI17uaZZAuNiZ9aIiN9gtC+ITN+25HC08QkYc6?=
 =?us-ascii?Q?1mP+kH2amhydTxHxLBK9kY2yhHq1jt5+fGRVSYpSvjqpjuaep2wv4buNSmwM?=
 =?us-ascii?Q?tnwLVfbUYxkO1ipR6Ma8RZAlNRT9u5QyJNOCIUqwU1V8E5Uh0b/9CiNn4KRM?=
 =?us-ascii?Q?BCkGfcyB2MEyeW1RNQ2mqMr92gaedjc0INSvDF3q+7T0FThjfzYLzyM8lUBf?=
 =?us-ascii?Q?db56MGKIjaQTpZzcU4WTW8octYuIbmP7A3jpOKdy?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed7d8f13-45f0-485a-109c-08dcc66aacf4
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB5178.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 07:34:25.2384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ho+FCjX/YNp1b/8rGw/3T8DlOB+JjEY6JwQxlgQRPVt2NRHimQ7+5g1IxPTnpnCXwmCgH4/AJN1brIFjQIgHKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI6PR06MB7102

This series use devm_clk_get_enabled() to simplify code 
and avoids the calls to clk_disable_unprepare() 

zhangxirui (9):
  mmc: cavium-thunderx: Use devm_clk_get_enabled() helpers
  mmc: davinci_mmc: Use devm_clk_get_enabled() helpers
  mmc: dw_mmc-hi3798cv200: Use devm_clk_get_enabled() helpers
  mmc: mvsdio: Use devm_clk_get_enabled() helpers
  mmc: mxcmmc: Use devm_clk_get_enabled() helpers
  mmc: mxs-mmc: Use devm_clk_get_enabled() helpers
  mmc: sdhci: milbeaut: Use devm_clk_get_enabled() helpers
  mmc: sdhci-of-arasan: Use devm_clk_get_enabled() helpers
  mmc: sdhci_f_sdh30: Use devm_clk_get_enabled() helpers

 drivers/mmc/host/cavium-thunderx.c    |  7 +-----
 drivers/mmc/host/davinci_mmc.c        |  8 +-----
 drivers/mmc/host/dw_mmc-hi3798cv200.c | 28 +++------------------
 drivers/mmc/host/mvsdio.c             | 13 +++-------
 drivers/mmc/host/mxcmmc.c             | 25 +++----------------
 drivers/mmc/host/mxs-mmc.c            | 13 +++-------
 drivers/mmc/host/sdhci-milbeaut.c     | 25 +++----------------
 drivers/mmc/host/sdhci-of-arasan.c    | 31 ++++-------------------
 drivers/mmc/host/sdhci_f_sdh30.c      | 36 ++++++++-------------------
 9 files changed, 35 insertions(+), 151 deletions(-)

-- 
2.25.1

