Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85A720E700;
	Thu, 13 Feb 2025 10:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739441646; cv=fail; b=G4jsI9GJFr9q7GPvIKO5U2/hz69AWImJQtMmpEWAF1oiSiPfYogC8f8gxK3b/W3Rw9zyKJZJjedjbjVnrjS2fOC9pl84fioHdjnDn6OefeCRaTszuMp+3HJIqy005l4Tgcona3x2j+Dgs3pLpTvErGbaruFRTFhRarZywgLUVFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739441646; c=relaxed/simple;
	bh=2lMgG7xNilY2NjIsxBJF3XUxRq/LFZMg//iDaTsQSbI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SzRyMoo0IvdVlpeztY1AB935wyGLOMoK24nIfBTYWZziEa/UWGxm65MqalkeHlA2svnIvp4/SWfsfQi60AhlpxL7lUYFJWEOuZk0/Z73KaW9r9TfEphr9EnJ50b/q271rlBK2629TR3a9QlU4C1abUlOM1tgA89LTjOLI7UU6wA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=o5/3FOuf; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="o5/3FOuf"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkim.sandisk.com; t=1739441643; x=1770977643;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2lMgG7xNilY2NjIsxBJF3XUxRq/LFZMg//iDaTsQSbI=;
  b=o5/3FOufp5qJMFQy5zdMY5/uJF/F3HI1mC0E7DlMXHmr4qhbT2OxkNkr
   gIHkaJx1qIkE4ou6eZzAa3ji0oSdnxX8Txk7Tdqgdo1TMIbg33XdubpBn
   5r2HuoQlx08ZiF2UULYfVndFQpMUsHbrCKEg8JAXhTStF6aiDMcIGTsLR
   +0ZdUm5G0TQazWEW5cjYSfQEIKRYiTAIZqA6DLjgmzujeYowrbE48M4yc
   74MQmc2x0Kq+/PfLrimFQ4xeYJf1zng7glcd6GF4V3VM/RPwvp3T7TWvU
   wqjsgjoDyVKqhtUH/MjhXijK61egp3xz/yO2Vi4/ArO8ngGla2Ch1kriN
   Q==;
X-CSE-ConnectionGUID: TkLn+cNiQuu4LVAKmGZVyw==
X-CSE-MsgGUID: X4g15tvyRmSkC4pc0GyPzw==
X-IronPort-AV: E=Sophos;i="6.13,282,1732550400"; 
   d="scan'208";a="38153558"
Received: from mail-mw2nam12lp2043.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.43])
  by ob1.hgst.iphmx.com with ESMTP; 13 Feb 2025 18:14:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZkP+lVK9TaHdTLalepI8zdsKt/bKKVNbnZeRxxo9MSnqKkZJXBWbQky5GcqRGhU9ZhiHaDTF9uCzPsZBVYo7wacRXIrpoWFP/u5TolBzlvvjeTfN92llPYEjT5NzG/CHBZok2PB4pnTVi++kEDk3ZwC4E8ldOqIysI7aRZiC1f3CGummxXSvdQAGtIyDB+2ymzVStsRImYZour49/lrlwpKtzZfgoPbXhT1wOFpDYpT4Mm4dnVTkC49GBgnPlY1xzUUoO3IhM7/EZkkENaadj9xVeUuT8PwPYf+DX7PHQdk1DKUWZLSpdkcwWk6IvIOOD+nJ1cp0Q4o4ZZalstcEMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WmuM3VZHOjrfiWmbmBdhCioL+AqDRmjcxtkPW+UDD4Y=;
 b=KJvcpKp33TauPhrt5CtOea6uQkvQzAlknm7VIvRwdwvDWBbGlZ6LpAFRPR2xAx6ZWEkGnbPTyg1f+l66FEguHHbmA667N8qvs6q7TL+AxydsIjJ+lIJsT4O4wqdvNz5LhjNwIJiRSXsPLEJS999hBsy6z1HtZ5pY14j/H3ikh7cT/ZwnO22Ugepu5opVhi+cxc9oZSzl5YOI1x3UNpwr4qwoyb14YZgV4ZdsePlZJkIMpm+v7U8HZn2Cc1lzDONU9DGeHPjYcK8TrovtVKuMF3fi0i30TwyVaeKZIBZH0v4a87Q30KQs3QTNgKYhzTcq+oloXvo5eANJXgd9BsbsmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sandisk.com; dmarc=pass action=none header.from=sandisk.com;
 dkim=pass header.d=sandisk.com; arc=none
