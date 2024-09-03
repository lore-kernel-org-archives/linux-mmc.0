Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04911CA6AF
	for <linux-mmc@vger.kernel.org>; Tue,  3 Sep 2024 13:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725369744; cv=fail; b=iy9loSOmk3wVA4NzP9LJ+Z2MscqehfH9j24CdcdNLJlqaY+Hrb1Q/+3zk5EQ6olbio22uwQeq2lKrcNpOR8ko9OMMBcG/QyeVau8kBHxzTbVG2LQdT8LjqEHmJXaIK3BOHx7DJAiq/FlA4CwVX3xPSjt00TDt7a4pWD0QcIysOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725369744; c=relaxed/simple;
	bh=cGSG1jUvJnHjcLdr3MZfVobX6LGTUnLNhRxuOpT5vII=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rOpoX0oeUuk96HJgfD0emia/Ormnw+IURKp1IEnRdaJb/NVhYTArbM9j0ULyY5NN2KrmxKvRkAjM1w1dkBuUShQvQAyv0qORwyBaaGNmuds8D52om/m5nweaoDnXlSoVVmlxLCW2tEPwnpmkarPKiEfWiLSQFtEt6Ray+J/pNJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=bnNO6J0z; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=aWo6iqaC; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="bnNO6J0z";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="aWo6iqaC"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1725369743; x=1756905743;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=cGSG1jUvJnHjcLdr3MZfVobX6LGTUnLNhRxuOpT5vII=;
  b=bnNO6J0zchsI/lxYNPL8lKC+XVNiCxPv95ntBHTeOJIgoYHxqDOkfW28
   xs0a/2FTqsiFmv5ShJhCHv0C5BOYfWawDUUuQYgMoJZKDwnt0qw4HipEB
   upmF44GmJgwD5qpTCz0Zvq2OWnc65bVGoq8ntY17H1CKTIVgwONLs01NF
   acEUecgP8oKpukcF73/G3hrgzBFB0mvdOA658qA54QdOFug/L8zWnTQgb
   W9oUC6k3pGWGM1jZsGjEdWN1N2BmZdJqosnmRmIHnNtzOtxO6zHF4zK5P
   n7/kH/F1quzPurcy3fsV03Yc0mFqNpACc0vzzs/4NKmjrm7Ma2aSh0Gx/
   Q==;
X-CSE-ConnectionGUID: t+u3KNuOTnGSXMXd3g9Gyg==
X-CSE-MsgGUID: gAM3YrY7S3WfOu92W98pzA==
X-IronPort-AV: E=Sophos;i="6.10,198,1719849600"; 
   d="scan'208";a="25191818"
Received: from mail-mw2nam10lp2047.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.47])
  by ob1.hgst.iphmx.com with ESMTP; 03 Sep 2024 21:22:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LdvOfdHSXnQLylIprRuYHirccY8RqdlcZsjHD0XOzSwCtCKG6D05v6rWAIPsAJ+KkQNF1M+6MeomYe8+mTESPlgtzt+5rlkI9bNqsv5rTPSw/ueS3+JAx+x2zunQ9pDcwVJQIgB6JcybDjNoJ0rXt8SrqyRdDIcQ8qAKcuRIFPMkbWkkqZkqlZQYizeg6tC9jPZ7A541YwZ8TQz6CKjJdorso2jtfgXjTWs1CE81V9giJkUdw0rXOAH/Umkqk984Azq8CyU9Hzwnu7pq5mgo1bBRxKzD1Kxbs6y3UW0iv1vHF9bBZwjm36GSynPxwnm6iJMTSmsx3YFl5PPNa3KNZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cGSG1jUvJnHjcLdr3MZfVobX6LGTUnLNhRxuOpT5vII=;
 b=L4osUEw7y/c8pvyq7KUTGCHN698eePX8WSXjUBsNfJ8FWV2kJ2jnXEIxGrJrpc7laQwfhF+1h/vci6VZSzkU7eRUonvDk8KfS1tz48Q9tpRFYrLF9yM5B1hYQfDloEDY9HHU4O1QPE7QHCiefrbKXMCF0Zgr+n8wUOFbEjGkknY2Pt6/E7vV3m/Yy4BGSmYKOYeXjasshHkbetBAjqOjX0aMi4VEU0W4zyOrcmqoEEX5g7yhUeTUwovyPbzYbNhFTvQNvgR9im93VFliPYENWKsp7uUGfiMvGpaQUewCeDRu+0ZCJLwo5l09JNQarG1nifkZvqbZSChg8W5BGFCm5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cGSG1jUvJnHjcLdr3MZfVobX6LGTUnLNhRxuOpT5vII=;
 b=aWo6iqaCiiZAfoUzrXxiD1Q+0OIhEE9H+UPXWvsL/98SPrY5uzLDJyzt4rrn/paB608feBm/f4uZKOZIGlyr33loZ4lZqledX58iJeLqu6g/KdOi0mkToLfH1xP2TjQjE9IL80Dyosei4tViM1z91FXTCw5ZBCTGrdZff7CDcSI=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 BL3PR04MB7977.namprd04.prod.outlook.com (2603:10b6:208:340::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Tue, 3 Sep
 2024 13:22:17 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f%3]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 13:22:17 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson
	<ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>
