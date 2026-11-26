Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=216.71.154.88
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795702290;
	b=XXbkKhXu3Kezf/Hw67vEm5ajxAbZwPTXP6jHkM8ei9gFFEfwbLb0GZygjMISmT658t5S
	 ceRB8Xlml1eZ4yKoVP17119tTa5JBzYREWwBW6LXLOxgO5mvpta0GyjwbWtJW4jmRbQrX
	 llNxyx9qy124YutvCTfR4P/FxHWwNQDclAdax1+2xL0POqMDJivVqSga5HGr6jVRl/B6H
	 LzAvh54LJvGQOe7wfKzyxeeHuTmpaErjUf5ga1DSHoxPNE1puAJ75JvXzG126IfYyrn/0
	 0j+1Ys5aTvED0rAU0P1NPgf7Z1xk+TtPzeZhIKa5XEzh1wAvKdBpHItFT9urBIP8P+A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795702290;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-RemoteIP:X-IronPort-MID:X-IronPort-Reputation:
	 X-IronPort-Listener:X-IronPort-SenderGroup:X-IronPort-MailFlowPolicy:
	 Received:Received:Received:From:To:Subject:Thread-Topic:Thread-Index:
	 Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-atpmessageproperties:sndkipoutbound:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=ylhBShu/7PtroFvqxDoHkR/Lgb3RjDKO4pFumFpFYaU=;
	b=C1QvqDxuaNZiX2zIFkaySsMm1m2ZaSr5giqx+l8nLlxPj+d1CMcsfnTRLLMDA/Z9o+p5
	 vhArlAqyLIkPKGYG3gVNH0+kkI3LtuzRN5DyGrbZgY8v8RX2PfzArUFjSU668qkBxrpo8
	 WUpivJQ62bz+bdTZMIzGkEpOivjR9gt7uGs6rAdm4Kddz2WEo1/4Rh+o19JU2k6gJfgZI
	 bIgXiFK1K1atwSYdkLtCivR6Q6MW4d7e0FUyO4V8bMNLo4oLlCb306g/GyiU6Tll9cgnC
	 vZ6HyFwqJgJ74ZuguUKC3u/5f7anru++uiE512ZkqQZZFPAKIwIduUs31bluw0NxWgA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sandisk.com;
	spf=pass smtp.mailfrom=sandisk.com;
	dkim=pass header.d=sandisk.com header.i=@sandisk.com header.a=rsa-sha256 header.s=dkimnew.sandisk.com header.b=cXgvBOxb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=216.71.154.88
Received: from esa.hc6817-7.iphmx.com (esa.hc6817-7.iphmx.com [216.71.154.88])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBBDF606A31C
	for <linux-mmc@vger.kernel.org>; Thu, 26 Nov 2026 14:11:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CBBDF606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sandisk.com header.i=@sandisk.com header.a=rsa-sha256 header.s=dkimnew.sandisk.com header.b=cXgvBOxb
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkimnew.sandisk.com; t=1795702298; x=1827238298;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=IaDEMQas3jMCoZZqiYG+Y360QUyEHD6++2wF2tR7/sY=;
  b=cXgvBOxbwsGDSf9IJIOvsUyiQgE3IMKsDCVjsTm4A+pbjlrvBe1Gd3H0
   kz6wuj10eNl8eHR8PyiPd7JxGzLZbmH+1HjIfGq7vUwlXV3occyHFTYF4
   L422NuWQdhJHqoxzX7t/A7pY3+UDJPqnWDU9RSWaoFws6YSRprOPtuEAm
   JA/PVMBuKaNBvpf9oAXzGtRdWJpqtH1wV63EGGjbqIgC2LZjQwo+1NH8G
   Vbx4gaGSXXr8P5/ujoTVXNMoRHVe0dfH6UKx18kfFRDp+N4SCALsJu7Y1
   XC5dx4ODpWEqxErNtoCA//xnLwBGXP2iTiN/k/1rzv+vD3kAEOUCT4zGM
   A==;
