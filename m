Received: from esa.hc6817-7.iphmx.com (esa.hc6817-7.iphmx.com [216.71.152.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB89145BE3
	for <linux-mmc@vger.kernel.org>; Sun, 17 May 2026 05:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.152.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778995146; cv=fail; b=SN3ePJ4Ba628n9gyLRvSzDxapUKBk8DBsKCPYNEvQ0UASsYdS6wptSdluFbwJMpRHDehLuQmJim8Y+aGo7hWPHE4t8rAbT2mXIux1gV6gbTlggTcpBjf9I0HS0t8/c3uUzlmF2D1PqP2HLY4SQZy6pCg7EHFuymUFC+QyDp/dfw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778995146; c=relaxed/simple;
	bh=mb8k+81uaieeSST59oQKml4Sw38ULFKDIwc+DYGrSZs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tPZYJ9QDCgDTbRy7ZWNX7E9/LsqiGoLLBtUC4RMfdrR7lOuyZmbGwatHeTXKR5vFAjKyr4e64QvYxwB5N+JQ03OESeG1ozSk4XJCduybA6TLVDwZSxxfz/TcxugbzztT9XanPDxAOEMjvX4ehSZuV4wdIT9DROow26bOsrbFEqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=OFwmdV57; arc=fail smtp.client-ip=216.71.152.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="OFwmdV57"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkimnew.sandisk.com; t=1778995144; x=1810531144;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mb8k+81uaieeSST59oQKml4Sw38ULFKDIwc+DYGrSZs=;
  b=OFwmdV57lnKcwp2RMvfJc/7JbPQDuAyDU3KfAgCOfWhSx2ws2lLup5za
   AFeHZ6IemW9swciNqPekV6a2K8Y5ktijIVu35WIlu0zK3hQgRvhJGytJP
   F+/SbxIE4c1N2oNiip21WhzXgH/5oHogjMhS+KgoNc3o0a6Sk/bS0qzYk
   OPtjGE1VLwwOO0MgqsyKmOdEYiBuaZBMSuxmMImZAVuv8x6m2DZzO/6cF
   59yr756g0Kqp1xkCoeqhn/c4CVGhi7aioFpj1Eb41+rXaEmJEWrhw/iY5
   586N3T4I4sulKidtPy7sL/IvAEeTCGeuBXgPNf2ZkJWQCkk3Cj2Va9Jkp
   g==;
X-CSE-ConnectionGUID: V8xavbjJTB6TuCGI2o8sDg==
X-CSE-MsgGUID: GTBSgYoxQ4SyzY4x9nZ9DQ==
X-IronPort-RemoteIP: 40.93.194.51
X-IronPort-MID: 22526850
X-IronPort-Reputation: None
X-IronPort-Listener: OutgoingMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
Received: from mail-southcentralusazon11011051.outbound.protection.outlook.com (HELO SN4PR0501CU005.outbound.protection.outlook.com) ([40.93.194.51])
  by ob1.hc6817-7.iphmx.com with ESMTP; 16 May 2026 22:19:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hN0KpWwcQvAflX+707ykccofnguopegjGguKHzCpF8wxmhPTcvCX5CXtGAAiGvr0Zd+rucJ7T8O6XYTcYbtoQ6GDnyFErZR/XAECiaegNaMkBmC895kUZrU/o5tFN+z0WRsfX39CJbhh/g+L78FamIeQ+SnUBKS3sD9F/GJf2XLkPFutPDsPCL1UzEWBuSHDbWbqC3GcO/biwXSG2LpflLr1re+Z6+MUyTzo56sDYn43tRrDdAr6Jd+pPGqhsuk9ClVUDwqGjFgVRa8DSSkSEpiRydDOqcJ0sjJdegWKJ29TCKZejegv1ybGbu9hF9kjkofJqvXOtf3nAMEfGMn3/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mb8k+81uaieeSST59oQKml4Sw38ULFKDIwc+DYGrSZs=;
 b=MxHFTdPEj9nmH8zyy7R80kj2PiM+4n2hKtX3mPEGO6HM5aSo0PK12/RNgrq4oHdc5YLJSiikloK2u+EGYEscb43YJmr3AJklw3hlnZ8jpQoLB4hD3GOR9mFWI1F+uciQ7P+7UHIvkIYsqC9YKvIreoFg1gulXAJ3nImQ8dcp24ULfX9PgZIP9qXXSHCxBjVmcLbU7Ax/WVuTdngqFEHdZaNcFoS5+JXTpB8yBgcqa2vVhuX25ZWYgyO++tz4lCemrtPL/SPxgLJFRcZTX1xCFz+gpQeAK3z1iK2UhbqmL17OKRx4HddwMjTHKG071jzNQCnAV5d0tWdptXFp9Go5cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sandisk.com; dmarc=pass action=none header.from=sandisk.com;
 dkim=pass header.d=sandisk.com; arc=none
Received: from DS1PR16MB6753.namprd16.prod.outlook.com (2603:10b6:8:1ec::5) by
 LV8PR16MB6282.namprd16.prod.outlook.com (2603:10b6:408:1c0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.18; Sun, 17 May
 2026 05:19:01 +0000
Received: from DS1PR16MB6753.namprd16.prod.outlook.com
 ([fe80::72d7:97b5:4539:a90]) by DS1PR16MB6753.namprd16.prod.outlook.com
 ([fe80::72d7:97b5:4539:a90%6]) with mapi id 15.21.0025.016; Sun, 17 May 2026
 05:19:01 +0000
From: Avri Altman <Avri.Altman@sandisk.com>
To: Torstein Eide <torsteine@gmail.com>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>
CC: Torstein Eide <torsteine+linux@gmail.com>
Subject: RE: [PATCH v2 1/5] mmc-utils: lsmmc: Refactor CID parsing into shared
 structs
Thread-Topic: [PATCH v2 1/5] mmc-utils: lsmmc: Refactor CID parsing into
 shared structs
Thread-Index: AQHc5LMmldQUgMVIQ0SgyvnbDMIj77YRr7pQ
Date: Sun, 17 May 2026 05:19:00 +0000
Message-ID:
 <DS1PR16MB6753D67AE4A413704D6E3264E5022@DS1PR16MB6753.namprd16.prod.outlook.com>
References: <20260515213747.1452692-1-torsteine+linux@gmail.com>
 <20260515213747.1452692-2-torsteine+linux@gmail.com>
In-Reply-To: <20260515213747.1452692-2-torsteine+linux@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sandisk.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS1PR16MB6753:EE_|LV8PR16MB6282:EE_
x-ms-office365-filtering-correlation-id: 077473c4-4a3e-4c9c-2b91-08deb3d3ce12
x-ms-exchange-atpmessageproperties: SA
sndkipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|55112099003|4143699003|11063799003|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 qVhbLzxCHxdRt21Vg2ZOQ9Kh6Ik+u8yqJTxIeUnUCn6dJMpnNxZDEoP/0E2JDRAZjlfTv8QOhxFkni5GFri9RYSM28lr36yBMZDRl6CwpDULbRHR5l6dwbx5o+Om9S9EEt1QapAvAM11hd4WtzkxvkGmPinuetMgdzwjEZFSK2Ooo7ZsZc5hWS+lUUAILY+P98DVZXgLqZC6UZgm6wsGtCN9z9k6cEC9vg5cNZeDVOs/V+cGaUosbJMUp9gpBu7UcH/rlXV1eMAuPt2rK9iW6SgtyWrIXoNiyrJoi6Ru5qtZ6F9bB4q7M+L6cFvkabFHFuQ3lgxNvG4cYIdgEUfjVJq7yYrDxHUxOm6QHwNbeIcR3WnZ+I1Fi+CLLq3WaMyscCoYzMJonp/dvESlOtJXN6YXojU8vt2Aj4y7JQVVGOx0rlEpY53oZrTaMscN5G+RpDzoBL8sMxL8RM1nNHqT+ZTBdI+EUKjqWBC4Jo2O/d5CutIN4Z08A6IdKyczwdCtGkg8i4/wWyxsQ9oPY713t1XdfIgbt2gbBkRMe1vLh8n1C6Age+qwMeiEtQID9B8E88KnUGA9Ah/dpm9tBeP3HcExPIDVyn3WIezgrSiF98AnP9Gfy7Ch0oNES/lhmKFrM2ECQqoweyM3Cv+IzS9t1r6T/f8hR7JqvYABSEKzKuniZsQgzCwBf2cBRXyAFh4Lv/2vlm0IqXFP1WDLfEppqe9Ig6Essd5EEc4liiKb/dq3iiNETB1oz3Ad0FTvB8bJ
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS1PR16MB6753.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(55112099003)(4143699003)(11063799003)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?BY2Dow496tQbjZwzMZhmEoxGuTs7bwFiHuwg5VlrsxDuqwh/8uL3IZgFaHsu?=
 =?us-ascii?Q?SFWOGc202L6SRPH17e321DgXtSarrKZBcj2GnEZxqj/xzWL4IxoPROM94sK5?=
 =?us-ascii?Q?iZEyxvFI2Pjwuz5Kb0ZvSnsPgAvJ80zJm7xjbnrkMsyj7MeyzyzG4BRiJWyb?=
 =?us-ascii?Q?QwKnbffU2NhADREJoBxzhy7XQU1WWCldEZwTJbvtUjrynQ2Bj8NKzOQIZ9sL?=
 =?us-ascii?Q?9iJx/y8pI6OX3+Qq5vKhv3IJEaesWp1vZfh3X2dHZhaYaiuTAIF9LhabcoMR?=
 =?us-ascii?Q?RQT/GH/hHpxUyT58ULZkDk4CtxRFopMLIG46ZoJTWoToXz+oMwqMKEpa/Exs?=
 =?us-ascii?Q?XSEidjgEQ5Pmq0+wzEKY3RrxoeDmLC2M9kVpH+LFYhecA2GoTdFhBoXh4Nc1?=
 =?us-ascii?Q?kKX9p95ZVjqJIjoKQo+/VnDo//7H0W0T68bodDWcwuKOAhZdwGufJ/GIaAvx?=
 =?us-ascii?Q?BaGK4Qcbg7csEjUfhI3oplBHR14iu1oQEILdPabIUv69Wz2nCzV6PWyRxWzs?=
 =?us-ascii?Q?CWz6I2wbW+yrhQ/5qiYvlfqNtwRDpjs5GwljnuhsHuZlFRiP9JTfLpUdLt6e?=
 =?us-ascii?Q?kieI5Pq2k7NIleWJXVoG15HJlygYnYa5qhhZXHAvZTwhzv/pqHNgQ+T82bT8?=
 =?us-ascii?Q?cOalQK7xDgC7fUkbrVIw+of4O08Gp/bHFKKg2cNmOUtv4WsEWWhh4X23VXSU?=
 =?us-ascii?Q?QsmfLtkrIkSWKQ2OLTDT0+VeaRXjf0ACm8qvn6GLc3hq6hK8VjeIm4Yum9na?=
 =?us-ascii?Q?50io7PvsuUFeh1zhqsVLHviOvsaXxDZvG7lCDutxLTXGmb2s1YSPb3SpHiyG?=
 =?us-ascii?Q?sgMkpjuaBWjiZ5laJ9fj678qyhVqkLS1aC53DW+eLZMIEMRUf8tGNUKk1XmL?=
 =?us-ascii?Q?LFGSz/5uI6Tq8hzX/jop3YwkYYl6GKNTNXC/HSCYJu/axFXH9lBAfKPz4lZc?=
 =?us-ascii?Q?bTXtWqxdVJf0tbWgoDSvpAb89gRk1ohKLOYfSG9G9ZRBk6Mpn6njzpSxbuk6?=
 =?us-ascii?Q?jGZBtfLyocQrjXCIRpMg6Nr3Zu9+j+apDNK8t5TDk0qNBxM9CpmhiBMT0Bud?=
 =?us-ascii?Q?irUzVGNVso/0GdzGtOqmROU2VElsycpstHcKaTuDRUUBLAQykqsPH5HO7zQ5?=
 =?us-ascii?Q?wTmIO6QUBRedcM/xi136JH0yQHjZNW5QFTHBKfJ/ywh7blVLNqPAw818jhYx?=
 =?us-ascii?Q?ntCMjbYHAszKpvDusrSW335muz7oZ1AQugBF/qmTd3BIFKOZxsVhn6aSb8KW?=
 =?us-ascii?Q?pv8+6cKhTlhpVdFCXjx/wnEEPYpWiUKbhcAXx4noNuj3usm+ZzIpoJQ9i4cD?=
 =?us-ascii?Q?A//Wv/rO3tFC083nsQdK+FrMZ8pBIrPnihfVZMKLiaEZYQXPbjUtUUYNLmei?=
 =?us-ascii?Q?3LfKxo/pF8D1YR60L5XheQI3/lcbEFs/xqylgMyojLbBzHs3NB6VYM12xdss?=
 =?us-ascii?Q?BAt4XtNIAVkjeL81dxvJWjs/eGINrvQUzUGFvoodS4rRm9YIFgxiUu2aC6n9?=
 =?us-ascii?Q?PzqbunrCydYOOsNCrlvBIwRCRKzULNmOBQpYQxL/WX1QJr9Omr7hngzK/Kf2?=
 =?us-ascii?Q?+uOBCtDonYxZ04z/M516HFhg6CHHW8OqqZvyTXrXMpbkP8R2+TDp2wrNblgs?=
 =?us-ascii?Q?JuVJnrAmetavwOlGWJ/K8mROiAQEpJqqhYMEngFioR3IYnadNd+OjA6o+PAm?=
 =?us-ascii?Q?OZxakM9p9vDPWbkGGfZParwbKB1DHMbSqmrKMv+cGYm+N81cVg2/l0Vc4HY3?=
 =?us-ascii?Q?RPN42sKJ+g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	r9LXghDNcaq2fM0Pu155r+EqI/sLhIkdUYskZnkil3og7/PEpBMu9cI7Vo/5EZ0a/K1uZTji9NvfFngIvMwSdC8oL1F9FKWJIdHKWYTYbz0NTvnf9jNoYGRZRjeuqp39wC58XeMCCwgfN57a19qxXrAXG3FDlMC3yvwYuD5fTN+Fffs+XsaTuMxopUh4g3i/wnAa71ofHk1QlK8Nvapcsk4ExokgMmFqhsnApmcFRRuGz9y4IqVgYArb6dmCQmFJZKvy6EaFCVg2LfMpK2WtrkW0nRfCbWhGorJ0Qj/a0Tq5xwhg++u744XQ3L3IMq380bQpyiKzkig4Vmkb0+Btqw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	yYvZvgVKiz3QTBTVZt12uI6z/hOLn5uoyMpwhENXWFuKasrOfHM71AdJbeB1uzkqufuyLQJQxM7HvrAR8dNz+IdN382a3zaLLupfCoN5OM9ov72ez1BhkeAzIXxYVUGJ/BhrJFc5u/CJC6hjynAEYEUdR4VkApACN5A0dkPPfdDd/DtoiGKUH1d8kFasi7CAPuRQNHOR7g+/1c/i6x+HH8Ngishgr4BQIG3J1L5QkKn09KgcN7tH7UB2pDk+7vA/e1C8SG1DxbuggOk+xAxYdlhOjjMaczk20u872hH0P5+EoD072U/GeweS/cbutcR6FSgHldYQXDc/HDIgTmldvQWbzoexw5JNuyfiNe2nGGzATLYzNfc5EOUJfaeAprhWhmc82Ot/1eOIN0Fstn4GhDshZ/1qAuvPp+LVjo19cwlNrbBB+ernhli4c6ICiC/UEiEidhw+2SqvzXEFx+FCMs1QCALO+VzeMmMXkCtkmqt9ji5qhcG7ajx4cSIP4T+ifiQwPpgJfbARIjaxWC5hZY0VtasnpTZrKiJ2vZ/rNjwcHEwP5djQFOqNRM7IUWKcAGHZwgATGMuprgj9Hg34I9XOh2IIgbOWnQzeenySrLYc1UnPtFzJHnwc554Ff7XWug0n+HtIFqgFMIYxwJSnKw==
X-OriginatorOrg: sandisk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS1PR16MB6753.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 077473c4-4a3e-4c9c-2b91-08deb3d3ce12
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2026 05:19:00.9920
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ffe0ff2-35d0-407e-a107-79fc32e84ec4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tbV3TNolvZ68LESqiuZ+782IWWWtjDCx88cnNMhv6vvdMnmBLrvQDOCj4Ksguw9/UG+yD9P1Fgi70lZ9qSxT6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR16MB6282

> Add struct sd_cid and struct mmc_cid with parse_sd_cid() and
> parse_mmc_cid() helpers. Use them in print_sd_cid(), print_mmc_cid() and
> print_list_entry() to eliminate duplicated parse_bin() format strings and=
 local
> variable lists.
>=20
> Also fix print_list_entry() using const char * for the strdup'd manufactu=
rer string
> without a matching free().
>=20
> Signed-off-by: Torstein Eide <torsteine+linux@gmail.com>

Looks like you are missing:
8f41ccb (origin/master, origin/HEAD, master) mmc-utils: recognize ext_csd_r=
ev 9
388e059 mmc-utils: lsmmc: cache ext_csd revision for MMC devices
2364dc6 mmc-utils: lsmmc: fix CID manufacturing date decoding
4dbd897 mmc-utils: lsmmc.c: print_{mmc,sd}_cid(): correct month names
6f6b6e1 mmc-utils: lsmmc.c: print_mmc_cid(): correct year/month parsing

Please rebase.

Thanks,
Avri
