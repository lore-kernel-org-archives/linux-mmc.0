Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2081.outbound.protection.outlook.com [40.107.104.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2F8155310;
	Fri,  5 Jul 2024 13:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720187252; cv=fail; b=R/VrF/sdXhv3sxup4GlOvqy8PUVmndlxcg8FM4KGt+a2ZNvkbOfWqmI+ltWUdBqDK+F33iHGNmIuAuOBIcahtk8KkcYD4DCzp1uKSudwsbLsMESFxLQPBqHSmvvKOBJTdOWm+9QzoJqDEGTS5ERzuop/Ph7ilqYzAeEUU7NpFsw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720187252; c=relaxed/simple;
	bh=DHhLXjxTs+NypUB9/UxERUOxX/LU6zaGoJtJE21AofE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=StZEsPHXveqpgUtzBzGu3lOiWdgV3mBS5VnGfb9wjiVyd1EBzMX4xSaKy3wGpBF5SiheDn7bcuWN5Zr7MqUlBhQS0wAiwRNIP0CALSL2BE16ZElq70omEeVBre0UfIMaGDR+AqYM2fa7bll4S47pYr0op68YdZzoZIbh8xU9yTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=CFHpWrSC; arc=fail smtp.client-ip=40.107.104.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="CFHpWrSC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T72ARCGWlxNelJ8EKgHR3PQ8rhg0E1wLvNfqBdi/6FiJkAI8z14ZLdOA/H90bL5BmD7KXFVF0fal70DIgN0xZiyarStCnI0j5OMjSo8it9MJupZdWZbHqIfSq/xY92hMD0ll/haCbsM7Y/vQC8/tih5vf4biz6Jg4iTQWibwspAC81qqSKkHQq3nG8PXvKd8pxsyWFTY0g9+GDMbkQBAqS6OnUVyUZWWlQaimkyak2xLUBEc4OltTbditn+uOlXQAwWscTudTvYp+D/yZUl4t19A9iN67scmXDvRLQa6eptjlGz4t+IsPjXLCABJQ9ag6VAmYXbP4vZY7j/msy0QuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pualSqx0gdiGLDlFTYGFBmBq39trV+/C9DQoWAo688s=;
 b=bDQG9eOGEtArib/7Aps5EvxZ5vjA+8NV1avsGYRqbbsaOhQrxqKdY1WFoNXzZkCCDNwgHoi3JLkIRf0lTTLTxmFmkoX/f6rOHlYfGj4ejgNPdSZP6evuqSYhva2qxulpU+rzeKKArmTGEU1fHLdI9izs47HaTh9YYUa4wzgf0Jq7Zp0QNnfQIr27eoCrWkTLVcBYHd1RZhbrJWCd4HlHZzCwOhdEZ+5p954+EnchkXHSelp9WtQBSykTDWUuz7iRDqumxgVXqWHoCvuzBn1Ka1v+8Dy8A1ligFziDyY+nfbEM3tYBwizKij/u6OzKJLTyVZAMReHSgCFLDITnygtAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pualSqx0gdiGLDlFTYGFBmBq39trV+/C9DQoWAo688s=;
 b=CFHpWrSCqHmb15J2m5hkxChr7/dXOBbPA+rRlcYNS3Iq6Y8zecLxanWP9vM0R1FB0oPdhv5ljkPy989n7FaGjA2AiPwsqm1F8Kb8Tws9kONOMWwHpnDiR23Ele1YFWctZaMJZ1dcC/1/8URTY4Z0IZmz6RdLlwDr1jOMnxjedUo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by GV1PR04MB10244.eurprd04.prod.outlook.com (2603:10a6:150:17b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.30; Fri, 5 Jul
 2024 13:47:23 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd%5]) with mapi id 15.20.7741.027; Fri, 5 Jul 2024
 13:47:23 +0000
From: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
To: Haibo Chen <haibo.chen@nxp.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	s32@nxp.com,
	Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
