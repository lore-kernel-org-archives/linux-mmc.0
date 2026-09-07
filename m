Received: from esa.hc6817-7.iphmx.com (esa.hc6817-7.iphmx.com [216.71.152.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B5137E5E1
	for <linux-mmc@vger.kernel.org>; Mon,  7 Sep 2026 05:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.152.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788758447; cv=fail; b=N4InaUAHX+WzyxMPeOC6zpsmfIF+eAIVBCNeTUXP8b0wBAZGvc81ug+ssuOow73I5ol7a+oewZARcvy+my2y82jEOak9f+UIoOWeVzYfJeCG3nB8O82zp6Xc77Qy0rhkjJOivbwW+nxNkA3UsfbDNj+4g26p0Ws89ezmWjpi6iE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788758447; c=relaxed/simple;
	bh=BgjOxWivKyJ6BJ9IAn8lMBu9gfoFn4A7SXY+pkrIy1E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=i3eMjEURwQT0edK4sMKi6CgRCEDgDV7XoqsG5+wBMGoxnX/olz+a/HK0Dze9Q0k51M2VCNamJ5TjBK0AAOuscKrwISdOZSi+HE3+I6OBnch2ANq2GUTNqCEfD0lTAW4tpc7kOrJtU99NTt83AyfN4HsVLBshvln2ZwlU6Gz4Aes=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=aYhc3uMS; arc=fail smtp.client-ip=216.71.152.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="aYhc3uMS"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkimnew.sandisk.com; t=1788758446; x=1820294446;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BgjOxWivKyJ6BJ9IAn8lMBu9gfoFn4A7SXY+pkrIy1E=;
  b=aYhc3uMSvF3d0ZVNStGo4xd/s6F9yS3cIRhEk3SCGMP3twshjn6JpD6e
   RqDOLkuvThjkRFWsiaY9Yz/SnFwl7zaZaeugDV47ENKkHZW7zhAibZdjr
   2T1y+AWjlrHHDcuc1vg7E2FMq3kZUk7rpwBydsGj9f9PP/VDTqLQKZ7dL
   wM16JypDmw7USZfoI9n8sPWWrXbsXzcbIvy5vmmLqeW3yFI5dmKC9PMc5
   mY8tql0CPladXGw4Y5ABknPDDn5ZKY/p1Jh3zrJ7XhGUqq37WoPvjIy3t
   PNlqzazzlrFM8Dmpc5y8HK9egqIOVIaU0F065pTUU1z+pSO/6Z0sO8A/W
   A==;
X-CSE-ConnectionGUID: +E7oEOHmRAqw2FUYqFBr4w==
X-CSE-MsgGUID: tpPqjBZCSTCZ2XIV8Osc7Q==
X-IronPort-RemoteIP: 40.107.200.97
X-IronPort-MID: 29630251
X-IronPort-Reputation: None
X-IronPort-Listener: OutgoingMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
Received: from mail-northcentralusazon11022097.outbound.protection.outlook.com (HELO CH5PR02CU005.outbound.protection.outlook.com) ([40.107.200.97])
  by ob1.hc6817-7.iphmx.com with ESMTP; 06 Sep 2026 22:20:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gU3O/qL+nvDAbEjKZltPS6rcgWW99LPTzlt3mP7r5Eao//OXh3qlULefobrHff4em4FmN/l7y/6zR36LlT+bYGkRgxZ6kkyiJe0KSP/YwpFglZ4LkQMRAC25apBTjmuFjkWDvqazG1+OQztGsRK59FCXk451WY76FzztfPzwHS9cRXq0THsovWOTL/hIYBi+LF2Ixp2BwUaovxsfyE9+6mUJjOVnoLJGdu+aWwbNvMjFxxChc9DRMNsrBcbtqCRvwPheHOmhL7PyEJTYaCMWaCbfbqJOv5pYSsJfcTUgb2nV1X/TXQsLLUh8ufUw6sMNcjhWyFHlTYrpgmzLMaIVkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BgjOxWivKyJ6BJ9IAn8lMBu9gfoFn4A7SXY+pkrIy1E=;
 b=hGTK4mP6IosI8bPah7wJcmxq3S73trSAKr6mA8LNhtdhNfSz5B4dyGewxwqz/C9NRn6g+R1FR/uKjG/hAeCLZDnTJIX+hnUVV9YknCLGKwaFtUMAe3EeKCy5DB0uUcVCtHPig6mbwR02hAFgcT+q5PHblKXxswLAgi2er/x42oqXQR1ZfKAw14XkbBnUUA04aQCGGwsShJogbm8c5AkUFU1ZawNpUWH5YkHzMWMfy1/Z35SYOuMA/6Pjo1wwkpGvBYieV03U3MXC9TcIMsKw3Xs+vw4u0VBphv5EIDoECjGT0qOYGT4RHUJasfr3LHrtfMPDS+wph9NoWkvpEezGfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sandisk.com; dmarc=pass action=none header.from=sandisk.com;
 dkim=pass header.d=sandisk.com; arc=none
Received: from DS1PR16MB6753.namprd16.prod.outlook.com (2603:10b6:8:1ec::5) by
 SA1PR16MB6243.namprd16.prod.outlook.com (2603:10b6:806:3d7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 05:20:38 +0000
Received: from DS1PR16MB6753.namprd16.prod.outlook.com
 ([fe80::72d7:97b5:4539:a90]) by DS1PR16MB6753.namprd16.prod.outlook.com
 ([fe80::72d7:97b5:4539:a90%5]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 05:20:38 +0000
From: Avri Altman <Avri.Altman@sandisk.com>
To: Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson <ulfh@kernel.org>
CC: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Shawn Lin
	<shawn.lin@linux.dev>
Subject: RE: [PATCH v2 1/2] mmc-utils: Factor out extcsd revision to string
 helper
Thread-Topic: [PATCH v2 1/2] mmc-utils: Factor out extcsd revision to string
 helper
Thread-Index: AQHdPmSWMifg7+0dgE+Dg21c6oznZrbClEnA
Date: Mon, 7 Sep 2026 05:20:38 +0000
Message-ID:
 <DS1PR16MB6753505912E785E6A4664AE2E5B22@DS1PR16MB6753.namprd16.prod.outlook.com>
References: <1788742944-94637-1-git-send-email-shawn.lin@rock-chips.com>
 <1788742944-94637-2-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1788742944-94637-2-git-send-email-shawn.lin@rock-chips.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sandisk.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS1PR16MB6753:EE_|SA1PR16MB6243:EE_
x-ms-office365-filtering-correlation-id: 32038c08-4a6a-4189-8002-08df0c9fc0b9
x-ms-exchange-atpmessageproperties: SA
sndkipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|10067099003|56012099006|11063799006|4143699003|3023799007|18002099003|22082099003|55112099003|38070700021;
x-microsoft-antispam-message-info:
 4cPJWYFzbpaMPpe0LWN4ktIr3dHzSZ/wKelbWAMWvnkcqJibWYfzwsDQJ5+ob/NXOXwX5YH2mQ7MxWDzvb2Q9c8xaDk2sqgg0aMchAll6uNnIBVeLe62kNymVxINaPRqDlI5vOb0jvuTqlUEE8Zf8jmsAyMm28zoWszxCQzNEX6M9OEnjRDjqAuPSu7C9SE4jM8WClj5CO+Y/u53LJISiFT7RtsqDOfM0IBJz327iykMFQRnCN6fmafPLeOtAxMr56lt6GcV7FDERaDqyYFz+Zd42rhzIVz0Kckk8lnYDqOWt5Pjv5KRNBiNWmVTpamzOtXkjPfWwiw+FGzuCrQjpUZmJ4pP4Gwj7nm4Q89X0dhLI/uPsNBY7eK1sMn08qKlyf6ZUIewGtbNsrzCzqmK6clLFtNE2d/KxvS8yCUhPLmOfxlivuNjAhjcsFJmmReLQrPXnbP0QsXA+etX66gx3lNYG793NFJnU9L0Bm91k92uI9tVuDlPYDnqK8PaJEYGzb3NqGkLnIzMMw3FW0JSkKOYcZ+xigAUCQNQO8ESCwbOxvQAnLqicafyXLAY1QEomO/dNdS79GQib6f3BBUB5ejTwcpXLaAYOvetv9M6ZEmA5B388VBS0iSDxiatGGS7fPUy4a5oMTgYxDVGwE4ACVnFYAhTBQUJg9fqG8gwq8N7N9OMR2h0M36VEcQ2/vcozb72Pa64apAS/U8qpOM4BA2GYOCYlVg+WC9/2C9cs+c=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS1PR16MB6753.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(10067099003)(56012099006)(11063799006)(4143699003)(3023799007)(18002099003)(22082099003)(55112099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?MR9vhJnamyYPOADzc/0Da47YeUQpbR5EcvyNGtthxfZ3GA1JXca5GB5ewkRX?=
 =?us-ascii?Q?HC4/hvM9GszEsxl/fJcahI9LIbaMz92M4m8+8UU7lbXHciPqldH52N9dqG1d?=
 =?us-ascii?Q?yb+thQZBHQy+mRKj0z82q3YKW0qCnvNldfQ6BdB+df7HdcvUa6NWkiLYiBNj?=
 =?us-ascii?Q?ex9sakq1mAx15pFOkJoi/DX/yKk1J/3Mx0FPr/fHup+qywPv8611bL3Ntu4v?=
 =?us-ascii?Q?hlreE8P1BfBMEId1vMB0IdnvHEHjRSn3e0eTXebeY4DRd76P1IV01lt6CHWG?=
 =?us-ascii?Q?lq829msIXhMCQMP9hS0AMxWBk+f8zcQ+gaCeqpAo37vFGskf2DPb1fFHgrd8?=
 =?us-ascii?Q?blfBKpo+cQ5H+blyi12yAVvMJhdm3Tla6TfMnH0yWjyRaKpfXATczvu02QM0?=
 =?us-ascii?Q?zq+KiX67Ba4Tz4aA5BdJSybOzM6GwvH2ck3rKHJILwm2/s/ixGBHlHA6xWGZ?=
 =?us-ascii?Q?3gvzlWGzj/+ruEnS4CNwJPAvZvs/BCNjvGNpiEiG4xwC3p8KFrSTwRqE8Kvy?=
 =?us-ascii?Q?XFi1PuN1GYmr+9G0/4rs3HfkVOKT9AWb6czyXoUCEXXEgICh/8HrWNVQxbmW?=
 =?us-ascii?Q?LASyKnLqndFKtVD6XDsvS3MKFlG7WBKKEU7JmwnpoYk6EAKr+De1Xyz8xE3l?=
 =?us-ascii?Q?gsJtjJmsYGVXRNXLTWpXic6FMC3RefhOUfHVomd4Fj4IiftyN87oZGF8ozw3?=
 =?us-ascii?Q?mgLy18sNki9FB1x8CyCqNLrxOFWV1IdCqHQveWbzBmB/RT7JiSngEUt0mX5w?=
 =?us-ascii?Q?INJFqZM6x9Tg2iQAh6xi00Sh8QczM69bfkjDmpfxzl/8X/Vdjvgaq3gIyCyg?=
 =?us-ascii?Q?ygKEY4m7YoSJs891wVUwV+Grz0IFI8D9dQv3HSK/Q58ZBkoUNa1x+qFRkIvk?=
 =?us-ascii?Q?2dKhQ8M0uuQOOBK/FAsaGszkzWnxeYtNIF9BtPXox+OF/vfUAf4wtCoIa0Dm?=
 =?us-ascii?Q?KnPUTowz01V37nBlIElDYn5VycHNuX2VWNTEBQJIdXl/q6W7d+AZ1qDFuahD?=
 =?us-ascii?Q?7GZVMEch8Ppm7se731ljOQ/tNaw18xtY9Y2WeNwRR/vBuauVlAJNGJyJMBYV?=
 =?us-ascii?Q?dZvRsorVRLykz7kBYdeDSJFFZNA7uQsomI7x8dJAu5yJPzdmkpWs+n2QI/pW?=
 =?us-ascii?Q?PMOh1AvQk4PvYN9cISk4/muQRcR90Fk6qWD2wmHpO76iBe3EesSWpbrqAyup?=
 =?us-ascii?Q?YPoB8//LjtqNno7zhycgVL8b5rxc4SHPysHdF68F8YJhp03iFYGUvtpIHVSV?=
 =?us-ascii?Q?ESRHycDIIdws5TOoiRS25n2iNOtBq4URix/ZsNr4vdyWyCqxWdtWkZjFGLfK?=
 =?us-ascii?Q?ir5tG9blOQnortFWwiJs6Pf+syN2vSsLBsGg5C3PchaV9gPsigPtTP6vbZeN?=
 =?us-ascii?Q?1Iuk+WCQsBBlir1IoU7bXYZ32GqccINHHlWqyC08DDOjZtdyXgMFVx4kB6iO?=
 =?us-ascii?Q?o3phW2p0EYpVOwh48anPPPWQWhVlCGmk8QJLPVQk74aADNQKxfvJwib40L67?=
 =?us-ascii?Q?xsTDBQ244uegjwcqoqDz2tuR3nCxBHgLHtHlJx+vNiGh0U5KShoFY2XRsCKV?=
 =?us-ascii?Q?SzU1chIkr26Mkuj/SunK6U6245VUog8RBQYyX76uoqDvIgPRWU8likzDQcos?=
 =?us-ascii?Q?sFB2S839AYMwVxCPhHVgt2AVrdYFLCYPPEN1778zW9AoxMulgMOgfGMc6FHK?=
 =?us-ascii?Q?Il3cRnBP8EaZW+DrX2K3I+kQtfwgOcAZWF6crtItooJBq7XFayDRvRz2hNpc?=
 =?us-ascii?Q?Cc/QFoXghw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	Z4ZUNKviKJOGHiRlHbv1jtUGaIfMOhS+9T5JfuT9DhcCS0kSWBrr3/uIIrEh84IxaDeYM5L58/s7EuNLtDW+CQ6HL9z1VTzjiVueKeTWzxeXtqeyWcxPLHo/pXLwLOr2/WxKhQBpaLgC8gxmYL1GEsVgLlGn3elANdaIiZ2q9wMdfoYimx97409TlBgp6ZmjQ+kcztbVtvsApb9WCFvdg8f9OaGvaj4LW2CvCtWIOENEHs6/AkbzLJVbFXslTGhxprY4qjzgAsWAgb7KRyiRS3xtM9NWPeoXyvn3oVHWWnI7ngChite90uweQWzk5ZaoUdCJr9CAWTos6M7Qh11R2A==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jR42VFtAiW4fgqra5ohSsNi6jPJh/l7s62sE1xmFeszb1Wj0PnuwRxpmPjJ+m48I+yC3T4pRG2i4J+FJF0NjkteWwi6IiK+G2Rek6MK0RB3wWMc/qmgQmMnk1mmFn9Ld8E+PQww6zpeQ/o50g6kNeU7iT3cFbZhMSmOouAx9U164BEGX6UFlVeEnmOqZvNH+baF9a2CeFu6cCnP0k5y1tfpmQHT6v3wdi/O1chEV6M4kr9R3f/VO2P7ZevwwVGWP0xxfVk6Gvy7LgMQEaoTpD5GlNMrQsRRxsaUwfGuA4z8XqClJ7IPDaTYtW41xe3Z6T+01oBGFj13b5qaFLG852fJA8/g5c/gFyJAhZJwN/3BtRR4P8tOd6U/328TQoPrZgWyCLRCfS/N+UxQTDIFZklGINxr4WmgYaU1sayp/sQT4cLiqM10hiIcGHG54axAVvkSFSyyGgZIxT6q97BaneSx78sYeB+xIS1cc0xbqA0yMao+Z6x/H4aOJGqhTCp/8a7dUQ/VHmsI0SgDra4PuNgj17/k/d6yasaBUEk+DftlbCGggigsFTha4HkT2uYsNv3HNeYbvvD+SaNbP+BAeNEArACrSTKxqGJmN3IfHkZ+Hu9e3PR5/VxQ5SBFQljNzOjharrGD6byv3j39ZOMkOw==
X-OriginatorOrg: sandisk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS1PR16MB6753.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32038c08-4a6a-4189-8002-08df0c9fc0b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2026 05:20:38.2578
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ffe0ff2-35d0-407e-a107-79fc32e84ec4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mg4GVcXtHlVVvZsRORyy539tdxlRoIMVM7P442LJO+Elk1I0y6K0p2e/noBA8S/yTxEajpcBZug8wYG28XdZxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR16MB6243

> From: Shawn Lin <shawn.lin@linux.dev>
>=20
> The extended CSD revision to MMC version string mapping is open coded in
> do_read_extcsd(). Factor it out into a helper, so that it can be shared w=
ith
> upcoming commands.
>=20
> No functional change.
>=20
> Signed-off-by: Shawn Lin <shawn.lin@linux.dev>
Reviewed-by: Avri Altman <avri.altman@sandisk.com>
