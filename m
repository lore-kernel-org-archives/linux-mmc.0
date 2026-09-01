Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012000.outbound.protection.outlook.com [52.101.43.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C737349F138;
	Tue,  1 Sep 2026 18:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788288551; cv=fail; b=Jr+imrBOxah6x440CLottGJy0yH6BGUljN1sOYnUheZUP1ounumS/RQOx6bi4MOck5smO0Hol75rEq3NQTIvBITlBWFsEZBgkJf/c2v994JiVub5z4J3URKv7lw5hv9nutF+vcjfxWX3ekrnssemNXIvDo7X/+ktVeERF9DAE/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788288551; c=relaxed/simple;
	bh=9pHxvLM3BFkJl3GPZQMaKhbCBkrZ7LYP1KNjFOJokA4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MnWBFLAw9OVqyOtl7p9ka7/bQ9UO45PQcRJQVRO41bUo8dAIWwcXTmqnYyvirk2UkYA63zqYvHnKp309flnBpg4EDKakanyRLmNbidPxAd8CdQQzsZJtlHGNI1zsYgmDXo62BD+9slmuaRpUHTXdQs/SmonClsEiv2NBPiBJ6pg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=MxqiLD5u; arc=fail smtp.client-ip=52.101.43.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="MxqiLD5u"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TYwDLoSDCG3GRCyK2tHG4T3bWOhuIgtfXiA0QhILYxnSdlKQ5v2JZGU2e9imL7Jruhv+bcskJ8LfVuQH5bzpShIL8N1ldcJDT7af8a6MtmP99JsuB+fCBDS6W6lGeOguaDy/lZ+utGOdiSH97HxjkaEufz1TG8a6E9VqDnNxyJ7GuvNJSrSwo82U4FCHvKCpkr68PPZ9ghJyJTMTCfZtXT3smEBcFzaPX2xxwu0+UWXKdqDTR6UhRk2Jg6YPixswwLH3+247xmutIWdm5wCxkAnEMYsuGbUgPt2AWd1YW/mpBmruNnOCByOaCTUvgcE1MnAA0B7O6yEU6CNlrSwBjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tVa2duc952khOnYj3SxAJ9K2qUnDs8nqPn0b/lFGKt8=;
 b=ECoKps7EDnHHal5LxFat+JpUJCiC+RuBLFdWsspkWlBQ3TkLSCqj/OS5AMwMoWkKzsD96IlT8kE60r2QLgDqcce02bFDbUI0QEbTO+EQVqPS84j25pqnfkq3JNEZhuvQ2Cobo6kmXlX2ncBjn6XFDG5dI1UqEktinyRBrfW6VxnisbDEHz+Y4fKecApt0vsU1b0ZYqeKUtkTJv2n1haz7jfDbl7Mp6BY4LXj3ubyPzxWJQAztoUjJCrlEmWPaKp2TccCJB85/4AjFWhcU9VG4dQS8tZK7CPVetrmgf8UkTcJ7GNBDGctc+B7h8n6h3y9pT9cHQ3kdoEetSV/IWPZjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tVa2duc952khOnYj3SxAJ9K2qUnDs8nqPn0b/lFGKt8=;
 b=MxqiLD5uXC3bX+m3pM7LuZa1WCgAkiIHywX+SBUSzisDxohmljFiBAe8I4rEEAPTJZ3RSdEHaeGIPsqBJ5vtGhLiVh+0/lHg3680kCDmuRleajJ/vY5I0jazbcECBu53Wfl9p0o5GwGgI1CBmuAoukoUe+LckHKPrMsOTrBkHILfvZaIxuqpgWibhqw8iSe5mJvSeTnwcMHAu4CGwlWfZth8A3uF9w4jHEO2LQdPZQpDFT7wm7vmPp71bqBfoXMQoVdMIBrjBQDCfm28zEeYnhmLmZpsxYyQ4t4iixvWOdF0A0zQRnvZIKmdq75oCix8FbwT2owVqnyr/sG8VgPxeA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by PH7PR03MB7338.namprd03.prod.outlook.com (2603:10b6:510:2f7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 18:49:04 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 18:49:04 +0000
From: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
To: linux-mmc@vger.kernel.org
Cc: ulfh@kernel.org,
	adrian.hunter@intel.com,
	krzk+dt@kernel.org,
	robh@kernel.org,
	conor+dt@kernel.org,
	dinguyen@kernel.org,
	p.zabel@pengutronix.de,
	devicetree@vger.kernel.org,
	Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 3/9] arm64: dts: agilex5: enable SD card on SOCDK OOBE card
Date: Tue,  1 Sep 2026 11:48:12 -0700
Message-Id: <20260901184828.15653-4-tanmay.kathpalia@altera.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20260901184828.15653-1-tanmay.kathpalia@altera.com>
References: <20260901184828.15653-1-tanmay.kathpalia@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0005.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::10) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|PH7PR03MB7338:EE_
X-MS-Office365-Filtering-Correlation-Id: a88b16fa-bc0c-49b1-b92e-08df0859b1df
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|23010399003|366016|56012099006|10067099003|11063799006|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	3tgPi72IlgwEVvRU+SM8ot4Ei7sN+vJXwoTaR+Iv30G/BPyDLVRbhmpdy6XUiAB2xGUyZGF7uqjtRZQtTDIJvWZHXTHP/z2Kt9gYSFk9iULb75sXTSkRYJovb3bJtmd+yjmql9cx2mQ+YlpYsy5yVsefvRyYiC4L3lrOdghwJ2+LWnQNzTe8j6qERu2Kqoeb3RQVgJ4TzrCvff28hmgxfUM76BUoPIM4SPySDl0xxt2UPtZU74Vc4Kdyh+HoihlyNK/uzHJTBdsr7GkXbDzNCa257VdBu+z5BQua2XD4nQ0y56Zq3kr0WRo9t35yAXsKnirp/mbuF6V/LylVJ31x4lR5yFf4mRHQL6fvBP+l26XGWqr3WeiKrCZfF05MP85DcrR6gFPLoJX8wE0pE3ZmcfoSz3RXYuYJhiFfX8+RxI8Bquw8ZW2nVvJoYz97Bdu8wic9dFgH2CdRVwhDA5ZFyTK69sXk7YpXjq4fsy10e00NaqRZ248IeWepitrkDjP//kDwTGMkeQKysVMWIaXmW4cdNG1JcC06Y2ifWaoRGVT2GWlI+iFzUGOvvBwmGog2W0cmm7+T35s6B2uk4KIpVcvFzlRx6lVU3jyyBp5Uduy5LC284M9CkG8Dd0F2dsOF/2mrB1UfulcdWgFDqbgdWfR4bWVFkVqVtlyHrQM6sb4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR03MB6208.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(366016)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aNWfKPRM0D0Q9wWx2QKjdjRY656Q1+52QiJOGDe5TWF4frdsgpCdkjL/+Qr8?=
 =?us-ascii?Q?nYYlEfENWtDxIPG8GEuEoWnC3JizoeHIqp0dpKHcUBVDgFfowu81KqdUxCcf?=
 =?us-ascii?Q?3LDt3U/v9I2g1Z+8ySWbO/619sszQk/mZXyNOHI3m/fE0yxesaUqVSDkb8AZ?=
 =?us-ascii?Q?ukvbiTxkq6JosIebBgzdImEkOIZTImz+D0Mwp+XbXTopzr4iKQcWE7udcx9Q?=
 =?us-ascii?Q?SnuieOPGxiqTIo3Pquf2v/w564eScde76Fj/CUPS8GIX5nZOrpKJq8hBlZyA?=
 =?us-ascii?Q?NF8ZMEjpCXfYGFERPR54IBtS0xJBgJwNBYEDHMFFOCd+N9J7cU2FSUGjpLx+?=
 =?us-ascii?Q?MZDqJNBbhB8uQi8wBj9thu3qm6eXDaZIxb4R/DqyVNoOUabc2el2H8+6sLzU?=
 =?us-ascii?Q?b2Y5jMTNZk/S8xwMH9r68WLbgXYUnvry6HKsHtcpYMxGpMwFXDGIcQ0NjO7N?=
 =?us-ascii?Q?+KstAaCIJHK0QXPuKkoSYBr5cKgy6YeEA4IzxBfJ6BNE2/YYri84iDkTabN2?=
 =?us-ascii?Q?9yWE6L0aRHjk09mF92Ds14PTBaPEuMCzWbviXZqfPw1xjEPFxZUBU+4gxs2g?=
 =?us-ascii?Q?oc6EqMtWJi/Jh/ls8FW2qrx3tnMTtHQJgdYbrM+TD/pznVq5ah1ibmM2UBac?=
 =?us-ascii?Q?rm2STsob74Rx8czUyLmTzp1cqBkNT9MSy49YNZbbzlY5MgHrm1rEbK0TZkA+?=
 =?us-ascii?Q?sRapBTVEKrutg2KfNm1E9dQ9POlPRxZ+/XCDC/biYe2durzL+CgNvvPzytHx?=
 =?us-ascii?Q?6NVbMKRVzfVcVb+8wLiQ+v2BXQRzalf0MBMfOtQzbTvvrHCDbfOUslDKYKJP?=
 =?us-ascii?Q?cqyCcEYgQQI6YBxVFnCZpCiG3LBcnJ+epn6urtI3x6VneNvpw9pfmMXybpLb?=
 =?us-ascii?Q?fGXe7aq4MXLa0qHqud0wqK2UtlcdPe/QYS+3YbSNQGAwo7xeT4VB9FEvqHb+?=
 =?us-ascii?Q?snmYFMpmEzpRaCqEAXSWGTxXAQ50XUShL/vUl9r1nZOdiN2DM/UospI6tbUg?=
 =?us-ascii?Q?uaVx53+Z2JPZs49a4zRtEpMO3JMYPC6Du//xL36g0DEx4JlR7fusFzsOvrMK?=
 =?us-ascii?Q?Ga7bnhcdtN7k5Bx7uDJ6HrZdWnApcCkAkbonHztZ14r9tdNfsTo8O1X5FTPU?=
 =?us-ascii?Q?6PsURvzpNQYgXijF2/6O0JtQXw43mjwoIER0uDOtnNUwk+qtzJ0lQ6f20eev?=
 =?us-ascii?Q?JB6uSwEJF23/haYH+LAzC3G7C2aEoDPnT7SPBYxfwLZZn9TBkBm3F9AH83Da?=
 =?us-ascii?Q?OQh3+LNz9cP1Sh7CYUXethtnJvrdgNlgMx3u97usbcRRHg7wjqPp+9OKx4Fo?=
 =?us-ascii?Q?Qy25IrQLmLE7ozkfmAYYe6Aa75graRErT8Q3sqWXl2r970J7otcLaRMjE6iN?=
 =?us-ascii?Q?NbF76qWHvniDRXdqzQXzXg2/hjhqe89T92W4+QxqPTpVnE/33qkTFESi5kXs?=
 =?us-ascii?Q?iGt+vlzlwbrZ+ut+4Lg2bn8QhvzvwkSwtKUKmQxx5XfzWqPPu68tdRez98bw?=
 =?us-ascii?Q?QHEGx+SXGD9Q4TeQRQ++YZA7EsvKhN4VCBV25qJPEEblb3LOAjwo5PhKkaK/?=
 =?us-ascii?Q?ULSSgfNKkVt6iXMd/v2fdFN513+eKjoKsd4jrB/AH8LQQjouOimdvF/tfOeP?=
 =?us-ascii?Q?IbH78SJQFSHjwgZbtFXPs+mC5yc9skJqyjTS4kXidI0GbjP8sVf9W3sBH4FF?=
 =?us-ascii?Q?NDjpsu1+TQIaMGvPkD/t4/+Ql3EuP0uYfi6K0OOPOyD8lpuOUken/n2vlkfH?=
 =?us-ascii?Q?Sw4R70Dx6U7RgriJm+krAgXejHp8U+I=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a88b16fa-bc0c-49b1-b92e-08df0859b1df
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 18:49:04.0337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GOlXtzIHE2QS747QFgFmT8esYIb76OY7zPYt5wjwSUmxeNz36BlwZ/zgzm6qP6yVlXReO62G+6IYUzA43wMrsiBEMMq9QorHaJKjTk+Kd3U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR03MB7338

