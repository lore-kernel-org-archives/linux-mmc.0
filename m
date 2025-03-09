Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5CB2F2E
	for <linux-mmc@vger.kernel.org>; Sun,  9 Mar 2025 06:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741502841; cv=fail; b=QTGUONe3wKkFrciqsyM4o7PTM+ZbKP77Q7jUfIZaPajWeolxzE4b9foTMQfLPedIQ8Q4jTVKtI80MlOQPW/yV6wgFZH/FiYFeGuE2r2UJ8naYT5ucTq3Glu+Hj04bqv7xsi1/u0acXNiSG7mr0d+cGOjp1Fc7hA3oQHuTEHwUFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741502841; c=relaxed/simple;
	bh=5f9sYBT/z0lKcrG1qrHhBoT66W4kusJKaN/zKcix/zM=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=u2VS16q/lcAQ9NYBtmmejk4FnRrqpWYKiG/gdH8itRGTrOR/eQ21ssPlL2NLfZl/zB4dSY3LMsFdRKgcN3NzEezc0zxal8orLO8LN0eg7vGFuRSTd9HIrnIE12Vb0nCZN9J43lrJQGWXX6ZRgTivVj23AnPqAEAWnK10A6eJbdE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=z5eMoSZ5; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="z5eMoSZ5"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkim.sandisk.com; t=1741502836; x=1773038836;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=5f9sYBT/z0lKcrG1qrHhBoT66W4kusJKaN/zKcix/zM=;
  b=z5eMoSZ54Yb82Jysdi3alCoLVSm9VdGPTxmh4y1k/zr9v0+iMf0dPVc7
   +OO+51piuhG0/jnVN0AFfBLpQ0Fir+VkBdAymIcEzhbzIVbb7vLiGCV45
   hXXodr97pQ1LZonW1kd4jIPTz5V5RX3w0VMkGhxv8yr1FKeuvqVdy63gw
   yRJ6YL2Vewm8Ss0ak+2FOfTIvKp4U9240yowOpetjKsirNWXRM2ChR38v
   0KlerYcOZFbYfSdyhvKNp71hhunTNd1TfHV+ChSzVbpmm42FvhKqBLag3
   6JDt8ak/JggOUDH7tXFsso2xy5n2MCH9bYghif661tSNc7o7jkDBAuob4
   g==;
X-CSE-ConnectionGUID: TQ0B/z26QQK8rWatvPVhbQ==
X-CSE-MsgGUID: cqwN2l/xRECtfPIxTgTK7Q==
X-IronPort-AV: E=Sophos;i="6.14,233,1736784000"; 
   d="scan'208";a="45440472"
Received: from mail-co1nam11lp2176.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.176])
  by ob1.hgst.iphmx.com with ESMTP; 09 Mar 2025 14:47:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IamGUCHzDZsyhjjN7l7v+zgMMjuPSyggTVor+INhAofdVzVaXC9cUr53GVaGq7c6C7IayUs4owvd2tauMrHdX5AEEdkQZoKzbNHUXwLuXBx2MF3p8hxjd/VQs3reyOKDIYt0OhLJVaQ2U8W/1NgZKn8usDz11rvQvXAr0dqQDj0YnwFzQeWVrB3Io/W08Qf6Sd08dqBTe7eaaB247zg0LJyH/DYVWKOtZ7AbPsV+cOYHGGIORTgNyijEP06V7ASve0iqSGq3snYP6pX41IPbHFRJ6FGwR/LgOAtvupot7sUOAEdNs/iwgfbFHDPrq8km/4LhMJ0HLMIELzNymaPgmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lGpDgE74mYTDpbno8DDoU4m+F/abMbRVVqLHEeg/MU4=;
 b=WB2AwPYvdy9RN1rzUFyAQX1yF1NSCx3j9tGO/TpNLi0Ivj0ASTK8cQUQZxWLzE7Ng54TAoCZfhRFWfmSsTdjM5RneqJFmN7sl436ZZRqgi90/glD70Ag+RVvo8Y1f2iCQ8z7l4BXUPAz73/KXsaZFv8LtnUKNQQ/9E0ERl4t8yA9izpT+yJFMClGWkvTPegxcXp0prLs9RX3up3IcwVUd5H/6jk3ZvbAtJxU4pskTG1DxZqNk1lGB29hpGLETExwyxbRZd7sHTgSU8i85yYMXZda5VqCOGtZQbUtvecmWRvf2RdDSpMLvxjf5OsRozKVyFV/XsKZzqacmdNxXPrlEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sandisk.com; dmarc=pass action=none header.from=sandisk.com;
 dkim=pass header.d=sandisk.com; arc=none
