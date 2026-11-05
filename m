Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.193
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793857422;
	b=KVs4pUUQRhIOjTCoM0QdUFEvb/U7s8NLU/iLYTZB2fymr8CIDKgFOrlWM5a82b9XtU1B
	 ih5l9zZynBMpiZrQMnNznra2xxVn5LV38bHyrPGlj2cif7bj1rmfdOYGDn7zb6B+RPK5+
	 np+1t20e3GHz0YydgC9Hn5wFliJHjBNF84CK58a27sghMoRwaLU/tF5dZ3LzIS+ttMD+2
	 UwXvIySZML5ZhnRzGoA6kodBYyDIB/8e0n7vCLZTA8eljFUw7RvG1hyw/Azm7IpGaVmUK
	 JMI18EMaoYRDSLBsiLvBWssFunaHL74Yy06edg4Zuin4pqjZ1OgFHtYZQIFvLioTdJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793857422;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
	 X-MS-Has-Attach:X-MS-TNEF-Correlator:msip_labels:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Language:Content-Type:Content-Transfer-Encoding;
	bh=kq7I2iaSa2pKuwvLVte5vwtf0y+5V2u5Ko4bFuiPGgg=;
	b=zoZN9BPIHPMvWBYM5RWJmRO3Jj647ZOlZv8R4hQcUenmkcF964MPmrUbdsOJU2zIce14
	 Y9QoFnSdtpPTjBwHuf/wE5p7NHR6cHVB7GUi+FJE1sP5bPZ2ogFXI9Bx7I6pAC8kjjynR
	 yJrOSc9uz2TWwf1ScAXaJa3U5lhSqxnMHDvmqRE5rKTR/ex8UY5U9aJbhZ2SxxnmE4ICb
	 +X4t0hiHRZMKjZf2Rwub7eDzBa84/A25u/PbGyW/z1njtn7RhYLRGSDKqHstZTXH2Jria
	 /T3HDCLnLlcxcD6LzVVjTkz8LwrdpxT7w2PKJXIZxMsml0OCtLh+FlS7QfX+JmC2Ktg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kingston.com.tw;
	spf=pass smtp.mailfrom=kingston.com.tw;
	dkim=pass header.d=kingston.com.tw header.i=@kingston.com.tw header.a=rsa-sha256 header.s=mimecast20260119 header.b=gplradf9;
	arc=none smtp.remote-ip=170.10.133.193
Received: from us-smtp-delivery-193.mimecast.com (us-smtp-delivery-193.mimecast.com [170.10.133.193])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA18606A326
	for <linux-mmc@vger.kernel.org>; Thu,  5 Nov 2026 05:43:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8CA18606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kingston.com.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kingston.com.tw
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kingston.com.tw header.i=@kingston.com.tw header.a=rsa-sha256 header.s=mimecast20260119 header.b=gplradf9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kingston.com.tw;
	s=mimecast20260119; t=1793857420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kq7I2iaSa2pKuwvLVte5vwtf0y+5V2u5Ko4bFuiPGgg=;
	b=gplradf9832PewIfzGfshaJ5zHbCcS1iTEQy/0iGFkKl7b21TCEZiJorfiy4nXBR3fjxeO
	KDgUjflL8jbu+uv+N1MvNcRMpdOmC517yN085Ii0cXYMg164aqNVKgoT/40BDPxU/au6zc
	C/j+pJYt9zNVaTj+gEPE5SfjY+9vRy7xrn4WEL3q9FQPKAPunwm6BZWDJnRyOJLAQ6jiae
	UHeYlx2PDJPBnvVJzZ6jUf/KBOaESE+TjFZK+GoZTymr/G4HeOhGUBJ6Dn/WEsXrj67zSm
	gj6XYFm3ylOoi/g66rwcbKP4VMzLVXVeHGcS4uxj7sf5jrjvZGgt1bg91SvT2Q==
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11020128.outbound.protection.outlook.com
 [40.93.198.128]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-386-tgyZ6MsbPci2VYDqNjc63g-1; Thu, 05 Nov 2026 00:43:38 -0500
