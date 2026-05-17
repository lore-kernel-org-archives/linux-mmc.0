Received: from esa.hc6817-7.iphmx.com (esa.hc6817-7.iphmx.com [216.71.154.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BD972623
	for <linux-mmc@vger.kernel.org>; Sun, 17 May 2026 04:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778992461; cv=fail; b=himdHc3MSsFzo0kJ7MAO5UgXj6SWUszLF1/CmKgjroJv4YY9QeTY+KSFpcLVjDzyVNMLUKZN5MSnYw2+Yw+Tshc/YL9iJv4oJA1oct1yhNGPLkhDnBe7Bs4FZwjVw4yUQvlIiKgOoC/vQLZkobtvcTg3sE+a9HtxKn8bqybtEFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778992461; c=relaxed/simple;
	bh=j5gb0Nc2MMtQ45+dXgD7x8s+JeR/Y7QVrOSY+EQtzLs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SjBIHmnvIm2WLVXgwtLdIchtfF8Nu7rmJW/YW+EDrDT7DfTp2dgSblBc8ddxBZln15G2IsdirU3SRP8YjpfMUL7wQYfqhJ8qS7aJcaAMSVeyYv9NfAG6hQ3UHJvKbwjolBbTkPCrrPyyNT/RXs1PLeag7NLJmH3q/SqHVnVsI8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=HSus1Hgq; arc=fail smtp.client-ip=216.71.154.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="HSus1Hgq"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkimnew.sandisk.com; t=1778992460; x=1810528460;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=j5gb0Nc2MMtQ45+dXgD7x8s+JeR/Y7QVrOSY+EQtzLs=;
  b=HSus1HgqZ7ANw6lVTkvqy0T9QhUXZXykkx4LMpeC5UJqW3LU85oGS6kS
   bJrvu+xl6+f30rxVhEZvQFzsr/+ThATEySk423F+UQMzvo8ohkfwP3FG0
   xLuFWnTx3UhQOFFpaENuM9HdOTDGHANNvcdqATGG/hjdw0mWsxBrwPtc/
   ZMXmMhk/v0GtBkRLiX+JAuC07v52r1BSbmf/PS09PlpMkxdpvkXdQP5IH
   xqiS+Wa0EaPfMeoGpVhh4VEGDG1/RnzXOwtmAul1yA9xlrt3U3JQd94kh
   WqRKAJ9dFES909E0gFuBt9rB7qLApiMzQDCmiccj5e2juFe1nFGPCglG3
   g==;
X-CSE-ConnectionGUID: N5kYH55wTWCrwi9wiud3LQ==
X-CSE-MsgGUID: JkOv9K/DRM+45nUoY7YNtg==
X-IronPort-RemoteIP: 40.93.195.58
X-IronPort-MID: 22819533
X-IronPort-Reputation: None
X-IronPort-Listener: OutgoingMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
Received: from mail-southcentralusazon11012058.outbound.protection.outlook.com (HELO SN4PR2101CU001.outbound.protection.outlook.com) ([40.93.195.58])
  by ob1.hc6817-7.iphmx.com with ESMTP; 16 May 2026 21:34:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lj/0tUc5XnSUn6x4aasSLFgv4LQOdwBiKLVheAbMwzVqRYnCj4bK4rifBvRWwkHVLxhq3BJwUU9YCf7FYdXUf4MTSOOpwNQQgr2BkOyMOmbenjBxnFt0O46+RA8uRulMYwRWaVlipJ8rqptzqOWOlB2F4fvnUzh3bdBe+LTXgn9jwU1AkKY04O0CuKjdVjek9eC3Lje+tZTcTJKC89o8R38X6O/U5QrwpWm8ufCRSvTIngRqYC9+A2WGWVFECI8BJS5rK+PhVSIfbgRh4FJgO9RI645IBvXhVIBQ5jxC9TKjnVX2CZRLshrYuBVYzp3NUZYy9+HiMfKdQE/XubGQcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j5gb0Nc2MMtQ45+dXgD7x8s+JeR/Y7QVrOSY+EQtzLs=;
 b=UCRsmrZ6licN4jlF3VoLgXPjP2KcNfrcrTpjcj+gjpkoH67wRxWnj/pBqfc3J6WoGk/RnNU/TJxwjtoZVUPfBCtrdYr5SEY4uS8mg9IDQ7Gi07tBOlILFGvnb4NGBnp2Y6FkIfcOCrwPVmlgNfGoWrql8JzDEWhed9ziC8HiK+UC/5Bnh+dCfQjf0oQpNguuZWJnLnNAQBzzO/nnxVUI5lw1WoRpFvTGuTin3MaS+M+kd9xmBFCmmVNOlUhDjT8xJ1ZNQTzzx0sWABrVDFYsjFH6QktXL7XFkqeTxI+KZLPA0spXoMJcpAE+UEITeIuO1MlJS7azFEnJVPFfLL4GJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sandisk.com; dmarc=pass action=none header.from=sandisk.com;
 dkim=pass header.d=sandisk.com; arc=none
Received: from DS1PR16MB6753.namprd16.prod.outlook.com (2603:10b6:8:1ec::5) by
 SA1PR16MB5851.namprd16.prod.outlook.com (2603:10b6:806:3ad::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.18; Sun, 17 May
 2026 04:34:10 +0000
Received: from DS1PR16MB6753.namprd16.prod.outlook.com
 ([fe80::72d7:97b5:4539:a90]) by DS1PR16MB6753.namprd16.prod.outlook.com
 ([fe80::72d7:97b5:4539:a90%6]) with mapi id 15.21.0025.016; Sun, 17 May 2026
 04:34:10 +0000
From: Avri Altman <Avri.Altman@sandisk.com>
To: Torstein Eide <torsteine@gmail.com>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>
CC: Torstein Eide <torsteine+linux@gmail.com>
Subject: RE: [PATCH v2 0/5] mmc-utils: improve lsmmc usability
Thread-Topic: [PATCH v2 0/5] mmc-utils: improve lsmmc usability
Thread-Index: AQHc5LT170bLu3gJJkOLT252QWKhYrYRopXg
Date: Sun, 17 May 2026 04:34:10 +0000
Message-ID:
 <DS1PR16MB6753BD029759F0F3246AEFD8E5022@DS1PR16MB6753.namprd16.prod.outlook.com>
References: <20260515213747.1452692-1-torsteine+linux@gmail.com>
In-Reply-To: <20260515213747.1452692-1-torsteine+linux@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sandisk.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS1PR16MB6753:EE_|SA1PR16MB5851:EE_
x-ms-office365-filtering-correlation-id: 1435695e-14db-4514-d76f-08deb3cd8a62
x-ms-exchange-atpmessageproperties: SA
sndkipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|11063799003|56012099003|22082099003|18002099003|55112099003|38070700021;
x-microsoft-antispam-message-info:
 mIUnc1Cc8jjDT5eqHQJA+ofrFZx2EHY2VELqUIhxSa3T9G3GPnQlMmtlYKLBcKIku7zWwEP6T2+/i0sohsgCwnl0Sjqbmcbd4tYaCnp9AB8OuOy94VmY/VS6K1JGnjj26c/5zLQgX7MPDH9BDTmUYejDjw20zxkYmCXRfz3qA6UwWZtjHgSUXSFo/NOcy6GmWtKVxV050xwIiOqtrDA7+5EnAsbpLPgJm9SnvRw7XCGC/bZxDU5h13UDuUmYAMS5vCNJ6gyi2O4TxO33+pu9qf5vqGP0vKaLoFMZ191JI5E7FY5pD87LPrwS0LcHaAPEHNaLnsitk6qv5Xh4/EouciGoAvadNld2gkL+q5txreARvHJKJztNSWamKeX3DOo/CorgffHUo2BP85Fir3ZXqyG0xvKTbyw/rMqSbmrDJOdNkwJ9UbXNvZwdun4ZW7i8jCFEQXXOOPEMqho8I6uzoe+PdfUUOMAdcoGV83rkmheH5QD9WVbIjxBUqnWuAjeb+tREuu87L3FlEloXjuYl2/NpQtOyAJrcrtqZsswrFzDrNbvA11zywEBFS1LQTRlpUyF4fBGgpdsgNNSspm415GU0GPuAdT/v9OIIC4g+SYSG3yf6Eb2CPUlWPngZDmcGEDIuAAnP2t8KIfNZSyfZKPbPUp8i9mAa6oW0qvHsEvgGVyLOIZGV3u1CGdyfUL5T/Cnx53C38IQttMw/pEsr21Oz8odf7u+4xFspD5YZFoNLzpvqZyS6EKMBjMP5s1B7
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS1PR16MB6753.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(11063799003)(56012099003)(22082099003)(18002099003)(55112099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?eFRC/OS54EEnjhFvbPeD4LkZJI2bhqzus49rJQEy9dApbruLUA0iTGKjohAu?=
 =?us-ascii?Q?9t+uk0m72oO7RcATFQ6vauolrbQmQWN9178qL1mQZ7X5AMAzh+fB0PINf+dE?=
 =?us-ascii?Q?t+AChRqQjICsbznvg/0JTfYi2gNPEIQLRoG7loRY8cgEW9aYxvE+8xcEU0Gn?=
 =?us-ascii?Q?eLzD5X6aA7iW+oF64WOMZwrUjbjL746YliStfv5XX9lqXisvlcVQHGatjNYx?=
 =?us-ascii?Q?mhBAZGgWljqA7WoK/cKjX7zZdmG5S2BTqyJCdJd1cSfFE9sLS4MnshMUpXVX?=
 =?us-ascii?Q?/c3T3adA6KecdN5ZZYyi7T7a/OV2pWorf2/e1HZMNpmekG7iWAQMr93UrmZ3?=
 =?us-ascii?Q?q1abBKCChAD4fwnyOE3dvcGaH5psUiG79M+nMx9QJSOgDIuduJv/AkLWrhw5?=
 =?us-ascii?Q?BlH3zk2UchDkuEF69Yldy82+yX/Ptttn1V1tT2/6W51InlHqutFxH9pCzltl?=
 =?us-ascii?Q?HEETP4isTjLmRJ+wVgfi9H1T5S0KDI/zLWV1Rj5NuEdNn7XP7jPwhAZHW4Z2?=
 =?us-ascii?Q?1A4cAEeSzwF+KOd788iwckre7nh9xzmfg9GUM8Seboxyu3kRyWWigf38ZsVk?=
 =?us-ascii?Q?E/epW/I3LDsl+CfQImC7M8hGT3sGg5JGemTKfn/5BcJ393igvORu0T3KOJNR?=
 =?us-ascii?Q?ZsytOuLoC6O2zbIe9JQNyyuHb1EJsUUB+/IM87xnumv9B4Jt2ry/Wq1nXEAl?=
 =?us-ascii?Q?TolJVtIkWF5aMyLI5853Lrzd7KKL+inoz3YGRVGluxyJW7wx0mBe5oFWLcPV?=
 =?us-ascii?Q?TRg/kooXbo4wNySr1UJHqeW0UFY6NQLa5blWtdXTsexwG37aForzplBd8Hg2?=
 =?us-ascii?Q?xnH1cWm9LhEpPn1HhulDFYKZBeKf0pAQ5tjPWzWEw7XpfEDc+fLUgTmA09+o?=
 =?us-ascii?Q?OxKG6VV3GtkekCPibl1HaTVUHcWNI0CmgAG4r6mFjcKd0044EOVUH4kg2+Z5?=
 =?us-ascii?Q?AXpgBiBulb5cZCzxRMC4/Yb7g0n2pyjAXwVr6x8bDXh2A68IvxNEXDrJkKE7?=
 =?us-ascii?Q?UEkmBCtx7ZzNmUssj66BNk3NOZE0h/gWrlr30ch5xI4uOx6LywyTT2KNikzI?=
 =?us-ascii?Q?X1VcUl4/hdgDMgCEytF4eMgnZsX7382blr8dcdd2gSX1/SBV48r1fYAIVyxO?=
 =?us-ascii?Q?F6NvaqWwIsusVf7xOa+TLrIjNe5YIvWBVbX9KqtryCYcMhG/EeRFEwGjcBpx?=
 =?us-ascii?Q?FnRYIWO4HJJVUjndDurkyK7rYpo/FsZJorjqbobtbVakSkI675rLWUIEb0cN?=
 =?us-ascii?Q?KXzLVCXpUzMPuGoV9Lfb04HZlItT9Nt5Fm1cgxVRad77pkUR79Lmt2or9NCf?=
 =?us-ascii?Q?K66AespQll1jxy7oAszv4rHlzpGIUSkVIcHfVTbOnAhR6Xgy7vfmacnYtGOq?=
 =?us-ascii?Q?MOgtW/v1mPFZdAS6gT57jom5hiNoVVWP2s2PD9XNd04onmV8E/H4IzypTy13?=
 =?us-ascii?Q?owZ6d6Wvv5wAxXmrQFc5n135uZhnfObpo8UMKcPavmIplYuDuxb2s3PulLMG?=
 =?us-ascii?Q?76bsWNao61oYsrx10RlBwaUSo9NskdKKVliOWPmnqKITMOxLrovOaquvw20R?=
 =?us-ascii?Q?eluoFe5PZFArXycOvkQ1KOfwocsyI5RO8wAY+qy9GIV7NyQgHUUSp8o2TVWR?=
 =?us-ascii?Q?uCFDe/XGMqFyWc/mMgfDe685U1V6XbttSfT8q7YfwyKAPrXX/yEQWWF0IfgJ?=
 =?us-ascii?Q?HxUd9ZoBn+PhLihJQnz9Ye2vRsH+Jcnpu3qAdVuhuFweZJkPWhR0D3C7/T4d?=
 =?us-ascii?Q?am6EwwQ5UA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	pjsJN94AtQnh2gyFeBWDRNawXtgu/D8xGQFNKObaEpSJav/UiKrqrZ3lEtNFYTteFwRZwDFaSh+5YQHF0cbiy+il0R6HQSmhfqjNXxX7lCikDZrx6u+6TElubHIpzrgWnDm6bOjKwsSEtjyGRM9s8VBh3pQvCX7h2Pk8NQwL4MqPzgvrzzt6lQpxYodKVl/3SFiLzFQG1Thg/GcbXg6C7gvpdOz+wAx2TfA43jwaIRZtLSHsmEVK2wlOenFcPwgTlg6RjJMb9EuEv3EqOXAAYvawe8hB4ZQB198pesVZdAI8LmuDsIm03Bpco1vlvaYcXmocIF/1GdHgg0wmI7KHSg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7CnGz3mXxpdQ8ArHhHyJ8lVvIoV2vMuYqfwHD+BFftNPlyhQ5jeMSdkRF3DTahHjk7Az/59CeuOfcMqilC3k5jptJWpz9cJKv02kCFmc3vIcFhb0iFAyDtySjveI4Vpm2jybnhuDWHQ6uVp52L7UzLe2NtNfuOSIDMKLQ/v0FGiWg7mMbdPacZzkV9WgoLRRhwIOXwyc7EYj5JigbLYoTcH9E14Xu3zH9trXJwoIN170nP6b0vc58J4xJcqJSVvx08OuXKR5OCubTSFG43m/cm17aRHO7sXx6QLsFwMHNufCGu1uVSsFQEA9HBkxJyJXM4Y2TSRZxloGTBybSSc1Nr4fM2m9ZumOZvYNhCe+e0EN+1/Uj0h7JCGx21TU3QvFfYfxCck9zeZ/xVCEkxKFIolCP2zmdTvippUjVZ6aOmrKU3d+k2hoa8pNgeyRCnzwzNiyRFXcAeLdwgXdGpxHKeqKG5lgYkwpWGl21fkHhjOPj70NWzMjc4ivX7KJ2kiGQHSUFLP6QIJPAV5Vrk+yjYAF63ri/aqUNV6HlNrA59IzC7GI3TNwNEVD89X1uoorXWT/tLPXPOgGGDnXgwA1nOoC5rGoFPAB6LJ9Z/w3FDLvfc4+n2rEh9uvhLSXMgz373KsS046vClHUzylBTRfrQ==
X-OriginatorOrg: sandisk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS1PR16MB6753.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1435695e-14db-4514-d76f-08deb3cd8a62
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2026 04:34:10.4546
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ffe0ff2-35d0-407e-a107-79fc32e84ec4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: afOgMyYQ30LREx9ov7UoLVOL4BSZn2Z8xNhYbC8K29I3D57mb6Ap/yPKFxEix6jWguPy7f2SRTmBpLFvCGLM8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR16MB5851

Still don't apply cleanly.
I will review your patches, but Ilf won't pick them up until they do.
From your development branch please share:
$ git log --oneline -10

Thanks,
Avri
