Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013006.outbound.protection.outlook.com [40.107.162.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58C13ED5A5;
	Fri,  6 Mar 2026 16:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772813765; cv=fail; b=eY3nAt2iVf5BsAyK+J6HY7NoTt4hGd4iYEUEtpTJOySxgrSw8exVe5absjhjMXwMWV479iLUYoBxM9ADpzOLGSHHUP/gbH/rDZDhnCGb6IIg0so9EXhgz8mCpvjVw9LdgzrDyszDgwWIoJy3j7X/mDCvgEsB7F0NmXO9tVM+wus=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772813765; c=relaxed/simple;
	bh=IG4Q2BS8R5pzXZEmuwOuXzur4HMLvSJcePtNrmqTHkA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XBh673cRjEydDd2+EGu2TN+khAWunfmBB3K/3Pd3Dwp8G2wlr1eC/Ed5KVUkt2cijey6mCVfaWuHCNXUVj9Vq4YyOLJ7V+Gli8arXsQyZ1605pKxTnuTsQpS15LMNRdwaztaNHD8G1lkGAW6jPVEJFGdveEH61YetG41MV6AeHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=sDzWd62g; arc=fail smtp.client-ip=40.107.162.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="sDzWd62g"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D1ubc09gwy5fDipuXmHemjYfUfVqcxNv81Dq2FBMH9jpU6tJDg6T3VXOeDUq4r+hL2HNpv3BP/scU5iAitcDxZgZ9UAleHLFoTPEDYINOqB/klveoaNQ9pXTY9pIo4RPl6qTa+4ozzl1i4o9oVeenQpWVuYGlIzTj2Le1MnT6K7wzkr0jyuQ2I6uAWCD/7IFb8SCmvaqf/bB3BgJnW/mviJomrAX+PWBnnMoUDhPveAZcZ0GbKv1XRboVxNjhZCNsrFdVrS6UoGLfUm6Ht968ra3FiG4f9UnK7+IRt7cuHx0LnDASGpJ+7mrOUnj4Ikx9s5xXpmKtmOWf/DNuH4nRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KTpL4oxtGqAc7MbYn4ap6a/tXkYV8vduPpyHFcU4nmQ=;
 b=n5MRAC3xS1VTqd2C+PJlIu+nu7ZRCBv8e1iQtiLJCv3XYdwECGk8WxDvgRYe0nVomEmAVukpZ/coPTTI4j3srIH4zX4rVNStG3qnpPXYZGZfTOoOJY0aVAQSinz0HZQ4uBFK85L05h0fAKoxVwhfumRaHTvULVTWQg3Nc2pZ9Iqc06SF+uP4RlKZAoaSPHjThQ02udDppyfz4DRWirRpRE0MLkZOwFyxT/nc0sTa9Y7tlD9w2344KBgU239t10vA29ej24jOEDZz/eAkOrAlOvjX91vP6mSOzv7t5u7+eVbXn8v6w9Edg9xY/pwM9j46jc3yEH0j/ai/yfbti7z8yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KTpL4oxtGqAc7MbYn4ap6a/tXkYV8vduPpyHFcU4nmQ=;
 b=sDzWd62g/sjH9OUcZn88buFblEwv+nrY/3DmOyKmFvdTM2ig6x/TsI6X4vaJZ1f2c353i1qx1Bt8v9o2hjxnno88VhLWtvBtIzPilau8Q74NYAGgLKgZArB0fTT03rTvyf30wHPjWyEEXBHRtMQIg7YUfQjJ7H0dbzRB+eVuVpbSf2LbdQ0h3gGhxkFroY+HXYWAeKiqp/CayVVm6H5pNRBQXbNhCzpfVC+sPm3nAJF3jbh96GMt+VsnvmpyUuATlF7o52yTIzYv9ZMcp5nN2FDFfIZk8jPmiJHXgM2IE+rBW92l59Of9dBU9R7PtdWdboF734yjKyxP0Ubqtt3YVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by PAXPR04MB8606.eurprd04.prod.outlook.com (2603:10a6:102:219::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.19; Fri, 6 Mar
 2026 16:16:00 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0%5]) with mapi id 15.20.9654.022; Fri, 6 Mar 2026
 16:16:00 +0000
From: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Haibo Chen <haibo.chen@nxp.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Lucas Stach <l.stach@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	s32@nxp.com,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>,
	Eric Chanudet <echanude@redhat.com>,
	Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>,
	Larisa Grigore <larisa.grigore@nxp.com>
Subject: [PATCH v4 1/8] dt-bindings: interrupt-controller: fsl,irqsteer: add S32N79 support
Date: Fri,  6 Mar 2026 17:15:48 +0100
Message-ID: <20260306161555.9000-2-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306161555.9000-1-ciprianmarian.costea@oss.nxp.com>
References: <20260306161555.9000-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR02CA0149.eurprd02.prod.outlook.com
 (2603:10a6:20b:28d::16) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|PAXPR04MB8606:EE_
