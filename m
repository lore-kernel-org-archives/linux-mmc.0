Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DFE175BF
	for <linux-mmc@vger.kernel.org>; Sun,  9 Mar 2025 06:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741502401; cv=fail; b=lG5AZ8Dhjxg+dBLSOgcANwRT1GL0TTp2vHXKWkorw0cFUOf5+58jqCmD+0TqYmO6AfCrNNFuIcUFP0/qe6Imvu1Wl34ej79gJDAbR8PnUPcwqAYBBE4wZw0qQIZzyBbAlBXqU9Cz2pM8RT0epQ9R3FXcdShEaHLUrOEZIks0NDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741502401; c=relaxed/simple;
	bh=0BS3SMAHBbcJQkJQPREAfNMxPBqZFa5iZ6xIsCy1o9U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rAErTt5PKpw66yvVL2kh996x7JQfbozPryVAcIq8iMgX7baWvs6XnZfzSGHbDPa7WaGniBfILAPNJvnEH7DOAjop4zypptQofNC4hHZbJgcmzW5sg51/Kk1iyRZxYWLBymjV6ZvC3dY2hG7fsaenIMynBqcKhxQ9PdK7dpgzVOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=Wz3biwZl; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="Wz3biwZl"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkim.sandisk.com; t=1741502399; x=1773038399;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0BS3SMAHBbcJQkJQPREAfNMxPBqZFa5iZ6xIsCy1o9U=;
  b=Wz3biwZlJh0XurX3yJmqJnw8RfAeCU8uXHiUYPO02ABfYffAqPSrOS3N
   nsttVWJ6vfTb2abGltoZtc3ZZ0Xh9MtxMiUh6hB97uD4PcEThAUnmf0NN
   WRwF9ZHcaZP1gogWYs7DfZ4aV8Vl7Tgr8DZV1KwGqrf72ey+cTZiTtHt3
   kdPlnnnuQhauUCGlLzfxv2RITE239oPkEOkvQd6coT1V/XJG1xJ7s2zbh
   h/SueY3TPIoi9CgFj8JY4PlUjUjr1w/NiO+51AMe7HNuDh2Ey9tNB7QxL
   tpn8gRjkWEgeJ6xLANZANytKkyNlmRvYlp0ilZGPM2qIdeRtUZ3+apKqa
   w==;
X-CSE-ConnectionGUID: D2RLmCBfQ22PiE1w2Lkr0A==
X-CSE-MsgGUID: XKSqKy7URYiFMUFyDt7QOw==
X-IronPort-AV: E=Sophos;i="6.14,233,1736784000"; 
   d="scan'208";a="44409052"
Received: from mail-mw2nam12lp2041.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.41])
  by ob1.hgst.iphmx.com with ESMTP; 09 Mar 2025 14:39:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BB4Qyk7MURAqpafskEFDRKEckYcYq2vtV4Zy9HsmMhhcGCV6nvP9BG5aFIYNtDC5Dv+ZUR/etj3fAZtBlByGEhGteVIQWR5yqXDXoj5bsCCOUH312wp/7UW9GzEzeAYuOzhyVFEc8sXcjQUp4BtL0H1M0NaPpgElUNnvEW+wXFKb7u8ce2zfZHyeOOiFowRo3/Zc7AkVBpz/KPO+fS9DA5fAA2jHpyMnUqAh7FrLXFu6BIC8Vfj1gHXgygbSfEfMgr2eO65rprt7N6GP0EojOhsMS4v+nVXJ1484yVTOUsPL3tbvCbCT7pP+fuztHh6rpOGkKeIQVRDpCQbubfTQyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OHnn137z3GgKPrmd+pqiT40V0F4brXkXhyKp4uoRdhQ=;
 b=j3JeaJzFsaUoj6npyqZ9bKcRSxRsJGqVRVW9sFvefEEt7Jhl07ITI5Ix1NAueLhRvSfhiB33Nj3CggIGPYmREt5tiZBAXO6okWMjfY1lk/gEDbOXojmf7O+WQRmFgdhZlhRJtjYATAXIC32mI6yUk33Y1phD8hZbd08cA388AaC4cBsadGqSP2X8qaLz1Rg5l5d6dPbjTyhGP5g00f4BkJkHbMdahveNQFcmF/8fLpviLLKhdBxFvAeXpxlOCeWFI9C1cIlwL6TqJxALw8eo7vOgMLlC2LLa4jbxT658AYglAUOrB9XYeAbtCXpDEsUc6L5BaP1uRr/cMICuEdLjSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sandisk.com; dmarc=pass action=none header.from=sandisk.com;
 dkim=pass header.d=sandisk.com; arc=none
