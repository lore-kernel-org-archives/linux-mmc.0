Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2065.outbound.protection.outlook.com [40.107.249.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBD94C8E;
	Tue, 26 Nov 2024 01:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732583461; cv=fail; b=Wn2KdSP1srf789is+Bg1FlN45Drk0pbeSYladYIUeAL8vY5vWbPOijAMe/Q+F9ToA0arcPAjOnPgfb08F+znbPu3md4dvsCbdGSUBE/KIT/dpZr/d/HFOjBThplE4CaNPcJbJM5u2qDmIWA/6Fj1HQhheoouxI2x4GGMOi4Mvbk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732583461; c=relaxed/simple;
	bh=B1FJI/XsQeen5W7G7adNK8H65JSb4Fc6aqI2PAW2jrE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pgXsL9CvKuV5K4XweMpFn0WpEG4hQy9ucg1yQtaac2hffpL5BJpbSEXHGtrHBqLWKERpTR6cVdbkdrql1hyCtDTfWBkhfmICGH08aDPteKnMjWbjLy4V2oQsGNKcGDk+8uqirOcfcCU3mXU/SFetqaA7YZAk43HxkOYZMqGtVto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jRYTmfYb; arc=fail smtp.client-ip=40.107.249.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jRYTmfYb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nCCgUI9LUfpPh7qjgYz6zyLFepHiSA0EdDj/oOoVOYKsf89yNSDZWbLMKbC+CDn4V43tsXppcDcWzO40TSmJxXtXQUAqBmhHFYa3devJLdLTFyetMgH2muV3McNHjXl2LKc8XD3DAqIY9DRwmiAx1G8D92q+woimMlz4tUJeIxeQc3h6gGRbXAAXR8GeZPBdmwq5UAo6ZHDQ30rGmztySDz7kPE8Y0kA2jnRjBW8ac5RvVXG4vLRcRTlbFm3zGF4fnXcoryPe4Gv08mFEW/gvR4pF6VDUA6+YLvNYzfynB/m+LHxIzRFNYZEyD7beKfyiuc+WVoskutePJWyXAfPLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B1FJI/XsQeen5W7G7adNK8H65JSb4Fc6aqI2PAW2jrE=;
 b=mQGOjyw8bwb4thbzIDKx3k4O9I5Peg1EU6o77Szp6p8oOCsvAaVCNRJRrAYLqbFZRHL9SyikuIuhmBNJtiQDQIqS+XbviNfUv86qrYoVswL15zAcxw0m3yUXbgweoXWhPfg4hcQNt0VAgmBwQZ/94OxZv9yNzibbSdEqL+O/olzvI7oqkYWOv8V9G9g7PB89utm5shfZoqyakOHI6SrMIvY0aA6STxzA0c1+Oxo7CHQymtMrKQY/I3R+P+TnVOy57PJGXrrBQwMZNqkmBuFzBVhJ9Al5RF9uPMwlIpGl2QsRm9iFWj5YEssDhBXJcrmDxSWBDiQnmcEkhiWioZTi+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B1FJI/XsQeen5W7G7adNK8H65JSb4Fc6aqI2PAW2jrE=;
 b=jRYTmfYbN30Xk9WLskUu5OFDpHinvP6b+DBCJlSwlx5gcBSR5i577NO4YqS7Hutj5lPmlPjhRRZ6iLaLQgZEX+ZJ+/OrSwAgUjX9uIFmTKJrvputn2lJkLN+QxtFo02R73lZjDbWhPyVmh6Cx7MAfUTOr41voYJ7Yfy85OJXfOltMyXuCUvj6CVf55ZZhmIJN7HGzkRgdPlg1tzJZe/VNPmSMzagIi+/y55f/rhOE+euq2iWZ5/199HU3JpgiLIm7vLU9JQlozhb+gR3sDmZ130DuAnmgJQjvHNmX0KMml3BkPWXoPMn1XaucvjdEbR/dFl5Xnor4oCtpdTYe2pEHw==
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by DB9PR04MB9379.eurprd04.prod.outlook.com (2603:10a6:10:369::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.19; Tue, 26 Nov
 2024 01:10:55 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334%5]) with mapi id 15.20.8182.018; Tue, 26 Nov 2024
 01:10:55 +0000
