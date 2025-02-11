Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B53253B43;
	Tue, 11 Feb 2025 18:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739299179; cv=fail; b=oEeOufX0fwaDp2VMiO1wntSp3HcWW+0u2k8Sr6GG4s8YqtUjaD8weLXbKCnpEKAC+AuzhD6Ed1SQgaxVc08FCIucypF+3qlbSZh2optKH19jjyqieIFfZF6k5/tQ2pnMxTgtGVb5H3oI8vrh/izir5OoHZbKKVxMZwR89H5uWtg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739299179; c=relaxed/simple;
	bh=KpC//iipbEDiJ7D31bmCd4Edl6ZCIuDcYPPr+syqGDc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=d0oijvcOh8N3BnEskkeXyNIhXOBqVrrMfzaehb3FchF6RYi65egLU0Z3bcxhvXGR+lN+B2BhJCBR3ULuzPKLqbbvaghEAUXQBRpJYBrZB4n8dwS4IiPxUbXdqhYILdqQwS3i5C1gacdZXKKlJMdWHnxsUQanFCb1nnfS0oCOpeg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=pcVv4zlM; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="pcVv4zlM"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkim.sandisk.com; t=1739299177; x=1770835177;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KpC//iipbEDiJ7D31bmCd4Edl6ZCIuDcYPPr+syqGDc=;
  b=pcVv4zlMVAPI1cOzNkvA/KWw8+YHQNhkAfAvAWDp8OlwHMtPKtfqd/ch
   7d55B6l1KNkIUQCFEKXE1i0/9uZv6zSTZNA3kalgxdYDV3KbZPQjiNAIv
   slWWS+RIX8h8fT9uYmuQuWAejIUS3dtRcBLbSMqkTQxnOYbVxuxhjAbYV
   giaCsjUl0u3Fx8xWrkKLUhWDpvnuDOKvQ6QOIRGGkyBiyYYabIbv5lFA/
   JGsYH6frXm+gK5y5T8fUeOmllX5MzdfNvyQVzimOFedq3tPPTfCZY178E
   NZz2/9Sp1JGEp2S7XGyjQj7vDdt9MBJJviQ9cYVZU+W2cDO0/R/NtammP
   A==;
X-CSE-ConnectionGUID: gxnjPJIzTz6U0gHhNeaWWA==
X-CSE-MsgGUID: LpmNg2ZuS/+3raQAtFgp0w==
X-IronPort-AV: E=Sophos;i="6.13,278,1732550400"; 
   d="scan'208";a="38781570"
Received: from mail-mw2nam12lp2042.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.42])
  by ob1.hgst.iphmx.com with ESMTP; 12 Feb 2025 02:39:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=koQ3CuEUyrRlojbULmBN5mbx7DjyFZ0U6lRycZO2QTAx72DTsolqtIug4cdJOAqNO3KT9wC5K51jppvk0hRIW9O1MOEEs8P2qEXBooC4K9Co76uMX96etFSvSILwtyg0SJM9OsjgEl9JT+DFfezM85VmiKVW73H8JbU15JMdwnjFQw2mY0ShVtAc1GOT9QEGB09HWkRthLFCKw5PyiGrk/BMFHcclKlhFZUpYEQ/0c4CUUEVEQMFWP4VjVMjInb/YMF0QjS89r6M7nXKwFQZg2ZqibH3cjPzYIm8/Tk3hhvZ7uRX4xoT+z+pbfu9V42A93KkgTa/bm1ZEnBzE6KBPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KpC//iipbEDiJ7D31bmCd4Edl6ZCIuDcYPPr+syqGDc=;
 b=iMve9dW1nVAFWv3tV6kqhMysrRxWLvow0sNPT4k8Rk4A96+c1fRObpUCnzmDIFflo7S2hChQIoAVGfEK1miNtoZFZqf6RO8OxshNvA/stdyCAhSMDqTki9AvtRCjUmUo6dMjLzLg+BnAXWCkBmgNYpT9myBXPYRf/bNLeJ3Etua47OQGB1WAspK9WMWq02ytL3w1nXrNuHVwAV9oGrNEkcdRvbW4W/pNAIPVmM4SnTBneauXDcVdpZuZxhHuFQkYwZT5VKZxjJD93yHfhc001DXWzU7C/MkCMYHo7CiBvtr89jMyRETk/EUOSEZTjBo1Zo0BamHw4ijJ18y6FRXMPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sandisk.com; dmarc=pass action=none header.from=sandisk.com;
 dkim=pass header.d=sandisk.com; arc=none