Received: from PH7PR16MB6196.namprd16.prod.outlook.com (2603:10b6:510:312::5)
 by SJ0PR16MB5173.namprd16.prod.outlook.com (2603:10b6:a03:4eb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.33; Sun, 9 Mar
 2025 06:39:49 +0000
Received: from PH7PR16MB6196.namprd16.prod.outlook.com
 ([fe80::58f:b34c:373c:5c8d]) by PH7PR16MB6196.namprd16.prod.outlook.com
 ([fe80::58f:b34c:373c:5c8d%4]) with mapi id 15.20.8511.025; Sun, 9 Mar 2025
 06:39:49 +0000
From: Avri Altman <Avri.Altman@sandisk.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>
CC: Christian Loehle <christian.loehle@arm.com>
Subject: RE: [PATCH v2] mmc-utils: Documentation: Add missing entry for
 "writeprotect user get" command
Thread-Topic: [PATCH v2] mmc-utils: Documentation: Add missing entry for
 "writeprotect user get" command
Thread-Index: AQHbe4cKULnSYV+TRkKxwc1mF0eJd7NfkivggAryryA=
Date: Sun, 9 Mar 2025 06:39:49 +0000
Message-ID:
 <PH7PR16MB61960C134A62DB27133384BFE5D72@PH7PR16MB6196.namprd16.prod.outlook.com>
References: <20250210063947.3298-1-avri.altman@wdc.com>
 <PH7PR16MB6196EBA0EDC021E8AC7A24E1E5CE2@PH7PR16MB6196.namprd16.prod.outlook.com>
In-Reply-To:
 <PH7PR16MB6196EBA0EDC021E8AC7A24E1E5CE2@PH7PR16MB6196.namprd16.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sandisk.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR16MB6196:EE_|SJ0PR16MB5173:EE_
x-ms-office365-filtering-correlation-id: be88477a-3923-4704-2ee5-08dd5ed530d9
wdcipoutbound: EOP-TRUE
wdcip_bypass_spam_filter_specific_domain_inbound: TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?uiIfWY5YiGwQWU52AbH95bLSAtkUPvHkmIfvD7eN6Coj6l7ZrbuRt4bxJf8U?=
 =?us-ascii?Q?tTwgKFqvYRVyt2+ck8XbRYS0y8sNc3/AntfV2tcbJyT+5PpoqFXfpYhHe2E3?=
 =?us-ascii?Q?7KAuDtpr5b5oYwAdJON9CnjqJH49KeOIR8Hfae3V1MZeqt2TQ/MIMJFU2zsD?=
 =?us-ascii?Q?0WxuzCIV4DxX+kinvqXnIaLfki9VVPmyLDIVsn5FToJuDkW65EJa780RaKsf?=
 =?us-ascii?Q?EqTprqLkWEROwzCcVqY0hd2kxM7pQYREgW4ZVGI7aHK1juSM+qo0ZzOpwRYB?=
 =?us-ascii?Q?wcIIIw9XxDS71clzKnia7tEIZFBOGlBK6wq+lviT/PZ5tCcQgU/lSXE6SD/d?=
 =?us-ascii?Q?G/Jr0Ka9aWs9HoKd2reIbY1IARpRdFf5nnIZzjJ0wCvItMRdJZNbBkyGE36b?=
 =?us-ascii?Q?vlMdyI+VYwe1HZH9Nyq8IfFqeqWBS9t8FIMkzgALet8m5bbmIYxeVQ7ROqp/?=
 =?us-ascii?Q?aIx5g0HIdTbrinKCTWUD2oupC7k4n6bJ29cvzq05m52V/Y/m9cv9hfp1BgUK?=
 =?us-ascii?Q?CjKMxLnUw0Lqwk4O3XmzrP7QHyQi2CjLxEudzt4aCrIKZfJXwB5vBulJhS0+?=
 =?us-ascii?Q?VcTxQMyukow80CPejRUSCXw4WKxDh1Rc0rNjOgkSpn2Ym/dncn5i+VMtOj6S?=
 =?us-ascii?Q?LqQVdsCQpz7vqiyX/dLh+hsoG9DcSlgEmyZdINyhhLwL3XZUnpjrdxVi9toI?=
 =?us-ascii?Q?XwUgG/JSOU9nAV0TQb4QVtFdACQKq3Z7KX4KoZvRbr4+Mrp9RQUeAVK0imFJ?=
 =?us-ascii?Q?bm85BU6BJqOHAQsw7crTzjtKJ3U893o5CeBTrx+I+b6A9oNgp1VpeyMcaHIF?=
 =?us-ascii?Q?G3PCDv9muaDnv3eGzoWiZeRFrLQQ+teGBpSgslUywqxobe+4+Z5jfXX95vkv?=
 =?us-ascii?Q?3119dqqRzneoh7fSiLBiz8FvcQuwU7tHw4TQSOmxPz3fjh5e3tDLuP6a0Ulv?=
 =?us-ascii?Q?U7cuMMZBhFGhNJLhCoDdSo3tMpLljPCmtprUKPWZVg3J/riDm/Qf0GmU2s1a?=
 =?us-ascii?Q?FrM3WFCyMCxXrHVMwkUXIA7W/3UF4PUmjZFuSiR9xZaZTa6ouobT5/EI2Uya?=
 =?us-ascii?Q?Op861fQDydR9N7+PNZs0Uu9liDRolEpxnZZUYoAAkxGJ70cIf8GKgi0iajJ+?=
 =?us-ascii?Q?sckQsRwtedSHonNrZi9wyPrm7fEDIWPPPtFD88QLsPgiBwiS1VbB7BnCtzdV?=
 =?us-ascii?Q?eFYf2Dd5KGBSkmPhNdQ0ApOZ8f68kOSumS5+9BoM9dxwHnDMuAcLyuJujc4E?=
 =?us-ascii?Q?CrDov2+DGcx5HL2mhX0PRanXpBCct74EhJlh0/b9zH13RSnq1UAWEfh4QB2O?=
 =?us-ascii?Q?arH2g3V8RhoCmRQZK75wI1N+na7dp4m8sSXZnCxNsUqw/fyL3qWDKy7Vb5/6?=
 =?us-ascii?Q?RT7vh55CnFhFrn0FhPPtg+9hedvDDgSs5b7FA4Bq5O5rladCAnTlJxa3Z8Q1?=
 =?us-ascii?Q?7znjotr5Sdoc0uo6prgbPbS8T/lP/HeS?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR16MB6196.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?wYc7qEoydfNmWIYY38ued4ZY0aRhzwFoVt1aJY4IPsPv8vT0FMLZMofOwY5f?=
 =?us-ascii?Q?pjb9BKOZW5cBDIkRvOvj+mMwXU2nCov5aEKdhDWgRrA74OVlkAYn/5IvZDqV?=
 =?us-ascii?Q?tOjYqu2Zmy3fzL+il9nl2Lyu/qAyYRE0C72et9iB1vHPXRiocBWskY3E2Tst?=
 =?us-ascii?Q?axVNphLwYIw/t9LresRP/qL3/CKN+VKhmkf17wAkmUO9slt40PLLuB2L5/BF?=
 =?us-ascii?Q?p7iodXsiIdfI4gbYXlPNdByD7mSbU2+77aGsltVu3vuB2lf6v7osph6sFdhM?=
 =?us-ascii?Q?YKT3awtUDec/ldHfAMr5W1HCBkEaRo3ZU1Pd1MDDxFi5JmJvrYp9q9HUWBt1?=
 =?us-ascii?Q?NjuSrUfCft1tvy92i0i76p2N7FKcoh4XIT6dN+0nuaoe4x8gKomiL3pIWmr8?=
 =?us-ascii?Q?Qfptg7JibPcW7NsMzWblRgCNLLPhPmIYQWf7cV5Zi1WAIbFIR7OWY0OCJENq?=
 =?us-ascii?Q?l2jqOHcZWdvPene/jHJqVv5uXVStDPxkU2iH1u51hbAJ6+QHiZFrJ13qZBfh?=
 =?us-ascii?Q?D5eJFxBpm0Uz23vioW8zoJoYKEzxlsVUECIyixb+7cm3rCqwFaLb5lU1Kk6e?=
 =?us-ascii?Q?4gOYIu0hTzhOsW2pcO/ubdvw+bgpkVnJP7WGxajKxsKtnAkrDZqa3d3RfxJA?=
 =?us-ascii?Q?MUyKvAZUSNh95YP/Qt27lOtdorUFuVWaSE2gXzYqCJr3ixA8O0wvBnvfenRI?=
 =?us-ascii?Q?LiCFsiIqQV23a4c+d6ck2fuaRYAMsedtVW1+uu2xWF3v9ecrGkRdmh819gJb?=
 =?us-ascii?Q?G38tVRpGQ4gOQzZPUDntvFc+UaO5t+R5fMKkhUkwsOEkkf3g//HQVBfv6r3m?=
 =?us-ascii?Q?gNGQZ9iSz0zbCKthq2XKJIz5XpVoCgGaVzjJVOtM5P5gD3kIeaxmNHo80NOa?=
 =?us-ascii?Q?ms3p3xPGPiOrVjFW6sR17vObjLQY4S035c03c1QCl/iv1vqArS4imLM7nmGM?=
 =?us-ascii?Q?lIX32+z6XLNSVqtRMYfpr/k2gifdzvQARwtmQFENgXH8wdOY2POWon0kFLSM?=
 =?us-ascii?Q?e0yX8UUaGEYnINoOCDBOlgWYp9wn1SkqTw11tTNiauylZzmhVf7E/wETf0LF?=
 =?us-ascii?Q?biRuDVQ8UuuhGUM8DCPI6O1qpy2TWZ8+ZazVpSzwTmQcV8x8tDN+FqnreH6k?=
 =?us-ascii?Q?TwUXKeGmEXvAc9uRCrlb3znae5xvKL/kFdhB1b6kNHw57+/+rD0TEXF0HEn8?=
 =?us-ascii?Q?c396WIWBBjqlzSeka0rUDU45pjPcFJIj2GIh8aHPXJIuSFXLpzfaPceYJM2h?=
 =?us-ascii?Q?cx+13MdDEoV2lqAzvvbDww6bDjMyeZ1BQrLmWwlwbnszaDtgcxrBeOq4CLC7?=
 =?us-ascii?Q?K9CVuT1eIw+yZG0kB27mGMCMYEIfNMu0y1cm+VBMuXJe4FCVu0JejsoSwKDs?=
 =?us-ascii?Q?WfZELKsKN1hr6Cum3UNWKiQ/gbf2Yd9dCtK5VwA77oGVF30mRzNq7Pat3e1T?=
 =?us-ascii?Q?D+0uNqzWVsiMXo0CdbQ/eSlzaQchFbot8rYeNWa7FIa+q5nz9kYJJadXm8rR?=
 =?us-ascii?Q?vq5SxoFWkuxtMchf5uVeCnhjZNGW64hvmBgM9ArTSdwiniDTDxD7aaqbJmhD?=
 =?us-ascii?Q?YZfitzdpePVpoJ2Wqn6WvBOUmoGXhb+bCeXICF+NmJy/C7vUncOwmBeLDPjH?=
 =?us-ascii?Q?VVqTq+6KHIaloqWGvTeJSIUNXYS+gxdzPx31ceCbyyyt?=
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
	AplcN8sNXKAYs2tHW7ifltvLCWksvDkZwUfYNQMheQGgZqJ1+AGqysW6tcPmEP/KtSDzQMcD5YbCPUWLn5NsXze9aodwMY4JUIk8QsJYHv9qKl27TD1Arsa1xiVAEywBTg5LZcXrLNbeQsG2l9c/IBFqX3oXzhnW0nvdazBZtBqYUZsIJXqD5gaP4W/XyDoyOqlAqqb2IFx9zlryWYC3lulq3HUEl9+3+pW4GVaBK44TxLrNU9DXT0LeUT5wpdyG0oVTKOP4uT1r1avNk4ekig+utSkJHjlbRdYKElJ45rwYIKMFJVB1lMzsi0YZ0ZEnxqLlSLjNe/FApHfvGoqg1BnaFHiw0jRV5L49rOag7C8QWil8B1PFtjzoE8LA2Y5uCCrFb7AFAadYHuN2f+Cfkomo5Pcy/RTW7B3dc9c7kfvP37kPsuHQf1b75L1qhgc320hrUjiFoXoHqdcr3b2iSyYSaHT6w1x5wRlMZTfpSjve8zd1ChjPnjXG5PLqmVxEHjGB/+KXd8CeVpXZs9bsC82YeMuW/R/02zb4cWo4EcuGXorHrmS3C7kA3sKSzL9Xuid37kWjH3kxrpCVI0gboIUbpRVzjV8SI9bHto8iT72omqcwFfBrM+1pgZGBr87w
X-OriginatorOrg: sandisk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR16MB6196.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be88477a-3923-4704-2ee5-08dd5ed530d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2025 06:39:49.6591
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ffe0ff2-35d0-407e-a107-79fc32e84ec4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1C8MVrK8fqqUN+VzYa5zi3Dk1/SOZjUeSam6AYhvL57sGiYcqb7lMdn07qt92WwxqSQxBzNC9kK+4ZuOBdaEVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR16MB5173

=20
> Ping.
And a second one.

Thanks,
Avri

>=20
> Thanks,
> Avri
>=20
> > This commit adds missing documentation for the "writeprotect user get"
> > command to both the man page (mmc.1) and the documentation page
> > (docs/HOWTO.rst).
> >
> > The "writeprotect user get" command prints the user areas write
> > protect configuration for the specified device.
> >
> > Signed-off-by: Avri Altman <avri.altman@wdc.com>
> >
> > ---
> > Changes in v2:
> >  - Fix a typo (Christian)
> > ---
> >  docs/HOWTO.rst | 3 +++
> >  mmc.1          | 3 +++
> >  2 files changed, 6 insertions(+)
> >
> > diff --git a/docs/HOWTO.rst b/docs/HOWTO.rst index 095a9bd..3902fa4
> > 100644
> > --- a/docs/HOWTO.rst
> > +++ b/docs/HOWTO.rst
> > @@ -28,6 +28,9 @@ Running mmc-utils
> >          If <number> is passed (0 or 1), only protect that particular
> > eMMC boot partition, otherwise protect both. It will be
> > write-protected until the next boot.
> >          -p  Protect partition permanently instead. NOTE! -p is a
> > one-time programmable (unreversible) change.
> >
> > +    ``writeprotect user get <device>``
> > +        Print the user areas write protect configuration for <device>.
> > +
> >      ``writeprotect user set <type> <start block> <blocks> <device>``
> >          Set user area write protection.
> >
> > diff --git a/mmc.1 b/mmc.1
> > index 543742c..2f7209c 100644
> > --- a/mmc.1
> > +++ b/mmc.1
> > @@ -27,6 +27,9 @@ If \fInumber\fR is passed (0 or 1), only protect
> > that specified eMMC boot partit  .br  It will be write-protected until
> > the next boot.
> >  .TP
> > +.BI writeprotect " " user " " get " " \fIdevice\fR Print the user
> > +areas write protect configuration for <device>.
> > +.TP
> >  .BI writeprotect " " user " " set " " \fItype\fR " " \fIstart\-block\f=
R " "
> > \fIblocks\fR " " \fIdevice\fR
> >  Set the write protect configuration for the specified region of the
> > user area for the device.
> >  .br
> > --
> > 2.25.1

