Received: from esa.hc6817-7.iphmx.com (esa.hc6817-7.iphmx.com [216.71.154.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C0517A2EB
	for <linux-mmc@vger.kernel.org>; Mon,  1 Sep 2025 07:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756710536; cv=fail; b=vECWImaXzpSex3KPA4bo9QjgL8V4WoJNBF4aaLl+HYMjmlGrsX9N5p0Gk1smBvQEdhZl79WGVhKTBP/Zm7MiKtKzHPnkSvvqkLwfzo9cy8cz3bpajkLP7AlJV3NuXertP5rccyR4Yk2488NZQW6WcUNN1o9Mj5hcQjLyFac4csA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756710536; c=relaxed/simple;
	bh=fd0Fo0aAbuP2sYESgAyAUNgvwE/PH6SFZJu+lzxQmfk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XZ/voLcbLtx4WweboR3DW61LXaeRKlWR96zXPrSpPCOQFjmiBn2llL7UgwxfsItIItLhQ1IwhJBN/QoVFqS+a0yZgc96RdlOYxqGAdOYWni0cNhrD2ulJtXUVsUAaQHTAsBDkUJyiyLiAPzci2ZI1jwX/TpadTxtjly/yJnthxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=mfvTpNWU; arc=fail smtp.client-ip=216.71.154.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="mfvTpNWU"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkimnew.sandisk.com; t=1756710534; x=1788246534;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fd0Fo0aAbuP2sYESgAyAUNgvwE/PH6SFZJu+lzxQmfk=;
  b=mfvTpNWUjOEM73Dut8dY4LIuYIAkq0FmYuAhILOBQt3LQBHt5/AdFMrD
   U9M5tEmuP9JwrbSafMEC3CeLC9siI0q3h+4+waf54azPmbCIoIgHyJ/qi
   mrXxqF5HPOzNtXZ7XTZnCRouYE+0VmvDLsrQmS/6yEem72yy6EEh1MR+s
   /r6OlBRBXNVcYsTU7Ld6cPJSXBeusUgT/Qtso3j3ReiK7kt+yf1QJpsiU
   2w6nKVa96z7nURiIxasrDSlFxZVcUdU3n+akahOV19lcMeawcl1P/s3d0
   FGYiGyRvA3xb7Q2FCUZdFbpNYFHHQgTVlK0GBgbfJXCqjEiCHWB703vrc
   Q==;
X-CSE-ConnectionGUID: c4tEGZXPSJmH4LDAGe/6CQ==
X-CSE-MsgGUID: FDtvwjR8TWiObicLXnaYgw==
Received: from mail-bn8nam11on2116.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([40.107.236.116])
  by ob1.hc6817-7.iphmx.com with ESMTP; 01 Sep 2025 00:08:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F1a7mFHo9NKuxzYPbXHoUHXp8ER1IbBJEXRr9rCWA66zVan4idVzwJV6hlkAeL5vprftaEYTT8loXY2li+l9+drDYW+4adQ3KuhIGL4HkNXpQcUrWPXE3gt59a8TTnPCF52xvuhymqwJamRAsKDTsBnMsDUj6ZXr89q8jMz6cFDfZuiVv9fj9wvnm3DwKZ9jQJYUMDnTpiuh8dTvu8yZx5ZARY4hVuK2Htzp/pXvhyEEhldKlAV6G/GBjw8B8gzLQyFDcC+QMVM2vFU6KTquelcH1f7M9UH8pPda74YoY6qhb0vRScOzRa+iYTJh+NPUwhgd6/fx46sE01zJw8Atrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fd0Fo0aAbuP2sYESgAyAUNgvwE/PH6SFZJu+lzxQmfk=;
 b=rDMXpODpYdnZPg4F4pzazwHtpkZuThAzmJFKrKqMuOl1Iu/j4e+ZE5Igzzg2b/0yixgnhdj3w7Umq/5lI/bI1JwNQsLxWu2siDNgG8GumNawZ3toHrmRLeDrLze6Vd6yDFxhhQvtwKNgGwyKFB8WnlZuS3C+3JUj8sDCThBGP5fPf7z0ofNBW/b7ddR+tnEilZe9mLX6HmmXVFjd2DhjAf5T/3Eed7etXIAONm88w+Xy6b3322Nv8aESx2Y7ngFIKtl9z5kaUP12cLuQFsTzrAScQdfn6rrTvmI07t6ahrp9nFILewpEN62SdgivzKqaqmndFvq3TlJqPZ9inr6hpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sandisk.com; dmarc=pass action=none header.from=sandisk.com;
 dkim=pass header.d=sandisk.com; arc=none
Received: from PH7PR16MB6196.namprd16.prod.outlook.com (2603:10b6:510:312::5)
 by CO6PR16MB4052.namprd16.prod.outlook.com (2603:10b6:303:b1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Mon, 1 Sep
 2025 07:08:51 +0000
Received: from PH7PR16MB6196.namprd16.prod.outlook.com
 ([fe80::d65f:a123:e86a:1d57]) by PH7PR16MB6196.namprd16.prod.outlook.com
 ([fe80::d65f:a123:e86a:1d57%7]) with mapi id 15.20.9073.021; Mon, 1 Sep 2025
 07:08:51 +0000
From: Avri Altman <Avri.Altman@sandisk.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>
CC: Avri Altman <avri.altman@wdc.com>, Ulf Hansson <ulf.hansson@linaro.org>
Subject: RE: [PATCH] mmc-utils: Correctly handle write counter overflow status
Thread-Topic: [PATCH] mmc-utils: Correctly handle write counter overflow
 status
Thread-Index: AQHcGrbML19M83kUxUy0kjLhGrR097R90PjggAAKA4CAAA2tYA==
Date: Mon, 1 Sep 2025 07:08:51 +0000
Message-ID:
 <PH7PR16MB619655F84E85BFE2BE796D05E507A@PH7PR16MB6196.namprd16.prod.outlook.com>
References: <31174fae-a3bf-4415-a8a5-76d252a6fbd4@siemens.com>
 <PH7PR16MB619601040C92D28ECC72F7AFE507A@PH7PR16MB6196.namprd16.prod.outlook.com>
 <e6f0ec2b-0d5e-4b3f-b32f-13120c86f85e@siemens.com>
In-Reply-To: <e6f0ec2b-0d5e-4b3f-b32f-13120c86f85e@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sandisk.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR16MB6196:EE_|CO6PR16MB4052:EE_
x-ms-office365-filtering-correlation-id: 5eeba888-6bd0-46b1-7113-08dde92667b3
x-ms-exchange-atpmessageproperties: SA
sndkipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cVRjRHNzUG5VVzVlaG1LYzkrMmZjS1hqRFFFZi9QNnJpMS9leGs1Z3ovUU9w?=
 =?utf-8?B?aG15djJETTVRMkxKVkhtbmJoNWNDM0llUEluZUI4SjJvbG8wZTBOSFFnMVFS?=
 =?utf-8?B?aCtiMlFpQnpzU3ZKSkM0SytlcVdXTDRkTGtJTy91eDRXbTIySVB1aWR3TU53?=
 =?utf-8?B?OHU4bDlGMjBObnlEWlB1Smg3RnpqaUlwY3pjamxISW9xVnJzWUxwUWYydkxh?=
 =?utf-8?B?RGVadzE1ZWp3cHFGeGlXNHNCeHBNcXhKNTl1RXZCdEQxQWtaaWFLRk45NWJW?=
 =?utf-8?B?S2M1aGRlbnFvWk1XVG5IUlRjTk5yMkU4cnhRZTF5ZzQzVzljejBVR3c0SkRR?=
 =?utf-8?B?c25PNE16WWlIOC9xeEY4U1NCS0hueVI1cWFIaE5CSFNSRFFveGRFbjRMMEdn?=
 =?utf-8?B?UDJyVjFUREkrVWdXd1V5OUJkaUtVUk9zOXREZkszZVROa1VpWmtEMkkxY0N4?=
 =?utf-8?B?bGJ2OFVhVG9lMVNQWjBKL21ydmRZRUxrZWhoZmlVeitjakpLY21sV2JhT01F?=
 =?utf-8?B?OU01WmFjTFlIWGFEYWxsejZ4aW1qSXFYRDA5dlZYaDNhM0RZc2pKV0h6YnJ3?=
 =?utf-8?B?eVEwWmVKNTZhMWpPbEJnUVAydEZVa2xJVVAxTmlxbHloamE0STdVa1E1V01V?=
 =?utf-8?B?YmRuMStFOVRML3MvOWtSbDRoclVvNTFxWmErOWZOZU9KbmJvOWJkbWdWMEJE?=
 =?utf-8?B?L2YrNkphaWJMQ1pDZ09wZzdPdTdDVm11NUswQU10QnFMdWplWFo2Y1ZlUEg2?=
 =?utf-8?B?TUtEYVMzNFNBWGF6R0hmQ0FUQ0RyTXpWdU5FWFNucUpiSTQybGtsSWRGVjdL?=
 =?utf-8?B?a1dVVk92cXprUFhRMDBNY3pPWmxHUjhLM2tYcE53Nk4xVkJka1VIcXl2Slpq?=
 =?utf-8?B?NExkeGVHK09yYXdjemovZU5nUUNvWnJyNEt6a2VIak9kU3ovRWFXZ2tEeis0?=
 =?utf-8?B?NTVLeS9DZmxkZHRVZy9UcjZZZThEUnA3VW5UWXVLdzljRmJzYmVnbWpHYWJo?=
 =?utf-8?B?d0RmaWJZcFFOaHhlek5YWC9QTUR4ckJuRU10MHl6Z1MwMGdsMEJ5UG5idUJv?=
 =?utf-8?B?VjVLNCszZllMZ05mdWgyU2VYRk5PUnR1MHVCYlNRY1VYTlh5MCtkeENUaGRn?=
 =?utf-8?B?UzdjRzRraUppUDZEL2dxaGRKYktuU3ZzZ3kvVVFlUXRseHBKNVBSeWZ6OWtl?=
 =?utf-8?B?Sit1ZDJJN29xYnZkYTFvaU9tNXh4VHZyUllkZ2RaSG9qMUpKbGdaOFdsYUU5?=
 =?utf-8?B?RktjZ3RuTmVWRzRFd3ZuSVNvNDVENE1KNlZXMjZ6Q1paK0tOYjkwY1k2cERu?=
 =?utf-8?B?bnU0enYrbkl6QWxrUFdVSUNib0lIVklUdmp3ZmMvMEJxRXVjdVZDTlVjY08w?=
 =?utf-8?B?cTQ4UFU4VlBwaGIwaTMyUzIwT3RUQzYyRUxtYTBaQy8vOUNSZy9IcDlvYy92?=
 =?utf-8?B?VkRqK3ZTYjNpUmQ2NSt0K01UcXBFTHdCQnJOSG9VUjE1QzNnR0pJR1VRV1FD?=
 =?utf-8?B?TXgxdjdyWGlYeFVBTS84NFRLODd1UkNHR3BQWjBPWEE2M1huQ3pwVFd6RFJr?=
 =?utf-8?B?SFFRN0VSQ3ZOVWlNK3RRdllZWk5nRVlnVjVuR2RzbzZMOHVXL2JreFNYWkdX?=
 =?utf-8?B?M2FlWWFiMzNrd253TVRtOEI2Ums1M2o2WVRuVkU1WVd6Q29PaEFmVDMzaEZT?=
 =?utf-8?B?d0kwWXVQc0I2WWRWZ0tNcEtyMVRFOFVxZlYzVnY5dkpDRTNIMTJnR2M0Mlg3?=
 =?utf-8?B?S0tDbkFtWE9iS2R4dG5acUxHY1FhejZWckhWeGNOa09jVjBBWUljQjNSMFZw?=
 =?utf-8?B?ZVJZMHdRMG0vT0NIN2JKdG5ZYi9sWTJVMHQ5MUpuVDdpeTlKOWdCN3d4bFpS?=
 =?utf-8?B?NFpLWldWbnIvS1ZqRDcxLzVFVXBqYkF2Tk9UdDZ3OXBPRWZvVzgxWHZqYWZH?=
 =?utf-8?B?L1B6RE1vZTVoQ3JCNGIzSVN6YUdVWnRHRlZzWmpld2pLcnhERHVxTjg3N2Nj?=
 =?utf-8?B?bFhHZ1lyTUNnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR16MB6196.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SEpGaFNodGM4T2NueEllMXFDeVZXakNoK0c0amk4Y0MrUWRDQUF3TEFPaGNh?=
 =?utf-8?B?ZHp1dTJtaFMvQmt0YVF3UUNPZ0lUSHNlNkFIQkpobllMTjB0ejdtdFZIVHhy?=
 =?utf-8?B?R2xkY1dPRDN1bUJUNHFHOWtJYzM0b29ieHBqUTZXbXh4dkI2UGJCRGczb2cw?=
 =?utf-8?B?dm96NWFqTUU3aVVBVlc0N21ydHdXdStMa2lLV0dGMkZDWFFSZ3o0VWw5dDho?=
 =?utf-8?B?OHFLTUJkcnphREgwZ1FIeXFjWWxxbDhVSC9WcnFsTFh0cjMrODRqOTBNRkUx?=
 =?utf-8?B?eUt4NDk1TkkxczN4bWlKTktIM3Rnc244ck1KU0VaRm5KczJiWkc5ZWtLM1ND?=
 =?utf-8?B?MWg2dURPczh2Y1l3STRKdEFGdncyOGNPTzNoUUgzTThtdDZUSXdPeHBoZU5a?=
 =?utf-8?B?RE0vRTBOQWpscVpxSnArcUdPYXp4ZHRqbFRqa1Z6MzlST2VmZnpLelBOY1BV?=
 =?utf-8?B?OUs4dmVoODV4Sk9ONFpSellnclhoT3k5WVNnQ01EbjhDWFo0bDIxYWoyQmxY?=
 =?utf-8?B?cTRJYTV2TzhGV1ZoV0cxZFI5Y0MzMENDY2g3WmwraU9zZFZVZE1UZWdMYThB?=
 =?utf-8?B?WVA3UHByTVNsRTBEZmtDN0tXRk8yanJwR3Q3ckFObUh1WUJ6RGJoMlRiekJv?=
 =?utf-8?B?a1pyMzVWL2RoQ2hybk5pR0NRcmttUGRPKzNNcDI1ZmcyS2I0MFprRGtCZVNy?=
 =?utf-8?B?c281R0FlQnBQY3g5aEwzZmlyUWNLT1NSRVhzQXV6V3JxYU9keGRHbEV5T2ZK?=
 =?utf-8?B?QkVuR2UzRHpwSXIzUlJ4MEpKQjAvV2o2aVowUFlVS2R6ZkIyOEFRRExYUWtP?=
 =?utf-8?B?a1ZaN1hHQ25qaXI1ZmFFTUQ0OWo1c2szSGNyN3JiU2t1S2E5V3BrZDBuSFRD?=
 =?utf-8?B?Kzk0V0hBdkN3NDhsM0MwemZxampJSFY4b1pCNTVCSzNKdWRlTjc4clM5TjQ4?=
 =?utf-8?B?S0luNVBERE9zL1RxU2VjMXY2ekF3ZG53MDVkTjhWNEtWRHc3anc4Lyt3c2U5?=
 =?utf-8?B?UjFybXdLM0hON2ZKdEtpY0NHbnNwUTZERUNoaFQ4T3o4QStSQkFzaytSd01N?=
 =?utf-8?B?MHZ3NTdBb2pUektVajMvUTB2b3BITVV0eUVmR1ZBVGtKNGVGbGt3YksvQUZY?=
 =?utf-8?B?bThzMVdaNEhzZ3FOUG5jbHNINVZDTENocWJIK05TOVlLeFhmU0cxRWVnS1I1?=
 =?utf-8?B?c2ZKUkFlL2xMVFFBK3IvSmdjSkY5UU9oV3IxYWhFTkdjTHVxWURsQjJNS3py?=
 =?utf-8?B?bWxVeVFUaUhza3ExWmgzZDQ2cXl4WXV5TVhqUW1KVkhjWGJ6clI3WTRTRDN0?=
 =?utf-8?B?QlpFUE5HQ216TXpqNzJsSGRCZ3JrYlJzTHR1VGpMamo2Wm8rdzl3ZXg4bnlD?=
 =?utf-8?B?TU1hbUVDaDV5bXFtU3FtQ09YZk0zVlZkRkhLYXZ3S25vZGtISndJS28zTmhP?=
 =?utf-8?B?QllXQWl4b0Jka0M2N0V6YmdQdGxjczF5eW9IdVJURlRnYVdINUc1czQxeWJn?=
 =?utf-8?B?ZDkwbW9UQnBUdjhlSzNKRUdEODUydlJOZXNKVmZiTkVqVmN0Uk1PUGl3dGw3?=
 =?utf-8?B?STNUK3hxM1ovU1doWE9wVmZjLy95OUIxdi9HaC9waGdZc0dWZnk4N2ZRa1gz?=
 =?utf-8?B?eUlBN0lKcng1bGl2czhka3M0Uk1PYkdOekhLNWMvcUp1UW5TTDJjZHFzOWYy?=
 =?utf-8?B?bWlUMElRbXB0N0d1aytKK3plZG1mUlRGdWplM0UzLzFMdGdzdVFQOWx2aHYy?=
 =?utf-8?B?bktsakwvOGcyWUVHS3RuLzM2cVZ2RXZIQ0YzSWRBRyttb1UvV3U2UHhydGdE?=
 =?utf-8?B?YktDVmV1MHlpSWF3UVBUYXdteHl2bk9qOTFydXhSMXVIN0JhZ2NYZWl6Vnc0?=
 =?utf-8?B?d3RqUi9XNjhyTTJKZWJvNzl3U0FQZ0xMTW5wRzUvbnJ0YWZMaXZkREpXOVdi?=
 =?utf-8?B?T1FEbDlaeW5CWXdKZkgyMnE4RGswNktnNUFaYUlNN3M5WVRqaUY1bWhHdXBX?=
 =?utf-8?B?SDBTa1JNeGJLK2xBeERDZXEybE1xdUZLa2RsSnNFVXUrbmpKVXBXdVczeEpN?=
 =?utf-8?B?QzRKaEx3NEJaTE9jWGpTWnVJYjBOdXB0YkhnV3FQb2l2Q3gzOGgzME1GRHdq?=
 =?utf-8?Q?UcuQ6hKJRpbE8P4KNfW3yJYpL?=
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
	Qcl+WQvnOuvDYhUvqCtEVkcyywCgVZeW6qJQh1EyYXhpa+a0arma2ZVDxllIueU3x3beP0k9KULtmKVZzkT0U+Udqij+VhU8JtWXEyYhycNKfWeTwdRsB7Wnsbgsx0osgrix80Be+Fw04rwjXXndSGflB1x2uFFU1O74eZ8qm7rY6VYh2K+SXs4RT/ZUjjywMWIx1A0Nn/r98eQNtbk4xHTnat0CW7FkqOZLgx/evLB13idv9cXEN5VoacsIQGTfDKY0fRfpWKSphblqZ2P2eZYhniu+3mbt0uKERqRcCahp2tNZqK6TZhwK+iVdAJG48XBfc8BLbL2QMEB06LoVWuip3JFqCOIfIVX9Qkvxy8WTHcePGedtgdCgdNuan61nCfPr0ktBhgs0vPRJGkazyrZ/lIHdP3jZ+Et+vZY5p3fP9yYKTcs5lL5CRIk6AknWOQwBP4sSWXiWjq4qNIo0ElNMl7LTekgq5oZoaSR5bE6hK1phn3++HH6cMJbMSqJTGfZPb6TmPv5eIWS+4p/s+NMDGzF8HogR5EAaPrNrZTwg4nEzDp0hpUcLxjD+eOMf6nhMRFIyGpuEXsIfG/B+CBZyG4I7E2Ls2BpWJTtFm19Wk/n68rdXSeMQvrqRqqiyN2UYVQEV0OcElIV4XzOwNg==
X-OriginatorOrg: sandisk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR16MB6196.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eeba888-6bd0-46b1-7113-08dde92667b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2025 07:08:51.3827
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ffe0ff2-35d0-407e-a107-79fc32e84ec4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tgNL3A8qA02nKg+iLeaoVniND/9M80GJ8f8lXg0PJ2W2Gflj3CnbjJBGaMro3Mq+V8QKk6JzLa7NwCwSqLZLuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR16MB4052

PiA+PiBUZXN0ZWQgYWdhaW5zdCBhIFFFTVUgUlBNQiBtb2RlbCB0aGF0IHdhcyB0dW5lZCB0byBy
ZWFjaCBhIGNvdW50ZXINCj4gPj4gZXhwaXJ5IHF1aWNrbHkuDQo+ID4gTW92ZSB0aGlzIGFib3Zl
IHlvdXIgc2lnbmF0dXJlDQo+ID4gQW5kIHllYWggLSBJbiB0aGlzIHJhcmUgY2FzZSB0aGUgZGV2
aWNlIGlzIG1vc3QgbGlrZWx5IHdvcm4gb2ZmIHNvIG1heWJlIGFkZA0KPiBhbiBpbmRpY2F0aW9u
IG9mIHRoYXQ/DQo+ID4NCj4gDQo+IFNob3VsZCB0aGlzIGJlIGlzc3VlZCBhdCB0aGUgZW5kIG9m
IGV2ZXJ5IGNvbW1hbmQgdGhhdCBzZWVzIHRoaXMgYml0IHNldD8NCk1heWJlIGp1c3QgaW4gcnBt
Yl9yZWFkX2NvdW50ZSgpID8NCg0KVGhhbmtzLA0KQXZyaQ0K