X-CSE-ConnectionGUID: YMjmVIfVRR+eva0zwuRw8g==
X-CSE-MsgGUID: uIrRCYrwS26XMZ44j/hqCg==
X-IronPort-RemoteIP: 40.107.201.126
X-IronPort-MID: 35150869
X-IronPort-Reputation: None
X-IronPort-Listener: OutgoingMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
Received: from mail-northcentralusazon11023126.outbound.protection.outlook.com (HELO CH4PR04CU002.outbound.protection.outlook.com) ([40.107.201.126])
  by ob1.hc6817-7.iphmx.com with ESMTP; 26 Nov 2026 06:11:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QVFFsJ3f2CK5+jT6y6nCOPR0skFya1aJTr82VRM7xwmmCd5wHaAAP6xvXU9WyHyrrCkTT1InY9crxWtO4r3hGqgYSmbj7Umu+eRHdEB4/qyUUxsrkZXk3djMja90UfSiBwqlczRLnqAuLDp/Zu9+CBRlu+5rnMmw6nlNjC8q+xQkm+YDpHPtJKOzGdFnWtig5/MJjJVu1zQqx4wab88lllD6GmTkMOL6XRgB3lOVhHKDFXv24kY1c1+jlqD5EoizlTnYARuWhMUePoaxzW/1NR8dBesTeSZ4UYzkTR7n1QhRyf55XurNR/hkISwCjlhQFI9H8OXPVAi35qKGYlUsYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ylhBShu/7PtroFvqxDoHkR/Lgb3RjDKO4pFumFpFYaU=;
 b=DT0h2z7Bqaw5JxvPB8mqUIbhGcbrfkwxFlXAVd8Fdcdd2UE/tolOu8rKmhXQd4VAvf/0Mz4MDG1piZoVnnoM4yLmeJHnUoar037KP83D0p6kyuGvAbab6cpFYvHWQ6rQghPSxSawXyIkTiYzQouPXHCst/AvWwbTjL9EsbYuujpUkpuWGly97dd9TX7+xhb70BHLI4UYRWibNQ4a981GEly6EpOasW4jp8kOMqO0wlfGghXa1zOOnuiFPjOn5zLcOFRam5IwDgD24DrBH/9XUYS689hsjeWXWK3jzUIdcRlrZQdBjTcWtBWpw4sI0pybPzpj9YzTMs854HlDLKGOSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sandisk.com; dmarc=pass action=none header.from=sandisk.com;
 dkim=pass header.d=sandisk.com; arc=none