From: Bough Chen <haibo.chen@nxp.com>
To: "Ciprian Marian Costea (OSS)" <ciprianmarian.costea@oss.nxp.com>, Adrian
 Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Shawn
 Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Fabio
 Estevam <festevam@gmail.com>
CC: Pengutronix Kernel Team <kernel@pengutronix.de>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>, dl-S32 <S32@nxp.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Christophe Lizzi <clizzi@redhat.com>, Alberto
 Ruiz <aruizrui@redhat.com>, Enric Balletbo <eballetb@redhat.com>
Subject: RE: [PATCH] mmc: sdhci-esdhc-imx: enable 'SDHCI_QUIRK_NO_LED' quirk
 for S32G
Thread-Topic: [PATCH] mmc: sdhci-esdhc-imx: enable 'SDHCI_QUIRK_NO_LED' quirk
 for S32G
Thread-Index: AQHbPxTIGAu8DmA1d0Cv2njrIZ28TLLIwblQ
Date: Tue, 26 Nov 2024 01:10:55 +0000
Message-ID:
 <DU0PR04MB94966AC4E3387D87444E68D0902F2@DU0PR04MB9496.eurprd04.prod.outlook.com>
References: <20241125083357.1041949-1-ciprianmarian.costea@oss.nxp.com>
In-Reply-To: <20241125083357.1041949-1-ciprianmarian.costea@oss.nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9496:EE_|DB9PR04MB9379:EE_
x-ms-office365-filtering-correlation-id: 16dd2404-9c82-4152-3746-08dd0db72d92
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZkF2K2pUb0xTVDFQV0xqaVp0U2ZCVEJpbjJhdkI3STdrUUZZS2IyY3ZYS0p5?=
 =?utf-8?B?dGhqS3BsWG1pSDJ5enJjbUdOdHAwM1J4WHcvM3lxeklsVFJwTTRnaTlObjdF?=
 =?utf-8?B?MklEcmM0WVVjdTlFeCs5MGJmanNNU3psVWR5SGIrNU52Z1NSVXorcUx6MHkr?=
 =?utf-8?B?eDR5RUtCaHVtVWJjUXFEalJpQmZHVWdHYjNIeGtWUU1nMjhVT2xMRU5wTTBS?=
 =?utf-8?B?RjAyK2t0RW9wVVgvMVZPOGUyNFFJTlZPUlpHN2RpaWNzMlBseDFOUjZzdFJN?=
 =?utf-8?B?UlNhZXkyazl6QytkaFRtNmFvazlHcEd4VEEwYTRlK3ZWUmFmeHM5N0pGUjgw?=
 =?utf-8?B?VTlpV29idDBvVzZNa0ZKRm5MUXhPTEl1ZktDc3E2TlFSYk9uY0RFbEZiYmdy?=
 =?utf-8?B?OUZwRzNtRXpwbjhJOUdXZGZDOXRvQzJNYnYxcXRDaFNsNUZxR2d3eE9EQjFm?=
 =?utf-8?B?UGpFUnZwaWgzWmV1S2J1QjZteENxSWxoYlc0OEZmM3VSK20rVEpWUU5Bdmw2?=
 =?utf-8?B?K0EweXlqODBTWHRFRklVQmQ1RUx3cUNSWk4reGxYSG00QjAzVHFtOTJUc0oy?=
 =?utf-8?B?UXkyTkNERWk2YXFySEE1MURBK3hmU2xYbnlzcGh3YldNYzIyenFmeXh2dDJO?=
 =?utf-8?B?b0NHK08wTlYySnpyNk9XQXZQS0NmUDQrQjRQK0tENjdCZ1F6OHZnT0xtR3VB?=
 =?utf-8?B?SC9aWE9aOFlSSlF5ZXZSN0loQmhOaGl5Vm9ucUgwblAvUlRiUVZXR3FwSVFQ?=
 =?utf-8?B?cXJLd3hBSGpqd09DUmFUYjYyaUdtaVVwbGg3V3dWNHN0bDlLcmhqTjhwZ1o2?=
 =?utf-8?B?QThXakh2bFNDZXJ5OGRvOFU1T2NYMEpVWTZMMGFaZEFEMHB4VlpqTkFOWmFT?=
 =?utf-8?B?VzdVMHBPaVlKNVhZd2tXNEZpMFc2S296L3lOK0loTEh2SUdSZG1Gc0VvZG5n?=
 =?utf-8?B?OWV1SGZDUG5KNGFRVDBoZzIxaWtrWThRZHpENmF4Tm9qcjQ5bTJ4d0lodzky?=
 =?utf-8?B?NDZoMkdjbHpGZUVjWld6M3IyT3hGZ0dsVUxyUXdCV2N3TEo5QUV0NlhsUVdM?=
 =?utf-8?B?c0x5dFZ4amlWc3RBOFo5OGNzT0FoRG1mV1NWckE0bEYyc295MnZqVVhBN29m?=
 =?utf-8?B?Z2c5U2RlemJreENNZjlSeTVNVGFsWDNyUFJRZ2MyUWxDbnpQZklmL2FiNXhD?=
 =?utf-8?B?bkFQb2NNeUZCWkJYMWtlM0p6M1BjK3c0RUhwd1F2cUVWWTA2QUxGMnFGUWti?=
 =?utf-8?B?UmlUSGE2VXZhWFhQWENZaE5Td0U4N2xDZ0hibnZHYVJPRHlCK3Y1NThyZXRT?=
 =?utf-8?B?ZlVxSzZVL1hHa2k1TktFY1gvZE9UV0pDSXZ4K2Rpa3pGTVNNSzVLZmRmYjll?=
 =?utf-8?B?ZllKRDIrOFNva3AzTS94RmY0ODcrZXNDMXp5WXhyUllGbEV4VFBWWVhrdUtJ?=
 =?utf-8?B?bEhMRm9EKzFDRHBDZXhvZWRUV01ZaWRFaXRPQit2dlM5N25FR2RxanY3MXJ5?=
 =?utf-8?B?bmpqdjQwb0MvZ1A1Y0V0eXl6bXRIRVh3MjlKcXlBS3Z4YXVnVDkwSXM3dmFm?=
 =?utf-8?B?SGx2T29wQk5icjNJRkkwWUYzTlJ4RURYdDE4WmNoTE5DYTBlVEMvZE9QY0k4?=
 =?utf-8?B?SkJiNW5OMDdhbnp0LzhlV0NVdUR2QTJOdkFSUGJkT0E5b2l5SHVJZmN4eFZD?=
 =?utf-8?B?TmdsRWlEYS94T044eU1kdUM0dTNPRnlPTGhabXFXbUdjZmY0dHdTbGwrbGU4?=
 =?utf-8?B?YVFDSk1ncWF2S2NMMjcrVHY1Q2FobU16ckdJVVhrL1lwSHovb3JFdVhUVGoy?=
 =?utf-8?B?R2dzVDZocC9DZjQreGhhdTZ5K1VqLy8vOGtKSERFbUhBY2N6Tm9oVGdpM2do?=
 =?utf-8?B?Yjl2UTZaenV4WVQvYjNLL2xjaElrUHVWWHk1QVphUUYzekE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dXB3dk9hQ3QrYStDZXdMZ29pY2wyWDNuQ0RoVU9OM3hIMFZ5NGNVWThKbU5E?=
 =?utf-8?B?aCtjRkVqL2l2dzEwb2hQR2F2UFN4N2U4Sklhd0N2TDBnTXI0WXVSUG9reHhE?=
 =?utf-8?B?T3JTU3AwRkZTcGplcXVFS0RsT1NQMXBVUTNMK3JHa1lrY3JMOXA2cEx5dm5L?=
 =?utf-8?B?dGFNbllTeGNUTktzNEdRbmlEenNHVFIxYkNlcUpuVm1TSjJUTTJ0VlJCOXZm?=
 =?utf-8?B?R2lxaHU0c25ReTVldDE0ZlM4elNBaGtJbEdpbEZsSnBXMG02Wko4bzNaQlFr?=
 =?utf-8?B?c1ZxUmdVaEhRQTRHK0tMK0pYMkhaM3lqQkpDK1JOSVBPUDVPQ2pkMnJDOC9J?=
 =?utf-8?B?SVROVWVUWk5QNUw0aThMZlJINlMxUVRxNWlsZXR3YVdTcXk1d0RDY3JDNHBl?=
 =?utf-8?B?ZWZVY2UxRUFVaW1CQkZxZlduNzZSMHhNVVJjaXBYKzRzN2svVkFXYU8vc2Uy?=
 =?utf-8?B?QnBZcjZmWThVQmJCb3FYdW5tMkMwOEFCTVNKWDlxNFc4aVJTd0JuaEJpRm5U?=
 =?utf-8?B?WXYveGJqRHVHY2xleGxTV1ZTTWdhZG5WQ083NURSTGdIQWVkQlgxTHZ3UDM4?=
 =?utf-8?B?T2N5VUI1L29VTnRFay9rdDlmUmRMTHBjNktZVFN3K1loQ1dpcXRINTB4Wmlq?=
 =?utf-8?B?dzkyK3VPaEtjT251UmpVclpYOHM0QmRBMDgrU1FlMnJkUjlNaXN0R1hZMDNm?=
 =?utf-8?B?TWg4ejlBWmxDVDBQR01iZFBwUW9GaGg3bWNZcS9zamN4NTYzcFZBdTgrSXEz?=
 =?utf-8?B?aG1CMFJxWjR4SVNVSnY3VEhRWHNndVpHTXVLNWMweThRM25BbUlpQU5NTzUz?=
 =?utf-8?B?OWkvYkJWTjB6ODhiMDJ6a0Z2WmFHZm5XVjZycFVNeFpmOVBqcy9ldUEycHpa?=
 =?utf-8?B?YlBwTEI5NExvMzZIMWJNVVFlL2VSa09SR1V0dmF0T2lsWFlXVVBaSUZUd2g1?=
 =?utf-8?B?RXR0NTlndkw2aHlCYWRMa2dGdDkrMGpNUHdDRGMreDZjOElJaUJ0UTcyZXNL?=
 =?utf-8?B?OWRYVTMyaUhOemVaM3lUcG5rSCtiL2YweE1URitleDJZZnd6SzBnYXBpNlhi?=
 =?utf-8?B?aHVZdXc4M1dSQVVRS2tOYTg2ODlQY3N2K0UzY2x4RlJzcjZ2YUlQeE5YSVc3?=
 =?utf-8?B?TjVFc1h6WUE0WnIvNU8rNEtIZktQNzlVTC85emhLdDVCeWIzZktNbG5PUFQ5?=
 =?utf-8?B?d2gxRk51VXlzS1AvMUkydFhvdERJRVBMRmxTYm91OEJXekVpQlVrNHRBVU14?=
 =?utf-8?B?Uzc2K0l2Y0ovUkNPM0w0ZWpaWjVMUzBOVkh3Q3dlbjBkQkpYdmFPRENtVFlq?=
 =?utf-8?B?MVFOa0dDRlpwRm03ZWxCbWFoNUVVTk40eVhOSzl4TmRYdXRsRnJTR3N4bzhZ?=
 =?utf-8?B?d2d3OWFRUjdkbzJVZ0hCTHlSMktOS0lXRTVSTzhoRlhwTWF0aW5kR0pmRzJQ?=
 =?utf-8?B?TnZvd240bnhsWmgrNGRUT3JjMU9VVWl0V29qU3ZrS1RpZ2duS212VE1ybVV5?=
 =?utf-8?B?OVBzVW1OQ3R0UmVVY2tLRlY0YmZ3MUNlSTBMQXhOSjgrT1NzcWova1VmaE9l?=
 =?utf-8?B?R21kSS9oL0NIZUorNkdOWUZDdXZZMzlMajRia3l0NDAzN2RqL2QwMStXTytx?=
 =?utf-8?B?MVcvRXA1dUtQQWF2bU5jWUZ0Yk1VTElqWlVKUDVhVUVwMHpNVC93clJrZXU0?=
 =?utf-8?B?dk0wdWtlYnprVnp5V2tycVUxenFZcXpLczBoZUpaNjZlVDNFMk1IR0wxZVM4?=
 =?utf-8?B?aVJsWUlUZG91VlZGakNSeWxPRGZnNUdyOW9vdzZQOThHT05LS2dXR2RXQmNh?=
 =?utf-8?B?ZzhFSklnOUNGb2Y0c2cxSkpOcXZKa05HSGVMMnNzbDlIRlFGcStMR0JLcWdu?=
 =?utf-8?B?U09zTTk2T1AvUDhGd2xIMjVBS1k3UndnMEc5QlRDSTFBdnlqZ2pRb3NORXlj?=
 =?utf-8?B?MVJ2dkM3WXVidll4MW1NZ1RUMmVkKzIxbkdXSVhLVXhlZ1dOWmowTFZXWHNS?=
 =?utf-8?B?cGtpaGVST3kvSTAvYWkwbFFBbEN4WmhyUE01TnVvOWRKNzdpMFd4NmdkT0ZV?=
 =?utf-8?B?STBta3V6SEw5d1cyME9xQmNQQnNDQkFHZHQ5SWY1Q3p2NDlka0MwT011NG9l?=
 =?utf-8?Q?9yQs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16dd2404-9c82-4152-3746-08dd0db72d92
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2024 01:10:55.0772
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F8dCPWOQ6mFdzEObXaYlbJJTxjcLp79L4X+xi3D6kkeNqshY16UDs3v8KwCLYvRhSpNFveL4hJqvX658/njR7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9379

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDaXByaWFuIE1hcmlhbiBDb3N0
ZWEgKE9TUykgPGNpcHJpYW5tYXJpYW4uY29zdGVhQG9zcy5ueHAuY29tPg0KPiBTZW50OiAyMDI0
5bm0MTHmnIgyNeaXpSAxNjozNA0KPiBUbzogQm91Z2ggQ2hlbiA8aGFpYm8uY2hlbkBueHAuY29t
PjsgQWRyaWFuIEh1bnRlcg0KPiA8YWRyaWFuLmh1bnRlckBpbnRlbC5jb20+OyBVbGYgSGFuc3Nv
biA8dWxmLmhhbnNzb25AbGluYXJvLm9yZz47IFNoYXduIEd1bw0KPiA8c2hhd25ndW9Aa2VybmVs
Lm9yZz47IFNhc2NoYSBIYXVlciA8cy5oYXVlckBwZW5ndXRyb25peC5kZT47IEZhYmlvDQo+IEVz
dGV2YW0gPGZlc3RldmFtQGdtYWlsLmNvbT4NCj4gQ2M6IFBlbmd1dHJvbml4IEtlcm5lbCBUZWFt
IDxrZXJuZWxAcGVuZ3V0cm9uaXguZGU+OyBpbXhAbGlzdHMubGludXguZGV2Ow0KPiBsaW51eC1t
bWNAdmdlci5rZXJuZWwub3JnOyBkbC1TMzIgPFMzMkBueHAuY29tPjsNCj4gbGludXgtYXJtLWtl
cm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBD
aHJpc3RvcGhlDQo+IExpenppIDxjbGl6emlAcmVkaGF0LmNvbT47IEFsYmVydG8gUnVpeiA8YXJ1
aXpydWlAcmVkaGF0LmNvbT47IEVucmljIEJhbGxldGJvDQo+IDxlYmFsbGV0YkByZWRoYXQuY29t
PjsgQ2lwcmlhbiBNYXJpYW4gQ29zdGVhIChPU1MpDQo+IDxjaXByaWFubWFyaWFuLmNvc3RlYUBv
c3MubnhwLmNvbT4NCj4gU3ViamVjdDogW1BBVENIXSBtbWM6IHNkaGNpLWVzZGhjLWlteDogZW5h
YmxlICdTREhDSV9RVUlSS19OT19MRUQnIHF1aXJrDQo+IGZvciBTMzJHDQo+IA0KPiBGcm9tOiBD
aXByaWFuIE1hcmlhbiBDb3N0ZWEgPGNpcHJpYW5tYXJpYW4uY29zdGVhQG9zcy5ueHAuY29tPg0K
PiANCj4gRW5hYmxlICdTREhDSV9RVUlSS19OT19MRUQnIHF1aXJrIGZvciBTMzJHMi9TMzJHMyBT
b0NzLg0KPiBTMzJHIFNESENJIGNvbnRyb2xsZXIgZG9lcyBub3QgaGF2ZSBhIExFRCBzaWduYWwg
bGluZS4NCg0KUmV2aWV3ZWQtYnk6IEhhaWJvIENoZW4gPGhhaWJvLmNoZW5AbnhwLmNvbT4NCg0K
UmVnYXJkcw0KSGFpYm8gQ2hlbg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQ2lwcmlhbiBNYXJpYW4g
Q29zdGVhIDxjaXByaWFubWFyaWFuLmNvc3RlYUBvc3MubnhwLmNvbT4NCj4gLS0tDQo+ICBkcml2
ZXJzL21tYy9ob3N0L3NkaGNpLWVzZGhjLWlteC5jIHwgMSArDQo+ICAxIGZpbGUgY2hhbmdlZCwg
MSBpbnNlcnRpb24oKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9ob3N0L3NkaGNp
LWVzZGhjLWlteC5jDQo+IGIvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1lc2RoYy1pbXguYw0KPiBp
bmRleCBkNTVkMDQ1ZWYyMzYuLmUyMzE3N2VhOWQ5MSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9t
bWMvaG9zdC9zZGhjaS1lc2RoYy1pbXguYw0KPiArKysgYi9kcml2ZXJzL21tYy9ob3N0L3NkaGNp
LWVzZGhjLWlteC5jDQo+IEBAIC0zMDQsNiArMzA0LDcgQEAgc3RhdGljIHN0cnVjdCBlc2RoY19z
b2NfZGF0YSB1c2RoY19zMzJnMl9kYXRhID0gew0KPiAgCQkJfCBFU0RIQ19GTEFHX0hBVkVfQ0FQ
MSB8IEVTREhDX0ZMQUdfSFMyMDANCj4gIAkJCXwgRVNESENfRkxBR19IUzQwMCB8IEVTREhDX0ZM
QUdfSFM0MDBfRVMNCj4gIAkJCXwgRVNESENfRkxBR19TS0lQX0VSUjAwNDUzNiB8DQo+IEVTREhD
X0ZMQUdfU0tJUF9DRF9XQUtFLA0KPiArCS5xdWlya3MgPSBTREhDSV9RVUlSS19OT19MRUQsDQo+
ICB9Ow0KPiANCj4gIHN0YXRpYyBzdHJ1Y3QgZXNkaGNfc29jX2RhdGEgdXNkaGNfaW14N3VscF9k
YXRhID0gew0KPiAtLQ0KPiAyLjQ1LjINCg0K