Received: from PH7PR16MB6196.namprd16.prod.outlook.com (2603:10b6:510:312::5)
 by DS0PR16MB5440.namprd16.prod.outlook.com (2603:10b6:8:156::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Sun, 9 Mar
 2025 06:47:07 +0000
Received: from PH7PR16MB6196.namprd16.prod.outlook.com
 ([fe80::58f:b34c:373c:5c8d]) by PH7PR16MB6196.namprd16.prod.outlook.com
 ([fe80::58f:b34c:373c:5c8d%4]) with mapi id 15.20.8511.025; Sun, 9 Mar 2025
 06:47:07 +0000
From: Avri Altman <Avri.Altman@sandisk.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>
Subject: RE: [PATCH v2] mmc-utils: Docs: Fix Sphinx build error
Thread-Topic: [PATCH v2] mmc-utils: Docs: Fix Sphinx build error
Thread-Index: AQHbfrW8ayQIoCU+Nk+xr72buBwRybNqgJeg
Date: Sun, 9 Mar 2025 06:47:07 +0000
Message-ID:
 <PH7PR16MB6196FE9EF00AA1581AF32791E5D72@PH7PR16MB6196.namprd16.prod.outlook.com>
References: <20250214075146.85101-1-avri.altman@wdc.com>
In-Reply-To: <20250214075146.85101-1-avri.altman@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sandisk.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR16MB6196:EE_|DS0PR16MB5440:EE_
x-ms-office365-filtering-correlation-id: a68ee6ed-31b5-4af5-4b21-08dd5ed635bf
wdcipoutbound: EOP-TRUE
wdcip_bypass_spam_filter_specific_domain_inbound: TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?RDGVQlUaG36Obp1oXtvWYIkqfWdKQ4umgCUaI8ZHXsYojC9UHWk4cC+Ei0x3?=
 =?us-ascii?Q?nmzE/1f1sBKu9Hhl4qUldT1XJhNY38OL5pieSPliNhu4Lxf39ttZq2qnZKa1?=
 =?us-ascii?Q?/J88+Bj5V9UUMc9HyYgTpcO/dPyo2dEMv5SzVtFtE9LApXfsdvMDdeIkSR6H?=
 =?us-ascii?Q?VlhtVdVCxOiVgPO2Rniyujtmh7OaOP+ZpdBQHG8045OZrPyaDePnrduUhwEW?=
 =?us-ascii?Q?iUeRny75brVT6ZpTHZK5ICqGKjjdT9LpOMFGYz7hUC+57yi0Cbrm9dri6Tmu?=
 =?us-ascii?Q?WvC5/e3fAXY8zWgjeVpQUqp0RejOyS8H8wsNsmWDsn9enU3PBPWwzf0seU2L?=
 =?us-ascii?Q?oaa1r99o+hANPG34RG9DH4LRTeqDj5XCPT/B+a0V9rHM5xTKTOujXve4QkN3?=
 =?us-ascii?Q?lPEJOtQ3iYrv+3Yx1BihJ3peUYVu2z9WyqqLdcvFNWCqnx7lCzibkZpY+p8m?=
 =?us-ascii?Q?Un1UkmrcaTyQpjcJebzp1UGhEeZQy8O/bfdn+IIUCP5a/M16ZGJScHNB5kKv?=
 =?us-ascii?Q?K9NGmQFCkMKuMej3+hdSfJH8voycNeayVLgJpwnDPN8/eLNP/vUhLcebCmYh?=
 =?us-ascii?Q?ymKt3l7st/szGNXWY2PuVWd2MN3if/QrRHqehyGsIG/Wx+sloJXxXKV2Xe6l?=
 =?us-ascii?Q?juc1S4z9SlfjMKSB3qVCrWgklNC7hkn5nJoBhLN9ZEsU6Q2XzutNcUtm+9ql?=
 =?us-ascii?Q?bF1FauEgq0W/5CH04HnZG1s0DajCpIvmtt9lPbKRNOWJ4oeYqCYROo+Fk1je?=
 =?us-ascii?Q?qXF8dlrqZXAbVK2tVU7oGxxx5a5ypmrgzJQALonnjvGnRT9nlw/AroJ2vsHr?=
 =?us-ascii?Q?/PV+qhqll7LFgbzx1z/FJkOwpw++H20YlpEZH98PIz1Ps8MUKJmKA4oYGkTC?=
 =?us-ascii?Q?k5LbkNbVmneoHxDk2knYC9oqCPDo9mR3bUMy6lt+v38blU646ap3zUOCubmU?=
 =?us-ascii?Q?BJKSdgf2ne3DosORq99hErCt7fbTDb/dWmMv20VwmVKHKledklNGm4wTV8PR?=
 =?us-ascii?Q?ppPuGpJoy9xHZq9mSeewv/yLTqifpbBd9NYgkZfs2zD2QOTD1UVlAxYplUEW?=
 =?us-ascii?Q?cOzA1Rv0KAdwwdY8gb3SgNl50mW6ZwcKMWdd5UdM7iqNGWl99yn9ngNAuq/Y?=
 =?us-ascii?Q?T+ZnC6zoCuO1pnE3A4H/VqGHcV1X1CQp7Nj2NcfgoleCfBgKYZxiUoQMs1Q9?=
 =?us-ascii?Q?oPJz1YFgCppQ2l+vObQsdweQodt0zeLb/wyomSzhAtpKn63rVBpp1TtxdQ/9?=
 =?us-ascii?Q?ijBsoZDz6a5sRoWyP/gWi7OtGkJ0q4aOJMHRTJE7AJHr+JFnXk/0Cu7yAo+1?=
 =?us-ascii?Q?IFMj/96NuH+IgNO3iQiBfXW0jqu4hTcwcA3I9ktJvkpUjISGBpAwZpCAk2tK?=
 =?us-ascii?Q?Y/TcszAyvcH7iFqAfs/CziMvk1rMdk0lKy34hPAf96ckMSepK5npb65Stit6?=
 =?us-ascii?Q?A96ROcKV3lwKljiIj8FUdL/nSDzcZ9V7?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR16MB6196.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?S6EHjuoTH16ulYoJEEzgYBRkJVDNVcT4Vv/H28E5LkBJNWd7VrnrD1ById2/?=
 =?us-ascii?Q?zJhLVE8CdunV85H4JVDwucUFp0JrzhqtfjDRwBkdUA3If8wBPEAX9l22RW8s?=
 =?us-ascii?Q?DDtn5If4JtwqJwZl0vnpKYgDIsmvYFQ79sgzaXDpdYo+hUBNvkic3o3xi9ma?=
 =?us-ascii?Q?OzKDwdPG4unEYgViMS1eJJ3tc9EE2238YyBtlI9Ja7NBEoBIWPVOKliz6oB6?=
 =?us-ascii?Q?H4MiAXY8t/08WrZoyOyA3YJaKeqHg2qarOPQfVPsAQ861sknZTscI9iO6Pz5?=
 =?us-ascii?Q?fxOB/gA9UZymbnhuRp1ZW2xiRfUT9U87CNieIxp+yK4c2Hr7uuOR5/Z155/l?=
 =?us-ascii?Q?373yNX2pNDO//lV2w/1+EyV1oHb5ceqQ7mggD6LaY+QrbNxUm0rZFcLJw2zx?=
 =?us-ascii?Q?Mb1l1wgw6g7RGH2nTcteCY3Q/MYwNqFiYnV3IHrsmmGtN+izcTf9hsDC4C1q?=
 =?us-ascii?Q?646lss4BJocjaSs7zx+5tSP7TMKoktrUyKv6g3RjHluWnXBputXDKDkp73AI?=
 =?us-ascii?Q?b/Y2uU1lsqqe7OM7XCw9g7ELh6JJCEbjVioZ7mMl7FbkAKt+zaJYVUAynMXU?=
 =?us-ascii?Q?8SaHOz6JWMkzEo0bwc+1iKzFiSt6zwmKmDHJ1JL31pQZ8Y6n4LB7W1F2rYvO?=
 =?us-ascii?Q?ZvMjc/3gYbqkjl0pLwmUbWymcDSehQgipQ++0bZKo6OnMpVXxxl5w5Pc4VRH?=
 =?us-ascii?Q?btb8JkMoDiB2WIjY5ciFtP1o38reO0cXIf6UPW117e+rKccM90hOjxl8/Bxj?=
 =?us-ascii?Q?GL+zeQDl7o7LLYPFPTjHiJR/RlRRfmdmazSvVj9w9x5qTbWW2g60CPKM2YJ2?=
 =?us-ascii?Q?4EUV0KBy+Z75eTcBJQec8/TA74uC8QzsS9HkVN6TsvGR9EaFUDEt9NzUpMhD?=
 =?us-ascii?Q?9q4dfoDyzgEsFWfyLOWs0YTKB8hqzjL2p9k2CmU3iISCYdAQpfk5zZzxFq8O?=
 =?us-ascii?Q?vDeesaXeEYF6rufsyI12qkCI2IyTKQ7EdwGKyIJX+UIP8ttsf1c9t16hXCmJ?=
 =?us-ascii?Q?gT07R2V1nKc2FSbmuBnAkdcWfOFlAfD7JzkeAwds4YW2TtLInhXtEHhDNpNw?=
 =?us-ascii?Q?UQqzdrTAz6Yjq4COsDBwETAJXoRULVQyavnmTjM/qCxze7bzUqzWmXTCRwcA?=
 =?us-ascii?Q?WcaDGqVpI+JU1jKkIfhPSNTihFz/yemKjZuVXtqA+W+TofzrngTo3msG9ddg?=
 =?us-ascii?Q?CgoW+AVvuSFIe/Ee9YIaCIpuZ+FaOXIqSb8pdv2kxKEma/sclYtf2JyfL/9m?=
 =?us-ascii?Q?CKTKI9oHtCysvgOpx+qxFEWFAYc+pYpdanI+FcM4eZNa/0CT7wI50EadRe27?=
 =?us-ascii?Q?5HuH3FDwEk05Bf5CuCW7lguA/JGeN72IWZR6sicCkCJOmzUWNBfFV4J4go8t?=
 =?us-ascii?Q?ilVOJCWVdQPkDO2f1JbOoJ1nDabr7StTTxDTzULTEWM+jZHOuX0tk/mosmfk?=
 =?us-ascii?Q?qrxSQ4UZpu3LgNsFz4bLhXrmzZMNTB03SWC39MZrbXtlUZUQ4f/vTLw0R8Jh?=
 =?us-ascii?Q?OcNJVaPkp+kWEU9u1Xt60KTwzWUzluQoTZyo0CVdhPPnyeiaxTT8GPBKzXzT?=
 =?us-ascii?Q?KS/LFS5EeTu45/9yosVTWVjOGyuEFGrk6gUcydYif9n4hW5A77zcw4/zewO6?=
 =?us-ascii?Q?tblq4TYzlRkKckHFdwwL04EANs/ujKDNwA/4mq5dOU4v?=
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
	Kl3h0QD9Jh054AL1u0YKejxHEYDsxVUFPINBk/PFaWJDLoLoHUM8AE4wXEd1R8hf11uW5lnSgg0saj9XUjvqv++AK0FNrlq6f1bz7kHSCJ+NwH1kLEYYMbdjHUUAryXRBfSFLXGSCgKs8NL8LP9Wme2QrKGr3kS5yGyZRTyT/M45S1DR7N9VdbAwWTiz4cPRMMeEH/1eUuRHQbaGQLmVDTeKjqfrDBjHYMyVfNEaxUiBPM+I3YehJREjNlFMj07DKL+cLPtaILifP5Enosj3UORjbFS5NjVFbaL4Zr46KJGX7Zuq9BrJzk+8g/KVsOTy46kJlUnuZpweOuoavkP8CYVQdhbQj+DClfJS2RNNHTKzLh8dQTnCUb/kzytPjo8IsEO3LfcQOaZIITQ0dqOiS9w9Pgvj1nW6zDMjWdzQf4xJTWpb/FQpGUvX7434eLm284b6oqhHQMCqhnDPgt2f4fPw5b3mVP5Jo9eXRvol4xxyaP8vI7/mBjQyoN/QZ6uayAJS3OYMVcE9EIJQ0defbX/BuEFiEpa/Okj3Hl1xndvY47IEkHHl8BuX83iyWu4eFTjsXfYDlVho9ff+0dDBPP5Xf9G5uDI6wh4c7d1wLDmphnjQEUk24eME9DQeWR4j
X-OriginatorOrg: sandisk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR16MB6196.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a68ee6ed-31b5-4af5-4b21-08dd5ed635bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2025 06:47:07.4193
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ffe0ff2-35d0-407e-a107-79fc32e84ec4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MQGwVK9ZaKlf+ooXsyE6uxCY6qmh+/Zi70hjaN4cHXrHbnBAHRf/Wx47aTevDIuAgGcMX6LgL8c9/u9OXK62Hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR16MB5440

Ping.

Thanks,
Avri

> This patch fixes a Sphinx build error encountered during the
> `make html-docs` process. Apparently the _static directory was absent
> and the master document not being set in the Sphinx configuration.
>=20
> Fixes: 1d1b1159ce7a ("mmc-utils: Add documentation section")
> Signed-off-by: Avri Altman <avri.altman@wdc.com>
>=20
> ---
> Changes in v2:
>  - Add a fixes tag
> ---
>  docs/_static/.gitkeep | 0
>  docs/conf.py          | 2 ++
>  2 files changed, 2 insertions(+)
>  create mode 100644 docs/_static/.gitkeep
>=20
> diff --git a/docs/_static/.gitkeep b/docs/_static/.gitkeep
> new file mode 100644
> index 0000000..e69de29
> diff --git a/docs/conf.py b/docs/conf.py
> index 9c08a23..9bc69ce 100644
> --- a/docs/conf.py
> +++ b/docs/conf.py
> @@ -39,6 +39,8 @@ templates_path =3D ['_templates']
>  # This pattern also affects html_static_path and html_extra_path.
>  exclude_patterns =3D ['_build', 'Thumbs.db', '.DS_Store']
>=20
> +# The master toctree document.
> +master_doc =3D 'index'
>=20
>  # -- Options for HTML output -------------------------------------------=
------
>=20
> --
> 2.25.1