On the SOCDK OOBE card the slot is SD-only: a fixed 3.3 V card supply
and a GPIO-selected 3.3 V / 1.8 V I/O supply for UHS-I signalling up
to SDR104.

Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
---
Depends on commit ab45ecfab540 ("dt-bindings: reset: altr: add
COMBOPHY_RESET for Agilex5"), which is already in mainline via the
reset tree. It is not yet in mmc/next; apply or merge that commit when
building/testing this patch on top of mmc/next.

Depends on commit 10cf797f3f8a ("arm64: dts: socfpga: agilex5: Enable
the SMMU"), which is already in the SoC DT tree. It is not yet in
mmc/next; apply or merge that commit when building/testing this patch
on top of mmc/next, otherwise the SMMU remains disabled.

 .../boot/dts/intel/socfpga_agilex5_socdk.dts  | 34 ++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk.dts b/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk.dts
index 57d3c5807c65..2b753d0e17bb 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk.dts
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk.dts
@@ -36,9 +36,37 @@ memory@80000000 {
 		/* We expect the bootloader to fill in the reg */
 		reg = <0x0 0x80000000 0x0 0x0>;
 	};
+
+	vqmmc_io_reg: regulator-1p8v {
+		compatible = "regulator-gpio";
+		gpios = <&portb 3 GPIO_ACTIVE_HIGH>;
+		gpios-states = <0>;
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <1800000>;
+		regulator-name = "vqmmc-io";
+		states = <1800000 0x1>,
+			 <3300000 0x0>;
+	};
+
+	vmmc_reg: regulator-fixed-3p3v {
+		compatible = "regulator-fixed";
+		regulator-always-on;
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "vcc-sd";
+	};
 };
 
-&gpio0 {
+&sdmmc {
+	bus-width = <4>;
+	cap-sd-highspeed;
+	disable-wp;
+	max-frequency = <200000000>;
+	no-mmc;
+	sd-uhs-sdr104;
+	vmmc-supply = <&vmmc_reg>;
+	vqmmc-supply = <&vqmmc_io_reg>;
+
 	status = "okay";
 };
 
@@ -59,6 +87,10 @@ emac2_phy0: ethernet-phy@0 {
 	};
 };
 
+&gpio0 {
+	status = "okay";
+};
+
 &gpio1 {
 	status = "okay";
 };
-- 
2.43.7

