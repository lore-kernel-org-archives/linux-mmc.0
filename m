Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5404439019;
	Tue,  3 Mar 2026 14:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.147.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772548612; cv=fail; b=s4Y5UkDz61CxCg2hWSEL59PiDR+l//Q28xYtuC5187yvlzLFVa40zr+xjaTjGQGynGMBITMkE+qRevTKnqpklUzxIQUcLOS3eN+/D7cR1ToNmAcKWTkzHEHACgMgfDlI3e/BcgKTcg/2Vlslu0Xrt8CSEMvPR49ZuceVkEmkoN0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772548612; c=relaxed/simple;
	bh=eX5TAHJ7wJ/pgEq7uHX4uiKmeoMpR2n45MobG55xvQ0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LuJ7ueS0EsNwmEK7tSptP5hZhcTw0TA6Pws3CdQBxcK8s1GnEca3cDiL5ohiAZcUNLeFJnqpYJgLNogIy4emCC/I/ANQhFdkpuYqGb+rmlZl+WpWf/YxXJUuu1k66LnvFlWn3JJaj4T7Q4ibdEgTHhBONj6GY5lp4ZKUvxBY9f0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=TsjEQhoX; arc=fail smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="TsjEQhoX"
Received: from pps.filterd (m0134420.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6239MlcP1866925;
	Tue, 3 Mar 2026 14:36:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps0720; bh=vg
	EWFBptlWP81xpjd7zjKI11auTIeuj6yKjyGulRNvI=; b=TsjEQhoXnRCUeqq+df
	/4C/VRoR2XGtA4LTQhvdJdujYYnsnYWN3z+pJGF9Dk8oql8pi7wgaW38Jye2AzsA
	vqCLhOMN6tBTjfVvxhHEiWWyFyLeawVHZBc0sW2ZqG6flcwXnHaQx4FeRgD6wi2E
	5S2Zc0h0Ap2aZmliALkvS8xrU+yPlSQlDddNiELh/OtjJdJVigVcMX/JZc5qY0x8
	No+PXY3qTCELOBvmmf+CUyaeLkLQAuWkQnibwFt6KlsnnT9Iyve4rmXwCA2UTCSB
	p/XnrL/d9R3cG8CtxL9yRWgJogSf4r/s9hPGpVoHOpkS/l/JQQ9KrOwtuOB/WYMf
	kR9g==
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 4cnvy74cfj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 03 Mar 2026 14:36:43 +0000 (GMT)
Received: from p1wg14924.americas.hpqcorp.net (unknown [10.119.18.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 760FD804782;
	Tue,  3 Mar 2026 14:36:43 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 3 Mar 2026 02:36:31 -1200
Received: from p1wg14926.americas.hpqcorp.net (10.119.18.115) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 3 Mar 2026 02:36:30 -1200
Received: from P1WG14918.americas.hpqcorp.net (16.230.19.121) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 3 Mar 2026 02:36:30 -1200
Received: from SN1PR07CU001.outbound.protection.outlook.com (192.58.206.35) by
 edge.it.hpe.com (16.230.19.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 3 Mar
 2026 14:36:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TUQjzuqMzG0nSe3k7xd0BDGtsfIpnBJaUkzPVDt83S+hdvsL9VsDmXzb32WAx87NoiG/xxQiALkBGQg5WQ+zAPhCmbjlo7/mg0KSkDR+djDXx9TF3NXnVZZx6AU2x4yDxl4w9OESy8kFqOoSUAAB5DbIzB9krMvyZCFjadIib3TM+hp10gL6RHsv8q8WUIXBUxljYouCB5pQuZoPTale4JcKCnWK4IGweI7OBlHzigscu1yRGQ53O4KwZ9W2bZ6EojRGHB72kGiOQnTA0oL2Bt0G5D/mCVMsJ2CLLAegSk4GhG+hzopILPwgYrTHVNC+61oF6hpLWICzjVfeYCrqMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vgEWFBptlWP81xpjd7zjKI11auTIeuj6yKjyGulRNvI=;
 b=MBEm0b3pt+pmYeYochFr2mxVpJYxbkJm7D14JQ7VJeMRy2Y08BUzGhuz3k+dyUQny2qEb/9j4LGCruGhoVyntjvLPx2+dSy/PhRt8KOLLumgK9Y91wu7oZlrlLk4VHyd9K8X0emqM29Zy7/1xWKOIpNGW0cjR9HyFG8LhnoEDAx78rJZg0occW2hebEqq/UhK+RWndMIldUHN5OiiDO/jd/BQzNUqx5hGsbLuDgrbMFhMqqYBny1qIdi62E4DxURZK3Lq5iRPX1LBpBUZq2it3Djm16LhU+ET95UhIANxJ1uIpBa41i0bUflqxpSqYZGOroaSuAcKGgDqvNyYy6G5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:4e::10) by
 DM4PR84MB1517.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:48::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.22; Tue, 3 Mar 2026 14:36:27 +0000
Received: from DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::a85b:624:a74f:e211]) by DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::a85b:624:a74f:e211%6]) with mapi id 15.20.9654.020; Tue, 3 Mar 2026
 14:36:27 +0000
