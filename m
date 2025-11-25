Received: from esa.hc6817-7.iphmx.com (esa.hc6817-7.iphmx.com [216.71.152.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4538B322A1C
	for <linux-mmc@vger.kernel.org>; Tue, 25 Nov 2025 14:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.152.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764080548; cv=fail; b=hT+ZbI4wAF6Yrzv7YLPee0L7PUCPDc2MrxvHUH23iqRy4+vR+j6VazOcSJBgtA+sFTWUlvwVt7i8TKNF7kIJstPTfSwa0w0A+rc61XMW5/gifC4dUp4pgenTJ76JYDffUtUK/dMf65pZ4Eo4S3KuA824ho+Qwg8PJJPN8mIUypQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764080548; c=relaxed/simple;
	bh=ZdjjaiZNa5+8j2vYIMGF+fmD8tiuZCIZot0D0XfZDkA=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eSobAQ9YiAeSep1h8YTTc6xbtjyeCamc0osOGJRpuFU6X6ndMdyPdjcdcuvLDq58xWbRVEOQHLld+IXOBFcfYlB8s964WJwEPMWDg8eEMw4WHiIE6W3MRNkrjyiVkfohDt/rLrObv6PZoKd9wBNaQRc1y2iCG33cpJD4in1Wp5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=AU8CEMWz; arc=fail smtp.client-ip=216.71.152.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="AU8CEMWz"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkimnew.sandisk.com; t=1764080546; x=1795616546;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=ZdjjaiZNa5+8j2vYIMGF+fmD8tiuZCIZot0D0XfZDkA=;
  b=AU8CEMWz4ZSVQqOJGVY5GWkMpMRfwf4ZcevI4iyCNlMcqGyWFLH1YWgu
   0IdeFVv3Kcj76QMYUbt2jQ7GUf1b1JGSko/rHPB6F5iH2/aHhIpOgzrk5
   3ysYICwjxOmBjnqGaceuS7cy5+uE8xIx2NveGI/fmpdLW+YKUcgevk1r5
   XVYbqLxVP8XKjMmrw/m7WUN8QfLfYF1zwmytJrgBizA5uUPHrh+9jfS9W
   rw+3qL9FRntUgV5OeQsvgXJ698oIqFzN9CKAsOGkeLIwT9x7p210iaTXJ
   byT1ACP3z7JCdKqIYWVdmFq7kF0l2H15NRpmyuMLo8LjAYSH1VmZc3WIr
   w==;
X-CSE-ConnectionGUID: AyuhZdrRSKmqbqMmnVZuCA==
X-CSE-MsgGUID: bC/5gspQTiq2zu9fGgI/NA==
Received: from mail-southcentralusazon11021110.outbound.protection.outlook.com (HELO SN4PR0501CU005.outbound.protection.outlook.com) ([40.93.194.110])
  by ob1.hc6817-7.iphmx.com with ESMTP; 25 Nov 2025 06:22:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eUvPhO+x3NRHusNRyKK9bYkJ0DHxRCoxQAxz1FmpDPspeDY9fjIdWAeP2O/T8mNm9fYKR1fM6zLS9K9JcIz/S/yTbYvaK3M9bzsv/l009l6LB0aUco7xdt9pN8H3eRbOjxIUu4QVVZZgtvOxJ2g0RZ6bwcwlKAEtRzl1hwF0H1JNBDq47s6rbLM3G3xGJvJeVIFUewWOyefhk5oJruZB1SmzC6YrgGvBS6QkztXbAmg1XCT+plQRLYGc+QXo8ZQa37thZzCP1SZ+byQ4e4DnIgIHors4jVgpkrbbWODX+ehf9O3Uia3Ovq6EEdoLzL/tzvxdypvHTKGOdVIAHpx6TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZdjjaiZNa5+8j2vYIMGF+fmD8tiuZCIZot0D0XfZDkA=;
 b=mb+AMj/KciqsA+m/lCbzg1WvFrMkKHV9ddz+vHKCzXchd8jEBLGwm1z134ot3WE1gAnfljWPtsqJL+Rk5k3gotpdeupjhHZyJVJ1JfCJ9IvGg+26S1DOnEEIGVckppVUvB8pLuhVf7QKX1MkyTEKOzIA3aq5FdtSq6U8YK9SZ3iglQX+3DiLAC1/Zje8YOlo1pruNCnh2m/oAUA7lCk0YG1NFDVdekoaZMylfXfzOswoLQ0hWaYg6mXv1ICRgwFtCAHiIygsjKyOf2BTiGe2Eli47VPhA0iaG0xqH3cqSL3nsNAR8voTljj6aN39poQ996DyPK2+HsnyRqsB2nMDvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sandisk.com; dmarc=pass action=none header.from=sandisk.com;
 dkim=pass header.d=sandisk.com; arc=none
Received: from DS1PR16MB6753.namprd16.prod.outlook.com (2603:10b6:8:1ec::5) by
 SA1PR16MB4834.namprd16.prod.outlook.com (2603:10b6:806:236::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 25 Nov
 2025 14:22:21 +0000
Received: from DS1PR16MB6753.namprd16.prod.outlook.com
 ([fe80::72d7:97b5:4539:a90]) by DS1PR16MB6753.namprd16.prod.outlook.com
 ([fe80::72d7:97b5:4539:a90%5]) with mapi id 15.20.9366.009; Tue, 25 Nov 2025
 14:22:21 +0000
From: Avri Altman <Avri.Altman@sandisk.com>
To: Bean Huo <huobean@gmail.com>, Avri Altman <avri.altman@gmail.com>, Ulf
 Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>
Subject: RE: [PATCH 2/2] mmc: core: Add quirk for broken manufacturing date
Thread-Topic: [PATCH 2/2] mmc: core: Add quirk for broken manufacturing date
Thread-Index: AQHcW35Y+KUsWivi60iGUFRu2uMWZbUDatwAgAAJ0WA=
Date: Tue, 25 Nov 2025 14:22:21 +0000
Message-ID:
 <DS1PR16MB6753397C1F5EF5804509D39EE5D1A@DS1PR16MB6753.namprd16.prod.outlook.com>
References: <20251122070442.111690-1-avri.altman@sandisk.com>
	 <20251122070442.111690-3-avri.altman@sandisk.com>
 <4a9236e8a4172437874291da221ef8b82d4a1126.camel@gmail.com>
In-Reply-To: <4a9236e8a4172437874291da221ef8b82d4a1126.camel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sandisk.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS1PR16MB6753:EE_|SA1PR16MB4834:EE_
x-ms-office365-filtering-correlation-id: 939b4821-fd88-465b-43e7-08de2c2e0be4
x-ms-exchange-atpmessageproperties: SA
sndkipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?eXRUWEUxakk5K1ZPeU9laENlKzRGRUZBQVRScy9QMXRhUG9IT1NrK1loTzZ5?=
 =?utf-8?B?UXNXWHNWcFVibC9ZMGNraXRoa1UxK01vT1V5L0Fwc2Y0Y3VpdHFLZnNZN0lW?=
 =?utf-8?B?MllrYWh3OHlLTVJ6U2NTdVJuSnpESzh5WUd3aFYzWE11bmtEOGFsQ09xVzdL?=
 =?utf-8?B?d0g0TlNSUmsrNWxJb2hPSGN6TzR6T05aTTNYcXFMdWQxQ2dTdEY3aTJVbU1t?=
 =?utf-8?B?UnNJTXZHbDJWU0NXV3dEd2VWQmRIOTczalFVZlRkODFrbUdNUXBYYXFZNGRM?=
 =?utf-8?B?a0JrckFFcjh1RWRBOUhFOEMyWXM4a3loam5OcnV0MkhzZTRJSlhuUzRGV3ZU?=
 =?utf-8?B?TVRqYXB4cTMrNlBXYVZWcVRia0grbTc5QVJsWnptdU5TZGlqTDNJVksrUVhZ?=
 =?utf-8?B?RDBBaUUrejZjYm92TjZBR0ZEZHBndGpzR0dlZ2UwZlp1RjNjakZtU3czL0JM?=
 =?utf-8?B?U0U4ZVVkd09yd2lWdStHZkkzSHd1bWNTSGFnTkRvcGxZeUNrNkJwa0pqZ2Y2?=
 =?utf-8?B?OXNZc3c2V3ZwV3BnV3lLMjFnakN3QjJjVktERlBORUVxM1MyMFJXaXFEYlBT?=
 =?utf-8?B?NGw1clNGVFY4bkJSZ1ZEdElMQlZXN2E2Zjl4UlJwRE5jQUJkcEUyYmY5UnhM?=
 =?utf-8?B?VzArOTd0ZllNQ1RkbjJGZmlwbUtTeGdVZkpJR1lqVUtsbHJZeFJ5dTZYbnNO?=
 =?utf-8?B?ZWtRcDRUZHYrRXo4dFdpSDdVWlN0QjZtNS9vT0VGZmdMcU5GQWRsdkEvUjFC?=
 =?utf-8?B?Rm4rZVhqVHp4U1NZeVBkMWEvb292cTREdlR4MkFoOTBveFdHcUVjN2NQZXBt?=
 =?utf-8?B?b1NHUHZNU1VXai9CUGFFMTlrT1g5bnVRZXdpcmFnYVRzZlpIcXIvMnZLMHhu?=
 =?utf-8?B?a0lBQmM0amtBVmVjcE1mTm1qRVZBVGU0RkJaTzR4QnNnOGttQmhHS1dveWxU?=
 =?utf-8?B?RzBGckNuTUpSaFJvd2VtaVlPOGlZMFFRWWZEUG1PWkNaZGM5NnpUQWNxR2JX?=
 =?utf-8?B?T2krNWZ0UzF3WXRnbU4rNDFrYklySXlDTmRqNzU0RTRpN205dlhCTHpTU3Z0?=
 =?utf-8?B?S2I4WVlQb2ZQMERRS21JMnFYUzJZR0Nha29BY0VjZDA1ODc4dExaSXVaM0Fs?=
 =?utf-8?B?OWc1OVgwYk5qcXB6QWd3UFRQWFdJdjVuV3psbnhCSDFVY0M3UXdLWUQ2YjN5?=
 =?utf-8?B?a1JsQWExWi9XRmhmak9oMyt2WmV1OU42QTAvNmEreU5WYWd1ZW9mRFRwbkF1?=
 =?utf-8?B?OGJvQzA2b2NaOVMrc0NEbWVpMzVNK1VtOWNabkU0eC93NkJnd3M2U3dtSEFx?=
 =?utf-8?B?THBkeDFaYnhWdk02aFpaclA0Ny83OEdTNS9FeGVwUWkzMDg2SExiaGEwSFhs?=
 =?utf-8?B?WWpZcHZJa1lZTzZScXRIWHkrVXRwV2g0RlEwMkg5WTBEL0tNalVraVlMZ2tY?=
 =?utf-8?B?ZGJLdWtXMWhKS0tmajJNWEtuUWdBSHN3T2NqSVcvemptSkFOSEU2VVhyRXBM?=
 =?utf-8?B?a0VhYnhqUkR1N0VkZ090b3RWd2dPRE1OcDlMQ2lPSmFDTGFvbWxVUmJ4VXhh?=
 =?utf-8?B?R3Y1REJSSjVLd0VEZEQ1YlBvTVFuT2VSOFU3emFIQ2dFQkpOaStUWlF5NDVT?=
 =?utf-8?B?ZjF2eGFhdmdtL044cHM1ekRIajdZTy8xa3U1WjVMdFp1Rm1QVWNmalcvNENH?=
 =?utf-8?B?SmNqdm5mcG8wV1BMUTlRQ3lCTUN5aERZczliSmZSYmlZRlF0cXNUcmVhR0dC?=
 =?utf-8?B?aG1rcWQ4MkZkYlB5dWdTZElrcmthWGR0SDNiTktWZVhEQ2U4ZkhCOERrVWEz?=
 =?utf-8?B?Rk9jdU1mcGJDRVMzQ2czZXViNkVBU2NOTDIwRm05WVl4ZWNKUS83cUJXQi9K?=
 =?utf-8?B?WjEyeTIyd2dCVlFTdlhSRnlhN1dyL3Y2cENTcTY4ZU8yQUc1bWI2KzJ0dEdy?=
 =?utf-8?B?UmdhdHFBenBPYlZUSHcwRnA2eGFzeHJydXd5STh3bE1yVEZjZHlTRGV2UGdQ?=
 =?utf-8?B?R1p6Yno5U0t0SG1tamF5MEdhNWhLQkRBOWtDUHB4cmN3NE8vTUNXZ2NSRENS?=
 =?utf-8?Q?Ny80Wu?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS1PR16MB6753.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NmxlVDJrelp6RkZYa0llSkVQZjVEN01DWE5KeWRSazNuR1h5N3EvRWxBbmNB?=
 =?utf-8?B?WnFuV1R4U2piQzI3SS91aG9iRHBXVTNLalh3UDNSWnNMaEZnUEErY1E3WldO?=
 =?utf-8?B?UmUxS1o1YlUxL0lsQi9UcnlPdGZDM0VWbWplNk5zd1JzdDJieEpySzZzVWZO?=
 =?utf-8?B?RlJYcWMyanFsekI1N0dlVVhYVXM2MnI5N3RwaUlBQmQxc2FNc25vbXBZcytB?=
 =?utf-8?B?elEzR2NQSXo4dU81NlFXbzVZaFMyTThiVDVnTjlhdVo2SGROK2JnaDFFd25N?=
 =?utf-8?B?QXNUTVVaaXU1Vm5PMkV1U3plZVh0ekFNak55Z2dwTFo3RjlQeGcxSWFUM2pZ?=
 =?utf-8?B?L0hLRVEvU2hQdGVyRjNieU4ySjY5V0swdjhBK1ZoRWcyUDNnQTFsUmloU2FC?=
 =?utf-8?B?VVhUMm5WZUJnSE5LdHpIajY5eW80QWhnQWNOVjRmWTU1bDRZZWVpUTNhTHRn?=
 =?utf-8?B?MTlaVXVVYWZtcTdNaHRwdHZzOXo0bTA5bi9tdGEwUjZib2RoSHljdVBNUDMy?=
 =?utf-8?B?RFJOdHN4bHlad0RuckcvZndkRk1NT2w5cXpMa2c2MWhzYnA1YmdwbFpkUkh4?=
 =?utf-8?B?bmhBRmJ4SWZDV3h5eWZONkk4MjZSd3o1NGJDOHFHVG5janZKYi8zOU5MQ3Fr?=
 =?utf-8?B?SkNsS3dRaXZaeXBSMDl4aVlMeDlhbE95QXVncjJFa3VRell6VVp1dHdnSmFY?=
 =?utf-8?B?OUJSa21YeXEwZlFMc04yNGMvc2x5Smh5dU5vWktZV1JnQmVWMjBaejlvSkZh?=
 =?utf-8?B?NDluWHJrTzVIS2liMkE5NWN2Znh2d2UwcElBaWtaT0hKWUxnUFpXN09OU24r?=
 =?utf-8?B?VzhxT1FHb2lsQ2VLVUZnZTJLN1pEZTNMZ2tuanYxQW9oM2ZEWWs2YmQwQzg3?=
 =?utf-8?B?YjNmcVZ4RHVkNHRLb0VHbkg0V1FLQTJpdi9iQ1ppNENaS3R0eDdOWUE1SUhJ?=
 =?utf-8?B?dVVrU2lXQks2UFZYaU9adE5oeWtRU0pUQzZ6ejFwOElYa0VkbWlSbldMTk9H?=
 =?utf-8?B?WEQyRWZNMXdqRVFaYnp1Z2ZvdisyMEtncW5iY2FqRWNvMk52MEhjVlBhU3B5?=
 =?utf-8?B?cjhvdDdJR1g1a0hrNnNiNnVEQWIyVDlrY2RYN0twVEp0N3lJRWYzNzVYZTVo?=
 =?utf-8?B?N0dpNFpleTVhclQwaU54YlJPazFtQVFhTmhYZjNLbHVrQ0UzSi8ySkM1cktU?=
 =?utf-8?B?c3hmb1JjclcrWFFFRktKMERUektPMUFaeUVCOE9yUnQ3TU1WUGVUdzNxL21t?=
 =?utf-8?B?Q1p0UXVZNEFWbDgydkpNTTM2a2J4bnpJUmRYY0JpSTBDS2ZnNEMvelVaMHJo?=
 =?utf-8?B?ZU0yWStwZGRjaWlTd2E3dFZMQ2l0ZlZ5aHlCVk84YW9iakdhUnovSFY4emNn?=
 =?utf-8?B?Yzk5bzRaR1hCV09HQVoxTzkyZDR1MTJPMmJENDFvL0J1Rys1aXFDbDBBWVNH?=
 =?utf-8?B?TlhsU2NaU2xydWorM2NUOVFHeEZYMjVVNzlEaDY0cHhwQU1oZkZnTUpSbXI0?=
 =?utf-8?B?N2cyMXYxTFpkNjZlYllueVp5M01qOVN4U2dCazdzOHZCTk0wak12QSs2WmVn?=
 =?utf-8?B?QnVmUHpFcDhrMUovcHRFTWw3THFNM3BwcGhPNEtnOVlheWlyMGlaQ3ZtampD?=
 =?utf-8?B?RmZOcXh5endHTWtJaXd2bHRUeE1JTW1zaGorNFBWRTBvdlRWOXdnNko0djNS?=
 =?utf-8?B?LzRVR3g5TkxQRS9BbHhXRzlvOGNHNy9hOTBwMFlZMjh0TFVpUzFZVmpXUTJx?=
 =?utf-8?B?R2pNNmoxNlZPQVFPVWhTVHpmbDUvb2JpSHo2TjhzcmF4aDRuVWlOR3hqdzRy?=
 =?utf-8?B?M2w2LzJqdDhyQ1AyY0pZaVJ4SnBHbEFPaGg0ajk5d0U5WDFPODRWdkx5eHRr?=
 =?utf-8?B?VGJFQ01kM2c0M3h0SVRZaHQ4QjA2cW9Ud2tCOUFTQ0JhNm1PcnBoVnhJaHNi?=
 =?utf-8?B?YysxVDNLZmZOWkNvSVFCazNJN3VYS2t5MXBsa1VtU2lRRXRjMFh4RklmUTJm?=
 =?utf-8?B?QnZZL2tBbXM0WndjaGJrcThWSGE1VURBeHFzZWVBSG51eGtmd2ZYOWw2c1Va?=
 =?utf-8?B?QkExYmFoT3BjUDdVWkVURGRFamhzNGxjampRbHBnN1BrNzA0Q3NteWZ4dHM1?=
 =?utf-8?Q?W8+rQlrkTYQ/NsVB176/zt9qh?=
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
	tVRCiFMzAfbfXqpMcKDzc14X16xneVGJdNKrDXxWt3ancchDbwDW+Jdb1vZT59/mSzjCqy36jwo6NuT9Fb+krGaE03qhh17uMUmGz5/j6WRV81HXtAd2N/fxJG/pmIKBYE18iY+FPmdH6rpwzrs3988jeAAtus1kfFHhg1ZYPsmz14xDoIYNics3n6O2cMNlaXJeSVPJb/KAg+1vnytuOQ81HyOAOO3+YJhVI6XjNY+YVP88F0t5Hb1Pw/3SP56O97eTfrZLXjsDddikOwgEDqS36EyKOWerA6j4GOeRj+wMsn2T1i+4vo3ngC6zy/1+yXuqBWUCQCiuU1Tvi2ifNRizHsl7yfdhYP/eDkRBOh82fCbCaxJqcVQr31Lopaew2ga/fybmL0hwvC5P2GkXhAvahtSxkmDr1YXBsL8Vh9G5EijfiL7zO1jo2guH75ZYfSh9L4asCx+4P2KUCr4nCu8hRNbpq78kS9LWyn7qJVaJi2oz7Apbk7lY2SPqfslW1yKeTK69sxUC1tTLSYeBPzT19d2ZwLTr24DnHPTYwC5SfFWKwMlneRmzl+wPK+m/MH6f/ORFjgkgw7zyZi4jTBPa0Ab9nyYlorWzZcfwMkyOXYDsW1DopIdfKUyp8AWqvgZOQnN7osUy2Fpx54Q/8w==
X-OriginatorOrg: sandisk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS1PR16MB6753.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 939b4821-fd88-465b-43e7-08de2c2e0be4
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2025 14:22:21.2352
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ffe0ff2-35d0-407e-a107-79fc32e84ec4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8i2+S6fJX3SzxTtN/KIYvhZ2zhBRVl0oYe1PmlerHdPbQRrbFy21mtzfLNo8P5i6DrTfyHss49qgP6xmvRVznA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR16MB4834

PiBBdnJpLA0KPiANCj4gV2XigJlyZSBhd2FyZSBvZiB0aGlzIGlzc3VlIGFuZCBhcHByZWNpYXRl
IHlvdXIgYXR0ZW50aW9uIHRvIGl0LiBIZXJlIGFyZSB0d28NCj4gY29tbWVudHMgcmVnYXJkaW5n
IHRoZSBjaGFuZ2U6DQpUaGFua3MuDQpDYW4geW91IHBsZWFzZSBjb21tZW50IG9uIFNoYXduJ3Mg
cHJvcG9zYWwgdG8gZWxhYm9yYXRlIHRoaXMgcXVpcmsgdG8gZW5hYmxlIGZsYXZvciBwZXIgdmVu
ZG9yPw0KDQo+IA0KPiA+ICBkcml2ZXJzL21tYy9jb3JlL2NhcmQuaCAgIHwgNSArKysrKw0KPiA+
ICBkcml2ZXJzL21tYy9jb3JlL21tYy5jICAgIHwgNyArKysrKystDQo+ID4gIGRyaXZlcnMvbW1j
L2NvcmUvcXVpcmtzLmggfCAzICsrKw0KPiA+ICBpbmNsdWRlL2xpbnV4L21tYy9jYXJkLmggIHwg
MSArDQo+ID4gIDQgZmlsZXMgY2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigt
KQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbW1jL2NvcmUvY2FyZC5oIGIvZHJpdmVy
cy9tbWMvY29yZS9jYXJkLmggaW5kZXgNCj4gPiAxMjAwOTUxYmFiMDguLjBkMTkwNGQ4N2EzOSAx
MDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL21tYy9jb3JlL2NhcmQuaA0KPiA+ICsrKyBiL2RyaXZl
cnMvbW1jL2NvcmUvY2FyZC5oDQo+ID4gQEAgLTMwNSw0ICszMDUsOSBAQCBzdGF0aWMgaW5saW5l
IGludA0KPiA+IG1tY19jYXJkX25vX3Voc19kZHI1MF90dW5pbmcoY29uc3QNCj4gPiBzdHJ1Y3Qg
bW1jX2NhcmQgKmMpDQo+ID4gICAgICAgICByZXR1cm4gYy0+cXVpcmtzICYgTU1DX1FVSVJLX05P
X1VIU19ERFI1MF9UVU5JTkc7ICB9DQo+ID4NCj4gPiArc3RhdGljIGlubGluZSBpbnQgbW1jX2Nh
cmRfYnJva2VuX21kdChjb25zdCBzdHJ1Y3QgbW1jX2NhcmQgKmMpIHsNCj4gPiArICAgICAgIHJl
dHVybiBjLT5xdWlya3MgJiBNTUNfUVVJUktfQlJPS0VOX01EVDsgfQ0KPiA+ICsNCj4gPiAgI2Vu
ZGlmDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbW1jL2NvcmUvbW1jLmMgYi9kcml2ZXJzL21t
Yy9jb3JlL21tYy5jIGluZGV4DQo+ID4gNGMzNjAyOWIyOGEzLi41NjRhNWZiNGRkOTYgMTAwNjQ0
DQo+ID4gLS0tIGEvZHJpdmVycy9tbWMvY29yZS9tbWMuYw0KPiA+ICsrKyBiL2RyaXZlcnMvbW1j
L2NvcmUvbW1jLmMNCj4gPiBAQCAtNjc2LDcgKzY3NiwxMiBAQCBzdGF0aWMgaW50IG1tY19kZWNv
ZGVfZXh0X2NzZChzdHJ1Y3QgbW1jX2NhcmQNCj4gPiAqY2FyZCwgdTgNCj4gPiAqZXh0X2NzZCkN
Cj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAvKiBBZGp1c3QgcHJvZHVjdGlvbiBkYXRlIGFz
IHBlciBKRURFQyBKQzY0LjEgKi8NCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICBpZiAoY2Fy
ZC0+Y2lkLnllYXIgPCAyMDIzKQ0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
Y2FyZC0+Y2lkLnllYXIgKz0gMTY7DQo+ID4gLSAgICAgICAgICAgICAgIH0NCj4gPiArICAgICAg
ICAgICAgICAgfSBlbHNlIHsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgLyogSGFuZGxl
IHZlbmRvcnMgd2l0aCBicm9rZW4gTURUIHJlcG9ydGluZyAqLw0KPiA+ICsgICAgICAgICAgICAg
ICAgICAgICAgICBpZiAobW1jX2NhcmRfYnJva2VuX21kdChjYXJkKSAmJg0KPiA+ICsgY2FyZC0+
Y2lkLnllYXIgPj0NCj4gPiAyMDEwDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAm
JiBjYXJkLT5jaWQueWVhciA8PSAyMDEyKQ0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIGNhcmQtPmNpZC55ZWFyICs9IDE2Ow0KPiANCj4gVGhpcyBvbmx5IGFwcGxpZXMgdG8g
dGhlIGVNTUMgd2l0aCBFWFRfQ1NEIHZlcnNpb24gOD8NCj4gDQo+IGlmIChjYXJkLT5leHRfY3Nk
LnJldiA9PSA4KSB7DQo+ICAgICAgICAgaWYgKG1tY19jYXJkX2Jyb2tlbl9tZHQoY2FyZCkgJiYN
ClRoZSBvdXRlciBjbGF1c2UgKGVNTUMgdjUuMSBvciBsYXRlcikgOg0KaWYgKGNhcmQtPmV4dF9j
c2QucmV2ID49IDgpIHsNCiAgICAgICAgICAgICAgICAgaWYgKGNhcmQtPmV4dF9jc2QucmV2ID49
IDkpIHsNCiAgICAgICAgICAgICAgICAgfSBlbHNlIHstLT4gY2FyZC0+ZXh0X2NzZC5yZXYgPT0g
OA0KICAgICAgICAgICAgICAgICB9DQp9DQoNCj4gDQo+IA0KPiANCj4gPiArICAgICAgICAgICAg
ICAgIH0NCj4gPiAgICAgICAgIH0NCj4gPg0KPiA+ICBvdXQ6DQo+ID4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvbW1jL2NvcmUvcXVpcmtzLmggYi9kcml2ZXJzL21tYy9jb3JlL3F1aXJrcy5oDQo+ID4g
aW5kZXggYzQxN2VkMzRjMDU3Li43YmZkMDdhZDNkN2QgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVy
cy9tbWMvY29yZS9xdWlya3MuaA0KPiA+ICsrKyBiL2RyaXZlcnMvbW1jL2NvcmUvcXVpcmtzLmgN
Cj4gPiBAQCAtMTUzLDYgKzE1Myw5IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbW1jX2ZpeHVwIF9f
bWF5YmVfdW51c2VkDQo+ID4gbW1jX2Jsa19maXh1cHNbXSA9IHsNCj4gPiAgICAgICAgIE1NQ19G
SVhVUCgiTTYyNzA0IiwgQ0lEX01BTkZJRF9LSU5HU1RPTiwgMHgwMTAwLA0KPiBhZGRfcXVpcmtf
bW1jLA0KPiA+ICAgICAgICAgICAgICAgICAgIE1NQ19RVUlSS19UUklNX0JST0tFTiksDQo+ID4N
Cj4gPiArICAgICAgICBNTUNfRklYVVAoQ0lEX05BTUVfQU5ZLCBDSURfTUFORklEX1NBTkRJU0ss
IENJRF9PRU1JRF9BTlksDQo+ID4gYWRkX3F1aXJrX21tYywNCj4gPiArICAgICAgICAgICAgICAg
ICBNTUNfUVVJUktfQlJPS0VOX01EVCksDQo+IA0KPiBUaGUgcXVpcmsgaXMgYWRkZWQgdG8gbW1j
X2Jsa19maXh1cHNbXSwgYnV0IGl0IG5lZWRzIHRvIGJlIGluDQo+IG1tY19leHRfY3NkX2ZpeHVw
c1tdIGluc3RlYWQ/DQpDb3JyZWN0IC0gV2lsbCBmaXguDQoNClRoYW5rcywNCkF2cmkNCj4gDQo+
IA0KPiBLaW5kIHJlZ2FyZHMsDQo+IEJlYW4NCg0K
