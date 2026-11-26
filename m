Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=216.71.154.88
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795702335;
	b=XJ+DWYgiOXw7x30YYPGp/qdIEXV5dFCEiMapqr6QTRUUhJASN46tj1nM42/BdTHgNg8J
	 zWc/NCmiN1blhRVDdFAlS9nV7yGvH19vZX7CObY+k4qtnpvPlcncFLjCELBGuCxr+h+gf
	 FgSHobTdRgeQ/6ejAL6CQK6hcJ8ozM2CAhL7GGQ2+QVgPCmuqsRnBZsJapqEbxymr1njD
	 XB8qrN7gC3Rg2WtUGIBImXvqxGxmpLVleVunVYD5pyN/3fAsJwToxJRI8VrnFpw2srqFE
	 AYGLdVkHnrP+QKLikUXxn24ElFwUSKr23IwVOzd1YloY3lNHef91fwYB+cwOvMlG8vg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795702335;
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
	bh=oIEJknRKznV0x8WDvBCzqB2XAq6yHP1HhxbruxRJDHA=;
	b=lroKzbj1lmd9KX3c490ZLUUda7/C/mAVlNZQom38ma5K19pnnpHfVzk6USb5sSTpdalf
	 Tl6vzQp8vepZa4BWLgtpKIonoyw5K8vnqK6M154Or34nnqBacY5acGd3DAkevcPQ+j2WH
	 Rc8ot14YdhHbZIoNKesrTnjgDBr7deMvb+AriETFNBk2MpHMJkN06SxoWD5PkIuB3XufA
	 uyEXoXN6SOU1Xn3bmhgQAK+yqOeMAfQ/TxBtXCGX/EsCniUyx8UT+wOBqg9e0E+qF7TOp
	 DIkv+PtMI0PSOjUp/DMYiiCwYDOcuBigXo+p9QqKp99L3IoMO2plBwM/C39OhrAKYYw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sandisk.com;
	spf=pass smtp.mailfrom=sandisk.com;
	dkim=pass header.d=sandisk.com header.i=@sandisk.com header.a=rsa-sha256 header.s=dkimnew.sandisk.com header.b=pq0LUlMw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=216.71.154.88
Received: from esa.hc6817-7.iphmx.com (esa.hc6817-7.iphmx.com [216.71.154.88])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38FB606A339
	for <linux-mmc@vger.kernel.org>; Thu, 26 Nov 2026 14:12:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F38FB606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.a=rsa-sha256 header.s=dkimnew.sandisk.com header.b=pq0LUlMw
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkimnew.sandisk.com; t=1795702343; x=1827238343;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=oIEJknRKznV0x8WDvBCzqB2XAq6yHP1HhxbruxRJDHA=;
  b=pq0LUlMw+x7StPSNU5u3HWuYTXNHhd6vBVMOrqhY2P1DKD17/404YciU
   NShMWoVhUbJNrHIWpz6kI+fs6CK5pnTUeakAti52huQBX5RcmykOjBqsP
   j2s07UuUEEs33dy6n5b1i6sLcBBjD2tatb9DCNFsjHZ2ld56UJUJW8aPU
   VF01IM9t647BqL2W0ArE7sV+MFHQVt/hJg2YtMcFqKBKqqslPhdSJSp0V
   tz6Ho4cxDE7/5+Z2wdqa+flbEytFssFNSepL5NGTuQQ85divYSGu5j6u2
   axg7pKWpcSiBzYJRCZeluy8/So8cJ2VDPUlxgZ6t1j3wdcFLp7O50S+HM
   w==;
