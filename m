Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2107117C7B5;
	Tue, 25 Jun 2024 19:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719342831; cv=fail; b=DoM6eHp5HJyg2zJnVMrdNgGmrR4x1MdHcaImZhZ7fiBck7JQpzxtZ9dm0VyD5WjX7TxuxWj+bif659+O9AIDzG4/zK1n+k1akwThloRke2um/99q8sdZcEYaOm+vjrMm5W6SNMBUZbcN+7d1NdFFRtbNua7YBMisqQrQjw6ygck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719342831; c=relaxed/simple;
	bh=0CNwgUzaJoFE8EuNCdjQEFbeF4zAiXqSFN4CZSvvcJI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hCpf9+yAxOuhVfot8wZoBGlL62ggANwmlumH2bPbkzCyBDdQkqtdpTcHIzzTJlKJUj14JoHmoRkYyBz5agGCYevMSiEAq9s4tVnNIl2EpAO+1Ip2vtWAJSLIUZvqACXPsP22YttczTarCvFSrpmYv4JB2pV3CE17rnew8PW62OA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QHNx79vx; arc=fail smtp.client-ip=40.107.244.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QHNx79vx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AwIYFxh7ufY/sENdfWUcvh/+cJMTdFy/X/y7cP+DfdfuvZf4W5Wf4Do7ny4RDoUfqioADCGUBn3Ujo0BX3lgZsHG8vjN4sXDjVm1EjdcZudYXe1FveAMUqudRGKUU8/4XSyt0uI/PGRv8nUdacjFDsuP1Ixgw3fBdUCKdyjfsusu3HQ5PPAwKKAjqra6o+y4il+4MXoLVCO8mBVOqbwfgPI+wdqfGXnCyHuvbQ8QzUVK3xSk/qX88hV12kjAVRzMwdJLFTDJnVfXXQ23oUObqnyVLerHOGdUtJk8Bq/T7UWiZfUJcNalZmlzlbZGZtRf9j+k2XZ/pg7GOHIAAKOu2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0CNwgUzaJoFE8EuNCdjQEFbeF4zAiXqSFN4CZSvvcJI=;
 b=PFU0C6nfgTbTSl28QB1ntW1XIYWBKdD8bXbehtF/iWlauua6EKIbDGhPRr/cQ0d6+RgMxzeXeAkLwvLmKVJpGuCxD9ClkKdM2QzazAESRqmhi4tQX9u967JigeMkMqYEyVWzNDzhPOJh/JV0nDI87skKub0jIAQxlnHtzkqk1BxHGD3+R9IQGvd9bQGF6C2ypEQlmDfB0QGa01UucDzKraP+J1oF8VgATaWaTmWyErQo8PaAgw3cRAFrxNCSGN/SiX0zuFwRl8StFaGp3Xz6aYgKoSNW9OrnrhCOFz6HoWIQlUxEgflK0R0V5EE912je7CJBSCCG7kSQWkvh1FHTtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0CNwgUzaJoFE8EuNCdjQEFbeF4zAiXqSFN4CZSvvcJI=;
 b=QHNx79vxD3dJ451PEhTQksgYEiaJ7FjYRoRndtA1RQqjtRyJHxtVbfSGq7F4h4RTsUPdYL09qzlXVqjwgOstSp3rwWg1Xg3TILXYl7FSx9zDwiMLStHoN6takzLSDnx77HZlnG1j2/VFSl8iK2RA9F8pWleybcT6/mxRxSPdc18I2YibaB8G8fGrqHi2HIARZ87tkTSs9FS4wZoT2/yG/b/Pwhhvn594Aqz5uwaxMXBG6EOUD3hjtnB66aBAQZj3OYxeEo1vrUTncZxVZB9jXq8nSg+gXUypdEL1FTuNUVBkJVFciFPgkfLn1f4dZjNoaHJwqRp0+ljQFrQm4pWSPQ==
