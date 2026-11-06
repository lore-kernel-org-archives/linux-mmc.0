Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.61
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793945834;
	b=BpncliOmk/odib1yEq+1eQrDAn9swVGeIJ9wydEuXyTT3ltb67CaWqeckfz14TGPTilf
	 TpiducrfSak9HMoJptCLT+rT3BN2q+b/HOsq8/GGLmETl7aV4Ud/4WTTVLxjfJCPWvv9v
	 Gf1Uul4a3/ddCk+AkGphqCUYkWqwcapLAcb/bmTFxDB59/aMkGTxVVbJzBR5iFd/7DVPH
	 rXlQnA+/MKoYAfC0cY8PBj7QzgXop09ayqz6Cjz8KPgL9ULZejmmO6N3Tjatvcd9F4fGc
	 1gGnUcYjfwtRRTXvPS2Do8j53WKm3AqilYdg6M469dtYWe8cPp0w9EUiGP0DRjvgfCw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793945834;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:Content-Type:X-Mailer:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=BVbIdh++wUeGx0fbN7MLKp+4wN1+HXw+cUZP7UccRgw=;
	b=dvM0EN7cxF5rtLiGwP5599Pjalmcrz6p4o2lBCB4biFvuQBZ8923O5kKxyVa+4i0F19I
	 bTx6sMuE0ccWwVngNBsslFH+PHWPL1mtDK2NYiRrWpjnDGjm6zMRCTooioD8DKdlTbOua
	 pM4ULIupWtGdYtkw1lWaLsy0l0g5snUjMCHi6/gpqdLtA7+fSgAWV/fFTgIBSQ2aUUdob
	 HfPEXRMNjslvum37cry2VyiC1kilyRog4utzK+G8Sz6IULpqpiQcmaO7URULPoSl8wZ7r
	 B079o3zfYAwAmNDtNU/wvbUSOwlS/HhT/FLIDRax/MphL3X9okbxAwbIp9m7fE2sb4g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=altera.com;
	spf=pass smtp.mailfrom=altera.com;
	dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=ojZREBiW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.61
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011061.outbound.protection.outlook.com [52.101.62.61])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66222606D809;
	Fri,  6 Nov 2026 06:17:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66222606D809
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=ojZREBiW
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IE6ctWmxPfHMDEKWvWSY9chHO1OaBMZqEZYyHq0lTtcKIIk/4ABkvaH3Eugf3NpHHiH5UcJCBi4hrY0RVcA8OeKaDKK8C1eIPnHPiwcW6O/sLRs21juzSgJca2jgtMFCVRIq7qL39BHFglelb3t8UsEy/ZkJ+rjXwWjlcpn2E/uNxGGYwmSNR/gZK11Wu2dZ2WqBdBIiL6AIkKWWrDaKX9KmD9nI6oMQzLXgCKGnEbN/hoO5o0s0xFZmfUsU3lkOMyLCshVZRtSwuuh0u1CqYRoYQ/IWU5qBtMrYao5wLvC9P5xs8ThLCLYhg4XFHjZgqHWPJxwwMSwv+MD7KdJ2Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BVbIdh++wUeGx0fbN7MLKp+4wN1+HXw+cUZP7UccRgw=;
 b=BlnEdwl5AQYcta5OayD/6gQNYVcPrDJYrbhcfdUofjVfH8Hm3ZmHU/WVQh0rRNIGEYjRJ9Ds72OvpBaEsTgJKWOrpUvyYLbDjX3+sJm0rQlwxAxWlq6iKphpiGrL6Dp3614RKuA70zZtLtahhdzDtlJNWKsQYfJ4TyRBsg4OXx4fa3xKm653io29f/cxjCqaQ7vGOk1rdghX8W+6Ekw92xWv2sd7IQUGAU+cAwGnEchmnEjsHfuNAK4qEiTtBpLY8pINWIA/JrlvRNj74b66Z30p5Z0UFz6Dle5dhpEOBe732T0+W7ERI+xAhTwnkU/eApVGE4t3Q0UWgdp/0vN30Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BVbIdh++wUeGx0fbN7MLKp+4wN1+HXw+cUZP7UccRgw=;
 b=ojZREBiWmuKzuvynMcJ7QA5MUCZ361eQqd/b02lkvag0tI8889QRZIXMnZt34rCf6ymhLIDEfureCgQiucZ2GizGJ8kOJKtcMsk60NfEzgcWWiWXGnXalbL8XS3I6XGaQHmIJ1GcdzaReLVn8EvgtpAvAqsXV4C7pkN031+08UqPo/jl4uXF0vCvo2ZM6kj9QVhN/u+nBzfWYndf8BBv11yEB62v05Qhg1oo6ZNCGz9OSjia0Gg4gc3gIND7MkIVWNmmoIyhszTcwi0hIyoWFNmzE5JVDL3m6PLHkZ85eRG1GuiBYkI8NdXaPQxKWSg6zEY0TtjESwB/2RLKfWI5jQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com (2603:10b6:a03:2d3::20)
 by EA8PPF1471CA897.namprd03.prod.outlook.com (2603:10b6:30f:fff5::845) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Fri, 6 Nov
 2026 06:17:11 +0000
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01]) by SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01%3]) with mapi id 15.21.0592.009; Fri, 6 Nov 2026
 06:17:11 +0000
