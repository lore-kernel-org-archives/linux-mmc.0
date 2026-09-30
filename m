Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2125.outbound.protection.partner.outlook.cn [139.219.146.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A7A481FA5;
	Wed, 30 Sep 2026 10:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790764404; cv=fail; b=pyspYqvbXvRoAXk/8akcDOv4BbvMX5AYbrrMQYne3Od89iJF4WB390u+5OkPgp6AQgWH9EkKx5OTpq3/O8tedYrlstTBOK8VDQFMvv+VEJbbBZsyavEEwSb1AijvvqhlJad6QZzD+Yk9UKY1GkT4upGNwo0wGp/97GiOg5sOCl8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790764404; c=relaxed/simple;
	bh=M+xA3zjRAnOvZc/CtbidubSX+vw5NS4WupVR9dkN8+s=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=jxrTCWgNPUrIqzfaeaqnPxGY2r6u/BtZsqnUMNDX+rTbsIen66DDELN2+szcalZwSWiRV1elI4XM9s18t93YqSbE6gXaJz3yuXDhy17tSC5GVgzy8YFs1sArWZvxC49CWRwfvaKfXNZ4NJmBDeG4F94vKVs+lpQWJ0u/Wd+agB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gcxs2e3ikU9lwt4TwGIcsQ4uBkJfGApYu60s9Ck+oGJOGyMMt1z5V92b6qTQPwOoTh5hSWzCSDOiUmSn0c4z6CbH6HnQ6hut/WYtRAkZ/Hc1Xtwhda9kUR74K8eusq/0PJySgB4W76pih0MwdmF1ZzALJbPTv5Lpvw6kxBKf7tTosbzZevFgzUb3sSnhQVbEbGkjM5x1LyOozgqif7Vi/+uSB1HVlujK+t7dH6bmwtdCe6IcB54Gb1W9mmjk70T13XJkSsIGj33LsidI2DVatnwKMl0u72oQw0FzHlzR/i8ZQgW+k6nZr1R/eTGbxa4aoE4AGffamDnjYeNE+nLhNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZJ7PPSz6uO8tg4EgHKKCoVxsaW6fEuF/o++Ae8Hi7gU=;
 b=l1pOahKogPbs/4PHGYqC/zVdmQLq5MBseyqO2NoujiWlVdyGPBfXnWIt+SLfTXxF0YquNTPTMCi3htcE9HUzJs7QfN6lbBge0U0ws0T76zJ/i9qhITOwizx+LoX7ND/Bs0skBT5j6n/splvlb/fGkPR0xmx+VEsCK02ZW73PUx//kPDKPnX6gRUJxcLV8TnwVEXiNJB+x8KYgv7CgeyeOKEekWRQlIfc+Bzyw5pT9j7d4x6Gj39pbBzENtJlcZmvITxaeaYUoOHmQcWLentXY+rs87YEKOgS8piBUhLinJ9K2CECOGZX9o2uPwrRcQO/iQvAH6V0f9+KDS8vXXkCjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1265.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:16::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Wed, 30 Sep
 2026 10:33:09 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%4])
 with mapi id 15.21.0451.026; Wed, 30 Sep 2026 10:33:09 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ulf Hansson <ulfh@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Chen Wang <chen.wang@linux.dev>,
	Jisheng Zhang <jszhang@kernel.org>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	sophgo@lists.linux.dev,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Changhuang Liang <changhuang.liang@starfivetech.com>
