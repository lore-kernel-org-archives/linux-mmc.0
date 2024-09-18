Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2044.outbound.protection.outlook.com [40.107.117.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420653A1A8;
	Wed, 18 Sep 2024 08:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726647425; cv=fail; b=a/pTmEVYN/Ztb2qCAXBQomysG9Jk5lDYeUwgwz7e9Bc086M2njJe56mGg3z//CNOu5SkOxiZxL9oCo53wMSRWHiEHNeoaewBFwnpFsS2WQurC9tM8nGdXA8Mj81ri8rkIMACq8gXak/uTFmMaRfdr+4epOEuBw/UNy1fXRP6L14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726647425; c=relaxed/simple;
	bh=LSMnxIBfhncolc5HBw/Swx4nAqKi1R5Av9TzKtmiDxM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=mL+9q6A1UCMx9B2RSAsR9Bw6TlywuPk7LaRyqCKEJrtA+2aBhmFDVFVTyT892c3VMMni/f8csemH9wTATsFhR/SU+xbMBnQbmlFc3/GA2gL9zXdexBTSWyAJmE0IwGs34+QYAjul9UYdz6NQ2F+48T/Md4ouCl3QlULU5CobpGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=c1oSEq9E; arc=fail smtp.client-ip=40.107.117.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="c1oSEq9E"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IUEjPmuztHuCKrOhYxKbzcrD0JEqFJ29FMvbrL7tMAtq/76u0BsKt5FqiOr+ZORU7Hi3f9tTQZZ52776O5yJasAnZen7T0klglSwAreq//phrwBdHCadqJA0xHAo15uTVcnqXaOTHGQ7YVApzmjYl9P8+p1zrBf+8woM4upivXGz46hHM8hQsEH6C8Bbj96LRlusw7F2/xZF0Ev3Z1ihve4A8doP/ABZyyD/e3kynCqPvyZ7HPSxibBxbiChammRwjkLi17I/n/Jp8jChvy4unv+IRFFR9B1Am50ezaU2kpT1ooCr3acrXG3rVHgFaG5SXHpqQ1p8Gj6JJcRBlVX2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ppAoZsv9JDKB1nJQd3sPSiNEyaScoA5AtRh4ONbegC0=;
 b=E5/niE+lMQ9VziIyoPxcYea6ADBiNMmaq+YfqovluB79/J4BiVqS0w76bz+TiL9THFJVnpcC5plaDXM+rxOe6cgA708mIb+ZJRAYQwU5XRaocis8Km5n4Opkh6gnCmAXvfzqsEWYxnmCo1bIFNG0Kxox/fJAbYm1e0Zo4gEzJ2bC8A32rShov/vicqfaIc7qBLHmD60mkaxeysZlYt0j4U+yqer5bl27iw3nnrDf3gL//UZjTqechk+D9k7YuE9L4xT7GyhC/nlqsV2EvQqFUnSBM9gHoSo3i23K8YTmzMRFjXHbeO6sIcuq3tmu/0mxEfNn9U9UD3/cAnGtnaNn2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ppAoZsv9JDKB1nJQd3sPSiNEyaScoA5AtRh4ONbegC0=;
 b=c1oSEq9EuSAiytM3vdxQipQ4VjSofsrukWvZCpkzHbM5idgR1M/eyhiNChVjD8OuAx6utjG9ZouTfQeNL+onfB/IWvNwZZPQcCPnmS7nBnqXJGywNDzssFUoKXPr4uUUo17YclhtWbXZSxcF3EVDHgWmNyvHjIJSxmS1PUeRktdIWx6LQVSctJmIBT1SkNJogUun81+TKcyNqmNDu2yekIuA7ywwtP8pMCJKd5m2ZOV3stMRgS5razOkCwt1bEVxPb3jcM9zEHKBBn9XGAKfDisRCaivLX4RBhMwht4lJSKbneOxkHwFQVrVf/av3krYnF84Qo2UkjzYEYosV5uq/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB4461.apcprd06.prod.outlook.com (2603:1096:400:82::8)
 by TY0PR06MB5708.apcprd06.prod.outlook.com (2603:1096:400:270::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Wed, 18 Sep
 2024 08:16:56 +0000
Received: from TYZPR06MB4461.apcprd06.prod.outlook.com
 ([fe80::9c62:d1f5:ede3:1b70]) by TYZPR06MB4461.apcprd06.prod.outlook.com
 ([fe80::9c62:d1f5:ede3:1b70%6]) with mapi id 15.20.7962.022; Wed, 18 Sep 2024
 08:16:56 +0000
From: Yu Jiaoliang <yujiaoliang@vivo.com>
To: Maxim Levitsky <maximlevitsky@gmail.com>,
	Alex Dubov <oakad@yahoo.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Jens Axboe <axboe@kernel.dk>,
	John Garry <john.g.garry@oracle.com>,
	Ming Lei <ming.lei@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com
Subject: [PATCH v1] memstick: Fix typo in comment
Date: Wed, 18 Sep 2024 16:16:38 +0800
Message-Id: <20240918081640.1493847-1-yujiaoliang@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0019.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::15) To TYZPR06MB4461.apcprd06.prod.outlook.com
 (2603:1096:400:82::8)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB4461:EE_|TY0PR06MB5708:EE_
X-MS-Office365-Filtering-Correlation-Id: b572e9fb-8b00-4ff6-b1ef-08dcd7ba4270
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/Ov8GnJ1XHgZ7um/uaGRfxQPSMzbWwVeKdfMMxjuWH4fMnSwTf1aWMiRC28G?=
 =?us-ascii?Q?bBq2oJ0DTCLKWpSyYhkmqxDhsOZECFzJhMKOABtxDlMAXPaxX56nTVKgg6+6?=
 =?us-ascii?Q?3HT6WmLNg586rl+3OrZ6kyiz1pbqO8lBPffqnxp17D5JPmRi9VIo60CK5isr?=
 =?us-ascii?Q?yofa28SuVweZFyivuuLCabMz4IUGsUKst4QKxh0wYG0gtjUHaYPzXc4nzJXW?=
 =?us-ascii?Q?o9rjVhgLAoHicAbUNQ3vVLn3z/f79H3Mx6ASSJNj436iKggbQHBtmUXNCB/z?=
 =?us-ascii?Q?dhcd59kgfGcmRMAtnBqUcReNVx9ViohU2e9nGrohs1Ya6I/PlRW5Ve6QPoM7?=
 =?us-ascii?Q?W2RaivEXqovo+grpt2QwG8EtSV0LVJDB3+jk4Ot2x59q1KSpc8sd3dVO+a0x?=
 =?us-ascii?Q?luTt8HpBgDQlhOzkDQVBKBdRcoSFkcu44ahvq9ejDybi8ij/GI2UdgNJ+Hy1?=
 =?us-ascii?Q?XwgD3KCmXCvopHYu4+vYQ8sT5pac7yKkLnE9C96rBdKFewo1XXzy/DDK9BUP?=
 =?us-ascii?Q?vSWs6A3vKh+YE1R+qdoLRLRPqi8ewgXIBW3/MFJ8g+pQCL/4C7oaptK1hy5W?=
 =?us-ascii?Q?ntr2hpeWIIVBhUmTgByJi/c2LjebIrzXacfTbxAXBSJ84y/rlr/RWN50sBFi?=
 =?us-ascii?Q?8il8acBFqs54RXZcSo4Zws/kW5kMqQpCGVFnOs2foilfiQKjgsH89HUrC6nl?=
 =?us-ascii?Q?MxMz0xY/Pw/UbOdt/DbR+o4/DOrWHej6YI4m2xGqCMWyJN5xS6XTvPjSswZp?=
 =?us-ascii?Q?OHailxjppYDc1CAqhT7+D5rnkfsBuXXCCugI3C/s4kH1vzzzywOm2fsJnkdg?=
 =?us-ascii?Q?SC+wgnsPfBwWCpts3Cb/OSZSZWI2PYPIbXRrYy66vqRWiLTn2msAgpg21lKl?=
 =?us-ascii?Q?yw3fjbekBbQyKNxJu05ngqt8ey6BS9oIE000M0YSccXj/6dVZqw808ivGG2N?=
 =?us-ascii?Q?Uag83Jla9vvZtHI8heCa29HdeHBsVwrfCllOTxVDQOP421AkSM2XNi1HrhsH?=
 =?us-ascii?Q?kODcZOsxqJPq1HukSois8cq3I88yLWpuRpQiRs2jvGFJtiv15qBeEuSuzBUW?=
 =?us-ascii?Q?ZbBt02K/shwPlxi0NRJZ/qvSwlQg5uFM5BcfmgOmcOfOqWHNDu3R3Cj2Elsh?=
 =?us-ascii?Q?0TjQZithCLPu00CCll/VaAmWPal6P1vRf0U6rfBxTZRhPe79txH2Bma3zAzn?=
 =?us-ascii?Q?kIRHy9j6LYODs4+Efd/6ZKgGy+l6laxrv/qX5rsbZ9VQEC0WhxUb1aAu1Eh+?=
 =?us-ascii?Q?gBXl7lsnr4T1tPxOg1YQWiV02sNqvs4nTB6cxI+d7r5XeKl+ThfvNtBWSqKT?=
 =?us-ascii?Q?ie6/ZODpwWgyEvtPI7kVWyPBapt6LA48SZeMayIMeJ5MxFBkqqnMqpqF4SoN?=
 =?us-ascii?Q?+8zUHrrtsNX2BLppk6gPJyD1vvvnqd/aSWpz+i7cjFzJkOR0pw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4461.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7QUSqsk4MVbvehFWUgD5atBkxAKNSMYqFhUxIUiFy0Y0z9/7p67ehA0aNmGT?=
 =?us-ascii?Q?IyalWvH2taMAaXx8YXLYK3F6CNxbj/QdTLc3TS3vtklLDGmjNGdOU8pKIQBd?=
 =?us-ascii?Q?X/b8bGWM5s8s3AEwGzh4V57d/8gCDJvyTNCskKXr+u7gBkxfwVp2O8uhOFWm?=
 =?us-ascii?Q?uV3bqKqvR3FyHUweoagGc7GbfFvOrCtLozCtR4r0MloZ89iv6iqDPw8ydoVA?=
 =?us-ascii?Q?8H38+TntiSQlpMD1jWqHcb0w1LhPDw5/K8qxQC02UO+cYI36q8MmVrLjBi54?=
 =?us-ascii?Q?c8TcueZODazvCMrnYiNa18iiWJPCyZHcxp5UWRLGBADtgc6v+37lyELZKzsH?=
 =?us-ascii?Q?RFPEqLWYGwr3aOGZ31DTrad0HxWU9yGl5SOURB9FYajFRMcC+61Z43VEeMpr?=
 =?us-ascii?Q?UMZTW+6yXLXMAFPb5gjBMf0DGwtUISEdrs/oqqrxQrjx4e7SUEBIItPRh+po?=
 =?us-ascii?Q?zYo7uJWsRCV1Gwe5gyuO57C7JmEB2OqQuVjYTCTpftRx6ETyQzMdAUt87cQm?=
 =?us-ascii?Q?7PiaijhWrPVvCdtzLv1EZktpyyQYeWLSLh3jtMMag4QqNFO7mGmxKxLxVPih?=
 =?us-ascii?Q?ixtpmYpfSbZioWXbepYFhqW+lZopdtxKhHIsK3QEaF6HXh42uC9qHjBqzZ1w?=
 =?us-ascii?Q?/bgAd73grvUyNUwFO1jbHn7Wed7SUOb5hS6MwxLDbKBMIuJVF2FOjOg9vjHi?=
 =?us-ascii?Q?iCFTvs6l78dkExHKMMkQVdzbJ/pXo74SZajCCMkSG3yAv0bWoA0YfIaihr7q?=
 =?us-ascii?Q?BnzvpSy4YGYD6Mz8DJXpS3YbaXOS8rlgL3nM1wKcQ1emCr1BLSOo6zPGyzmQ?=
 =?us-ascii?Q?ZzYoIYjOUQBNN/2GNNXPoSbn9oAvbdaNphsfUXIVpagZHVNYfpAN+Etuks5Z?=
 =?us-ascii?Q?S2aiNqUAGau7k6n2F8nyfRPJUVGRIdvAdFDpOjaa0C4l+BGC70BtLkPQFvVi?=
 =?us-ascii?Q?w45YY4WyD6espPr0c9rcwY0JB3AJ0SZ7c7Ra5dyHb03yHRZLymhiWk1KUR5H?=
 =?us-ascii?Q?wdGyS1LsBHmM8Z1quMcZp2pTpIfliWiQFAg1JIuOxHuVh4chnhX1r85b2Xic?=
 =?us-ascii?Q?oXB4NDH9VsFbNAwcKbN2Pn0iaFsR34eg7KKNCKSf4U96saz1KYwQHkl4LWcs?=
 =?us-ascii?Q?65MTet0XrQjpkDhIDMjzUiCg8V1GhoIkZS735mTmCxnsRgJbh40PlXRar/yT?=
 =?us-ascii?Q?84KSyN84m16ulBKCNInM/GHc7X3MZ+5zZUAK6y8YcI7WQ8HVA+sLUazgqjWI?=
 =?us-ascii?Q?e/aW4Tk2s01f8xFp+PX4x0vYFlxaBEWYqpolB47HPU4TpSciMUabjmQSg+cn?=
 =?us-ascii?Q?DcYkJB0dsSF+Lek79jLv2KoCzZrsS88aMYjDvilwgBZbI/e13F/GiH5HRZNS?=
 =?us-ascii?Q?4HuMZGggRNkAukd8S7gJdh5yusrp5HscRt5wY7x07lNZaegSLwl8nRzmbX7d?=
 =?us-ascii?Q?WKwOyPL9zYuMPTQFEVEiI/HA6A4xbdjQ00Qm1bFUgKnREsOdANCpS2VnewVP?=
 =?us-ascii?Q?tO+thzOcKPZigdIBZ8M56M+hT7jaVjbrSqOuIuTgD3g8X6ypV8ipvNmlrp0f?=
 =?us-ascii?Q?alDK61C3eIec9/oKVFMn/AeYyWqpA7uW7LWe03UT?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b572e9fb-8b00-4ff6-b1ef-08dcd7ba4270
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4461.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2024 08:16:55.9964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5V0Oq8pjC8XwwMuvPPI78FmggnV/Drxe+1e6A/HTZi9EFfrBYIpczDzp8lw9LSDVMWf7twvzz39bB3DvEtNukg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5708

Fix typos:
exectly->exactly,
cylynders->cylinders,
intersting->interesting,
inteface->interface.

Signed-off-by: Yu Jiaoliang <yujiaoliang@vivo.com>
---
 drivers/memstick/core/ms_block.c | 6 +++---
 drivers/memstick/host/r592.c     | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/memstick/core/ms_block.c b/drivers/memstick/core/ms_block.c
index 47a314a4eb6f..c0383959dbb2 100644
--- a/drivers/memstick/core/ms_block.c
+++ b/drivers/memstick/core/ms_block.c
@@ -996,7 +996,7 @@ static int msb_verify_block(struct msb_data *msb, u16 pba,
 	return 0;
 }
 
-/* Writes exectly one block + oob */
+/* Writes exactly one block + oob */
 static int msb_write_block(struct msb_data *msb,
 			u16 pba, u32 lba, struct scatterlist *sg, int offset)
 {
@@ -1684,7 +1684,7 @@ static int msb_cache_read(struct msb_data *msb, int lba,
  */
 
 static const struct chs_entry chs_table[] = {
-/*        size sectors cylynders  heads */
+/*        size sectors cylinders heads */
 	{ 4,    16,    247,       2  },
 	{ 8,    16,    495,       2  },
 	{ 16,   16,    495,       4  },
@@ -1729,7 +1729,7 @@ static int msb_init_card(struct memstick_dev *card)
 
 	boot_block = &msb->boot_page[0];
 
-	/* Save intersting attributes from boot page */
+	/* Save interesting attributes from boot page */
 	msb->block_count = boot_block->attr.number_of_blocks;
 	msb->page_size = boot_block->attr.page_size;
 
diff --git a/drivers/memstick/host/r592.c b/drivers/memstick/host/r592.c
index 461f5ffd02bc..544a31ff46e5 100644
--- a/drivers/memstick/host/r592.c
+++ b/drivers/memstick/host/r592.c
@@ -675,7 +675,7 @@ static irqreturn_t r592_irq(int irq, void *data)
 	return ret;
 }
 
-/* External inteface: set settings */
+/* External interface: set settings */
 static int r592_set_param(struct memstick_host *host,
 			enum memstick_param param, int value)
 {
-- 
2.34.1

