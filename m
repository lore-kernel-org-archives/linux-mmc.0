Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=216.71.152.95
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794206079;
	b=UH+0DxNm08K8qKZ7pbfGQFkYtwksxkeU7nRliAnIqdj72nEvjZ4bhc7wkYEZ3FynceK3
	 sROzAFyQDcOHYRcxFfqcL8dmcOsI9wcUi/416/+Uo+dDw5WCwSeEkSlh6b0dq5qhqyUUL
	 am6Xn7Ij8YTLmdVJoVbje7zYuuB9uELkcktgn6+2L0GSgLUzsypmiFjWTETiB9eVtO6V/
	 PIJ18f5WhAV7ryzQkLiIvMa2BULhtbOufKW+BOe7sROWUW+nKJl/IplgP6mKGO+VlvTqt
	 SwuN8Vp6AbOkM7OhxpS9r5lbtTtOjL/DXVMoD2eBojQ3rAjbf/CCR+EfmGMLUbGubqA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794206079;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-RemoteIP:X-IronPort-MID:X-IronPort-Reputation:
	 X-IronPort-Listener:X-IronPort-SenderGroup:X-IronPort-MailFlowPolicy:
	 Received:Received:Received:From:To:Subject:Thread-Topic:Thread-Index:
	 Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:msip_labels:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-atpmessageproperties:sndkipoutbound:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=QLEqVpgAmq7GA1W38d2XGBmQyZYehntdG58HG1ngcrY=;
	b=CHomIYZcIwblOf4o0eXSvndUIAisxsf80JyN8xezQ17pC3F9kjApgq3TGRv3UVCILIw4
	 UMRvNdChghUrp+EnvRaXPzIz3+4R9lwcQtkPcVIw6kU/vEkVDHxKp/8V4PYdmD2eEIbFY
	 cqZVv0w8MJLIxgyIXuwjCWR7rTAoNXgKmFeQeeJsFr+xHlFmT0QvEITEGQeGHdoghtN/1
	 ctlDUw2M4VWpPlXdQbEBFF61AkLzxfd88RJuJh2P77qO3QBGv1IHGouolYD5oCehGw4Br
	 cRJ/Dwc0EIbN9LMpdldCdHnYJvCCCSKEgiqgrI2VtIg6KXwMASrkViyGKD4bm2UIl0Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sandisk.com;
	spf=pass smtp.mailfrom=sandisk.com;
	dkim=pass header.d=sandisk.com header.i=@sandisk.com header.a=rsa-sha256 header.s=dkimnew.sandisk.com header.b="Tif/S/VJ";
	arc=pass header.oldest-pass=0 smtp.remote-ip=216.71.152.95
Received: from esa.hc6817-7.iphmx.com (esa.hc6817-7.iphmx.com [216.71.152.95])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 835FE606A31C
	for <linux-mmc@vger.kernel.org>; Mon,  9 Nov 2026 06:34:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 835FE606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sandisk.com header.i=@sandisk.com header.a=rsa-sha256 header.s=dkimnew.sandisk.com header.b=Tif/S/VJ
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkimnew.sandisk.com; t=1794206078; x=1825742078;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=QLEqVpgAmq7GA1W38d2XGBmQyZYehntdG58HG1ngcrY=;
  b=Tif/S/VJdKuTmu2QBAFxYDx1myOa4w3+XXNGtzmF+zzKdofI4jfL8Z9a
   iKaTo1g9/oNlvDH4Qrd4xESTqtc40JB9qdn0UaZzkmMfnfSuGr2OYlSIS
   uAwvSUyj99q9fmW12NXEltTg9iWE3e5qaORodis+6Rt19gZut9bDCFbPN
   06Al+5daIDMbAMs3z4ek0+dcUQ+DTeLcjHifkY40WOU9Grs4BISgaJpZX
   hvJESoIGcTktipxRYl1awbBv62zORrcyly7WBD7yz4YRDeNJQgvOtnqfA
   TMNokc3/kt6v9myx18xnM6XARUfijqHMP1Yg/yGXhWpa2iIWVcwwyiutm
   g==;
