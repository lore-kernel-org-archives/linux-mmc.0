Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=139.219.146.100
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794212321;
	b=cImAty2IekBDn2g1EFbtA43nBJLG6+pAzZUJg+DXGCLV/8dfFlz0o+v4PciRhl8bJZ+n
	 ZXApfbz2V41og0rwkE1dBEcbY/DWGe7KJ/qEHZd3zaWvtS0P0Syq6JF66PZG6c5S5Fstt
	 XW01aqNCBqWZMNgXZz+oUHrUCTIDVKGRRCFI10I76ZagJ0BxsB8UPfW77lEQpdbM+RiYv
	 SrTpCVGXPRmcS2A0ODB9XmviihGblAcwvn+388mZfyb4V1PsEPjxkdMgblRhq9XTf0b3v
	 Viu1CKN7R6IsPzKYKMvV21+3dUJoWWo9FgmmveWelcNldmR+YWF9P62OLmYFK8jbD8g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794212321;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=hqOIM/Msc7NeLTcnlcWQkqsTkazFwMjshZq4BRoTHrE=;
	b=3glWmbW49CaqPIqJWMQvz1n07lxUzAy9y9KEsogtfregX0NsGo/fZ37j/hCYuk/PCLHS
	 G0pfnSREU69gxUJeuY+DoKscfIkN1Xfrt+kjsCJ9du8Zi3ekm/jOLjrXzY+8FhDy5RmLV
	 S6jI+h1m6/kWWk4uV0zrd2FiOeUZOj7h5TUOVSa54VnWneVyhWz1MfmXWeQp86SCGOgcO
	 hpP9PBQYLgSg25cTGs8c78QZePA8hhhmFQmZLcS9UgOQQmNgkWVuRKaQKtnmmNVbj7aHB
	 wynJGqDduB02VxJXBi3hDd7WJP2YkNXYL4vdxj6iQ/i8uxzgfy5hbKJJYt7KMswsrlQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=starfivetech.com;
	spf=pass smtp.mailfrom=starfivetech.com;
	arc=fail smtp.remote-ip=139.219.146.100
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2100.outbound.protection.partner.outlook.cn [139.219.146.100])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D41606A321;
	Mon,  9 Nov 2026 08:18:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9D41606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OglE/vYq5VTjZ8oMiRY+HuddQ//9f9Ca6lQKpEgtwzWujePfyICEJW8a5U0vAyLbDOJoJnN3j6p8J27aRJFALW+x2xIvVW8MJwNpeWNHt32dC/kRrDU5fS6p7RE4YRqyy802NQONY1VO7Wlpmdivg4U/BEZOfP6/+cuTOX7tg+nD1fbroD1ruxHtcu97Quk9DN015cCJ5GLytferq5vs3/QZhlGUYitno6yH/SibEH42CZld8YTIKeQjUzcG8cfyIC7+L8JL9tQ9BA8CI5LZ3cyPeKrGcx4JKHHZVRxPMrlRLbpaAfUamj3zccNuWQbr7+spl3h9Cz0KD/4uIm+SGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hqOIM/Msc7NeLTcnlcWQkqsTkazFwMjshZq4BRoTHrE=;
 b=IqtPPZDZqjmlFvBNh3kHjQ3/pn4iXqo+7Hr77HPmm+QPi1pSBwbtICSMY4APrlnbR9uaZ0wmuc2FV30gdinMEBZ4vJS6zaguXqxfXR5rKbcR/D0Kml5q7mcTEQYIy33tZsRUyx1HBgWcy3cduKxmyJVvdtSXUNzSnlqp/Xbl4oJGJqKz8G28BzNRHE4hAxuZ087UaA/Vph4CYOunQ6icvAddx5o8/gesaIpvx7+Y9xr3YwAo0UmY7G4JFwxnQvNsyoZaf/Xpuu5J1pvt7cBOhPmO7V4yOf67NdaViDcAv/emyEJTosUi66DnSQK0AZBj3tO0v7zz12yBjq2i9oNY+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1201.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:13::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 08:18:27 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%4])
 with mapi id 15.21.0592.010; Mon, 9 Nov 2026 08:18:27 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Ritesh Harjani <ritesh.list@gmail.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Changhuang Liang <changhuang.liang@starfivetech.com>