From: "Hawkins, Nick" <nick.hawkins@hpe.com>
To: Conor Dooley <conor@kernel.org>
CC: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "robh@kernel.org"
	<robh@kernel.org>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "jszhang@kernel.org"
	<jszhang@kernel.org>,
        "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 1/2] dt-bindings: mmc: snps,dwcmshc-sdhci: add HPE GSC
 dwcmshc compatible
Thread-Topic: [PATCH v1 1/2] dt-bindings: mmc: snps,dwcmshc-sdhci: add HPE GSC
 dwcmshc compatible
Thread-Index: AQHcqnck9Wx4klAWvEy895ZMktF5i7WbpemAgAE3HZA=
Date: Tue, 3 Mar 2026 14:36:27 +0000
Message-ID: <DM4PR84MB1927565588A5B529020C4A80887FA@DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM>
References: <20260302190141.1481298-1-nick.hawkins@hpe.com>
 <20260302190141.1481298-2-nick.hawkins@hpe.com>
 <20260302-denture-widow-dfe7fa5ef561@spud>
In-Reply-To: <20260302-denture-widow-dfe7fa5ef561@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR84MB1927:EE_|DM4PR84MB1517:EE_
x-ms-office365-filtering-correlation-id: 981bbe29-9aaf-4595-cb9d-08de793240b2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: CrfGP/E+67VPViIbUMAibbRIehmDO5XhR57ruHOPo092Qyz6PweMvbA9w5Lf6Ok8adV4QoIMZunxwvpDDGvaF4D8y++ikFtbi4ZEx6S7rPTYqgWW0IC0rC4Ki5xC2BXRZOqhb+j2blxGDqFn4ov/vmj+8aPTbeIW4Bsx23mL+LkPKbbSoFWeX10NUpIL8dOpYINOBDLwfsmoxVidYHH5TSwVaKguBBnuFcB7XvJopFjMteCUrSOaPsfKCXBbLVJQ/aQJY4z/Y6y28b0ILcRJa8pnGh9CIjoOFw7vrl2GJWxn6fToTV5b3LTGYw9x9rwtP8xOy3QLWXlxqt/BTBYW6TPLE5TNGQg/Ic8pJJ92O8q89kz+Z0g21eh8EBZnmR2YAUbHcsy1bQ4bnX1IDOqpR9hpVEkhYyk/QYrT0+DtKVRR3wkQ76IQ/tqqfgGUdbJ2TMazMonBtnoIFGBeUk7u4z4H4eaVkzyqNlsiN/gkd8xYT+sBSRaDjeLUQvebFyWWb7g7Z/5QwHHT+/dVVWRr4BP0MJ0LU8cMY/PTZrTaFXoylDmtf4gI/O+vO92z8Lh7lXTs9Vq3RqHf9v6RWhrU2O0X1HPK6PfKdop2zfcYzJ83YJEJ2mvMS+iZuYRIhuAYaZ0ljd6dsnMi5RrZhZ0KCxQg8V96waz5j7KXUQYi5zfPyvqJwlwDWrdxAFHABSubi/qX3a/BVJNeKVXa3n5bAWMVnQJ3Sc593t6YbxTbygwt/3KvHR9sNNY3Jwn95oh/+FrNS0PEy6Z+f91pI06oYufcEGXSLGom/8nisG3YESc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ynXPUnYOQJMDl+qihmzePz39+U9hzBNjrGlfBPEPrBtk6pYERNrJQRPeH5QU?=
 =?us-ascii?Q?tc8DCrg2fOgxjsGeNnz7h2VZ7c4kZWAGbHwbIB0UqtUOWNksZNxM4CUvgS/B?=
 =?us-ascii?Q?9OYp3KV/HBJnWaAT8L+EesnPV7I0FBaaRsXydE0RD3zjpwVOxHCiJTbzOd9n?=
 =?us-ascii?Q?vf0Dw/NG6fLCm6+e0olm/xB2HxU2z7oSUeDWzzPp7RtqL6mUn8Ry1T4laIOg?=
 =?us-ascii?Q?qPe50KgB1yiItu28bAfFOIp2ZusjSk21F1dWpRT/5vL6ZAvhRITHlcn6EL0F?=
 =?us-ascii?Q?e3THqn54vxxnSuhBXWKrKNDxlaWHDDTelTfSulTEFb7QZoeyLyzeM/9gR6GA?=
 =?us-ascii?Q?EsvSOr3y5+phV3gs8OawBt+ai/hF/6nNhCL3XcOnTLrRLMgJOouz+55QIGPc?=
 =?us-ascii?Q?Zi5N8P80/f8234lF3xE4phxfLlbWG8vMwrW9I9ij/gg+GKedEjSL/gOrqHef?=
 =?us-ascii?Q?Iu4V4Suqe6rVnxXd+Yf/d0vlIhft/VjYKPCR1hMDBKKsWZkGJMi+0FQeQLfA?=
 =?us-ascii?Q?vcnw3Vq6cUU0yEd4kTdd2ZmVNEOZyErfdthsxRHbd+HDJFW5i/fd/2dn3T0G?=
 =?us-ascii?Q?blIGsyncVGC4jnf71wWbGNSzLGFsbeJNv2Lgfojp6Mrja+GWAoIkkrRquGM4?=
 =?us-ascii?Q?TKUcMY1jpy/R8GMmE5IR/8j6vnJnCOY6nJdUJzo7c+4aixSaKvRZTVKzWp6e?=
 =?us-ascii?Q?hHTdp6D1QKmvQA/1Xr/QcQF+PaEICLUe8bpPeuzikk3weifzVDEr3lAwITJ7?=
 =?us-ascii?Q?6CMJ2Of1gUyu9mzPjJHKBJNyF2bLl+u9+Jv3RK1462aOA4sUiJ4DH4chvnrE?=
 =?us-ascii?Q?PrMfwhTtFVjLrnG3vKi5kfA3RZ5aopjPNPQUMqlQBb7vP/eTecmL49Jlx+Hd?=
 =?us-ascii?Q?NAEjlgn+y95JR2rlj/oEOsctz8s4U8oFPuESckwwVesCoPD+laWIR495Qza+?=
 =?us-ascii?Q?rO7cXs+10/17LgnerKPVvay4Tc31ks+ZRDmjyc39eJBf0E1aVB8NIuXJOYwu?=
 =?us-ascii?Q?JVAQPMTNa1cVH7nsogh/NKZLmORhZOKig4hWrSwo64JofT82L3hnIc3GK6Hl?=
 =?us-ascii?Q?8oRW6bEdekg+crC5n/pCbDIkcYbTDWaoZqFfc50/XkLuxcVcqRLzlpl/0axM?=
 =?us-ascii?Q?4vVdV1Am/71FeI6QCbEx6sc40eSs/stQdh2c78ZGZwdHZJKS93ca1NUnAZbI?=
 =?us-ascii?Q?ChNu1i2tyWBQ8LZskIXeMI8P0e29wJP7ooMlDqreXzoVSxsxCB1D/beaY5fd?=
 =?us-ascii?Q?jDPckIkw62tqrOiSNPljpYPezUfEP8m3Gvw8VZ5uioqtp9G4/boQRpbY4GI9?=
 =?us-ascii?Q?8mTj/WZmnGpVdAQ9rItLE0rD8e01A1/dvRK35gBNXZxKp1DEs9tIXHlBXzPr?=
 =?us-ascii?Q?bkd0a87fDLPrdDxxruXROMw81B31w3wDezsPYduig+x4f7C0bFscOhR0C2HX?=
 =?us-ascii?Q?RwbQCKYi3FQp7FyUx+J2EXnxrGQXSdrm5zIoCLnGLT5hsVuyqoSNAB87owsV?=
 =?us-ascii?Q?Y2TZO3ctAsG92OmnnQ6AGQScgrge/bwnH1Gp0M+TzYd/QwJ07IZCpMPF6dU1?=
 =?us-ascii?Q?WjqnqaMSS5s0mvwSb4+23dsYNtBcfvPlM7WDx1Mnv6S/O3x51v2iSjJYYawV?=
 =?us-ascii?Q?QoPBi7OcXGiaFkLdufYlwSlpt2JJTgGgtpBkWdX35Sn2DKvewGb0f1Xsw98k?=
 =?us-ascii?Q?FKkYqzIm4CNj6f/yCen8ZbbZkxKIiSKLYEdF6VNZASHrcMuCRmLCwY2dl3Qk?=
 =?us-ascii?Q?GeKqhiqEJQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 981bbe29-9aaf-4595-cb9d-08de793240b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2026 14:36:27.3224
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nuj9Iu49H/rMO9jyCUuBbMsLep6pstR5h9DjkXwp4cHzRc8QJKxWNxSNsapH7ci6JIGDgOfbk2NiUEpwfqW0CQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR84MB1517
X-OriginatorOrg: hpe.com
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDExNiBTYWx0ZWRfX4AIa+lQIZ4af
 A6z+KyX7oKiKzQ/rMrMNrUcN8wcX/yarBwGcTLI6EATfmSrcegPSomNvB5kmzTngCIE++ACtc4X
 FIcoZhqzD+8mkPkvjXILAfvLFBIOJoMbFc/Jnh48THLdkBRcTH2JjdQD2muKoFIopUUv+V0AjHc
 7zDoeB8IU59LPJ3LnAYTEOhGllDg9r5RbMSFMCGj/jZ84S+uQh9t6hyLQUHzqFF/GEQ62fEIHxm
 FThK9i4CtBS18JphXV0KH/8c6iGjmcV3mtgqxDJ9R/G61uFflQVDf91cweDwfL1KdSthZxQ0G5X
 Xu+Jx+J7HZrhNHnpfNsTW6jm4stv2Yy1kd2pbVLiGco9AYjJUmc9fAX29j7MfvEDrJrrSE7NWc+
 K1Nn9ViofhQB7wj+tyvsazY1+Yp7J8UB+flmAJP16D9vte0oS8BA7qaTdLHTcJ6kCfqjOdiGqep
 Z+aQJzpWyMuoaNxrtaQ==
