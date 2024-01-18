Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2102.outbound.protection.outlook.com [40.107.93.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BD9B645
	for <linux-mmc@vger.kernel.org>; Thu, 18 Jan 2024 06:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705560696; cv=fail; b=Fqb0o7i1ngJZKEqg3DDV/My/l1PHKx/x7LSX+m91v5sGTzFxFhKbwEFJV8BY60v44+qVK6V/5S3Rs72Ln6awLsACm7W8Nz2G7KP/1NJegjh0vIKmW7R9irv4NEGURjBys/yjtlAjEyYJ9K30FP9QhfAcbBBhA7JSS+c2GoIPofo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705560696; c=relaxed/simple;
	bh=o0DFx0rUW5wDwHnpccL6yLiRaynNPA0Z1b4nG9jezPM=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:From:To:CC:Subject:Thread-Topic:Thread-Index:
	 X-CallingTelephoneNumber:X-VoiceMessageDuration:X-FaxNumberOfPages:
	 Date:Message-ID:Accept-Language:Content-Language:X-MS-Has-Attach:
	 X-MS-TNEF-Correlator:x-ms-publictraffictype:
	 x-ms-traffictypediagnostic:x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-recallreportgenerated:
	 x-ms-exchange-recallreportcfmgenerated:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=AUT6w/v0cjfpjWwvHYINWB5PrLn1YP48FoukyB2VKz+XvucG5qDieTmy2dxw/rMakaD7UDqsUQzcLz4RJndIgykM9A/W4/Y4tPxWvp5VZaNW+B49zzxtGOPtHHUTsadhR0sfei/idNj3ZaSDhbbse5DMSFqZL1ruWo0O5F3SLk8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bayhubtech.com; spf=pass smtp.mailfrom=bayhubtech.com; dkim=pass (1024-bit key) header.d=towerbridgetechnology.onmicrosoft.com header.i=@towerbridgetechnology.onmicrosoft.com header.b=Wpn3gArb; arc=fail smtp.client-ip=40.107.93.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bayhubtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bayhubtech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=towerbridgetechnology.onmicrosoft.com header.i=@towerbridgetechnology.onmicrosoft.com header.b="Wpn3gArb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g2ixTnMFSXMi5f5z+tEAkoZGIJ9ErINC/8bwcOfmXrq2HdpwuI00bpkGhD3Pa06hvqASUWUWX/PiMsCugJgAQTWg5SvIJfi5T/su1RtGt9wAmWP5fns0bX58bKfdFFUChNEuxooaMgDzyk4czuRhiy3SMtfxO9928WrtJfbT8sEH10Pj2X76/ioXenRSFsUe+24oe6pSGMVBt+BWun7sFxdUsLMtuz1i2zC0zeWh154Bwx+AI4S0eEOaIljo6e2b/v4z3kwZchpssiebVqJguqhwfq9JuhEOMYat29PJPfOe3vFZflZiJ1RNa5uyosz+nKZsvrahXi145jBxb5kwDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o0DFx0rUW5wDwHnpccL6yLiRaynNPA0Z1b4nG9jezPM=;
 b=g1dL1wF94FCxlEN/OBoJ4kIy6SHkedovmswPY1QcuyYlrFjUhUnddxGuCSnNOZRNxlACUBKgjHkLOZK3tKI1DRb2hROwJUrbbwIXrsaODgexN7RQjPHJW0hH2BOBSMVpngySd0fnXU1mexXBquG76NUt0wJcvQNdEQwaXxSaEczSMfDcLabnTZg2ubkP0NRdI5wH/zgOrskehErjelt5SMBpD7qiDLgi1PiT4wrdSNgM8XhFGWnM7dWaa6PVfXX89KNZtCF61QE6qC/E5fNST6ErQzDJWVlUocn/e3JKMYOhdcDLAHzWHO8l0cQA4zAM3ofB9/1F3x2pqYWOut+Yww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bayhubtech.com; dmarc=pass action=none
 header.from=bayhubtech.com; dkim=pass header.d=bayhubtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=towerbridgetechnology.onmicrosoft.com;
 s=selector2-towerbridgetechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o0DFx0rUW5wDwHnpccL6yLiRaynNPA0Z1b4nG9jezPM=;
 b=Wpn3gArbvf42gOMSyyj5dQ24eF3rWvDm2WicapY2xu7G2freKPKmr/wcPWohGql5F8qjGO/8oV0jrEqi5W00K9XtIjQ8sVsbXpMUHflUwyzulNGHXj//pqYlUbtX0fowHwSOTw62Qc543K1hjZseGeqEYqeWjpE2kV++M/l4E1Y=
Received: from DM4PR16MB5004.namprd16.prod.outlook.com (2603:10b6:8:43::15) by
 SN7PR16MB5228.namprd16.prod.outlook.com (2603:10b6:806:351::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Thu, 18 Jan
 2024 06:51:32 +0000
Received: from DM4PR16MB5004.namprd16.prod.outlook.com
 ([fe80::17e9:205d:e39b:6666]) by DM4PR16MB5004.namprd16.prod.outlook.com
 ([fe80::17e9:205d:e39b:6666%5]) with mapi id 15.20.7181.026; Thu, 18 Jan 2024
 06:51:31 +0000
From: "Chevron Li (WH)" <chevron.li@bayhubtech.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Brent Roman <brent@mbari.org>, "Fred
 Ai(WH)" <fred.ai@bayhubtech.com>
CC: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter
	<adrian.hunter@intel.com>
Subject: =?gb2312?B?s7e72DogUmVncmVzc2lvbiBpbiBzZGhjaS1wY2ktbzJtaWNyby5j?=
Thread-Topic: Regression in sdhci-pci-o2micro.c
Thread-Index: AQHaSdrENomMRlZR0kS6j59vPMUCfg==
X-CallingTelephoneNumber: IPM.Note
X-VoiceMessageDuration: 17
X-FaxNumberOfPages: 0
Date: Thu, 18 Jan 2024 06:51:31 +0000
Message-ID:
 <DM4PR16MB5004B1DFD0A70A89584CA3DAEA712@DM4PR16MB5004.namprd16.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bayhubtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR16MB5004:EE_|SN7PR16MB5228:EE_
x-ms-office365-filtering-correlation-id: 24e261f9-e562-4c0c-45a2-08dc17f1e741
x-ms-exchange-recallreportgenerated: true
x-ms-exchange-recallreportcfmgenerated: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 0gCJqsTPrLXe5RR4olAj3y8KOz5K5hHWH27gsgcgfIUufLcmwANl2qT7walswLjIk71mdJdZWY0kP6por20DOLfjmPE+4yByF84mvprKYzyS+kznNcr+u6NMEHpXay4+Bv8JyCCeMSsB4yIzRHbrihwjQ/fdInpE1OnH2DR3JiScbLae+7wcyap7oemkWqnIVqWOGmjFwbEQtrruXPIVtB5JfjWY5gDvJypBaVaoHU935lRYrG+un4hiMTxYz6P7m/h0J9HmGPkORNg9wbjtfTxw3VMZcEBBC8D5rnTkit8oyHerke4FDSdT7GrT2pMcj0gRCFfcfScuAUaSt6lN5K36CjncxC2JjKBzwWxLksJ4XB3rqY104EJEAv2DeOP0/r7qm/NCL8BX9RDB8pzOn/Pp7hoR8RCe3ooqYgd+McAMVW8xqVJsSr2jVcHH14Rdvy2cX2iQ9AyGGMpSNT4njukopny6lkW9voozyC1pCrfeWvXb38NL6cyc8Vq42rCGclQIzVTJHUAHi/RIYp8PteGeaOoeW7cJT9Z+p24wJTAcMfqTYs9cmyHOMeqyx5lg5pk3pnR4JQlLFLcDr4hVT7I6tZcx26Ctf3wUQJem7e6BP1Pbqn+R4PjQyr/6RPiq
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR16MB5004.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(39840400004)(376002)(346002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(55016003)(41300700001)(26005)(9686003)(86362001)(558084003)(33656002)(224303003)(38070700009)(8936002)(52536014)(4326008)(5660300002)(7696005)(6506007)(122000001)(38100700002)(64756008)(54906003)(76116006)(66946007)(66556008)(66476007)(66446008)(6636002)(316002)(110136005)(2906002)(71200400001)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?WUR4Q29TZkkwMHFkV0JCTFJTcVdzeFl2Rk1nMGtEaGZKdGNCd2ptMGpFeDdG?=
 =?gb2312?B?eDlsbWlJdUpnVmVEelNDRUdBWDhhUXdzdFo2QVVsc2lYNjh4UXBTZTRReVBo?=
 =?gb2312?B?dmkxWkRBTkUrWmlHSllvODZCcHhpT0pEcXF2Z3lZQlFXSll3YStBeDJndWJr?=
 =?gb2312?B?RVdlOCs2ejY1RndvTmNJYmd2cHhqNUM4R0MxQmVtMzl3MDdjbmluRFgyM1lw?=
 =?gb2312?B?eW1NVEk3T3NMcUVUNCtubG1ZL244cW82MDd6VEcwMnlwdktnalUvZ2Z0UDhX?=
 =?gb2312?B?N2xxSnEzdzlkaDJGdVArbEg3SXRvVytVTFFnaDJLY3U0Y1BycVFDY2w0UXRX?=
 =?gb2312?B?UGlYUyszT2Yxa0FzbWpLUzJoYjNPR0NrRkFYMDJXdTJtbnZFMGcvZU41MVFm?=
 =?gb2312?B?UUVCVlRSRVFWMHhud2FyU3BTSkd5MnJyYkVHSkRUVllQUGxycDBFZlZGZVdL?=
 =?gb2312?B?N3dDYmlRZ29UQ3RtVk1RUnNTc0tPMEZmRjBYNW1icXV0OGJHNVEyOWlJZjNk?=
 =?gb2312?B?MFl3emplSVU3Z0hWa1JTSmgyRzdpVk85QXk0bWx3eTVxdVBWdUtwY1B2Q0lK?=
 =?gb2312?B?MEFaUERRbWN2TkVIVTlHbDhmTEh0d3lzUU1lbmFHd2VvMGEveGlxQitXa2Qr?=
 =?gb2312?B?eVJGdzBhd3JNakx4Z3VkOUJyNUdZMDdDamJSZE8zbUpRY3l6M1p0a2F6UkRn?=
 =?gb2312?B?N2dGbjRYSzF4azgrbU4xTEkxUnQ5NWdaalp2NVk5d1lXRXhLMytKUkF5Yk85?=
 =?gb2312?B?L3loOHByb3VsYUZ1dTRLd2ZHQUx2SXkxa04veVJhK2NtdEFFSy9Dbkt4aWNP?=
 =?gb2312?B?SCttNzRmbDZtVFg4ZEdERzRBd3pEMEY1MVl6TGNHOXp3elREeFdNMnFWS0tJ?=
 =?gb2312?B?NENKT1RnRmFFOFVwMGF0a1FQTStyWHY4dnc0dkNrUWFqRldJNWZiYkx5a3k0?=
 =?gb2312?B?aWJvV2RyR2NrbVFDeDZhRWxMcTVvRjYxT0NKQkhMK3pSN3BQRFRSSzBpdVMx?=
 =?gb2312?B?ODR0dDFBVnJHTjVBbGRTWW5EYjYxdG9ZRC91blNnMnQ2RkJWN3RuMEwxdGs3?=
 =?gb2312?B?eDhyemFGNTZoeXljRHJjclVWUUR2d0VLUk9xQlFiVk5vMS9MMkR4Ry9qQmMx?=
 =?gb2312?B?K0t3YXF4Um9rWDlvSVd6VFhQRXlHcHhHaUVwem4xVHFnR3lwQkZJcGdxWW5r?=
 =?gb2312?B?V2lHWXAvRExCQ0gvNWxYc09INGxBMGFySTFSNTM2Ykx6S1hkZlFNeTQ3RHA2?=
 =?gb2312?B?WlE0S0N3dW44K25WNi85ckdNMUVMV3U1L1RLTGRxQXE2YVlSZG9KbTBJMmxn?=
 =?gb2312?B?S3NLMkhoRkp6VDY0N2VYdzRvYS82OWFxR0dLT2xtd1Vucy9zaHlXMFlHTExO?=
 =?gb2312?B?SmxHWHhRV0EzYWM5enRYWFR2M3BJWE1KYm1GZDJiL2pza201QjhVNG1weE5P?=
 =?gb2312?B?aVozbEFUNWR0blordWFXTGpCSERiUXBqbzRlNE5VOURNOFpkcVlMbkh6V1dD?=
 =?gb2312?B?bzR1bXN6R2k1akVURG1SWTVHT3lwTHhybmdCaVA2UHpRWUVDUndRRlJYV21N?=
 =?gb2312?B?eElOVUcrOGczZHpsb291dTNoZWJJdjhXTjEycWdFVlV0R05HeFFMYkkrN0R1?=
 =?gb2312?B?UzFVOVRjYW1SWXUzNHFJK0ZNN3RERW8zNXFWTHQrTzcrdmx0THJvci9teVdH?=
 =?gb2312?B?VmtZdThCME50dlpTVkxnYzNVcjRVbDRpczVxM3lmVFZ0RWUycmFNRFV2bWRO?=
 =?gb2312?B?S2FtYXhpL2xTWXpSa2JiOE9TeFdVTy80eUo0dmJlK3M2ZmV1VEZvTE1zbkdD?=
 =?gb2312?B?SXNXL1VSSVZkNTN6eXIzenMwNEpvWGxicURWWmlTTnMxUEhBWWNrRFdYcUxM?=
 =?gb2312?B?ZWZ6cktQZjFlMFk3QVFXNFB3c0FLZEpVQjVqMkxHOHJLRVRPVjBiN05zdWJ4?=
 =?gb2312?B?RllqcnRBellJVlF0ZG52cGoyNk1MVFlNZlJmcWd3Zm5vTVRKZE92anptZnI4?=
 =?gb2312?B?LzhISHIxZWNzTDVkZ0RpU3A4cE9rYTM3Wk15Qm4vNCtvTy9DelZuelVXeHlE?=
 =?gb2312?B?R1lmdWJCUWJDYTRuVDhISWM1djdwaGJVT0I0TkgvaFFRS3VMdkltcUZsY21M?=
 =?gb2312?Q?KdyfPk6maaEdd88KY3EbDVxLI?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bayhubtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR16MB5004.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24e261f9-e562-4c0c-45a2-08dc17f1e741
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2024 06:51:31.3644
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0a7aae2b-8f2e-44df-ba2f-42de7f93c642
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cWiWqbDEa2lCQjWftfXbv+3IwHzAIPOUVr/Rp2vjkKasOy0rsvjjHmA/GAh/r4JChyghPdVf5y5O7mLlwZrong/WMpotBArGvL1onJ2kkNc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR16MB5228

Q2hldnJvbiBMaSAoV0gpIL2rs7e72NPKvP6hsFJlZ3Jlc3Npb24gaW4gc2RoY2ktcGNpLW8ybWlj
cm8uY6GxoaM=