From: tze.yee.ng@altera.com
To: Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Ulf Hansson <ulfh@kernel.org>
Subject: [PATCH v3 4/4] mmc: sdhci-cadence6: read SD6HC DDR50 tuning from device tree
Date: Fri,  6 Nov 2026 14:16:55 +0800
Message-ID: <20261106-sd_cadence_ddr50_v3-v3-4-cb50afece614@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261106-sd_cadence_ddr50_v3-v3-0-cb50afece614@altera.com>
References: <20261106-sd_cadence_ddr50_v3-v3-0-cb50afece614@altera.com>
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.16.0
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR05CA0045.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::20) To SJ0PR03MB5950.namprd03.prod.outlook.com
 (2603:10b6:a03:2d3::20)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5950:EE_|EA8PPF1471CA897:EE_
X-MS-Office365-Filtering-Correlation-Id: 64280741-9964-4922-a27c-08df3bcd97b4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|261022075727099003|261021123027099003|261021121427099003|261009223027099003|261026121527099003|11063799006|10067099003|261102123227099003|55112099003|22082099003|3023799007|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	LlWdKHa4GB1VMoF8e4fQUxWux7z02P3EylZIwOyb5kUKQHjUc1e4iYq0xnRkFTI1ATs4Lb4F+CEUlmKS1foC/QRXoRqxJqzGx0KfvrSdE9K4Mv2Gt5fHRNTaksnvVPjq0DULiZxI9UXLlGp7ANY+idMAf9S4kk3o6/GWFBwczgzWwdiYutofRkHZbCQn56FEQuTvD9ky2IXL5jRlNJDTNlRppEliTVJaqLnpmZ7GB8HqFHdSd3C4Z3ohzMO8jzxcdtViJ7anuuMpeQG3hKcfx1NAWavaj5c8iZlTHvJ530ZND1Gnc+aZCfxhkRnKNZYURNvRdpD3tHgUCcEJgCci9d3IjSRiPIGp37i3ZrqPaM0OANkzbLz09R7wzuZuMdGi2VP6BM4EeI8K7mXxJK/GvILaxVYlOk6l4oPsflh8NPwzWXl3KEIc4cY2yzvEnuv2Zi6RCeC3S9SetH+JeOUvQ1xkK3c9RS8uOKO4DlXSF6boqy7yre2Lixub1wr6YbA1bdbBjFVMVJjuXyaexHY3VTc2/7jJhqlaaClAaKknaKLUs7ZPcflAFyUBXXrkmvx9L8vWCISnMq+1bZo2r+N4jJZK7WluSwFkVaW9BkEZuerlOsIbr6iNkSaqXNb/Aa51ip4d3yoth2HArHog4YDTNYMru7+nWkPYjgaBXT6cIRQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5950.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(261022075727099003)(261021123027099003)(261021121427099003)(261009223027099003)(261026121527099003)(11063799006)(10067099003)(261102123227099003)(55112099003)(22082099003)(3023799007)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eGY3b1NmU3JPRjdCcE8xQXhETTA0M2tscVAxWFI0U2tLM0NTdjk0d25lbXRL?=
 =?utf-8?B?eVBodmo5UXAyQlorL2hNK1g5OThqVWcwN3pRVnBrRVBHLzFvRDlNRHBONnNz?=
 =?utf-8?B?N2JGbDJWakRQdjVaVGNjN1NUbFhJVEhVZk5OYXdiVDd2Zm1uMVkvcWlYVllT?=
 =?utf-8?B?c0E4dFd3eTc0QmdHVlVwaUwzV3U2WDIyc0UwWm8zbGw5TlRZTldxNm1FSmww?=
 =?utf-8?B?TkZUT2RIRmcyYWNqSkRwSmpmN2VMZmw0K1lpckFJLzFHQU1tRGFIeU9iaEVU?=
 =?utf-8?B?Q2dPYTNjWVI0T1RKc3RTZThoVE8zUFd6MnU3SldPUjF6b3RIRE1qYXA5a0tz?=
 =?utf-8?B?OEx2akwxaXVzNUk4UFM1aDRRL1dhVUh5dStibHd1YklrclZNNlZJMVF1MFYv?=
 =?utf-8?B?SjVvUHZJRWlYY1Vzblc2UjJSVnFwWXVHYjM1T1lIQWZJaGZEdXQwOGRjWEZO?=
 =?utf-8?B?WGFOZU5EMm1PNkRQR0d1U2tFQ0lTd1BDWUhGbUNscmdCc0hrc3VNR3FhK0Z0?=
 =?utf-8?B?Q1cyd1ZYVFVDUVFablpld0xkeUtHSGJTWUVpUTZJT1ZXaEpKZktKaWtzeUFY?=
 =?utf-8?B?NmZwa1dxcCs5K0VLbHBnRkROMDkwTk9vSnNVU2dUQXVXaFFMbHhncnNON0lz?=
 =?utf-8?B?NUx3WURiaFdXZUFMekYxTWFEa0VsTW5WUVd2dWNnUHk5VG1YaE9EYlF1RVFo?=
 =?utf-8?B?bjZzaDhPR1EzK1laZjFveDNJK1hzWk13RDZQbGpaNncxTVlSbGc0VlB1Wlh3?=
 =?utf-8?B?bFRKV1E1NU12THVmU28zTFZHazc2WWx3R205c3JxZ2N4R2VpYThCRGlhS0dW?=
 =?utf-8?B?SWtXSHEyQUx3blV4UytwY1N2TzVrcExDcnM3M1RDVHVRQUdLYk83UHNyU3dL?=
 =?utf-8?B?NTJteStKc0h2REFwaVRFcEJmdTJsZEhkUmVrWTR6NFRPRUdiU1NDbkw2Nmhn?=
 =?utf-8?B?TlRzcDZrNlk2ZURRUWFKRGw3aUk2ZWY2eGlNRmN4ellYQ1A2cG9VQUtkdnRN?=
 =?utf-8?B?LzNPVXgwRVkyN0ZIenZDZjBMWHdVZnVKVGt1RUVGQTdFclp2TU0xenR6M01P?=
 =?utf-8?B?MFV0MW5xemJrOWR5RWh5bnVzSDhuL1ZMSkhGZC9EYzlQclErS0g5K1dQTEps?=
 =?utf-8?B?N1RyM0x3UHdNUkI2aWQxK0N5L1NpUmdvclRtZk5rYUl6Z0N0YkNNSFA0ZkJT?=
 =?utf-8?B?TlBpZWRLd1lMOEI5SFYvNWVXbzBDQ3lCQjU1Z0hJWUZDRUMvSzNKQWxQcGFw?=
 =?utf-8?B?TXFNemd2eTh6MmpSaGFUcnhVUUpaU1JMbENmcHJZaml4QWVYNFhwNUFMeFRi?=
 =?utf-8?B?OHlaQUdLeTBDR0RUYWJYVC8xdmhXdFdXeHhZaVRCMzR0QXNXNEhjcXNsbWZy?=
 =?utf-8?B?UDlib25pZVdmYjYvUWVXV1lMYjhlNW1Ld2VYcHg2Y1VuQmkraUZBUzROdm9U?=
 =?utf-8?B?YUJPZC9nbWkvY242ZmNkQ0t6dEVia1llTXNHSXZiUEk0U1dXVWt2eEtMa0dh?=
 =?utf-8?B?OG9TeHFoQU9EL3daT1JwVi9veDhNMmpiYyt1dm1WNmJwTmYyb3VubjlPYlJj?=
 =?utf-8?B?cWdycjAwU0xTaXZ2TXdHV0h5djFTNENad1J1emo3VWsxYUtqd3R0Uzd3WlNl?=
 =?utf-8?B?SjVLdUg4UmxJKzdoSU9BQnNRNURSNnU4azYyMkM2SG9DY3JWU00vSVBBK2pS?=
 =?utf-8?B?Q2xHL1hjanRFRWRLbXZ0Wk9TOXdkUXB2eXlUa0hSdEdqNGlTSHZrZ3E3Tyt5?=
 =?utf-8?B?dDlBTnZHdzcyZEJTSmh6QkJPQ3FRTTY4akpIN3U0a2o5c1pCQ2xhV3FZNHpB?=
 =?utf-8?B?d1ZHNmJFdWxNbW95eDM5N1J5M0ZHVDliVXc2TkRmRzNFVFRjWWl4ait4Q2F2?=
 =?utf-8?B?WE05d1JWUTBGRWVaTDJCdS96THRCNjhzeHJVdnJTUU9Cai9QeWJubmZnZXdm?=
 =?utf-8?B?U3oydWphTHluYkpSR0JCOTB1alE0ODlOSDNCRnVCam55c1NDTGRzUHVWSnlj?=
 =?utf-8?B?eDFqTE1tbnBmeFBvVTl0bis3d0NWbjRCSm1PS21EejhUK0lXQ3Q1KzFWV05j?=
 =?utf-8?B?USs4ajNpVm8vVDJGdnpJTUJvWDBzaC9BTUszeUtMY2dMZ2pNME81SUt1N3BT?=
 =?utf-8?B?UTZsNHpiL3V2WCt1NmlaYnBOck1xd255NXAxQUxoZG9zN0ZLVVNacWozSGlD?=
 =?utf-8?B?YkUrWUFmdkx2VGRlVEFaQzQ4RzhYcExrUzN2RnpIYTUrMDZLUEx0N3U2NGJJ?=
 =?utf-8?B?MzJuV05XV2w4RjdXVVBCdmpWcm1VTk1EWUxPcVg2dFRRVkFkVGw5cXpDVzVT?=
 =?utf-8?B?QjBFc3VWRHlaS01PSjNINVFoMXNZazYxM3IwdFh2empTZVpmZ0djQT09?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64280741-9964-4922-a27c-08df3bcd97b4
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5950.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 06:17:11.2007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DWlNZzcIcgG9azQi2JjsWY+YuFzcV8nijxkLk6DoEHNTk+7hHUmB4NGXBGSR7DrisABOu4hq5DLdBzM2vydeag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EA8PPF1471CA897

