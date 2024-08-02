Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448D638DDB;
	Fri,  2 Aug 2024 06:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722581624; cv=fail; b=GGj8YTg2kjez4RiqV1F00sUuIXtpOQNw4eCb/uOowtdUXUfu6VwO8YgZyiNa7UWMabGSKVNVeEDImlf5XHwkpNmFTD3YQB1YH2gWoME6ebzkVgKRpaQwVVYgWNdVMddPlfa672YXg5F5JGpRma3NVEnwtkG03ax2S3mRVtjni9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722581624; c=relaxed/simple;
	bh=VGXNn1duWSXOexbQDhogT3o4I5RemBKgwereDvX22ns=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CM9hO5Kr9U7OdSvX9l3GbfEdJmFtlbdWmFrrA/jYnYsXbOqk50jhZmL68k62eeBnhKU1jkCCW8gQ8l8YGU+ThDjNhaaYMYSNZGhsyYljjWBpUDUTlDaVcofOAXwOYOVz6M4ttBZXFbX8hSNVCYboUQBf0LFDDf0ZjYith91fc6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=F9mVhD/Q; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=d5+fejui; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="F9mVhD/Q";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="d5+fejui"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1722581622; x=1754117622;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VGXNn1duWSXOexbQDhogT3o4I5RemBKgwereDvX22ns=;
  b=F9mVhD/Qn5waH2UmWMSbt2EnCKvTWzL37opVSfZbYdHgjApAd4Ma41xe
   xe+Bl5jr6h4YfTqtVJH6yJbOVBRFahP3uQCxSLnO7+Ipqdotdad2LcTSS
   f4/Z9c0MKr0Bn7A2Rk9Kmhkstt7Ov9oKe6xASyGwYpInIx2/5mui81iud
   UM91FPjkhFMxmVhxBUUQsYu17JfUYOPCK7X+X1ctZNkrUwvYAnHdEYpTx
   TKyzns7OTu1VhDnkjqvoOsiqkYnw/Z5zj4Bwovwl07FolI+f4AiVYc/bC
   FpSM28GM6eiBl00mN+4FKp6k+/Ir2aU3a83aToW1XHyjvPZS36zol77vI
   A==;
X-CSE-ConnectionGUID: +y/DyWShS2KqX+zVh1Q26w==
X-CSE-MsgGUID: awmL13SlRO+GpAePlwVDIA==
X-IronPort-AV: E=Sophos;i="6.09,257,1716220800"; 
   d="scan'208";a="23999559"
Received: from mail-northcentralusazlp17010000.outbound.protection.outlook.com (HELO CH1PR05CU001.outbound.protection.outlook.com) ([40.93.20.0])
  by ob1.hgst.iphmx.com with ESMTP; 02 Aug 2024 14:53:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z7uxhzzlvIkyRjKH97U9azDU2kQxwi3jepk9sEXgTRAIA7aKhDPnMu3amEMKreNt787Mbwzo7gO8J2OjLg/EjPuqZXz4TZrCmuk2VcQcTxI8FWxI1E3mYZEEgRm1VA+rgiF7yeZKQvZKzxxHalqQOJ7rwIdHOtLJT09nHJvLKECbnZMRz8lYMVD8A/q44Mn6h5UJOmTF4KCi/Gd2cYDNY54vVegaeoL1OqGSZmm/HBfMW3XOy5YIJbnoK+FlSZwt5kJfqom11pxVVXS72jD2HYrdNVvDXY5WHbmPLci3IvYI+K531dzuZ66uUxChElIqJikWr7qES5I43yvHmIok1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VGXNn1duWSXOexbQDhogT3o4I5RemBKgwereDvX22ns=;
 b=RHRiRcMVhnhr480o3fWHuL5SKChQ+vKkvW+KTKUn+FkpcEamscEnHPOfhG5Joq2XP441zSXQpiWLWVgprud2CnsaMqr2tgqr9V84njZ9jAvATNseVnb6ukwcrzuNrQlcmVfabmrCZtcy+QSaDBXv1dmx0W7XGHE07h0AGJjw0VHvnC1sx/p6aXr9Z1Sz40YWpNyK6Dox3UYK7dn6H0z1W1j7uAYSjQjA8gqpqL4kMpEa3DxIoCYdRiStsv3quNtbd/HpEy0rCqdG9cQGfCZzXC0hl5+gndxgWWhDUAfnZwUlWHAdXMr7clmHR/ErRwRVN1Ifh+FV2w5jwt4xecqbow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VGXNn1duWSXOexbQDhogT3o4I5RemBKgwereDvX22ns=;
 b=d5+fejuiooOEszW+3nSJUTatJsuJlDJ6oxt5L2MlAYY/WyqC0TW5pZBxEdvOt/LYRNdaKoyqxGKV75ja9QRysZOekPlltsIVKku2NYWXqnss64ke6CcIJKJ1vFxiFznnDfSfKbP7bRDjXtSzXzdUgWZE0/IuBAdHfno4T9GA/lY=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 CH3PR04MB8902.namprd04.prod.outlook.com (2603:10b6:610:17a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Fri, 2 Aug
 2024 06:53:33 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f%5]) with mapi id 15.20.7828.023; Fri, 2 Aug 2024
 06:53:32 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Keita Aihara <keita.aihara@sony.com>, Ulf Hansson <ulf.hansson@linaro.org>