Subject: RE: [PATCH] Documentation: mmc: Add mmc-test doc
Thread-Topic: [PATCH] Documentation: mmc: Add mmc-test doc
Thread-Index: AQHa/e+F1dYsooCLtUSpQrxlxSGAx7JGBHwAgAAIBkA=
Date: Tue, 3 Sep 2024 13:22:17 +0000
Message-ID:
 <DM6PR04MB657580446A090E3A7CB4C317FC932@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20240903105151.3581457-1-avri.altman@wdc.com>
 <a7b19646-d44e-4a0d-bf7e-5eea109dd48c@intel.com>
In-Reply-To: <a7b19646-d44e-4a0d-bf7e-5eea109dd48c@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|BL3PR04MB7977:EE_
x-ms-office365-filtering-correlation-id: b03d4086-1ca0-4a28-5fb3-08dccc1b6ee7
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bG1PNW1QRGxla1E3NzBwYVJoc0s3cWlFNGg2T2xqM25mKy9qY0VVV0lYNDVZ?=
 =?utf-8?B?OVAyT2d3dDBweVlMVnA3QWZVNWE2aVZwSVI3ek95dExoa3h6Qk5mcG1BTUhP?=
 =?utf-8?B?TVRFNU1yM2ZYaDRDN3FLR2hjdms2QW4yMnEzK2xmYXVIbm11UEtIUkV0L09s?=
 =?utf-8?B?Y285NjBSYUtIVGo4ZWVXMUh2VmlxN2ZIQnRFbHk5YzZUSDFyV0xFbnh4bWdt?=
 =?utf-8?B?SzBvaWFyelRmL25rbm1LdnN5ZUdnWVJreU13VjVZQm5sVS9hSTZBNjQ2RTdW?=
 =?utf-8?B?clFCbXU4STQ1d1BmR2QrTkRIV1ZidzJUVU9uTUpDeHpDcWozMGtHQWk0SEdW?=
 =?utf-8?B?NEVhRXM1bWJFNFdqWkFZd24xeWtwRFByTkFyNWp4Rjg2U1dDQXZwQ01UMkdj?=
 =?utf-8?B?QXZJcWcwRTFLTDJodU1TOGxvM1NMcWpCMkVvb1FGMWtjd25YeGtXVzFCUUpz?=
 =?utf-8?B?VlJOenVDUmlMOTlqNTFzdlVva0I5dG9hUjl0V2ZuWWdRcjhLQjArVVR0ZG4x?=
 =?utf-8?B?LzdCOG9tVG0rNXc1RVVNMjk2aCtTaFFJa21tektaV3IyTlJDVFlqdHBIMlBG?=
 =?utf-8?B?WjkzZ240QUhuYyttaFpLd3UzcTg5blRTd0Q1ZVhtbEdyN3cyZm52M3ZtY3Yr?=
 =?utf-8?B?anNCWGpwK21CenBWaFMwN085SUhQR29hSVJiZzhRU3BCc2g4a1gzeXhMTnhP?=
 =?utf-8?B?OFgvSE53VjhWM0huRzN6SUphTzhtRklBbFA1bzRGUDFMb0p0UnUrVnFuc1N1?=
 =?utf-8?B?Q3BKemJ5VGRSK2k0UXhOM21SU1A5Y29Bc0Fvck9CdUQ2TmxxRHkzbWN5QXZu?=
 =?utf-8?B?MUlCaW9LdFZUWlhNVG9zNzJhQ2VRUm5Qakp0a3RySTZtUlNROWR3M0RVY3lZ?=
 =?utf-8?B?REpVd1JNVWhJb2lhRSs0Sjl0K05OVWcrMFh1NnJsVURKYUY5REFZVXQ1RzZp?=
 =?utf-8?B?MjNxVTRzWXdqd0hoYkIrWFRuOENGQWtXWUVEemVJdGZLVmJFbUxjNmJRTFJi?=
 =?utf-8?B?Q002VVE3bit5WUNMc09udUcwbExkUzVRNkRtdmNkVUc3RU81OXFFalVVZW5D?=
 =?utf-8?B?eW1GQ3ZIQS9mZFVZbGNxVUl4MXI5RU1kalk3U0IvbnhJeGN4Z3dmaTlNeGRQ?=
 =?utf-8?B?ZiszVFhPaWtaTm9jUTY3K2p5Vm5LVXl0Y1JNWmw1YXlkb1RZNGFOU1VzZGNr?=
 =?utf-8?B?OXdwMTFJOUYyakNtSFBYQ1JMU2FlNVNtV2cxamVFc2I4N09FT2MrWHJJWXpN?=
 =?utf-8?B?Zk5xTzV4NjFWM3AyOUk2dkFCU2FFbHpZTzZ1ZVRWT3RPc0NDMTF3ZU83MytG?=
 =?utf-8?B?SmlMVEpCN0hJaHdIRVNoS2kyZU5ta1diOTVVOE9yVFBOOGJMNzZQTkFSSTZ3?=
 =?utf-8?B?b2QxR0JKSTZFaTE3aFZGdE9xenFDM0VWTGJ1UmxTcUJTWEUveXZRMjNHa3Nj?=
 =?utf-8?B?aU1DL01pWVRQZDVpM0VOQjFmSlFHaCtYWCtMOERvVHlLVmNPeDB1SDF3Njdu?=
 =?utf-8?B?U2RGeWtIeHZKMUdBUEtPU21PcTVuZDBXV0ptME12VS83a2I0S01nbFByNlla?=
 =?utf-8?B?dlZyNFN6MVdua0pOTHNJUVFUcS8vaS9KQXR0YjdKeVpTRVFkNGxFMGRsbW95?=
 =?utf-8?B?c1JRRmV5ek9UWHJVUEN4YWFLdEc0bDVVa2lhL1FoemZoSWV1ZlA1bFJmSEJv?=
 =?utf-8?B?OVYwLzVUamFMOEtyM1MvVEZVbWNaaXd3YXZHSlZTaXNuSmxGVkdlWVk3UEdV?=
 =?utf-8?B?WHZXM3dNQ0czKzFsY2lkZ24rY2ZoOTZCVkoyL09vOHBFalhWZ1FzQjFPV3VM?=
 =?utf-8?B?dHo5SXQ4WjhGdmluK1JLSUpTTDViMllESmxJaG9PcDhyUWN0bzdZS0dJMVNz?=
 =?utf-8?B?c2JwYnRVUzBqTjZkdjQ1aFNHVEJhZmxTMUllMEJ6SEJsQWc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Si92dWxoYnJxdFh2RS9VTy9MYk03c1VMOGhIcXBZS21WaFVnU3h3MzdNSExy?=
 =?utf-8?B?RFNmV2ZuanYvK2h1QjVKY3E5YmFZb1kzeVBEME9jZFBDZ0MrbllxSndUY3ll?=
 =?utf-8?B?eHltWGY4Q3hqR2E4ZDRFM0xsZ2o0aGZsWHdVOFFzbTBlVkJDUDI5dmd2YkNq?=
 =?utf-8?B?MHhrT3FVa2pZanFxeWhVeXdOQ2VkeGpVTnl0VHNKQm04QTlMSnQxc2hWYk9r?=
 =?utf-8?B?ZlNzMmZ0NitBMHJGVFhpRmRXSlJMUVF1b3VsZWZOeVQvbXFZRGxLVEwyQm05?=
 =?utf-8?B?UXQ5ZC81ZERiUk5JVFRYYnVudmJ3S0pocERyakRuUGxxVjJIWENJS29JWkha?=
 =?utf-8?B?dE50Ymt4TmZjWEtkUnFCR2EzMVVKU1hDN2d6WWhNQlg3c3Z1azJScDV3R0dj?=
 =?utf-8?B?U2pGK0Q0MlpCYzRvekFNTFlFZERQVWg2UkhsTERnZHd6cG5JbEpXYnRwN2V5?=
 =?utf-8?B?VUVhMUpyWSszbGdKMG5abXBnY0N4cTByTkxscUFLTmFLUzEyZHhxMmxZcWE0?=
 =?utf-8?B?UUFIdFhJOHR1ek0vLzBkZFVsWVZzampNTDRvamYrcEg4QVlTS0dWUzVvU0VB?=
 =?utf-8?B?NjM0dW4xNHU3REJtR3djbGFHMU03ZklJYjR5dlV4QTk2QTNyWGdaQ3EzWm90?=
 =?utf-8?B?a1dOZERkeUZkMDBBc1UwZFc3UFI4Wkoxc2dnSlM0ZGJ6TTM1dnYvUmJXMFdC?=
 =?utf-8?B?bEx5d0owY2NSUmllc3hBR0tHMG1Vam5wOFc4cDlhZmRHZzh1Tm5zU2gzTVd0?=
 =?utf-8?B?c2RoN0lOM2xENFR5cUNnY3RQck5hczFCTHVMckxrM25TS0VpTEliaFJEOG9s?=
 =?utf-8?B?Z0Zkc2p3VzBRdDZiWjd4dWV6clhISEdUQysvT09BU2RlbDRnOVFaZEM0U3pj?=
 =?utf-8?B?MjRsVGxqek45cThUY0VwbHErV3BldWcxOWRKdkpRVGRXdDdIZDdRek16M0lT?=
 =?utf-8?B?aldhbUhBelJPdDVRempGVS85dmltVTZCTzlYK3RaaWhyN3JCZ2dtamFaTVUx?=
 =?utf-8?B?RzNUSDBqdGlTaU5LYldyaGkyajZEamsrQzArRkRGa1ptVm43VHRYTWI5bTVG?=
 =?utf-8?B?Uk1SZEFrZGE4Q0s1aEdQbkpWSU9uSzJLT0pnVTFCZnhHOTNKbm5uZWRnRUl1?=
 =?utf-8?B?c1RWSHJsM0hEUVlBNmI1U0VQTENudWl1dTZ4QVVEeXpVSDU3M2lFK2NJRkhC?=
 =?utf-8?B?Y2FEdkRxcm1ZSkdIQTNEekowZ2llVmxnYlQyUDBIN1gyMVZxalhSbzBGNXhS?=
 =?utf-8?B?U25RcXBrWnFCa0xlRFc0NmQ4Um5KcG5hNjdwNmM2YTdDTmJQOWU3b3VublFk?=
 =?utf-8?B?WXBlY0kxNVFBc25pTTdpVHZnVFJhN3dGeXZ6L25ERUZHU1cwSzNERU5EdHRQ?=
 =?utf-8?B?blJwRjJSOVZsMW9VZXBJQzFJK3hXaVV0RmhXZ0xDY1JXaVJDS3dsRUc4MFRu?=
 =?utf-8?B?LzJZQjVyQ2tNOUxnTTh5eThWMUJkbGpRNGxCd0l2dnYzdDErSW5BT0tTWlhG?=
 =?utf-8?B?WGw1QmtDaW1MMXdiSXgrM3RqSGdjQUtZbmsybXQ3eTQ3ZFpJMmhXZHBmMXFh?=
 =?utf-8?B?NUg5eis1dFRYWW5YV2s1a3RHR1dVbDFtZ3RqNFBhTmZkeW55RjhoVFVyS1Br?=
 =?utf-8?B?YjVzL0R1UTFnQ0FFMEkzMy9RMG5ZS01OV2g2b3RNNGJHb2xuVVFzNlZKWDNa?=
 =?utf-8?B?UC9HcjZyTDcyTktHOWZCOXZQS2gydldhZ2dGTXl6WnY1RHJML1FUVnQ1VkFz?=
 =?utf-8?B?SWJxSUhlUXBiRXp6VEQ5VlkrRGtUR1kzOEx5Wk5iRStsSnBCNGxxOVltYm9J?=
 =?utf-8?B?Rkd4YS8reEtrQmhidUJENElkRkhtMUtyTVBianQ1RG1OSEVWZ2l6WHVzdWs0?=
 =?utf-8?B?aE5wemp6bUF0QjBCNlhjUDhtVVNwRXNhZ3E4SjYzQUJtR2ZKUTFmOFdpN1lQ?=
 =?utf-8?B?Ny9SM1pwVE9xZjZ4SDl6cm15d3NXTHROdlNPWXc4Y3MvczZNMGVCT1JzY2lI?=
 =?utf-8?B?bnlod0hzSGZjM3VqYzFldTdIelN3bXBFMGFiY3gxVUluVkZVV29SSzRYa09I?=
 =?utf-8?B?emwvU3BjbEVYWDJmNEVWbFFoTThHWGVlYTNHYnQ5MmFrM2Q4RFloL0NweDRX?=
 =?utf-8?Q?DIWORSlAnNu8wT8k1scVfH6sx?=
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
	3MMvCOHTV1fhp2xO9gqBJxbZx2o9UbSVcv3A+VWyrNdJYYiM+FbIVbEcYkT/N8csx1+RRIEtNYTY1OmVNqSIIDeBSKw4BnpOZ6IJ1nYG8Xqfjxav/WHYOCkWFTJYCZC26TFpqE3xBXV1tPbyXxSLBEvwyQOYAIg9b6l8dpp7gd+Qv2lDlX8Fm305qKtHhkoLmHLNnUb2gW+HesAmvQI7T8rII22hHzGMbeTen5x4Yd+VYfB9CK3bA6GBCZilFgwz/Th4C3TZrPd5C1SuSfBP7xsLE+l/X6jDiDxQMfTc5u0ODT3T/kcDcyeoAJwepag4kdMLpRpKe2TTH22x94Q5l4YtcoSUVqfKxYc75iOexSwaPZ/zAMqUT5GoTiMbQL0m04QyIp8GfLVolOV4QK1U1nADr2TXqrwhYreLkoX/5Xj2wsP2zIXVUlG/TFL9k1wMBzqoi7mljTWrVikAeRUHngroLFBM+ednVSoL2xnIIlLYFaAPIdEOfktX7Z7BykMezh3doYdy6IdIHKiX+mR4NCRTOTr4htypJNtnHtXSd4hNrhhaOUpRRj8/RWJugWGDTyW/mQ9BoRmYSW06an+gtTvIlruBpoxzknc0YAjQqEYLCJAhUK2F0ZPV8JcGVKPW
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b03d4086-1ca0-4a28-5fb3-08dccc1b6ee7
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2024 13:22:17.6287
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T+aU4PQRmfd1q8rx6Js5l3qGONIMs8IVGqqL094/IaCGrwmiRUw0kd5OryVZprPDsi0qfTeGj2pcCpuJwrLQ2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR04MB7977