X-MC-Unique: tgyZ6MsbPci2VYDqNjc63g-1
X-Mimecast-MFC-AGG-ID: tgyZ6MsbPci2VYDqNjc63g_1793857418
Received: from SA2PR10MB4794.namprd10.prod.outlook.com (2603:10b6:806:113::8)
 by CC6PR10MB824513.namprd10.prod.outlook.com (2603:10b6:170:206::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 05:43:35 +0000
Received: from SA2PR10MB4794.namprd10.prod.outlook.com
 ([fe80::b13f:fc64:4ad4:1256]) by SA2PR10MB4794.namprd10.prod.outlook.com
 ([fe80::b13f:fc64:4ad4:1256%7]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 05:43:35 +0000
From: Chris Liu <Chris_Liu@kingston.com.tw>
To: Avri Altman <avri.altman@sandisk.com>, Ulf Hansson <ulfh@kernel.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: =?utf-8?B?5Zue6KaGOiBbQlVHIC8gUkZDIG1tYy11dGlsc10gaW5jb3JyZWN0IEdQIHBh?=
 =?utf-8?Q?rtition_config?=
Thread-Topic: [BUG / RFC mmc-utils] incorrect GP partition config
Thread-Index: AQHdbNP8zy/awUOkjEioDZndvS+b0rce906J
Date: Thu, 5 Nov 2026 05:43:34 +0000
Message-ID: <SA2PR10MB47947BB371D92546E8BF3F10D9772@SA2PR10MB4794.namprd10.prod.outlook.com>
References: <SJ0PR10MB47994BA641B2C58D8B75173DD9772@SJ0PR10MB4799.namprd10.prod.outlook.com>
In-Reply-To: <SJ0PR10MB47994BA641B2C58D8B75173DD9772@SJ0PR10MB4799.namprd10.prod.outlook.com>
Accept-Language: zh-TW, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9iNGEzY2RkNy0wNmQ1LTQxMDUtOTYxOC1lMzI1OGZkNjIy?=
 =?utf-8?B?YjBfRW5hYmxlZD1UcnVlO01TSVBfTGFiZWxfYjRhM2NkZDctMDZkNS00MTA1?=
 =?utf-8?B?LTk2MTgtZTMyNThmZDYyMmIwX1NpdGVJZD1mNDNhMmQ4OS1iY2Q1LTQyNWYt?=
 =?utf-8?B?OTgxYy1mNzIzMWJjZDQ0Njc7TVNJUF9MYWJlbF9iNGEzY2RkNy0wNmQ1LTQx?=
 =?utf-8?B?MDUtOTYxOC1lMzI1OGZkNjIyYjBfU2V0RGF0ZT0yMDI2LTExLTA1VDA1OjQz?=
 =?utf-8?B?OjM0LjQ1NVo7TVNJUF9MYWJlbF9iNGEzY2RkNy0wNmQ1LTQxMDUtOTYxOC1l?=
 =?utf-8?B?MzI1OGZkNjIyYjBfTmFtZT3ph5Hlo6vpoJPlhafpg6g7TVNJUF9MYWJlbF9i?=
 =?utf-8?B?NGEzY2RkNy0wNmQ1LTQxMDUtOTYxOC1lMzI1OGZkNjIyYjBfQ29udGVudEJp?=
 =?utf-8?B?dHM9MTtNU0lQX0xhYmVsX2I0YTNjZGQ3LTA2ZDUtNDEwNS05NjE4LWUzMjU4?=
 =?utf-8?B?ZmQ2MjJiMF9NZXRob2Q9U3RhbmRhcmQ7?=
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA2PR10MB4794:EE_|CC6PR10MB824513:EE_
x-ms-office365-filtering-correlation-id: ffa72745-6d6f-4aef-bb74-08df3affbbb1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|6133799003|22082099003|18002099003|3023799007|38070700021|10067099003|261021123027099003|11063799006|261022105027099003|261028144727099003|261026121527099003|261102123227099003|261026140227099003|261022075727099003|261021121427099003|261009223027099003|56012099006
x-microsoft-antispam-message-info: DuK3yDNcPG7uiuH6w6qB39P0TkZwLDy/jLIlpA57U5CDqwBto8ZBSUgi568CLEDmW5oAwo2rEIaMpioSpY/AfGpYBpa+WqlbJIVj2F+nEf9ISw/R8gwq5dYnIYT26XwUNTuWDmBh2/2lqYDyUL2Qd8YkkreOBnwWkX42hkAUEesoEloQEj6YhZwlbQD51u662W36CyYzXB9fc+lIZhE7nlZZ2NRbefaCC/uriBbj9t/qI7K9/BySmXYPrsGEFWw7ZqloT0/Yj/D524VEMB0qLiXtWOAbSDPnwLP7rpQK+vB3JHkVqMFtB0XD5ZE5hO3CUWjGkZ5QRktNyOwU9xvJ14kq47f/c+qq6ZU2kq+qVL4QJNWsCeXm29sK6H3p/76gt4lJdkK1yywXxYvT+c94ezd/iCrzbtZhxdz/oXxbITQtlladpKjzK6FQWXTrgzHVmaFoCoC7h77DP31OkOaxemOWYIvH6iSACw+HSR40lai/sy+97an7s46hZbdbaW36bOcKbB2z6RJ5VeHF3q/sWC2TtYEEKyJsXji1ASuR+KB2XIk/9Qc5WPSQOUxeMWzuSuYKL9gsFGrVUDhPjX0+SFMZayP8VIwFVCM/xQeQSsdw08lvs/br95FBgY7u2FtLcQ4sm97KV2ceGfGqAE9uZKKrW+KUEb8qAlE61kT0MPioViYGvz3RkhLjAAkCJbDlF91ASif4EafKb4UMwOqjFQbkycsCGGNPc9aLXEibR2E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4794.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(6133799003)(22082099003)(18002099003)(3023799007)(38070700021)(10067099003)(261021123027099003)(11063799006)(261022105027099003)(261028144727099003)(261026121527099003)(261102123227099003)(261026140227099003)(261022075727099003)(261021121427099003)(261009223027099003)(56012099006);DIR:OUT;SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MGZpUFN4TGFIemt2NzErOWdpa2NpMEVNaXNiVm9SaHVYaVlBTmhUK2NXTU1O?=
 =?utf-8?B?L2QrMElCN240bXo2aHowREdKVGpXc1BlS2JyY0N2Z2xkenJmaFNRWndsNjFw?=
 =?utf-8?B?T05wd0JsMGVpU2RubWZZYlF0WUNia053TGh6RFNnV0pjTlRiZWx2bUFiU1Jz?=
 =?utf-8?B?UXpQemQ4WGpKOGlEZ01hUkFqZm5iQ1kxUVR3MmFrNnYyZ3pEUHI2Y3ZxK1pa?=
 =?utf-8?B?dDdjVG5oV1RyTytWWmo2eDJKRVM0RWJ6WXMxMzFibXJvZzFFWVl1dzZVNGZW?=
 =?utf-8?B?THArVkRJMDN1TkQvTnRQOGtFSlJCWlU0TURhRGJldXAzSWVDSnMzYkQ2bWJm?=
 =?utf-8?B?Y1V2SHpmQnhkN2NReUZnR2V4Q1BkZDNuYnVnRHltMGdkbERUVXJCZk1xZUQ2?=
 =?utf-8?B?YVFCcGp6U2Rkd3BQcGV4RFBDZVF4dEVIZy90amM0Q1NrbFhYV0Z6R1BTN1Zy?=
 =?utf-8?B?YkJxVzVUYS9yN09yM2dFMTZXaTFUVi9mb25UU1BnYjJDQUY0MTBVMCs4Yk90?=
 =?utf-8?B?RjdMY0RLQ0x3eFZnNEI5c1UxaFIrMzVHdGNDeFV1c1V2eS9lODN2QUJNelB0?=
 =?utf-8?B?cDdQMWcxY3hwTjc2UVErODlSWlByRFNaMEdEVXY2NlFKUUxkc1ZQUnlBUmcr?=
 =?utf-8?B?SmdFNWordVdYYzJraHZGREV5dHhuU2pJTk9kSEIxTU1RcmhZUVJjT25Bd3lu?=
 =?utf-8?B?aHd2UElIZlRSdDZ3ZXJzOGpISWhQNzJxdWYzMDlZaTNJQSs1YWxRYm56aWE2?=
 =?utf-8?B?YkZDS2RvYTAvWEtnSXdDV3A4TW8rYTczZGkyVzZKUXVCMzJyK0VFaDZSSWZu?=
 =?utf-8?B?Z1N1UldqWFJubUlzY1o4bzZhVGJLR0hkTDAxdGxwYzQ5azhoQ2dGZE5xcEU0?=
 =?utf-8?B?dk1mRUdJcEg2SVVZMUE5SGFlOTk3Qll4cW5iRHVPNS9XQklFNFNwQ2RVbWo5?=
 =?utf-8?B?RVN4YWhnR2R5WUFrbDJRbHk5Zy9CSFloV0poaVFjakJmMm5PVWV6Y0pXOEEx?=
 =?utf-8?B?WkdaZ09HWFJwUkJQYmc3TW55WFdFN3Zxb0QyWmx2TEY2MEozYWNsaExsbDNn?=
 =?utf-8?B?VEd6anFnNmZCVW9wN0lNVVNpNnZZNVhMc282SzBEUW1ycWJTcTVFc3RhK1pJ?=
 =?utf-8?B?eUtEL0V2UnNyOG5uTDR3SU1IMG0wMUdRQ0JzbGpkekVvQUlZSWE1MmFIOVdy?=
 =?utf-8?B?S2J5Q3RrQTJ3bG5SY0QwYmFnYXFSWERWNzEvdGtQK09PRGVockRBdnhiNXNS?=
 =?utf-8?B?WnBnMUR5Znczbi9MZUtqblFmRDNPYTREZHJjUC9qejl3bVZmMnk5WTN2S1JK?=
 =?utf-8?B?aGxidkIvb1B6ck9WcURWMjlDcU1nU1dCNVpSemhmL0k5b3h1UXRUSzVEd2RC?=
 =?utf-8?B?aU5HMzdkRlJ5MXRVOHhmekZXOGRIUTVtK0Roekw1enEyajlMYkgzSGljTDF0?=
 =?utf-8?B?aUZTeTd6Q1VhQllXckoxM3E4RDBJbTVYbHorUlZYRW02SGpHTU4rYm9iS05i?=
 =?utf-8?B?Y0ZFRWZZcjZra2pWMzRWaXdoZExQdHppRXpCeUNnd25ydWV6NUdnR3lCbzc5?=
 =?utf-8?B?YjBYOW9ITGJRdFFmYngzZHFOcTBZR25Tb0xXVkRxRkcvSkRHNzJIbmZFVjZW?=
 =?utf-8?B?bnQxM01ZdEJ3dm1RWDVPY29wSDl0Yzc1NzliRktKNmxNNmJJL2tCSkdILy9t?=
 =?utf-8?B?NnEyZGF1dFdoYTFmTGhzOFNVNVZXTXV0R2lpWEN1dm1ISkhROGtmK05WSXNN?=
 =?utf-8?B?ZU5ReERaOFZPeGFETWxDenExZEN1TytDOGRqN3dLSHU4eW9xMWozSEwvY2xG?=
 =?utf-8?B?eDh2a1BOazlWdGR5em1NczZNR2w2dnE0WnhhN3dxVGRpVkR6K2NVRnB1WVp0?=
 =?utf-8?B?bEpuNmh4Qlp1ZXhTSTJ0aTZFb0JFWkcxa1laZGZUN04vNHpDdWdlZXpnVkt1?=
 =?utf-8?B?bStCRnlhZ2VZTXRsTFFudGdjTmwxOExIUG9qRlVyK28vRjM3YVZiYUpnbzJT?=
 =?utf-8?B?WFIrdnhHWXZZQmY3Um82OHYwVDVJQ1U0M2EzbVZCbEUwcThiRURyM2lUbkZn?=
 =?utf-8?B?ZGRnakJsKzZGR1JZSFhNQjQ3OHJtTkMvaFdRL0taZm5FblYyWDRRUjRQMTNv?=
 =?utf-8?B?NWRTZ0p3R010MTJSR084bm9zdHI5YWlUS0ZiMDdLQUd0SjVhK1pDWUk2NTc1?=
 =?utf-8?B?SWVobzlqdGVEYXQ2cFFESjMyQm5sd0U5NzZWakJUaXdRVW54Sk5qNDNPQ2I5?=
 =?utf-8?B?SEp3RDNsMXlJZTNOTUNhcTBrU2pBWW94Tk5xcG1QeHJVOHVmdC9yalRwSGRV?=
 =?utf-8?B?WnNuam1rNWVxSGtGNWhSbzJNMDdveUJFTUpJV1lyZHRNLytFM245dz09?=
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: eZ38mh5u93uBQl5jcpSdMrmxhG8PNCDkRJOM4r0yze29X9JlZvQ/5thWZKgT2JO+CvCRDZGys5bmxdSuw6vUvyRTeMq74LKQz+B6YG8C5UvLHnpwVtyE5eB3GHOnmbWsdPq3v1RPsR7pZB5HX1rTqPv31kplHBrou+g8nR1+IQrYZKxK1kQw5lWSbS2Yc0mooUtw+4PL2koEOhQZPCHMXzf6JS1Tua9M4dAoZ9ngu9sRdYhYxKWCptOf86HBXMoo7Q4y+kRYwfXyDlfzLtgIJrCUmH7qa6L7rYBc2TLHExIamud1hSNeFQeteuewVlsy7GCokfjB7qfQSDYfqIeIUg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: cx8ox0cD/yl0FzQUlakwShIM8Kptq5T3DQo7xkKfr6u66oAL7QAVrj4B/XRWBQdaHE+1yOAGFQt6dl/EeLt/He4ohcKDxKlnyoxgO1ZnesxO4wM9/lwasFfNDv+EOE3CRekUEtRAu4KN82rUBGtTnd1vLxYng3IUZwcav1HRxpuenkpIlDPm08yrHiw+qWLBXs5k3FeoilTzH/Zfs52ak70Lscb4maJ8DrQjK8+eLiY5WN2gxh3Y6e2cJM1TJ93Evpgp4FLLXp6E0ctP5YkHrM3R8ZuFKRoKuaZ45uLfifVZxJYOCNH4QsNsNJtfZ/G5IO+Ttrj1Q1ltcExGvZPCifNaXlPkNriAX+s+HdNZsco0uT3+xXD8Q+SUCYaa6cu5atwyioiSMu4UpvRruabLYUBcItUhyR+ln4XHKr+I1vlF92grSab7PuQD6pd6QoWt7T/hjelQQt7HpJb9RmJmTyj2hUhXdT/mxIJcqxxAoX5YlZUA+mVvDShhzqEE0Onv8LJkvgVpKMLbZNTwpivMQielV+y9Bg3EFw0+MEvUgyd0nidKbgnKXJo2etTGYQBHq/fE/wtba8YRZ5rb7/a4bbxVFh5TyAEGHNH3UTZk5Vji6rZkXhyYDX2/yqITHKU+iHl+zcs3V9FnqSGyW1Rj5A==
X-OriginatorOrg: kingston.com.tw
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4794.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffa72745-6d6f-4aef-bb74-08df3affbbb1
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2026 05:43:34.9874
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f43a2d89-bcd5-425f-981c-f7231bcd4467
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9r/QgZ6NRudV3+Fo+M2p2YkSAhHjq2I8PEr3EIqYXSS1rXCUw0FxJ+hf4Fs767ZDJzNFwGTddEoB6k69Xd6yJcRhE6RhMD6gIJKsY/BIgGg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CC6PR10MB824513
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: XVIDl3KEOMxoqIjnPdmIRxWAKlSez5bNthv-e-EOWe8_1793857418
X-Mimecast-Originator: kingston.com.tw
Content-Language: zh-TW
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

SGkgTU1DIG1haW50YWluZXJzLA0KDQpJIHdvdWxkIGxpa2UgdG8gcmVwb3J0IGFuIGlzc3VlIHJl
Z2FyZGluZyB0aGUgJ21tYyBncCBjcmVhdGUnIGNvbW1hbmQgaW4gbW1jLXV0aWxzIHdoZW4gY29u
ZmlndXJpbmcgbXVsdGlwbGUgR2VuZXJhbCBQdXJwb3NlIFBhcnRpdGlvbnMgKEdQQVApIHdpdGgg
ZW5oYW5jZWQgYXR0cmlidXRlcy4NCg0KW1Byb2JsZW0gU3VtbWFyeV0NCk9uIG1hbnkgZU1NQyA1
LjEgZGV2aWNlcywgUEFSVElUSU9OU19BVFRSSUJVVEUgKEVYVF9DU0RbMTU2XSkgb25seSBhY2Nl
cHRzIHRoZSBmaXJzdCB3cml0ZSBwcmlvciB0byBwYXJ0aXRpb24gY29tcGxldGlvbjsNCnN1YnNl
cXVlbnQgd3JpdGVzIHRvIEVYVF9DU0RbMTU2XSBhcmUgaWdub3JlZCBieSB0aGUgZGV2aWNlLg0K
QmVjYXVzZSAnbW1jIGdwIGNyZWF0ZScgb25seSB0YWtlcyBwYXJhbWV0ZXJzIGZvciBhIHNpbmds
ZSBHUCBwYXJ0aXRpb24gcGVyIGNvbW1hbmQgYW5kIGlzc3VlcyBhIGRpcmVjdCBDTUQ2IHdyaXRl
IHRvIEVYVF9DU0RbMTU2XSBlYWNoIHRpbWUsIHJ1bm5pbmcgJ21tYyBncCBjcmVhdGUnIHNlcXVl
bnRpYWxseSByZXN1bHRzIGluIG9ubHkgdGhlIGZpcnN0IGNvbmZpZ3VyZWQgcGFydGl0aW9uIChH
UDEpIGdldHRpbmcgdGhlIEVOSCBhdHRyaWJ1dGUsIHdoaWxlIHN1YnNlcXVlbnQgcGFydGl0aW9u
cyAoR1AyKSByZW1haW4gaW4gc3RhbmRhcmQgbW9kZS4NCg0KW1N0ZXBzIHRvIFJlcHJvZHVjZV0N
CkFzc3VtZSBhbiB1bnBhcnRpdGlvbmVkIGVNTUMgZGV2aWNlIHdoZXJlIFBBUlRJVElPTl9TRVRU
SU5HX0NPTVBMRVRFRCAoRVhUX0NTRFsxNTVdKSBpcyAweDAwOg0KQ29uZmlndXJlIEdQMSB3aXRo
IGVuaGFuY2VkIGF0dHJpYnV0ZSAod2l0aG91dCBmaW5hbGl6YXRpb24pOg0KbW1jIGdwIGNyZWF0
ZSAtYyA1MjQyODggMSAxIDAgL2Rldi9tbWNibGswDQotPiBQQVJUSVRJT05TX0FUVFJJQlVURSAo
RVhUX0NTRFsxNTZdKSBpcyBzZXQgdG8gMHgwMiAoQml0IDEgc2V0IGZvciBHUDEpLg0KDQpDb25m
aWd1cmUgR1AyIHdpdGggZW5oYW5jZWQgYXR0cmlidXRlIGFuZCBmaW5hbGl6ZToNCm1tYyBncCBj
cmVhdGUgLXkgMjYyMTQ0IDIgMSAwIC9kZXYvbW1jYmxrMA0KLT4gUEFSVElUSU9OU19BVFRSSUJV
VEUgKEVYVF9DU0RbMTU2XSkgaXMgb3ZlcndyaXR0ZW4gd2l0aCAweDA2IChCaXQgMiBzZXQgZm9y
IEdQMikuDQoNCjxQb3dlciBjeWNsZT4NCg0KQ2hlY2sgdGhlIHJlc3VsdGluZyBjb25maWd1cmF0
aW9uIHZpYSBleHRjc2QgcmVhZDoNCm1tYyBleHRjc2QgcmVhZCAvZGV2L21tY2JsazAgfCBncmVw
IC1pICJQQVJUSVRJT05TX0FUVFJJQlVURSINCg0KW1Jvb3QgQ2F1c2UgJiBKRURFQyBCZWhhdmlv
cl0NCkFjY29yZGluZyB0byBKRURFQyBKRVNEODQtQjUxLCBjb25maWd1cmluZyBtdWx0aXBsZSBH
UCBwYXJ0aXRpb25zIHdpdGggZW5oYW5jZWQgb3Igd3JpdGUgcmVsaWFiaWxpdHkgYXR0cmlidXRl
cyByZXF1aXJlcyBFWFRfQ1NEWzE1Nl0gdG8gYmUgc2V0IHdpdGggYWxsIGRlc2lyZWQgcGFydGl0
aW9uIGJpdHMgKGUuZy4sIDB4MDYgZm9yIGJvdGggR1AxIGFuZCBHUDIpIGluIGEgc2luZ2xlIGNv
bmZpZ3VyYXRpb24gc2VxdWVuY2UgYmVmb3JlIHRoZSByZWdpc3RlciBiZWNvbWVzIGltbXV0YWJs
ZS4NClRoZSBjdXJyZW50IENMSSBpbnRlcmZhY2Ugb2YgJ21tYyBncCBjcmVhdGUnIGlzIHNpbmds
ZS1wYXJ0aXRpb24tb3JpZW50ZWQgYW5kIGRvZXMgbm90IGFsbG93IHVzZXJzIHRvIHNwZWNpZnkg
YXR0cmlidXRlcyBmb3IgbXVsdGlwbGUgR1AgcGFydGl0aW9ucyBpbiBhIHNpbmdsZSBjb21tYW5k
LCBtYWtpbmcgaXQgaW1wb3NzaWJsZSB0byBjb25maWd1cmUgbXVsdGlwbGUgRU5IIEdQIHBhcnRp
dGlvbnMgc2VxdWVudGlhbGx5IHVzaW5nIG1tYy11dGlscy4NCg0KW1N1Z2dlc3RlZCBFbmhhbmNl
bWVudF0NClN1cHBvcnQgY29uZmlndXJpbmcgYWxsIEdQIHBhcnRpdGlvbnMgYW5kIHRoZSBjb21w
b3NpdGUgUEFSVElUSU9OU19BVFRSSUJVVEUgKEVYVF9DU0RbMTU2XSkgaW4gYSBzaW5nbGUgY29t
bWFuZCBpbnZvY2F0aW9uLCBvciBwcm92aWRlIGEgY29tbWFuZC9zeW50YXggdG8gc3BlY2lmeSBt
dWx0aS1HUCBjb25maWd1cmF0aW9ucyBhdG9taWNhbGx5IGJlZm9yZSB3cml0aW5nIEVYVF9DU0Rb
MTU1XS4NCg0KDQoNCkNocmlzIExpdQ0KDQpUaGlzIGVtYWlsIGFuZCBhdHRhY2htZW50KHMpIG1h
eSBjb250YWluIG1hdGVyaWFsIHRoYXQgaXMgY29uZmlkZW50aWFsLCBwcml2aWxlZ2VkIGFuZC9v
ciBhdHRvcm5leSB3b3JrIHByb2R1Y3QgZm9yIHRoZSBzb2xlIHVzZSBvZiB0aGUgaW50ZW5kZWQg
cmVjaXBpZW50LiBBbnkgcmV2aWV3LCByZWxpYW5jZSBvciBkaXN0cmlidXRpb24gYnkgb3RoZXJz
IG9yIGZvcndhcmRpbmcgd2l0aG91dCBleHByZXNzIHBlcm1pc3Npb24gaXMgc3RyaWN0bHkgcHJv
aGliaXRlZC4gSWYgeW91IGFyZSBub3QgdGhlIGludGVuZGVkIHJlY2lwaWVudCwgcGxlYXNlIGNv
bnRhY3QgdGhlIHNlbmRlciBhbmQgZGVsZXRlIGFsbCBjb3BpZXMuDQo=