Subject: [PATCH v2 0/2] Add StarFive JHB100 DWCMSHC controller support
Date: Wed, 30 Sep 2026 03:32:56 -0700
Message-Id: <20260930103258.13375-1-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHXPR01CA0020.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1b::29) To ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ4PR01MB1202:EE_|ZQ4PR01MB1265:EE_
X-MS-Office365-Filtering-Correlation-Id: c3c6ec40-9b61-4e1b-165d-08df1ede3892
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|52116014|7416014|1800799024|376014|366016|10067099003|56012099006|3023799007|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	DOFts02G2TqfEBvX6NOd1JvuzmxWrc4H5BSFZHE47z0p95flwE4Loy6F9y5z25j4W5wLa6DWnEMbLo/WKJPe+lz7Wcdvjw/Vxyce9Qu0qwtS6Hdg0iMs+NB5eDNrbtE5YgVpFxXYdyzJ4G/dvWCPm7wfewom/pjPa3C1QQGcmHU4AMSznbqJFzr8RpyTRRhEotlIXj1r3KJSkPvDdhobVAWu6s1P02nW6zeeA6l7oEPqs66flWFOZSD/R8T4UwHXoSeJG3TXXTIaZrlmtUcES5SGJpXsmTSfuQD9AalCqXhCYUacXuKEk8iexAEsdr1WFmbssZ0J76SfD18MzJ8YoqKgka1qNXig9NKvfIxxEKzRAMQx+jU5AV8xnCloxSwaVpqDCo7t+h5AmZHmywjHtMP5KkOkF/Td/M41S/LqxPtPK4SOpXKjXfEHyPc27wWbwh1eZO5cHmvacZXdr49QzPElxTJj5vfRqqZt7fCwAMOt1xA8P1j4fUiq3de90K6tXRObRucvj/F31Mdkz51s9WNM0kTz8w2oT1gj8b2/TD0R61RSv8hfFzPIJ+aVFEjI
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(52116014)(7416014)(1800799024)(376014)(366016)(10067099003)(56012099006)(3023799007)(18002099003)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?g9e5UT31Ltd6j/i1b+0VfVFpEYSZtb2dAGg/Hx+C1nXWyhzYk5r49H1TLK5B?=
 =?us-ascii?Q?zEyduKL+E2r/LyjoeMAuqf4oGL5GMn5dIzwdZT63R9/HYFjXyznGxl0cMAW3?=
 =?us-ascii?Q?2QRO3k5BiXSxIORmoS5k9oSOv+sNKEKMMbqXStOUOMeSS7WWAvtvv3ncPGEN?=
 =?us-ascii?Q?11JYKoxOwRMvDi64Y/MJrkmfa8iecZbnIgLEmZVejpfkJ4sgvW64lweDRNYU?=
 =?us-ascii?Q?YW8SRhgs1+dJ7Ln6FbnK3Fis5cLO+yEFPMU1Mv8a8gYYIRUCZ7VED73mJb7L?=
 =?us-ascii?Q?/Nlg+ebCc5kHdi1suRQm99mfzkI2dQGp/VEjqsWU3MX1i7BWuy65/PgVv8bz?=
 =?us-ascii?Q?d4QD3D0vyXqRMSBFlR2sR8YBLcKLt3Lcbwjgen7eL2ufhEgZ+OWVezXMyBbc?=
 =?us-ascii?Q?ecN+ExBBG02ERzE5q2ACRv97PlWNMZkil2LVPtXAM3MSgItqfh+3u2zj4bnm?=
 =?us-ascii?Q?WgeGJXNav5LcNb/V0XZOZaSy0zSTZviAv2VzvUxFnczd5SRtYXdh6xtVyHa9?=
 =?us-ascii?Q?lAOPIpPV9bV9bbICY07eNl7RJzwUKo+9rsQkFHdISF4Ougifj6nGMKq31TWa?=
 =?us-ascii?Q?rHVRJzNbtMTdLpUBjT8OoPIq2KjB7CW3Kp5dw8GamTI0V5yG1XPfwfA/2Jgl?=
 =?us-ascii?Q?Yj+NjsvTiL25G3FEug1e4x+osEeDMyIbtmIEKBMIFXsUGmaQtYLS1J5s6Pnv?=
 =?us-ascii?Q?EoX+0uoqNt+b2UBgEI/RJOwVg6X5NUp3G0UoU4pccw/OytK0tdzu8faVG/cU?=
 =?us-ascii?Q?YKv6d9B8m1ELTNMX6q2RF5RmxZKAORRDx4oC7uyMWuMIw1XPbO1m9a1U7dCy?=
 =?us-ascii?Q?X1SLOmezobxlsp5nJsM14eIpztjTp9p0ywQkt2kmynF0HUwEjFQdTBiL5+0b?=
 =?us-ascii?Q?xaRQ+yJ5/avfJPcP8Jz+b0lG9lF85ej7URTs5T///dnMt42GtU1MYmmENkz3?=
 =?us-ascii?Q?a2PiHt1ILlFEpNEM0uQFfyvZP5UrvWSXr2FmQfR0M7ei5Ed6QdvIqOWy6QLz?=
 =?us-ascii?Q?Ay10IVoFIJLAvGdGB+3c/+0n9MKjyHXDdUXd8btn99MQt5KnKj43a31gbgCM?=
 =?us-ascii?Q?G7EdS9amjhMy5EO7mPRokVPF071kSs/BhH2Hd5mdgjGiuYHZySNMF/BTkdQI?=
 =?us-ascii?Q?5Deu22sbYPBMwdx4z6E9QbNRd/eX+nW4Hs/TQWs8fhM9YYMHkEb0l97A+vrO?=
 =?us-ascii?Q?w3bvjQz1TFowoc+V+COHlKWO52UVZwYgpsOADWQZQ9sWetfHgpDn1oc+Nh3d?=
 =?us-ascii?Q?to7mrargEM4c10GnQDALU0Pgi8OndXPkYJlnww12LLGKHFHQPwbffwnNIo55?=
 =?us-ascii?Q?3ujiuPmvnGlRc7/Pkgjr1EKHPU+ZoCRev11I52aO6MsEDqs6vZpl99Io8p+Q?=
 =?us-ascii?Q?6VsGv+ZCMAGhvLnT8VA/GBqxlPS/DWMnjPkGftOE92Fmy4sO0D4oJ/19nZSd?=
 =?us-ascii?Q?Int1oVsnYhzcZQDBZUI9ULOCWXI9uZ2obyDg4lRFynCBv0/XHK06C9zOTI8/?=
 =?us-ascii?Q?ktVT02/i2XFkAFTanyHJLdgCi2Dd7DYuIEs+tdcfIcEoIvk6rJIooMC/Foar?=
 =?us-ascii?Q?l/p3DOWKMSOEJl9NlM3tq3sEqkkJ2FrpqnPeSOorYkpQ4k39a5mjnCxH7mKF?=
 =?us-ascii?Q?eEoUPWPm7XBSBS4Jr8cdNzaphIGR2b/X7sUL+ZCJXtqDlgMeuw8GlQW8dZd5?=
 =?us-ascii?Q?DRRA+JX28w3oK8O4lsxAldhr1tTbGKY1O79WJh0RoBZ3PVPcf5BS+qKVeXt0?=
 =?us-ascii?Q?jFrH4W3cUZUP4Dcvphq62cMR8zFfSFncw0mcrjXtxyvDRHmVF3tN?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3c6ec40-9b61-4e1b-165d-08df1ede3892
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 10:33:09.1353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QcJNCXNnbhmkoeFYwXOh7Wu+Wq8+i8hKCwqyYZEsjpH/tiTARFT7sZwQ101s0Q1vhoHUIvJQtFqVWG6DnI9GNIIjii2K3APRnZBkL9f1cf6zoKPapkYIcvC4LxQ3BGcj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1265