X-MS-Office365-Filtering-Correlation-Id: a7212baa-67d2-4291-8069-08de7b9ba7ec
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|19092799006|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	afRdw9TfphNqXQtLaC4PPwbFkLEdWKEZq+4xl+mxgGN+214udAlDzb64CHkEVK5E22RPz9S/PIxWfTMk7ahTDSp+orCoLlw1AglSF8PvKYim/89GOjFgbj/Yf3QYHTBdLIowYuJ31zzNWD7kWAidu3sOf/EQCgBMwuRORAu0ayW1Moypz/ujabBW44y8MmofKlCpDHMFTS3tODaCLbsPOD5Uh6GU9aLEfur8Ug5n4cJLLq04m3oN+MeTMYHcBUqUNA4exD764s20uHxFPjeKysLoGHzSMQZuVMUtJIFbU+AYJ1kWaqTWFVJ4+xmr4UjdGRAOgdmHxpJ97QpQ9TTt0O1dQ+ZMIFPrvq2GVD+vorv1tJgR6Y3CdzDarXdGv4NVbluWCp+UGNo8C8yamhepmhsKbzX0lm/T9+CIktfheX3JHI7l3EUeXs0P6klINJIXcUmH+4D2qTDDNuYxn9i3JUqwER9vvD5M+dtiJ3gLMmWu+gM8slgL8LqwYpbndqY/y0rnyWIATqNcxILYGHvycJvXYPSko4wj+7j4MzAGbgOsqTy20hqz3GXLmqvqwYTkmVHXw/AxQbc/W3ZYEoqycX71jtKvAHuTYnrcelWblmUjUmnWreM7QRRAOvXOBCATE5jgqoiL3dTsI7n8dvkIpNxYZ4JacKxE72MBDB2eDq9sCU2gWJG679hhtT1xWr3etWzZSxfy+roUsOqTKmR7YmQVd4tyopx4p+TQRqw2tVxLomTeHbBD1R8owM+O3sGjZW3T6HHJh4VQBsv+1Wu5Jw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(19092799006)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c0VSVU5KQTBvbk9EWndDNHpreHBRY0kvUFhRVXpwenJmbWJNQm96YnZBNnNa?=
 =?utf-8?B?VGhpMXdGMFFUUnNXSVNVNEZDclpwcTNPYkF1ZXZZcU04aGlSZnNuZ2Y3UVVp?=
 =?utf-8?B?TDZ2RE1DUWY5NDltdmVGQU50VGJLc283aHBiVGt5ZW9ZbnR1d25hdm5lSDBW?=
 =?utf-8?B?a0M3ZU5rbEhGZjB3bDlFRXVUbkZZK2k3dGpDUnFkMFRtL1dMTTB1eStqTndO?=
 =?utf-8?B?Z0dDd1V1YXpRZlZxSUY4NzRrL0FobC9CMjFULzJOWENScWx5RmtUNWFzQ1Zs?=
 =?utf-8?B?TjVlZE9jNWVuSG9NL0RZU0ZTOVVvZEIwdnFVUXBVYjNHWDdJTmhaV0ZCNHpT?=
 =?utf-8?B?aG4rVnk1ODdNMlcyRmljV0YyNktJQ1hXRGEyL3F6eFNRb2RKbCsrN3FEYWpG?=
 =?utf-8?B?Y0RDRFZtbzFUSEhKUCs4d1hOQ3J6OXV2clk4VTNPSmsxVFBHTXJNM3R5SGJK?=
 =?utf-8?B?NXhNYW1nRXlSZXdUYmQwanVSOXk2YXhxVkRUY2RGaHNQdG84d3gvWms1YVBH?=
 =?utf-8?B?bnBBNlZWOFU5cjlZeVJUbGE4NkFVeHJrcE54RnREMFUvQ0djbkVuaXE2WFRM?=
 =?utf-8?B?cEEwVlNOWHFsdndNdFJMQTAxYkRQOWZoQ2MxQTdpTWRvN2tRMER3VmFYYThj?=
 =?utf-8?B?Sk5pWjkvdUp3dTlNUVBlZ1FVY3FrZXBPMUhqd3ZOWUswN3UyRHE2TVlQcTZO?=
 =?utf-8?B?YVhjZ090cUJRZkZnS3NSMVR0OHpWNC9Ib0NLN0JYRlpsNllXdTBNb0ZUeHgx?=
 =?utf-8?B?cEhlYVFHUXI4QzJlM3dLTlRUSDlUMmEydDNLUzMyWTVvcTZQaDM4ZUx0RlJy?=
 =?utf-8?B?Z0FVaThUMStpSko0d1lFckxoWEZSNXJWR3pWdU1kZjFyaEFQK2RKL3N6QlRy?=
 =?utf-8?B?M3lxYm5LTWptWnF1VkV0TjIyalBrQkwxVzBCWFQvcU5za1FSNGpITnZuMmVv?=
 =?utf-8?B?KzZjRmNveWdtTXkvOWpMTndCaU5XdmRaZE5HZ2VqUDlwbmhwNnV6SnMrVFAr?=
 =?utf-8?B?Yk1hSkZNYzNUaGtabnRKaHdhSlRSM29pUUVVOTVWUzNqbll1MmFJUUZTOHRp?=
 =?utf-8?B?WlhlQmJtTzhLdDA2SXJ5bmhudHJHMmZFdVBqMnJDQzg1cEJrN0RTeEF0Q2Y5?=
 =?utf-8?B?WmlMSVJlOTBrVkZEYUM5VmtYYThwYlZqdk9kZnJPSndVTnpmWUxBUlJsRzBD?=
 =?utf-8?B?Q0hMMkhYYUJHZW1CNlM0a2VRM25iaTE2MTBMT1ZLWHJ4cEFpYTZsL2JGQ2lo?=
 =?utf-8?B?dVQ2M2Z0U1g0WW1oRFFkV1RiUFFQdVJKcjdseW96ZjY0dUJHbGtWYzNkYXlW?=
 =?utf-8?B?RHZhN1RmVm1hcmMyUjdLTDZiSUFPeHdXT1ZBekI3TW1EOEdNRVVIc3pUOEFz?=
 =?utf-8?B?aXkvRlhIN2tWVmtjajlLMjh1b25OZFRrc1Buc2NkQkhycFRZbStCOG9DVWN1?=
 =?utf-8?B?TGxTVGxOY3JWUUVHbDE3T3E4WUNyQSszSDNkL294SmtmTTNhTkQ4bmpSSmIx?=
 =?utf-8?B?VWgvL0JHMFc2WFhpZ05vakVWbjlRR2JJOENlR0ZxdjM5Z0g4cnFZb0F2NVdy?=
 =?utf-8?B?WENvOWhFenViOUlyR3ZCQ21ua0ZyWkxWcjkrSXdXd2NaRnZEOGxCMURDZy9G?=
 =?utf-8?B?ZlYzQjU1eXZlb1JveGN3NnRMZUZCSm5RQnVwNEt3RDFhZ1dQN2s0Nm9PUFhQ?=
 =?utf-8?B?d0xvRzlDZnNqeEh1RGl2cVNZV05uUVEvOVVTR0UwS1piRmFWc3ZCNGVvaXJl?=
 =?utf-8?B?MmsxUnJHb2pCcW8rNjBZbzY2VWVvZDFxVG5UTmZWTDFzdHdiMHI1WUlwWjZR?=
 =?utf-8?B?VzlsTFJkYllxNTNXZGxmcHdQT01uQWdjUE16U2ExOUZJYm4zT0NaKzkrWktH?=
 =?utf-8?B?RjVaSEkyNUcyNm9lMlNhU1ZxVXNIRWRGaVplRm1WcXpUWnZnVGxGc1lxSUVk?=
 =?utf-8?B?VnViYnZWeWlzYWdLT3pxYy9qbG1uMTdtS3BoMGZEd1l5YUpjT09rTWdIbWJ6?=
 =?utf-8?B?WldsanFWcUVFbjZjWGo2d1JTNFFzQ2VHbTQrZ1hRVW9ueFZMRVBRZC9ScWl6?=
 =?utf-8?B?Nks2a1hVdUpTdittUURtVFR4bXV4cXhmV2N5NjVCaXV0YmVkQkdyWFNtZmVX?=
 =?utf-8?B?WU5zQ2dvWTE2UmdFR0NxN0FZSElBam43T1hNSUpncS9aQURSdXFNRmZUTEVJ?=
 =?utf-8?B?ZG1XeGxKTzN4M0tsbENQVStEbU1jUTFCTVExN21nY2tjdk8wNkRHU29nUVBq?=
 =?utf-8?B?cituOXpEdnY3azM1ZDN3ZkdVelBZaEljSy9ERFhhamxUeUNrVkxHNExuOTRn?=
 =?utf-8?B?Zmd1THRqS0VEK1d5ZU4rMDRSekdnVGhtR2I5Rm9pRG43NDcvNzZLQzVMMDFV?=
 =?utf-8?Q?2zy2qMAunvj0JE9Y=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7212baa-67d2-4291-8069-08de7b9ba7ec
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 16:16:00.2519
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1xr9qiFnz2fO6o7H/bRuCXmJp8H8DX46Ex6hGYc6yuVjYAk223dOo8hKySo03ZawkBf8jTLkLAJs0BJm5D0FMLp7rUuHS8+sjui1g1xPMms=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8606

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

Add compatible string for the interrupt steering controller used in NXP
S32N79 SoC.

The S32N79 SoC differs from the i.MX version by not implementing the
CHANCTRL register, but otherwise maintains the same programming model and
register layout.

Co-developed-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
---
 .../bindings/interrupt-controller/fsl,irqsteer.yaml           | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml b/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml
index 5c768c1e159c..13cd37bf48e4 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml
@@ -12,7 +12,9 @@ maintainers:
 properties:
   compatible:
     oneOf:
-      - const: fsl,imx-irqsteer
+      - enum:
+          - fsl,imx-irqsteer
+          - nxp,s32n79-irqsteer
       - items:
           - enum:
               - fsl,imx8m-irqsteer
-- 
2.43.0