X-CSE-ConnectionGUID: kvybuKlOTn2zjQzzRz3EAA==
X-CSE-MsgGUID: 1+ec996CQJy3fdjGgwjAyw==
X-IronPort-RemoteIP: 40.93.194.106
X-IronPort-MID: 33820486
X-IronPort-Reputation: None
X-IronPort-Listener: OutgoingMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
Received: from mail-southcentralusazon11021106.outbound.protection.outlook.com (HELO SN4PR0501CU005.outbound.protection.outlook.com) ([40.93.194.106])
  by ob1.hc6817-7.iphmx.com with ESMTP; 08 Nov 2026 22:34:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sq6Qo8YfxhNGZmOaTpxd8NgBewJDIJWDERDcikb2p1VD6a3J+V1eyq54b9O/qnJCFuNxhY2s+FSq+Pu3Pij1XwT6NCjRnJu9U0lUdnJF6G3U6XFgOkTW1Ja0RGUQG2E5ZSevOWUgYHjIlKICxvD8dHDKFev5cK0TdyfNCuNOGpKuaZEpuDmy8TawOLCyeBmiQsr3bQwJlQ34Y1Q5sQmbe55KO06EBY6S+h3ZL8SGkSoMPTgp6RbXRKs2xzg4D6zTI2NJt8DUtqcoOBGDo5IjckQ8YZTnvpppyH3beqLqiPcB/nkg9EK3aiD9UZg7938HF8qYXuyWMEpszXzdvEQa8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QLEqVpgAmq7GA1W38d2XGBmQyZYehntdG58HG1ngcrY=;
 b=r2f9M7mgwXHUePyWIX8dqirrNkvNuydiGrHUgXD3U/aV8azYNfjGNB7aSFk1Xja+LvRkyq9BBh+tpLlCBXN5vbFETQ4IfQRqh13/Dh7ZvKxBFtr8gBUiueJficG8KlIvSwC1HSP6EEd7FZZvyiFggXKx+E1U7tIanqVbHh8QW8JVrOgHYcHeo3tkQshissamJ5dwTBdETjoGFjWJvuPYkJARB9/FIzeKk85vl8i/TRq3pwWc3s2693GHjC9CP0ATFTbPlO6gbOgXUv0ToyJ9YUbyk3Oi7GveoSqDWGr6+0x4UIAsGii++QAfseQZOwJpEWiyFMNNdlsGUPiOSfzE6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sandisk.com; dmarc=pass action=none header.from=sandisk.com;
 dkim=pass header.d=sandisk.com; arc=none