From: Tze Yee Ng <tze.yee.ng@altera.com>

DDR50 has no CMD19 tuning, so the SD6HC read path relies on static PHY
settings that need board/SoC characterisation. Read the read-DQS delay,
read-DQS source and phony DQS assertion timing from the new
cdns,ddr-read-dqs-delay, cdns,ddr-no-lpbk-dqs and
cdns,ddr-phony-dqs-timing DT properties at PHY probe and apply them in
the extended-read DDR modes (DDR50 and DDR52). The read-DQS delay is a
count of DLL delay elements (each cdns,delay-element-ps wide) written
directly to the 8-bit PHY field (0-255).

Loopback DQS is the recommended read-capture path and stays the default;
cdns,ddr-no-lpbk-dqs lets a board fall back to the fabricated phony DQS.
When a property is absent the driver-computed value is kept - for the
phony DQS timing, the value derived from the RE# pulse width
(REBAR_PULSE_CYCLES-1).

Signed-off-by: Tze Yee Ng <tze.yee.ng@altera.com>
---
Changes in v3:
- Read cdns,ddr-read-dqs-delay directly as the delay-element count and
  write it to the 8-bit PHY field; dropped the ps->element conversion
  (divide by cdns,delay-element-ps) and the FIELD_MAX() clamp.
  (Krzysztof Kozlowski)
