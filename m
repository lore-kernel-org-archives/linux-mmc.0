Received: from esa.hc6817-7.iphmx.com (esa.hc6817-7.iphmx.com [216.71.152.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2723F256C84
	for <linux-mmc@vger.kernel.org>; Mon, 10 Aug 2026 05:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.152.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786340884; cv=fail; b=tWPvSQyS5O0nYRAtHOq0bMIMxxYOdcKAR6+ehoPhgkOFG/GyKgidjj7PH82cOw7JRiqF/7Zz3IrsgtyoYqICn+j88uqfKSnGioX3CPGUYm48Mit8Kk6qCrH/018dJ3utCbKud0mt3TnHden0lIi1JB9e64pHgUdv6qD51WUQnlc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786340884; c=relaxed/simple;
	bh=uwMOrJdd+l+uwIzsj+gBt5hhcZTwVjbKopapSD1dOAI=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Wuu2hnn5Fcrxw40hUqIizbn6lzcWaZbzxNnhvYrGG+Zex1G9HvYOSkVGXw7tqo9k4inVHvHOhQp/HdtJcEw+/TqsASpImp0t7wAL74kQGYVR4b1lkM3ZDOhcvusuz7PCadauIqMy9Rm8dCSLB+p/xp8Zt/40xxj3sFtvrPBG4qY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=uPpv6BZN; arc=fail smtp.client-ip=216.71.152.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="uPpv6BZN"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkimnew.sandisk.com; t=1786340883; x=1817876883;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=uwMOrJdd+l+uwIzsj+gBt5hhcZTwVjbKopapSD1dOAI=;
  b=uPpv6BZNu2/9Bs8QiZ+YyZqyKeAYAcXxozDIkr+KqUtdF+Se5wgvCOFm
   pSUqcO8+cqdz/IgAbnl0tbYnCdUtdxw0l1dRqQJRQ8Sm0KjN6ABmsb7mA
   +p1lKduOsjkBLX8xEyuDo8WmQlalEL+qGZ0wvV9Vx5Ogl2YXFill6LgBC
   Xr/Zn2VySmpDxvDZjIPvJFTSqqcbj8neT0NdAuUAQ1N68BUQGorlKsyIZ
   gsEIQuGztlgiDrIlZffmcsPzQqa8/cGqBCtqPMORYEGBp6qlzDtPs47DQ
   yNQ9QQvf3+VpUIEgJKgG8Z9NahALrsx/q/UaSr1apQRNgPvLg0iPX6R7v
   A==;
X-CSE-ConnectionGUID: HlIonz4JSFKtK2c3gy1qTQ==
X-CSE-MsgGUID: FupwQEiMSP+F2ep2TuMsiA==
X-IronPort-RemoteIP: 40.107.200.129
X-IronPort-MID: 27835131
X-IronPort-Reputation: None
X-IronPort-Listener: OutgoingMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
Received: from mail-northcentralusazon11022129.outbound.protection.outlook.com (HELO CH5PR02CU005.outbound.protection.outlook.com) ([40.107.200.129])
  by ob1.hc6817-7.iphmx.com with ESMTP; 09 Aug 2026 22:46:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yfNzpEDWn/gtAoH762Y3Olz/V1mvdZhMo87WF8qtYgM6+uu3ssthESsHnTkjkcx9LZGHTT/C8M1j1X8M8/YTrUaa1zn1gVyvqDHB2Fm0dkWicLTswLu+4L1oXHk+UmU5xlq0tRZO7HFAUJVg1dYWaOUtbjdvT9NCa8RO+6dsJ0mszxSXG6613S01RQipYAOWdN405OHVqS4LRfmLqJNNEoREwj/MawPp1M/XqnihzYgiPHwLIbZai3IK/KjotkrQx/JiPSAMY/FZwdIxWeGgdxzZ23GqTBGlZ152lFKI3JcZvLGuWu3Lf8q40hYLkDOBHSxgRlyPdqeEWCReq/Dm3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vGEhaFSDAxYGsXue3O+67MLs0TKNJtHdBnMxHuzlMP4=;
 b=VRQZ5y12V7S74AtXyVHsdLeEGu3SIaWCjs1zcDiwid1lSyJYaXYl4vq6nB9wuXXwlz9sLAO2GILj2mvzpLqnc8/9uCQf+T3063qrDztl43HlAUzCPB9ixg93WgOWSGBrhXR4Zj7GNx2oNE3eXvXACg7B7XuOsjMfJflDDg4IdxB42sUcjI6nzXrlV0ZOzCDo5HvNDVARvhvZ/ckk9D7y54GVfW3Lln+4giNRyJdOWdCepahCPoAcN3qFf0sVjIUlu+sbteegX7PFq9pZTqic6623ejrzAo9mUC4zPX5EJ8ymSLbmgYlzXbdSYmVPEjonLwD5kENxdOb+GD4GWg/Ftw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sandisk.com; dmarc=pass action=none header.from=sandisk.com;
 dkim=pass header.d=sandisk.com; arc=none
Received: from DS1PR16MB6753.namprd16.prod.outlook.com (2603:10b6:8:1ec::5) by
 IA6PR16MB7029.namprd16.prod.outlook.com (2603:10b6:208:5da::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 05:46:51 +0000
Received: from DS1PR16MB6753.namprd16.prod.outlook.com
 ([fe80::72d7:97b5:4539:a90]) by DS1PR16MB6753.namprd16.prod.outlook.com
 ([fe80::72d7:97b5:4539:a90%6]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 05:46:51 +0000
From: Avri Altman <Avri.Altman@sandisk.com>
To: Torstein Eide <torsteine+linux@gmail.com>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>
Subject: RE: [PATCH v5 0/3] mmc-utils: lsmmc: add 'mmc list' command
Thread-Topic: [PATCH v5 0/3] mmc-utils: lsmmc: add 'mmc list' command
Thread-Index: AQHdJ9hJ9FoWl5LFSkqdLpnwNGhuJ7aWx0Pg
Date: Mon, 10 Aug 2026 05:46:51 +0000
Message-ID:
 <DS1PR16MB675333B51DEBD84526B51CD4E5DE2@DS1PR16MB6753.namprd16.prod.outlook.com>
References: <20260809082153.104311-1-torsteine+linux@gmail.com>
In-Reply-To: <20260809082153.104311-1-torsteine+linux@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sandisk.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS1PR16MB6753:EE_|IA6PR16MB7029:EE_
x-ms-office365-filtering-correlation-id: 0aca0bd1-0fb3-40c7-eb87-08def6a2c6f8
x-ms-exchange-atpmessageproperties: SA
sndkipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|55112099003|22082099003|18002099003|11063799006|56012099006|3023799007|38070700021|10067099003;
x-microsoft-antispam-message-info:
 94BdUaNeoDyJ01bN1oZz/Kri7IOznsHpsXNqq1da0/Kcmi2iKjUKElpd3uUAng0CH3ovjtZzbTJ3/6LqC/knt+KOayVbgKmqki6KV/b4KmToIHH2fiXMbykyetZC+FL/HNOOm5wT6tp+xUuG0EuyOaPcyDRjUCv5cFu4P8kiXXHli2p/8DSBCC3+4NrgSAcfq4RGb80F5Be4J7xhdjBoNU3BHuk9yAcZOgdRxepHi2FSHqTmEw+g/8a8LhQf8TlpZ/AEq11XJlV5evzyNJALiVLDQ65x79g6xh4E/UQfiHbHUIeA3nyMVgNxHaZL9oFgdgs5K6QBqgjo58lQMMS2l7FVuUC9dvrK+/qfGIk4EQZZh2URyjfHmFZf1+J5ggoTTtqUHPy1Clyx0MFOdaNBBgcnUPLjKioISdYRNmGIxaHOyC2X+xaKTx+sf+GTqsCUyEm9QKuryVKeBpJgT1hHIl2wIj8souhACcOhB4cqOOVl+V9BRS32AXjkDjdsMwoB0vXON/tExUUaDjnBmAypanZK4exgLUTmbVY6SWLhjkRBZ4z69CJXurbmI1VYHP8kB9tOhp9wsSnZtKPdFAE7MKzX5MUYqIG2yQDY4Hs9UwbvEWIwMHc6GBDQ8Smn9EbQq1ysucV4gCbjggJFGga6VdqCAkZjllr/OJzl5MHxf5qkZTnIh4/7uDysHUpodh5vijo6l7W5dk80SzdzNmDzv9i0ARibjwfiir7+5dqYmAo=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS1PR16MB6753.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(55112099003)(22082099003)(18002099003)(11063799006)(56012099006)(3023799007)(38070700021)(10067099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?8f1+iK7NVvF5rYRqKkve5RjtQbh1M0igsWi3zDmXlrJmdGFKEjPDpD4IkVKS?=
 =?us-ascii?Q?MH0Y3PHBQANUEUoTXA69UOmOENrXQn41+2/X7oG/G/KJn8Hc2yKTXFL5PbbR?=
 =?us-ascii?Q?SlA0p+28jFw05lgw4q5SMNnhcdlX0uj6uRHPogPovkOXlnSMXyXxsR0KTqCC?=
 =?us-ascii?Q?aKjjb9jEu57xJGKj2M/yg4yAcllwjlLLwd0WF0o2oZZBRinU2o9EuMYhr4Eo?=
 =?us-ascii?Q?PG/vxNnEZHXb398eUfzrDwf25VGteIWIQI6yDOYQEiM/0mEfxdiTHzbGh0Qw?=
 =?us-ascii?Q?hwyw8s0n7ZMaOcStXuuL8yy2NZVqqtQppDdAnvX7YW/DVGW1eYHZAVd9p09a?=
 =?us-ascii?Q?5KLd4Ovs/sq+i3R81ZXFqaxWo679gkR+CHFkHt6iiyyVki3wKfY0jLIzODXh?=
 =?us-ascii?Q?ih62xCPeozO12KKx+zwdhlV1xxjdpc8FPjWI2iQpas41hlOOMEHyZa0lsiMG?=
 =?us-ascii?Q?0nc/fdPA20CKk+DOCSVfPLiKt5YwpK8E4EPCCfDNfTFOiMeHwA1yxocrnPzF?=
 =?us-ascii?Q?kR81DO/9erpHVe+Z1DceLFb6KUkSc6xKE8x/vjSQg7E8pC+MTuaYLdqFkywr?=
 =?us-ascii?Q?+Fy0n+CYlndzBPGX0cWN6/vUEvWtZZNemhYRyMCYRBEvH/Wui91iOwJXuzJe?=
 =?us-ascii?Q?M0t/YD9aHVz/12IizxZoK1JIcV2D5TCI+i0ysKMsFjP7erbHcceM3XK9fFpF?=
 =?us-ascii?Q?5+RGUS1McLk9NgLvuBkHVeZy6mM/QQcz1Vm6XPEcMqqddtaHSsNpt4chE5Ie?=
 =?us-ascii?Q?tHAJTC8bNQ892Pq4KX6Fx7pJYHmX1bZj9eTwWezEuDHYrTcyq+wGv7fpPFqh?=
 =?us-ascii?Q?lI8lMlucBTU9RLBIU8PwmMJNIk1kcXPtxp0IjOAJ82gDyHov+bcVGqkprlHP?=
 =?us-ascii?Q?kitW+EEu1uk8xfEpxHbXa9GnxYvHzlZxsyqqikd/o9YTh14KGBm+EKqTblkF?=
 =?us-ascii?Q?CSYeKzAxFgR3NqTM0Rg9J8hhmw1RYC8FUgZrZYnjPN2RGDwSTfD5jax3wf30?=
 =?us-ascii?Q?P9oQBdjruEz1WnF9BSczFWpnaqRSH+Kzmz4R+ihnc8n8eM7SBmdrOn9aNzIG?=
 =?us-ascii?Q?w14adJ5Os/WvB5MTPkiFR90E4DAWGoRNOPSZLS3t7Y+UspQKnl4HaZtYulhB?=
 =?us-ascii?Q?/lX18b7zq2uQzeGMNPhmlarouS2AlW4yDsNIyQl2/cNCv/7642hPIXsMION1?=
 =?us-ascii?Q?DPKufVBRpTwf2LFLLqI8M1W1bZZzeBar3L/+z/5tRvUXwcjQ49i8k6o2q5hW?=
 =?us-ascii?Q?09l2mcf2nOgsts8FVxcclfgQcTZ2Swz+f4/9A+iZwBko/CsfvT+OBjAFrOuo?=
 =?us-ascii?Q?Ejf6qKPpGiPNQA3reGMJFDdCnZIQI/N4cCSgxqChYmMLXSavcCIzRtzK5BpX?=
 =?us-ascii?Q?eBR5wnFcM/XwehisDuobp00tKvyIdtdkaCyH7bHBqZbLs9Pft458k9mThbrD?=
 =?us-ascii?Q?YfFmbcJz4zX5hr1GhpzDIyaOv799As0Hrez9zwp5X1fG/e9MF2oCr96xwFq+?=
 =?us-ascii?Q?VRdUwlGMXFxTad/hDq+3niEByyYc/V3D5ENNqMI7TCu4uZmXSu9/QOnjwO7S?=
 =?us-ascii?Q?oqxSYkm4Ks36Bsi0jTuoz/dGusPgFuMg15EV8W6XZp7/a99hjqiNG+rIPEfB?=
 =?us-ascii?Q?T2h8wMvCaf0b/ov7a2IR+7eE+BqfOqS0ecCpNoTK9ypP9lCCXavgNbi1jug9?=
 =?us-ascii?Q?wBvIXqp6ZGNNwnoUP5Q0PSW7zxvzg7DxVJP9odoibrdNKoA5PYyxDzDcZlkn?=
 =?us-ascii?Q?zq9FrdEpJQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	XZIV+RlFBUHsqcEN6lBlpfHmhjy6eKTDY+IXJY2wOUIunSRGXOyg2C7dHuH7vc56I+Iq3jdwA5CfecMxwF776cUs3ZpDmV+7g16Ec+wXF+Y9D9ECd2rkb1lM5DBcw8MndCoYg95WGLACtn4m9civ4dhmhc8ghgXstF8wRTuzmCognYyv0UMjzkrqOrQcZ6IDJ2jjA/tD20W8BUsrwIsYAv9EuWIq7lPMZQ+FNW1Eg/50qGxLknFUfjjeU82fsP/WgoBhz8MNg8qAM9gDMDhSVgkbgW/l/VIL3rqQvgy/TWYGdwhCfuQ5Y7pdk8Til9iMCgS36z1JizhfLmAFckWBQw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	uMuUliHImkKxFocx5fURAgrvlsi43kTppUeAnMr/U+4fqlQVfYjTtKHZ1YWgScZolKLrS9qBmSvAI88SDiH1oLkeKZdIh0k39n988XHZJSmKZxkTW+zlHJ/HhLqRqB4EUSdETbJosgT7nmvyM80ZswjL283RBipORebQcD8atUsMsMii7xWxJ72HYKQV28h9MjdhasFQ5Avz1p6EQUV7j36vouiVIZPeYE/Wi3YNUJp/yN+PR6/p9UEfcpCEOo/cb3JjIXmBS6fimdne8C5pYrnHYWXIGWv3oTVDdqpDSEIFGW7xeDjOBH2nGEmtlnkF4PiKC1Nj99/ktqLpG1L+D6qLGt8vBE9O71lkv1jKJMxPTPBQaH8tD/D/4bB78u1g1HKEd9NKsVPxFJpCFl9Xe+CUtk0yp0LHdxUo1zJPWbGlx0NHDBrv8c2UDu3+K4gVuxQupTdM5sZbeBCqKW8FiBx/+SrNRM9xJA9JJe1mskV/6z8FLPiLhBiUt1Ox5VguaHnYtipZKJ32h5Df1wS8oufiX6ZJTM/21tWbRt1di3+u9CXNyTggLKeUVN+je4p+9AQY6mLZ1UI91AAyi59RLZJk6UiHK94/Q/0TyEeqT34A4xO3/n1BWJRodpV6F4u9Lbexa8/U81p38Cvl9Bvp4g==
X-OriginatorOrg: sandisk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS1PR16MB6753.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aca0bd1-0fb3-40c7-eb87-08def6a2c6f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2026 05:46:51.6081
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ffe0ff2-35d0-407e-a107-79fc32e84ec4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 82UnffpG76NlVJfGA21cUmE44utRsRCdjA5uwQgTQ8QIWFGqNPGXSy+iExNbgQ/P0Z1+ZzaNGfbEA5DKRj4oQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA6PR16MB7029

> This series adds a 'mmc list' command to lsmmc that scans
> /sys/bus/mmc/devices/ and prints a one-line summary per MMC/SD device
> (device name, /dev path, bus type, manufacturer, product, revision, seria=
l
> number, and manufacturing date), and teaches the existing register-read
> commands to accept /dev and /sys/block paths directly instead of only sys=
fs
> device directories.
For the whole series:
Reviewed-by: Avri Altman <avri.altman@sandisk.com>

>=20
> Changes since v4:
> - New patch 2 ("Factor out CID month/year helpers"): extracts the
>   month-name table and manufacturing-year derivation that
>   print_sd_cid() and print_mmc_cid() each open-coded into shared
>   helpers (month_name(), sd_cid_year(), mmc_cid_year()), so patch 3
>   has a single place to reuse instead of duplicating (and
>   miscomputing) that logic.
> - Patch 3 (Add mmc list command): print_list_entry() now uses those
>   shared helpers instead of its own copy, which fixes two bugs the
>   duplicated code had: the month table was indexed 0-based while
>   mdt_month is 1-based, and the MMC manufacturing year hardcoded
>   "1997 + mdt_year" instead of applying the ext_csd_rev based
>   base-year adjustment. Also removed a stray double blank line.
>=20
> Torstein Eide (3):
>   mmc-utils: lsmmc: Use external .ids files and accept /dev, /sys/block
>     paths
>   mmc-utils: lsmmc: Factor out CID month/year helpers
>   mmc-utils: lsmmc: Add mmc list command
>=20
>  Makefile           |   8 +-
>  docs/HOWTO.rst     |  71 ++++-
>  lsmmc.c            | 645 ++++++++++++++++++++++++++-------------------
>  mmc.c              |   6 +-
>  mmc_cmds.h         |   1 +
>  multimediacard.ids |  16 ++
>  sdcard.ids         |  23 ++
>  7 files changed, 485 insertions(+), 285 deletions(-)  create mode 100644
> multimediacard.ids  create mode 100644 sdcard.ids
>=20
> --
> 2.53.0
>=20