CC: Jonathan Bell <jonathan@raspberrypi.com>, "Tim.Bird@sony.com"
	<Tim.Bird@sony.com>, "Shingo.Takeuchi@sony.com" <Shingo.Takeuchi@sony.com>,
	"Masaya.Takahashi@sony.com" <Masaya.Takahashi@sony.com>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] mmc: core: apply SD quirks earlier during probe
Thread-Topic: [PATCH] mmc: core: apply SD quirks earlier during probe
Thread-Index: AQHa5IyN2eW83YeZG0yW8ctqcF2XGrITiBFw
Date: Fri, 2 Aug 2024 06:53:32 +0000
Message-ID:
 <DM6PR04MB65758D0D2BB64D11EA4FFC1BFCB32@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20240802032121.GA4019194@sony.com>
In-Reply-To: <20240802032121.GA4019194@sony.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|CH3PR04MB8902:EE_
x-ms-office365-filtering-correlation-id: 3f573562-d459-4af1-df2f-08dcb2bfd2e6
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?U6kFKvyOdBdt4snx8cpXucHVdvJAz0/Z65zqkpBF4CAWhI+38ldKH/1T+T+k?=
 =?us-ascii?Q?J6dTczVogliQgfiQFl19R/xtb5GhYEKXew8u69/MQ/e8Ty36/EYjPrsmFA3Y?=
 =?us-ascii?Q?V2zdTQJmbQMwPosn0NNXRJSQS9QTLhCfbwOKmRHFK2MChbzETzolUFo9Tw/k?=
 =?us-ascii?Q?E35Z969mht5+0TVHEBTmsMpQGSHZK4H3OsJhhCDOiWqtk7tx/JyT9NvSiPzj?=
 =?us-ascii?Q?HSMvh4Nys5zAY7CAXKAHSvjieYlNz/h0NUG4XkzpfZwvZDhZlgrk3kOs4fR/?=
 =?us-ascii?Q?QG7v26XCjHtzAcqY6CaZku6TuiUOKRviY5eCvOe4NUpYOZ013LG4Q1OC6cWD?=
 =?us-ascii?Q?WoKNeVFz9G6VkXnzhOeQYKQvY1fWvYOHsXfsI2/nAeYrobPGQphfyMCFdbuF?=
 =?us-ascii?Q?RrvnfS9U1XagzIiA11d6tJ2+u+7QOwiHM5z5A27scdP8o7zQNODL/xgtACXq?=
 =?us-ascii?Q?o65WENFpu+Y37PjeJpbHwjSWVuzM817KzquBOvj5qu/961xwS9DpgGfOFUkS?=
 =?us-ascii?Q?C3NVDgXX6AteHMjD0l7TCmIQ3cshShegJly+I/w1MYd68xUfYnfIP8OTnWw2?=
 =?us-ascii?Q?7lwY0grwWS3wBvFxWUWnf/RyOG+h7EwDugZAwSE4AP1ESgLvl72d3bHOrMu4?=
 =?us-ascii?Q?5t50zVyJVANLhhg1pwCLuMm1TIAxJr2ShjWThG2Lvgi6zkT0odnFCf4sbJce?=
 =?us-ascii?Q?cD+lcgHGtRg8NKneI+tpgViT2KmXBZSQKpd1vhOsnCYZnIm/390YgVnbG/M1?=
 =?us-ascii?Q?f5WLPjeiXmym7wtWL/Mv1gbIEaQgG8g+VpwbJVf3WW5CwUsHX1DFT90yLhh4?=
 =?us-ascii?Q?eG6WlGcQ7a1MrNrQd4NsLNLp/ROP+c1YcV41Tlu+Ic2qCJhs1oPmtAcc8hjy?=
 =?us-ascii?Q?601ezIdzaI9pORKf/r8Iv/NbBeFxyHh5XA/dKCt1qHSrLum56XaSgxomiaUJ?=
 =?us-ascii?Q?EB26Pe63SwC6rLKMoQYMV01TCg99zH+yPYjaMnj6fXUHcAeutRVMCJTjDqpr?=
 =?us-ascii?Q?efVSht0YaKMMYaD6ztqD9UVdGKF5zMSCZC8bxbTCdD6tr5sXDlT4eZPDK/ba?=
 =?us-ascii?Q?uwD1n13AQIg2Ylb2Ty4FLQTWp4ZPxDBDISilLuX40BlXDsJ6T6wf5YsrNLiD?=
 =?us-ascii?Q?tbO4tMxWnEw1gVLphb3GSxCu8/6LArCpq0HRKg+IOYPsjpvYW9ATGks3h5Y4?=
 =?us-ascii?Q?Vm2yjZg2H2gyuhAtjS3nm19zWZRkSHjD03cKE7YdMm0i2mpusoNsjnk2SosE?=
 =?us-ascii?Q?REMEm3v4zoT2QlRsBYfHq5oZO6G/E54XSJF0qCyE0fSo/DBfJAOpr5aT8UE1?=
 =?us-ascii?Q?sNJ9x0vWwuc+3HkVuxW+a9RyJ1HQdzoNw3TlOTsW/qcjLoWWmc74K1joe48M?=
 =?us-ascii?Q?JRHzI/6Es+T7GBQzaFdGE2mu0hehuFqrORzX9MbE+8G15ZfcmQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?pmPo9BbQD7E0tOZMfQt4ZWajpkKK7juies/ORjfue9llmfFNwdB2JW78PqOR?=
 =?us-ascii?Q?vfMLu1JliIcVLdjR89Y54KUj84dggkD5pLBOn1cfE07sx5LB1VsrPAXwge4H?=
 =?us-ascii?Q?7ApW6ZZy9ijqCz3ZoThlN33Q/SyyVtw5OcmBX4ZXinKPjM40tBMm42vnRr8w?=
 =?us-ascii?Q?OLV3AAwoncWSi1Ikw9tpKWWa7GYSWF1JSunygB1nA8mi/XT+6FCLD02gOZpP?=
 =?us-ascii?Q?Jhn+Xet2ciYD3IjvSbCnB6KLQjlLcmtskCvijcrHuTQ5eMwP1Mu8DZhMj96N?=
 =?us-ascii?Q?ODQ4gRAAJqBhiC4z8OeA8kWc7aGyL0mtQW2uHa3DExccT87KTYd67L8vcgTX?=
 =?us-ascii?Q?wUI+l5tj9PGXUWFXeegL4cbzoPsDUZIUVRApMUpL3AweFalYiAUr5b/hDHoh?=
 =?us-ascii?Q?LDc5zlMsEmAh75n4JUhELbZvAFImORLCHLWT/VLIaalEEYDJB8pge7QyJft5?=
 =?us-ascii?Q?Ofw/ZIvNSeGF2rsXEKh5sBSVomelkoVPhdx/hlkePNCzbSEddr/R8nN+HdS0?=
 =?us-ascii?Q?lyqtDewb2/InEtQiro9dSIn72L+oKOWMteK2QaWRkOoqYvjB77cpotyqaz1X?=
 =?us-ascii?Q?JPGFFDbDf8mkhaGd5gOS/bx0gOXgIFVP4XAfKHjQeIedFx++36vZi3TEo73f?=
 =?us-ascii?Q?LB1fgQYhCFy75TB2jsoHZDBHSbGcHAKSOTc9C8tgwa410l/C4KBW7XltTo7d?=
 =?us-ascii?Q?ljsyn3o0C9nPz8ursyrAohzT9wq0tGHoFTlO5ifvB8CwPILohkjPBNHOSATz?=
 =?us-ascii?Q?6J2VO09TbJ4SEXxwkxP6LZ4bRIXptjJP/6A4IFuwDuWa821dG0rJwKJnur/l?=
 =?us-ascii?Q?QfXgEs1WupmT9JVuDwlkX79KPPxiWgAOgbPlarTK1txcCjf1l3TyfJGJ8I+V?=
 =?us-ascii?Q?792lwqD/argkF+iZmdcvt9fvL6lbYpD3xfHm5LMMVcuRHGjaurlLGzZmsuHZ?=
 =?us-ascii?Q?do2o1sbee1UX1GqFhbGYBy+QMkP+2c8Q27S6jeJwQPCxe0j+MWD+/dwlkCHz?=
 =?us-ascii?Q?up3nO/Pg+IwKVQXxAvKwchhQ3UN8x8S3gbQhD7BsTDKLMQ4fLC7/dMHE7M3j?=
 =?us-ascii?Q?zfneTku42Su183n8kpHb7mqccAZ5loIC5XEJVGVLgiDiqRLxB8+6Qyajm0Aw?=
 =?us-ascii?Q?xXZY2qAMda9n1VpOpiC0QGF1wh/P98Z+0rlydu2mmg43RMQnLeZGeAZfjeyc?=
 =?us-ascii?Q?Kl43zIBDE2V7OftjCkkQtIRbZJlokQgrjgJLH7+3R2GH6fjWLYKJvk58aQWn?=
 =?us-ascii?Q?UA4DcbCoS/TZvhCT9JkYBjILEPW4Y7FB1bUMYleMd/wqyHp2yvFEtP39Z1h1?=
 =?us-ascii?Q?UIuM6+8IYrEel4qkqMos9nrI3KIkHc2wrPQA6Na3hgM/pcJiHc4KpIKFadlg?=
 =?us-ascii?Q?21JmSlLS0YKbVJjFh0Sd4Hw9nTaQelExeTr6NW1QC/KmfcFsRwpW50TTTwF5?=
 =?us-ascii?Q?JJp615MubgQ45tDQmkRB+0Ud5qBrtXHrNsjkO+5CKZ/8KBwiRWA3Mq7jP2vP?=
 =?us-ascii?Q?lGftbrz4r7v1+KicC2i30kOn1mNmcx7tuyeIh4BtLsMD249kojqey/C8rz4e?=
 =?us-ascii?Q?xxTrlLtwYeOcUBJx6at4ovWH2BJaPK6QpT6lXMSkDrlw9vtRcF5sisl0Byuy?=
 =?us-ascii?Q?2QmDrjmigGn2Ox1JSc2M0b+VOV4J0BPtqViGuHhmu2DT?=
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
	dWwYWMlh6V4oEFZJfQhwZd2hr7daM3Ob+4czzDZsulMSPnxlxCZ6mIlE0GkA5uHWDw/9CGROMzPclmrMVaLw3TDITX5F7VkuqIBrSa0WnkP8a0EMtlEFebI7oc6BBj66wxmbCMJ+uD1x49Ijp9ETV+5o6RmfA96tjZ5uZs3kiRNCBCOamTcBm1gO4QwJwEzM4QIWvBqIuGjtzxCo7lrzDCy88sZeEFMijj4sL3veEEizzR7PRecHvh/ds4N0rSn+WXlVEIVIbV4wEVCkFxqwMo7vw762vfC9LsvaV2B0BrrMecRReXZZ+ujvwaca8PtJtIcglMaC+y8PHpXl8A9Axv52T+p1ocLzmZqvAklzE0QyTGtmEt7cGImbJVndh7PFoFlgugcj+FIOLqQJLFanA3RZ4FeMYyYShdA0SiSA5rgaONgXBkZUrEcs0RpqEqXom+OthKWiFcbLwYxC1e5PIlUm42Jc9FATr6dZ2eYXDVUAptFETej+zbnPDJPf9lwVBs93ECq/e6agj3VF+QeDmN9v/HajnZTM8vH/ARNS5IrdXXWo0J3/ZqBei57xHamNZcC6Bo/qrKHHcQ2+qSrvWXdglgrhXNlEpMueQ4O0MS4xy6Hodxs+OrSnKEqsf3ty
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f573562-d459-4af1-df2f-08dcb2bfd2e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2024 06:53:32.6064
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eyoMlOov2Y9/nGs/XgD7893FZdbC4lqRsx7RyT3XhkIW8QpoN5/RFakovHh9ZLrUxzMUlJmGur9mcHVYWYrR5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR04MB8902

> Applying MMC_QUIRK_BROKEN_SD_CACHE is broken, as the card's extended
> registers are parsed prior to the quirk being applied in mmc_blk.
>=20
> Split this out into an SD-specific list of quirks and apply in mmc_sd_ini=
t_card
> instead.
>=20
> Fixes: c467c8f08185 ("mmc: Add MMC_QUIRK_BROKEN_SD_CACHE for
> Kingston Canvas Go Plus from 11/2019")
> Authored-by: Jonathan Bell <jonathan@raspberrypi.com>
> Signed-off-by: Jonathan Bell <jonathan@raspberrypi.com>
> Signed-off-by: Keita Aihara <keita.aihara@sony.com>
Reviewed-by: Avri Altman <avri.altman@wdc.com>