- Hoisted the repeated DDR-mode test to a local bool. (Adrian Hunter)
- Removed the probe-time dev_warn() that validated the firmware value.
  (Adrian Hunter)
- Unwrapped the of_property_read_u32() call to 100 columns.
  (Adrian Hunter)

Changes in v2:
- Updated patch title to "mmc: sdhci-cadence6:" since it touches only the
  v6 PHY.
- Renamed the properties to cdns,ddr-*.
- Read cdns,ddr-read-dqs-delay-ps in ps and convert it to delay elements
  (dividing by cdns,delay-element-ps), clamping that quotient to the 8-bit
  PHY field. (Krzysztof Kozlowski)
- Read cdns,ddr-no-lpbk-dqs via of_property_read_bool().
  (Krzysztof Kozlowski)
- Dropped the v1 per-property range checks and redundant FIELD_MAX() write
  masks. (Adrian Hunter)
- Apply the overrides in both DDR50 and DDR52.
---
 drivers/mmc/host/sdhci-cadence-phy-v6.c | 48 ++++++++++++++++++++++++++++++---
 1 file changed, 44 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-cadence-phy-v6.c b/drivers/mmc/host/sdhci-cadence-phy-v6.c
index 8d6a9c26c139..d905e39d4b6f 100644
--- a/drivers/mmc/host/sdhci-cadence-phy-v6.c
+++ b/drivers/mmc/host/sdhci-cadence-phy-v6.c
@@ -129,6 +129,11 @@ struct sdhci_cdns6_phy {
 	/* Active delay element (ps); doubled when one SDMCLK requires > 256 steps */
 	u32 delay_element;
 
+	/* DDR read-path overrides (SoC-specific) */
+	u32 ddr_read_dqs_delay;
+	bool ddr_no_lpbk_dqs;
+	s32 ddr_phony_dqs_timing;
+
 	/* PHY_DLL_SLAVE_CTRL register fields */
 	u8 cp_read_dqs_cmd_delay;	/* bits [31:24] */
 	u8 cp_clk_wrdqs_delay;		/* bits [23:16] */
@@ -145,6 +150,7 @@ struct sdhci_cdns6_phy {
 	/* PHY_DQS_TIMING register fields */
 	bool cp_use_phony_dqs;		/* bit [20] */
 	bool cp_use_phony_dqs_cmd;	/* bit [19] */
+	bool cp_use_lpbk_dqs;		/* bit [21] */
 
 	/* PHY_CTRL register fields */
 	u32 cp_phony_dqs_timing;
@@ -511,6 +517,7 @@ static void sdhci_cdns6_phy_calc_dat_in(struct sdhci_cdns6_phy *phy)
 {
 	u32 hcsdclkadj = 0;
 	bool strobe_dat = (phy->mode == MMC_TIMING_MMC_HS400);
+	bool ddr = (phy->mode == MMC_TIMING_UHS_DDR50 || phy->mode == MMC_TIMING_MMC_DDR52);
 
 	if (strobe_dat) {
 		phy->cp_use_phony_dqs = false;
@@ -523,13 +530,31 @@ static void sdhci_cdns6_phy_calc_dat_in(struct sdhci_cdns6_phy *phy)
 	if (phy->mode == MMC_TIMING_MMC_HS200)
 		phy->cp_read_dqs_delay = phy->hs200_tune_val;
 
-	if (phy->sdhc_extended_rd_mode &&
-	    (phy->mode == MMC_TIMING_UHS_DDR50 ||
-	     phy->mode == MMC_TIMING_MMC_DDR52))
+	if (ddr && phy->ddr_read_dqs_delay)
+		phy->cp_read_dqs_delay = phy->ddr_read_dqs_delay;
+
+	phy->cp_use_lpbk_dqs = 1;
+
+	if (phy->sdhc_extended_rd_mode && ddr)
 		phy->cp_phony_dqs_timing = SDHCI_CDNS6_PHY_REBAR_PULSE_CYCLES - 1;
 	else
 		phy->cp_phony_dqs_timing = 0;
 
+	/*
+	 * Loopback DQS is the recommended read-capture path; allow boards that
+	 * need the fabricated phony DQS instead to opt out in the DDR modes.
+	 */
+	if (ddr && phy->ddr_no_lpbk_dqs)
+		phy->cp_use_lpbk_dqs = 0;
+
+	/*
+	 * The computed phony DQS timing above is derived from the RE# pulse
+	 * width. Allow a DT override for boards whose flight time shifts the
+	 * returning DDR data relative to the fabricated strobe.
+	 */
+	if (ddr && phy->ddr_phony_dqs_timing >= 0)
+		phy->cp_phony_dqs_timing = phy->ddr_phony_dqs_timing;
+
 	if (strobe_dat) {
 		/* dqs loopback input via IO cell */
 		hcsdclkadj += phy->iocell_input_delay;
@@ -693,10 +718,11 @@ int sdhci_cdns6_phy_init(struct sdhci_cdns_priv *priv)
 	sdhci_cdns6_dll_reset(priv, true);
 
 	reg = sdhci_cdns6_read_phy_reg(priv, SDHCI_CDNS6_PHY_DQS_TIMING_REG);
+	reg &= ~SDHCI_CDNS6_PHY_DQS_TIMING_USE_LPBK_DQS;
 	reg &= ~SDHCI_CDNS6_PHY_DQS_TIMING_USE_PHONY_DQS;
 	reg &= ~SDHCI_CDNS6_PHY_DQS_TIMING_USE_PHONY_DQS_CMD;
 	reg |= SDHCI_CDNS6_PHY_DQS_TIMING_USE_EXT_LPBK_DQS;
-	reg |= SDHCI_CDNS6_PHY_DQS_TIMING_USE_LPBK_DQS;
+	reg |= FIELD_PREP(SDHCI_CDNS6_PHY_DQS_TIMING_USE_LPBK_DQS, phy->cp_use_lpbk_dqs);
 	reg |= FIELD_PREP(SDHCI_CDNS6_PHY_DQS_TIMING_USE_PHONY_DQS, phy->cp_use_phony_dqs);
 	reg |= FIELD_PREP(SDHCI_CDNS6_PHY_DQS_TIMING_USE_PHONY_DQS_CMD, phy->cp_use_phony_dqs_cmd);
 	sdhci_cdns6_write_phy_reg(priv, SDHCI_CDNS6_PHY_DQS_TIMING_REG, reg);
@@ -878,6 +904,7 @@ int sdhci_cdns6_phy_probe(struct platform_device *pdev, struct sdhci_cdns_priv *
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_cdns6_phy *phy;
 	unsigned long val;
+	u32 prop;
 	int ret;
 
 	phy = devm_kzalloc(dev, sizeof(*phy), GFP_KERNEL);
@@ -916,6 +943,19 @@ int sdhci_cdns6_phy_probe(struct platform_device *pdev, struct sdhci_cdns_priv *
 
 	phy->delay_element_org = phy->delay_element;
 
+	/*
+	 * Optional read-path tuning for the extended-read DDR modes (SD DDR50,
+	 * eMMC DDR52).
+	 */
+	phy->ddr_read_dqs_delay = 0;
+	of_property_read_u32(dev->of_node, "cdns,ddr-read-dqs-delay", &phy->ddr_read_dqs_delay);
+
+	phy->ddr_no_lpbk_dqs = of_property_read_bool(dev->of_node, "cdns,ddr-no-lpbk-dqs");
+
+	phy->ddr_phony_dqs_timing = -1;
+	if (!of_property_read_u32(dev->of_node, "cdns,ddr-phony-dqs-timing", &prop))
+		phy->ddr_phony_dqs_timing = prop;
+
 	priv->phy = phy;
 
 	return 0;

-- 
2.43.7