Add DWCMSHC controller driver for StarFive JHB100 SoC.
This series has been tested on the JHB100 EVB1 board.

Due to syscon limitations, it is necessary to use dma-ranges
to restrict the DMA address space of the eMMC controller to:
[0x400000000 - 0x4ffffffff]

bus_nioc_4g: bus_nioc_4g {
	compatible = "simple-bus";
	#address-cells = <2>;
	#size-cells = <2>;
	dma-noncoherent;
	ranges;
	dma-ranges = <0x4 0x00000000 0x0 0x40000000 0x1 0x0>,
		     <0x4 0x00000000 0x4 0x00000000 0x1 0x0>;

	emmc0: mmc@11b00000 {
		compatible = "starfive,jhb100-dwcmshc";
		reg = <0x0 0x11b00000 0x0 0x10000>;
	};
};

Changes since v1:

patch 1:
- Add Krzysztof's Reviewed-by tag

patch 2:
- Fix the DMA address range error in the commit message
- Clarify the 36-bit DMA capability and its constraints
- Add a named macro for the JHB100 delay line value
- Use dwcmshc_reset instead of sdhci_reset
- Detect 1.8V capability from mmc->caps/caps2 instead of DT properties
- In sdhci_jhb100_set_clock(), keep cclk_tx gated when clock is 0.

v1: https://lore.kernel.org/all/20260919092950.178617-1-changhuang.liang@starfivetech.com/

Changhuang Liang (2):
  dt-bindings: mmc: snps,dwcmshc-sdhci: Add starfive,jhb100-dwcmshc
  mmc: sdhci-of-dwcmshc: Add support for StarFive JHB100

 .../bindings/mmc/snps,dwcmshc-sdhci.yaml      |  74 +++++++-
 drivers/mmc/host/sdhci-of-dwcmshc.c           | 169 ++++++++++++++++++
 2 files changed, 239 insertions(+), 4 deletions(-)

--
2.25.1
