Received: from esa.hc6817-7.iphmx.com (esa.hc6817-7.iphmx.com [216.71.154.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6592F872
	for <linux-mmc@vger.kernel.org>; Sun, 28 Jun 2026 07:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782631902; cv=fail; b=QuzPmR2yEMW/34LF+XwCy45dKakRToURMt1uhrmhfl5SwA/c2/7d+63UEFVCH0JaswW93RWaKKT1NckWdxMY4D4UE+zEPhbXFc6OrVkWPKs/0X1ZKQyqk02sWtaXSturLbWRjvwfmiC6k4OXHOQP5sr9Otoy+XlijzVAVpxbGvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782631902; c=relaxed/simple;
	bh=vNNyug8OVvrNqX5bjqZYKw1eswcYKRUVliv4CWsInxA=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XNx8GIBFFftBlmfVRPX4N6eFSvvX7AqyP49yANDXRv5ZmrDncbQBNANDn6zxLOs18Geb1zRX5A+FbnZeEDCO/4WWoYZtwUeTTs8/C8yfUWWNE903j+/IZpe+XsKxX48cE9MyX4OF8iP3OHlsg1TbJaQ2yYc6eDxuObQ3CXVb1b0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=NQQIYiAx; arc=fail smtp.client-ip=216.71.154.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="NQQIYiAx"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkimnew.sandisk.com; t=1782631902; x=1814167902;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=vNNyug8OVvrNqX5bjqZYKw1eswcYKRUVliv4CWsInxA=;
  b=NQQIYiAxvptIaIj8iHZDSYD8Nk/bVqhiF+7EtgNisoAyxPyRhQnglh+Q
   Kx8tHhv74OpQbIMDRE0QoxCLe2HUE2uzRY2ozYlVk7MUos5WIMU2EgnSp
   JbcMF8Rn2IXkokD+pIyKSQXgrLXnUx3QO3j2vb/GPvxQJxLWTzv/GlHza
   ATKqwKlAGvWX4buapZWwavkNX/T2DgR5VwydOr6x0/HMRS05yZyutN5Vf
   3/pTMnVt9LFslbFGrGXaaz8+T2mJdKkNBniIP2evDdk8sT6fKJOUk0f06
   oSgTM7z+Bwu06RYM7XfF0Ike+vRrXdv+EMM3Drd5A7sQ4ojk7sPPUFPJy
   A==;
X-CSE-ConnectionGUID: sZ9r3nSoTleW85kcM7J2WA==
X-CSE-MsgGUID: ZVABRW9jQ1WwyfTIXP8pPg==
X-IronPort-RemoteIP: 52.101.61.8
X-IronPort-MID: 25507759
X-IronPort-Reputation: None
X-IronPort-Listener: OutgoingMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
Received: from mail-centralusazon11010008.outbound.protection.outlook.com (HELO DM1PR04CU001.outbound.protection.outlook.com) ([52.101.61.8])
  by ob1.hc6817-7.iphmx.com with ESMTP; 28 Jun 2026 00:31:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aBMm9ijLAOY7TIqNGY94HWJ+/zudbEun1uaWuJFVcAC6iLhMbn7ZXocO9Bzhy2uIRym8e4FMuPB8tKYeu+b6h/y3ejmluo48P5V0tvClLIQ5HA1RAfl8O7m+V0rJLXBEJR1irc8dS7C0v8OwSPMZv6+zUcr31Ly4PnRTBDSFniSY/2S/JmJW8WnZKEDVTAx+6rpJI9vIE3XCvAtB7k2iYzxhdYpC8ntwSgkJCyKbJ3CQ8WhWj45MXnZ41Kldtw4wu2cDU0M0V9Js1jHCqnQio/7qxTZWY/jzMHj2wUDDPwDL/73xc4N44aQAWL7j5UkeHAHPTfRePMz2AjAcTyVZvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qnDrkTeUWWuu8SPfMHVPmCx7vUkSKSo2j2p6HumwCrw=;
 b=VKRlgcauH8jvhUNj5g+dXrUt0aBlb1AGQwQqxSWs8umS/X+6E0wTIcQLeZj1V5CS1tN9hrBqjHFNwGXXBo5sobl2MAf8M+6uK2TE3OZgOiiniNLzSSWpB/cOJ7AtfSYpohHetIxe5LKRDLHUDH7g6sa0U6si7AeOLHXGlbKHmaFnnZZatb6rymw3AVEULAC99HgmmFOMhPIIR3qcz7XkpV4xt+GfpyDHaPC9zP0XgxXQX4Qvkg4q21zSXm3xRLS8qEFwV2Ijtlhyqad9rXabaehFczFphYR19seexZE/lMOSHPXhGyRr+f3hftfCRdEmFscOOopI8xCtFy9ZYsW+VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sandisk.com; dmarc=pass action=none header.from=sandisk.com;
 dkim=pass header.d=sandisk.com; arc=none
Received: from DS1PR16MB6753.namprd16.prod.outlook.com (2603:10b6:8:1ec::5) by
 CH1PPF20D6C7E62.namprd16.prod.outlook.com (2603:10b6:61f:fc00::a0a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Sun, 28 Jun
 2026 07:31:38 +0000
Received: from DS1PR16MB6753.namprd16.prod.outlook.com
 ([fe80::72d7:97b5:4539:a90]) by DS1PR16MB6753.namprd16.prod.outlook.com
 ([fe80::72d7:97b5:4539:a90%6]) with mapi id 15.21.0159.018; Sun, 28 Jun 2026
 07:31:38 +0000
From: Avri Altman <Avri.Altman@sandisk.com>
To: Torstein Eide <torsteine+linux@gmail.com>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>
Subject: RE: [PATCH v4 2/3] mmc-utils: lsmmc: Add mmc list command
Thread-Topic: [PATCH v4 2/3] mmc-utils: lsmmc: Add mmc list command
Thread-Index: AQHdBAoZuVet0PrgyEKA86MhDgpyqbZTk00w
Date: Sun, 28 Jun 2026 07:31:38 +0000
Message-ID:
 <DS1PR16MB6753D8B392B311F599EC7CCCE5E92@DS1PR16MB6753.namprd16.prod.outlook.com>
References: <20260624184824.2215718-1-torsteine+linux@gmail.com>
 <20260624184824.2215718-3-torsteine+linux@gmail.com>
In-Reply-To: <20260624184824.2215718-3-torsteine+linux@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sandisk.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS1PR16MB6753:EE_|CH1PPF20D6C7E62:EE_
x-ms-office365-filtering-correlation-id: ff7d4862-ecd8-4f42-1f6d-08ded4e74a36
x-ms-exchange-atpmessageproperties: SA
sndkipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|38070700021|3023799007|55112099003|6133799003|18002099003|22082099003|11063799006|56012099006|4143699003;
x-microsoft-antispam-message-info:
 56q4bzwv3fTipSJ4VFed+9mMNbyNhLCPytbBWl6H2MQyyMM1JUOt2HFSP3LfzInWwOAXYrern6K2UD0xz/Ks63NHS79qZjnQHstfcq/PFIhyd4zxv86mxyTF2jDafHDif5o1qP34MorVwZV/8qI+3IdLJQO1TGzi/yk1JceY3DYLl1slkMchrfenjzIVNzU6lwAojIwiI2LYj1n45EeU9peOYy7MkSmXC3EowpzC4ie0rWgLy1fBDI+Uwh6bjLOxctNBt0meVQcmJb2bWjETX9Z68C4MFsbHC+ta5Kn25oqYdfwljeo8m5pLyUNHEEfupNOnbQ42ULq2ZRxe+BLrmyeKKxxb2LGZLxbGJDKONkzG8/QaxAEzdu5VmLWwWBGd4+tDNfvMgUjS8dbH5HkzIWQA7sQtdNR1Kgp1OWNh7BWMJNPjRW/L6v/8VKYuIQe+3wPAcx+2n5RGYqJ61h4VfZvkhAgrCIKJJztjZ+zZ9bX7xqcTuH2EcSyL0ViqvC1i9BnsXoxZJz2Xq5/qRIDZ+qyZtwRFhIXKBfBbDW6WGYdjiwzg5EcJ+Z7Z5sZjtubhKsqJwi7vkNUR2x+4s5VjHPlQRkbun3DUrV/aWnUQv7PQ7iEsDAhSt7zJemr9lytanoABUdVKfWjpVmZixgWFN200fSwKQ0dmuFyJ6OS1mJh4QICV7KU7PSiKnTS9WOWlv6qcT86Bs//WCIoMIvtTl24IZzFTyFyx8no3ac81e68=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS1PR16MB6753.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(38070700021)(3023799007)(55112099003)(6133799003)(18002099003)(22082099003)(11063799006)(56012099006)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?GFiLCRuHIuM6L4MfWRZbGXrJgWdEBkKGqUT/jQQj7mLhaKG+Rm1XC8N8pa4O?=
 =?us-ascii?Q?hVolDXmQH0XSevSOjd2o3vf0yYhBSHpXIBZaVCwq5ZMOZQN8ZMVTbnscQUdp?=
 =?us-ascii?Q?4wEgVk9yI/XWTebu/kisIzUqk6T9J9Tznw40YngxGtyuCTjVuk1qS3zHHdVb?=
 =?us-ascii?Q?X2qxP+gY6MdbpFMIVE2gTZaRFA3cClieBtgatE6cLvwXekZRJ7hOKTs6E9HK?=
 =?us-ascii?Q?USEAyxBNCqkDZG0k8W2wmgcdpIoLvcrGIppHrt/UgD2IvczddnFCAKjmAfyF?=
 =?us-ascii?Q?3qSJJOex76LugBRW2ok77QdowEnT06tflOIv8cOnxcxdCWZYFaxuxB4aC3sp?=
 =?us-ascii?Q?TCfQHMf6OiWBffEADRRkqxSz6rkyV7pRkyrjeqwG3AzlA69B3tdGVSwrqAw4?=
 =?us-ascii?Q?3iQLYnVhLSSTt2Y9xHZgtAtgeusKXMFxO+s8JrDcvR12KkwlaNn8Z7gcdSa9?=
 =?us-ascii?Q?BzTGM0n1B2sHac87nc5A/aat+V55QoEzGoyXNtoidHw2v4Fsw9r5U1yD0b8O?=
 =?us-ascii?Q?LitnqXdg+sez9n2jOoZjey5P14AFouNK0sP67t1AgiN8L2rXrRpa95lNupay?=
 =?us-ascii?Q?fgJgz1eGW44VkpHp2rq5LZH+mRW72Gb+ipHvI8FmXeJE/jBbdG3o+SetJtSi?=
 =?us-ascii?Q?4C227nEAZ0/DL/iV1MPXZOQG810PFYTDASdyoirz5LtyIEXPkga7kV/3wcbh?=
 =?us-ascii?Q?9q3zYQaJ8dYMUZbLF9wdkbj7RT8j1kCiz2Uet/SI2nz35zVRuPCYK7CfqEgD?=
 =?us-ascii?Q?QSPOq3nQs8MyQ9H3jSOKGyDvfL3UiDCm0FVfnroPUKpAymB8zagAqIDX6R+K?=
 =?us-ascii?Q?iawcYDGWF7j2GznZpBUoTDU540Er+zo3ZJ95SxpdjRROQHvlb7YQ+SWXTr9T?=
 =?us-ascii?Q?l6TFRHPkW2NyIY5Of6joav3/gQFfr9hroE5phEZeo84VhsRkq+S+Hkiqj1pP?=
 =?us-ascii?Q?3IQwf+9WXq9M9sCym1B2aL5zMDDiKh49nwpQ2tbkK9anWkWvoDzn6duiVZGY?=
 =?us-ascii?Q?sETX8uYAcMKozIeNACwspGiFwmKooVFBGglHFL8NLDPTLk6yN91DDVin/fAd?=
 =?us-ascii?Q?ZlRseFF4ZmGyTHtqSE5fqdM9p/dR8pekrDrXSvWXV85En+ol3luwfOgxYcVv?=
 =?us-ascii?Q?Zww3NItbT6JgKFG6fOShGTQZLjyIl92fn+T0UUZF/OMUdj8HGt/YIp/oJom6?=
 =?us-ascii?Q?Omv36xT/YIPpFnCvt1tXP6EkFb7DpHRL6Jx+g5taQIpOGLUvdUEyjiOOEb6i?=
 =?us-ascii?Q?D4FCRrvuTrnBg2swT7Mcka7oCrQo6Bq1vc69WBc8cId3eZOZ+/jdqkvt3erP?=
 =?us-ascii?Q?Q4mSg8jfRpoOYGMNCOoCEvNH8jG+pb/BffxeYYlUDoMP4pVBUpu6sQEexqZq?=
 =?us-ascii?Q?4ZmgK3Wp/wa9njVza+6ivDrm41pkj+yz/zBaV4Xk9degrEVcrjMjmD65wXAh?=
 =?us-ascii?Q?OOhjBvHs03UVObObHgtgW/XIayHdJqqg2tzaJBDhdk9dQS4nqkXEftgH+590?=
 =?us-ascii?Q?8I9/dF/4mdReiJ9skfR3xE7iEDc0tdFOw+7g1F8vTfjWyJocYJd3qRI6GV8u?=
 =?us-ascii?Q?z7Vu9+xSN8kTa8YGtQijhUIUNBobTGw4B9nYo0HlRpYtmHRaSsSN2wWfsoQ5?=
 =?us-ascii?Q?tvGfapC2oyvxkRAKoMusmy2P1Ot7hYtf/Ex3crFRW+RuGbXLFTLHoLJujCHD?=
 =?us-ascii?Q?McaaLsPl7TN2DSKgfG8XYXUFLCBTYuFgq4JXtT3ItrK9RuCarVhgabXLYcHv?=
 =?us-ascii?Q?d9RyMTsDHw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	ox5ajgGUBuQTDdFpWhhAgmZWeBeak2qdcj9twpfKY7nRXvtOuybwqgSFEHMbXdVcY0kWK9E4A7+BBraOKAB++3oVZmbzX9A+suWJWvgGBzU5MBoktvJaoY1SMWNaoPZOsWBTV7qg4iV4bYtPtcbeUvgC41dkeXP5QGIpGiX3o9KM0SLsx10Famvk1bS7FTuAm4BTpw9bFRybbMVb9VRhp6lY0qNbJJ2HMaJ61bJbJx71ac9isRrid/QY3VhsDCmyLTATD6gvsmn69zClsR8EnK/bSMVoKrJCwvc7Pdu4RyEPNaHTFOXEdWtIBlZvkGqF8SOWK4l8P96XqmNgo0e2Ew==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	75Ekq5DTW6iYK4S+gyDqj31foOvQvie/V2efmx/VEewe8zmASigfeDqfOv+Gz7bOaknVS7JG7dCYGBRTJilkH08gEwJK+TexrbyDMgkzQnAOpOm5VfE7QaFGVnISOOGObpu/0oCzJT3dpcjDKAelVTwWJnphAKNdbietJCpreRNVF69Om8IIRJzLUIYkxYNUUf5qjMGZNv6Vz1NwSh/lvZecV9kMbEwYpf21Rpnxy+5p+SJH/7tjb7Fni3zRguH4CQd6HCohOZ2psVtAJpeY2HjU6XKXQCu4c4pv+DRDNRq0p7uwS5+qYVsEeFgU+BMOLKA8KvXEQWl6aOfvAXMbIez9CTo2fjAYXtUqgoSf4aAulvzOBtC6gflSySm5GhchmtHYnhcv5gWyJogxW9cPcC0dIKzR6l3quGpxSZJ9zdPWcq2hEJ+MsMLyGAv5xon2sl8AlBptEQhMZm51NvWqt8MT2H9oQxDMOWBzVl72gtu8rlkxrDkQEBMDR28LI8s2qcXaUabWBfa6SjWR+wrIFPKO9E0yKnew8KPpDua/43RjY1tC0xwh8+dr1/w1pRO/wjkDwMT5eDYXxY/GTF4J6BHM+WxLQGe1JLqHnBZXSbvHqbC/9BUIB6IMNCUB+DoSrShSCAKQBS/hn4b5YMO3hg==
X-OriginatorOrg: sandisk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS1PR16MB6753.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff7d4862-ecd8-4f42-1f6d-08ded4e74a36
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2026 07:31:38.0507
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ffe0ff2-35d0-407e-a107-79fc32e84ec4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W19hqaIjj63Eqy0CbEC7O67wXz860COVEhNpKjGDvshZmLIEwxGJtPqEq/VJDwPgPbRoLRNI4wYdQzd63if5WQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF20D6C7E62

> Add a 'mmc list' command that scans /sys/bus/mmc/devices/, resolves each
> card's sysfs path, and prints a one-line summary per device.
>=20
> find_block_devname() maps a sysfs device path back to its mmcblkN name by
> scanning /sys/class/block/mmcblkN/device symlinks.
>=20
> print_list_entry() parses the CID register and formats a fixed-width tabl=
e row with
> device name, /dev path, bus type, manufacturer, product, revision, serial=
 number,
> and manufacturing date.
>=20
> The header is printed once before the first result. Devices without a rea=
dable cid
> file are skipped silently via access() so unrelated sysfs entries do not =
produce
> spurious error messages.
>=20
> Signed-off-by: Torstein Eide <torsteine+linux@gmail.com>
> ---
>  docs/HOWTO.rst |  12 ++++
>  lsmmc.c        | 147 +++++++++++++++++++++++++++++++++++++++++++++++++
>  mmc.c          |   6 +-
>  mmc_cmds.h     |   1 +
>  4 files changed, 165 insertions(+), 1 deletion(-)
>=20
> diff --git a/docs/HOWTO.rst b/docs/HOWTO.rst index 3739a0a..0b486e4 10064=
4
> --- a/docs/HOWTO.rst
> +++ b/docs/HOWTO.rst
> @@ -90,6 +90,18 @@ Running mmc-utils
>              sysfs:
> /sys/devices/platform/fe320000.mmc/mmc_host/mmc1/mmc1:aaaa
>              SCR Register: 0235800000000000
>=20
> +    ``list``
> +        List all MMC/SD devices present on the system. Output is a table=
 with
> +        columns: DEVICE (sysfs name), DEV (/dev path), TYPE (MMC or SD),
> +        MANUFACTURER, PRODUCT, REV, SERIAL, and DATE.
> +
> +        Example::
> +
> +            $ mmc list
> +            DEVICE          DEV            TYPE  MANUFACTURER         PR=
ODUCT    REV
> SERIAL      DATE
> +            mmc0:0001       /dev/mmcblk0   MMC   Samsung              MA=
G4FA     1.0
> 0x1a2b3c4d  2021-jan
> +            mmc1:aaaa       /dev/mmcblk1   SD    SanDisk              SP=
32G      8.0
> 0x5e6f7a8b  2020-mar
> +
>      ``ffu <image name> <device> [chunk-bytes]``
>        Default mode.  Run Field Firmware Update with `<image name>` on
> `<device>`. `[chunk-bytes]` is optional and defaults to its max - 512k. S=
hould be in
> decimal bytes and sector aligned.
>=20
> diff --git a/lsmmc.c b/lsmmc.c
> index d5a26b6..bc43004 100644
> --- a/lsmmc.c
> +++ b/lsmmc.c
> @@ -229,6 +229,39 @@ fallback:
>         return strdup(name);
>  }
>=20
> +static char *find_block_devname(const char *sysfs_devpath) {
> +       DIR *d;
> +       struct dirent *ent;
> +
> +       d =3D opendir("/sys/class/block");
> +       if (!d)
> +               return NULL;
> +
> +       while ((ent =3D readdir(d)) !=3D NULL) {
> +               char linkpath[PATH_MAX];
> +               char resolved[PATH_MAX];
> +
> +               if (strncmp(ent->d_name, "mmcblk", 6) !=3D 0)
> +                       continue;
> +               if (strchr(ent->d_name + 6, 'p'))
> +                       continue;
> +
> +               snprintf(linkpath, sizeof(linkpath),
> +                        "/sys/class/block/%s/device", ent->d_name);
> +               if (realpath(linkpath, resolved) =3D=3D NULL)
> +                       continue;
> +               if (strcmp(resolved, sysfs_devpath) =3D=3D 0) {
> +                       closedir(d);
> +                       return strdup(ent->d_name);
> +               }
> +       }
> +
> +       closedir(d);
> +       return NULL;
> +}
> +
> +
Double blank line.

>  /* MMC/SD file parsing functions */
>  static char *read_file_at(const char *dir, const char *name)  { @@ -2274=
,6
> +2307,120 @@ static int do_read_reg(int argc, char **argv, enum REG_TYPE =
reg)
>         return ret;
>  }
>=20
> +static const char *month_name(unsigned int month) {
> +       static const char *months[] =3D {
mdt_month is 1-based - see print_sd_cid & print_mmc_cid

> +               "jan", "feb", "mar", "apr", "may", "jun",
> +               "jul", "aug", "sep", "oct", "nov", "dec",
> +               "invalid0", "invalid1", "invalid2", "invalid3",
> +       };
> +
> +       if (month >=3D ARRAY_SIZE(months))
> +               return "invalid";
> +
> +       return months[month];
> +}
> +
> +static void print_list_entry(struct config *cfg, const char *devname,
> +                            const char *blkdev, char *cid) {
> +       char *mfr;
> +       char devnode[32];
> +
> +       snprintf(devnode, sizeof(devnode), "/dev/%s", blkdev ? blkdev :
> + "?");
> +
> +       if (cfg->bus =3D=3D SD) {
> +               struct sd_cid c;
> +
> +               parse_sd_cid(cid, &c);
> +               mfr =3D get_manufacturer(cfg, c.mid);
> +               printf("%-14s %-14s SD   %-20s %-10s %u.%u  0x%08x  %u-%s=
\n",
> +                      devname, devnode, mfr ? mfr : "Unlisted", c.pnm,
> +                      c.prv_major, c.prv_minor, c.psn, 2000 + c.mdt_year=
,
> +                      month_name(c.mdt_month));
> +       } else {
> +               struct mmc_cid c;
> +
> +               parse_mmc_cid(cid, &c);
> +               mfr =3D get_manufacturer(cfg, c.mid);
> +               printf("%-14s %-14s MMC  %-20s %-10s %u.%u  0x%08x  %u-%s=
\n",
> +                      devname, devnode, mfr ? mfr : "Unlisted", c.pnm,
> +                      c.prv_major, c.prv_minor, c.psn, 1997 + c.mdt_year=
,
This hardcodes 1997 + c.mdt_year which is wrong - see how print_mmc_cid der=
ive the base year.

> +                      month_name(c.mdt_month));
> +       }
> +
> +       free(mfr);
> +}
How about factoring out the shared pieces of month & year into small helper=
s and have all three callers - print_sd_cid, print_mmc_cid, and print_list_=
entry use them?
Then we would have a single month's table and one place for the base-year l=
ogic: unsigned sd_cid_year(...) / unsigned mmc_cid_year(..., ext_csd_rev)
Probably as a preparatory patch.


Thanks,
Avri

> +
> +int do_list(int nargs, char **argv)
> +{
> +       const char *bus_path =3D "/sys/bus/mmc/devices";
> +       DIR *d;
> +       struct dirent *ent;
> +       bool header_printed =3D false;
> +
> +       d =3D opendir(bus_path);
> +       if (!d) {
> +               fprintf(stderr, "Cannot open %s\n", bus_path);
> +               return -1;
> +       }
> +
> +       struct config cfg =3D {};
> +
> +       /* Probe ids files so any warning appears before table output */
> +       cfg.bus =3D SD;
> +       free(get_manufacturer(&cfg, ~0u));
> +       cfg.bus =3D MMC;
> +       free(get_manufacturer(&cfg, ~0u));
> +
> +       while ((ent =3D readdir(d)) !=3D NULL) {
> +               char devpath[PATH_MAX];
> +               char resolved[PATH_MAX];
> +               char *type, *cid, *blkdev;
> +
> +               if (!strchr(ent->d_name, ':'))
> +                       continue;
> +
> +               snprintf(devpath, sizeof(devpath), "%s/%s", bus_path, ent=
->d_name);
> +               if (realpath(devpath, resolved) =3D=3D NULL)
> +                       continue;
> +
> +               type =3D read_file_at(resolved, "type");
> +               if (!type)
> +                       continue;
> +
> +               if (strcmp(type, "MMC") !=3D 0 && strcmp(type, "SD") !=3D=
 0) {
> +                       free(type);
> +                       continue;
> +               }
> +
> +               cid =3D read_file_at(resolved, "cid");
> +               if (!cid) {
> +                       free(type);
> +                       continue;
> +               }
> +
> +               blkdev =3D find_block_devname(resolved);
> +               cfg.bus =3D strcmp(type, "MMC") ? SD : MMC;
> +
> +               if (!header_printed) {
> +                       printf("%-14s %-14s %-5s%-20s %-10s %-5s %-12s %s=
\n",
> +                              "DEVICE", "DEV", "TYPE", "MANUFACTURER", "=
PRODUCT",
> +                              "REV", "SERIAL", "DATE");
> +                       header_printed =3D true;
> +               }
> +
> +               print_list_entry(&cfg, ent->d_name, blkdev, cid);
> +
> +               free(blkdev);
> +               free(cid);
> +               free(type);
> +       }
> +
> +       closedir(d);
> +       return 0;
> +}
> +
>  int do_read_csd(int argc, char **argv)
>  {
>         return do_read_reg(argc, argv, CSD); diff --git a/mmc.c b/mmc.c i=
ndex
> fce7eef..b0f1f9b 100644
> --- a/mmc.c
> +++ b/mmc.c
> @@ -306,6 +306,11 @@ static struct Command commands[] =3D {
>           "3. Only up to 512K bytes of boot data will be transferred.\n"
>           "4. The MMC will perform a soft reset, if your system cannot ha=
ndle that do
> not use the boot operation from mmc-utils.\n",
>         },
> +       { do_list, 0,
> +         "list", "\n"
> +               "List all MMC/SD devices with their /dev path and CID inf=
o.",
> +         NULL
> +       },
>         { NULL, 0, NULL, NULL }
>  };
>=20
> @@ -590,4 +595,3 @@ int main(int ac, char **av )
>=20
>         exit(func(nargs, args));
>  }
> -
> diff --git a/mmc_cmds.h b/mmc_cmds.h
> index 9d5f944..033cc09 100644
> --- a/mmc_cmds.h
> +++ b/mmc_cmds.h
> @@ -62,6 +62,7 @@ int do_opt_ffu4(int nargs, char **argv);  int do_read_s=
cr(int
> argc, char **argv);  int do_read_cid(int argc, char **argv);  int do_read=
_csd(int
> argc, char **argv);
> +int do_list(int nargs, char **argv);
>  int do_erase(int nargs, char **argv);
>  int do_general_cmd_read(int nargs, char **argv);  int do_softreset(int n=
args,
> char **argv);
> --
> 2.53.0
>=20