Subject: [PATCH v3 0/2] Improve eMMC performance for the StarFive JHB100 SoC
Date: Mon,  9 Nov 2026 00:18:11 -0800
Message-Id: <20261109081813.3846-1-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0019.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:c::22) To ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ4PR01MB1202:EE_|ZQ4PR01MB1201:EE_
X-MS-Office365-Filtering-Correlation-Id: e880e11f-31a9-41c4-82a7-08df3e3a080c
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|52116014|366016|18002099003|10067099003|261102130727099003|261102123227099003|261022075727099003|56012099006|261021121427099003|261026121527099003|261009223027099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	IXWXDWQ/MgTkZq9SIeFtLPd5l9kralj76K3//CqZJY+WlF3WD1Qsgyy2xhxtCmbsaRfxnnP/2ahXLtF20GyQUalh3IrmhOGaQgUxUaeHmOi+mJqS07Vpf3Gt0wQFeaT65jI8lO4E2ulbwgxXdqOGLOmT6t8EBAwE3MScN2dW+R4qieLx+wy0di+c0/XTV3Y5fPbJZGxxn7JXU0ED/Mg6LM3v7sNzkW6mQawXezouUylZ0akPNuvUAKDJoU/u6MwyRVZQ6UZLJuU5Kcs5sN3cGJelO6ZGdg8EJChxZYh0fWxJzz+OpJPybpfQAw6NqrLm97uhpdHWADb2PMZeOYDbFbzsMH+ey/MeKzsOMEz3RJ+PAdHljZ9f9pJpzBGcCV7ZeXzXuBZV9cMU2GWJBwbK6l/cWl2OrgsJIfMwcpSuq9/294XrQKm8O9nsrdxIcB1Xg4htJ23dmJsVO67rIvgTPppuEOezefeTOhrC+IQwIo5824I/jyPoEkEDdR1crHcGCwFDkgJSGuWS6YBKA+3SjliR77Vm9p+SroFuzL94689mDW056kHc6K8u+dsctsXe
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(52116014)(366016)(18002099003)(10067099003)(261102130727099003)(261102123227099003)(261022075727099003)(56012099006)(261021121427099003)(261026121527099003)(261009223027099003)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZISjhkBZ63HMYvWFDgN0pjoJy0ZXYIKaEAwe2R2avulhwA0MxWl+YsiYfkb2?=
 =?us-ascii?Q?m8An9JuKHDP+tShcO1SCjqI9xzN+J4RgLSBTIBux84jHo/9jp/Zy+LwztCtj?=
 =?us-ascii?Q?RWExZ1h3jmmohbtrH17Bc7C946EhsWzdV+Nt/u1/jXRrfUDgSGbC7tBajo9n?=
 =?us-ascii?Q?O/254b6onUZReMjFLpznBWJSnrMv3MsT6/phXcuRrWMZBAwy67OQM+9DzfJI?=
 =?us-ascii?Q?J+EuBUwQYt/TxPMWg5HSgUFqkAAtsR3yqvmnIwNCe220X1V57uzdvmEuUhPr?=
 =?us-ascii?Q?1jjLQBWXcsfRC/D0H5JLSuwERCbazgkfxE6THlZVNSD45SOwE9+gB0Siu1GF?=
 =?us-ascii?Q?a41ybdRaWJmSOweeFUirA9Z+IkH2way18P8HyRynCVRbk0c3+5nL7/J8AQAx?=
 =?us-ascii?Q?P1sxFBrNpDJ0iUchmIpkLRtkN4pHtZkl9v7r+BmRkN9Q1RlcOslNKJOBgQMp?=
 =?us-ascii?Q?UvsyFgJd4d/PCLMBdVxtJGC2+tBbe/Mn5p5S+fbTGvONVQMhE0zcnCzKBnA3?=
 =?us-ascii?Q?tphBMUqLdU8/ctJMCXPLL+ppZrro0FPsFrlswyfLqfyI6dp1z8rKGwOspaf8?=
 =?us-ascii?Q?XqBZgw4iECupdGGpuIpN62wgfV0KBZQaGXvPh7dpkoptCw1nkOpzP9aLpjDR?=
 =?us-ascii?Q?oHwk5iAjmOVj44h+KdkJIzQ12Sk6ilpyVHpRYwUfNXPr+S5Amm9JXosOl47D?=
 =?us-ascii?Q?Q64XHiqUQEq+pcuuSt6bP8Q1QmnYYeKnKrbdEdojeibY8rTsnwGAnrKhE5oq?=
 =?us-ascii?Q?z0e/sqYJPDbhNGKGRg66JwqNZhq2ivSefUAzrWi0IbyEoXAyLRGqysT/ba8B?=
 =?us-ascii?Q?vvdBD+N224YncG/BlNFPipEaEXJ3fmwwAPg9/AGHqFnvprKDAkYd4X1OYDhH?=
 =?us-ascii?Q?+YHiA22Z3uKzVjvAjAtjozDvXmNziF3z4Bg0903yqhJ7lfZhOaZbEpeF4RsH?=
 =?us-ascii?Q?qx0VPWaTjUpul9NGs0EipYtp8H3r3/ASPtnsze88ajRpDCXxb1bKi4/tuXdO?=
 =?us-ascii?Q?/fuqt7SfWUC2pDzUu6Y4oCBp/xoI0/J7jO+RF4UE6iHD5gzcYC1TVG7KPKHb?=
 =?us-ascii?Q?fIojRZEF9bdVkKv91HMLoOZzYL49ugK8lhm3Jn7aw6gpCp4xJVZHA2/dvOKd?=
 =?us-ascii?Q?QAJUJFq2EBtd0zifMVguaCPmQl/wM6o/ga6jT5M0H6ANjucjYKqusSXmmCrw?=
 =?us-ascii?Q?Ap2Eo4Kyn6n4Ivoca2NjXGut3C2JP0LeoczbEwVOS7zLMbaj//wtDmJ+xOG0?=
 =?us-ascii?Q?2GmgzVeHctolVwECoFxGb/WCKlmOyjkIXTLGpe2EwKep03VzkxoL4pzdEr/r?=
 =?us-ascii?Q?DhNYNJ/GQ9+l5hUqhvYZAYxl92fOX6ZC6UIObdUGNGPqD1lfT3ZzvwRDcX8L?=
 =?us-ascii?Q?tP9PL/LpCimLyoMZXGMqTroXvH1o3ozozu0bAPXZVs/ezzOXHRf9qqOQSFzj?=
 =?us-ascii?Q?MjsCG3bkEAGKwjVwn451s2UGuZHMgYiM+yQOFsum+hFEZymCV3BYtZHlQnKJ?=
 =?us-ascii?Q?ezdge88+vF1sC2IWSI8aUBIvH+sEUVZkBFYpRgECX5TuXiCV0Wtdty1cc21s?=
 =?us-ascii?Q?EIS8acgBbbGRgQeafW1eh+a+GbUKAs3spu2exJWzJdJKzYpYZyhcZpmmb4Bq?=
 =?us-ascii?Q?KSeNBKEWwSEt0MLd7I4sAJmi572uK9lVOgOud+5GN+lBKywYmvAQRVpGs2R+?=
 =?us-ascii?Q?AquRpUHC/JPfDpDEcHHIRiIXWm+2o+QBvgSMWsnduOwNSrGYZbUIfZMe4+rH?=
 =?us-ascii?Q?aDsXr9pw1DvCgCPnU+4XdwJT+G3o++voKqr+qq9CT84wwVjxve3r?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e880e11f-31a9-41c4-82a7-08df3e3a080c
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 08:18:27.5948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EV4a/9lys98RFS6WM8s+JblmnRsLMW6dCaeBHJCAvBUe/vPN71pvZDEK9tAjy3l+8pgZ6XbUKYvdmh4NgXRlLgnTEgWgATc0cjpO2Jq+2mTuJKbv1Tce8MWDyArTLAdy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1201

