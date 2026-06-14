Received: from esa.hc6817-7.iphmx.com (esa.hc6817-7.iphmx.com [216.71.154.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B4F1DA62E
	for <linux-mmc@vger.kernel.org>; Sun, 14 Jun 2026 05:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781414987; cv=fail; b=LjAsqfrF3vgWhSboXhnXtwUs6hEFna+w6yq8730tkIU6ogb8KNTsfxq3k+nAOd/zmrbk9qki1A6VTgaj0jU4DkxRyqfjJ/CtoZ5hy2ggroiry8W3bp3MX2+BWuNv86sHffkJr7MsAgOOz8k8T2GxQKq7nosJFPBr3blL+rHualQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781414987; c=relaxed/simple;
	bh=5x8jG9OFDjNGlBiBOcCvN/968c/qbQB73wF4zkpD63U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kTENKSfLwe28shDZce/lKViUKQ86coqKA4WZ6Owkh5UblFchTaa2hpcgDwrya0vtcP8RNU9GQNJndxDINnvnE2gtitBioI8Ut9hfRO1Q5GJry2hgSYY9lGpFBq6rGfjRX4flOUckQy73FiKtGffgD9vlz7ytKpm+J+FvskIuUT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=tBjrQ9Pn; arc=fail smtp.client-ip=216.71.154.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="tBjrQ9Pn"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkimnew.sandisk.com; t=1781414986; x=1812950986;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5x8jG9OFDjNGlBiBOcCvN/968c/qbQB73wF4zkpD63U=;
  b=tBjrQ9Pn+qaCcQMwKMaITzTZeWVnB2ttep+NP72L7sW1TFmjM+WkfBhI
   BF6SoErdq5Ly818gfkd+8mI9UIqi3EmEOGTpDYT07u80TiDEm25QGQRKA
   USJnznhmikV15IR8RDROAJdNgTM7WRS7sm6rQgxOJaxOcw9t12TBmc+Q3
   yb7vLZ+KnDFbKMPGDX+Gb+Zn1aHs+8SExYunOLdVg4C4pPM4a4pDSZeUA
   QDkTgVQg1xn2YDcg5FJjqKDIEkfJ3yXykQMS+1AkxbswZLH78wSE+5qnv
   qG5zrfIU0h9Nu+dVaoF8WZ2e9cyuk0N+mljLdSZCWpQxstEXtvynjKBzd
   A==;
X-CSE-ConnectionGUID: ziw+lI1rRBmH/hpWQOuZzA==
X-CSE-MsgGUID: SNFz4DXATySyKlI9QEpcYA==
X-IronPort-RemoteIP: 52.101.61.33
X-IronPort-MID: 24600571
X-IronPort-Reputation: None
X-IronPort-Listener: OutgoingMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
Received: from mail-centralusazon11010033.outbound.protection.outlook.com (HELO DM1PR04CU001.outbound.protection.outlook.com) ([52.101.61.33])
  by ob1.hc6817-7.iphmx.com with ESMTP; 13 Jun 2026 22:28:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ICPaG/yR9xU9rzKih72gKpDHqJ4nDF4WoCNhn4bV2ZbHFnpNc2yFhKviPPhktAV4aMiwmFgj+RLosnE1pNj8K3vY0ymgxFyv6KchN6dnuhUijxULDkMOKcyKPxNQx4my4lMQRg/3lG0W/gy9UazJ1uiYzftIyehMxYRM38uYg2+Kz7iycfZJFGm9ykOXlD+APNXdnGquixKc0LiAVHWgFKrfTP4B7Hy3dCc1oPcjCBGFZkWvhDYmZCMnagQq8y6asfkXuA2ImgGv41HEw/h14SCHO5pSa2wD8IvOJFm1OXDswwHtYV04rXLjmeHnqNf+CUXwB5IjmH4wJ3Y4xXn7Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5x8jG9OFDjNGlBiBOcCvN/968c/qbQB73wF4zkpD63U=;
 b=xmIGS6wSlCXLwq+6jcs9mWLGL78QAG86OHSCgsagNyUC7bmlvzREZNLA1NJN1vxLXzmKUQItQd01saylCbSH7W8QDLduRsuyh9syU+jo3nc4G0QdN6qgDzxkq9NrFSt3Up6HwLhm9ttcULhFprU8Rx3KHzC2BPSDzU0vyeu2aC6cjI/tcDmQrIbgfcIbDq6Cqjey4fxhDrD4fv0B8ifQQWSLiB+nAf7Zgx4e5QaaL6AILNfFfn1IVd0Hkd1y0Xks4m2S/ptwb/ZkU1yu/NrAAk+U3w23trFAteZuzxi8nIvChGG3E1c5Fz73jRH/Eve4qtTSr8lCim9qgii8RMNIKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sandisk.com; dmarc=pass action=none header.from=sandisk.com;
 dkim=pass header.d=sandisk.com; arc=none
Received: from DS1PR16MB6753.namprd16.prod.outlook.com (2603:10b6:8:1ec::5) by
 SA2PR16MB4028.namprd16.prod.outlook.com (2603:10b6:806:141::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.16; Sun, 14 Jun
 2026 05:28:34 +0000
Received: from DS1PR16MB6753.namprd16.prod.outlook.com
 ([fe80::72d7:97b5:4539:a90]) by DS1PR16MB6753.namprd16.prod.outlook.com
 ([fe80::72d7:97b5:4539:a90%6]) with mapi id 15.21.0113.013; Sun, 14 Jun 2026
 05:28:34 +0000
From: Avri Altman <Avri.Altman@sandisk.com>
To: Wei Cheng <wei.cheng.kernel@qq.com>, "avri.altman@wdc.com"
	<avri.altman@wdc.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
CC: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: RE: [PATCH] mmc-utils: lsmmc.c: Add ATP to SD Card Manufacturer ID
 database
Thread-Topic: [PATCH] mmc-utils: lsmmc.c: Add ATP to SD Card Manufacturer ID
 database
Thread-Index: AQHc+0XzsVc1FpDyUUmMXgjllxqdRrY9hjUw
Date: Sun, 14 Jun 2026 05:28:34 +0000
Message-ID:
 <DS1PR16MB675311AA52947B8A7AA9FDBAE5E72@DS1PR16MB6753.namprd16.prod.outlook.com>
References: <tencent_D7DC335840B22B81B4E99D8745DC7E46E205@qq.com>
In-Reply-To: <tencent_D7DC335840B22B81B4E99D8745DC7E46E205@qq.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sandisk.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS1PR16MB6753:EE_|SA2PR16MB4028:EE_
x-ms-office365-filtering-correlation-id: c913fd74-cf09-4eb4-fcdc-08dec9d5c791
x-ms-exchange-atpmessageproperties: SA
sndkipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|3613699012|55112099003|38070700021|18002099003|22082099003|11063799006|56012099006;
x-microsoft-antispam-message-info:
 B9JCoGoMVAOAW96ZieEJIrfpYbsXb9gd7W8EHsRyUmYDRnjCNhvDljHvIkdVLVUrPNf3ZMxuJKrXnqK8g762t5h4+fkEaeYVj4vFmTP/01+JA7AoQMAgfwuj8kUUrAuP++OqcfupBhcpNac+5lbRoAFiZ6MWB/odU2MOlSsT9zJ8+6k7C2ESzLh1QI00ShLgNNwYgu1IGLLXXSLalRYBGRjGWCJxP+957PQ7aJ90I2B/7e7L6xEIP7QR8mlJXL9Sdx294zGPemridN7lQ3Bm31KPN40CKv8ojEc+0GSgFRgK4+eJWG1KPgZHLN+cEIq/wJyZQtCgjgVegvUIfNbaokz6QZxBLSEjmySm83CeygqOw3Nk9l7Ob1cFzX688Itz4kB/fZ/8RXZfUldliOgmpIxqb/HkQOEdgcbGSEtjXqSseKFx2U1yfm+QcUnu7WdqDlbkAHjXOXh9CB+1jbvbdmh9TMKKzMepM9H1XeUPcl88IxbeAoL7jqI6CxxrXSCGp0/m93k2vnau28mVXNyK/Nqfvucf9SlBKHVhaE7o0u6uaLaOs/J+hZ7os1OZ16UU3Saips8lar+tk7nSqVIurwkWyQIpgtzdm8mk7VKE+Jrexn7tz1d69X/ZBiSlLZdm9P/p+ITNCVjsVEaBwwYPEZVPcF3YFNilE4RFMMXZa3SoD8lxQNFvcZIlh8+pfWHxCDr2dz/NdHgoKCBRFEzHJ3bwuBFukhC4wgHQtupWtbeqBpYxRVDYgJmX8iCydc311631Y+xyvbxSo4T3vLYd7Q==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS1PR16MB6753.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(3613699012)(55112099003)(38070700021)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?t5EDUNIYRO/nzQNU0hAIgG8ia2mGnpB/bKE2lMlFHrkyQgHh3qnjXjNguxih?=
 =?us-ascii?Q?X3/ZWMkZVGW92NPn2lgUt+WkBk1BjncZWYaa2JhDdS4w5GEyZpnpm6hENw3F?=
 =?us-ascii?Q?OgK+oVt5f7TuYGyvS0mG3egTPXVrfiJefzP1uitZUxLwzrzIxXNYiQxQPGbG?=
 =?us-ascii?Q?773Wtdljm2MhQkwEG2E8S1W4YcMsaIYMlR6EYZc6MxcKw/ZGoNeuSbMZMw9d?=
 =?us-ascii?Q?u9XZrycrSE23pmJeq7Mtol2oyf9kjGK9UQpAI4J45jtwtuYPxx65g9Ujc3DJ?=
 =?us-ascii?Q?PGc4jjAeBDGH9zoWP/gVoGtGZO6qKDTj/v0bZN5KvRX8SgV22L9jnh90IJxK?=
 =?us-ascii?Q?Cs29ZHUcUsg5rSVc8YjGRiipRF/s8jDcio+0Rb9kshDZ8hgb1W/wICLTarF9?=
 =?us-ascii?Q?Sn5SKTWSIwgaCT8qbYJIhqpfdvHyB19z4XDzJAqWKGFghKYHvVlSs1gfF1Jj?=
 =?us-ascii?Q?ZzzObLyV9hwCSd9BHsHLuLu5L00QUWgCSs5x+WEzW/Vm901FSSK8CXMQqFbd?=
 =?us-ascii?Q?vTBrR3V/9GA7txH5Tp1u00bnzkSQI+AEwrw8cAgqKp1Y21FJpGOd1F+zFBOd?=
 =?us-ascii?Q?nFld5nxkbXS2O37IOQEjERBDPVxSEsdlMyP10HXn7WG/8GX09bKHpfX9/y9q?=
 =?us-ascii?Q?cCUcPPX1BS0hHXu5yq/35pdHL/wV8MHkUnmFvN5uUX/JlIgtYG5Xr5xCAphL?=
 =?us-ascii?Q?+nOYq7PL0pX9Zn7BG6SmOHKi118MfO9A0yUi9qmRTxdDYr+7n6nG+F4Lt5f/?=
 =?us-ascii?Q?eC7Htmq3JLwoRa9hE9pnlj4P2N7KxXBhakRCk9bXk4VYfKorGxM02BMsXEj6?=
 =?us-ascii?Q?O2WDb7k1nY12EZWqQkF1UicTS3pTu3u8OIs0Nzx9Qg8jkF2v7/6Fb5RxPz/z?=
 =?us-ascii?Q?TRtp8uU+d203eA52PO7dMiCk9mDgdIT4k8M+buKafpn1MXqwf1V4/G9NKGPT?=
 =?us-ascii?Q?bw1Db6V/zZnViaj/VPIZSjI4V2kSsgXvZCdwNV3ZBHulYnI89LSfH/3DYcCd?=
 =?us-ascii?Q?W6tcOlGBRREgONOZDWiVvjS6o7qrwIXknMuAiE4fEGAd3E58AeFY4614xmsU?=
 =?us-ascii?Q?VDAFAO5L8DovKk8DWEoL9DKwznUIAPrPPVjjQk639whqoaQxMaHzn2N3dm4w?=
 =?us-ascii?Q?bVtsbxNyPhCZ7Tn6ZBjpUqoClA3gcVVELPFeMhc3PC44vzc2N+AkSgwGR3Mt?=
 =?us-ascii?Q?8cwVBg3bYf+vwx9vD73iAZVSjs6IYxifZs0Jwip32sZr3Q5ubllIuWOlF7Yo?=
 =?us-ascii?Q?0lwWP8CY183QsFA6d7rZcysVIr1xBZrxGxhQxMZDx1U8lBFNGvbooyDSuZux?=
 =?us-ascii?Q?YbFYQ/k8rDSnrcgNXA7KmbfHikn9vOJQBHRnl5WTBPZcehgj2IrPldK8cZLu?=
 =?us-ascii?Q?+IJrDxv0809ob+9ZdtkXHTAqtEJ1iXpinQ7kvJP9rIsm5Z3nIf3nY6KtV21C?=
 =?us-ascii?Q?C9w0xz8WkcKw3KWRrc3dzSndwNIsM2kSC2kZWVuUjU/SW8Kv2zau8ETpK2iu?=
 =?us-ascii?Q?pLr0ALi10buQDTGL0QLB+btVZpSVgplQ/r7NMkUODjPyNdGfv5B5JhN0MyPo?=
 =?us-ascii?Q?9knbUlqoGyaOlQWDn8oXJNl5+hLpM6RYVBCSO30D3CNsYccB71dUGvKNEfq7?=
 =?us-ascii?Q?wnKotTsTlsFYaYTwb7cHBqi8BK/TV2oeSJtwcMQ6GqH/rUUIETfofTC39K3H?=
 =?us-ascii?Q?BeuRZ5TSBcPRH7VOIkZr0EgEeDtv8eoeObD87PiOcL/HYlABUzymDWFMHMlx?=
 =?us-ascii?Q?7oW4I+K2pQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	pduXWF6YGqJQ2Zb6Gw743jBptWSI+B3Rb7z1loO7Y2Fzx6enNkQxTqXhs70fwiPvHaymh3RwsTinNdM3IOoGXJqUkBUT7s+zMxS9t+5DU9RKEuWJCGmYKFDcAIjxBKowzvJLqCnYocBbWKMyH3TPi5ShL42LMjpqJWc4RMyzCGQy/L9pJx71STNv/5n4FmUNOdgMFgnPVlZQHaOeMqKArTRzXMvm7arScZ4uvfv/kCYlqNsX3NgHIHY/LRDPsQDaExOsdzWk2/hwaXvo+BJuppPZfdOOuuqUxSuENspCqROw+lIPdaY3ND/mMLZIIVkfCmduF81iqodukILgyqdezg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QArUB1l4naELTilTf/0cVfqeLxoZgCVJ3a+yao3kKL7ju9iOeztCX3MJSjgLcCHKKmt813fF23SGdKGKxN4yH5DtRmhBUnl3fAOG2dBOf1vmp/9xCy/6t8yVaQeBLvuDaIEfKty71D+KJbyEAEhv/8DQ9t+ocfHEJFVHo58JlOdk0wmQ1n0hfHafjXdv81BZgjhB9QlXiFK0AeBsqoRntpjYl09dvvBmuf4x663dSYLNQcviCX3LzN63FcGvl10XeVGYUUubYvEt1bfeTuW98YkZGeuIXJf6tZbbCRMAf6r1hwzbd6hLaOwHLwhtXHbIlKW6VKjIvDr0LILPCOyKQCW0zcWJEM/b6AZD/tkwZsIJfkyUX2Jn5CCdiujmCm902ATX4IC0fO8RlLhVXxSPV+eLJU1vaWn8cy/A6JaLWzE3uG6TDPG8af6aSq/KhGkdW/1Rni82dYq8K2fjBRUjfH8BQyGYFeZoiJod9YYqPqipboFULgEi/7bpH8GbCsR44Nns58vPtUPqSnzt9wLDVuNl9f1K8+vY0tFUa3PDGUPue0cz1KqlxTGEBvvAA1ge2FgsjDNAUZw3+4AxV+GbS0+JE2/zKxYOgMA9w8/NGiq7QoF5Hgvcwv2ZMdRewAzhf+Yl4cNEaCILtB6WwqzTGg==
X-OriginatorOrg: sandisk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS1PR16MB6753.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c913fd74-cf09-4eb4-fcdc-08dec9d5c791
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2026 05:28:34.6021
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ffe0ff2-35d0-407e-a107-79fc32e84ec4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 90LFYX49v6hhp46Uu2N9Llu6bLyLiW3TywD35SIqcrl/VORIuu7Ops7h23DzLDcGpW5bbsZrgftcrcLgm7gdjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR16MB4028

> The current sd_database does not contain an entry for ATP (Manufacturer I=
D
> 0x09).
> Add it so that lsmmc can correctly identify ATP SD cards.
>=20
> Verified on ATP AF4GUDI-OEM microSD.
>=20
> Signed-off-by: Wei Cheng <wei.cheng.kernel@qq.com>
Acked-by: Avri Altman <avri.altman@sandisk.com>
