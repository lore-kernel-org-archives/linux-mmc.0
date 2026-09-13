Received: from esa.hc6817-7.iphmx.com (esa.hc6817-7.iphmx.com [216.71.154.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801412C3261
	for <linux-mmc@vger.kernel.org>; Sun, 13 Sep 2026 07:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789284275; cv=fail; b=IYcobWKTwMbb0z2m6E5UvhstmO3pVVjjbGaqFP3Fx3Qp0Pe5chb6QfPYmlVrrMWGQWat4ybO1gxoyfShaWo5c80l6X3P2G/GQ2y0oV4JraQ12dOGWg4vlFyNZ1CqeHYxXSNaWgpXDdZwh+b74VG9jBjQWejfkoHXgEn4siJh9GA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789284275; c=relaxed/simple;
	bh=jUrMk6AeEyTDXcC4XVZaly/kw7FO+2fhFFkzaLido7Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sJAOF44vUkKinTFI1wmonTPqF18zNn/7SjgXBAqyWrR0ftCd5m+cSXz0+KR8uCIRpP3HESQ3MOLmOKEFd/PMeAADFIpqNenbs1GqakWiSWx7XVuIBOJhCEaqUMj3d3J5gCN0MUomyysTJi54iCurEX2g4Kyn7h1PFre3fV+mRKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=GtE3r1eD; arc=fail smtp.client-ip=216.71.154.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="GtE3r1eD"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkimnew.sandisk.com; t=1789284273; x=1820820273;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jUrMk6AeEyTDXcC4XVZaly/kw7FO+2fhFFkzaLido7Y=;
  b=GtE3r1eDumfZFZu1T81CyI6utfWwcjP5Ye9X8VoUPGyX8/JFa6nNR2Kj
   dbpJUZJC/6529dih5jhvhDldEWJbKrW/pJfA+mof33r2v+oaT7HSlAeBf
   KNkzVU/BK3V/xa11MS6qYUib3d+wH3m+tFbhiSadf4Gb88i7uh1WytCFG
   ZqgRcdGbQaXPPVbsI+Z5i7UoosRJvwyVEnnLWngplCLkQg9nMBxd2gqm9
   rsSHPxJ/LcX748M3g5/Wfp1NOq9/eqy4wigjUDG/YiBllwTG7k6ElqZuL
   e8BfcQ0pZ/5m5hQHecRW57dNag5RAcToOfaEXRQPEwkHG/kz/FsosDYwC
   g==;
X-CSE-ConnectionGUID: WYJd2Gp8RTeZ9sMKNGgphA==
X-CSE-MsgGUID: xU+EUrn/TCKPGQbI+b7RDQ==
X-IronPort-RemoteIP: 52.101.193.82
X-IronPort-MID: 30145918
X-IronPort-Reputation: None
X-IronPort-Listener: OutgoingMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
Received: from mail-northcentralusazon11020082.outbound.protection.outlook.com (HELO CH1PR05CU001.outbound.protection.outlook.com) ([52.101.193.82])
  by ob1.hc6817-7.iphmx.com with ESMTP; 13 Sep 2026 00:24:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bk5CG0MVCIasPlamO2KM27KwrqgNK+YEgCis53g4o8w/y8pqVRK4wjgm/viUlq/G/Dar0PnThNe2RDmSuhzguzcJq7MwjwQWqP4R3XrevLXXijmgC/qSjYhtfviIk3c97aY7ZtS2tJnNb1fLPG5HGeXnzEsrmt9ElMeBuK6SPo1gqabUeVDW8GZDwf7+1eWLDpSMd/e3nWi+JaUyAhZ0LK9tIGD4FujlDCND2+LOez98nj7cZrVoayNeUnkQ4HB0vWEWbgkI+RW7IxxUGNhAtq8q/dF6Z2UxyRqwSa5mpwX0opJEaoVn6IhyCZXuenyxXMfLMNTCUTrvOkNAmBFYKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jFJl1vYfYgyNQuB+5K3ZZy6qZ9h0Z6urORZAiJZy+mE=;
 b=gGznjKyOLn9Eyy/PGAl0a22zg3W8edBdIOa1Pb2bzb/W2lLBwprR2rKyDNf83ZJORvTM5L2iiTx2LXzXBTSGhxae3E7pfkvd9ajXhBdUQK66H8t6FcGKBQrPYsOgDpCEI7IJd5fzalgRX7sJhZZYENwQ58saGdhm9LMGZoQ2eXkQS22QxCQX59HuydDSnGNlrKfUStN5B4cj/o/6xsVoZ4nmEqtb1WcuDPDiQd0AOmDPQ4HoTmGb1Spw+b/WR23jCTpQcvRuLkMC+3+jz2lJ3C3jXWkt/kX3GamCBubkUD4wgTk7pVia2vwmX6mUety8qM3HsgeMQTOzIcpoh4nTqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sandisk.com; dmarc=pass action=none header.from=sandisk.com;
 dkim=pass header.d=sandisk.com; arc=none
Received: from BL3PR16MB4473.namprd16.prod.outlook.com (2603:10b6:208:344::6)
 by CH3PR16MB6447.namprd16.prod.outlook.com (2603:10b6:610:1de::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.11; Sun, 13 Sep
 2026 07:24:22 +0000
Received: from BL3PR16MB4473.namprd16.prod.outlook.com
 ([fe80::f768:136d:184a:ebb6]) by BL3PR16MB4473.namprd16.prod.outlook.com
 ([fe80::f768:136d:184a:ebb6%4]) with mapi id 15.21.0406.007; Sun, 13 Sep 2026
 07:24:20 +0000
From: Avri Altman <Avri.Altman@sandisk.com>
To: Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson <ulfh@kernel.org>
CC: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Shawn Lin
	<shawn.lin@linux.dev>, Johannes Berg <johannes@sipsolutions.net>
Subject: RE: [RFC PATCH 0/4] Add SDIO userspace passthrough support (kernel
 cdev + mmc-utils)
Thread-Topic: [RFC PATCH 0/4] Add SDIO userspace passthrough support (kernel
 cdev + mmc-utils)
Thread-Index: AQHdQbks9s71DPzmU0CbuZ6zuxKwjbbMGlYg
Date: Sun, 13 Sep 2026 07:24:20 +0000
Message-ID:
 <BL3PR16MB44734321BBE9FC4EB9EC91C7E5BC2@BL3PR16MB4473.namprd16.prod.outlook.com>
References: <1789109096-196082-1-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1789109096-196082-1-git-send-email-shawn.lin@rock-chips.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sandisk.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR16MB4473:EE_|CH3PR16MB6447:EE_
x-ms-office365-filtering-correlation-id: c22ee929-ffbf-4509-9e71-08df1168073c
x-ms-exchange-atpmessageproperties: SA
sndkipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|23010399003|1800799024|366016|376014|38070700021|56012099006|11063799006|10067099003|55112099003|22082099003|18002099003|6133799003|3023799007;
x-microsoft-antispam-message-info:
 baRUOlsqXMR+cXhp82VRa/Z1m7oZ3sbwtABWpnoyEb7wysnobKWt53TekxE3yMU7Vzr7cBmVEGadcmShX6DZcnbHHmvMw7yx5T5EqQClv88tIIru7WrzuSU+j5DYhnBvaUikDTRk8GPtu6RRi3SUQA8WRQZcta6VPeJlbWmfCtRntXsjsR73FWtd/PWhOf0OE8t1Ruxlf54CWUvvOape1q+V2nDZ8M1YSU/BeVFqkq4damXJuT/3a3rN6tCYBb0qLNmjVnaEC7O+Nj1Rb48bdNy5g3JIVqEVLweZnpM+IiYPNRogFt3f6G6mhxf9rCRl7RygHv3BO9glOI1Y4CWJmwufMgEqEFcqoWJ8rKONaU+SoLUEkFFW9zUwEqPJSUNWamv8xZYg1PEu74O+Ie0yWCBmSPua5PMGldsddZIs0ThxFP41P2OaWuX3X2DdA8WjV8oFOJJEdrztPLoBe8M33NPPNKw974CJzwDNzFgHmD2de//uodltmB6QFVkkz80m1jJT3EDtoTdTcaFEPFe5ygaMmaz5E0iUi45PHMyBbZO5KkW/bYKiG7U833ezLeKgtfQg+DzUcdPemqZK9n1M6MjucZ1cH1+EK7Unk7ZMTJFqyfAGBHUm6F9gfn4YRM5ruGXJiah7a7iq9zamV5OqJK9BmN2hPmqU2Kh+Kc5tJDbDfqK5ljsCrt+cFYBhvCd91N0hzVAvp38GqxBk4H1hRNLeAI6hqNOjlRXbXRrIQE8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR16MB4473.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(1800799024)(366016)(376014)(38070700021)(56012099006)(11063799006)(10067099003)(55112099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?foN8Dk5kTjDk6Dwxzc80o9JsY4mIHbhcHKKYTgsYkqyYFttEwYqplHSSuuB7?=
 =?us-ascii?Q?tdWWrgIGRnNPI6UTTC4bUJ1AMUAVxY5wujC90xJyZsAtjjqgFYLoIUW4Qjwm?=
 =?us-ascii?Q?9xsZOIi5QRBP0sZ8vyOj9ECFNkf83mvLvY2KCQtg10fy6jxM0cA8ALDAgq3n?=
 =?us-ascii?Q?913W74OtoXgwjNH470HkABJgk/7uCBBcnpFOmsq+pNiOyztVkpZ1jjk2DPy7?=
 =?us-ascii?Q?QnfJ96Zp4LUannVtvCd4BOatb+7LJnF+QBtiOYN0pMihhtUa20y3uw3uzAvz?=
 =?us-ascii?Q?dWWAKPCXT0pfNDUaIlUG1GD1WFtn3lH/Itvidxxn/3bhc/VTei2eZe0IZZts?=
 =?us-ascii?Q?yy48U0oeFkGG72VPlG7896e2Nk1dwCkoYpUrd4uzJjUvnRRGddy75O/zWDt4?=
 =?us-ascii?Q?UGn7UyMWAQMfSj4wqifFAYPZGnxTD9/3KBnH1pTY8tB0CnUYttP2RvSzM7se?=
 =?us-ascii?Q?q9kavB1ZUZMvb8OL/THmSknh86M4qd47g5s0LSmpE6SJurc/tzhaSWhpQIJk?=
 =?us-ascii?Q?DXzGF7MgQ3YrNF3xp7ay7Ys+La4BnQqdWmzJpFZs4evTJcpNuONKly8eNYiz?=
 =?us-ascii?Q?gGA0UhJUw3vUEm5wBuvz51WvtMNPgosfyVNoQ3BmaWxB7iiddR6WWHcBHT6k?=
 =?us-ascii?Q?B7flIkkHDTf62uogru1ISM7YNfmn9Wqv01xMcE6N6MkaalibaoQrRW4ZIhik?=
 =?us-ascii?Q?FzshNdt8HuOha8PvXTVxgg4ZiksfkG1/F6kpGtuFA2nh9YBLbApD9X0rOT03?=
 =?us-ascii?Q?RllIPQuw6Y29YceHo2HUuLh7MMeqSxBICt/5Jdqp50EYJ721g+eWUk/BB8TL?=
 =?us-ascii?Q?oi/zUAe/7yNLbA3iPnAvevpuoD2TQmI2kUApSsc2Xy+P3WP0C87KkjuYtlFK?=
 =?us-ascii?Q?f3X2XWmd+pBDtDg614meQ8zBQZ8u+sgMtWYu4YEKbgbPzuZ0aSKkkyBC+TGl?=
 =?us-ascii?Q?+gg8NoS2ds32MG9vo3O5vVwD/qn4mN71It1nyyNGUHQDmJSH04hyNj7Y+VZ+?=
 =?us-ascii?Q?PopJXs2F2TXvPXBquRhY0q+GjjkA3ItBpQJgqf8jN5xv8ZvlmraA6Z+cAI7V?=
 =?us-ascii?Q?rWB0yRc674G65YZyaoC5l62ZpVHl8AAfMQelLecnJrucOo9X5dAAoE1Ywyfs?=
 =?us-ascii?Q?TMAKn86wNuf6bMKgr+OXubn5lDVwc8bZwla4JkJji+EBPKcm+E4T6o4CU2dF?=
 =?us-ascii?Q?QqVcUbLK/tZ7d+C1oh1bz1DdNoJ2o8lBQKoi0NcYSoYA6h+AS7fx5jdkMbbZ?=
 =?us-ascii?Q?dHs8YXLY/Lm7gGRVUPbiCcuP0zFY1SNoQAisXqDbxO8UgK7DlEOcL93ovVqB?=
 =?us-ascii?Q?/1lc1/c6kHGxai059Rsxk0PszCTPksmb1QbH96HCsUsKIP0fUbXXQ7FoNLOV?=
 =?us-ascii?Q?rhsrks8gPp+yExjLKptLv6aaWpnJJd2WzHzSMf3vYX6x/sZeb11Mq2/jL3at?=
 =?us-ascii?Q?A7GRvIGDSLQaq5XgbQmBIGAyXoLB1PID0ub51Cnfga521Rwv6wZweZa3tkDv?=
 =?us-ascii?Q?9tQN0/bySeAUYH22PUv7hyRwGy+JWquSQFhPUqkQ9EGZ0Ovq7SsXvv9NhvV9?=
 =?us-ascii?Q?bZ0vRlAQtlx0ou8q8ssaLRGttIbZUixQFUVncQ+7wrmDaqEmcmWQgMRkOFwk?=
 =?us-ascii?Q?j8ab3TorhTbjSk0q7ZZv9nZtFO1qiS79LQbM44yrA6WK3cv31p9h/mNe4rUC?=
 =?us-ascii?Q?xKu6lOa6RRRgB6aUpwEkWvK4ZP6IrInbgUt3510msLDPOXhzK3TzW3FS8XjS?=
 =?us-ascii?Q?HxHv/44tqhMGiO3qm87pPrmLnY1tK/wwNR9LnygNOgoWqAQTzvSJfJRex2k4?=
x-ms-exchange-antispam-messagedata-1: +pdPgbq30bpDsA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	fETwNMHPlJV1mBbCGxaiOwwuVW2vw5ywGBW5CP+EZCfNV28n/nptt/3c/RsEw/+QMS7wyx7NNnJFmvOA5YBJfwfPE5GuhZF/j6jwkbGT/gkPdFMxldZ8CHbx9skAbcapfMFTIarutnYHrZnwYiJ4gy2BewpFtja4kHv9nQ5ZYv7L/AnGHRuUyUppaeGW3/NvCr2yoduAKwD6VMOD0aon12vzxSJuACo52+Wi+xXnTpBRvR+N7BwtxSUCIO5NMnxh9nItpig353jCphllHCCjDVm938tkBZfG7HfMJCYj0vLwB5FiSa7ILNoc7OXetODhdQOR3OmL4NsdoWYJVIfODA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+1qdY8NeT1Nh8I0HUb2d6MAIIaYqxMoQnjG8hIoF1JMMYqC680jnu3qPKt5zD7nMP9DcNFQ9CyorL/7UJYPG80kGICMDZiWX+VlqphIYLiL0GIqe63ItVfg101HLG97bet1TVttoW1QfCmzLPapqXpMEvQFaFEYMLApdZNxDYxtSHrjf0Cq8+omKO9Ny5tLYFsAZL8PFPqn/aVHB4zeC29sPzczEZWwsA6ZW7E+YU6uAKRtZi7mK02izUvJM3QDgLe8uhLEiW3K3nS57UKIhLVz0gPGDbdvFNpCsIkXwRJWI6igG4OQSU2dob/LLwPsjYK2FId3fpziCumMQQYy9TbJicn1waBNfe197BW4jZCkS+1ahMfynSwQ+zUxefDXy242ABaNLV7wcZmUFS0aCBnWhnbDUzYy8XBgChleGMwYI8k+0DxWoJ6dar2Vk20dfhVqP387seMvBYeW95ywri8pLGrrBgiGbREKQbUBftGLmIwvL9gbFdAOdB0NbHUy7urQ8xoPsmzgiPWoz7o/wznE83dOZ3MeHiP3h+PWGispRcM1ey020qHbyo/A5dSJTbQpE7qj1lm36tZex3oW41RrV9EmJZ8zdYGBjgZSHCV/cTCRJ+ken9+w/XYTgyEmVGW5ibTunONQ/q/yEpZ16kQ==
X-OriginatorOrg: sandisk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR16MB4473.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c22ee929-ffbf-4509-9e71-08df1168073c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2026 07:24:20.5465
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ffe0ff2-35d0-407e-a107-79fc32e84ec4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8KxbrKoU3wizX/7ReDIaZMUWqWfhjatQqJ55hrRn7N5Ug8GxTlJHUloCgPU7/k+lZMyMnz2qbWO3zDHhQa2Gfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR16MB6447

> From: Shawn Lin <shawn.lin@linux.dev>
>=20
> Hi Ulf
>=20
> This RFC series adds raw userspace access to the SDIO register space, spa=
nning
> two projects and therefore threaded into a single series:
>=20
>   - Patch 1 (kernel tree): a passthrough character device exposing
>     CMD52/CMD53 to userspace for every SDIO function.
>=20
>   - Patches 2-4 (mmc-utils tree): SDIO enumeration in 'mmc list'
>     plus 'mmc sdio' commands using the new interface, i.e. the first
>     userspace consumer of the kernel patch.
>=20
> They are sent together so the kernel UAPI and its user can be reviewed as=
 a
> whole. If you prefer, I am happy to split them into independent threads p=
er
> project.
>=20
> =3D=3D=3D Motivation =3D=3D=3D
>=20
> SDIO cards are normally driven by function drivers (brcmfmac, mwifiex,
> rtw88_8723bs, ...), but bring-up, debugging and factory test frequently n=
eed
> to poke the SDIO register space directly:
> CCCR/FBR in function 0, or vendor registers before any function driver is
> bound, and some deployments, notably lightweight IoT boards, want to
> handle the SDIO function entirely from userspace.
> Today the only way is to write a tiny kernel driver per device.
>=20
> eMMC and SD already have userspace tooling in mmc-utils; SDIO is
> conspicuously absent from it.
>=20
> =3D=3D=3D Why not lssdio? =3D=3D=3D
>=20
> Standalone SDIO enumeration tooling already exists: the lssdio script of =
the
> sdioutils project [1], and the sdio.ids database proposed here comes from
> that very project. Still, I would rather grow mmc-utils than use lssdio, =
for two
> reasons:
>=20
>   - Userspace tooling of a subsystem is conventionally unified:
>     USB has lsusb, PCI has lspci, and MMC/SD cards are already
>     enumerated by 'mmc' from mmc-utils. SDIO devices live on the
>     same subsystem, so extending 'mmc list' is their natural home:
>     one tool, one consistent output format, one place to maintain.
>=20
>   - lssdio is a standalone perl script, and SDIO devices are mass
>     deployed in lightweight IoT/embedded systems where a perl
>     runtime costs 10-20MB of storage - a non-starter there. mmc-utils
>     is a tiny C binary already present on most boards shipping eMMC
>     or SD, so SDIO support comes essentially for free, and the
>     sdio.ids database it needs is a few KB.
+Johannes , who might be interested to comment on this as well

The kernel UAPI may need a small reference/debug client,
but that does not require making mmc-utils the home of SDIO userspace tooli=
ng.
The fact that SDIO shares the Linux MMC core and SD physical interface is n=
ot sufficient:
mmc-utils is a storage-management utility, not a generic enumerator or cont=
rol plane for every device function carried over that bus.

My main concern is the long-term scope boundary.
eMMC is a JEDEC storage specification with a relatively stable, finite mana=
gement surface,
whereas SD and SDIO are part of the actively evolving SDA specification fam=
ily and extend beyond storage into device-function domains.

Once mmc-utils starts carrying SDIO function enumeration and its own sdio.i=
ds database,
it establishes itself as the home for SDA SDIO userspace support.
That is a substantially broader commitment than a small reference client fo=
r a kernel UAPI,
and it invites further non-storage functionality as the SDA specifications =
and SDIO use cases evolve.

Thanks,
Avri