This series implements programmable support for CIT, allowing host drivers to
set the Send Status Command Idle Timer (CIT) in CQHCI_SSC1, either in
nanoseconds or directly in internal timer clock cycles.
Different platforms can improve MMC performance by configuring their respective
CIT. This series has been tested on the JHB100 SoC.

before:
dd if=/dev/mmcblk0 of=/dev/null bs=1M count=800
838860800 bytes (839 MB, 800 MiB) copied, 9.38511 s, 89.4 MB/s
dd if=/dev/zero of=/dev/mmcblk0 bs=1M count=800
838860800 bytes (839 MB, 800 MiB) copied, 12.2127 s, 68.7 MB/s

after:
dd if=/dev/mmcblk0 of=/dev/null bs=1M count=800
838860800 bytes (839 MB, 800 MiB) copied, 3.19472 s, 263 MB/s
dd if=/dev/zero of=/dev/mmcblk0 bs=1M count=800
838860800 bytes (839 MB, 800 MiB) copied, 10.7587 s, 78.0 MB/s

Changes since v2:

Patch 1:
- cqhci_set_cmd_idle_time() is removed, along with its EXPORT_SYMBOL.
- A new internal helper, cqhci_init_cit(), computes the CIT during
  cqhci_init(), replacing cqhci_itcf_init().
- Replace itcf_hz with a driver-provided cit_ns field.

Patch 2:
- simply assigns cq_host->cit_ns = pltfm_data->cqhci_cit_ns before cqhci_init().
- dropping the post-init cqhci_set_cmd_idle_time() call and its warning path.

v2: https://lore.kernel.org/all/20261104112657.110536-1-changhuang.liang@starfivetech.com/
v1: https://lore.kernel.org/all/20261014121222.31385-1-changhuang.liang@starfivetech.com/

Changhuang Liang (2):
  mmc: cqhci: Add support for setting the Send Status Command Idle Timer
  mmc: sdhci-of-dwcmshc: Set CQHCI command idle time for StarFive JHB100

 drivers/mmc/host/cqhci-core.c       | 45 +++++++++++++++++++++++++++++
 drivers/mmc/host/cqhci.h            | 13 +++++++++
 drivers/mmc/host/sdhci-of-dwcmshc.c |  7 +++++
 3 files changed, 65 insertions(+)

--
2.25.1
