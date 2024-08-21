Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0AC168487;
	Wed, 21 Aug 2024 06:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724220313; cv=fail; b=PH38w5pT6T9MU+oh0tqwR+7gtcg376MMzH2eCFUyYAz+BmIy/cJTPipDBl2pXvk8WTUglcgxixSb+ZdjlupTWrgJHxfkqYeQIAhIf5LPeADGp0cMezMcpl9QMne386BNapGKYIP7uddfkf7hy2ZBJA2dG7K9SP8vymzAtlhx+8U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724220313; c=relaxed/simple;
	bh=AaSTuS9XRX0TaskRsNFNo7i7XOT7XVRfBPeJfch5u5E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nYLQ8wYanotiStmtMj3zuWHkyTcQkRhGMzgZh46X6Ynwcz4evtGrqx39Juoaty7OONv0e1jOSNlQdnRiOQGwFWJfw6fGJpvy9Bk2mguBYwT16I+MwE7phfVeJDldZ5uifDIsT0MxgEXqIFJ+3jGuEIrmBV9FYxBFzNtjKn30BnA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=V3Gv3Ph+; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=O1MesBIC; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="V3Gv3Ph+";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="O1MesBIC"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1724220311; x=1755756311;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AaSTuS9XRX0TaskRsNFNo7i7XOT7XVRfBPeJfch5u5E=;
  b=V3Gv3Ph+F7EnoOgWfIGdPAfC3V1k29pjNGWxCXNfsJYOqXRxCkgR2vvO
   sv6b8xIiJAtYYv65nkSwkur7s8RiwHll8WLehhNlDLW+dPMhxYKlMNxXV
   YW2oeEIrw0BmxeACN1Z/9vOboZiVxTa+KgykhnYj/ere9fwoDWN7XTP0n
   cMOt8bIg5fJMPuaOMmv81v4CYMOrwfrt5hkIY82XfAUaXqnyJ+Ir9GOId
   drWs48mCeCBFI8lEtehIRm+BTQUAH7iZelPTJ05jH5lNa4XmzK0UxYbH5
   BBLU3U5w4IGUKQkv/YI7yjHyyojkz23jQuXNjfQi3vCr5MGdya3ttDAd8
   w==;
X-CSE-ConnectionGUID: Rl8ttQ9xRw+kpvjTrscxAw==
X-CSE-MsgGUID: fdZzt/90TFiPo0wJAwQvpw==
X-IronPort-AV: E=Sophos;i="6.10,164,1719849600"; 
   d="scan'208";a="25777761"
Received: from mail-westcentralusazlp17010000.outbound.protection.outlook.com (HELO CY4PR05CU001.outbound.protection.outlook.com) ([40.93.6.0])
  by ob1.hgst.iphmx.com with ESMTP; 21 Aug 2024 14:05:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uVv9bMvvfVJmtgByP7ekJTaOU/oBSWpCssidwhGEtmQ/hiWrvWYHRUI+yqncgu7E/OcWy42dainsvuqMXOrkXqRYP0nehq9aEFoSIaawzmJU1duaHig5eoTCtyoCwZSR53akvvszdYr4l0AJf2qnWyjEMiQQ2cGTWak15QnRJE3dU9r68wvQMSIsth1kq9134HkoOYMpfQm1Uv6dgkK0GHl06ekUunx9wB0PZrcC+1LEv/uOydzxp5jZllF8BYZuQB45noWdrskWuWPgHorFiZE8a8ooxzswWTJOqqqowrRyjN+PY6/ryd6gZPICPEMr6PM1Qx7N2dyeCVQNS5RDGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AaSTuS9XRX0TaskRsNFNo7i7XOT7XVRfBPeJfch5u5E=;
 b=gqGcbp4IEJnPkl2B6ylTy3cqnGebdwBKd/hpqY8iCt45CaLmAp9SJrHNystoB1VjScLtqDcdSDNpD5Agt2ISKvimYgYTPD2tjILpMLt6ihdwTcE+Q594bjQ5Ny4Ydpc5HHWipk8E4LsfBfwozXkY1qY8RgTReyl5RugBjROdSl9FCeD6+8/CuD3i3pCpwPFLTkptoSY9HfGZJLt7GFnOM8C10xXMfAG5Qi7sfRZ0Ugzmx/+gnTJ1Z2lQKnuaoedZCh06fUyCImb0RLK9ync/PuByuwNkcnYUsxOIYxteYjObfIg674b4lFVvUt3N0TXaS89pTQPS2F8WmenWnYlD4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AaSTuS9XRX0TaskRsNFNo7i7XOT7XVRfBPeJfch5u5E=;
 b=O1MesBICX5/8Suylt4A+8/Nwl/ubiVhWhbeTaOuawRE6QIbKDVIwcIbZw4/1P+6hkadRuALiR8ZTpRAy1Bjwc03QYLuU+ke17LxfuRvX1Vs+7j+PtDiAvsEH9W7/ksGO9qs+Ih3HpYPlskhN3D5PRjLxUeaRT7tdCaYU9Cqlty0=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 PH8PR04MB8733.namprd04.prod.outlook.com (2603:10b6:510:254::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Wed, 21 Aug
 2024 06:05:00 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f%3]) with mapi id 15.20.7875.019; Wed, 21 Aug 2024
 06:04:59 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Keita Aihara <keita.aihara@sony.com>, Ulf Hansson <ulf.hansson@linaro.org>