Received: from BN9PR12MB5068.namprd12.prod.outlook.com (2603:10b6:408:135::21)
 by MW6PR12MB7070.namprd12.prod.outlook.com (2603:10b6:303:238::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Tue, 25 Jun
 2024 19:13:44 +0000
Received: from BN9PR12MB5068.namprd12.prod.outlook.com
 ([fe80::7274:cdb1:c663:641b]) by BN9PR12MB5068.namprd12.prod.outlook.com
 ([fe80::7274:cdb1:c663:641b%6]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 19:13:43 +0000
From: Liming Sun <limings@nvidia.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: Adrian Hunter <adrian.hunter@intel.com>, David Thompson
	<davthompson@nvidia.com>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 2/2] dw_mmc-bluefield: add hw_reset() support
Thread-Topic: [PATCH v1 2/2] dw_mmc-bluefield: add hw_reset() support
Thread-Index: AQHavO/vJ0/ETMv+yEq95opA6DmRfbHQwJkAgAgry1A=
Date: Tue, 25 Jun 2024 19:13:43 +0000
Message-ID:
 <BN9PR12MB506861D155E2BFC6B8B61252D3D52@BN9PR12MB5068.namprd12.prod.outlook.com>
References: <cover.1718213918.git.limings@nvidia.com>
 <2c459196c6867e325f9386ec0559efea464cfdd6.1718213918.git.limings@nvidia.com>
 <CAPDyKFqXZ3JdQBMpTM1ccAFqUSsqUcZ2fn+Ste2aG-APS2dt2w@mail.gmail.com>
In-Reply-To:
 <CAPDyKFqXZ3JdQBMpTM1ccAFqUSsqUcZ2fn+Ste2aG-APS2dt2w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5068:EE_|MW6PR12MB7070:EE_
x-ms-office365-filtering-correlation-id: 4e44f67a-facd-4b1e-432b-08dc954aee4f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230038|366014|376012|1800799022|38070700016;
x-microsoft-antispam-message-info:
 =?utf-8?B?eE9KdjBMbHNGSWZ0MFo0VWtiMFI2am54dVRQNTVZajNkaE1qZXFLNkoxZlMx?=
 =?utf-8?B?bTlXS2dQMVUwbHNCS3pCT0N5Q09DSlR2b0hmWldsS2xWQkxFK1VRR1FoL2lZ?=
 =?utf-8?B?SWlWOUI3MVVpTHZyVXNHZHgxazd3WDd2Z1NvR2xZZ3ZjTk1OR1h1WXgyMW9W?=
 =?utf-8?B?MU8wakUrZTBXZUFicDY1ZVVrK3p4TXB2MVdJVG0yQ0pRZmtCRHlHUDRlNFVz?=
 =?utf-8?B?WEFWYTIrSlB2QndRVlZLQjNnQ2laYlhXMjZaS1JEK0hpK3JwM3RBVFQ5SlZN?=
 =?utf-8?B?ekZFcVplR2o4SGgvZ1FSa29vUVRubGIrdGJ2TjdNYTdWb28wZ1hzdXN0U1dU?=
 =?utf-8?B?ME5BWTBQVVY4b2hLemQwNkIxc1FMYjRXMmNTQ25lT2RsS2gzemVrVmJVVDZw?=
 =?utf-8?B?Wk4yWWxIaFNJYUNFWUZzVVBDTlBYdmg1bmJnU0JrTlZ3d1dHelpJcWx4dmxR?=
 =?utf-8?B?Tnc5QStMN2JsNGQwemRwcG43WnZ4RWVtUFk4VnJZUUFGdUZINFdJSG1aaWdl?=
 =?utf-8?B?UjllS3ZBQUJmdWlMaHdkckoyRkN5cGVPcVFNWGxSL3lyMmdMZHVWUWErOGJF?=
 =?utf-8?B?T25ucHIyVFM1QnF6eGcvdVFhbStzMnVSOWpzWXdEcHBNQzY0RUFQeXltd1ps?=
 =?utf-8?B?MmdSWGx6SzQrcXN1bHVjWGl1eTBKMEJnWWlZcGovcU8ramdHaENSVGRqeExM?=
 =?utf-8?B?cVdjSE14OTVkNWtRRHVnY3R6VWFkcEhINkdtdEl2MTJPdHArMktTU1laRkVt?=
 =?utf-8?B?T1pVa3VGeDcrSE9TYTdsMXRjd3hUcTdOTEhKdUtQRUlqV2lZaUd3ejdOTzFt?=
 =?utf-8?B?VTFSd1Y4NVI5T0pUMitzZ1Q5emNpVDdaY2MvT1pPTXRscTZoMlZ2NGpMWm5B?=
 =?utf-8?B?ZFYwSUxHaEN2OFJmMzZrS1QyTm5sMytBRVNMYks4Qk1DaC8yaTdkamhuOVJS?=
 =?utf-8?B?c2RXMmR4Qm01ZHNGWWY4Uk00VU9rWklCQ0t1WHJzVDNFTkt2ZmpoWjhnbGNW?=
 =?utf-8?B?RktBZ3VGYW44RU9mZ3RuR2d5Y0s3SnIzSXhxbjh4T0kvdFpKQjdkVGM3ZEpn?=
 =?utf-8?B?UFF1dy81OUJBSmEydlMrSHZEVTdialdlRWY0R1dPa291dHQrR1FDMFRqLzVp?=
 =?utf-8?B?eGkyZHFkMGZvQktzRDlyQ1gvWWNMNExJUDYxZWFGeHlEbFcxSkEvbkxDUUxy?=
 =?utf-8?B?QjIxR1EzM0RMaGJ3L2FGUXFDd0VKMEVvMHI3SjVmcEtWd2RsZTJJcTRVYmds?=
 =?utf-8?B?NDBDNVdGcHZ0TVZ1Rmt6N0t2T0VlTjVUZk1OTW1zaGNaTDFWUWdnNWpZSExN?=
 =?utf-8?B?M3JnYXhtMGZRUUlXYTlkRHU3NENvL0J0TlVCUEZwRjkwMEhVSFBpQlY5MlVt?=
 =?utf-8?B?OFFGRVVxdW5oNTBxOHBQV3ozejlCRU5CaGltdE5Ha05ZVnc0eDgxUGp6UW10?=
 =?utf-8?B?ank4YmtOVWxBMnAyd3liZXlkcjYyL3RkMGp0aTJwZlZobmtzMmxNNmttcnhK?=
 =?utf-8?B?MERvU0I2OGl6SjhsMktqSkFzbTF0S3liZUV0Zzk1cmQzK2QzbnREdjQrazlk?=
 =?utf-8?B?SU1PK1V2K3ptVmtBMTZnYnhBZ0htUXpoQ05kNGswWWdnOHFlMVB6OFFlMlp3?=
 =?utf-8?B?RkV1RTRFbGkxSjVwWWlYVjRTcDlFRlVSNTFHUFRGcFJSbTNydUxkRTZzbmp5?=
 =?utf-8?B?QkxpT1p3cHN4QzBpNW9PYnJBVGZRR0N4Z1N0OEgzK3N2S3puZzlQdVRBZnJ1?=
 =?utf-8?B?Qit5MnhOMmxsbzVnb1NwNkxaRjg0NzErQ3FsSlZLRnJwZGFJNDE3TngzYU82?=
 =?utf-8?B?MDIwZGxEVlN4cmVyUmpIcG5mbFBMdy9jSy9VWWkzb21VVHk5QnVtb0duY09N?=
 =?utf-8?B?cmlCL2FBSU9PUmNVUjZOY0xyQnQ4cXdJRnRFT1VpVjJlNHc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5068.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(376012)(1800799022)(38070700016);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dmhZcURrTmxIdUtHTG16bDRTWTB5UGQ4Y2h4RXR4b2tWa2ZtcURJekNLZDR6?=
 =?utf-8?B?MWxXODkyRFBGK3hqR3hzcXlrV0pYWnk4YUdkMi90M2lKOTR6dHp1VzV2K1Vh?=
 =?utf-8?B?ZXNWN0kwc3BiWlgxakR2ajlSeGxETUZrcCs4OFF6aVJMRHArTTVDT1NFM3lW?=
 =?utf-8?B?dGxkMmNFaitVVXd6dWdTK1JXRGNSUGhUMmtIVWpCNWlibDkwZnQxb3owRkIy?=
 =?utf-8?B?c2traUtjZHJyNW1TVUszUURQblVIemg5QktybWdvUm9ORDZQcTJnY1JJR1Fw?=
 =?utf-8?B?eG5haWNwWmhkV1JoQlIrOFRBSUNyVHJDc1A2U21kL0h6bEczQW4wVGNOeEcz?=
 =?utf-8?B?bVRaRVFpN05WS0FnMGt4SEFqSzNNRHpsOFJ1b1BtTksyTkp1TVRiS1FMNlRY?=
 =?utf-8?B?QlVicjcxNnBReUFhUExKRzc2NGtBVFM0U0dvVnNRcG1HeTNleVFXcGNOdnRE?=
 =?utf-8?B?YnhEaVdPNHNnWmtCL1JQMk1ueXFKOUFycDZuY0RSQ3QyR085VFVVR0c3Kzd6?=
 =?utf-8?B?aHhyZFQ1TVdKYVJlMmM0NVhtUFR4V2NMaktkV1gxZGVCUnJkZWZiNW9Na0Jh?=
 =?utf-8?B?T2tvQVFudld0S2xrZHVpSUFuelRiZ3dNaEY1QkpjaEg4bGIyQkY3OVBRbjdk?=
 =?utf-8?B?cjFEUlJYTld0OEVoM1ArWnd5SXREVElTbEhKRFlmK0lTNlNBRkxQQ0hqcFIz?=
 =?utf-8?B?bWtGdUp2elJSRlllZUZDc3BSR2Z1MjBSVG5BRmQ2K3Vpa2pHMk1OM3NSVXVr?=
 =?utf-8?B?NFo1V2lYNmhGVEg0YWphSktBc1hDTU5JajF1c2lqWkpVWmtMSldnaHkwRkFH?=
 =?utf-8?B?aWtGaWREaWhhUExYUFpxRm8wdDduTysxdDFnME1XM1Npd0RFcWRQc0xXRTUy?=
 =?utf-8?B?SHhNNnh2K0JYMXdRNWZMWVpUMjJlT2wzZjRGQXcxVGZkVmMyZG8vZlFNODUz?=
 =?utf-8?B?V0h2Z0NXQUpvWGV5bEQ4WTJvdE9GYjRORXVLa245Tm1NYzl5MVNwdTQxRmRN?=
 =?utf-8?B?aVFVSW1yd0JFRVJIL3pzWTR0L0hlZnhYUnY2VnBxQktTckxRSjhwTGFtRk53?=
 =?utf-8?B?OGJOcjVpRUNKODZ5ZzY4Z2pTQzNSTEdWQWJIVzlnWHVFQWRXTkpTRDRKNWIy?=
 =?utf-8?B?K1RXUTlhRGFKeUo1NjhjRjN3Vkx1RGpELytEb2dMVmF6T3ROUTI2elo5RHdH?=
 =?utf-8?B?RUxqZXB0ZG9RM3NoTklyMHdtYThjcVpqZU5iVmx5TktPK3p2VWZwb2JNWi8y?=
 =?utf-8?B?U0pIa3NCTHVOL3RvalZtNkpNU3Rtd1dZSUY2OGFHbkFYQ3dob2JUY2cxMy8y?=
 =?utf-8?B?K1JpK3ZMd0xmMlJTbS9TMGhLWTFhdlpIUGVseHdEWDhTN2F3VVN3N1dIOGxQ?=
 =?utf-8?B?UUVLdG5VWDJpMFZmS3hhVmRsbXdubWY0WGU1U2NvVUs0eW5FVXJpMlEwSmw2?=
 =?utf-8?B?Vm9EWXRqT0tudk5wWTN1aGo0cmYrSWdXdGVVM0pnK1dsc1pDVW5CODVNbVpG?=
 =?utf-8?B?aDdCRWcramtUaGxSNWIzUWZuUmtsRGxGcnF5OUtpa0o2eFVONnNlRS91Vjhp?=
 =?utf-8?B?bU01eTg5MC9qQy93c3N1eDdsSWlxeW8vWmJESE9YRFloVkhGdS9lbG5UVmZp?=
 =?utf-8?B?aTkrZUNyZ1BJMjhPSUpXbndWeXZ4d3ZzTDI1QzdZVy84NTAyN0NZSGo1ZWxK?=
 =?utf-8?B?N09RS3lJbEsrcDdsSXhyQU0vL1ZjZ3ZyYU5Zamk1MWlZMENITnlkOGgzcjF2?=
 =?utf-8?B?alFuQW9NUEk2NDEzdmRGNjk1WDMxMURJaFBSRW9NWHhjd2dKMDhaV1ZuWXFL?=
 =?utf-8?B?VFF4MnhKR0J4RmpHS1JzdVhXM3VCNEZ5Y1hTdFdYMFI1U245WmJMdm9OTmNI?=
 =?utf-8?B?eTJ5VzdtMTBaN05JcnkrVTRGamJReUdVTjhEbmRkZmdBaDNBcmtiZXQzanlN?=
 =?utf-8?B?OFVtcW1Rbjl4czJWVXFCdmliQWNyWE5kL2U0L0pDODFFdVlNNUV2ckd3WEVG?=
 =?utf-8?B?clM2TWJNOGhtQUhqcndLZmovUFhkR0N4VDBCU2psRy9EZnZqcXVNZngzVW1Q?=
 =?utf-8?B?TmxvamtKdTdCTEYxajhrK2VSRXltQklmd1JYbE9JcUNSV2tYRTNGdXRxeE9a?=
 =?utf-8?Q?q01M=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e44f67a-facd-4b1e-432b-08dc954aee4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2024 19:13:43.7979
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ptg2GCVchIhiamj01ht0YSqcfCwc5XTmLRvuiQE4lj2OvgsZmU5PVYqy93RJB9c4Z3MMFzxcOFh0wuMEWCl8sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7070

VGhhbmtzLCBVZmZlLiBQbGVhc2Ugc2VlIHNvbWUgY29tbWVudHMvcXVlc3Rpb25zIGJlbG93Lg0K
DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFVsZiBIYW5zc29uIDx1bGYu
aGFuc3NvbkBsaW5hcm8ub3JnPg0KPiBTZW50OiBUaHVyc2RheSwgSnVuZSAyMCwgMjAyNCAxMDoy
MiBBTQ0KPiBUbzogTGltaW5nIFN1biA8bGltaW5nc0BudmlkaWEuY29tPg0KPiBDYzogQWRyaWFu
IEh1bnRlciA8YWRyaWFuLmh1bnRlckBpbnRlbC5jb20+OyBEYXZpZCBUaG9tcHNvbg0KPiA8ZGF2
dGhvbXBzb25AbnZpZGlhLmNvbT47IGxpbnV4LW1tY0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0K
PiBrZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMi8yXSBk
d19tbWMtYmx1ZWZpZWxkOiBhZGQgaHdfcmVzZXQoKSBzdXBwb3J0DQo+IA0KPiBPbiBUaHUsIDEz
IEp1biAyMDI0IGF0IDAwOjUzLCBMaW1pbmcgU3VuIDxsaW1pbmdzQG52aWRpYS5jb20+IHdyb3Rl
Og0KPiA+DQo+ID4gVGhlIGVNTUMgUlNUX04gcmVnaXN0ZXIgaXMgaW1wbGVtZW50ZWQgYXMgc2Vj
dXJlIHJlZ2lzdGVyIG9uDQo+ID4gQmx1ZUZpZWxkIFNvQyBhbmQgY29udHJvbGxlZCBieSBBVEYu
IFRoaXMgY29tbWl0IHNlbmRzIFNNQyBjYWxsDQo+ID4gdG8gQVRGIGZvciB0aGUgZU1NQyBIVyBy
ZXNldC4NCj4gDQo+IEp1c3QgdG8gbWFrZSBzdXJlIEkgZ2V0IHRoaXMgY29ycmVjdGx5LiBBc3Nl
cnRpbmcgdGhlIGVNTUMgcmVzZXQgbGluZQ0KPiBpcyBtYW5hZ2VkIHRocm91Z2ggYSBzZWN1cmUg
cmVnaXN0ZXI/IE9yIGlzIHRoaXMgYWJvdXQgcmVzZXR0aW5nIHRoZQ0KPiBlTU1DIGNvbnRyb2xs
ZXI/DQoNClllcywgYXNzZXJ0aW5nIHRoZSBlTU1DIHJlc2V0IGxpbmUgKFJTVF9OKSBpcyBtYW5h
Z2VkIHRocm91Z2ggYSBzZWN1cmUgcmVnaXN0ZXIuDQpJdCdzIHRoZSBzYW1lIHJlZ2lzdGVyIGJ1
dCBpbXBsZW1lbnRlZCBhcyBzZWN1cmUgYW5kIGNhbiBvbmx5IGJlIHdyaXR0ZW4gaW4gQVRGLg0K
DQo+IA0KPiBObyBtYXR0ZXIgd2hhdCwgaXQgbG9va3MgdG8gbWUgdGhhdCBpdCBzaG91bGQgYmUg
aW1wbGVtZW50ZWQgYXMgYQ0KPiByZXNldCBwcm92aWRlci4NCg0KRG8geW91IG1lYW4gdGhhdCAn
IGh3X3Jlc2V0KCknIHNob3VsZCBpbXBsZW1lbnQgdGhlIHdob2xlIGZ1bmN0aW9uIGluc3RlYWQg
b2YganVzdCB0aGUgdG9nZ2xpbmcgdGhlIFJTVF9OPw0KDQo+IA0KPiBLaW5kIHJlZ2FyZHMNCj4g
VWZmZQ0KPiANCj4gPg0KPiA+IFJldmlld2VkLWJ5OiBEYXZpZCBUaG9tcHNvbiA8ZGF2dGhvbXBz
b25AbnZpZGlhLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBMaW1pbmcgU3VuIDxsaW1pbmdzQG52
aWRpYS5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvbW1jL2hvc3QvZHdfbW1jLWJsdWVmaWVs
ZC5jIHwgMTggKysrKysrKysrKysrKysrKystDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxNyBpbnNl
cnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9t
bWMvaG9zdC9kd19tbWMtYmx1ZWZpZWxkLmMNCj4gYi9kcml2ZXJzL21tYy9ob3N0L2R3X21tYy1i
bHVlZmllbGQuYw0KPiA+IGluZGV4IDQ3NDdlNTY5OGY0OC4uMjRlMGI2MDRiNDA1IDEwMDY0NA0K
PiA+IC0tLSBhL2RyaXZlcnMvbW1jL2hvc3QvZHdfbW1jLWJsdWVmaWVsZC5jDQo+ID4gKysrIGIv
ZHJpdmVycy9tbWMvaG9zdC9kd19tbWMtYmx1ZWZpZWxkLmMNCj4gPiBAQCAtMyw2ICszLDcgQEAN
Cj4gPiAgICogQ29weXJpZ2h0IChDKSAyMDE4IE1lbGxhbm94IFRlY2hub2xvZ2llcy4NCj4gPiAg
ICovDQo+ID4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L2FybS1zbWNjYy5oPg0KPiA+ICAjaW5jbHVk
ZSA8bGludXgvYml0ZmllbGQuaD4NCj4gPiAgI2luY2x1ZGUgPGxpbnV4L2JpdG9wcy5oPg0KPiA+
ICAjaW5jbHVkZSA8bGludXgvbW1jL2hvc3QuaD4NCj4gPiBAQCAtMjAsNiArMjEsOSBAQA0KPiA+
ICAjZGVmaW5lIEJMVUVGSUVMRF9VSFNfUkVHX0VYVF9TQU1QTEUgICAyDQo+ID4gICNkZWZpbmUg
QkxVRUZJRUxEX1VIU19SRUdfRVhUX0RSSVZFICAgIDQNCj4gPg0KPiA+ICsvKiBTTUMgY2FsbCBm
b3IgUlNUX04gKi8NCj4gPiArI2RlZmluZSBCTFVFRklFTERfU01DX1NFVF9FTU1DX1JTVF9OICAg
MHg4MjAwMDAwNw0KPiA+ICsNCj4gPiAgc3RhdGljIHZvaWQgZHdfbWNpX2JsdWVmaWVsZF9zZXRf
aW9zKHN0cnVjdCBkd19tY2kgKmhvc3QsIHN0cnVjdCBtbWNfaW9zDQo+ICppb3MpDQo+ID4gIHsN
Cj4gPiAgICAgICAgIHUzMiByZWc7DQo+ID4gQEAgLTM0LDggKzM4LDIwIEBAIHN0YXRpYyB2b2lk
IGR3X21jaV9ibHVlZmllbGRfc2V0X2lvcyhzdHJ1Y3QgZHdfbWNpDQo+ICpob3N0LCBzdHJ1Y3Qg
bW1jX2lvcyAqaW9zKQ0KPiA+ICAgICAgICAgbWNpX3dyaXRlbChob3N0LCBVSFNfUkVHX0VYVCwg
cmVnKTsNCj4gPiAgfQ0KPiA+DQo+ID4gK3N0YXRpYyB2b2lkIGR3X21jaV9ibHVlZmllbGRfaHdf
cmVzZXQoc3RydWN0IGR3X21jaSAqaG9zdCkNCj4gPiArew0KPiA+ICsgICAgICAgICAgICAgICBz
dHJ1Y3QgYXJtX3NtY2NjX3JlcyByZXMgPSB7IDAgfTsNCj4gPiArDQo+ID4gKyAgICAgICAgICAg
ICAgIGFybV9zbWNjY19zbWMoQkxVRUZJRUxEX1NNQ19TRVRfRU1NQ19SU1RfTiwgMCwgMCwgMCwg
MCwgMCwNCj4gMCwgMCwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmcmVzKTsN
Cj4gPiArDQo+ID4gKyAgICAgICAgICAgICAgIGlmIChyZXMuYTApDQo+ID4gKyAgICAgICAgICAg
ICAgICAgICAgICAgcHJfZXJyKCJSU1RfTiBmYWlsZWQuXG4iKTsNCj4gPiArfQ0KPiA+ICsNCj4g
PiAgc3RhdGljIGNvbnN0IHN0cnVjdCBkd19tY2lfZHJ2X2RhdGEgYmx1ZWZpZWxkX2Rydl9kYXRh
ID0gew0KPiA+IC0gICAgICAgLnNldF9pb3MgICAgICAgICAgICAgICAgPSBkd19tY2lfYmx1ZWZp
ZWxkX3NldF9pb3MNCj4gPiArICAgICAgIC5zZXRfaW9zICAgICAgICAgICAgICAgID0gZHdfbWNp
X2JsdWVmaWVsZF9zZXRfaW9zLA0KPiA+ICsgICAgICAgLmh3X3Jlc2V0ICAgICAgICAgICAgICAg
PSBkd19tY2lfYmx1ZWZpZWxkX2h3X3Jlc2V0DQo+ID4gIH07DQo+ID4NCj4gPiAgc3RhdGljIGNv
bnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgZHdfbWNpX2JsdWVmaWVsZF9tYXRjaFtdID0gew0KPiA+
IC0tDQo+ID4gMi4zMC4xDQo+ID4NCg==
