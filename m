Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2056.outbound.protection.outlook.com [40.107.101.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF6780632
	for <linux-mmc@vger.kernel.org>; Mon, 13 May 2024 21:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715635540; cv=fail; b=gUqh9NAnkr7gjRodCt/tXVu8kMUOZ1GTUrR2PY8VAyECOr9bdDP4nsV+opLZjEwN4UwOaCRCHK9WSbuPHOV6zQwkYTV/XyXyFJCsop/5zYmiE6FpimIJzz3cgxblBOvuM2ldmwuC+/Z22MybdDAo1Bxm3uOYIVmuI06Ear/yvUA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715635540; c=relaxed/simple;
	bh=V42f7jI/qv4WVFsOBNOjXu/de1RbecBKuDHRbH7G+Hw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kNSs26XOzf5OiItC1L/5RPnc+mRJJUUWMMrUOVKnZziPjZ2w7PxOQiRDQJ20OEoZcBPZoLi1BzNQhjA+2JEt99yuoW3Dvr9aBHYeQ1XaQ+EQYZ+7ls/EnASKP7Qa1oVEc7Zks4ApjhvVzJN6KEglCFStSbo1Jvrcv+nUkkZR7lg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PLx66NV8; arc=fail smtp.client-ip=40.107.101.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PLx66NV8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aQZ4sdzVmHGGpjSbZ1FIiMXD9bNddOPIWAInX35flNThvuSytDEM88RrsnXGO6i3Q6GrMRATqoE11iHq86n5ikegOYZg968W0IyTGFo3xFxToPLb75494iHp75rmcEhJd/VFe5EJ1UpHpKfuijuXfV6T0xo2DXssOJrBbXClh/WgJEg4ej/L2e/VRy8rVMgVo3BpVxq2gxJsqXCtZaz0vqhuLt5hFwJHvVv7J/zG/fZxrKoeY+Z1NQnHujGJ49NCtXyvEv2t/CNk/iXdoF/eC43A9puJGZMEVPOeuo6Lyu8ych2GyWp4MBi5SeJgfPiiqYrJkfuKPN6Z9tlu8GGmbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V42f7jI/qv4WVFsOBNOjXu/de1RbecBKuDHRbH7G+Hw=;
 b=fHNYmp7FUF4pswJ8QFKkf9CVBjGFoZ56KaeKKJdlRkVC2BXAUcfOzvo4gd/Kwd2p8TWeYzII4161XlaDfwuaYCcEU3tkN/HNKzgPtvP+6XI+YHikNEj+GKQ6CfbW3iMayZh1ZlkFxIIBl9MdsG4ojJdHTLXM3EnQXnL81DJUXTRgOJo1utelO0Adydl6yFlh7uyo4S9618GtqlITxSymbzgWlcSQPrAn8R3ebNpHFiEpCO2JhHFQH9DBy/qzfAdoyyuP1sxBjB2O/JJQ241gHX2ryyDdztXH3buw0UDgqz0a9z7AoicN9ag0vwxJKQt/G15G86N/PsNgx5RXNtfoIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V42f7jI/qv4WVFsOBNOjXu/de1RbecBKuDHRbH7G+Hw=;
 b=PLx66NV8oF7xg1h44+fih0BGfJg4QdlAWzGT9cygLr5LtHVbVLxy85agwqc5HXDvK9Yh2N3B+VbZdVRmsn0Ul1s6otbX4e3u2oFDyPxUJHPPbGIJGOjLSbf4KxVsTl3MEjCChsFd8gtYjbxoe0ymMvhl2CpooaI0xcDAQaHXK6qPj8bDYO2uAe5dL0h8kCdHDjIzvSH8N0D84H5FU4TL0jH4Ennsp5uxaWhhHMBb/DldrASL1p8v1fXcrVGN+KcKmFT75314lH5b2bvh26cG5gUamp1zql7pAFFntNuHxf1dddnr8+7t2DVh63CyUUPNsFWRMfilOALh/7iEhMK4Wg==
Received: from BN9PR12MB5068.namprd12.prod.outlook.com (2603:10b6:408:135::21)
 by LV2PR12MB5893.namprd12.prod.outlook.com (2603:10b6:408:175::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 21:25:36 +0000
Received: from BN9PR12MB5068.namprd12.prod.outlook.com
 ([fe80::7274:cdb1:c663:641b]) by BN9PR12MB5068.namprd12.prod.outlook.com
 ([fe80::7274:cdb1:c663:641b%3]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 21:25:36 +0000
From: Liming Sun <limings@nvidia.com>
To: Adrian Hunter <adrian.hunter@intel.com>
CC: linux-mmc <linux-mmc@vger.kernel.org>
Subject: RE: Question about mmc_blk_issue_flush() failure and recovery in
 Linux kernel
Thread-Topic: Question about mmc_blk_issue_flush() failure and recovery in
 Linux kernel
Thread-Index: Adqk3+wMGg+oOeL0Saq9hCN9UR8q4AAElWGAACJidEA=
Date: Mon, 13 May 2024 21:25:36 +0000
Message-ID:
 <BN9PR12MB5068D7320A458F0A057B1920D3E22@BN9PR12MB5068.namprd12.prod.outlook.com>
References:
 <BN9PR12MB5068667F4108339D4B140274D3E22@BN9PR12MB5068.namprd12.prod.outlook.com>
 <579d5e7a-0745-4598-9d1d-ac951992a549@intel.com>
In-Reply-To: <579d5e7a-0745-4598-9d1d-ac951992a549@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5068:EE_|LV2PR12MB5893:EE_
x-ms-office365-filtering-correlation-id: e637b477-7696-42e5-d7c4-08dc73933ab5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?aGQycGtpM1lpWmJwV3doaGVBb3Y4MksyTEZlSm1DMmp3M1cwSmxwNHA2cnd6?=
 =?utf-8?B?VS9pZWlTWGk5YXdxUU9CWWJ1cUtEYWVNN2RzOVhqYXNZb0E2N2h1YXc1UTJ1?=
 =?utf-8?B?RjM5bzBDV0szY200NkhBRzYrc1JuOTc4ZVNoaHE0WUNwZmp1SVl1REQ2UDBV?=
 =?utf-8?B?N2wzdjZHeHhhc0RCbmljbDdRTkkvK1RHRll3d09sdTJ1ZWVLS2FHbzM2Zm5R?=
 =?utf-8?B?Z1UyT3lnNGQzYU0wQ0FWUzA1a2JTdUV2OXJNWm9sY000VFRCeUtRaWk1Mmo4?=
 =?utf-8?B?cXpyN1MzTDR4b0lFSGltM1FWcDZXM1IvMDdlVFB4L0VkQ0NTVmRlTjh2QUp2?=
 =?utf-8?B?SmVBcTBab1o4Smd4YTdKNWxaQXJSbzEyRVJsOXpIN2c1ZUFKTzJRbFUvVWxt?=
 =?utf-8?B?UDRiTktrK015aGxFUXdNZ2p3THZpOFVuZjNYWVl1ci9HSEJSWG1ubkRETm5D?=
 =?utf-8?B?T0h6NWV5M09ibzNrc0xVU2w2TklBYlBueFZDL3RoOXhCQlpKREtISjZlWFJL?=
 =?utf-8?B?dUl6anRudHpLWXpOMm9WcWxMVXNYQkhKNTZDTWFINHprenR6S1FuRitjeEpJ?=
 =?utf-8?B?bDVMTENsVUEwVG1WYm8yT3diWi9zOTd5cVkrdUVzYnVNM1grNVdieXdXTFN1?=
 =?utf-8?B?TkY4SzA5UjNUQW9RQlYzSllIelRvWnZVeEphREVrUnc1VExhRGNkWmY2Q1FK?=
 =?utf-8?B?K2k0WjlYemNrU1hIeURIbGU3aVZ6eXJ0WisxdFZlQzBwVUFYaTh1YnFobnkr?=
 =?utf-8?B?WTB5eTFNeS9JU1ZQNTRVZ1VPQkdEQlZ5VGcyL2Nhb3RsRWErV0hGc2hFLzkw?=
 =?utf-8?B?VXl2aGgzanNaNUFaRVhmQzZvSmg0VzdzZFZVU0JQMDF6enhMQVgvc2xDSEU2?=
 =?utf-8?B?SWNZVEptdmJCM0NsN3BRZnYxdWFIY0hVMldnM05OcjJNMHczeG5rRFZGa0Ny?=
 =?utf-8?B?UndHMnQwOUZMb0NqamM1SllPMWYrZXkwVGJ1QjZya0tORWY0S0xkc3lKNTd5?=
 =?utf-8?B?TCtuM1VMeDM1ZEhJN1VHcEVmODRMRkxlV2VNcUpOVXg1MDlodmh2azkwV1Jh?=
 =?utf-8?B?S1IxaEkzQ05nYmZzUHdxQVF1QXo2TjRlUVlWOXkxRWhnbTJjNFBPYlZBNngy?=
 =?utf-8?B?aUZCTjN6OWJyV0hlbDN6cXFOSERsdVlJbGZYd2xqTkJlMjliZlJYVDIwc3hl?=
 =?utf-8?B?bE9PMTlGWi9kOXgwQk1PZkFha3NSKzhZSW96VWd3cEpQbzhmeE0wOW84dWZD?=
 =?utf-8?B?T1F5WW9rdzBjL3prQkVVRDYvcXE1MFRZSm9zdWV0SFZDNUJhVGs5d05IYytN?=
 =?utf-8?B?Z2trRmdnWStvMTlQczVzaUNadEtIRC9TYVpxR0RFOXRFYUd5T1VrUjdCZUxG?=
 =?utf-8?B?dlM4eUlHZWp6RXhjZm5OMHJCemJORHJaRGNpWm5kVUdJUlRrOVZyb2V4QVV4?=
 =?utf-8?B?YnRZc2dOT3F2ei9TNGJNVXJVSCtIOEJML1R2ekZ5TWtoNjFYOEdsZUFJd1cy?=
 =?utf-8?B?eFYyT3lCVVMxdm0vcnpEKzhkOE5semh2R0dwWXZESXhJQng0SGlGbzM3NE9h?=
 =?utf-8?B?czQ3OGZkOGtublhNQTZ5R1crVGFnRDljM0lhSzdLYTRDWVFHRWJnZXdQZjJw?=
 =?utf-8?B?anZ6MTQra2ladWtiZ2pHa3JVeVI3a0FKak53M3lRay91ZUNXSElQT3BLbVpC?=
 =?utf-8?B?Mkx4cmhrUERnTmhXMm5JbEZNZnAwVlNXbGZxa01GdTUyeE1wSkJoQmpJZENO?=
 =?utf-8?B?aSs4VXI1U2JacjNiTzhsbHFLcWpqQk9zbXpjSDZpcjN5bmNtMHNiNUZydjVw?=
 =?utf-8?B?Z1YrMFdzWFFjcU9FUEVVQT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5068.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?STVYajdseGZ4YStKa0dxWWZHOFlaa3NhaEVWTVFIVy9yWEVjWklvaDJlTEtv?=
 =?utf-8?B?RXhvVG0xaGE1ZnorbTBvVys1T281aGIvQk1UNjZ4Y3p6UmpMa29namxNeUZa?=
 =?utf-8?B?a1FveDJCWkd1UnNkQk5aSGZVbU1lTW9EUU11OFNDR1hMQm5MQy9nU1J5Nlhl?=
 =?utf-8?B?WjM5UDhLTVdQb3M3SzdtYVBmaytDSTFxNXpFU0wvOE8zSTVqNGlFRUUxanlu?=
 =?utf-8?B?NnJvalFGcWVLenAzbDJEam1yWHdmcDB5bThTQXoxd2U5ZzdTNU5xdkx0cGlT?=
 =?utf-8?B?b1BZQTkweXFRcnVpS2xROVVyWk9HTnljYUtsS2hIaGN6OC9aUUhyK0x0V2Rv?=
 =?utf-8?B?U0FlUTRUREFjNHBqdVRITEg4M01RWnhNcHFGd20xN1pCR1h1a2FqR0UrdHZ2?=
 =?utf-8?B?UUZVZDhNZzRIcjYyRkFPb2prU0txcW1BVkFhdzhITms1VWRnY3pFNnV2ajEw?=
 =?utf-8?B?ZzAraUo0Yys0ZVZFWVgxMitja3JLaXBkUld1YzhtMnFpMkxwVGtaeTU1MnZu?=
 =?utf-8?B?N0paUkJGMHhaU1N5ZHVrYXJUM1VqS1hzMnBoT3IwMytpSnBLOW1YZVdCTWlW?=
 =?utf-8?B?YjByNHViNmhyLzJSYTVjbTVBZktQZk5CWmtOQnMyTzRkSGVxY3NNY2xWNkJT?=
 =?utf-8?B?c0xtYTA0TzBOd2F6SWw5dWs4UGx2K0h5QVlpY2tQRHdBVFlQeFRJUXh5R2Qx?=
 =?utf-8?B?ajVhSHU2d0s3dElWcVVWQ3U4T2w2ZzNjMVo5SS9hRjNla3o4QmkyOFpFVGhh?=
 =?utf-8?B?TXFpcmxxTHl0bDN1MmlocWdZVlQ2cmErcWJ1TitTalRIWlh2VmFVQjgwa2hO?=
 =?utf-8?B?RkVXVDNnZUFtZG9obTk0N0ZFNGxSSEFhSW01ZE8rcDBjNThmOWFKWjlqNnAx?=
 =?utf-8?B?aVRSVUNvNE51WTFyOHhNYTYxZTZLT1FPODhYTmZ3TThTTmw2dDNUaXZUclVv?=
 =?utf-8?B?eXFyOG5qNHpvK1RuM0FvaUFuTnpkMDd6alIyZ1BiNWFsOW9WdlFQVmN1MGNa?=
 =?utf-8?B?UCswb28rYkZtT2s3N1BWa0pBRmlCdFUvSm1GYldWNHRlOHdGTStoR2NGcDg2?=
 =?utf-8?B?RE51T3FkaWdkK3lPcXVRN3ZOeGNnV09XbkVhTy91V3RKS3kvVDZmbEdubUhi?=
 =?utf-8?B?RE53M0FQdXpDSHp4Qy9HWVlRY09JNmtOamJvVkZya3hsdm5KeG8vSDh5RTAr?=
 =?utf-8?B?QS9RdE1wUHB3d29uZUcxRHhacGVQeWE4QmQ2bDFscXhMRDB4Wm5pNlZsSTJy?=
 =?utf-8?B?aitVejBXNjBBdlFEN2hCREhxdk82dEV5dmh0NFBId2lnN29jOUwvMC93T3ZN?=
 =?utf-8?B?OW1MVEszL1o4Vm01QXFOdnJhTy9PelNHdTNHR2gzSnhRbGNZb2lERWNOVzJj?=
 =?utf-8?B?R2FvenViZXhCY2tSSEJCNE15MTZmRUFJYzh4ekVJYzNBa2U1eGdCelMrWnVy?=
 =?utf-8?B?cHBMQ3ZVaHBoVXNJeWs4Z2t4SitnWm9PQmtpYnRodXdMdEJ0T2lGQUJyYmlo?=
 =?utf-8?B?K0xJZFBZZ1lXRUlGWVk0c3ZhdXpjcDlVaDRBa1dVSCs1VWowOVBGK0FRSUxl?=
 =?utf-8?B?TVd6NTZBOWlkZnpiNlJSWmRRckszSjhaWEhMOG5VYjA3QkJUT3doVUdvcG9L?=
 =?utf-8?B?ZXI3S0krTlIySStIaEd4RjhPN1oyanRJS096K2pnb2wycmNCeXNwVEkzb3dZ?=
 =?utf-8?B?dWQ3OWFaMVdhR09lMUtLWUw5aUpaelFIU1VGemJKTUNOaXNGL1pYUjkxbkJ3?=
 =?utf-8?B?d2JGNm1iaWE2OGZpcDhOSWpDR082c2lJWmlPT1MrK1dyZG1LR09OUk16RVRP?=
 =?utf-8?B?bkFMWmQ5MDJkdDFpT0R3Q2oyTE1HOUpyamUzZTFuWXZtOFlXaktYUERNKzk5?=
 =?utf-8?B?MS9EUzdKYlh2SWxjRWxkQ3VaSURzNE9xUk9hemYxUit3MGgzcWhZQ2xuWGRF?=
 =?utf-8?B?MUdaQ2krdlFxTHFHakZCMGpZZ3h0THRROHJXdEFLWDhFQ1Yyck15c0JTdjBZ?=
 =?utf-8?B?Z09mVnc3U29jejJ6TkozZEFtMzRjbE9YVG9DZWY1c2hNYk1HYmpneEt1RWFG?=
 =?utf-8?B?ZjRHUWNrbE8ydU5YR2R1ZnNaY092REFrYjNVL0dORHYwdW1xUC9EbGdIL0Qz?=
 =?utf-8?Q?BYug=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5068.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e637b477-7696-42e5-d7c4-08dc73933ab5
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2024 21:25:36.1748
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DC5gYwzRcPdj5P+kUTZLBiAzyqeT9++Vqf+R6HyAgUgoKjl8aSLIN0RF63AmyzZ8tVquOZBzqmxXWtCJi2Fghg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5893

TWFrZSBzZW5zZS4gVGhhbmtzIEFkcmlhbi4NCg0KLSBMaW1pbmcNCg0KPiAtLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBZHJpYW4gSHVudGVyIDxhZHJpYW4uaHVudGVyQGludGVs
LmNvbT4NCj4gU2VudDogTW9uZGF5LCBNYXkgMTMsIDIwMjQgMTI6NTkgQU0NCj4gVG86IExpbWlu
ZyBTdW4gPGxpbWluZ3NAbnZpZGlhLmNvbT4NCj4gQ2M6IGxpbnV4LW1tYyA8bGludXgtbW1jQHZn
ZXIua2VybmVsLm9yZz4NCj4gU3ViamVjdDogUmU6IFF1ZXN0aW9uIGFib3V0IG1tY19ibGtfaXNz
dWVfZmx1c2goKSBmYWlsdXJlIGFuZCByZWNvdmVyeSBpbg0KPiBMaW51eCBrZXJuZWwNCj4gDQo+
IE9uIDEzLzA1LzI0IDA1OjQ3LCBMaW1pbmcgU3VuIHdyb3RlOg0KPiANCj4gUGxlYXNlIGNjIGxp
bnV4LW1tYyBtYWlsaW5nIGxpc3QuICBPdGhlcnMgbWF5IGJlIGFibGUgdG8gaGVscA0KPiBvciBo
YXZlIHNpbWlsYXIgaXNzdWVzLg0KPiANCj4gPiBJIHNhdyB0aGF0IExpbnV4IGVtbWMvYmxvY2sg
aGFzIHJlY292ZXJ5IG1lY2hhbmlzbSwgYnV0IHNvbWVob3cgYSBwYXRoDQo+IGxpa2UgYmVsb3cg
ZG9lc27igJl0IHNlZW0gdG8gdHJpZ2dlciBpdC4NCj4gPg0KPiA+IFvCoCAyODUuODU4ODM4XSBt
bWMwOiBjYWNoZSBmbHVzaCBlcnJvciAtMTEwDQo+IA0KPiBDYWNoZSBmbHVzaCBlcnJvciBtZWFu
cyBhbnkgZGF0YSBpbiB0aGUgY2FjaGUgd2lsbCBiZSBsb3N0Lg0KPiANCj4gR2VuZXJhbGx5LCB0
aGlzIGlzIGFscmVhZHkgdW5hY2NlcHRhYmxlIGkuZS4gcmVjb3ZlcnkgZnJvbQ0KPiBoZXJlIGlz
IG5vdCBhIHByaW9yaXR5IGJlY2F1c2Ugd2Ugc2hvdWxkbid0IGdldCBoZXJlLg0KPiANCj4gQWxz
byB0aGUgZmlsZSBzeXN0ZW0gbWF5IGJlIGNvcnJ1cHQsIGFuZCB0aGVyZSBkb2Vzbid0IHNlZW0N
Cj4gdG8gYmUgYW55dGhpbmcgdGhlIG1tYyBzdWJzeXN0ZW0gY2FuIGRvIGFib3V0IHRoYXQuDQo+
IA0KPiA+IFvCoCAyODUuODYyNzc2XSBibGtfdXBkYXRlX3JlcXVlc3Q6IEkvTyBlcnJvciwgZGV2
IG1tY2JsazAsIHNlY3Rvcg0KPiA0MjAwMjU3NyBvcCAweDE6KFdSSVRFKSBmbGFncyAweDI5ODAw
IHBoeXNfc2VnIDEgcHJpbyBjbGFzcyAwDQo+ID4gW8KgIDI4NS44NzQwMDZdIFhGUyAobW1jYmxr
MHAzKTogbG9nIEkvTyBlcnJvciAtNQ0KPiA+IFvCoCAyODUuODc4MzY5XSBYRlMgKG1tY2JsazBw
Myk6IExvZyBJL08gRXJyb3IgRGV0ZWN0ZWQuIFNodXR0aW5nIGRvd24NCj4gZmlsZXN5c3RlbQ0K
PiA+IFvCoCAyODUuODg1NDg5XSBYRlMgKG1tY2JsazBwMyk6IFBsZWFzZSB1bm1vdW50IHRoZSBm
aWxlc3lzdGVtIGFuZCByZWN0aWZ5DQo+IHRoZSBwcm9ibGVtKHMpDQo+IA0KPiBUbyByZWNvdmVy
eSBmcm9tIGhlcmUgcHJvYmFibHkgbWVhbnMNCj4gCXVubW91bnQgdGhlIGZpbGUgc3lzdGVtDQo+
IAlmaXggaXQNCj4gCXVuYmluZCBhbmQgcmViaW5kIHRoZSBlTU1DIGhvc3QgY29udHJvbGxlcg0K
PiANCj4gPiBGcm9tIHRoZSBjb2RlLCBpdCBtaWdodCBiZSBjYWxsZWQgZnJvbSBtbWNfYmxrX21x
X2lzc3VlX3JxKCkgw6ANCj4gTU1DX0lTU1VFX1NZTkMvUkVRX09QX0ZMVVNIIMOgIG1tY19ibGtf
aXNzdWVfZmx1c2goKSB3aGljaCBmYWlscy4NCj4gPg0KPiA+IFdvdWxkIGl0IG1ha2Ugc2Vuc2Ug
dG8gdHJpZ2dlciBlbW1jIHJlY292ZXJ5IGZvciB0aGlzIHBhdGggb3IgYW55DQo+IHN1Z2dlc3Rp
b24gaG93IHRvIGRvIGl0Pw0KPiANCj4gR2VuZXJhbGx5IHRoZSBwcmlvcml0eSB3b3VsZCBiZSBw
cmV2ZW50aW5nIHRoZSBjYWNoZQ0KPiBmbHVzaCBlcnJvci4gIFRvIHN0YXJ0IHdpdGgsIGlkZW50
aWZ5IHdoYXQgaXMgY2F1c2luZw0KPiBpdC4NCg0K