Received: from PH7PR16MB6196.namprd16.prod.outlook.com (2603:10b6:510:312::5)
 by SA1PR16MB6058.namprd16.prod.outlook.com (2603:10b6:806:3ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Tue, 11 Feb
 2025 18:39:26 +0000
Received: from PH7PR16MB6196.namprd16.prod.outlook.com
 ([fe80::e087:8329:baea:5808]) by PH7PR16MB6196.namprd16.prod.outlook.com
 ([fe80::e087:8329:baea:5808%7]) with mapi id 15.20.8422.015; Tue, 11 Feb 2025
 18:39:25 +0000
From: Avri Altman <Avri.Altman@sandisk.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>, Ulf Hansson
	<ulf.hansson@linaro.org>, Kamal Dasu <kamal.dasu@broadcom.com>, Jens
 Wiklander <jens.wiklander@linaro.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "adrian.hunter@intel.com"
	<adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "wsa+renesas@sang-engineering.com"
	<wsa+renesas@sang-engineering.com>, "f.fainelli@gmail.com"
	<f.fainelli@gmail.com>, "bcm-kernel-feedback-list@broadcom.com"
	<bcm-kernel-feedback-list@broadcom.com>
Subject: RE: [PATCH RFC 0/3] mmc: sdhci-brcmstb: Add rpmb sharing support
Thread-Topic: [PATCH RFC 0/3] mmc: sdhci-brcmstb: Add rpmb sharing support
Thread-Index: AQHbe96hg6lVP+XIuES1HZwNeWffYLNBwQAwgACUioCAABrWQA==
Date: Tue, 11 Feb 2025 18:39:25 +0000
Message-ID:
 <PH7PR16MB6196A1AB0472684F9A234C55E5FD2@PH7PR16MB6196.namprd16.prod.outlook.com>
References: <20250206220940.10553-1-kamal.dasu@broadcom.com>
 <CAPDyKFq1ZbP4c9ECfM1SY+MEopf+dC19w9PkqXaUjevf=bPjcw@mail.gmail.com>
 <115a59e1-75b2-4d09-bbf9-50dfcd2b62dd@broadcom.com>
 <PH7PR16MB61967C18645C64E582B222B6E5FD2@PH7PR16MB6196.namprd16.prod.outlook.com>
 <d51a9d7a-b942-4c3b-93d2-65b1bb04c8da@broadcom.com>
In-Reply-To: <d51a9d7a-b942-4c3b-93d2-65b1bb04c8da@broadcom.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sandisk.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR16MB6196:EE_|SA1PR16MB6058:EE_
x-ms-office365-filtering-correlation-id: 6232cd79-789c-430e-40c3-08dd4acb690f
wdcipoutbound: EOP-TRUE
wdcip_bypass_spam_filter_specific_domain_inbound: TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?R2l1S0JQejdDd25uUHhhMm8yYVp3UDdxdUFCVTlQdGJBUmNwdWRUOE04YW1S?=
 =?utf-8?B?enJjMDZOa0pKdTlPa2hoQnpQR1NoVUM4NzRBZmtkbHRhMDFVMUFXemFvbDdm?=
 =?utf-8?B?MHFLbUZ2SktmTkZCMk1SUmk2cHBHYSsrQ3JzeGVBNkZEWnVUOWIyL3puMFVi?=
 =?utf-8?B?NWl0R3RMRHdCNVRZYzUvZDB3cmtNOHBVYjBEbGFBbXhOaW44NXJtbVoyWkYw?=
 =?utf-8?B?SkRDQk1wbm83UmsxY3NONW92R3k5Y0pwSVNQUlRaN2RUUjY1eDNOMER4ZlVY?=
 =?utf-8?B?dmkvNEZwemQvaUxqL3o4SnFKZ21MSzJuSlQ5VHJueUxtSzZFOHBXdThMRFh5?=
 =?utf-8?B?QnpzTkNUdjFCd2FpeXNkbjhmbitEbUVDOHhhMytYRUw5dFpPdmx5SitYd21a?=
 =?utf-8?B?RlE5bmRXV1M1bXZ4bkMwOVQ5UnZmVEV6eWVCMXFZVnpYdnlmRGd5eU1WNlVH?=
 =?utf-8?B?LzhBUjVJSkJGb1dLMHNUd00rbEJJR2JPSUg3bncvQUdTREY1d2locFNETm5Q?=
 =?utf-8?B?ZTFkaUhhZkt2TVVqVFVKSXBGcW5ocENNN1NFZUIxSEk0Z1Y5MWQ0cG9yTTMv?=
 =?utf-8?B?NmRHdis3anRsMytPODdnTnpoU1R5Qm9aNG5DR3BiMjVjUWttc1lQcjIxeVB3?=
 =?utf-8?B?aUVCcitPNEpDRzE5U0FiUDZEaHdUS083ZXRudXZ2OHlUMUJTaVMxM05PWmdO?=
 =?utf-8?B?UytKOVZ2bzR5WDMyVTZmNmJEUG9zaGZwaW9GaFEyazA0RE8xTmx1OTBxN1Rx?=
 =?utf-8?B?Ump1bkJsaGtiTFNHQStXVkppbDBnc3NxNW5Vb1hJWE1LVzNFenRjb2pPdzlZ?=
 =?utf-8?B?R3ZGL1Q2QVFQMFg3bXJXSDB2ZTkrMXU2RjhRN2hJb1JKckQ1RVVrZEZub1Qy?=
 =?utf-8?B?TWh3SFNoamxSL0VzeUJMWjY1VVRnaHRXeEJjZThKczVHcVlHQWFQZTdwb1RT?=
 =?utf-8?B?anhwM0N0K1phQTVSOW1BbzlLOVo5SVdJWnpBV0Z3UjZvZjZtL01Kc05GRVk0?=
 =?utf-8?B?alBrcFA4SkYwYjdHYjZ5dHBZU0tVdWZRdVJ5djJZRDFrT0Rxdi8vUkVKZWNm?=
 =?utf-8?B?VURveFJnMHFpS09ndzRidFNlN1cxbk9FdWZ3VmxnRGNHQmxMSmJORnNPelZo?=
 =?utf-8?B?UTlpc2ZvQkxOY1JwWXU0QUd2QnNlUnBJSVJ4Z3ZKa3BDUzZzZlgxMDA3ZU9q?=
 =?utf-8?B?ME9zSlY4ZW5aSG5FVlNwN1RRM0hiL0l3TW9rL1VrUWwrdEtKMEE2dVNDSmc5?=
 =?utf-8?B?VlhJa3k3L3o2N3dscnA4M1l4OXpkSktXNUNIUlVoVy84M00wM0RiWG1tU2hv?=
 =?utf-8?B?Z1hhZUFqclBjQllGVFdDVkFYN0hGd3I5bWNVc3o5ZVdGYmEyRVd4aVkzU2tO?=
 =?utf-8?B?OFEwMGQwS1B3QkxONjVxQk13b1M0UThTQWFJNmxqNCthajEyNWJQdnhDcnND?=
 =?utf-8?B?VkFETXFnMnFWMmtVR0d0V1FlRndRWjNOTWtwbzJhRzZUUWg2OWoyakRVSHRa?=
 =?utf-8?B?OGNqdncxS2QrMHlzd0hWbkhTNmFuMkJEUEhEUzBON1NRWENGMGNrbnl4OWQ3?=
 =?utf-8?B?TGFndjFyMkJiTUJhWDlna1VaN2FLNHFUVyt4KzlSTFUvMnlkR2dERWRqS0dG?=
 =?utf-8?B?UThIcGhJb3F3MjN2NVdZc2R1VHZPbXZBNkhZaitNTXdWRXhoQ3hBbzlWNGhP?=
 =?utf-8?B?QmtBbUk2NkhLNUlqNU5zNFNwUGxBeTU1RWp1bThUbjRLeHNMZDNxb0ZvQ0o1?=
 =?utf-8?B?OXBnWHNMck9MZEhqZDdMOHN6ZkRYT1ZrYzlFNjBZQUxEVXlZaGlYei9uOFFU?=
 =?utf-8?B?c09XOUdVNXRVeGtCenJNZVVKY0JrbUl1blF3SmxSYWVvbFpkd3V4ZUQ1cGlP?=
 =?utf-8?B?R1hrS05ka01MWVd6TkVUUXc5NjBBVk1OSEM4R3N5YzdUajY4aU1KS2k4cXZ4?=
 =?utf-8?Q?58wzec33ijXTWpmBheBqvbvY5Tp9o37o?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR16MB6196.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NFJ1bERLQUc5UUtSYXNFMDhhRzFHMWozY29pdVpxSnVMTnREZ2ZBS1ZpbVFC?=
 =?utf-8?B?eGJCMjVFaTBUeFRsc2ZPT240clN5NDhTQXc3blI0bElidGhkYTVSbmV3dERw?=
 =?utf-8?B?QTRrd0hqS0ZBdmN3TS93OUZiVlNXU21YZ2xyTWtZQkxrRnlvTFJNREQ1ZlQx?=
 =?utf-8?B?bUpVNzM3RHMxZDBzL3ZVR2ozd3dXMGN4U1NaN2psMmphaStZYkVFZGlLVUpM?=
 =?utf-8?B?MVJjMmRxa0hhVXZkS3k5bVhGalNJWGk5MCtlOVRrMy95eU1NM3NwUWNhbW1E?=
 =?utf-8?B?UG1pcnJIRXJ0WWhrMmNNb2N0aHdpVXlBODBqWW4vV1ZFamd3MWVackNONDY1?=
 =?utf-8?B?cjZyQVB2TEU2T000UFY2T25UaVdKNXFqamN6b1FReFRWRDdwTUpsRExnS2dm?=
 =?utf-8?B?YTVhOTdTallaOXRwekhKSmV3bkRtSUppK0RLZjAxMHNOWmtDSFg0T1hOb1Nq?=
 =?utf-8?B?ZDJZVlUvaXZ6Q2dITmRQK0Y2cVlnTTNvYlpoNFFTMEViVVpMektVeVhOemI5?=
 =?utf-8?B?dXhKbWhzZjNKaThpMzIyOUhxalBBZThFMlZlSWlhS0h6OFlLN2FONG5TVGRr?=
 =?utf-8?B?NGJ4Ulh2dUtPcVVqVzltcTB0WmdITHhXemJ6Tnd1T0hxa1Z2N2hBWE8vYTFy?=
 =?utf-8?B?QlF0Y1dmSms2SFRMZkpNNlJXZ3hxT3FZQmhoZVZ2YlhwUnVTeGoxTmdSaUlq?=
 =?utf-8?B?T0NZUUNScU9QWlNaOGZTWlloUEpDWEpUL3YvZFVCaWxtUHpLWTJSRWVWelhj?=
 =?utf-8?B?TnlSWHFKS09UTjQrTm9XbzVKV0UxVldNRkl2bUZ6bkUwV0hBRU9rT25YMjRG?=
 =?utf-8?B?TDJkbGZXazhyTDNhYlVvZ2F2RUZ0cUhtVWFtMFhOODYxTms3NTYyMUwyWSt4?=
 =?utf-8?B?dmJZTG16UmtNSDcwR011NjdzQmNNK0dYeG5jMkR2eFRrc25CVWpscXJxWk5k?=
 =?utf-8?B?S3crV3ZsV2FIMHBjMjZGcnY0R0NXLytTTXQzZllIdzFvb05zczEwd2FkTnVE?=
 =?utf-8?B?a2VaaUNIRkZjV1Yrdk9Eakl6UG1BOTkxTzkwUU5QN1hnZ0RIcG9uM2RDVVZy?=
 =?utf-8?B?ZFpGN0hMdzd2elVvM09OeGxXdXVmSE1qUzdTOW5nd1lRcjlOeTJsSzJVMUxn?=
 =?utf-8?B?dndGVEM3VkszTjJZUnN6TWxyUk9XbjFQVXgvdDFoWnRkQWlzaUtNb1hmbVI5?=
 =?utf-8?B?THNHQU1aLy8wSEhmS21xdUtkeFFZa01lcEFZcUNrVGhtdGlNb0dMMDV0eGI3?=
 =?utf-8?B?U2RvMWtmRW9WNnIzaFNQeHRpR3ZHVzBtNFI4SUFXQ0hWdXhxaVVkRFFPL1I4?=
 =?utf-8?B?L2FVVkMzaFpLZ0xlamdJZ3h6MUlwZ2VPN3l6TFFjUVRRL3dyRXRadGJyTHRZ?=
 =?utf-8?B?NGNlaFg1M1hMRlBRQlZUMGdseFdUR0loSkphVW5MQTZSZ09POUpPdnRnU2JG?=
 =?utf-8?B?LzRLTm9jYjJuQjBCSGdwRWJnUHI1dk5oSWxJTnBFL1BlZUNQUENWWUhKMU9R?=
 =?utf-8?B?MGlNYkhqOGVyaElpUzlpVi9FNFhNOFdiYkMwemVYRXZRdkh6RytOOFM5dXRi?=
 =?utf-8?B?L2tNaVBGYkpZdmFKdG93Z21FelJtT3R2ZXJ3WjR1blArb1doL3RJVmxCN0Rh?=
 =?utf-8?B?V0x1NjdOcVlpWDMrUWtFTldoUmNzVUl0WmxmWFRhQXBkSEtuY2drNGRUQTJy?=
 =?utf-8?B?aGhMOXRTemJXZ1JUamx6cHVFRlppVFJkYStVbVpDYVdLQkRBVTlRUGJrV21B?=
 =?utf-8?B?RzNBRXZtN2RuejhhY1REZ0pRZ1ZsZURhRHZFbjZWclhtNXlNT2RDWm85ZEZI?=
 =?utf-8?B?Q0ZYcHpHd1grV0xTSWZQRFVNOHh1dWNpNEttSHZoRGdsMS9TeTZGQ0dMK2RD?=
 =?utf-8?B?bmZDa2VwblpUcERLSjV6eTM1NTFaMmllUldQR1cyVmZSWDlISzJBTVU4ejlS?=
 =?utf-8?B?M2ZqemhEU0J0b29wcmRRYTJHQ0I2RjBGTmlyVlRFMVdLWFVsU2tiS1ZiZXM1?=
 =?utf-8?B?ekNnNVNqS2tSVnpzdDRWZ1JIVjE4N1gxZCs3NXFyTXJtU0EyaXdoZkNMcldo?=
 =?utf-8?B?bGVib1NEaE1IT2NuU2doSUtHZ3lybGRrTFA4MDJwUDRWZ2gzWUVKT09EL0lo?=
 =?utf-8?B?d25NMWdSOGpHL00ra2pvekh2L0F3aHdUdzM5eW4rdlFvVXdHcnU2Y1pBTysv?=
 =?utf-8?Q?mdWIEFsp9uzvMTEhABSbDClRWvs85nFHbwI547H7MDes?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Bh832YMkaHzrhQ15YsCsWgNElOp66Mq1xiYDXGZhkvjQFi4jYAbx8zX7+yb87YGYGDm/cHq1NbNd9yHeiX5P/CBXLJeScWGQLpZjVK8rix0sblsySSlvF7Pg82m/5RBZA0PLRBg7CDwEjbZjmuzUZtFg2m3TuY5luVt6eAjs1k1DoYQvRWM/aLu2s8rd98X01tb1dnDYWdAq0Hefx0/KLQzCHnX2P4rVhN8JXTXSGZIh23ZWM05ZImn3aSP4seZGLN8mS/evXFk3xw6//Y9z50ra/Mu61oHnz7IqeOvZjscDBmn3SA+bwOIlvrBe4b3/9ZB7wjTk5OWfS7ARx7BvdFh6sfK70U/Jb0rKq75tac21EHczCn8LKBIio4DUFqLIDb3zzFvyBwTVfj4wYGe7ggR7mp9YbKPTgzp+SYGTFMwbu3wcLicCaWyTR1jm5pkyQY58VRnK0M5uanw+pBkCnUxy79Nd4T2QaD60/PtiSOZdTj6DJld+5uDApkZE84X20/4lf0qldpcqdaNxF4j6FLBkDw9qZiy7tBdPSE/0VZR54dEk9z1NRKqVlLX9yMS6/GjbRoGk+9zxWJALFbq9vZrm0JjaPN+5W2bgZCaK3wh3p28ikmT9Rp/CCl5/KZtnDNdvUeP89VBTf3uMlw0hLA==
X-OriginatorOrg: sandisk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR16MB6196.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6232cd79-789c-430e-40c3-08dd4acb690f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2025 18:39:25.7546
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ffe0ff2-35d0-407e-a107-79fc32e84ec4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rsrwxG/5iu7+9jjR+1hq7cOwFGX1eQxC21aq1hCkYd8A2qZeeh2oQhsMu/XW9iPwhiILdd1Bk9xAzKuKLWSfQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR16MB6058

PiBPbiAyLzExLzI1IDAwOjEzLCBBdnJpIEFsdG1hbiB3cm90ZToNCj4gPj4+PiBUaGlzIHBhdGNo
IHNldCBhZGRzIHN1cHBvcnQgZm9yIEJyb2FkY29tIFRaT1MgdG8gcmVhZCBhbmQgd3JpdGUgdG8N
Cj4gPj4+PiBSUE1CIHBhcnRpdGlvbiB1c2luZyBzeW5jaHJvbml6ZWQgYWNjZXNzIHRvIHRoZSBj
b250cm9sbGVyIGhhcmR3YXJlLg0KPiA+IFByYWN0aWNhbGx5IGl0IGVzdGFibGlzaGVzIGEgY29t
bXVuaWNhdGlvbiBjaGFubmVsIGJldHdlZW4gdGhlIHRydXN0IHpvbmUgYW5kDQo+IHRoZSBob3N0
IGNvbnRyb2xsZXIgcmVnYXJkbGVzcyBvZiB0aGUgcnBtYiBwcm90b2NvbC4NCj4gPiBPciBkaWQg
SSBnZXQgaXQgd3Jvbmc/DQo+IA0KPiBSYXRoZXIgdGhhbiBjb21tdW5pY2F0aW9uIGNoYW5uZWws
IEkgd291bGQgZGVzY3JpYmUgaXQgYXMgYW4gYXJiaXRyYXRpb24gc2NoZW1lDQo+IGJldHdlZW4g
TiBwYXJ0aWNpcGFudHMsIHdpdGggZ3VhcmFudGVlZCBmb3J3YXJkIHByb2dyZXNzIGFuZCBmYWly
bmVzcyBiZXR3ZWVuDQo+IGFsbCBwYXJ0aWNpcGFudHMuDQo+IA0KPiBUaGUgaW50ZXJlc3QgaGVy
ZSBpcyBmb3Igb25lIG9mIHRob3NlIHBhcnRpY2lwYW50cyB0byBvd24gdGhlIGVNTUMgY29udHJv
bGxlciBmb3INCj4gYSBjZXJ0YWluIGFtb3VudCBvZiB0aW1lIGFuZCBpbmRpY2F0ZSB3aGVuIGl0
IGlzIGRvbmUgd2l0aCBpdC4gVGhpcyBpcyBub3Qgc3BlY2lmaWMNCj4gdG8gZU1NQyBhcyB0aGlz
IGNvdWxkIHNjYWxlIHRvIHZpcnR1YWxseSBhbnkgcGllY2Ugb2YgSFcgdGhhdCBpcyBkcml2ZW4g
YnkNCj4gdHJhbnNhY3Rpb25zIGZyb20gYSBDUFUsIGJ1dCB0aGUgbWFpbiBhcHBsaWNhdGlvbiBp
cyBmb3IgYWxsb3dpbmcgdGhlIFRydXN0ZWQgT1MgdG8NCj4gb3duIHRoZSBlTU1DIGNvbnRyb2xs
ZXIgZm9yIGEgc2hvcnQgcGVyaW9kIG9mIHRpbWUgaW4gb3JkZXIgdG8gZG8gaXRzIFJQTUINCj4g
YWNjZXNzLCBhbmQgdGhlbiBnaXZlIGl0IGJhY2sgaW4gdGhlIHNhbWUgc3RhdGUgaXQgZm91bmQg
aXQgdG8gdGhlIG5leHQgcGFydGljaXBhbnQuDQpUaGVuIG1heWJlIGVkaXQgdGhlIHN1YmplY3Qg
YWNjb3JkaW5nbHkgYW5kIGVuY2xvc2UgdGhpcyBleGNlbGxlbnQgZXhwbGFuYXRpb24gaW4gdGhl
IGNvdmVyIGxldHRlci4NCiANClRoYW5rcywNCkF2cmkNCg0KPiAtLQ0KPiBGbG9yaWFuDQo=
