Received: from esa.hc6817-7.iphmx.com (esa.hc6817-7.iphmx.com [216.71.152.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C927E54B
	for <linux-mmc@vger.kernel.org>; Sun, 17 May 2026 05:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.152.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778994817; cv=fail; b=I0wxwUcVbc0it4pRXiYBdzYBKpBx01xeY/MJinvMSqSk5LA2d9J2kgOFVZwEJ6ghTKVhC3Vdu6j1KGq/MMD/DjzmS4T+MBZEkgVK8Oyl6s96x8+27IZVi9uTn98LSoW0ZbXFT7fjFVupbRGutCgnR/iZkmnWHRwwbYDLNbAd43Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778994817; c=relaxed/simple;
	bh=QgS+7jxjOZPH3+KUPtO0dKzk+iAlLgJk9+O2KKbK8S8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ud0BcsRTQEqy/4K5i/YkgIHZHk4/TSF3xZadLzijJjJWO7Tr1FuHjT78c0QlZ4Ody7PYXNbLuBd8d3nv6GxgoQ8EJYfx7JsO2k8q/Qx/slwQDYs+kTZKRlFQld5rQT+Sitp3J4OGpIkQp4Y4uWIalm9Z31FvrLCBbtKXNIKhtyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=oAFJsIT/; arc=fail smtp.client-ip=216.71.152.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="oAFJsIT/"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkimnew.sandisk.com; t=1778994816; x=1810530816;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QgS+7jxjOZPH3+KUPtO0dKzk+iAlLgJk9+O2KKbK8S8=;
  b=oAFJsIT/St8eVlqOI3SXDVbXCW3YLSQHy1lczt6n8ZRxDu8NjsfUUFA3
   D0eVE4YLmJ1n4IFF7/SWz4agP9EulPqoRBfNk3a6PY+b6JcV/tiuDMA7l
   eIhz+HpThxjPjic9GSFrmRt75OIYYoJDdNW7jxAY7H0i4CvLzINTlPf2t
   UtzHbuwh/+5N8GkiXqQlWhVH4Fv3I4bUo17F0oOqQghEnC85oEwhWl4mW
   hferZrMrlEje/OHUYpg9ohUk2z2RCjOPyoIUZ9JT6V228Rz9ipvdpNOiN
   rAlD1En5BdMmcQxi8Pki/dkRPjsQzu2lJVs+ow0KtFOd8Y+yH5AOeMBTD
   Q==;
X-CSE-ConnectionGUID: 7TM8Ny9NTjS+S0cDEgojAQ==
X-CSE-MsgGUID: yVy/LYSITbu3em+aaeiGOA==
X-IronPort-RemoteIP: 40.107.201.29
X-IronPort-MID: 22526734
X-IronPort-Reputation: None
X-IronPort-Listener: OutgoingMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
Received: from mail-northcentralusazon11013029.outbound.protection.outlook.com (HELO CH4PR04CU002.outbound.protection.outlook.com) ([40.107.201.29])
  by ob1.hc6817-7.iphmx.com with ESMTP; 16 May 2026 22:13:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cbJpgKF/7pAQcUFUvr4qAjrcAf1szNAN5a5sLL7p6qv84T1YTa+Ywqc1O7IVp9kxF6C9yH5EOEm9+TQ8GOIm5WKmL0IzXRBCSKAkksyjb/Ptf8v++rmJA1y6rpeRfSBF7db7FRPxmaX0GD8wxLlSuCN9+ZfjDYi/ZAUjUeIh54v3CWNov3JUEZk+CkLvk08t5rcX2eOsl8Tktd6dSiJyAI5ut5QGKWaTMba+rZuyfQCpXzuiBkVs5rOaNLYRtUqk4cAcc8/e6icE8apv6eh09HdA1ub/qFu7HF6kEjbzLet6LuUkb7dfYoRfJzDFSPEZ4TPDCJDVV3eeFHnXW3gnxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VwHkD8b208JfNWOTdvRV4EJYnPlHAl3L3PZZryBBO7I=;
 b=K/LLzLtwD7XZzjfq5bGaXpsjMj0C2Y9L4uiEbZV2+v5P9kZwn5Qn+BIrxnTz5lg9YII8FOednnSbnLFRbYl/9+DRFKo0ctrE6iDkrvGKL++T97u4BEFlQYmOCkMYjj/HXbumt0VhgVZl77hkPu11urypMvB9xX9cmv6rPJuYWKNlE9n4ZvrizYRWKOIppqIt/FUBcHtkKZMXD6l3DiSwoM7l2LDjC4i15C/9Wxm/5OK72q9OJ+n5kGv9mUD2uXbUtxaa6Dva59CWNW/doqef6ijk5jK3moiF8QLLbZx8/Wp/BksIfZmmEzYgtel1nBjQjwH0BlLNOJeGs1Y5Ue6cHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sandisk.com; dmarc=pass action=none header.from=sandisk.com;
 dkim=pass header.d=sandisk.com; arc=none
Received: from DS1PR16MB6753.namprd16.prod.outlook.com (2603:10b6:8:1ec::5) by
 MW5PR16MB5024.namprd16.prod.outlook.com (2603:10b6:303:1c5::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.22; Sun, 17 May 2026 05:13:32 +0000
Received: from DS1PR16MB6753.namprd16.prod.outlook.com
 ([fe80::72d7:97b5:4539:a90]) by DS1PR16MB6753.namprd16.prod.outlook.com
 ([fe80::72d7:97b5:4539:a90%6]) with mapi id 15.21.0025.016; Sun, 17 May 2026
 05:13:32 +0000
From: Avri Altman <Avri.Altman@sandisk.com>
To: Avri Altman <Avri.Altman@sandisk.com>, Torstein Eide
	<torsteine@gmail.com>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>
CC: Torstein Eide <torsteine+linux@gmail.com>
Subject: RE: [PATCH v2 1/5] mmc-utils: lsmmc: Refactor CID parsing into shared
 structs
Thread-Topic: [PATCH v2 1/5] mmc-utils: lsmmc: Refactor CID parsing into
 shared structs
Thread-Index: AQHc5LMmldQUgMVIQ0SgyvnbDMIj77YRrRrwgAABCKA=
Date: Sun, 17 May 2026 05:13:32 +0000
Message-ID:
 <DS1PR16MB67535FFEF391B2AB6A75FAA8E5022@DS1PR16MB6753.namprd16.prod.outlook.com>
References: <20260515213747.1452692-1-torsteine+linux@gmail.com>
 <20260515213747.1452692-2-torsteine+linux@gmail.com>
 <DS1PR16MB67539B7C566BBA7A7D56EC2DE5022@DS1PR16MB6753.namprd16.prod.outlook.com>
In-Reply-To:
 <DS1PR16MB67539B7C566BBA7A7D56EC2DE5022@DS1PR16MB6753.namprd16.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sandisk.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS1PR16MB6753:EE_|MW5PR16MB5024:EE_
x-ms-office365-filtering-correlation-id: 5a0660c5-e52a-49ea-7259-08deb3d30a30
x-ms-exchange-atpmessageproperties: SA
sndkipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|56012099003|22082099003|18002099003|38070700021|55112099003|11063799003|4143699003;
x-microsoft-antispam-message-info:
 wiR3rgbSfGqnJefzrIgSnZfR7ATzMrcW2cdcN/9Zlplhe9vd4QlKK6SCGKVvFj87VRG9Su9IEzOJXt41t80YG2KsXJF2pkLezP3Rqdlen5YAxMLX52yCGzB8+Bj4HbSO6fDs6bLnSKMrRvXJIwm94nWzhbXHnl2GVitVWdMY4K0w9Df1H0vOt4RrZeYWOmfOerbdeFoTeZxvEXVFQ4Kx64E4pzTCjsYJFtssyZrwh/pZLFSrYi6fYAP9ufLDm3dXI+cOdHJ4ltLMh5+9Y3JRtVAf5PDopCxu/WEWP7Oq44m61dUo4u9EQ97cn9weifX/EDLtei5ZeuuDJ5k5dCmmpN5FwF0la2EqYfQHPII2jL5XEu4QqJmvvlKLNpVyhTNU7SaJZCP/7BOTotYtiWatopReTL3btBZT3NcwoBj8sYkfJptVlL9lgOCbBZU91wuEV1OgPyl4V73YxnpCY3K7qgUPWaiStSndR0/MoXmj3tYdDrTyPR4nIyi8sUcXjIa6eQg+7qLw0cU2oyjTcZy5uYDh1WwOafWxjtVQ2zZLyuvbFzfieXjVFiS280ngftqDWuN/X89ub/xzjKKwaRSlSt/t4A/5LT3K5YjoCPAv2Y4xZ6NJBaYhjfJGONkypDNF6ZDiDS9ZDnhBisSKoSvCcD+dtB4LJRfsDZH/EZFNw8skie2MO3Q/YIFSXgwSuYHZQma/1JG2iRo57uWLgLbndcmx35kSYGgKjrrgGNF38SGvu9FOCfb4+ZefesFET4aW
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS1PR16MB6753.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(22082099003)(18002099003)(38070700021)(55112099003)(11063799003)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?8cLSxHNvaUdGdwLq+ut+t7F8T9y7Or/4w/7neuniAuRCckF8Xf06CFoJtMPu?=
 =?us-ascii?Q?+YxY94gCyehJBHcZkEGa9MTNzFVFO9bHB3I3kANzxwxpmtJ3ADl4V93nQJ37?=
 =?us-ascii?Q?OhgSyZ78pmtROo+Cgk6o1D48Z9mOFa3YOEURQE3WdD9dq1WkmQN37dXJrt0U?=
 =?us-ascii?Q?WoZj9iiM+6amzl8BnrUHvV6VaB+sqCpvcZHxtxjj52LZP9KLSGB8d4ijbfqI?=
 =?us-ascii?Q?F6A+tL0gDwvaOwHcZ+1y1rgy5Jbz5MnIJNN2l7q4EYQ19mc3D4blVxJnJgcs?=
 =?us-ascii?Q?SYdzAuwLTWe6Yst2UnQvurA1N+mEWQvNFltrsiQvDlaQWNzzUjbQ5Dld5TyT?=
 =?us-ascii?Q?scJkIViJNEsM3uzjAXCFwm4NfZ0CbJfjrRrg+xEnsvlWEDJTT4kA9aOjlhwD?=
 =?us-ascii?Q?eUjhgdbl3VCKx8dpjWtUttxFDQAUo1ss15WWk1J+QqHSyhBYYVfOpMdr5i2A?=
 =?us-ascii?Q?L9CUbj00ct9o/uwnnDF5/K23k+4YZp6uzSzC7jdXTPeDitF5Wr4io+dS2MtB?=
 =?us-ascii?Q?GAL/3MUYRi+Et/PCKOZ3x87dYFhVFUDiZOneGhxcaxm1wZShyMnrlcc6CkrB?=
 =?us-ascii?Q?H429ax/+w9bqah7EAeWf0tQUFKPDsM5Uf7I/0vm147EFbCTEuVDyXrVJp5Gb?=
 =?us-ascii?Q?R2wqkDeB1FJrcYfmZo4L7iVzBrutSce6gHDQGhKazaJTJ8Bwl9NOwLi63i1v?=
 =?us-ascii?Q?VahG55TtwM6zAGrC2EZZoSyFGXM86+s69f68vIaI6m+fUOFSRO/h7RpO06Im?=
 =?us-ascii?Q?dZQL8w9C+gjcf3VxxhTk7IubDX6hHLjcyB1dNnZenhO3hIxxIBcCj4wqNHPR?=
 =?us-ascii?Q?3z/acVlH1uIWwHseuL+WqRVYA6FlVYXTf4r7jcuocPoH6PrslrBDkl+tmPqX?=
 =?us-ascii?Q?T5IVLjL8gQj0lqu4ht3SbEijapw6QzRkXzvLIbRQY7DWpFmiVnfXM3nmMo0L?=
 =?us-ascii?Q?Y9CAIHdB4mte5La0ZKJ4Qx68gn9cHnlT/MmXA9BNrv7Yh01CbNnhWwU6aMEy?=
 =?us-ascii?Q?eI5qGHlsDV5azlzt8CGE5rG0ttGy1nnWscfJ5oEX+QYlGS7B0kQUeEK+SNaN?=
 =?us-ascii?Q?SUxL0+5S/ay9SN2kF6TWqpUpN/Upw0iX59Ng/x2zrkIX4lCBWp2TqUeQbEzA?=
 =?us-ascii?Q?0LeFx8ehiL8uAD+ksFtfkrmAkWHRKonlCLXMB95sdoD0fR0iep3s/zMjD1jl?=
 =?us-ascii?Q?I0mvhR2L46qdWvOMJiBw1yNNorQiTk1bK+NSNseo5Tl+1HnjfZVNdB6q4Fnp?=
 =?us-ascii?Q?LpBk02RsRs15LZwdI/ovSuZ2mdjnGekzhhPVTVR80LbOdjo2AqNaCTKBRK04?=
 =?us-ascii?Q?0NRe+OPKvS/nMwolmFghOkX4GKdhvTtf857zu/oq0ys0QA7C4no1Vx4DM2kv?=
 =?us-ascii?Q?Mz7hbS/oGOYO+VNfeUT+3wPOH7ETcPFXV6pRrvVmbJYQspRzxYiWuUAa/Ffh?=
 =?us-ascii?Q?XTR7tI7CNM8IC/AJRqlZRzgmNXlXjI78kxHaHVSMBnQ7U6Hw1bPe5AQSVzvk?=
 =?us-ascii?Q?PihaFHzIcQMOo++4rrW0afpeqDyWmDpurj+R8OTGjiS6GfwHw88a05AduWp7?=
 =?us-ascii?Q?VR0Yx9f15DdFH3qGEWeXnidLBFBAQZBkHLoHAU4MT8pEy4nP9TQXmeXYNHZD?=
 =?us-ascii?Q?VBiCF936luTAinRPOUgpcuNb1sAxvAHKETdJTQydkA4bSvd44UonhKUd4Xcl?=
 =?us-ascii?Q?h2kwcHI8XC3v6z/ypMy06EQShn0fFP9+PLurW+/JOlu3/hX9kKAQR7ZdIIsn?=
 =?us-ascii?Q?sr+ynSIobg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	gMLIwBP4S8K4Jx0AS4jS/ffJMsz/dXljWy6iAsh2BdURH86aLApvtpuEIvi+5QARgvpwTVmDoMWDpzsNwuRBpwFfi+iQpdfGWLtOWnXxPU+mBT0+Ajxas1nCdmIFviLaHBYgzqO+JC02Fu88LALZS0WBy1Z1G3UGCMfSvDj5k/+P+ViIxkM/I8YwSUPcSBa6D606G+cjsGrkxwcOijGNRKwa2U505On0NbQB10SkWkvqfB8+PZTFQFnfyH1urENzApwAM6T6lD4e3G2SebhcqEKcyWUiOd0XN5jF7q1fvlg/Lo4dB/GsVrxGV5fAyl7xd1uUWkaITZiZbve0gWMqYw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Iqni5ghAakhYJDLd2Wl8yJT74Ct9css47ar6i1m0bhMTd40E76nmQZBFevAhWfD+q3WTOw56MWNPGzqXRoE/fvPusJ0T/jVX19T4qXXoKMs4iOHYNZ/TeApc1rcTVjArLOWxAZUuTny6xzunMtBOMKiAa9pRn7FJrU/ZX0ppc1CXdFWk++naxpQmTxhFV8aWh304q91YR4Z5LXylloZJVWUSITfSBJR+d/ZZnMlcmkzBHEz7BYtWFrnBu4LGOu7vgdR6C1N3TYfzECd9x67vKUU8gkhP+qL+b97qIJz//JnXj+2ehGCWwAwLEwQSAtPOUnBtP5PMpEqyAliB/7+nSTRSk1CktavMzR2rUXz6iwN42UkQIW0+C69eAuOzyZj3jstfooO1i2tWQV5VcHbj4Kff8FPNL33brr2PIch5Ce8Db0JDjXkYskDQs3Pj0x6gAe4gpHpcz+Icw9DWVi+ZWGZPyoWFp31LFRyoaRRGW+XMAwplC6LKJ6+8nxLI010ceuMvChfupy5H6K+GAVn2DoZ65jwDDXKv1PKp7Fk/n7Yk7vUwDSs8yy0Qs2/nlmiaibnuUE3w7KVls9pJU6NVazHpL+o7cmFuY6eM08CsQN4q2XE9ByBDoEFzTF/fQ3hmtEerKfhWnwYUcauP43PEBQ==
X-OriginatorOrg: sandisk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS1PR16MB6753.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a0660c5-e52a-49ea-7259-08deb3d30a30
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2026 05:13:32.3289
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ffe0ff2-35d0-407e-a107-79fc32e84ec4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qBcA41L17iGf5URs1nh9836iv8sWSRU7FlLslNZ8biY133SuOLY5kFP7RnXWyNPVUKUrhDozGJh/tmEqpidOGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR16MB5024

> > Add struct sd_cid and struct mmc_cid with parse_sd_cid() and
> > parse_mmc_cid() helpers. Use them in print_sd_cid(), print_mmc_cid()
> > and
> > print_list_entry() to eliminate duplicated parse_bin() format strings
> > and local variable lists.
> >
> > Also fix print_list_entry() using const char * for the strdup'd
> > manufacturer string without a matching free().
> >
> > Signed-off-by: Torstein Eide <torsteine+linux@gmail.com>
> Reviewed-by: Avri Altman <avri.altman@sandisk.com>
Ahh - no  - Please ignore this.  Will review it later.

Sorry about the confusion.
Avri
