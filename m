Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2081.outbound.protection.outlook.com [40.107.104.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC590152184;
	Fri,  5 Jul 2024 13:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720187250; cv=fail; b=r1AW9xzfTlJgOEIDTcypbL6laTJPsjCqhTZLPmmaHGLpQSr/sDD5h6kofnekzxRGKgRhzWGy8YpO8sHfjNx4i94HEQk32w3ayAMrOWWW/cF7gRiluWWImq2h6BYaDjwmSXG5YtSmxUZFh8+lAh8KnO2g9g5bwHJnjtKj9vZPNLw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720187250; c=relaxed/simple;
	bh=4/UivPtlR60qrSoh3s+mf7nWjTTkNYETFIIUAGpASAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d7HJzQz+cfKBYkRX56b/kTXrQRRraemvvUIKii1HQZv+qTaM9i3fTlWBlMJ06DDTwSIDlhG2HjT8t+oEP+1iklJeLCC8ScxCqBc59hae7q5ej8l4u8jVSuEGE080fgZolcuOdfye12XM/zIV6p4XEZTjSsoL0PpfmDqSzFywgGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=j8G2L2eM; arc=fail smtp.client-ip=40.107.104.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="j8G2L2eM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gCuqvQMRSMS5UZnPk1tbxSu9Ek9RKv74uQd5PaEZ+ymtz8epbhTX50vO4DCt/4BXrf39IOqxPtirJCrmQTSxMABeUGQejFCxTdCC4/CAeO9uhOkSWPgfgMI/Yg+xqiYmwTaVp6XIs6AosE0OiJZWgEMnG+/lFzMVK7GPSdhGE5KFRs34IuRdpancJaQFu0O0lfbOxgReLMRjLDLTQH4IBiiQTANDfK8wAyQymaQJR21qA4CfGS7kYqBEnj5MS6bJPMXSTK0agFQ1PecRlEQoe/iRFn8elIVr2Ltu7VnKZBUwiyT35NJIanh9fP6RE19bjt74VJmhTOShMpARbM+4bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sf7OPVuzFCVUbxqXMXgjlFlzFPQmuxktVkyKjUGXAQg=;
 b=nR8iKJOENa3yu5/HDaqrb8rv58mSHrtWw5d2qyyQnu7PnGZyZoSHDx2fNO22gLnWs/wqPtpDpARBPuSiBXgfkL5KFinJXF3Vf6KOFfA2OUDxsvWV3cV25WoXMAoJFSuuHrBJSQ/sGG8jugvmHSbqprFljCF21Duydu4VUfL8xS26gkBgMURKA88Lsg+nr9EiylBhIh0Pn8GEa1WVZ08vSSDOX7XRIz6uIAxCzc/Ru65bpy9TJjWQbiTYDjD6oNrZfRRNE+6T2QsMvMMRHgAD/s2Qb6QL/tCfRIoHKJ01gYzB3UncZnN+4VZu17bcmSGO2gPXFdu1dTJtwzCzmP4sKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sf7OPVuzFCVUbxqXMXgjlFlzFPQmuxktVkyKjUGXAQg=;
 b=j8G2L2eMeViQhmakzwiAqXIuYx+8NIDO3jJO8B3G8AFYsuj8GaUflgt+7EXaURhnp+9eKYLZnJSIUTs9rqTCGaSrV9ajQyt+JhwwbT0xYNnB9w6uW6yQv1YWW8sSfpgMfS1OZ5SFiCoWZ8eCNbrTnK5RrcrDwmvrcVzQb2Usrj8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by GV1PR04MB10244.eurprd04.prod.outlook.com (2603:10a6:150:17b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.30; Fri, 5 Jul
 2024 13:47:22 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd%5]) with mapi id 15.20.7741.027; Fri, 5 Jul 2024
 13:47:21 +0000
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
Subject: [PATCH 2/4] mmc: sdhci-esdhc-imx: obtain the 'per' clock rate after its enablement
Date: Fri,  5 Jul 2024 16:46:45 +0300
Message-ID: <20240705134647.3524969-3-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240705134647.3524969-1-ciprianmarian.costea@oss.nxp.com>
References: <20240705134647.3524969-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P189CA0033.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dd::6) To DU0PR04MB9251.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: b70175c4-7977-4f52-f217-08dc9cf8fe9b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OU83Rkkrd3lHWDVaS0F5SWpOSENyZS9jYTVKdnp6TXVFUXhCVlRJMzRBYk1j?=
 =?utf-8?B?bHR4VUhoQVk3QnhtNWhnSXdEZXVtUnhYVC9vd2NXbCtDY2IxTlpMaUswMWoz?=
 =?utf-8?B?YU1QWlVoTitaWlFJbnNnbTlQOGtseU5jVENGY2pMcEZzWjh6dXEzZFdRUktm?=
 =?utf-8?B?K09sT3B5emJIWUlJTk5jRGdYaUpRWENSTGNFMWdMYzIyaXNROTZIQ2d3SkZB?=
 =?utf-8?B?Uk50cFkwNlk3c3B6QVQ1SmM1MjlEM24wSmF2UG5kcWMzclVFdGxWN3d2U3B6?=
 =?utf-8?B?bWJJbWxPSTJxVjJpY1g5eTdPcURVQWJPcXk1U2huNmFWTXJZMWJWOE9aa1Y5?=
 =?utf-8?B?eUZ2SmV2T1JoVlRTc3VvODhJOFJGSGZkcXNIUGdWd0N2VmNhSytXbXhaSUVn?=
 =?utf-8?B?b3ZvWjVhbnNVbExodVlKRkJ3TGRoaUROVmhneG1paWhOYUNCSXBXL2JSdEZT?=
 =?utf-8?B?OVVNZW1MdjhHN04yT2pDV3gvTVVCZHZKYWN5TmpLOGJ6KzhBVDhWVmJ1blJp?=
 =?utf-8?B?MzZOUWlBdVJ3MG5MSEVnYjJ5cVNzblpJTDJhSURhMFpKTElKZUpiYUlOVkI5?=
 =?utf-8?B?NEpuU2RTUHJ1MmlvV2hlYzhiMlRnR1pvb05xZW9PaitSZjlpTmorYm1VOTdF?=
 =?utf-8?B?UW5PYVVWS3BqaFJzalZuUWgyQk5jUTg3UFcvenAzb0VDZzVGZXdxTmwyRFBk?=
 =?utf-8?B?Zm9zQW9VVDhhMFdpbXpBVWU5azJSY1B0QUIyT2hESXJMOUJCTGVBSGE3aGVv?=
 =?utf-8?B?ekUrcHZrTkZXb1dWU1drNHVZL01CcStGZ1pXbFdyeFVlOWhpOUV4WnNXTk9k?=
 =?utf-8?B?ZjJ0N0FuQjVoZjdteTliWUhDRUNYQkJtcmRTS1FvdzVvMitJaTZDb1BYUEV4?=
 =?utf-8?B?NW0xU1o5R3JUS0tEUXY2NDVuN1Q5aUxXTHJxNW1Zc1g5ZUNDWjAwOVRITkVT?=
 =?utf-8?B?R3ZkL1ZUalVlTjkxVUR1TEJxNk1VNWtERUpmalZaZlB1S09Ya0RXdGNUeU5W?=
 =?utf-8?B?d3Q4TXZSV0wwdDd0T3FHOGtnRVU2bjNwZktjRHR4S3hkZnNkeFl1bnpnZ3I5?=
 =?utf-8?B?K3BNQ0U0RGV5bWhBMjdHZHJZTzY5SUxJWTBITlp0MklVdlNIM0RZbElpaVFE?=
 =?utf-8?B?cnNMM2NVK0VZQkRENkZVU2E2bzgyNnlIemtwb2k2azZzcy9leFltbFFXdEZk?=
 =?utf-8?B?NVhwdUc0Q05wTHZHaTJOamRsZFNMUjZBaTArOUNrTk56OGgwa1E1NDlCQngy?=
 =?utf-8?B?cWUzWWpyb1MyMzd2SGF4bkJzTFlneU0wZXNsRVJUYzdsdWc3Qy94MHp1Uysz?=
 =?utf-8?B?a2JsTEl5UkU1Z3pBN25vZDRoQmZscEZjWEpXUGJQdnlEK0VqRDRwcUt4UXcy?=
 =?utf-8?B?d0pWcFptRno5VmlxamY4QWFRM3J5RFJtR0k5ZU1zUnQ2bEJpSFd4MWlFMkt3?=
 =?utf-8?B?V2ZFQitMdUFMQThxbCs3dWE4UXpuNE11Q3M2MDQ3dWk4L0ZldEFrZ2V6YWQr?=
 =?utf-8?B?RlZIV0Vhb2IwWkZ1VEc1RnkzNTg5Q09BSTF3LzNsSG9Ga3VOeDN6b2QvWDcr?=
 =?utf-8?B?dUloZ3ZtWlVLcFlDTUF6U05FaFZFWExRdlRHYUNzNTB5NVJHOHRobCtBTmhI?=
 =?utf-8?B?L3pQYUFrK0ZIZGxKbGhQbEZGd2p0d1YzMmpNUUhid3BMeDA5YTVsUitlaUlR?=
 =?utf-8?B?WXZ2cmhFWnlYWTUvQjJ6Q29wMWloV1l3ZlJnWUl3RDZ0Qk9WL3BOalZIeTlh?=
 =?utf-8?B?cjVISGtMcHdTZXozVFUyWHNDT2w4dUg3bW45ZE1rblB6NmIvT0djVElaMWdR?=
 =?utf-8?B?TGV6UHJGNlhPK1h4Zk5EUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VTVBeVlTN0oyY3VGREoyVDNCTms0b2daQzNuTzRCV0RqVmQ5QTFFVDVrYnJR?=
 =?utf-8?B?bFBIMmMwVlAvV2NZVEJicDB4L09mbnRlaTNwVUFCY2V3YmxMdVJ6VjZDMnls?=
 =?utf-8?B?U2NDTDZlZTVkVWRsM3ExUFEzRUpyNlpsRi9LL2Y4L3RYNU9YcmgzbnpVS3NS?=
 =?utf-8?B?VElBVzZZY1grbWVIWGxMZ2QrdDdYRVpvVlNiS3pkMEIzK2xIdi9uVUtqZUE1?=
 =?utf-8?B?Z1BRaE9sMWNUTWRLWUYrTXk0SGpuK1puS2QzbWQ1SmZFZFhPWEJza09KcU1M?=
 =?utf-8?B?MUkzeDdoRU5SVmcxQW53RmFtT0NPeUZGdXVFQndES1Uyd0VLWnd3Zk1LZ0pn?=
 =?utf-8?B?RGJ2OEFFT1hHMHFHRGFBNG1vZytFa2ZFZmdzWHorK2hWcVJOUms3MzNCL3ZB?=
 =?utf-8?B?L2ZBYy9QU0ZtLzRuaEZsVXNnT3Y5UGp3L3FOU3poUDYydnJDN2dIY0Y2MDJI?=
 =?utf-8?B?SkFraUVJUkoxazdWK1czVGRVNTdWUHF0bmVzQ0ZUQVBTYjlSejFzQXhvTWI5?=
 =?utf-8?B?WFpjd1FUYnQzQ2VTbmNQZjZEV29UaC9YZm5uTWZTZlQzbzlGd1k0NTNJRmV0?=
 =?utf-8?B?RjA0UCsrSGFiV0RtbnlnVllVTW04T3VmMFc1bUhvWFp5Ym1IbWtWZTBYZjJX?=
 =?utf-8?B?ZjR0T0lia0pNc0xsL1hqbTBPNzEwUjZ6QW5maVVuK2tvQU5jcVBHeXR1eERU?=
 =?utf-8?B?UWMxekZsNEVJdUg0cDhPN3Q1OTdGWUpUZFRKWlA4Y29ORkpybHNUa1R0RlRv?=
 =?utf-8?B?U0wzaEhjVlowNDlXazV0RFNlaUluRWRmM0NsRnorTE55RWhjemdGbWZZSzJO?=
 =?utf-8?B?c1ZtMmRMbngyKzF3RUo3WThFZDVhMGU1MXpMOTNsQy9MbHFFZTNRVkduNVBR?=
 =?utf-8?B?eDdpWm9TTnByWGNkUkkrNU9xY1pUNGF4SnF0c1Y2U2xLRGcvaGpZdU9NSitB?=
 =?utf-8?B?M1VjTWZ3cGJvSktKZXVwdzg0UFg5c3AxRkYyMWF6d1dHRjZ1MlJZMmlyT2sv?=
 =?utf-8?B?Sm5aOXVabVE4U1FuY3VQdFg1Y25DTHdjZWVqeEF3SXVLdnRDdkloQndNQ05a?=
 =?utf-8?B?TTFnMUJScWdPUEhVb3cva3FHVW5tMGpXK0IvNzdCQmw0bUdCTkpJdU1ieko5?=
 =?utf-8?B?Rk9vNkg5K290cGIwalVsaG5COUdBWDlrWDA0eC9xK3ZLV2M4cU9Uc0ZyazI4?=
 =?utf-8?B?ejg1NEFpQU1ycVJ3N2JSTFNJUjQ3T2tZZWJBNDFGTDh0eDRDMzgxWkR1K3B2?=
 =?utf-8?B?YjVlbmdTK2NESmtRZ2RBenFRQU5nVTRIZUdZSGdlMG9vckJpTXJnbGlUUFgz?=
 =?utf-8?B?RkpZblRlK3JtQi9vVWVvcmNSNlJsNlg5anNVOVA4WGEzSTUrV3JlTnVkVXhM?=
 =?utf-8?B?VUhZUDJIN1h5Qm9xZHVhWFJEY2FJWm5zd1ZqeVFMQnU2UVlISFVHd1N5U3FH?=
 =?utf-8?B?UDFMY2tLdTM0bm9kWVZDUkVSNlVNVTV1cGRpSUpHU1NrckVPUWhxK3BheTRV?=
 =?utf-8?B?cS9vN1hGTGRLRnljN3oweVFxeERoeFRMdk9iSmpEcTZ1NWNpem45d05sQjRD?=
 =?utf-8?B?aXk2ajFGdUpQWHMxUy9JU3hIN3lydm1HakxMUkdpU3hEQ0dnRUlScTc1Tjdi?=
 =?utf-8?B?ckFwUW5XWUhka2pRdlR1dDFFclNUNGNobkszaTdpWFgxNE1RMUpyOFZ3SG83?=
 =?utf-8?B?SDhlcG80K1UxblRScWR0R0Jua09BdGw1VU8yaHJldzJJUHpvUFBDQnUzdjYx?=
 =?utf-8?B?aGZ5dXNDK09CNVhRc052OWlwbGU4ZCtjNjVtYTQ1TUF2WG1DUXNBL1kyZzA4?=
 =?utf-8?B?UnVGTXdPRVRzODVWUUowWE13aFZ2cnFOckd0RVBoUG9yM3k3bVgvcDNGcWxE?=
 =?utf-8?B?aXdLZS8vSS9CVFpldUY2bGFGRHZydkNmSEl6bTVNaGRvektvTDBUY1V4M1Zk?=
 =?utf-8?B?RS95TTFza20wWlBEL0VVWEgyd2Y0YWQ0WFBxVEtSSnFrVFQ2U2RNSm4vdjd5?=
 =?utf-8?B?Z0tQb3pnM0lwYUlHZFRkaTRZLzk1cUREZU1aNXd5QzQxaHBHTjAyd2tkc1FW?=
 =?utf-8?B?c0hLU0dKMWs3RDd1ai9WbnZha1o0QlBzL3cxSWVveW9wcXBONU9YeTNGeDcv?=
 =?utf-8?B?bmdqRW9YdnZ5NzlRc2F6VlZvSVpBMTJmTHhHRmRhTUx4ejhvc3NLT0o5S2RJ?=
 =?utf-8?B?aGc9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b70175c4-7977-4f52-f217-08dc9cf8fe9b
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 13:47:21.8437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 17rOjZFZWSx89+Z6vbVtRZOL44/R2vODoNIy01bQH/cNAH2BtSPZuyewmbnBTMeotIpBlu6Ry7LGAkH9xdl7W7u09LlsY2W7DcWB60d1UFM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10244

The I.MX SDHCI driver assumes that the frequency of the 'per' clock
can be obtained even on disabled clocks, which is not always the case.

According to 'clk_get_rate' documentation, it is only valid
once the clock source has been enabled.

Signed-off-by: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 21d984a77be8..8f0bc6dca2b0 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1709,7 +1709,6 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 	}
 
 	pltfm_host->clk = imx_data->clk_per;
-	pltfm_host->clock = clk_get_rate(pltfm_host->clk);
 	err = clk_prepare_enable(imx_data->clk_per);
 	if (err)
 		goto free_sdhci;
@@ -1720,6 +1719,13 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 	if (err)
 		goto disable_ipg_clk;
 
+	pltfm_host->clock = clk_get_rate(pltfm_host->clk);
+	if (!pltfm_host->clock) {
+		dev_err(mmc_dev(host->mmc), "could not get clk rate\n");
+		err = -EINVAL;
+		goto disable_ahb_clk;
+	}
+
 	imx_data->pinctrl = devm_pinctrl_get(&pdev->dev);
 	if (IS_ERR(imx_data->pinctrl))
 		dev_warn(mmc_dev(host->mmc), "could not get pinctrl\n");
-- 
2.45.2

