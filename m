Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=139.219.17.125
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793791636;
	b=z775ycz/2AGH/W8+EasGG+punbhBpSH1bS9qrTpYkPshVJHr/df+bebTyl1bnBHYHxII
	 00VAw7YtPal9u8gdscMeOCqzZRmaMdEG4HEX1WUpJLF4TYYgkWX2GpRGxDyW8LRNT70Bf
	 L78SbZ3aAJRUOG+uHttCr0vFjW5fidvbBTm5AkiC5s4dwDq7xrJv2A877bg5XaqNtDnKf
	 WGLzfA0IkSs3NzhLEATwQIJY+0c+p5k6n5j4zoEAJeN6HP9aa/OCnSsrjepXj8Cj47vmN
	 3w6OFO98jWQ79lx+BWuOy8YxNHmxwIPpE+maMUElOLN5Ef9XBDg66bLrAquLOvXuSlw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793791636;
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
	bh=dnVjikP4cBeCPcQEAuzK10Ypkw+IzKvzRm0/pctNEw8=;
	b=M/zTg/flhGKOCpOg8fRDILoi7clos2Yt2B3fPLLhjbT4pg22pTn/9tpSRyf/sqgpqvnV
	 Ry7h7LbYVhxq/PifRWo1DwD1SfGVD/DUkvDcLc/6t5aRNQIx1eXofGRHrNDO3P1uBD+0u
	 R7SrsK5VGuhr1a1sJtyHZrNeu86j/IdTmRjYt6NxIhEuPKJczls1ih/YxjzzIMktGeNXn
	 2rlpegqolGcgymamx2yLt6E2iW7b3XdTgj7PGM//WjHfed06id7QRE7AF+Nt4A+3iITBF
	 NAzR4Xz6zOB5CQF0neZ0cF/R9jPs3+WwyGAqVu6uzrjuMzFz5wU4WP19krMwvHued6w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=starfivetech.com;
	spf=pass smtp.mailfrom=starfivetech.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=139.219.17.125
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2125.outbound.protection.partner.outlook.cn [139.219.17.125])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D10D606A333;
	Wed,  4 Nov 2026 11:27:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D10D606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E7OWwbRWSM0I5/EUFM3VA/Qu87C7So0Gm0Zw9eB/YcTkYE6K88Tt0Gt4uL9wfp74kiqnowSYIRtjxZG2rEIsZyz4n6ijMw9k/VTAnvO+Q483ubU1BEXEhSGl8Wi6++QtFLcXSohQbP0fVmWsTBjtPIJyEyvnR/VJBwnkyg53EvFpnVn/PgE6YJT6q9+mwsUwHBTMTAIebXysS1icMJU52yQxLx8siu9SGuyhK+yMBJe/+5YG7+7sekTyZkO67ujeNG2oZ69zen/iGYwQuHT+pyu94jdp361/89NfH/mLzuSFO+HBQhGeXaNzF2LNw5VKvivQS2COeUzLTooexg+nfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dnVjikP4cBeCPcQEAuzK10Ypkw+IzKvzRm0/pctNEw8=;
 b=R0HOiqHSQUYxvtH8yFgjAsdQ5Z82QzZnSXNmO0L2upCRrNQV/89q78KY6JFTdK9kuUOb3srsbQzSz0cTezln7ghOemqAUNXT/VLZXWohyLVrMzaXLy2DRrOS+EHMKLmMwDROszoCvIMG6K2/TDEDsPfB1cJv++CCsJWhM2vaG8gEMj1n27UW9mKi+Rv7sKANmIZiy5gRy/YxCqulu8IO838L+jmT2vsEcTYqk/UoMkTjT1gmMiydTkPaYAvnQlzHMOdJHGeQs9I+ZzgO5qGMzGlBW4hC401yocu7aHYUXe0TNXMBkrmIbGTbzOuu3xJ3qjRtkNhKGaqGjdYqSA6vnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1218.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Wed, 4 Nov
 2026 11:27:04 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%4])
 with mapi id 15.21.0592.009; Wed, 4 Nov 2026 11:27:04 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Asutosh Das <quic_asutoshd@quicinc.com>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Changhuang Liang <changhuang.liang@starfivetech.com>
