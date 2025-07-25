Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2067.outbound.protection.outlook.com [40.107.236.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A1420127B;
	Fri, 25 Jul 2025 10:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753440837; cv=fail; b=K16+ydmk6L5Se08N3XlSWcYrvv/9Vw8yQo7XxgK7QuxEh4VahTWrUleJ8oMkQ2w8Zqzz5iX2dJ1l9fvR0J5yUgTSGEVC/xzZZF39uD9JwWenh1zIeVnHfEORWG9n5I5pEEyWHyhPwhjgxJXRXL7yHQV08EBgFIt1Ej6QgYNEGtE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753440837; c=relaxed/simple;
	bh=lemyBG7c7EQmmlqUCcirJtxw07wejPno9OxTc36mXog=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=A702mTiJFFgXUAD0HhxCfZKbLALohiA6eRXhwa6ll4wq3AXIzxIePNSvThakKu2STlGke6FjJULxkUINObDZeoz3sHST5QHrfwCAy0XqQh/kJGKhy1ZahPXSSAykfgKEkGTMe3sG/V6ur/st5cWWnKmVQMGA66kcXYJxa/AlIOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sRL91J0y; arc=fail smtp.client-ip=40.107.236.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sRL91J0y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XUfvM07L+/MFFoeT94yVymJZhT9eHJ398SutHg/L3YvwMUcM4eIzYcPrqTr0alX3bv58KlgXArPBuACLCtNih9KOF8fTuqRDSgQS/UaN16dmdIpvsrVaxtFhAbpJxI8YQhkb+Pq2NDjoP0f5j6P+FCbSCQYlnni2xDDxD+705RuLCrxKUcvo+1xnd95RkMDC+04SYLOi5BUtyeSfHAcc2OdBd1DqOZ9TL9rqGZLP59w49txui1BMiqPlwNJsGRWaN8oZPPPOaK3l/D30SP6Yj4znZ20Iyi0kySIMXswo7HA708fjFzQA+6wUh8LECi3O/0iLFBxyQuDXPsxiW6wvSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lemyBG7c7EQmmlqUCcirJtxw07wejPno9OxTc36mXog=;
 b=QjlnaWyw6VGtwubMWkibDvNJx/PtNgoLow7kd3D5UN3LAp/FKoLuZwpW7dLVLv1PudokecO6XmtSb8YqoLHqP+ufpv7lp5cX1tuzSgxTMcYEE6dzaanA8h3rsb2JmOOjWGJ8zgoxlRFAFBWGhH7hdNi41sr7Gen/7BP2NYO3BMsTRY8W4C/CYEKu+nErDIaVXNECOybFnQyrlLH4bU4iOx3klnFfXdMqo2BeOTbN40JS6KZZQgYRGdzddVQhQuUJdmcN18HdPm/WWnhuNX4lv98LMtn/iq+g2CmOwx4Wpi3wtpGkwIS+ZD1PcyVVuUUQ+Uzc0M58kBG6I6l+Yx6Tag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lemyBG7c7EQmmlqUCcirJtxw07wejPno9OxTc36mXog=;
 b=sRL91J0yoJ+Fj4GG1EU3Q4TZpl3tz92YSjWHfRBZ3G7ZppLZYBj1oqHUR6a8b07Wen4xU8uoAklBQF9sUJ4vNG592+gVXgYpmBGj9UzlQrKW11ppI5NPdYXyrIFiqQF7VVtqkaW2UAohiTlfk/j+/nwR6jgd5ToH1FHivqHHbxw=
Received: from BY5PR12MB4258.namprd12.prod.outlook.com (2603:10b6:a03:20d::10)
 by SA0PR12MB4400.namprd12.prod.outlook.com (2603:10b6:806:95::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Fri, 25 Jul
 2025 10:53:51 +0000
Received: from BY5PR12MB4258.namprd12.prod.outlook.com
 ([fe80::3228:a925:2191:98b3]) by BY5PR12MB4258.namprd12.prod.outlook.com
 ([fe80::3228:a925:2191:98b3%7]) with mapi id 15.20.8943.029; Fri, 25 Jul 2025
 10:53:51 +0000
From: "Potthuri, Sai Krishna" <sai.krishna.potthuri@amd.com>
To: Adrian Hunter <adrian.hunter@intel.com>, "Simek, Michal"
	<michal.simek@amd.com>, Ulf Hansson <ulf.hansson@linaro.org>
CC: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "git (AMD-Xilinx)" <git@amd.com>,
	"saikrishna12468@gmail.com" <saikrishna12468@gmail.com>
Subject: RE: [PATCH] mmc: sdhci-of-arasan: Ensure CD logic stabilization
 before power-up
Thread-Topic: [PATCH] mmc: sdhci-of-arasan: Ensure CD logic stabilization
 before power-up
Thread-Index: AQHb+iV59JsftOMvbkGqvxMjsJtJdbRBeViAgAAfaPCAAOthgIAAG1ow
Date: Fri, 25 Jul 2025 10:53:51 +0000
Message-ID:
 <BY5PR12MB4258226B0E1B11CDCB69569CDB59A@BY5PR12MB4258.namprd12.prod.outlook.com>
References: <20250721095357.3783222-1-sai.krishna.potthuri@amd.com>
 <cf04326b-4de4-4637-aa3b-fa1c358b9ae4@intel.com>
 <BY5PR12MB425804611D4B29ADDCC82906DB59A@BY5PR12MB4258.namprd12.prod.outlook.com>
 <b2e94588-96e4-4afa-b767-e7f05a81dcfa@intel.com>
In-Reply-To: <b2e94588-96e4-4afa-b767-e7f05a81dcfa@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-07-25T09:52:52.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR12MB4258:EE_|SA0PR12MB4400:EE_
x-ms-office365-filtering-correlation-id: 72f85f5f-4b78-4a8b-c2c8-08ddcb698a82
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dndJdzN5c0RGdnpabnNOTjY4RlVibEFyYnh6Uy9nSlBTOUhxODViTm9HVHov?=
 =?utf-8?B?WTV1dlBqdy85NTd5YmNEQU4vRVQyUDNjWGwxMHVMVVd5MDd2ZkRYODRNSk02?=
 =?utf-8?B?TWVIVjkrbmhPY1VnUUlSMDZRYmZVS1h4N3NvY1B0dWpuUjhLUSs5T2hDeC9k?=
 =?utf-8?B?RVM1V3RjUzBpOVpOVkVoVUE4bTRCd0k4UjMrdFZwZXphY2RTWkNpRmpIMWxp?=
 =?utf-8?B?NGdhVVpBR0w1bzJyemJtTE94bVJNcXBhZmVDbnU3TUlRM1FZOWZLdHd0WFhU?=
 =?utf-8?B?OHhUTS81c1dPZW4vQlNicGU3MEEyVzZ0dk4wZGlteHkyZGJSWXp0dFNtR25I?=
 =?utf-8?B?L1FLQlFNYnlZd1BvODhLTUZTWXhBKytqbzU3WG9vT2lrMVBBUEFMaFUvSVNl?=
 =?utf-8?B?YTRxNUgwVHIwZ2trWXdUN3pIQ28rUHpTNGRGMEdZZ1A4alEzRlN1MFN2QVJS?=
 =?utf-8?B?ZHA3dkJ0YjR1UWR5VWRhalU1RHN6V0lmSWdhdGNNUk0rQ25KNUNMWVEyZThJ?=
 =?utf-8?B?bVVkZk5hT2E4YklmTmdVYURYNXVCTzlKOFNiVGcvdmRSbS9nd2lQOUkzU2V5?=
 =?utf-8?B?ckxOVTNmVmhzM25TU3E0QkxXUEMzSnRvOEJTNWRQTXQzQzhaSlQ0M1h1Ymhp?=
 =?utf-8?B?YXY0ckJzVDJaMTdGeENjNlBXWWoyN1ppSjlQbkZjdTZrRkZFSDE5SUNWVUdH?=
 =?utf-8?B?bG95ckd6TVl5Q1I4STFtOXpwZk9uMTNwR254Z09Fc2I1clpMQWZXS0tuTk5i?=
 =?utf-8?B?eGV6Z3ljTDg1U2NXei9GZUhSQ0xwYXhZeFJjcjJzc29PYkF0VTJvZmlqa2s4?=
 =?utf-8?B?aGdOMFhoT3BUTWtRL0w0M2FmWFFTSVBZeUhmUG1KZlRWMjRYMEozbENtY3FY?=
 =?utf-8?B?aFgwYzM0NjRkQnRrTXY4S05uMlNJUE1tbURieC90bVFheGUrQ01NVHZHTHpz?=
 =?utf-8?B?ZWdTRXRmQUhVdlMvSlJrNlU1ZXNGQmt3Nyt1WUFkSmZwcWd6Vy9CNiszSEFX?=
 =?utf-8?B?UjRETjhyaUp5b2dlUmpJNWt3N3FwQ1lUOHg4bFl1cklFbVBkTlJ1UU5xQ1dU?=
 =?utf-8?B?ZXRwSC82b3QvbEtRbVBVTlpGOGVNZkdOMm1kaWFsZ005U0NjS25Gd3hxVmdv?=
 =?utf-8?B?ZXJBa2pJbitrUkxpUmFHL3BZdFVUWEo4R3hSbWZ3c3N4RnJMaGxUN2tkR2tu?=
 =?utf-8?B?ekltdFdLQjAzeGZQMFBXWlpWYVhnbGVJWGdSWU13UGdxellGdG5mK3F4SE5J?=
 =?utf-8?B?NTI5ZHg5MXdGSE1yN3FRSkEwckE1ck0vcWdlZFd2SHJHNll6TjVwWFppKzRw?=
 =?utf-8?B?eHlYTjBGRTRLTHg0NHpnYkp3Sjk0SDc0ellmanFqZDBzUTlZV2hIMmdhOFp3?=
 =?utf-8?B?QW5KS09XSFZRellvU3Izc1lxRDVBSzBsNkZrdDdBWGtFQjNVR0lEL0txVFNG?=
 =?utf-8?B?dHJ2WU8wMmoxMUNUUFJualpTQUdUWUVpbmJWemQ4SXpvc2ZTRmlxUEkrZkZQ?=
 =?utf-8?B?eHFHUkZkM0wwbWs3MWg4TWkxWGoyZDV3b2lqUmRkQmRpRUdCTlZNTkxJZUMw?=
 =?utf-8?B?TURMNytrMHMyN21uVkFzTVNicy9NQ3R5dFMvUkVOTjRlYTlOcFNuTDNGbWFi?=
 =?utf-8?B?bERJbEVYZW1IcmdXdWlUWXkxY3lkbG16UnRjck9NM2JlMEcxZjJqSlZPSFYr?=
 =?utf-8?B?dlVqK3lmUjUwQk5MU1RQUHNIVmU1bFUybDd3UXROTWxqLzVMNVZyZWRHVExv?=
 =?utf-8?B?L2xCQld1R1I4d2xaeW9UcmpwUk9Xd0R6N285N2VITlV0R0dtOS9yejdqNm5i?=
 =?utf-8?B?K25wMEgzZ0FEOHpMSzBkOWU5R2dkbEFkMEQzL0FxSmpieDg2dmQ3ZFBkSEEv?=
 =?utf-8?B?cHI1RitYelo5UDV5SGhna0YzUGtUS3lBZ0xiYWhKektybEtTR09nb0dmTkpn?=
 =?utf-8?B?OS9iem1lalVYK0NOek02S0p5MkJLRVl6cTB5WnlnZnNmNHBJOTRvNXhGU2NO?=
 =?utf-8?Q?brqB65i2wt3JcWcJEICT/Rv8vbA2xU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4258.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q2VoTERlMDZLZG5WaDA5STlIOUgzbVRzZVRVcXN5dGVYenp6akc4VDliZ0RK?=
 =?utf-8?B?cHRWSXVzY1kxNFpxNEJiOUVpK290K2k5YmZrNndTZEZHMW5JWGJkaS84STdn?=
 =?utf-8?B?T25Qay9NWmNYeCtJSEhDMngxL1pDTHN6VlAxRnIvV3N1b3FyWks3OG11dEhk?=
 =?utf-8?B?b0I0MG1DMitXLzVhV3A4Ykh6cE5UN0gxV1g3d2JjcXBOalFRaUdRM256bnNw?=
 =?utf-8?B?MHFuTlhJNU9FbDd6TzVNdXdOMHYzdkc4OXpXTjdBODJoRU1RYkpYeThiU0tx?=
 =?utf-8?B?TVFBTk85eTNqQTNiZUhISk42RU1uRlRKSGRER3FTOHdnUHpGNFJna3M0ekRo?=
 =?utf-8?B?eDhDNmd6cFRKSmovOG85VEtXTjcxclRFUVJWUGVmWE1hZWRsT0pVL3A2OXhG?=
 =?utf-8?B?REZpKzBDbkJiQlppME5uQTY3OTk0VnpoU2NFN3djUW5JUzJLUGlSRXo0akZS?=
 =?utf-8?B?RGQrSWxOTWk1R0NtTWtnUVBkK215NU9BSHBNbllDdWNsd0xUbXM1czJjeDFT?=
 =?utf-8?B?Znk3RER4c3htSFZkZVQ0bEhjbnNoS1c3ckRSUjhVWHhxeU1jSVlBcEU2QlpW?=
 =?utf-8?B?LzIxK1k1SnY1NjVqMnFOenk1Q1JWK0hWenVhOUtPV1dyR1p0dUNPMllFaHhN?=
 =?utf-8?B?amRzVFFUZlJxQlNrOTRrWitHcEMrT3huTlM3WGJ1d3p3ZXlDdkVleUtPN0Rp?=
 =?utf-8?B?ZWd2UG9DZlltdWhKYy8wakFVclM4ckZlaXRrZzQya3Y3dlk3a2VidndRMmVI?=
 =?utf-8?B?amZFT0VJQ3VZendQQ2JMbW5rL2ZRYjdZMmlBZW5aS1Q1ZEs0eTZpTlA4NEw5?=
 =?utf-8?B?d1N5eldZbklEY2R0YUNYZXZaNzZsbVdJWGdzNzMxUkVTOCtBVU45Qk5VZ2tw?=
 =?utf-8?B?aTFZNU4wc2Fwb21LcFBxYUEwZlZmdE1Va3NGVWhpTVByaEFRdzJhZVltMlpB?=
 =?utf-8?B?STVQaXpEeVhVS3BqWndzbXhVaVZLWGx5ZldOeWE2cFRBcThWU0FVODhMRWZi?=
 =?utf-8?B?VUV1OG5YeFhIN1RmaURmbWtWZnE0UUFVNVltaHI5SmJLWkVOdTlDUW02RGo0?=
 =?utf-8?B?enZqNDFVQ1pkOUtMMU1nWVFHT1M0RW0xVTAxRE1uNVNiWGJVY0NpZ3JmM25N?=
 =?utf-8?B?c3crOVJ0Z3RhME5MWVhvaGJIaTNmZm5sR1o1QTFWQ0lBNTVvU2hYMTNXOS9h?=
 =?utf-8?B?dWo5bkUwTENLWHcwSVFtTHlETDI5UmRYTEpkSk8xYTB6TERzMUI3NUZHLzZl?=
 =?utf-8?B?eFVFY01lYWs3bXpwUzlxTkRxVDRxOHBSL2kyYVhZZUNuU0RBNlhBQjdGYWdG?=
 =?utf-8?B?d1ZvQU1JQnF6d0plY3ZJM1AxbFZ2UUZEWmswWmh5YUpmVmkvNTlNMldDemRM?=
 =?utf-8?B?dGxLRlh3bUFWK2Vsd1NTWVJpNnNsQnl5dnh0WUdHQW5NTWxHQ1dHamxDdzVu?=
 =?utf-8?B?dzdiRnBxWDF6U3pDRWhma0ZxUi95WWtRUWVvdy9zeUQ2N2VlMkFKNTdTVi9K?=
 =?utf-8?B?b0hwK1Y2WWxCVmcrNkdLT0RTTElBOXcydDFLWHVKdlVYQ05TR0VPOXpWbGtB?=
 =?utf-8?B?UW9pT1k0VmRCMlk1M29qaVdVWGRKalZHVEZMRjk0V2xweUdzWnpGMy9UU0N4?=
 =?utf-8?B?N3pMZzhOZ3Nyb0sxVXg4L2pQUGN2eVlYOWxqQ0psVXNJNVBIcGxmNjJGY2sz?=
 =?utf-8?B?dFRNQVI3NDJvbyt0ajAxWkJKYTdDUXZndVRRcWhWajVpY1h1bkh5R0s1N0FH?=
 =?utf-8?B?SUtZa0xBcWIrNVhCcjRUZlRtT3A0dFFhNjk5cTV6azM2VTdiN2d4Vld3YVBy?=
 =?utf-8?B?b1phS3kzdnB3ZHBKWkxETGhPYzZhb0M0NnF5cVVsZXVHLzVCMS82RDVCbDVR?=
 =?utf-8?B?UG1ucjNqTUUzRmJhWHlGQ1BNemc5eHU2L2VTckhtZVVnVW8yVHA1RDFBdlZz?=
 =?utf-8?B?NW5ENUszdkdEd3RLc0lJSVpQSi8ydHE4YU9yVzI1OWlpdWg4WWdEV3NJdWVm?=
 =?utf-8?B?QlRuZytJUkVRT1NwSnlsWndjR1BnY2tnZDVXYjRsWkg0WU9yVnByK3pqemFm?=
 =?utf-8?B?aEhYNUw1NVc2TmF2bEpFYml6ODZseTl4TGN6aXppc3RzZzkvVmlZeGFRZ0dp?=
 =?utf-8?Q?ciJM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4258.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72f85f5f-4b78-4a8b-c2c8-08ddcb698a82
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2025 10:53:51.2017
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I90u7860Rbku00DLPHhhNaJC+w0SxeSh+N8dp64lNaBxxSuL+ejyzmoXLiRqa5Ax6qGLn8azV9iSfSPoWEC9iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4400

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KSGkgQWRyaWFuLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEFk
cmlhbiBIdW50ZXIgPGFkcmlhbi5odW50ZXJAaW50ZWwuY29tPg0KPiBTZW50OiBGcmlkYXksIEp1
bHkgMjUsIDIwMjUgMTo0NSBQTQ0KPiBUbzogUG90dGh1cmksIFNhaSBLcmlzaG5hIDxzYWkua3Jp
c2huYS5wb3R0aHVyaUBhbWQuY29tPjsgU2ltZWssIE1pY2hhbA0KPiA8bWljaGFsLnNpbWVrQGFt
ZC5jb20+OyBVbGYgSGFuc3NvbiA8dWxmLmhhbnNzb25AbGluYXJvLm9yZz4NCj4gQ2M6IGxpbnV4
LW1tY0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9y
ZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGdpdCAoQU1ELVhpbGlueCkgPGdp
dEBhbWQuY29tPjsNCj4gc2Fpa3Jpc2huYTEyNDY4QGdtYWlsLmNvbQ0KPiBTdWJqZWN0OiBSZTog
W1BBVENIXSBtbWM6IHNkaGNpLW9mLWFyYXNhbjogRW5zdXJlIENEIGxvZ2ljIHN0YWJpbGl6YXRp
b24gYmVmb3JlDQo+IHBvd2VyLXVwDQo+DQo+IE9uIDI1LzA3LzIwMjUgMDg6NDksIFBvdHRodXJp
LCBTYWkgS3Jpc2huYSB3cm90ZToNCj4gPiBbUHVibGljXQ0KPiA+DQo+ID4gSGkgQWRyaWFuLA0K
PiA+DQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+IEZyb206IEFkcmlhbiBI
dW50ZXIgPGFkcmlhbi5odW50ZXJAaW50ZWwuY29tPg0KPiA+PiBTZW50OiBUaHVyc2RheSwgSnVs
eSAyNCwgMjAyNSA5OjUwIFBNDQo+ID4+IFRvOiBQb3R0aHVyaSwgU2FpIEtyaXNobmEgPHNhaS5r
cmlzaG5hLnBvdHRodXJpQGFtZC5jb20+OyBTaW1laywNCj4gPj4gTWljaGFsIDxtaWNoYWwuc2lt
ZWtAYW1kLmNvbT47IFVsZiBIYW5zc29uIDx1bGYuaGFuc3NvbkBsaW5hcm8ub3JnPg0KPiA+PiBD
YzogbGludXgtbW1jQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZy
YWRlYWQub3JnOw0KPiA+PiBsaW51eC0ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgZ2l0IChBTUQt
WGlsaW54KSA8Z2l0QGFtZC5jb20+Ow0KPiA+PiBzYWlrcmlzaG5hMTI0NjhAZ21haWwuY29tDQo+
ID4+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIG1tYzogc2RoY2ktb2YtYXJhc2FuOiBFbnN1cmUgQ0Qg
bG9naWMNCj4gPj4gc3RhYmlsaXphdGlvbiBiZWZvcmUgcG93ZXItdXANCj4gPj4NCj4gPj4gT24g
MjEvMDcvMjAyNSAxMjo1MywgU2FpIEtyaXNobmEgUG90dGh1cmkgd3JvdGU6DQo+ID4+PiBEdXJp
bmcgU0Qgc3VzcGVuZC9yZXN1bWUgd2l0aG91dCBhIGZ1bGwgY2FyZCByZXNjYW4gKHdoZW4gdXNp
bmcNCj4gPj4+IG5vbi1yZW1vdmFibGUgU0QgY2FyZHMgZm9yIHJvb3RmcyksIHRoZSBTRCBjYXJk
IGluaXRpYWxpemF0aW9uIG1heQ0KPiA+Pj4gZmFpbCBhZnRlciByZXN1bWUuIFRoaXMgb2NjdXJz
IGJlY2F1c2UsIGFmdGVyIGEgaG9zdCBjb250cm9sbGVyDQo+ID4+PiByZXNldCwgdGhlIGNhcmQg
ZGV0ZWN0IGxvZ2ljIG1heSB0YWtlIHRpbWUgdG8gc3RhYmlsaXplIGR1ZSB0byBkZWJvdW5jZSBs
b2dpYy4NCj4gPj4+IFdpdGhvdXQgd2FpdGluZyBmb3Igc3RhYmlsaXphdGlvbiwgdGhlIGhvc3Qg
bWF5IGF0dGVtcHQgcG93ZXJpbmcgdXANCj4gPj4+IHRoZSBjYXJkIHByZW1hdHVyZWx5LCBsZWFk
aW5nIHRvIGNvbW1hbmQgdGltZW91dHMgZHVyaW5nIHJlc3VtZSBmbG93Lg0KPiA+Pj4gQWRkIHNk
aGNpX2FyYXNhbl9zZXRfcG93ZXJfYW5kX2J1c192b2x0YWdlKCkgdG8gd2FpdCBmb3IgdGhlIGNh
cmQNCj4gPj4+IGRldGVjdCBzdGFibGUgYml0IGJlZm9yZSBwb3dlciB1cCB0aGUgY2FyZC4gU2lu
Y2UgdGhlIHN0YWJpbGl6YXRpb24NCj4gPj4+IHRpbWUgaXMgbm90IGZpeGVkLCBhIG1heGltdW0g
dGltZW91dCBvZiBvbmUgc2Vjb25kIGlzIHVzZWQgdG8gZW5zdXJlDQo+ID4+PiBzdWZmaWNpZW50
IHdhaXQgdGltZSBmb3IgdGhlIGNhcmQgZGV0ZWN0IHNpZ25hbCB0byBzdGFiaWxpemUuDQo+ID4+
Pg0KPiA+Pj4gU2lnbmVkLW9mZi1ieTogU2FpIEtyaXNobmEgUG90dGh1cmkgPHNhaS5rcmlzaG5h
LnBvdHRodXJpQGFtZC5jb20+DQo+ID4+PiAtLS0NCj4gPj4+ICBkcml2ZXJzL21tYy9ob3N0L3Nk
aGNpLW9mLWFyYXNhbi5jIHwgMjQgKysrKysrKysrKysrKysrKysrKysrKy0tDQo+ID4+PiAgMSBm
aWxlIGNoYW5nZWQsIDIyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4+Pg0KPiA+
Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktb2YtYXJhc2FuLmMNCj4gPj4+
IGIvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1vZi1hcmFzYW4uYw0KPiA+Pj4gaW5kZXggNDI4Nzg0
NzRlNTZlLi4zY2U1NTAwOWJhNGEgMTAwNjQ0DQo+ID4+PiAtLS0gYS9kcml2ZXJzL21tYy9ob3N0
L3NkaGNpLW9mLWFyYXNhbi5jDQo+ID4+PiArKysgYi9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLW9m
LWFyYXNhbi5jDQo+ID4+PiBAQCAtOTksNiArOTksOSBAQA0KPiA+Pj4gICNkZWZpbmUgSElXT1JE
X1VQREFURSh2YWwsIG1hc2ssIHNoaWZ0KSBcDQo+ID4+PiAgICAgICAgICAgICAoKHZhbCkgPDwg
KHNoaWZ0KSB8IChtYXNrKSA8PCAoKHNoaWZ0KSArIDE2KSkNCj4gPj4+DQo+ID4+PiArI2RlZmlu
ZSBDRF9TVEFCTEVfVElNRU9VVF9VUyAgICAgICAgICAgICAgIDEwMDAwMDANCj4gPj4+ICsjZGVm
aW5lIENEX1NUQUJMRV9NQVhfU0xFRVBfVVMgICAgICAgICAgICAgMTANCj4gPj4+ICsNCj4gPj4+
ICAvKioNCj4gPj4+ICAgKiBzdHJ1Y3Qgc2RoY2lfYXJhc2FuX3NvY19jdGxfZmllbGQgLSBGaWVs
ZCB1c2VkIGluDQo+IHNkaGNpX2FyYXNhbl9zb2NfY3RsX21hcA0KPiA+Pj4gICAqDQo+ID4+PiBA
QCAtNTE0LDYgKzUxNywyMyBAQCBzdGF0aWMgaW50IHNkaGNpX2FyYXNhbl92b2x0YWdlX3N3aXRj
aChzdHJ1Y3QNCj4gPj4gbW1jX2hvc3QgKm1tYywNCj4gPj4+ICAgICByZXR1cm4gLUVJTlZBTDsN
Cj4gPj4+ICB9DQo+ID4+Pg0KPiA+Pj4gK3N0YXRpYyB2b2lkIHNkaGNpX2FyYXNhbl9zZXRfcG93
ZXJfYW5kX2J1c192b2x0YWdlKHN0cnVjdA0KPiA+Pj4gK3NkaGNpX2hvc3QgKmhvc3QsDQo+ID4+
IHVuc2lnbmVkIGNoYXIgbW9kZSwNCj4gPj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgdW5zaWduZWQgc2hvcnQgdmRkKSB7DQo+ID4+PiArICAgdTMyIHJl
ZzsNCj4gPj4+ICsNCj4gPj4+ICsgICAvKg0KPiA+Pj4gKyAgICAqIEVuc3VyZSB0aGF0IHRoZSBj
YXJkIGRldGVjdCBsb2dpYyBoYXMgc3RhYmlsaXplZCBiZWZvcmUNCj4gPj4+ICsgcG93ZXJpbmcg
dXAsIHRoaXMNCj4gPj4gaXMNCj4gPj4+ICsgICAgKiBuZWNlc3NhcnkgYWZ0ZXIgYSBob3N0IGNv
bnRyb2xsZXIgcmVzZXQuDQo+ID4+PiArICAgICovDQo+ID4+PiArICAgaWYgKG1vZGUgPT0gTU1D
X1BPV0VSX1VQKSB7DQo+ID4+PiArICAgICAgICAgICByZWFkbF9wb2xsX3RpbWVvdXQoaG9zdC0+
aW9hZGRyICsgU0RIQ0lfUFJFU0VOVF9TVEFURSwNCj4gPj4+ICsgcmVnLA0KPiA+PiByZWcgJiBT
REhDSV9DRF9TVEFCTEUsDQo+ID4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQ0Rf
U1RBQkxFX01BWF9TTEVFUF9VUywNCj4gPj4gQ0RfU1RBQkxFX1RJTUVPVVRfVVMpOw0KPiA+Pj4g
KyAgIH0NCj4gPj4NCj4gPj4gRG9lc24ndCBuZWVkIHt9DQo+ID4gV2lsbCByZW1vdmUgaW4gdjIu
DQo+DQo+IEFsc28gcHJvYmFibHkgYmV0dGVyIHRvIGFjY2VzcyB0aGUgcmVnaXN0ZXIgaW4gYSBj
b25zaXN0ZW50IG1hbm5lciBpLmUuIHVzZQ0KPiByZWFkX3BvbGxfdGltZW91dChzZGhjaV9yZWFk
bCwuLi4saG9zdCwgU0RIQ0lfUFJFU0VOVF9TVEFURSkNClN1cmUsIEkgd2lsbCB1cGRhdGUuDQo+
DQo+ID4NCj4gPj4NCj4gPj4gV2lsbCB0aGlzIHdvcmsgd2l0aCBhbGwgQXJhc2FuIHZhcmlhbnRz
Pw0KPiA+IFllcywgdGhpcyBpcyBleHBlY3RlZCB0byB3b3JrIGFjcm9zcyBhbGwgQXJhc2FuIHZh
cmlhbnRzIHRoYXQgY29tcGx5DQo+ID4gd2l0aCB0aGUgc3RhbmRhcmQgU0RIQ0kgcmVnaXN0ZXIg
ZGVmaW5pdGlvbnMuIFRoZSBTREhDSV9DRF9TVEFCTEUgYml0DQo+ID4gaXMgZGVmaW5lZCBpbiBi
b3RoIHRoZSBzdGFuZGFyZCBTREhDSSBzcGVjaWZpY2F0aW9uIGFuZCBBcmFzYW4ncyB1c2VyIGd1
aWRlLg0KPiA+IE9uIFhpbGlueC9BTUQgVmVyc2FsIGFuZCBaeW5xTVAgcGxhdGZvcm1zLCB0aGUg
Q0Qgc3RhYmxlIGJpdCBpcw0KPiA+IHR5cGljYWxseSBzZXQgd2l0aGluIGEgZmV3IG1pbGxpc2Vj
b25kcy4gSG93ZXZlciwgdG8gYmUgb24gdGhlIHNhZmVyDQo+ID4gc2lkZSBhbmQgZW5zdXJlIGNv
bXBhdGliaWxpdHkgYWNyb3NzIGFsbCBBcmFzYW4gdmFyaWFudHMsIGEgdGltZW91dCBvZiAxIHNl
Y29uZCBpcw0KPiBhZGRlZC4NCj4NCj4gQSBsb3dlciB0aW1lb3V0IHdvdWxkIGhhdmUgbGVzcyBp
c3N1ZSBpZiB0aGVyZSB3ZXJlIGRldmljZXMgdGhhdCBkaWQgbm90IGhhdmUNCj4gc3RhbmRhcmQg
Q0Qgc3RhYmxlIGJpdCBiZWhhdmlvdXIuDQo+DQo+ID4gUGxlYXNlIGxldCBtZSBrbm93IGlmIHlv
dSBwcmVmZXIgdG8gaW5jcmVhc2UgdGhlIHRpbWVvdXQgb3IgaWYgdGhpcw0KPiA+IGxvZ2ljIHNo
b3VsZCBiZSBlbmFibGVkIGJ5IGEgcGxhdGZvcm0gc3BlY2lmaWMgcXVpcmsuDQo+DQo+IElmIHlv
dSBhcmUgMTAwJSBjb25maWRlbnQgaXQgd29uJ3QgbmVnYXRpdmVseSBhZmZlY3Qgb3RoZXIgZGV2
aWNlcywgdGhlbiBpdCBpcyBPSy4NCj4gT3RoZXJ3aXNlIGl0IGlzIGJldHRlciBhcyBhIHF1aXJr
Lg0KRm9yIHRoZSBkZXZpY2VzIHRoYXQgZGlkbid0IGhhdmUgb3IgYnJva2VuIENEIHN0YWJsZSBi
ZWhhdmlvciB0aGVuIHRoZXkgbWlnaHQgc2VlDQppbmNyZWFzZSBpbiB0aGUgaW5pdGlhbGl6YXRp
b24gdGltZSB0aGF0IGlzIHRoZSBvbmx5IGltcGFjdCBJIGNhbiBzZWUuDQpNYXkgYmUgYmV0dGVy
IEkgd2lsbCBlbmFibGUgdGhlIGxvZ2ljIHVzaW5nIHBsYXRmb3JtIHNwZWNpZmljIHF1aXJrLCBz
byB0aGF0IG90aGVyDQpkZXZpY2VzIHdpbGwgaGF2ZSB6ZXJvIGltcGFjdCBhbmQgd2hvZXZlciBu
ZWVkcyBpdCB0aGV5IHdpbGwgZGVmaW5lIHRoZSBxdWlyay4NCg0KUmVnYXJkcw0KU2FpIEtyaXNo
bmENCg0KPg0KPiA+DQo+ID4gUmVnYXJkcw0KPiA+IFNhaSBLcmlzaG5hDQo+ID4NCj4gPj4NCj4g
Pj4+ICsNCj4gPj4+ICsgICBzZGhjaV9zZXRfcG93ZXJfYW5kX2J1c192b2x0YWdlKGhvc3QsIG1v
ZGUsIHZkZCk7IH0NCj4gPj4+ICsNCj4gPj4+ICBzdGF0aWMgY29uc3Qgc3RydWN0IHNkaGNpX29w
cyBzZGhjaV9hcmFzYW5fb3BzID0gew0KPiA+Pj4gICAgIC5zZXRfY2xvY2sgPSBzZGhjaV9hcmFz
YW5fc2V0X2Nsb2NrLA0KPiA+Pj4gICAgIC5nZXRfbWF4X2Nsb2NrID0gc2RoY2lfcGx0Zm1fY2xr
X2dldF9tYXhfY2xvY2ssIEBAIC01MjEsNyArNTQxLDcNCj4gPj4gQEANCj4gPj4+IHN0YXRpYyBj
b25zdCBzdHJ1Y3Qgc2RoY2lfb3BzIHNkaGNpX2FyYXNhbl9vcHMgPSB7DQo+ID4+PiAgICAgLnNl
dF9idXNfd2lkdGggPSBzZGhjaV9zZXRfYnVzX3dpZHRoLA0KPiA+Pj4gICAgIC5yZXNldCA9IHNk
aGNpX2FyYXNhbl9yZXNldCwNCj4gPj4+ICAgICAuc2V0X3Voc19zaWduYWxpbmcgPSBzZGhjaV9z
ZXRfdWhzX3NpZ25hbGluZywNCj4gPj4+IC0gICAuc2V0X3Bvd2VyID0gc2RoY2lfc2V0X3Bvd2Vy
X2FuZF9idXNfdm9sdGFnZSwNCj4gPj4+ICsgICAuc2V0X3Bvd2VyID0gc2RoY2lfYXJhc2FuX3Nl
dF9wb3dlcl9hbmRfYnVzX3ZvbHRhZ2UsDQo+ID4+PiAgICAgLmh3X3Jlc2V0ID0gc2RoY2lfYXJh
c2FuX2h3X3Jlc2V0LCAgfTsNCj4gPj4+DQo+ID4+PiBAQCAtNTcwLDcgKzU5MCw3IEBAIHN0YXRp
YyBjb25zdCBzdHJ1Y3Qgc2RoY2lfb3BzIHNkaGNpX2FyYXNhbl9jcWVfb3BzDQo+ID0gew0KPiA+
Pj4gICAgIC5zZXRfYnVzX3dpZHRoID0gc2RoY2lfc2V0X2J1c193aWR0aCwNCj4gPj4+ICAgICAu
cmVzZXQgPSBzZGhjaV9hcmFzYW5fcmVzZXQsDQo+ID4+PiAgICAgLnNldF91aHNfc2lnbmFsaW5n
ID0gc2RoY2lfc2V0X3Voc19zaWduYWxpbmcsDQo+ID4+PiAtICAgLnNldF9wb3dlciA9IHNkaGNp
X3NldF9wb3dlcl9hbmRfYnVzX3ZvbHRhZ2UsDQo+ID4+PiArICAgLnNldF9wb3dlciA9IHNkaGNp
X2FyYXNhbl9zZXRfcG93ZXJfYW5kX2J1c192b2x0YWdlLA0KPiA+Pj4gICAgIC5pcnEgPSBzZGhj
aV9hcmFzYW5fY3FoY2lfaXJxLA0KPiA+Pj4gIH07DQo+ID4+Pg0KPiA+DQoNCg==