Received: from IA4PR16MB520939.namprd16.prod.outlook.com
 (2603:10b6:207:144::15) by CH3PR16MB6114.namprd16.prod.outlook.com
 (2603:10b6:610:1b4::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 06:34:30 +0000
Received: from IA4PR16MB520939.namprd16.prod.outlook.com
 ([fe80::5b79:943f:ee09:cc1c]) by IA4PR16MB520939.namprd16.prod.outlook.com
 ([fe80::5b79:943f:ee09:cc1c%5]) with mapi id 15.21.0592.012; Mon, 9 Nov 2026
 06:34:29 +0000
From: Avri Altman <Avri.Altman@sandisk.com>
To: Chris Liu <Chris_Liu@kingston.com.tw>, Ulf Hansson <ulfh@kernel.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: RE: [BUG / RFC mmc-utils] incorrect GP partition config
Thread-Topic: [BUG / RFC mmc-utils] incorrect GP partition config
Thread-Index: AQHdbNP8zy/awUOkjEioDZndvS+b0rce906JgAZTByA=
Date: Mon, 9 Nov 2026 06:34:29 +0000
Message-ID:
 <IA4PR16MB5209397C311B9704BE2D5884E4E5732@IA4PR16MB520939.namprd16.prod.outlook.com>
References:
 <SJ0PR10MB47994BA641B2C58D8B75173DD9772@SJ0PR10MB4799.namprd10.prod.outlook.com>
 <SA2PR10MB47947BB371D92546E8BF3F10D9772@SA2PR10MB4794.namprd10.prod.outlook.com>
In-Reply-To:
 <SA2PR10MB47947BB371D92546E8BF3F10D9772@SA2PR10MB4794.namprd10.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 =?utf-8?B?TVNJUF9MYWJlbF9iNGEzY2RkNy0wNmQ1LTQxMDUtOTYxOC1lMzI1OGZkNjIy?=
 =?utf-8?B?YjBfQ29udGVudEJpdHM9MTtNU0lQX0xhYmVsX2I0YTNjZGQ3LTA2ZDUtNDEw?=
 =?utf-8?B?NS05NjE4LWUzMjU4ZmQ2MjJiMF9FbmFibGVkPXRydWU7TVNJUF9MYWJlbF9i?=
 =?utf-8?B?NGEzY2RkNy0wNmQ1LTQxMDUtOTYxOC1lMzI1OGZkNjIyYjBfTWV0aG9kPVN0?=
 =?utf-8?B?YW5kYXJkO01TSVBfTGFiZWxfYjRhM2NkZDctMDZkNS00MTA1LTk2MTgtZTMy?=
 =?utf-8?B?NThmZDYyMmIwX05hbWU96YeR5aOr6aCT5YWn6YOoO01TSVBfTGFiZWxfYjRh?=
 =?utf-8?B?M2NkZDctMDZkNS00MTA1LTk2MTgtZTMyNThmZDYyMmIwX1NldERhdGU9MjAy?=
 =?utf-8?B?Ni0xMS0wNVQwNTo0MzozNC40NTVaO01TSVBfTGFiZWxfYjRhM2NkZDctMDZk?=
 =?utf-8?B?NS00MTA1LTk2MTgtZTMyNThmZDYyMmIwX1NpdGVJZD1mNDNhMmQ4OS1iY2Q1?=
 =?utf-8?Q?-425f-981c-f7231bcd4467;?=
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sandisk.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA4PR16MB520939:EE_|CH3PR16MB6114:EE_
x-ms-office365-filtering-correlation-id: cedf4519-d319-46e2-c542-08df3e2b8218
x-ms-exchange-atpmessageproperties: SA
sndkipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|38070700021|11063799006|5023799004|4143699003|56012099006|261021121427099003|261022075727099003|261022105027099003|261009223027099003|261026140227099003|261026121527099003|261028144727099003|261102123227099003|10067099003|55112099003|18002099003|22082099003|6133799003|3023799007;
x-microsoft-antispam-message-info:
 QMkcqD5J/bgHupWB8jVs/a8dsQM/cEVoxDZsSm7cyBh458qlcP6GN2FlXtyyLtpOMW7oQxDzUrEpGctTwlcLye8BZenlOYipBCAS63AIGHHwqsHImU2EXqUIXp3EXnojddQO1PxZ6myctSGKcm2qwu6XiCJ39yvJmkxWs6/cClzrkA4056KTPE5LtWvL+kbU4T7VleVSGeKhWgeH4YnjbgMfI81L1o5RqJ5Wb2CWVUPrg/fWdIcFHb3jQc0jRuLyGOZSHknjolyVXE+bJy5Uc7qEH+P7w8243e9IOmssZ1OEcj9hfgxvfQBW5T+l39dFR2AaDhL3IArtxRWLIvVmohiJI9GgM+HS/A5VDxNOnVJq/BO9gTsz9V/bbhD6m95aMcgRa3NtIKuOXAKwQO3gmp3NiRls774l9uv1D3eNvlKX1g4LrtCf2qMvwibESzWeVSzQpIVLNZuI30gzLyiOKyBPcNet92242i3oIFq4xu8CyZmVXXLvayA2WucJF9uV0qsKrhorjFeWcw+j5oTHn7TzH/vnHndoI9ucxnm2acKpZF+bJnH6/DcarWA5jCbEHFWCOjGJQZAAOIcpc28DAbSIqzYFv9h0GV2ZTqQTQ5MvEFcMLumpinqsg6eMLd6AAUJjKOWtRjU7X6bPK2o6uW2dEGqBAilpl1qiqt6dzsa60yLjtjhV8YYqcIVVzaDOE+fdPaV1Z93kQQFbBWCTatvP/dLER3PesOr+l0pwnWo=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR16MB520939.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(38070700021)(11063799006)(5023799004)(4143699003)(56012099006)(261021121427099003)(261022075727099003)(261022105027099003)(261009223027099003)(261026140227099003)(261026121527099003)(261028144727099003)(261102123227099003)(10067099003)(55112099003)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bXNDaXRsTkFoTnNGS0pFM2RFODA0YzR0aGpxSWpCWUVOYmNMWW9CalNJMHdS?=
 =?utf-8?B?VFNORmVQS3RTRG9WTnlMa1BjNFE1UVZCczFIeFpVMzgweHlIQVovTldXNi9q?=
 =?utf-8?B?M2FROXdPS1NPZ0xkNzNWMkdMMVZWRm9vMk5kWjZEYlNaSzh0bndvOXAvWjdM?=
 =?utf-8?B?N1VZUCtYSVo1aEZYQnNJZE1ubTBWVGNLdjlIMGNoWVo4R3N4bzFGeDdaL1dj?=
 =?utf-8?B?SU9Yd0NtVzN1WEpodUlTVjBLMU96K1QrSTFkTzZQQUNmb2dGZWsyNDV6cmtD?=
 =?utf-8?B?SGVyQUFtRzVRY3MycHEra0Nzb2ZCN2Z3cTdpZEtSTkRPVHhxN0QrcWhETE1n?=
 =?utf-8?B?MjFhVlg4ZmdTNjZqU3I1RmxLQ2xvcXlBRk1SdmREWEE3eXBYcmY0NmthMFVP?=
 =?utf-8?B?WUVFUUFCRWs2cGZoMmJwTXQrdG9CMkU5OU1hREhXME4rbytsVGJ1K205bklx?=
 =?utf-8?B?SzRTdU5LTlJUbStFZ1pKTm9vY3FtOEdabFpRbFRxUTVpT25paHRienNWcDlh?=
 =?utf-8?B?U2JsZVlhRldQczMwbVF0Ukl2eHpEOG5Ed0NFdDBycVdIbVQzMkhSM1k1OXI1?=
 =?utf-8?B?VUJsMVI2K1VKdCtNUURoMHRCQzhaYVlWWUZHWGxTVGtjOHloTnZEZ0M5UFp0?=
 =?utf-8?B?TkM5Zzd2cDBGZnpBdytPR3hXY1JRYXEyWkRwR2FPM3k1OEtyZ0M4Unp1a0RO?=
 =?utf-8?B?Tnd5dUZLdlhmeElvYWtFNEozTlI4YjlqVEtQd29vc3dLcmhMdVpBMHV3Nk1J?=
 =?utf-8?B?UTdZbGxWVlZqN1h6U2RGVUtQNVdsNm1vNzlzN1JLeDhnZERrRVdpbUpjMGVS?=
 =?utf-8?B?RStrU3VrNUFsQlpFNC9ZSXNnMEJMckd2WE4vMzQ1WEFVU0IvZHJKUTRzOVF1?=
 =?utf-8?B?dHByU3BCcEtjZHBKcFYyaTI0SDUrajczMFJsaTNHS3E0S2dnNHdGSWVwMSs2?=
 =?utf-8?B?a1pHLzF1NFFudXp1cE84b29oVXVENW1yczFXSmVzd3VwMUViK2daK28wT3V1?=
 =?utf-8?B?czJnZWNjV2lYZ25PalNEK3JubTMxVDFjMjFqMDJGMXMwUmhKemprTkMxTXZY?=
 =?utf-8?B?YXBQWDNLRE9xMXZERWhtZjhLcmt4a0k1endPaEE3SUNaRjhFN2wxZEhtd2cz?=
 =?utf-8?B?ZnI3Q0g3ZXpWOU9JSmJ2a01hUlo5dWtOL3FDV004andXMWxBVm9xNU1QSmZ3?=
 =?utf-8?B?QVM1WFh6MFgyNUdkOXpJb1JjcjJCQlpRTDZkWmxuQzdxSDJsSTF4UU50M0pO?=
 =?utf-8?B?Y25wS2E1dkhRZmZtNEpheXdsT3doWjkreGRjaG1pWXMxS2VkMVUwRnQ3SHI0?=
 =?utf-8?B?d3dIMHVXb3JJOUUxL1VqOVZYRDJLbUxzdG11WXFsNE1Wa255VU83TFNNOFR4?=
 =?utf-8?B?QVNRZnp6Q016d0JaMm5HSWhTWFF2RGNxdEJMMFhISEt1MVlzeGdkSjlINnNn?=
 =?utf-8?B?S3FZaVpjNDZkc1hRbkFVMXVrTnNteVNSNnBHY1lXK2JUVlp1a2hMSVpSTVk5?=
 =?utf-8?B?REtVWTRjYzQ3VThucHV6d1RwV0duVnYySDFEQjlTanlrNTByTmNXRi9wTFFt?=
 =?utf-8?B?Z0x0OVN1NGEzdHF3alBHVnFvU1hPeFhFb2hVL0h5dnNHaEExRElyV1c2YnRj?=
 =?utf-8?B?djNseU9WVGsvNDV3UXl2MXhCTUFjeWhzWS9hWkNmYkc2blk0TTZUU0IxMzZ1?=
 =?utf-8?B?Vlh4RENTT2NTUFB4TmVwTWowNEZ1dUhveFUwQ0h5NXFsRkJYdkxiN2pqOWFj?=
 =?utf-8?B?S0hoQ1ZpUFQ4NEtMc0dGaTAyQVcycy90QU1FNG1HOTVoaG5EVTRUZ2JmKzVt?=
 =?utf-8?B?VklTNU1MYkF5REFGTGxsNm9jWHR6OStrVkhrVFdITFRBdWdjdzEva2tZMHNw?=
 =?utf-8?B?S3ZsdVJUOU5oYXI2OWdJbkNhYjI4aFh0QXVVYTNyQkFPbGVZSnlhbm9ndkZq?=
 =?utf-8?B?K0pDSDFxL2JCNmlQenBHeitldG1qVjhiRjYwQUd3U1pXa3VBbUkvNkJJUXZU?=
 =?utf-8?B?TVVjL3dPVUVpMkdiTjRydCtOMDhHVGg4MGJMaWt6TjdnV1RKcHdsTjF3NjMw?=
 =?utf-8?B?djRuSXRVUlZ1L2ZJWEcza0RkRlNSWTZLVnYyZlRTZCswNkxabkNQaWRmVTVy?=
 =?utf-8?B?d2plcEFRYzBpU3FVY2d1VEQrZEF3TGI4eGhHWTRWVkRXQ2tVSUgvcjlNcnor?=
 =?utf-8?B?OHFTeHJ1anNpYXp3NUtDeUxVQnRJU3lDbXRGNGNHa3BML2JTU3UreS9kaSt2?=
 =?utf-8?B?S0x0TXpub0VXSzdxNk5CdElDUy82RjFUMjc1anVidmRFeTdDV280U2ZWSjNz?=
 =?utf-8?B?SzhmWkt2djloTGVBOEJoZ3JYRHBWTHFUemN6RGRkMFFTbkgzcE5HUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	1tdYWY3LKC+q9LAxr7BliCIbE+5m5BWGULLIbKXmhdOea9Ot2b5sPjKN9KMWijLVNtNv3wTpoC3AooX08u3kbrmt6RgwnH8cYU+3V3JLg+ZBuTr1BLXr5+GCUEJrVMOsDrAi4c96Hm1WxCSNptUKax3r27BqD0nSwa5glQSOr2xIKfuqmzPGbhzeRTzVRihhOxU7AfxnwXjDBL4s7VnpnVjupnsz4v0sD89iHA5t43v5SCdLOWfjdsXSerdY80yf/ScaaW6ZlXuAhXLsNQg4dW3XKbf+9IVExSsYXfHupO/PYbYATXKRIs4ixdwEbqrFOf7icBWNx5iWf2CC/N+laQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4XyCwHXN+s6AlKEEBUPaFIRhbG8uSgG2gxVak3E0JA49pmjV5ujXtEEDXgGsgY3og0RaRcBoHmbH3jp6GI5FHUZTROVOSkrNZbfnIQ3cxvMman+hQ+J8SfE/VaEEI+H5QeudCQZbqDBC6hC/vfMXvDx47RBZRvgN/rWDJCVhWyCkA11eDz9gDtS0xrLNWygBFQVFhsIeEnwraqgRG5dswHjcRrZ9gcFxmhOSJkluN+wU4doFmdI2zreMI3kmBAFxffnA5ClZwGb9u8S0E2vOdhhLk4B+M/ur84V+ZGmjXiXUqPqGtVMpGZx2KVls4lDJ6AyLyIlnG8vW2zsuNfiGTZVMeLCchQ4ucBcflOf22cdbeW6Zp1+b20QZOhqhuuzBertJAhJTA6A/ITlrmuKauUDn+gtmDE7SWnKbyy2Txl0VnAIj7QK9JosGP7M2NWW+B/yTOSBKkgBJSXHm0znwn0uJxB8rq4NUVA2FYzlHbF9uH9IuAmPSOgWnPVGfcIxOfew5kCKZxqGpwE9VhsBr49ivhilzi/gVXiuIhODTU2TU7ra+VDaF+m1Bj02lGj2Z0tBSg6S4MknzKOH00VTTUH5NPKGKW9a8pc6i5II7pbNzL9z6eQmy+zwlBc2cnxGNWmt0f/JtR5ovq0Dr51qOzw==
X-OriginatorOrg: sandisk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA4PR16MB520939.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cedf4519-d319-46e2-c542-08df3e2b8218
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2026 06:34:29.6492
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ffe0ff2-35d0-407e-a107-79fc32e84ec4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G6+fScPipC2gCIodsWDtnk5/YVTIEyPQdRfyLNtlUE/Z/rJdlgcEE4rylLcB6PmKkPp9JdC3uT+VRAIkkCUkTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR16MB6114

PiBIaSBNTUMgbWFpbnRhaW5lcnMsDQo+IA0KPiBJIHdvdWxkIGxpa2UgdG8gcmVwb3J0IGFuIGlz
c3VlIHJlZ2FyZGluZyB0aGUgJ21tYyBncCBjcmVhdGUnIGNvbW1hbmQgaW4NCj4gbW1jLXV0aWxz
IHdoZW4gY29uZmlndXJpbmcgbXVsdGlwbGUgR2VuZXJhbCBQdXJwb3NlIFBhcnRpdGlvbnMgKEdQ
QVApIHdpdGgNCj4gZW5oYW5jZWQgYXR0cmlidXRlcy4NCj4gDQo+IFtQcm9ibGVtIFN1bW1hcnld
DQo+IE9uIG1hbnkgZU1NQyA1LjEgZGV2aWNlcywgUEFSVElUSU9OU19BVFRSSUJVVEUgKEVYVF9D
U0RbMTU2XSkgb25seQ0KPiBhY2NlcHRzIHRoZSBmaXJzdCB3cml0ZSBwcmlvciB0byBwYXJ0aXRp
b24gY29tcGxldGlvbjsgc3Vic2VxdWVudCB3cml0ZXMgdG8NCj4gRVhUX0NTRFsxNTZdIGFyZSBp
Z25vcmVkIGJ5IHRoZSBkZXZpY2UuDQo+IEJlY2F1c2UgJ21tYyBncCBjcmVhdGUnIG9ubHkgdGFr
ZXMgcGFyYW1ldGVycyBmb3IgYSBzaW5nbGUgR1AgcGFydGl0aW9uIHBlcg0KPiBjb21tYW5kIGFu
ZCBpc3N1ZXMgYSBkaXJlY3QgQ01ENiB3cml0ZSB0byBFWFRfQ1NEWzE1Nl0gZWFjaCB0aW1lLCBy
dW5uaW5nDQo+ICdtbWMgZ3AgY3JlYXRlJyBzZXF1ZW50aWFsbHkgcmVzdWx0cyBpbiBvbmx5IHRo
ZSBmaXJzdCBjb25maWd1cmVkIHBhcnRpdGlvbiAoR1AxKQ0KPiBnZXR0aW5nIHRoZSBFTkggYXR0
cmlidXRlLCB3aGlsZSBzdWJzZXF1ZW50IHBhcnRpdGlvbnMgKEdQMikgcmVtYWluIGluDQo+IHN0
YW5kYXJkIG1vZGUuDQo+IA0KPiBbU3RlcHMgdG8gUmVwcm9kdWNlXQ0KPiBBc3N1bWUgYW4gdW5w
YXJ0aXRpb25lZCBlTU1DIGRldmljZSB3aGVyZQ0KPiBQQVJUSVRJT05fU0VUVElOR19DT01QTEVU
RUQgKEVYVF9DU0RbMTU1XSkgaXMgMHgwMDoNCj4gQ29uZmlndXJlIEdQMSB3aXRoIGVuaGFuY2Vk
IGF0dHJpYnV0ZSAod2l0aG91dCBmaW5hbGl6YXRpb24pOg0KPiBtbWMgZ3AgY3JlYXRlIC1jIDUy
NDI4OCAxIDEgMCAvZGV2L21tY2JsazANCj4gLT4gUEFSVElUSU9OU19BVFRSSUJVVEUgKEVYVF9D
U0RbMTU2XSkgaXMgc2V0IHRvIDB4MDIgKEJpdCAxIHNldCBmb3IgR1AxKS4NCj4gDQo+IENvbmZp
Z3VyZSBHUDIgd2l0aCBlbmhhbmNlZCBhdHRyaWJ1dGUgYW5kIGZpbmFsaXplOg0KPiBtbWMgZ3Ag
Y3JlYXRlIC15IDI2MjE0NCAyIDEgMCAvZGV2L21tY2JsazANCj4gLT4gUEFSVElUSU9OU19BVFRS
SUJVVEUgKEVYVF9DU0RbMTU2XSkgaXMgb3ZlcndyaXR0ZW4gd2l0aCAweDA2IChCaXQgMiBzZXQN
Cj4gZm9yIEdQMikuDQo+IA0KPiA8UG93ZXIgY3ljbGU+DQo+IA0KPiBDaGVjayB0aGUgcmVzdWx0
aW5nIGNvbmZpZ3VyYXRpb24gdmlhIGV4dGNzZCByZWFkOg0KPiBtbWMgZXh0Y3NkIHJlYWQgL2Rl
di9tbWNibGswIHwgZ3JlcCAtaSAiUEFSVElUSU9OU19BVFRSSUJVVEUiDQo+IA0KPiBbUm9vdCBD
YXVzZSAmIEpFREVDIEJlaGF2aW9yXQ0KPiBBY2NvcmRpbmcgdG8gSkVERUMgSkVTRDg0LUI1MSwg
Y29uZmlndXJpbmcgbXVsdGlwbGUgR1AgcGFydGl0aW9ucyB3aXRoDQo+IGVuaGFuY2VkIG9yIHdy
aXRlIHJlbGlhYmlsaXR5IGF0dHJpYnV0ZXMgcmVxdWlyZXMgRVhUX0NTRFsxNTZdIHRvIGJlIHNl
dCB3aXRoDQo+IGFsbCBkZXNpcmVkIHBhcnRpdGlvbiBiaXRzIChlLmcuLCAweDA2IGZvciBib3Ro
IEdQMSBhbmQgR1AyKSBpbiBhIHNpbmdsZQ0KPiBjb25maWd1cmF0aW9uIHNlcXVlbmNlIGJlZm9y
ZSB0aGUgcmVnaXN0ZXIgYmVjb21lcyBpbW11dGFibGUuDQo+IFRoZSBjdXJyZW50IENMSSBpbnRl
cmZhY2Ugb2YgJ21tYyBncCBjcmVhdGUnIGlzIHNpbmdsZS1wYXJ0aXRpb24tb3JpZW50ZWQgYW5k
DQo+IGRvZXMgbm90IGFsbG93IHVzZXJzIHRvIHNwZWNpZnkgYXR0cmlidXRlcyBmb3IgbXVsdGlw
bGUgR1AgcGFydGl0aW9ucyBpbiBhIHNpbmdsZQ0KPiBjb21tYW5kLCBtYWtpbmcgaXQgaW1wb3Nz
aWJsZSB0byBjb25maWd1cmUgbXVsdGlwbGUgRU5IIEdQIHBhcnRpdGlvbnMNCj4gc2VxdWVudGlh
bGx5IHVzaW5nIG1tYy11dGlscy4NCj4gDQo+IFtTdWdnZXN0ZWQgRW5oYW5jZW1lbnRdDQo+IFN1
cHBvcnQgY29uZmlndXJpbmcgYWxsIEdQIHBhcnRpdGlvbnMgYW5kIHRoZSBjb21wb3NpdGUNCj4g
UEFSVElUSU9OU19BVFRSSUJVVEUgKEVYVF9DU0RbMTU2XSkgaW4gYSBzaW5nbGUgY29tbWFuZCBp
bnZvY2F0aW9uLCBvcg0KPiBwcm92aWRlIGEgY29tbWFuZC9zeW50YXggdG8gc3BlY2lmeSBtdWx0
aS1HUCBjb25maWd1cmF0aW9ucyBhdG9taWNhbGx5DQo+IGJlZm9yZSB3cml0aW5nIEVYVF9DU0Rb
MTU1XS4NCkhpIENocmlzLA0KQUZBSUssIHRoZSBleGlzdGluZyBgLWNgL2AteWAgaW50ZXJmYWNl
IGFscmVhZHkgc3VwcG9ydHMgY29uZmlndXJpbmcgbXVsdGlwbGUgR1AgcGFydGl0aW9ucyBiZWZv
cmUgc2V0dGluZyBQQVJUSVRJT05fU0VUVElOR19DT01QTEVURUQuDQpBbHNvLCBJIHdvdWxkIGV4
cGVjdCBTV0lUQ0hfRVJST1IgcmF0aGVyIHRoYW4gYSBzaWxlbnRseSBpZ25vcmVkIHVwZGF0ZS4N
Cg0KVGhhdCBzYWlkLCBzdXBwb3J0aW5nIG11bHRpcGxlIEdQIHBhcnRpdGlvbnMgaW4gb25lIGlu
dm9jYXRpb24gc291bmRzIHJlYXNvbmFibGUuDQpUaGlzIGNvdWxkIGJlIGUuZy4gYSBuZXcgYGdw
LW11bHRpIGNyZWF0ZWAgY29tbWFuZCwgbGVhdmluZyBgZ3AgY3JlYXRlYCB1bmNoYW5nZWQuDQpX
ZSBjb3VsZCB2YWxpZGF0ZSB0aGUgY29tcGxldGUgY29uZmlndXJhdGlvbiB1cGZyb250LCBwcm9n
cmFtIHRoZSBwYXJ0aXRpb24gc2l6ZXMsIHdyaXRlIHRoZSBjb21iaW5lZCBQQVJUSVRJT05TX0FU
VFJJQlVURSB2YWx1ZSBvbmNlLCBhbmQgb3B0aW9uYWxseSBzZXQgUEFSVElUSU9OX1NFVFRJTkdf
Q09NUExFVEVEIGF0IHRoZSBlbmQuDQpXaGlsZSBhdCBpdCwgaXQgd291bGQgYmUgYSBnb29kIG9w
cG9ydHVuaXR5IHRvIGFkZCB0aGUgbWlzc2luZyBgZ3AgY3JlYXRlYCB0byBvdXIgSE9XVE8uDQoN
ClRoYW5rcywNCkF2cmkNCg==