CC: Jonathan Bell <jonathan@raspberrypi.com>, "Tim.Bird@sony.com"
	<Tim.Bird@sony.com>, "Shingo.Takeuchi@sony.com" <Shingo.Takeuchi@sony.com>,
	"Masaya.Takahashi@sony.com" <Masaya.Takahashi@sony.com>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] mmc: core: apply SD quirks earlier during probe
Thread-Topic: [PATCH v2] mmc: core: apply SD quirks earlier during probe
Thread-Index: AQHa81cWmdGCEWGMy0KIHwlaiipHyrIxOTzA
Date: Wed, 21 Aug 2024 06:04:59 +0000
Message-ID:
 <DM6PR04MB6575D3F036B2ADD0F35837A8FC8E2@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20240820230631.GA436523@sony.com>
In-Reply-To: <20240820230631.GA436523@sony.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|PH8PR04MB8733:EE_
x-ms-office365-filtering-correlation-id: cf18bfd0-2dcf-4976-207d-08dcc1a730a3
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?/qH4Bvk23mZAXE1jQYA9RJ4bcxgtnKGvv0qFEWdphph6YeHzb2lf2r+OUbKr?=
 =?us-ascii?Q?jZPgWUQsVqjw4y4Y7XT7MQAX8lAfH5iyv013jFF4JuLoFpB7Rz8bTm6aKpS8?=
 =?us-ascii?Q?glqbBIY2z2/k1WHXqEN1P+gdmsDSwN+ZP+seSouuB6LcI8vvs7pwKj4AXglw?=
 =?us-ascii?Q?wv8rvwENPyWhZuyxrRdRU4ag/98eSraiJ9T560XqLju+uA0fLpj9PM/I3tYe?=
 =?us-ascii?Q?F1vcVD9HZxDTBALcvUfdxYnameBFmrZm7sKoX1+9wjJnww+Vokh4YaitBdbf?=
 =?us-ascii?Q?Em2XZrxxeMhKmBW6JkAi0o3ENO4JUhozYyhJekmL0F9R8wxBZxezuBOTPoPK?=
 =?us-ascii?Q?R3kLsoWjeeSiZUeK6k83E0m5cC2R7DBd9yyMXeXbfFDUdrEQbtT1Q3QekiAO?=
 =?us-ascii?Q?kd4S58yBxqf+JvXP6z9OS0xMdI4WAgE3MyfdRdaickX2n+W6IoJqiWFpfG8h?=
 =?us-ascii?Q?pgDSCciyJZO5gd47t1A/Ph8caFlQFnCcq26ZwZKFNNy4Ake3UBYGP9pVjmV+?=
 =?us-ascii?Q?aKMw9aMV0JPYJJUEtlr7GkONjgKNlj0Td8quMZXi39nb0MWIRnvgekSZ3cx8?=
 =?us-ascii?Q?bQ3jN3MLSo7NrjUBHnGqnvyrWVixpO0bij1FUJag1bX0ddCPIYjbeIJReXeZ?=
 =?us-ascii?Q?HHUoOIOxt0/Lz86HZkyld9Ax+0jU/bJma634R1q7ymNocIOARivXPjnmzsIg?=
 =?us-ascii?Q?XPJp9/56mgCgckUU5/3pRTTzyciRTewL+ksJReeVw0EyVYD/VX3IdYS1HCE8?=
 =?us-ascii?Q?xst5/8DasGxY+1YwxC9w/3YehsNdMhHmmc+4/zPqoZqiTpkxUYifkIUSByJU?=
 =?us-ascii?Q?SkrYx/Hr1qHq3wJbTCJTXYOn435o007Xu8cIu5cn/4Jobtf3L/y5MPQ9U0rm?=
 =?us-ascii?Q?5fzJcWR/8Om2Vpz69EzbPct2wwUe18gfxYfvwmgehq6Oa4gSAutkTCzSx6H2?=
 =?us-ascii?Q?eAdJbLY4yJeSgNfBgyEl9qPfcWs8b7DAwPfeXIc1tem6tVFtvs3wRIY2rzxS?=
 =?us-ascii?Q?cwvWhOZr7UwLsq3fx+qquQgDnbUUCqykga3xXvZBcFcRsiVCRZP1iglxvMEo?=
 =?us-ascii?Q?xjR3i/LV4uvU/IxIyKzSnHa2CYtR9nO54/UU3zKn9066DIU0mBzK0UJfm05W?=
 =?us-ascii?Q?9K22dyrj0YijrrYpw4EHiZlhnXMwJPOFuyPI6eIomX29NCZFRnvQkWD2+7dv?=
 =?us-ascii?Q?8XLa6cC857JtFZ0Vmz/iLtLi/KIQSvYlYUkg2FpU1vzzPzuApCXqfcUdr9iQ?=
 =?us-ascii?Q?C4eYV+4lPcVkMRJGSRwUHBIt9RPgXC/lh0Xd35Clvc4S3U7pKR7tom3q9+zP?=
 =?us-ascii?Q?n+Vsk1P2MRmS8qs/PEu/F9um2zAcaaqlum6tCFnNspXP/xfI/tsWDZJg5piI?=
 =?us-ascii?Q?gkPjaL6hp9OF81IksFjXYoGa1VzDTmFuURn0VwR9x8ApeSE7tw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?zO2T/iNT0l9sjufOrxOjydS+ERpFxGggg3RSSsttQrobKzVPdGmLmbMOnAQ7?=
 =?us-ascii?Q?8LNBkGi7QNpPUbhMOenYijgs8JVgr5e8BuyOzeuwEDBGnghbzKK1QTAYOc7e?=
 =?us-ascii?Q?gzCnfXn2M7x/sFwr04zw1Syn91SroRX9NaIc+IByX4IVJyGBeOKkedSythgw?=
 =?us-ascii?Q?0smUl4jxzQqQeSfdmY7QzXJXygDPh8EmUQGhRR4CNZOSGhS7yNTpDNROI7Vx?=
 =?us-ascii?Q?NSOtt0d8SNOAshXeGSAO+h7bfTpcMWxHu3a9yx3l+hnDbLTq4gvdsChmoKsU?=
 =?us-ascii?Q?T2LND4/vmM4xUZspgoj72YeM2CR9ftR0raGES7/26Qd0YUEEW3pcwN1M4EdC?=
 =?us-ascii?Q?6/MPLyEKV40Fh8P/wBJ5moXJaLRjigymQ0lAwHRfPOfSg9F5IvShW5/E58GD?=
 =?us-ascii?Q?wC78SANJLq3LA9K+SHzx6d9+OKeGmhvdtVfbsisMPqbV722Hfg4jnGIOogST?=
 =?us-ascii?Q?XN0+52rqe4u7uPGtsBZLCJ+7SzdMf+sJwVax6UOpOigp9GrCeDcQASp7s4J8?=
 =?us-ascii?Q?+iHQxwqJd6DYyoIW6+wd3rbRhqSrWEU8W8D4z+qg33kL0eOyDGIzZ9NoL0i/?=
 =?us-ascii?Q?QQg5o88JxiDiMD+a+raV8xqg1JeJXprxXIei+uIjeubqi7C/CuWNCguBmT8/?=
 =?us-ascii?Q?NtQ0cq8PpoPeNw2NHQmsobRu9x/mfPEI8A1cHpRfkacZVOSSJePdNJ8tRyGI?=
 =?us-ascii?Q?RgyoRA92Gdegc1AJ3VR75CmKoGmiYfWVbNRgmreo11/tY9Ucb71TgrPNOcJu?=
 =?us-ascii?Q?U45OBCMo74rQjKmtV59FhJacd8wf/Z2PxALckejwCqB0pMxRh8uxbZXswhJU?=
 =?us-ascii?Q?LdP7t6mLkpkWpbv1dYqE8vEra7n8dTUnVKBB1wUwfWZHPbUYGRAlUJ4JPhWR?=
 =?us-ascii?Q?DYz9krnMdFjQF3kPzHNNwODN10vZHUmjiS3tInszGvy5s834Fn7BucbRUyf1?=
 =?us-ascii?Q?bvnA+lRew3GS5APhfyfyZPtPUIABnZcO9NGVIcGDrWDco5mqB9mMyaC9+RpL?=
 =?us-ascii?Q?W4NJFxh6A4UlCRwbCp5nnF5sC3aorZXgtq1V+A6cDGUJCuN/GuvsvvjXG9fF?=
 =?us-ascii?Q?m+1/+OoDxYNW5XKauULohuxh0RcrZtd588l9tSIlecAiqcdXvABL14Swupt9?=
 =?us-ascii?Q?xIJq+lsyeZaFxw9/eYIrZCKB3Hke9CUvCiNynE4OHEctmPBxuS3Jza6f3kBT?=
 =?us-ascii?Q?U2ZXOHLgx7LFZs1kSuHvG/IJPY0mEgjAMs4oQFbjflRxNvhwJUVB9pqlvO0S?=
 =?us-ascii?Q?LbAhJ1nM8qD5fXwnmO0Pg/wgAsrSvi3XoVqxnDkjvrjot56bDmVjBgioGH00?=
 =?us-ascii?Q?zm4zncXzxtZCgP6a3u3AxutV851podQWcvSeYmMGYtdd8JScERg1R5VfJXWb?=
 =?us-ascii?Q?v50toGJjBHIROnUpXNblgMyXW5WETFZpJntKuQ1vk2mN4g+1CWRNg4Dv99Uf?=
 =?us-ascii?Q?GhbrpfQtjTcqntQVGzpG4VmOnX3G+ztFWSUfOxFCBpZTMb14hJdOUaL/IEs2?=
 =?us-ascii?Q?I5dJoNjtB0eCv0a8n4mqY13cqYqnHkT6XRLFttVmcX4SHvGlf6JISB5hkJMn?=
 =?us-ascii?Q?RvkA5Od20vpNd3cKT0Vu6/Hku9IXGl30uHiAyp1u?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dHwJOsecfOsk2ausZx9kB9RGMBw3xRT7Nlme6sSLApVHNfv4TZRFkO855n8LosZXclHZU1alMAix78b+LBwP3FhF7J3L+j/24y0Zo9w2GxV3xcb2pK5CtrhrDHtrvSDGMqOQub9W9GaYicXqxeYoWwQVGc85jPM+522SnSi1GwcTcArIU2b9IveEbJdM8KnJ+lYNEXHL7ZI03Pgt7j0Ak0bOA/3ic6BhES94X0v18uKiyEMmShMxWw9w2P5RgYZRDOJi+HsouSOeOTaVFOJoK1k0iChgWctOt7zeSJm0fP6D2JMoBECIFgEyQ5q0ETHYz2vnIaCJyMRFpiRZUBCEonkD5cDHCcTFOvYZ97CcTmZ8Tt6xRrNUeJ/LB+XU7b0YmqF35N4XZd3rYeJQDunZQP9b5Xnv3YC3B1kJHeuZ5qPjonR3n6gFDN5EGXLzfH54RSSJle2UtUzxqXjSMSHBzTITdRPaeb5bvqVjCA2PTKTOYJIZly4YXWu/5SrtyKRWS6ZFigwBWCTzX1D18ZQjnMMyCSB9dLPVAGXbDBCNuXKsAid8k2XeN5uiAeK70ICOV1Qe4zkEgRqlj9C/+6+8qEWOlI3FW3D1gAycEITtYtYV5xAU54vaqMnjRXgSrUUv
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf18bfd0-2dcf-4976-207d-08dcc1a730a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2024 06:04:59.9323
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XAs/oh9T3eH2nhLAn1wfr21J0lUcDb/bV6Nai7jTTceWBq7HI4nADi7LjVS4v9lcgb8pTMuPfRvX/leTco/Vlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR04MB8733

>=20
>=20
> From: Jonathan Bell <jonathan@raspberrypi.com>
>=20
> Applying MMC_QUIRK_BROKEN_SD_CACHE is broken, as the card's SD quirks are
> referenced in sd_parse_ext_reg_perf() prior to the quirks being initializ=
ed in
> mmc_blk_probe().
>=20
> Split this out into a SD-specific list of quirks and apply in
> mmc_sd_init_card() instead.
>=20
> Fixes: c467c8f08185 ("mmc: Add MMC_QUIRK_BROKEN_SD_CACHE for Kingston
> Canvas Go Plus from 11/2019")
> Signed-off-by: Jonathan Bell <jonathan@raspberrypi.com>
> Co-developed-by: Keita Aihara <keita.aihara@sony.com>
> Signed-off-by: Keita Aihara <keita.aihara@sony.com>
Reviewed-by: Avri Altman <avri.altman@wdc.com>