PiANCj4gT24gMy8wOS8yNCAxMzo1MSwgQXZyaSBBbHRtYW4gd3JvdGU6DQo+ID4gQWRkIG1pc3Np
bmcgZG9jdW1lbnRhdGlvbiBmb3IgbW1jLXRlc3QuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBB
dnJpIEFsdG1hbiA8YXZyaS5hbHRtYW5Ad2RjLmNvbT4NCj4gPiAtLS0NCj4gPiAgRG9jdW1lbnRh
dGlvbi9kcml2ZXItYXBpL21tYy9pbmRleC5yc3QgICAgfCAgIDEgKw0KPiA+ICBEb2N1bWVudGF0
aW9uL2RyaXZlci1hcGkvbW1jL21tYy10ZXN0LnJzdCB8IDI4Nw0KPiArKysrKysrKysrKysrKysr
KysrKysrDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgMjg4IGluc2VydGlvbnMoKykNCj4gPiAgY3Jl
YXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZHJpdmVyLWFwaS9tbWMvbW1jLXRlc3QucnN0
DQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kcml2ZXItYXBpL21tYy9pbmRl
eC5yc3QgYi9Eb2N1bWVudGF0aW9uL2RyaXZlci0NCj4gYXBpL21tYy9pbmRleC5yc3QNCj4gPiBp
bmRleCA3MzM5NzM2YWM3NzQuLjgxODg4NjNlNTk1OSAxMDA2NDQNCj4gPiAtLS0gYS9Eb2N1bWVu
dGF0aW9uL2RyaXZlci1hcGkvbW1jL2luZGV4LnJzdA0KPiA+ICsrKyBiL0RvY3VtZW50YXRpb24v
ZHJpdmVyLWFwaS9tbWMvaW5kZXgucnN0DQo+ID4gQEAgLTEwLDQgKzEwLDUgQEAgTU1DL1NEL1NE
SU8gY2FyZCBzdXBwb3J0DQo+ID4gICAgIG1tYy1kZXYtYXR0cnMNCj4gPiAgICAgbW1jLWRldi1w
YXJ0cw0KPiA+ICAgICBtbWMtYXN5bmMtcmVxDQo+ID4gKyAgIG1tYy10ZXN0DQo+ID4gICAgIG1t
Yy10b29scw0KPiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RyaXZlci1hcGkvbW1jL21t
Yy10ZXN0LnJzdA0KPiBiL0RvY3VtZW50YXRpb24vZHJpdmVyLWFwaS9tbWMvbW1jLXRlc3QucnN0
DQo+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiBpbmRleCAwMDAwMDAwMDAwMDAuLjkyNGY4
N2FiY2I3Nw0KPiA+IC0tLSAvZGV2L251bGwNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2RyaXZl
ci1hcGkvbW1jL21tYy10ZXN0LnJzdA0KPiA+IEBAIC0wLDAgKzEsMjg3IEBADQo+ID4gKy4uIFNQ
RFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wDQo+ID4gKw0KPiA+ICs9PT09PT09PT09PT09
PT09PT09PT09PT0NCj4gPiArTU1DIFRlc3QgRnJhbWV3b3JrDQo+ID4gKz09PT09PT09PT09PT09
PT09PT09PT09PQ0KPiA+ICsNCj4gPiArT3ZlcnZpZXcNCj4gPiArPT09PT09PT0NCj4gPiArDQo+
ID4gK1RoZSBNTUMgVGVzdCBGcmFtZXdvcmsgKGBtbWNfdGVzdGApIGlzIGRlc2lnbmVkIHRvIGZh
Y2lsaXRhdGUgdGVzdGluZyBvZg0KPiBNTUMgKE11bHRpTWVkaWFDYXJkKSBkZXZpY2VzLiBJdCBw
cm92aWRlcyBhIHNldCBvZiB0ZXN0cyBhbmQgdXRpbGl0aWVzIHRvIHZlcmlmeQ0KPiB0aGUgZnVu
Y3Rpb25hbGl0eSBhbmQgcGVyZm9ybWFuY2Ugb2YgTU1DIGRldmljZXMuDQpUaGFua3MuICBJIGFs
cmVhZHkgcmV3b3JkZWQgdGhhdCBwYXJhZ3JhcGggdG8gc29tZXRoaW5nIHNpbWlsYXIuDQoNCj4g
DQo+IFBsdXM6DQo+IA0KPiBOb3RlIHRoYXQgd2hhdGV2ZXIgaXMgb24geW91ciBjYXJkIHdpbGwg
YmUgb3ZlcndyaXR0ZW4gYnkgdGhlc2UgdGVzdHMuDQpEb25lLg0KDQpUaGFua3MsDQpBdnJpDQo=