X-Authority-Analysis: v=2.4 cv=U+OfzOru c=1 sm=1 tr=0 ts=69a6f1fb cx=c_pps
 a=FAnPgvRYq/vnBSvlTDCQOQ==:117 a=FAnPgvRYq/vnBSvlTDCQOQ==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gQcMVamqm3wCPoSYhaRC:22 a=RtSn8ETxjE2H05FtM2s8:22
 a=CXmb-wgfiRas4Qun81IA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: -TywhTBfMtzxFkwumZ7hNC3etBCI_FAM
X-Proofpoint-GUID: -TywhTBfMtzxFkwumZ7hNC3etBCI_FAM
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_05,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 priorityscore=1501 clxscore=1011 phishscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603030116


Hi Conor,

> > +    mmc@c0100000 {
> > +      compatible =3D "hpe,gsc-dwcmshc";
> > +      reg =3D <0xc0100000 0x1000>, <0xc0000110 0x4>;

> A 0x4 sized region is always incredibly suspect. What is at address
> 0xc000010c or 0xc0000114? Usually in these sorts of scenarios, it ends
> up being that there's some sort of misc. register region of which this
> is just one register, that should be represented as a syscon.

The first register set will be the actual device / IP we are working with.=
=20
The second is as you suggested is just a misc register region.
I will work on handling that for the second revision of the patch series.

Thank you,

-Nick