Received: from IA4PR16MB520939.namprd16.prod.outlook.com
 (2603:10b6:207:144::15) by DS0PR16MB501054.namprd16.prod.outlook.com
 (2603:10b6:8:42f::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 14:11:21 +0000
Received: from IA4PR16MB520939.namprd16.prod.outlook.com
 ([fe80::5b79:943f:ee09:cc1c]) by IA4PR16MB520939.namprd16.prod.outlook.com
 ([fe80::5b79:943f:ee09:cc1c%5]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 14:11:21 +0000
From: Avri Altman <Avri.Altman@sandisk.com>
To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>, "ulfh@kernel.org"
	<ulfh@kernel.org>, "shawn.lin@rock-chips.com" <shawn.lin@rock-chips.com>,
	"ao.sun@transsion.com" <ao.sun@transsion.com>, "hemanth.selam@gmail.com"
	<hemanth.selam@gmail.com>, "b-liu@ti.com" <b-liu@ti.com>,
	"raoxu@uniontech.com" <raoxu@uniontech.com>, "axboe@kernel.dk"
	<axboe@kernel.dk>, "ziniu.wang_1@nxp.com" <ziniu.wang_1@nxp.com>,
	"mateusz.nowicki@posteo.net" <mateusz.nowicki@posteo.net>,
	"andreiw@motorola.com" <andreiw@motorola.com>, "cjb@laptop.org"
	<cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: RE: [PATCH 1/2] mmc: block: Limit the CMD23 block count on eMMC
Thread-Topic: [PATCH 1/2] mmc: block: Limit the CMD23 block count on eMMC
Thread-Index: AQHdfNjQ2lcNgjZU2UKWLmSU8WLdS7dAZZ1g
Date: Thu, 26 Nov 2026 14:11:21 +0000
Message-ID:
 <IA4PR16MB520939C986E7E2B8EBDC24150BE5422@IA4PR16MB520939.namprd16.prod.outlook.com>
References: <20261125123015.3999-1-ovidiu.panait.rb@renesas.com>
 <20261125123015.3999-2-ovidiu.panait.rb@renesas.com>
In-Reply-To: <20261125123015.3999-2-ovidiu.panait.rb@renesas.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sandisk.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA4PR16MB520939:EE_|DS0PR16MB501054:EE_
x-ms-office365-filtering-correlation-id: 8eb71765-eae1-4fff-9428-08df4bc725b3
x-ms-exchange-atpmessageproperties: SA
sndkipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|4143699003|261009223027099003|18002099003|55112099003|22082099003|921020|10067099003|261102123227099003|56012099006|11063799006|38070700021|261026140227099003|261026121527099003|261022105027099003|261028144727099003|261021121427099003;
x-microsoft-antispam-message-info:
 vGdPTSK7vM/kesp4+rJXjZjnKfK4RaGz+32SzzAVAGhpH6Xa51dqXZuAsgN3SiHbkz+ycI7wQ3wlgifBfB6GH/vQ8eq5juFyCyrIrN81kkmMujHPzdtcN4PY4utY1ZGSrEFAS4rCKGNFC9hnXAFNC2EqXcjtmTFbJ2WSFEu4S8p2FwrFRaI+D0NwxT0e4TMABMba9Ku3Rzo5s7eataGH5I4hDgtha9cc9HPGRZwKVWtShdX3j1b+06Z79WgjLud53u23XSw7GUsmQC+GouH7yK73PvE1meJ6Bzj+LLTj7fQ04ny9wHmbZYrbFUXk93Dd1hIzwBYSNyAFm0LeO1IhR7T9EAaNb8HbmI4arsnIVnrc3vNk11/tUAfl6neupdGCmvvRY4pFSC89jR/xAg1xSoXfC4oGSmRVd/043GTiJ59gNFNyKI5HCs3VjR0w7p2caP6gBRs2j1bkFKCOOjBFeiEEBxqyXHNJwrZW+nzRKWSy7qGktH3eCVmEqB6JkLKMpsO5EUIlQxMKheLLTJEPVBok0S5Nifi98y1f276R0wjIDl+H7KoRKJ4Jn2DIT8PT5cw4YtlBRUWcY7uYiBhnznWcieQRzfOR3yd5CDsyxH+LciEfnkjEegyrFnIIgdM/LfWY/y7+Lgp3xPxtvw1lzrMTKbvKLxVY6tw+TBf2y1eGgVRcnrfwSR93hBk2yeXi7AR5Nr5Qbi+LidJU/l66LMcPqr3JoNZtSoElw6dByXWPsvJMA2xctq4uKJvCqEFz
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR16MB520939.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(4143699003)(261009223027099003)(18002099003)(55112099003)(22082099003)(921020)(10067099003)(261102123227099003)(56012099006)(11063799006)(38070700021)(261026140227099003)(261026121527099003)(261022105027099003)(261028144727099003)(261021121427099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?N9ND0+8S6lreQFFJoJaXuxGyR75CBxbLr/lA0aQlf8aMH1YceWnKTr2ZlfQs?=
 =?us-ascii?Q?wXau8lqCT8mcnU6lVStIDxeGlFLwFlK8IqO7KnHo3Ba85+mochYoQcc4SOzb?=
 =?us-ascii?Q?FmZI9DL01f5CA1Q33ST7kvxmyDOsEPggxv9EbyP6C21KIE61Uc4dimJle5Xa?=
 =?us-ascii?Q?G/HPPL5JhtzQtga6JYg7O0wLADqJfeQeqiE9Nbt3fFzniPeBDLkR40sqfzXb?=
 =?us-ascii?Q?zfCthsxqlJ/3GKkLwk6Y/u7n8lvdcU49gxKvMuOr4aiWgHsHCAsFqnSEKL3l?=
 =?us-ascii?Q?umQwDwQA5O8vvNSJWrjYUZEo2PVv//JzPflzVQUR27hCrnFhRiR3/V1u/b0l?=
 =?us-ascii?Q?t8iQ33x3HTN0IviMFTSaxJO43TfIriai/rgd/uLiBQP8J9X1rZZqlItsXHNC?=
 =?us-ascii?Q?C34g4mY2glwYMIfnq/U+KrOJRB5/WulJZWiNrEtdKeit7WiVB8SQPWNFQ8dR?=
 =?us-ascii?Q?20ETqoyb+SAGgHRlrvBYsSxHXIY1o+MU2x5AldeBpoLor3FjMyr+V7OZQA6U?=
 =?us-ascii?Q?xGNx8Czjj9l53pE1s1cQTFaBIJ+zg8xkQzMQfTsDC/Jp7hophOeTz/js75Oc?=
 =?us-ascii?Q?JLUynWiQPNZYNiG+mpBhZmz7uADZnolwiPGGybMwVSbRwpj99dRQP9L7bS/I?=
 =?us-ascii?Q?6jmftwIouo+uiLC7IlQzyePUAihL18d7EGwagN1b8udNV6rLRn02SVBloAdP?=
 =?us-ascii?Q?/AuQBaHWKWyT1Eva56YtYRvc+0+W/LRwEdwB2IQ2kJK0/8vQNV9UTOGS8xj5?=
 =?us-ascii?Q?7AgI5SrqHshOBmowTybXzSienh2J4qyd4Y7Z2FLKJLqhrh3trvvq2ZmUTOBQ?=
 =?us-ascii?Q?+u5nje9taOWwXdk44LsYe29ZDswiMUOwN5jeW4wJ1n8BYb8/ag6IcbzIUq7l?=
 =?us-ascii?Q?uFYV+cqZAAvpvFxoCOtHMRF1e/cOwtrm8WVpQybmj87dKyZvTiOwvFiaHab/?=
 =?us-ascii?Q?x6ilGBKfXtW7ticMd/f8PDiGGPhxcMJamESeuuiVhEsE6ZLXzugnAlkiTv7W?=
 =?us-ascii?Q?wVQXzcS66Ue0a3xKIEXGMk1Ev9NoaJtIfs+/lGjCsPFABCHaoJuYXxEWo0XG?=
 =?us-ascii?Q?IAfYTTbswuzCM/+H0wWheZAW9anBLaA5IkHyMcY840QckdtwMkxwFVlXvxfD?=
 =?us-ascii?Q?nZ9CmWMv/950GP6FPId0ga30du3NJ/fTDZ4f0Im0ypK+A+24K0HEuh4BBE+T?=
 =?us-ascii?Q?9jiGO3s4B1QFR781HgBun0ewMPwJMCE1ythN2Quxll2e/u96HJvD8qBnhI+S?=
 =?us-ascii?Q?sqN7vjiD55bWXZu/NQs4Dup8SJftjsaINmoChH7yOP1wjwMeQIWTuRx8vyiO?=
 =?us-ascii?Q?QXdr1T8FMJq8NPzDJdJFabAbitkxx4zqEm1lfncLxjoAt65C1+9PgAwP9vbm?=
 =?us-ascii?Q?3hjzOrN6oYQOSjkDgg7mAccb7OOcACXDQnuKi+SVDZa4lS9CK6i4qAp62k68?=
 =?us-ascii?Q?+Vr95/JzLG2X7VDs3Dy0GU9HAsxtPaa6CxbflT9mDtkmuzVOrZlF25bD7WbN?=
 =?us-ascii?Q?yxmdBVOYcoKFgRd8+ZIAoILE6sTb+OC7n8X6XaPU1OuQhAcBNFFR/S7NvXV+?=
 =?us-ascii?Q?KhPLE0Fj4iXM82J0Gyqpvvs9wLDfmED1li/Ortv8oxlgdDk3fyDWc+UO7Qr2?=
 =?us-ascii?Q?xXDMuqQyT+9hISHGy2jUV+8sYAZ1QzCkOpTIR0+Wd4SBdu41qx+SeC8/hPU6?=
 =?us-ascii?Q?9xQOEpWxLBDxKLnXBgVbgp3NbV6rsfPlgmWoBnuQihUsvTYOb+QD4PczNHsf?=
 =?us-ascii?Q?67FlLo4Zlw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	lRhsDvfQNFytJ+eVZqXe2LI3vtHt4ptrGThok/cluOl9QlxbiHNcOOrHQjAEVDWCyE/LPMzfsmCdmsgI8kc9HkuvBgi7OgRje1ZtQLglmw9IQQwlxavSiQUr9bAB1rywyOob4lsbcVq/0cLv9iWUsZgWSDHYC83d0mhoyi9oImHVeEpwroTy+BpdOM4J8MlYHYdLP0oMpFUlI0GsKFVthN4OSqmgJHG4QAO4sieqqk0XDsWW9TdEzyIV6ORzXv7onjq1Uq0IrXBOQDG2aLgeirnFPxZSWyIuCL5VMoYgMLsms4f09aadz0CqZikSCkrpdLKe96Nf8aeipQM9fd72DQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zYj0OUHH68FmpAq8fgg+GnA3uiltJijzXoVJwPT/JxoJnk9V1uoove2Mc3J3NMvzbyqJTcAn02t57T69O7650Yi9ddZURwS/YkFq6iIVvMBTljoYBeWX4jyw/LildqmWvZUTj+HnYsMj7UODDWM5PPRL1rh4YjB3WN3GZPikjs6QpFBpyFUgGPuadFOlFUnC5s8MuNxm2CWZIs016Pq0m4YQm1lyNForFnDygjRJ/34i4S2kVU+EgCdAsZuWUeqVRxKEPfOue8kMeefK/DNemrT3yVuHlWuhAnTF6wQ2delq/qrzhCb8AUtSR7QVpyDuQDOlnkkATJ56fzTIDdm0UZ+PEb/HtsnSQ6FFNe2QsrNZWmi21Iv1h73K6Q4DijXgbT+zv5y+llem1tm+S5PQtmtPoQPpFEuTDRsSD1Iw5SKU7RtQhcDjKm5N7V26OcCpqWqJz8P7j49oqW4OlhXJkpCn5lOBimEZwVQnRh5mUbe/UWJ4q1aYM24g1Prg23oB8cMbveNS+nALsMlpxJCs9Ak4gFTi+9Jw75W/KOJg3LKIasE3PhZQYbNYgudF4LZhRnI+BSYZauIVuDeg9ZEPvom4VaHhVVRsbIIlCpI5WZ/pp9WkWSTFjXX8HqdJAq29p81e3pvrUQ1bFOR4vMpHcg==
X-OriginatorOrg: sandisk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA4PR16MB520939.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eb71765-eae1-4fff-9428-08df4bc725b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2026 14:11:21.2691
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ffe0ff2-35d0-407e-a107-79fc32e84ec4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LRVSOuULfcQuqxKgIDwHsJY2borip1ud9TiL6z2vqsMBFmZI6hm7WhCRnqi7DxaWtr0FARe/+tl7xgsbaBt4Ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR16MB501054

> On the Renesas RZ/V2N platform, a 32 MiB write to eMMC fails with:
>=20
>   mmc0: Card stuck being busy! __mmc_poll_for_busy
>=20
> For eMMC, CMD23 only has 16 bits for the block count, while a 32 MiB requ=
est is
> 65536 blocks, which doesn't fit inside 16 bits. Currently, the driver doe=
s not check
> this and puts the full block count into the argument.
>=20
> To fix this, limit the number of blocks per request to what CMD23 can sen=
d. Round
> down to the physical block size so that the split stays aligned on eMMCs =
with 4
> KiB sectors.
>=20
> Fixes: d0c97cfb81eb ("mmc: core: Use CMD23 for multiblock transfers when =
we
> can.")
> Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Maybe also:
Cc: stable@vger.kernel.org

and a nit below.
Reviewed-by: Avri Altman <avri.altman@sandisk.com>

> ---
>  drivers/mmc/core/block.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>=20
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c index
> a02bb2fee874..be092d6291bb 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -1383,6 +1383,15 @@ static void mmc_blk_eval_resp_error(struct
> mmc_blk_request *brq)
>         }
>  }
>=20
> +static unsigned int mmc_blk_sbc_max_blocks(struct mmc_queue *mq) {
> +       if (!mmc_card_mmc(mq->card))
> +               return UINT_MAX;
> +
> +       return round_down(U16_MAX,
> +                         queue_physical_block_size(mq->queue) >>
> +SECTOR_SHIFT); }
> +
>  static void mmc_blk_data_prep(struct mmc_queue *mq, struct mmc_queue_req
> *mqrq,
>                               int recovery_mode, bool *do_rel_wr_p,
>                               bool *do_data_tag_p) @@ -1441,6 +1450,10 @@=
 static void
> mmc_blk_data_prep(struct mmc_queue *mq, struct mmc_queue_req *mqrq,
>         if (brq->data.blocks > card->host->max_blk_count)
>                 brq->data.blocks =3D card->host->max_blk_count;
>=20
> +       if ((md->flags & MMC_BLK_CMD23) &&
> +           brq->data.blocks > mmc_blk_sbc_max_blocks(mq))
Nit: A local max_blocks variable would make the logic clearer and compute t=
he limit once

Thanks,
Avri
> +               brq->data.blocks =3D mmc_blk_sbc_max_blocks(mq);
> +
>         if (brq->data.blocks > 1) {
>                 /*
>                  * Some SD cards in SPI mode return a CRC error or even l=
ock up
> --
> 2.34.1