X-CSE-ConnectionGUID: i6pjg1LrStat7p/qWnOZhQ==
X-CSE-MsgGUID: dgDOjOTPRviOoxpZlqS3IA==
X-IronPort-RemoteIP: 40.107.209.79
X-IronPort-MID: 35150938
X-IronPort-Reputation: None
X-IronPort-Listener: OutgoingMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
Received: from mail-westus3azon11022079.outbound.protection.outlook.com (HELO PH8PR06CU001.outbound.protection.outlook.com) ([40.107.209.79])
  by ob1.hc6817-7.iphmx.com with ESMTP; 26 Nov 2026 06:12:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IdK1/ilBE3JtoJmF//Op1/ivVfDZMnhBzIBXP/ezp5WsRmmSDZud+w/GYfsUI+wtQFq9ZucjLq0hd6iH4dhrLCL82AG/CQ0vTbR8hcPBXo16PSNBbULA6tQCYDTJCxQYXIAKL0hSv2b7fqlNxFcVtBuWUgqVCRD9UZz5rRA3QaiIrffBnATllT0bF5WAilW57tBsc8i9aOxrO4uV1w+vaKES0vXd6VjukcahJFF6MGkNv5/DftYakP3xQJmYfk0EfeUQohw7Q9kt4boVUQsbYu0K+nbRUwumQ8fCNvqPaeiB8IU+OAw9pMmmozeT0Xdtf2ZtGNvqrP+nyuT/v0+5Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oIEJknRKznV0x8WDvBCzqB2XAq6yHP1HhxbruxRJDHA=;
 b=cfWUaXRd5ur+EwIycDo6YzTanG1okOItmTxsdkrduOtYWmvY4bZX1RVLOhILkGhHG0khsDMZmKeG/72ZcBAkBItdUO3MbmeuuGj+/zbIBBS6pEHKdZOJtElX7SzEB98/Vs1/A81UKQV9zwzesb9hu2uXLh6g87CqLnx9aZcWHqnj2aVikZT1tqXP/HjjQn6cocSjHps3IuOCK4AGSZdwENv/TY1pBpooS9/qxNdco4vn7SwzWbuXEkzQdZYLJUR+ejpEj3XWBPSCjJKGuxBSJIByO5JT2awu5D010AiSMmUFN6STUgrvTmUOOnQab2KbHh/NMqmZdsao4fApx49gKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sandisk.com; dmarc=pass action=none header.from=sandisk.com;
 dkim=pass header.d=sandisk.com; arc=none