Received: from PH7PR16MB6196.namprd16.prod.outlook.com (2603:10b6:510:312::5)
 by IA1PR16MB5422.namprd16.prod.outlook.com (2603:10b6:208:452::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Thu, 13 Feb
 2025 10:14:00 +0000
Received: from PH7PR16MB6196.namprd16.prod.outlook.com
 ([fe80::e087:8329:baea:5808]) by PH7PR16MB6196.namprd16.prod.outlook.com
 ([fe80::e087:8329:baea:5808%7]) with mapi id 15.20.8445.013; Thu, 13 Feb 2025
 10:14:00 +0000
From: Avri Altman <Avri.Altman@sandisk.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>, Ulf Hansson
	<ulf.hansson@linaro.org>
CC: "kernel@pengutronix.de" <kernel@pengutronix.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Mark Brown <broonie@kernel.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>
Subject: RE: [PATCH v1 1/1] mmc: core: Handle undervoltage events and register
 regulator notifiers
Thread-Topic: [PATCH v1 1/1] mmc: core: Handle undervoltage events and
 register regulator notifiers
Thread-Index: AQHbfVFzGWCl0Hr3Xki6r+7iNzM7arNFBBRA
Date: Thu, 13 Feb 2025 10:14:00 +0000
Message-ID:
 <PH7PR16MB619609C650452062D6BC2385E5FF2@PH7PR16MB6196.namprd16.prod.outlook.com>
References: <20250212132403.3978175-1-o.rempel@pengutronix.de>
In-Reply-To: <20250212132403.3978175-1-o.rempel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sandisk.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR16MB6196:EE_|IA1PR16MB5422:EE_
x-ms-office365-filtering-correlation-id: bbc5d434-1ba8-471a-8206-08dd4c172272
wdcipoutbound: EOP-TRUE
wdcip_bypass_spam_filter_specific_domain_inbound: TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Z0ni6ZOoSgtQn+GMIN5nHk13RyfICwNdwX+WkrZ25hT2mKpKIe/yIcMcGtKV?=
 =?us-ascii?Q?K3ibTaGbMDQ9rZcXYUmxz2AYgnC0rBx1j33/iBdjy/ue8nPnBphY1ILN8VD6?=
 =?us-ascii?Q?+saPx2iZ/lbt+7N9IuGJqV+eINNNsQqjwk5jrfcoKnAU8QXxxzYhSSNNsyXT?=
 =?us-ascii?Q?xaEcpJWLu3Mg6ElMPxkKvyOqtC4EEvo56Vef0vTknDYXo+FOgVD2R3g+BYZQ?=
 =?us-ascii?Q?SWxptt3OohHNa8v13i/adud4NccTFYIvv2FXJi1MxuOLR45nserZn54+xOTk?=
 =?us-ascii?Q?B+b8pO9X6au830EXXShTgKYpoadgI4D5Fl+ZYlCixboeQt5YIvGLeieSujvh?=
 =?us-ascii?Q?WhW7vC7NKtUeQvTm2XLuoU7BQb/41useajqetjIJPQ0p7IF3et+2Vif5cwxU?=
 =?us-ascii?Q?MGffZSvY4w1Iz1yqP2H6LAUiDallTvvdihDAmISRte5d6ac1Bm12Ho3LguIg?=
 =?us-ascii?Q?CICcV59j7XxWD26QrO7/LaTOLvgv4FVQEUCA7d2vDQE9KFUJ2dBRcxh7vx7A?=
 =?us-ascii?Q?mbDZT9vfTzAIt9P66Yw+zr+jw1IecKPWs6kfWle4j2PxMFi5fziUs5XDbcwU?=
 =?us-ascii?Q?Qnbq+23749xbOv4bvZ5lSV37scg87aRXoDoHdkNGEbXyWiLsFZSr2N83WLTI?=
 =?us-ascii?Q?tj0JxJxxPvN+e0Tyde49suREZlJVxApKceehrpj/KoM0TiMbOJwK3hMJi/n6?=
 =?us-ascii?Q?16Fc+YP8dUL1Rhok5YsIasghM55HIygFz4JUr4FyEHUKd3x/8BLC7KbkPnd2?=
 =?us-ascii?Q?yCnB0z/9+oQhR3GoiiMJ/k4USXW1GF1AAjg6GNFCfmJtSOWwWqIZLSK5vdCV?=
 =?us-ascii?Q?tPu/kW8RoosmiSf++TTwkTWNtzT4ZTGaapf1af8hg2ORKYhf6PntMDwGNoEn?=
 =?us-ascii?Q?yP9B9i6UnI8IWXtt0j2CiqxmR4ahm+WXb+MwZfYlGxTGXaGMHM1hamlqTOJC?=
 =?us-ascii?Q?FKjftZ9AZgIBo+2Z8y28wlIY/q0DKiEqv/arp88ueLdZB+P3FepMPn/WygiD?=
 =?us-ascii?Q?Je61PLEZ5JpzxwEkYDKpO+KUOsPNHAYEDQFVrJoQFOFqnTmICuLzE5wFXCTE?=
 =?us-ascii?Q?MJ7qGnh+wDrOBEHydsZrpU4+wuoQTNqOFCRXuTHGARNFR87rFSWD5dkukTNW?=
 =?us-ascii?Q?J18OeJXinYIbFPLXfMs6+aydIxVs9Qm38F515ufBBWDFaxagJ7vmLIL5QZKq?=
 =?us-ascii?Q?QAIkbL28/M1B3NaJdQ3giKEHG/uZpmZvLqC0Mb4rEHjxQCZGt6eOZCgNL2d7?=
 =?us-ascii?Q?wwzbgV6Z5a9rAFmiQ9rTpcJd/NmAkQgaHeozYRsKxtNEuLDqmf8nVh34b/+c?=
 =?us-ascii?Q?7wMMQXZ8nruihou0esGKlgPth9B+O1UEkIGjF+R9j4vwVokPQVLE3rS6i7KF?=
 =?us-ascii?Q?ZXJ5UAak8JP8viTQkVh8UzSMpY86hcCqcM7cYapZ6OsQPUcO9swgSH0ai+z0?=
 =?us-ascii?Q?kkpCTjre+NmsRC6FcVbzYETeeNUbBAja?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR16MB6196.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?jEZPLYmdvVvtbsCtaU82tV0hLBGzcCdq6L5xUhkSd9oGIpharfxWJky7b/5C?=
 =?us-ascii?Q?Vs1GnRqRkqMGqy3eF/L2+p22GruLC/0D0AuMLbyD+L8Qj+SyzIaqUTeYwSDI?=
 =?us-ascii?Q?aSOhhG/DeTiTozLS+9Inejj3lzJ6hGv5kdu5CrJtjj1RVBsLDkl6Xy0e7l7M?=
 =?us-ascii?Q?e/wVw6hTE7xXEIiYORLu2OdHAEqSaApdHkHHBze+LLd0InH3GP5QYxxfuBjo?=
 =?us-ascii?Q?NCll4+Lp3VjugbggzkGGWPJnGh+HLlBzYQosaKMQvL4IqXL3lwjl8EeTf3dn?=
 =?us-ascii?Q?h1aoLow3BlH+T4WvPhtudA7lRaRkSSd9ZowEwpj2tHNko8pU9JSovN1w+7/i?=
 =?us-ascii?Q?ORB7XZqa1P5D7qxUUnojbaS9m+ZGZaGMgjm42zWXEl/LNrJ9Pj+7mvN/PCqy?=
 =?us-ascii?Q?tAJSlQCc/tY1LfzwlZ2GqigxdLEvUo6f/fma2lHMq8n9htTZg+QiZbji+nJA?=
 =?us-ascii?Q?N2eyyBcNb/C+EifSClfyhdODZeGO9cjIgvSgyKnEDKsJj843PXbhOJ9GORJs?=
 =?us-ascii?Q?WfllmKvQo583ql0SM2V/e9PuTPyjXNtBjyFRXdf6dMSe264uIMyNOO3r63IW?=
 =?us-ascii?Q?6m/t7zaZpx3I01vjLQiIoXPtqMObIfR1Rp7Dio9Vd2cfsaMizkRrXJqgviae?=
 =?us-ascii?Q?bG6s8+UeAHLmaBIgST5wAJf7CCtcTDK/SPuzX6QfQjKLi2khA6SJkdxkZKS6?=
 =?us-ascii?Q?ScVYCQO8lcURYmo3AZL5VLZo7tGKRMZwG/WT8P87Hf899xJ7rA66rc7M92A/?=
 =?us-ascii?Q?xpLl+xLyTuhmDXn29p9iZNbE4hnOOx+21xzoEezQbpnaTwPlgZurkzvI1bty?=
 =?us-ascii?Q?q0hJt1jDvM30hLx7JI4oGofA5vCGvGUImDZ/QNNY/Xte9hf3b3oNZLTdbkvw?=
 =?us-ascii?Q?zxgVGLI7cQ/UfniEC1M0o7Ai2QLUKhCPt8qcZv0XubzUID+FKsgPO3qztB5d?=
 =?us-ascii?Q?fz/LKj/S/lSfo5VShiZ139EpId4BHYFiTWWbw9wjjOJ2aTaLV/Aw7+EqV5zj?=
 =?us-ascii?Q?dOHsFOgdQxo4GBvljucsE+xxZjXZJrVwaNhO/n4rnZ1W49vbmRETaUOPbqHu?=
 =?us-ascii?Q?YnOexJkdvjbQw2lutIaMkbg7cCj/XqEMtyo1dcQfTFPqGRsY1wZhHW9/mMvn?=
 =?us-ascii?Q?8cWN0tJb4zoNsdDAAIGL+08ALBpN7Dk2lmYQ7LTzHzR6nOnto74MwKXU3ayN?=
 =?us-ascii?Q?sJbWLPZxkgZ9R5jszkXYW5bwZ/G/TNG3l8SLLwNvgyA0PvFnThCamnfoeH+y?=
 =?us-ascii?Q?aRe+avXHfh/MQv0hToGr7KnkQkA2LJLEWmavpkGAw7ah3zm/AKvDlCvZUFTb?=
 =?us-ascii?Q?yqI5mNrNBvEI1M3q99lFWnaMhZK5heU7mUczhGLxc0P/SlYz+e8gw7kPmvtK?=
 =?us-ascii?Q?Gln6cXrGJyslKKA1GnmoJMl+JRgAXL/n871D41eLYGOc3zz0wCzSm18+Bg3Y?=
 =?us-ascii?Q?qEXsryNQLBi07m7WCHxQRzI+sJF/1B1JJPQrjorL7Y9x/avuWcK7F6YfsN84?=
 =?us-ascii?Q?/U9ANVu2NWa/sgyXzLhw6+3TSJu6LHPr0y8BKblBVoh5eJvsoND7qFXiBKdI?=
 =?us-ascii?Q?aJCtOKQSDsUhQp9YtkYP9jpteGpRZZoqZtAizdYyDMg1hSZdaFinbLeU5SwN?=
 =?us-ascii?Q?0bj64FE5Dv6gjo6UaxvK17s2eSQKeG4hYR3728EbNknO?=
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
	6ePcQNPcDUoWEj/Z1PjE2IG4WZRIz9Sshb0zRaRE5BILC068Z2U3iLtCN9uKtTfRxoaQM1nZ2T9KsPEEfnDUC6c3ZplsKEJ4LQbW52zE3wl0AvTptxXkA1ni4nWJJMUY6HUIQ8gVlTz5g3DcfNqyjIRoKL+6pCXzc046B8ANmWF3RbpRlJoKbtioN7HZ+K2SOXTkjfLlFLYWDVSFnWBnAmBTNm6kKojFGyvoW/WrQ1PQ9Pzu/PWn9rXS/+1zyozNn+fZd4r2wux5mC/AfFq6ZGqhkPSTqabhg0vJoGZlWV7gCOtkbNrywfj9eYOLBQpAKsFXCNddNNj+ctjUHSCxPMo3x0cAQ9GfD+XQZhMzRwnttawLsdqWDASzBHez/intz672abOXxrbXKfqgRj6cGK+6JHhqyGiplHkIfqdF45JNQjSetndvX6f04rWQVH6mLaSBdjCthObTaE6O1p4j4GdO9FggtSPolXJSCBjh7CPoevEGw8IlBWTubrhhKdnSsDVhCnllw9b6QJEAwULDD2LFLiyXdjzf9hhsGJzGSrDYwuYJTj4ICsKvAAcaYSWYeYJLyaj6+iZID6EwbFc0Lpn69j2yleW4elXxvkmm6J35I329uRUJt7YKbqbEmmEAftsk0ddPwhfyB+Ydb8ua1g==
X-OriginatorOrg: sandisk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR16MB6196.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbc5d434-1ba8-471a-8206-08dd4c172272
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2025 10:14:00.1872
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ffe0ff2-35d0-407e-a107-79fc32e84ec4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8dQCDKE9BjXZEstHj2iiI+XVEbZg1+oXH51Z9dGfgNA7HQG626VutgjcjjGe5wd33/AD7PtHNyNvC/kJjQHKtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR16MB5422

> Extend the MMC core to handle undervoltage events by implementing
> infrastructure to notify the MMC bus about voltage drops.
>=20
> Background & Decision at LPC24:
>=20
> This solution was proposed and refined during LPC24 in the talk "Graceful
> Under Pressure: Prioritizing Shutdown to Protect Your Data in Embedded
> Systems" which aimed to address how Linux should handle power fluctuation=
s
> in embedded devices to prevent data corruption or storage damage.
>=20
> At the time, multiple possible solutions were considered:
>=20
> 1. Triggering a system-wide suspend or shutdown: when undervoltage is
>    detected, with device-specific prioritization to ensure critical
>    components shut down first.
>    - This approach was disliked by Greg Kroah-Hartman, as it introduced
>      complexity and was not suitable for all use cases.
>=20
> 2. Notifying relevant devices through the regulator framework: to allow
>    graceful per-device handling.
>    - This approach was agreed upon as the most acceptable: by participant=
s
>      in the discussion, including Greg Kroah-Hartman, Mark Brown,
>      and Rafael J. Wysocki.
>    - This patch implements that decision by integrating undervoltage
>      handling into the MMC subsystem.
>=20
> This patch was tested on iMX8MP based system with SDHCI controller.
Has it been considered, to rely on user-space and not the kernel to handle =
those extreme conditions?
E.g. a pollable sysfs that would be monitored by select(), poll(), etc.  As=
 Android might use?

Thanks,
Avri=20

>=20
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  drivers/mmc/core/card.h      |  5 ++
>  drivers/mmc/core/core.c      | 29 ++++++++++++
>  drivers/mmc/core/core.h      |  2 +
>  drivers/mmc/core/mmc.c       |  6 +++
>  drivers/mmc/core/regulator.c | 90
> ++++++++++++++++++++++++++++++++++++
>  include/linux/mmc/host.h     |  4 ++
>  6 files changed, 136 insertions(+)
>=20
> diff --git a/drivers/mmc/core/card.h b/drivers/mmc/core/card.h index
> 3205feb1e8ff..f8341e1657f0 100644
> --- a/drivers/mmc/core/card.h
> +++ b/drivers/mmc/core/card.h
> @@ -24,6 +24,9 @@
>  #define MMC_CARD_REMOVED	(1<<4)		/* card has been
> removed */
>  #define MMC_STATE_SUSPENDED	(1<<5)		/* card is suspended
> */
>  #define MMC_CARD_SDUC		(1<<6)		/* card is SDUC */
> +#define MMC_CARD_UNDERVOLTAGE   (1<<7)		/* card is in
> undervoltage
> +						 * condition
> +						 */
>=20
>  #define mmc_card_present(c)	((c)->state & MMC_STATE_PRESENT)
>  #define mmc_card_readonly(c)	((c)->state & MMC_STATE_READONLY)
> @@ -32,6 +35,7 @@
>  #define mmc_card_removed(c)	((c) && ((c)->state &
> MMC_CARD_REMOVED))
>  #define mmc_card_suspended(c)	((c)->state &
> MMC_STATE_SUSPENDED)
>  #define mmc_card_ult_capacity(c) ((c)->state & MMC_CARD_SDUC)
> +#define mmc_card_in_undervoltage(c) ((c)->state &
> +MMC_CARD_UNDERVOLTAGE)
>=20
>  #define mmc_card_set_present(c)	((c)->state |=3D MMC_STATE_PRESENT)
>  #define mmc_card_set_readonly(c) ((c)->state |=3D MMC_STATE_READONLY)
> @@ -41,6 +45,7 @@  #define mmc_card_set_removed(c) ((c)->state |=3D
> MMC_CARD_REMOVED)  #define mmc_card_set_suspended(c) ((c)->state |=3D
> MMC_STATE_SUSPENDED)  #define mmc_card_clr_suspended(c) ((c)->state
> &=3D ~MMC_STATE_SUSPENDED)
> +#define mmc_card_set_undervoltage(c) ((c)->state |=3D
> +MMC_CARD_UNDERVOLTAGE)
>=20
>  /*
>   * The world is not perfect and supplies us with broken mmc/sdio devices=
.
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c index
> 5241528f8b90..4b94017d2600 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -1399,6 +1399,35 @@ void mmc_power_cycle(struct mmc_host *host,
> u32 ocr)
>  	mmc_power_up(host, ocr);
>  }
>=20
> +/**
> + * mmc_handle_undervoltage - Handle an undervoltage event on the MMC
> +bus
> + * @host: The MMC host that detected the undervoltage condition
> + *
> + * This function is called when an undervoltage event is detected on
> +one of
> + * the MMC regulators.
> + *
> + * Returns: 0 on success or a negative error code on failure.
> + */
> +int mmc_handle_undervoltage(struct mmc_host *host) {
> +	spin_lock(&host->lock);
> +
> +	if (!host->card || mmc_card_in_undervoltage(host->card)) {
> +		spin_unlock(&host->lock);
> +		return 0;
> +	}
> +
> +	/* Mark the card as in undervoltage condition */
> +	mmc_card_set_undervoltage(host->card);
> +	spin_unlock(&host->lock);
> +
> +	/* Call bus-specific undervoltage handler if available */
> +	if (host->bus_ops && host->bus_ops->handle_undervoltage)
> +		return host->bus_ops->handle_undervoltage(host);
> +
> +	return 0;
> +}
> +
>  /*
>   * Assign a mmc bus handler to a host. Only one bus handler may control =
a
>   * host at any given time.
> diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h index
> fc9c066e6468..578c98e2f04d 100644
> --- a/drivers/mmc/core/core.h
> +++ b/drivers/mmc/core/core.h
> @@ -31,6 +31,7 @@ struct mmc_bus_ops {
>  	int (*sw_reset)(struct mmc_host *);
>  	bool (*cache_enabled)(struct mmc_host *);
>  	int (*flush_cache)(struct mmc_host *);
> +	int (*handle_undervoltage)(struct mmc_host *);
>  };
>=20
>  void mmc_attach_bus(struct mmc_host *host, const struct mmc_bus_ops
> *ops); @@ -59,6 +60,7 @@ void mmc_power_off(struct mmc_host *host);
> void mmc_power_cycle(struct mmc_host *host, u32 ocr);  void
> mmc_set_initial_state(struct mmc_host *host);
>  u32 mmc_vddrange_to_ocrmask(int vdd_min, int vdd_max);
> +int mmc_handle_undervoltage(struct mmc_host *host);
>=20
>  static inline void mmc_delay(unsigned int ms)  { diff --git
> a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c index
> 6a23be214543..c8b8e7a7b7d6 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -2273,6 +2273,11 @@ static int _mmc_hw_reset(struct mmc_host
> *host)
>  	return mmc_init_card(host, card->ocr, card);  }
>=20
> +static int _mmc_handle_undervoltage(struct mmc_host *host) {
> +	return mmc_shutdown(host);
> +}
> +
>  static const struct mmc_bus_ops mmc_ops =3D {
>  	.remove =3D mmc_remove,
>  	.detect =3D mmc_detect,
> @@ -2285,6 +2290,7 @@ static const struct mmc_bus_ops mmc_ops =3D {
>  	.hw_reset =3D _mmc_hw_reset,
>  	.cache_enabled =3D _mmc_cache_enabled,
>  	.flush_cache =3D _mmc_flush_cache,
> +	.handle_undervoltage =3D _mmc_handle_undervoltage,
>  };
>=20
>  /*
> diff --git a/drivers/mmc/core/regulator.c b/drivers/mmc/core/regulator.c
> index 3dae2e9b7978..0723afb2f9ed 100644
> --- a/drivers/mmc/core/regulator.c
> +++ b/drivers/mmc/core/regulator.c
> @@ -262,6 +262,81 @@ static inline int mmc_regulator_get_ocrmask(struct
> regulator *supply)
>=20
>  #endif /* CONFIG_REGULATOR */
>=20
> +static int mmc_handle_regulator_event(struct mmc_host *mmc,
> +				      const char *regulator_name,
> +				      unsigned long event)
> +{
> +	struct device *dev =3D mmc_dev(mmc);
> +	int ret;
> +
> +	switch (event) {
> +	case REGULATOR_EVENT_UNDER_VOLTAGE:
> +		ret =3D mmc_handle_undervoltage(mmc);
> +		if (ret)
> +			dev_err(dev, "Undervoltage handling failed: %pe\n",
> +				ERR_PTR(ret));
> +		break;
> +	default:
> +		return NOTIFY_DONE;
> +	}
> +
> +	return NOTIFY_OK;
> +}
> +
> +static int mmc_vmmc_notifier_callback(struct notifier_block *nb,
> +				      unsigned long event, void *data) {
> +	struct mmc_supply *supply;
> +	struct mmc_host *mmc;
> +
> +	supply =3D container_of(nb, struct mmc_supply, vmmc_nb);
> +	mmc =3D container_of(supply, struct mmc_host, supply);
> +
> +	return mmc_handle_regulator_event(mmc, "vmmc", event); }
> +
> +static int mmc_vqmmc_notifier_callback(struct notifier_block *nb,
> +				       unsigned long event, void *data) {
> +	struct mmc_supply *supply;
> +	struct mmc_host *mmc;
> +
> +	supply =3D container_of(nb, struct mmc_supply, vqmmc_nb);
> +	mmc =3D container_of(supply, struct mmc_host, supply);
> +
> +	return mmc_handle_regulator_event(mmc, "vqmmc", event); }
> +
> +static int mmc_vqmmc2_notifier_callback(struct notifier_block *nb,
> +					unsigned long event, void *data)
> +{
> +	struct mmc_supply *supply;
> +	struct mmc_host *mmc;
> +
> +	supply =3D container_of(nb, struct mmc_supply, vqmmc2_nb);
> +	mmc =3D container_of(supply, struct mmc_host, supply);
> +
> +	return mmc_handle_regulator_event(mmc, "vqmmc2", event); }
> +
> +static void
> +mmc_register_regulator_notifier(struct mmc_host *mmc,
> +				struct regulator *regulator,
> +				struct notifier_block *nb,
> +				int (*callback)(struct notifier_block *,
> +						unsigned long, void *),
> +				const char *name)
> +{
> +	struct device *dev =3D mmc_dev(mmc);
> +	int ret;
> +
> +	nb->notifier_call =3D callback;
> +	ret =3D devm_regulator_register_notifier(regulator, nb);
> +	if (ret)
> +		dev_warn(dev, "Failed to register %s notifier: %pe\n", name,
> +			 ERR_PTR(ret));
> +}
> +
>  /**
>   * mmc_regulator_get_supply - try to get VMMC and VQMMC regulators for a
> host
>   * @mmc: the host to regulate
> @@ -293,6 +368,11 @@ int mmc_regulator_get_supply(struct mmc_host
> *mmc)
>  			mmc->ocr_avail =3D ret;
>  		else
>  			dev_warn(dev, "Failed getting OCR mask: %d\n", ret);
> +
> +		mmc_register_regulator_notifier(mmc, mmc->supply.vmmc,
> +						&mmc->supply.vmmc_nb,
> +
> 	mmc_vmmc_notifier_callback,
> +						"vmmc");
>  	}
>=20
>  	if (IS_ERR(mmc->supply.vqmmc)) {
> @@ -301,12 +381,22 @@ int mmc_regulator_get_supply(struct mmc_host
> *mmc)
>  					     "vqmmc regulator not
> available\n");
>=20
>  		dev_dbg(dev, "No vqmmc regulator found\n");
> +	} else {
> +		mmc_register_regulator_notifier(mmc, mmc->supply.vqmmc,
> +						&mmc->supply.vqmmc_nb,
> +
> 	mmc_vqmmc_notifier_callback,
> +						"vqmmc");
>  	}
>=20
>  	if (IS_ERR(mmc->supply.vqmmc2)) {
>  		if (PTR_ERR(mmc->supply.vqmmc2) =3D=3D -EPROBE_DEFER)
>  			return -EPROBE_DEFER;
>  		dev_dbg(dev, "No vqmmc2 regulator found\n");
> +	} else {
> +		mmc_register_regulator_notifier(mmc, mmc-
> >supply.vqmmc2,
> +						&mmc->supply.vqmmc2_nb,
> +
> 	mmc_vqmmc2_notifier_callback,
> +						"vqmmc2");
>  	}
>=20
>  	return 0;
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h index
> 68f09a955a90..7da053095c63 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -342,6 +342,10 @@ struct mmc_supply {
>  	struct regulator *vmmc;		/* Card power supply */
>  	struct regulator *vqmmc;	/* Optional Vccq supply */
>  	struct regulator *vqmmc2;	/* Optional supply for phy */
> +
> +	struct notifier_block vmmc_nb;		/* Notifier for vmmc */
> +	struct notifier_block vqmmc_nb;		/* Notifier for vqmmc
> */
> +	struct notifier_block vqmmc2_nb;	/* Notifier for vqmmc2 */
>  };
>=20
>  struct mmc_ctx {
> --
> 2.39.5
>=20