Subject: [PATCH v2 0/2] Improve eMMC performance for the StarFive JHB100 SoC
Date: Wed,  4 Nov 2026 03:26:55 -0800
Message-Id: <20261104112657.110536-1-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJSPR01CA0007.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:c::19) To ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
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
X-MS-TrafficTypeDiagnostic: ZQ4PR01MB1202:EE_|ZQ4PR01MB1218:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b5a715e-2f08-4ab7-dbf9-08df3a668d4f
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|52116014|1800799024|10067099003|18002099003|38350700014|56012099006|261021121427099003|261009223027099003|261102123227099003;
X-Microsoft-Antispam-Message-Info:
	25DTYMgpH5yCcymLfjnvxsj4ATYPe8M1nq1KgLva2D1VTRhyUcO+0jJSuPQsmjj635Rvm7zFCWQPpsUHAGlNHno5bBHMPkGzGChytubx+pKrN5OYiIGEi6DAlR55ybjfehz0SxousBhWZnOLEIoIwPOovhtQsucLirIkNT6SOaXMzBd2z7mKgC2K7XMaJB6G027jmF9TRDmjs1Lxpz+M8pmKGQbPToajoyljtKlopvkcUUuqmfcg9jvIz6fsLr9PF7ogi81Si1l1VrJHEnBauAREC7shXg+CCLFzA7Tr5o0bAAce67mVKzO1TbXgsb+W+rl3qRJBxF9lPhfKtGulGWQzXCg99yrcU9e+mRjO50wZN2WKQgJxNfQJTswDyUsxFpXsuut2BlZU53HbWLqHxEWskjmpOv05ME3oiBbLNmDLMsW73K6dlF5beeilSkv1ndO8VavuHI0xF16+qpVDjeo/bk3h75bnCyTfgml9biodFF6KEqIXzeyKWT8AHw3QWBH7lKjbM2UVTiXwLpAwyDeZwCAmOx77oi7kG7jzFe1Ygu2yNn6DA3EVMOoduWAm
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(52116014)(1800799024)(10067099003)(18002099003)(38350700014)(56012099006)(261021121427099003)(261009223027099003)(261102123227099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LN8+Uz2rcpk96xiDuF7wnSTWwx8sc7OudysFFmNIcU/qOflFmZz9aSkc+xpQ?=
 =?us-ascii?Q?1JUOHiaP4ORLGu7g5TdpJHBm69X29e1grb70Vy8yMq8LAAY16p/QY7qxO1sk?=
 =?us-ascii?Q?D6CqbeQdA7WRPWlYRgDw3oGlt4YQ4VLBnuQZnns+m9cpM1j7Cs5qNjZnjh4w?=
 =?us-ascii?Q?VS2tFQH6x7L+yvpvQ/lh3OjdWRHjuYMLI8G9dBbheEE9ipVfMi5DbQ9E8wv5?=
 =?us-ascii?Q?AXn0nLR2MfynS07YZzZuRPhAZZve46eJQ15sL9QMY6mzAwe9fRDKdefpGURU?=
 =?us-ascii?Q?f8c2ygr/ORtAuwGMfjaaxGAIxQ1/ioFhp/4qVYFC2uiL20I1FGdz4juwwHTx?=
 =?us-ascii?Q?FBYBs/x11vH2NHZTyWHTFFjoMebOzsUq5kpVWLCtV4joYnNYrkmL0iO42zhX?=
 =?us-ascii?Q?6myzimhD4AjxAE+X2Ek2/NzNC3a+/3fHdeHClXuM22wVoRZ3dQ5VBPj3zBXI?=
 =?us-ascii?Q?ZLyptBSFAKWLnBeO1qUAVVBtujc+VjFGUuoZyQshHk5d9wu9WDsrzKHTv3u7?=
 =?us-ascii?Q?p9KclOl7B2a7wUjAAiolPvXEPWnjRBGrpwYJ0FfcMspUGz6gpzg6l+R8WPu/?=
 =?us-ascii?Q?wHFjkK47nIyjJRcMAK5qvWN7FGA4MgptZHTaIlY1ppSD+z4j/adO5R++5k1V?=
 =?us-ascii?Q?LYTsnRmfpmAWlweFbs6TPPZ+6EsWp1/OVMNUeTqypIeAWNabp2FiWq9rFoWS?=
 =?us-ascii?Q?Bh7CwHo/hU5SaJpzKsDSeFKUNaR0Rj26c6iauWs1NugsBhirTTfAiIZ497qR?=
 =?us-ascii?Q?r+c5MxIX6OhWz797I+Jquk8lDQ1daQTudlhbYkB4MfcWcZJxyAb9DPxuBQq5?=
 =?us-ascii?Q?M1SShK7GCKKbspx1bE0A2AzpSJ0W/G9oRCJN8R+/SlQcqwZVINHV7edOa/2k?=
 =?us-ascii?Q?tJt0IwyVmq1iiSszjMMTRpzAQF1iWD2kJEGWl1Rh9UWMbunvI2VVAjsn6GdR?=
 =?us-ascii?Q?oDWiIOXdOsBzDVn/DQspSbOxyx8iY0h5dzYqIPPlja1i+Ewubgu12eXoeAb0?=
 =?us-ascii?Q?4r54zkAiixIy3rMS4Xez7rEJ7cX4VM96NAHDTc0pmgcYPgxl1PunU9ItJXZr?=
 =?us-ascii?Q?SV3VYsrNvskY5I4Lfk+dHgn3ZwS0QARvHeo8vwZ0icwiMuGaYaOwucpqoZif?=
 =?us-ascii?Q?urmxUUtC8ciAEfkQaO4lHLHB/heeWvaUwmBjjvfVYscn3MW6NVS2NHzFKz7m?=
 =?us-ascii?Q?sjCvSvqmOY6Fj25qugQ2awww3FMaf3pwzNqWGeMGuTBxBC/baNJK0jEmH5Ys?=
 =?us-ascii?Q?rJXgBjuGq0iVj6GE3o5+1ULyIfWn3n+IQXODfUMThVW7Oge8uI7EBsRVKyTY?=
 =?us-ascii?Q?XdztOLkGZLAfLS4bTnCUclqpWPQkBw/mToIAfs3tegaDfwbAsJJE5eQYp79Q?=
 =?us-ascii?Q?5w3RagS+ZRLw92TRXeEAriSMM1AC6uJyGKGsNGHTUQfCXvC7J/GC1v0jz6jo?=
 =?us-ascii?Q?NaXwCv/U646Z/ijDjvy8YbKtAAXI5RJfTmynw3eO7cRrP92kEvPiRQxeAl9a?=
 =?us-ascii?Q?14WB9ZYBoRus2i6ikTjRBDsEFrPeNTrhXPJ/pQMRVOYvMDTklRJFUvTMIfQK?=
 =?us-ascii?Q?7GZCxIcrQApw0/DCWPPjQ3x0bRRgkHjHmcpwwe5jmaGeKK+q0rX3tnFHnzEk?=
 =?us-ascii?Q?4u+wvb+ax9Cr/KZwAjcHgsbnxhHam8ADvIdMDKpekFBFCFjHyG8Z+bNvcR1V?=
 =?us-ascii?Q?xrUBcEwfnCYk/1dVWO6rf2kjRWy3agKaA9SrXxbqsdk4L4mv0xaK2VbEfkcm?=
 =?us-ascii?Q?pbw9raeyUsbBdr+mlym6BduLdUmOiR/hCxej6EcIcXWLBhft5fjw?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b5a715e-2f08-4ab7-dbf9-08df3a668d4f
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 11:27:04.3263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: enHYFiZr6h8/fmZE3JaMoR//IxRxzruMti4Xqq6y1ymlDzS7pjS83pdsKBHaIa+mYQsVdLgun9RpzCzZFpfp8pYHdRroo7dOV+Lt5wOOpW0gmtBXbzCm4QDygCKkjDEk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1218

This series implements a generic interface to configure CIT based on
time (ns). Different platforms can improve MMC performance by
configuring their respective CIT. This series has been tested on the
JHB100 SoC.

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

Changes since v1:

Patch 1:
- Add a cit field to struct cqhci_host.
- cqhci_set_cmd_idle_time() caches cit in cq_host->cit.
- __cqhci_enable() applies the cached CIT value to CQHCI_SSC1
  (only when non-zero).

Patch 2:
- dwcmshc_cqhci_init() calls cqhci_set_cmd_idle_time() once at
  init time when cqhci_cit_ns is set.
- Replace the JHB100-specific pre_enable hook (dwcmshc_starfive_jhb100_pre_enable)
  and its private cqhci_host_ops with a new cqhci_cit_ns field in
  struct dwcmshc_pltfm_data.
- sets .cqhci_cit_ns = JHB100_CQHCI_CIT_NS.

v1: https://lore.kernel.org/all/20261014121222.31385-1-changhuang.liang@starfivetech.com/

Changhuang Liang (2):
  mmc: cqhci: Add support for setting command idle time in nanoseconds
  mmc: sdhci-of-dwcmshc: Set CQHCI command idle time for StarFive JHB100

 drivers/mmc/host/cqhci-core.c       | 64 +++++++++++++++++++++++++++++
 drivers/mmc/host/cqhci.h            |  8 ++++
 drivers/mmc/host/sdhci-of-dwcmshc.c | 12 ++++++
 3 files changed, 84 insertions(+)

--
2.25.1