Received: from IA4PR16MB520939.namprd16.prod.outlook.com
 (2603:10b6:207:144::15) by DS0PR16MB501054.namprd16.prod.outlook.com
 (2603:10b6:8:42f::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 14:12:12 +0000
Received: from IA4PR16MB520939.namprd16.prod.outlook.com
 ([fe80::5b79:943f:ee09:cc1c]) by IA4PR16MB520939.namprd16.prod.outlook.com
 ([fe80::5b79:943f:ee09:cc1c%5]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 14:12:12 +0000
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
Subject: RE: [PATCH 2/2] mmc: core: Clear the single block retry flag for new
 requests
Thread-Topic: [PATCH 2/2] mmc: core: Clear the single block retry flag for new
 requests
Thread-Index: AQHdfNjPbW831XkGNkyRFeSzcy4LK7dAZmSQ
Date: Thu, 26 Nov 2026 14:12:12 +0000
Message-ID:
 <IA4PR16MB5209399E5CFC3E12B3DCFB97F7E5422@IA4PR16MB520939.namprd16.prod.outlook.com>
References: <20261125123015.3999-1-ovidiu.panait.rb@renesas.com>
 <20261125123015.3999-3-ovidiu.panait.rb@renesas.com>
In-Reply-To: <20261125123015.3999-3-ovidiu.panait.rb@renesas.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sandisk.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA4PR16MB520939:EE_|DS0PR16MB501054:EE_
x-ms-office365-filtering-correlation-id: b8dded96-298a-4b9f-a864-08df4bc7442c
x-ms-exchange-atpmessageproperties: SA
sndkipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|4143699003|18002099003|55112099003|22082099003|921020|10067099003|56012099006|11063799006|38070700021|261026140227099003|261026121527099003|261022105027099003|261028144727099003;
x-microsoft-antispam-message-info:
 wGPSYE/3vzhyNxQzvxbZvlB4PBXkIU8Y2UB3hqlBViCzoqtpzKgE6eCMvHjh1rShAfZJbdVo+uUicNqMMfjhQeziuOd761csLU0yiboO0IyfS3tHBAOO937AlIBdx9LebCYRNKxhbCkkbKo1j+LxH701DskrQVouoKb9I3jPHt4/TYgR76rppU2wMR1fXqZv0WfE52tqafnMS08qyk4FO7HUVZzctmVj9gflRmhls528cRGkE7oQuhO4BjLMoIjbk24vPwiL4X8kf7KyAsz4PpWaMIXa3zFGYxSGkskYYNAIAjuBDX8j6RDSKpeV4mjj0cK0QxwZSS8lLd/kf4pR2ifzRAHjs37AdBEFHxmBv4U9rIg+OmTeOvBrQwr0BIlfyM+wBM+c/gXuPmCH7DaTcfVzaX7MEmR8euSX9tMpy9sVTfaumsSC5SzLvsmbjLDQLIKiW3U67F3fLNm+BIsuT+3zd9pKqEOQTu2AtsdOFJEDSgsCMpLvmpMMNM3wDQZmV89W5FtHfF+PZ9FLrRB8MPE5URt/rTdLyfLVMpUu8QkMqyY13+7kecjILa1/s+eXM4bYlTrT6IYbJxbqiOSMut5OEvY+S7HwMRJhthdDGpY1r7tixS4R/NZUI0ASGVx0i98a8xPr3IAGHyMr6j3o+AthMUluaKV/oio+lbhTt9SP/pBnSYdcABtdwufY8H+U6V17NKPNVUpcF59MDloc6hWku0xYhhkhUPgFFG3MibpznJw/acvfP8q3y77578MB
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR16MB520939.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(4143699003)(18002099003)(55112099003)(22082099003)(921020)(10067099003)(56012099006)(11063799006)(38070700021)(261026140227099003)(261026121527099003)(261022105027099003)(261028144727099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?WGyz9clFA5iTSKZr40SbeG6spXUstO//DUIRQ+0wP7NWFFCqyv+EZBZE36Cb?=
 =?us-ascii?Q?A+bSCuAtpWG/j4znlsH8kVSJQ37kaQpGclXUt915WtyP6GhOpuT9ZpZv1Vef?=
 =?us-ascii?Q?YNiBNT/zPWzwaFahhJyz1m6QQXdpskoj0Y1EqAiE16hqxY2mapy4GfSE63yC?=
 =?us-ascii?Q?ypIBAlrXO9vasO01xJZ1ImNFk+21obZDwPb6XmrwKLXMmuAU8neDgoMe29Rs?=
 =?us-ascii?Q?uxIBGFrfQaHRKkSErDX3OaqvWUJbUS/KhDc4wVZFpiUYQumoob47Dzi4EJ1K?=
 =?us-ascii?Q?fr3CcyFYZgax1VTfcxRlEcuDj//RiqByXMbYst48kWsSUwok/2o92nJIRviC?=
 =?us-ascii?Q?djzEIIoctTa1u5ZdzwZd1dNwzwiGbazq1y0hqroD61bgg/7hKJxzECv0+9KI?=
 =?us-ascii?Q?pRlvPzlTPARdsAsTnLp6fwGUvbQG5yYs21454uTm+9o1VfWkYBQItdq2hh6N?=
 =?us-ascii?Q?h7ecAgF579XkpLM+XJQvXvqzRWn3kwLHf4xmWCfbK0tzLaQC5fYNKuRVTo/A?=
 =?us-ascii?Q?BLt71LXPBcZmSLknEXWL+DECqCKY5t+mY/jZv0OeaUaYXkmS1sgGTE95zKsi?=
 =?us-ascii?Q?nGqTkG69nfeqht5HU7eF3pH+1Do3HVBs2LJ9Eouo/hJpceUFwleGANt3G7+n?=
 =?us-ascii?Q?hWZagZI6Hi+XRKdlXMxU2RHC8COVZZS9qlywaL6CIBxXtC2FU0QIOi+MK9SC?=
 =?us-ascii?Q?m4lVmwKbtGHYg4MQ7gB4gxY8ufMbiNkJvVn4RNK8JNasSe3EABDLq+1V3w17?=
 =?us-ascii?Q?LI3TNfUCaUIHMVVgH+q8rcWFyzWkCrKDW/lGfppUWoZgaceVNTm7fF5cVaHi?=
 =?us-ascii?Q?7q6yyzJiNt9693byH2TQ9uYLRTIoMWtoa5s7g9FXY787M/INapbcPRCUwRA6?=
 =?us-ascii?Q?FyMhxLWZVEaNFlTSam25E/JUvzvjxdGQ3VqXJ2q/XWgrYSlwHcRvEphJ74yq?=
 =?us-ascii?Q?nOb55XiFzP0D78xOl1VhHp0PmosDJXVhPbc1LXwBnHCGFOUqRMtXyNJPzDR0?=
 =?us-ascii?Q?gpOj8sz2FhNuytmoDQRveQZqonM+rEkTaHA8jW0k9B9QSVQckNaZWCcSYJS+?=
 =?us-ascii?Q?1fvvgnqNGz9awyASm+BFhI6QtJz14J7I6NWvGYM9xb6/U++HQ43LbENehXxj?=
 =?us-ascii?Q?YA6UA99hw7EcJ3YpDz4LVDJZdSAR47b5iT6uFTri8ilHEqI+223HMJ4Gylu2?=
 =?us-ascii?Q?hgBZqfhkizV4VrOkwLN6yqh96zfOHIx4RRAfmYZxomdMJvS8ILB8tkKQqIhj?=
 =?us-ascii?Q?a6Qb7+Ec6z37JENXzuuuxqAsTYugrIt0yMcpeyl6er/jU23qIDYAEs8beDX3?=
 =?us-ascii?Q?tuJVfZzQbAxyLNGX1HErA1Acv/mo/vfuknwZJoFRsZp7MQvQCi1QX2LaEoQT?=
 =?us-ascii?Q?V5/5hX+1/ajioovLRojJvn5s6v8tjj2mujThGYJgm1pjkCkbDUzfmz09Yts4?=
 =?us-ascii?Q?w5OFbGdAwOG7HE1WkzT87+faxn8G2TVop7qkdbIQFarPNK6J35I2W6C3IFqy?=
 =?us-ascii?Q?QPfZM1sSFgv+Zvg2DNp7X8xEXV1J6FVDMXXdwT5waQ5RCuwlj4uOE8pMJ1Bk?=
 =?us-ascii?Q?JFVH+C5yRnUHrCThCNiqCIWx902aOQZ2dLNAEmQcOpcJqYL4D2LoqEN9NgzI?=
 =?us-ascii?Q?xb93hyq6jzzAbMX210AemLEhhzz9Pz4L4hZCNQUO4M63kTROZ4RsoW9w1dc6?=
 =?us-ascii?Q?laCb22CFXwJUx4MO+zW4Utg4vMmR+RzBRGlaXGOoA1d88Em6qvywdYO3vaNF?=
 =?us-ascii?Q?A+lTJfW/eQ=3D=3D?=
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
	AUJYTDmyfPlmnzriqd3wabKf01P4AqZvmkSL3YXparMzrSJLHXCrtFVkiJGkr5xceXhXPe2PUo85GI+xorqo6vA49pIKzNBXEpQB7gXIq013iyFowxxqCLz7+jhQRNaO4BvAHHMetwfCmAR87MQke5j0MZgJsJPEfIch93KPEVoh309qEKg/GPc9zPwmOq56mRIJJ36jEuCeuRFsrhEF6DlDlA1XesEReO+ZlvIHd0tH0+hFqW26sJaOnxwFaNfdrQgGoeFCOrwTUgISXKt3MPY5hv2WDeDRgnM+n1UwUB88OUmX4HIvq7hAgcNZ0Ubv4iukTJqC0afK+GJx/JQiZA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FRM5nv0opPDHt+4sZFepFFZSFYF7f+yrrYS6ujK0CLJM43xHy5eqHSrzgW1iwrCQZ7DIuu2vXKzoZH8/vRmHNCykq+iFiW0IIT6gfmDOy1iEoS6iRPjfoC05n4gVjKXaNz19krljPD9VDM2t+agNO1sTYAR6IictmbqoTEDBjbjaJuCvATZSR4s4MhY09iVpokB18bSFaqfCZFl9fZ1GOuiH1t2jMbJU/QLASnLud/IPUBwts3lz6brA+nPF04swN60YE3qSd0/YqzgfeiwXHt1Nd/txI90vmrpQX52DHU4oTbK5jYy+tb6hvIEYfTkRqO7HP8H79Osi0LF5xwZw2pOHU0XoYgMf8s/3nrYptFumKblk1kIc16gE9VQiw/yh1Itpc2Al9g1McpM7c48JcH27HCyRy7fnAorK6ZS7wTqdqJXLdv+ZJvaxIeGXH9+2niCblIo39BDP0bNnffW8eUL3+BjjIdfsYMmnoQ5K6BGA4LBtH6HejFiTqKM/+5CPPjpz+oi+gECUzwlW8U5xsx+3VK5xYkU/7cM64tUZiprkuwQO6YcMf7h8Dmv0ZFLAaUTKjRVXzamWTZZr7FO5IRxk1t5iscmctPKgWYFKzScy7F9cT+KU475WkRfFND6BaVldVrHKhzDypyWIf5MRaA==
X-OriginatorOrg: sandisk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA4PR16MB520939.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8dded96-298a-4b9f-a864-08df4bc7442c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2026 14:12:12.4124
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ffe0ff2-35d0-407e-a107-79fc32e84ec4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g3IphppR4FbdsDc9vrsuAEiIFCdrZEjipKSTVQ5qwnCNgFN8D4xdtFlUxDIloo5BsL5GURUPwfjeqTHRyQz7jA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR16MB501054

> When a request fails and is retried, the MQRQ_XFER_SINGLE_BLOCK flag is s=
et so
> that the retry is done one block at a time. However, the flag is never cl=
eared and
> blk-mq reuses the same mmc_queue_req for later requests.
> These then inherit the flag and are also transferred one block at a time,=
 which
> makes them much slower.
>=20
> To fix this, clear the flags together with the retry count.
>=20
> Fixes: c7c6d4f51038 ("mmc: block: use single block write in retry")
> Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Maybe also:
Cc: stable@vger.kernel.org

Reviewed-by: Avri Altman <avri.altman@sandisk.com>