Subject: [PATCH 3/4] mmc: sdhci-esdhc-imx: add option to not change pinctrl state in suspend
Date: Fri,  5 Jul 2024 16:46:46 +0300
Message-ID: <20240705134647.3524969-4-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240705134647.3524969-1-ciprianmarian.costea@oss.nxp.com>
References: <20240705134647.3524969-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P189CA0031.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dd::11) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|GV1PR04MB10244:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e69419c-1c03-4325-f445-08dc9cf8ffad
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N0pleStCdGplOFFnZm1XN1hsM3hBQU1nM1h1ZkltVmNLY2pSeVg4UnFiLzUw?=
 =?utf-8?B?azJQZE5UUjVvUVpGQ012dkFFcThoZm5SdzBmOUZxc05ZVUIyQ245OUUwdEZE?=
 =?utf-8?B?cm50Z1hBeXhUSDZZT2cveWNJYjJTZmZ1dktaOWpNdUdWQktyZFU2bEc4VzJB?=
 =?utf-8?B?SWRkMmtIQTdkVDBOUzNZQWd5R2JpY2E1OEFHelNMWmtYYlNwOTNGZ21neWIw?=
 =?utf-8?B?SzY2REFza1FQSXFTeXBQT0E1MFA0R1BEb1dtRWpHREtkVFJpOEtlZ3hBOWVH?=
 =?utf-8?B?bGpCL2FsdUQzR1FmZjJuTWdtcHF1VE1NdnVnYmk1T2ptZDdkYzdJd1lSQ2pt?=
 =?utf-8?B?dXQvVk9lb3BBS1FHY0UrOXNPTitQWFcvbkxtMXd5dVlWOFdheGgrVVoxNlJx?=
 =?utf-8?B?a3ZvMTJYOXo1QUtXeExBeTJPeklaMitjczR5M2F0bDRiaXB4UDArbmNqdTNO?=
 =?utf-8?B?SG5ZcEViZE5PTkFmOGNPUzBlMUpVZUxoTHMwTXVsQ1lDT2dRSVJ5YTYwMkxk?=
 =?utf-8?B?VW1hL2Q1WmdFckh4eG5vVVlSdFpocGt2V2ZYNklPUFZvMW9XYWFHdWNtY2Rm?=
 =?utf-8?B?UytwMjhpUC9NQ2JQeWY1SjJkSW5NbVhjZjN4SmtVY0FlTnVUN05oSnFmWlVq?=
 =?utf-8?B?U1MwNnNDdURmcENiMWZPcmRQV3FzYWRnZHpnbUlwZGhaS1ByQjdmYXdoeFZQ?=
 =?utf-8?B?MFR0ZVNQV1Zycm56RFVSZnZwTVY4d3c5aWVIMnRsOWwwMWdaYTRXb0RyVWc4?=
 =?utf-8?B?M0VaNTJzTU91TlQwZStvZFNNcXU1NnYxaFV2dEdJL2pGNXhnWW9nWmU5UDZk?=
 =?utf-8?B?VDBiWnVVNGd0NERiYXk2RVRhSGx4aEZ1WVBVbStyM0lMa0FPZFB3UzJUSmg3?=
 =?utf-8?B?TkhtdUdOL1luVTdhZFFPSEt5Z2haQVFCMmRiNmJBak5Hb1JuZTNrZDBwT1cx?=
 =?utf-8?B?OWZWanU1OFFOTlUvSFJYN3VyOVZjSVJVbGN6N0ZORFdKalJPZmJGZnBOMnlv?=
 =?utf-8?B?VW5wSEZ4dXF4N1dvOTdTQjdFWDAvTnBzcmdjQ21jZUk1QnNZVmZjYXk2M3dC?=
 =?utf-8?B?K1FrN05jaEFKRS9PY2RISUZXVlMxVWZpdmZXUW9kTmc4b09jMXBmazhvUTRF?=
 =?utf-8?B?QkRVK3FFeXNYalM1RS9zZEhRTzJIajVHckRXN2JYbVR5aW44cmlCUzhNTVZs?=
 =?utf-8?B?ZGI2UE1NZWEzb2JDR0JSOVkvMU9mOGxJWEJYYnU3aEhaL1lxd3VQMS9IZ0dz?=
 =?utf-8?B?Sm96VDVUUE9LV0VhWDVZK09SUEpJNmZITmJPb091RmlHWkc1RjVZV0taaS9H?=
 =?utf-8?B?c0Zva0Z4NnhkbzR0QVJoYTZsQnNpK1hwL1VVdUpxSExxbFNaYjdpT1ZQNEdN?=
 =?utf-8?B?eGJDMDIvZEN1N0wxMGNRUUNvZ1VtSzZZYW14NmJQaHNjZjMxcEw4VEdMOTB2?=
 =?utf-8?B?TnZwYnVRR0JEOVBMOWJkR1lVc0NzZVNxUmNuU2RPekVsT0JGVVpxQWVpYUtN?=
 =?utf-8?B?Vy9MQ3owQkNjOGp0K1BsUUNocmVvSlg0cE1Sd09GUzBXU3RNUExLb21lNnE0?=
 =?utf-8?B?T3hremJ4ajFaZ2hzL041L2l5aFNNTkNRVnRtZndDcncwU0Q4RDhmTWgwUFFx?=
 =?utf-8?B?aFAzYzdYYlNKd1ZpdGxaVURJSGxqZFF0NVZpZ1dJSzNlSUNKakc0MWo0RUcy?=
 =?utf-8?B?YnFvYktoLzV3RjJ0YmsvdkFWSytFazJzcnJsNFRZNmNEOWpYdEpRYUJUNzh5?=
 =?utf-8?B?aGM4WlBhTW84MmsvVjU4eGdiYUVlVGo0WVhVSGxKZXpITXN6c1lDYlZxV1hE?=
 =?utf-8?B?bmY1bXdkRTVKaktOcTdCQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WEFSL2lhcmcyd0FHN2xCRTBpNFJaNG9TSUxHVFZNR3JuOThnaWZCWUNYNTlk?=
 =?utf-8?B?cHZSQ21YblZDTG1wTWJXbXlmdUc3VkhENVRrU0JLR3BlME84bXJTUTFLdlRJ?=
 =?utf-8?B?eGlvVFNIVWNMK05kc3BUT3NmVHBYZFlqLzY1NWdWY3p4SlllQWFPN1lRVWcz?=
 =?utf-8?B?L0tpL3FnZW92NWJsM2lHc0R2N1dWMmd6cUkrNFZiTzRPRytrenFCeHJXb2NH?=
 =?utf-8?B?REMwVFZXaTNzMDl5UDYyd2pCeE9FYVdWeUJzOWtabThpUU5uOEQ1aENBM05W?=
 =?utf-8?B?ZDEzdldrNno1blZ2T3RXZGw3WjA3MU9OcTNNdTFlUC8zc1ZvT0RtNHlOTVRI?=
 =?utf-8?B?bzIwZjd5R1dqSjhxeHN3QmdyZjRXZFEyRERlSTdOdGw3OGtmcnlOWjZuTjAw?=
 =?utf-8?B?eng5cWdsNElvVXgwdVkrazI2eG5OQmZzWHNmUSt1TkxQSXpnaFhwT21teFRi?=
 =?utf-8?B?UVFRWkV5SVhnYzBkUHRDVER0OFFMQ040VDFiVTdJT0R0NkhYbDZyR21MS0dz?=
 =?utf-8?B?Mk1lb3RYNFVrcFA1dmxVSG5Sb29zRVZUY0JxMFh1aWJjRjAvdWdSRUNYRmlw?=
 =?utf-8?B?NmFUMEhIbzlhMi9iNUxVdUNaaXhoS2V4a1FyVmJRUzcwQyt5eUUzcFkwVVdN?=
 =?utf-8?B?U1lpT3NTbyt5cW8yZlVUZWRZMEdJNm1ud0xGRHlUVEduR3JjdEpaNEdtRGhP?=
 =?utf-8?B?N2NjOW9SbnFqNklLektKRHFxblBINFZNbHdCR2tzdXljQzlNcHFCT05zVDc3?=
 =?utf-8?B?amNiYlI0NENrdi85Rk91enYwN2dqNzZ3S28rc0NJK0pJVWxxQmt1bmRBWTR2?=
 =?utf-8?B?OXoySVJ0NTJMamMvMC95V2svb3paQ2FxS01vWTNyY2JKNVFRd2lycm1uQ3Vr?=
 =?utf-8?B?VkJ2R2NZLzcwWWwvYXE5UUpiOEptOHpRZnViYWc0U3Y5Z2gzSkZzN0JVMEhS?=
 =?utf-8?B?SGI3Q2Y5L3Q2QXZYTDgvU1VrVkt6eWoyK3VrcXJWRy9UQmw4ZGsrc1VBRUZZ?=
 =?utf-8?B?N3FUN0czaFA2SVhOQUJJY2s2STRpRG9FSTN6Qk5JV0hWSkdlSWFldm5aelpT?=
 =?utf-8?B?WlBwT09TU3BIaGtiUDViZFZSSXpwRGhoRTdYY2NwekY5TXdkQmt3Mkx2WGtW?=
 =?utf-8?B?Ly9UU044QUJUQlJzN2RtQjFwQXZUN0M3b09SVko5cU02bS9JcUNDOW9nR1Jq?=
 =?utf-8?B?dDFqNHRpZE5jQ2p5aEZ0ajgzY0pYdHNnbEY3a3V6ZWZvNHowWWhpWG1ZMnR1?=
 =?utf-8?B?S1hHcmFxUXBraE9iNE1WNEwvNTJ0RlpXZ2JkTmtNV0hQNStWWEJlQTVmWllm?=
 =?utf-8?B?YytlTE45M0RibmluVFNzY1hpM25QdFRJSVJlVFl5bWk3T2N4SjJmZURPM2Zi?=
 =?utf-8?B?V29UajFEREdQS3lNTnlZRzZsbHJPN1prd09oYlZuOXNGaE8xdEZESUFocVZt?=
 =?utf-8?B?M21Vc0xTN0thbHdCUjVndnNBLzVaNUpsQWZLWWF5RkM3Wkg3TzNuWExxS1lG?=
 =?utf-8?B?ZkR5K1lJSy9nSkc4Y3BXWi9ZTERyWElVNHRoWm5reUtWQnRiSGtmOTJZajdw?=
 =?utf-8?B?WFpiVm01elZqVTh6M1RvRU1wZGJtNFZpeVBpbm5nNlFkSUw1eHZER1B1cmhY?=
 =?utf-8?B?SHZMNkp5TU82M0lNZjFLVHJXd1dOZW5tMW93S21CbVB6bktFZUwrZThsMFQ4?=
 =?utf-8?B?czNtN3piaSsyS0EzNFQwOE5yai9BZVZwUkVPRGZQejRLbW5MNU80d2tMWjN0?=
 =?utf-8?B?RTYyNnR0aXhTa0huN0x1UENsbUN0a0NPVXlUL1pkMndRZU01blFkYTI3WHA3?=
 =?utf-8?B?TzVJZlJQUHA4R1d6TGZXbTgvVFBjVDR0L0JBMUFXVGtLY1d6eHlyUENZMW10?=
 =?utf-8?B?MlNiQ2wxTnl2dzhLVjlndkd3SXJaV1drNWU0eW01YnN1QnZjOEdhV1M1TUNs?=
 =?utf-8?B?cnlxeXpJYlJJS2xDZ21TNFNMS09NYWE0eXB0WGFzSFZoZzU4bUZ5NERRNkN5?=
 =?utf-8?B?VHdyUFRYNXRXZlIxRzZuU1RibWY1ZTJuNzlaK2lOYlJkSy8rM2Z2ckhFN0VX?=
 =?utf-8?B?Qi9NL0sxenF5MStzYjN0aHNOSDJJc0RIN1NETzZia3V1UGFqUVZnU2xQNlNM?=
 =?utf-8?B?VVJSMjVhSkRxZERjdGJjYldHSE1ERXFSdDVubVNZVUdGQ0Nxck5PYksvSVlV?=
 =?utf-8?B?K0E9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e69419c-1c03-4325-f445-08dc9cf8ffad
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 13:47:23.6643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dqc21iBKpbjT6eEJ+LsQGgFLBvKIDS59pzgpLOzfNEVdOmYORFEZUBzxGMfSEPvgS69XXGO7BZ/xba6V00f72YebqnQbEDXrsyLAD8LaD9I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10244

On some boards such as S32G based, changing the pinctrl state
in suspend routine may not be supported.

For this scenario the newly introduced flag
'ESDHC_FLAG_SKIP_PINCTRL_SLEEP' is used.

Signed-off-by: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 8f0bc6dca2b0..c3ff7fccd051 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -204,6 +204,9 @@
 /* The IP does not have GPIO CD wake capabilities */
 #define ESDHC_FLAG_SKIP_CD_WAKE		BIT(18)
 
+/* The IP does not support transition to pinctrl sleep state */
+#define ESDHC_FLAG_SKIP_PINCTRL_SLEEP  BIT(19)
+
 enum wp_types {
 	ESDHC_WP_NONE,		/* no WP, neither controller nor gpio */
 	ESDHC_WP_CONTROLLER,	/* mmc controller internal WP */
@@ -301,7 +304,8 @@ static struct esdhc_soc_data usdhc_s32g2_data = {
 	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_MAN_TUNING
 			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
 			| ESDHC_FLAG_HS400 | ESDHC_FLAG_HS400_ES
-			| ESDHC_FLAG_SKIP_ERR004536 | ESDHC_FLAG_SKIP_CD_WAKE,
+			| ESDHC_FLAG_SKIP_ERR004536 | ESDHC_FLAG_SKIP_CD_WAKE
+			| ESDHC_FLAG_SKIP_PINCTRL_SLEEP,
 };
 
 static struct esdhc_soc_data usdhc_imx7ulp_data = {
@@ -1884,9 +1888,11 @@ static int sdhci_esdhc_suspend(struct device *dev)
 	if (ret)
 		return ret;
 
-	ret = pinctrl_pm_select_sleep_state(dev);
-	if (ret)
-		return ret;
+	if (!(imx_data->socdata->flags & ESDHC_FLAG_SKIP_PINCTRL_SLEEP)) {
+		ret = pinctrl_pm_select_sleep_state(dev);
+		if (ret)
+			return ret;
+	}
 
 	ret = mmc_gpio_set_cd_wake(host->mmc, true);
 
-- 
2.45.2

