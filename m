Received: from esa.hc6817-7.iphmx.com (esa.hc6817-7.iphmx.com [216.71.152.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFE0254B18
	for <linux-mmc@vger.kernel.org>; Mon,  1 Sep 2025 09:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.152.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756720121; cv=fail; b=K6DMTb7nFtAV6g+rKlXXNIiV5x19ksoKDmkSJmop9kMwoWBa9wtlzbvexCmDJXg0r7NAJXO2jCPreRiw+tM2HG9926m3/jlBzd+LJDQYk/KD8bk59kBZpodxAFnC39cvVNmsXpYMOkrBQHXFANSdOEIHpnzDZBFkTGaOmXbQSXc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756720121; c=relaxed/simple;
	bh=N6RwnKMtUaNYKwL56kBBSTqbsnFsmrY8Dnjs6XH30vU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Gx189nrcayBnGodNkNMLeMmwVt+O+xOuzALrPknC4PI9+RWnnXobji88n5d0VfTi6P21gL5bHo7VIE4k4MmLtjml+lZxQ6+QpKMBb5WQxRqmEDQoAtC5kM5LH2YBXkjHeaEd6D7QOU+ZRyeRijlP9o3KA4/EXoG5CfIokOb/aDA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=kWPJuon7; arc=fail smtp.client-ip=216.71.152.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="kWPJuon7"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkimnew.sandisk.com; t=1756720120; x=1788256120;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=N6RwnKMtUaNYKwL56kBBSTqbsnFsmrY8Dnjs6XH30vU=;
  b=kWPJuon7Wz5ypt5WBxwUYmwreMbAfSZaybTegRs0S9uIH/EuR/atxRlI
   pV9EdyBAiAv1MEkwoG55lr0XSWxIKQGoM0RunmJXHBS7+RJruaf9E2qII
   Qz9re6b8x2yoY7o24aRaCC6ptM30ikPLyzeQm1V8k7xsyHvsr3rVbCRCG
   df4BKDrN9/82fvXdVPXJXzne6b36yG+Tzyq3rWy0kH5dkXKg+pD9QRfFC
   7pqXGMVPMbyB0JN8mPjghvmzk/sZ29yvHWEkDflehtkt2p/zTpZ3znju8
   qbNYPKW35zJA2KsrY8kSOprWwyR8JPqq7rIb80T+EQy8XNnLO5QbvbMwk
   w==;
X-CSE-ConnectionGUID: JLiKY00ITlyLjiQ+QvPeaA==
X-CSE-MsgGUID: eTe5gjd6Q1yV5yWmZZC/GQ==
Received: from mail-bn7nam10on2116.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([40.107.92.116])
  by ob1.hc6817-7.iphmx.com with ESMTP; 01 Sep 2025 02:47:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KoFDhiJ/vk/i4ScYdkPhWXbt/ZZViSOdW+4CxaoBAFhzklSDa63v2jQHyLAkJewT5gkS1NipANDhFAeSt7JxaOkk+xxViBPtYPTeYnCCGkDHAMtJoyZXJBMZO4Bu2K+byl8qkh8glTdenrawqAPqw8slGXLe9V7mXqcQBB+5K9U1xSveLKmiTKnQpGFhkQ9qAefsCZpfErpA120BjWj/SOBAI+PZbyN4QUuSgJ33H3lP3lVyvtf1ErSt2QsZjc+6DL+f4RT9w5ujVg5VRBCWduBN+SkB/ckyPkoy0f3xA0MEarv/4H34OJdGiS/w9riNhMGcPrXEuZrzzBPIr7B4cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N6RwnKMtUaNYKwL56kBBSTqbsnFsmrY8Dnjs6XH30vU=;
 b=bZWuGRi1j/ZYI3HonCfAwO9SZ6TQfY9QV6frRb6nkmZUkFBRMKg5URCd4cJbWGA+vACb1gCkXC9YbXfRIonvqksqEUqjpNJfU/kawurUXSECgpjL3gPcRWz5kMBzLWmTPQR5imPuQvdmi4ynIzduAmcfVHxexBFsF1j+jzsIsg9pJTX3N8Rqb2vgeHsitUsBdoSVWj+8tjXqUlJ+dT8eaBY71Q86JUq37Z8vAHQBtcxjV9gfCUO1/DeSjzO3yC7J09gptgk2fYQfwW3jbhyZ56FDmb7GNFCbTxlR4ScjsFv+CRLxG9PiQ1p0WMkI6MaxSXLlb6eDO0y9VAgrTLrPCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sandisk.com; dmarc=pass action=none header.from=sandisk.com;
 dkim=pass header.d=sandisk.com; arc=none
Received: from PH7PR16MB6196.namprd16.prod.outlook.com (2603:10b6:510:312::5)
 by PH7PR16MB5233.namprd16.prod.outlook.com (2603:10b6:510:2b2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.21; Mon, 1 Sep
 2025 09:47:29 +0000
Received: from PH7PR16MB6196.namprd16.prod.outlook.com
 ([fe80::d65f:a123:e86a:1d57]) by PH7PR16MB6196.namprd16.prod.outlook.com
 ([fe80::d65f:a123:e86a:1d57%7]) with mapi id 15.20.9073.021; Mon, 1 Sep 2025
 09:47:29 +0000
From: Avri Altman <Avri.Altman@sandisk.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>
CC: Ulf Hansson <ulf.hansson@linaro.org>
Subject: RE: [PATCH] mmc-utils: Warn during rpmb read-counter on expiry
Thread-Topic: [PATCH] mmc-utils: Warn during rpmb read-counter on expiry
Thread-Index: AQHcGyJ54erdZhqFVUSH4WPEuJBZY7R+FEGw
Date: Mon, 1 Sep 2025 09:47:28 +0000
Message-ID:
 <PH7PR16MB6196BBEBEA3E54F16ECE0964E507A@PH7PR16MB6196.namprd16.prod.outlook.com>
References: <31fb75e1-abf4-4fb2-b838-074edbee5423@siemens.com>
In-Reply-To: <31fb75e1-abf4-4fb2-b838-074edbee5423@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sandisk.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR16MB6196:EE_|PH7PR16MB5233:EE_
x-ms-office365-filtering-correlation-id: 9b8efe42-b43f-4d88-715f-08dde93c909d
x-ms-exchange-atpmessageproperties: SA
sndkipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Uld2MTV4L0ZzT0xzT25YNUV2M3RDRjNUUmR3QnRGTDJQU3VlWnNVa0JkR0J2?=
 =?utf-8?B?blNucEprS1FYRXRhOTk4Mnp0MDVxcXIwaW5QbVlhTFAzOStQbmhKTjN2Q2Vn?=
 =?utf-8?B?NXZ6dFhtMnhLdXBJT1lnNTU0YVV0YnFCam1IV01WYjFPMitXN3JpYlBwSXdp?=
 =?utf-8?B?bW9iZ2FUZHRDMFBjUHdlcVNoNnczZ0VCWURsbzV3a0xydzRiNkRLdHMrd1NC?=
 =?utf-8?B?LzdqT0gzbmF0NU1VRlozUUkvVUpkZ0loZ3BkU1Q0NDNvdElZSC9nd2lZMkxG?=
 =?utf-8?B?V01EZ2xHSDNWZ2JaZWNVMk9IQU54UGJMMTBaZHpZVDg3bU5YSWFGYTM5L2tM?=
 =?utf-8?B?ZWNPREdzWC9VMjZNVjkwVHNWNll0cThrbW14QXhTVDhBUVRKQzhuc0pIakEy?=
 =?utf-8?B?eWwxUWg4VHBjbzdqY1ZoNmlzemhYTjF6QWhjVTlKcFl6dnhNN1BvOU96SUVs?=
 =?utf-8?B?Mm1sanVVTmhZMyt5cS85OTJhbWRMbVZXVVkwb0ljVDdwWW44VzBpWlVlb2Nk?=
 =?utf-8?B?akFkQjN0MzJ2bXhlOFdaa3NBYVNBT3N2aVFiUVdvR1NXRGdHNno5dS8zQjRm?=
 =?utf-8?B?N3lYcHJpQVJXTks3V09iL3NBb09RWnBTcFBTVGUwNFVWT2NUNzQwbEJiUWtu?=
 =?utf-8?B?M2lWUW4zQ2FCMFh6bWY2aTVZbGh6dHNpSW1LdFoxcXprYlVpYTVyRzJPYXBo?=
 =?utf-8?B?TUcrWEQ2MEtlVEJ4U2NObmJEZk5jZnZPNWlaRnB1UWVQZTRZZmFFMXFVV1Vo?=
 =?utf-8?B?RmNjLzlkalF1TkNEWjJqMWpoVlFXamZYb2tBZXk5bVpML0NnNElXbWQ2TDdw?=
 =?utf-8?B?eUpQZkpGcXZ0K1M3cnFyYUdXTXd5MVIwRmhEWnRMb0FZb05LSHZKOG1WQlRn?=
 =?utf-8?B?UW1nNno1Q0lMWW8zZnh1K3RkTWY3dDlGNDkyTVFuck84KzQ0clJSNFV0Q1dD?=
 =?utf-8?B?eGVJeVNrRDlFem5aV2l6YkRvQUNWemE1RVRpNjlPZnA1bEs3VXZMWFZKMWVJ?=
 =?utf-8?B?WTJyNVVaRE81QW1oanJ2cHRpZDlEeWRQZlk2cmxCbnZjdkhkNnlZUXNhWFRs?=
 =?utf-8?B?NFNDa05VeGIwLzhpMDFnZFRPUlo4WGlQTHp5b3l0cHBMNTd5Q0FQRUF3dTZl?=
 =?utf-8?B?U1o4TDMwWFp2MG5zS0dZSnN3a0E0NzJtZUZoRFVybGdVVXJFZlhmWGdjbFBJ?=
 =?utf-8?B?cFhmTVpBdUhFRldlMnpyRk1jcFZxREFDQVV6ejRUVEVObHZXbXNpK09yUkZB?=
 =?utf-8?B?NzlSQ2tZbWs2eWpVV2YrcG9GNVZoaDI1Q2RRQ3F3NWt5N291aGx1a0ZjSWtV?=
 =?utf-8?B?SWc5YlhyUXorY1dDaC9SZzBJQU9VSDlDTys3VGN4cVprWkgzVTk5RFdUamlJ?=
 =?utf-8?B?andBQXVUMFdSY05lRlR3OHIrSTdOU3BXdUF6b0g0Q1RFN1A2RGRkZ0R2N3JM?=
 =?utf-8?B?SEpDRjMvaXJIWStMTjVDYlZ6VWFCL2hMeXRVYVQveElSakRtSnl0N2V1VU92?=
 =?utf-8?B?MEJQUEZwdndieEdSbTlCREMrY3dWdzZEWGNuVVdkckdRUTBPQnlWNXgzeUZI?=
 =?utf-8?B?R09JWk9Kc3M2TVNlc0tIMFZ1bTZka1F1dUx6Z3VUaEFMaHZ6V1FxVmxscE9x?=
 =?utf-8?B?UXk4RmRJSDlsem5IZTBwS3JVRFdWc1hzYjQzN0VXZThiZUp4UG4yODM1dlBL?=
 =?utf-8?B?NDM2T3o2S21zRXhFVGZFaHZ1MjlaQyt0Y3JPZlFQSExuSVVsWjJhV1oxcEl1?=
 =?utf-8?B?eGZadkxUT3VKWDFpa3lXRlZQSHFaazdhQ1hPbEZXM2dtNHZ6MEs2bGpPVlda?=
 =?utf-8?B?dlFWa2tYOGhCS1o0Rlc2dzhOY2I5OHB2VURaTlJjNGJRWUVvT2l0UlFMcVdk?=
 =?utf-8?B?QnpNT1IwZEczTm41ZDRZNTZrdmtDV2t6bG16Nkg5VHBHbXJndjNFRTIwbmhx?=
 =?utf-8?B?b3ZzbzNUOXFRWVFWd2c0ZzRGaXJHVnNjUk5lRFprQ00yZ05OaUdtWTAwaGJl?=
 =?utf-8?B?N2xuQmpwRGJRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR16MB6196.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?L1ptR3ZrSWFtZ01HS002bWpWUHBVWWhqam1COXpXMm9iZ1J0aHEzTlZRK2xJ?=
 =?utf-8?B?cW1sbXMwWUF2QzA5amQ2TzVZTVh6T3FOUjAybSt0bTdaNjUwa0prVmhxOVpx?=
 =?utf-8?B?eXJmNnpqVGdRdFdSenlhNzUzaXBYeDhsSFcrVmpJRzhmYnl1T2VEVG9vVzh1?=
 =?utf-8?B?Q2E2cVZlWWRpcWJ4WUhTdTRpemFycFk2QXp0Tjd0RkRZQ3lUTVIzZzVHcWJO?=
 =?utf-8?B?b0RrcXBPbjQzeVpqREhBdXVKVkc1QnNVZDUvS25oRzBVVWhOa2MxZ3lhUVZH?=
 =?utf-8?B?RHlNenZxV2dZUTR2emJySFoxTVhMWGZTYkU0eVlob3lpK21wb2tIRDhWZG5u?=
 =?utf-8?B?aWR4NjA4WUhFYUhSd1p0TDJLcG05Z1lNcTZmS2lDZC9GcEh3NUFGK2l5NW1M?=
 =?utf-8?B?c2dSYmZxeldodnl6dHJOMG1MNlp0M3FyVzlWVXZCMlVBSjNpMXI1WXpETSsw?=
 =?utf-8?B?Z2xKNEdnU211S3BHbE5wQjltMU1SODdCYmVJemtIUHcvanZaV0xrSktnVG91?=
 =?utf-8?B?d3ljdm5Ud1VVbXVrUjNCamtoaXN1SklGMllITFZuRG1QcHZGdytqaGRvVFBL?=
 =?utf-8?B?ZmNZVzN4U1oyeHBuSTNxeUJsNGNyOXFGeWsvb2xnV2lEakdJcDB1TmozNGht?=
 =?utf-8?B?OXdrRkQ1Q3VxeWpIZEtnMWF4T3ZQeDBta3FaNFVQM3BpcUNIZkFvV2JRK0tY?=
 =?utf-8?B?K2NZZm5CSDdvM1dsSXRtQ0kwd0c0QjhsSW5IQk92c3M5NVRUVTdNYjFPdlQ5?=
 =?utf-8?B?dmFnVHZhTkhYVVNaam55aVZsb05ldWNvdjY0UUlDMmNDcWlib0FXVUdyYlZ2?=
 =?utf-8?B?dmY0MDE1VDFQTXdrUEI2WUphbTNYTnhOUEx6ZEU0cXFHRkp3VzdtNk5JWDMw?=
 =?utf-8?B?bGxnLytNVFFCSFJudUJ0RFMzeUYyMld4QmQzU1NtSEFReHZ3cWx5MVh6Ry8v?=
 =?utf-8?B?eUFORGRYOU9TcWRKenBHMiszdEJFeHVodVFkVG1mdEdYYWNkMWs5amdhYUxU?=
 =?utf-8?B?OXFZQ01McXhVbFNxV3YvZnEyajlEOHdVbjFyVjVVYWVwanV1eWV4Rit2MFlS?=
 =?utf-8?B?K0tjQkFQaGJST2NWaUE2QWFMT2poOCsyYVNhZjQ5cnRzZ3I5SENCRVJXc29H?=
 =?utf-8?B?aXBKLzVrRVBKaVJMTXVoOWRRYWorcHhkZDVoeWhNblNKMEx0aUgrQ01Cc1JH?=
 =?utf-8?B?RXNLRktMTDVSZE1PcmhmNnhlMVU0UnRCL3J6Q0VZTTQvaVBOVWxMcmcvNmg3?=
 =?utf-8?B?WDF1YU5EUE9rajhtTmVsOXE5RFh2TG5Zci9TbzhTNTlqQncvaXBIMThPdXdN?=
 =?utf-8?B?ZndzNzk2dkR4aERRcXFDOUowNzJJWFpmSERkeXk4VGppSVJNSkZZVFBCSVlU?=
 =?utf-8?B?Qi9NYUl2dUI3aDBrRmtCYVFRRDdVaGQrSUpMQzIxbmRQTXdvWC9KWU1FZmtS?=
 =?utf-8?B?Y044ZFVuRTZJdXdhSG9YbFgyVW5OQWxzSzhpa1dqQnZRWHd2SHNUL3pXR1lI?=
 =?utf-8?B?QnBJcVlFZ3lyUFdIcVdEM2R6U3I1bjhReTR0eXJFNks5UTdqRkFvY0U2UGpK?=
 =?utf-8?B?ZTJmQkJiRDZraGFpWnVFUWJDQ1VxNVpkK3lIY1pGQkxJK1BhL2hjNEZkYm9S?=
 =?utf-8?B?U3N2WUFJbkUyVkJGeGw3YlZQZjFHMExWSG9TQmV4a1FWWUtQdC9IUFZpL28x?=
 =?utf-8?B?VFBBdEVzbHJnYmVWbVZOSEFRY1hqTUxxc3ZIb01Jc0JuRGRINkZHT0Nwcmhp?=
 =?utf-8?B?UEE5NytkVUFhZmdrbE5GeGx4bVFIbVVYNENRSDRhQVR0MENkalRlSHBVeVpt?=
 =?utf-8?B?RzgreVRHZ2txTDlBc1AydXMwSDJwTmNFTzlCZjBhMC9JMG51VHd0bENJZytO?=
 =?utf-8?B?NkZSTm5uVlRENFhYenFMaHJ2cHAzMHM3L1UwUkxna2N3R3ZRbVRoa2R4Z1oz?=
 =?utf-8?B?UnVjTDNFSFZjTlY5QXY4UW1aRzJuM05MRjN1QlZNaVZmc1QwTjJtK1YyNE5B?=
 =?utf-8?B?VktUV3IzeEhsSU10SVJMTXN1QkVFbjg2OHVtYms4Tk14UUdZankvREVnL1BZ?=
 =?utf-8?B?cGlKTlhvaEFxK3orTWFBOVZBT2YrUU9PRUhjSFZuRE11NHd0ZjRQZHFidWFr?=
 =?utf-8?Q?D5MnkMb/d4iFT1cGFGJjf81Wm?=
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
	XDPN5GErHbzb2O+i4lY+mOaDkfb/ZNdWjCL9pOy7foU5R6Ahfn9EMMMCfAvDXIDnFHXjP9XIR90cK8XhpuebJT8zPqcGTf48bQPk24tK2useX/CFzp3no5g/VRxHD6Oy8YfyQdN8LwbMTq/yYKtd6iwoU1wm/xX+W1Irb9NQKtdxkpd9rG5lMzu5NIlQLfR3Z8Hnfq3Gj+Ir6VWlYCTUOJ0t+Yo7Fl/WS5iG63SKoublA0rWmQmbxGTfIVk9DIc5HujTHD8qiB0SClgWQ0sj5ebEzHSCCxMYJiM+1p6g8/ftEUkUc18ms6eQQ+ZAKVyblATGd8dTVysgTSE2dN2hEBdm7ZsMTSB7CF32tMW6beaeZkzCH5kR9IqvEoOXivFCFof/Tk+82L9c2zcR8XBTYOwaYJvSN3twPIXeBxzCKHSxa9tIiKrDoCok2/ruOP9JC6Fq+1MI0dAJ61fO5cTj3VuJrnzTQFOs/h5m/rJoM6qOHNfyEV3StIybz/PhTnRLBOJ5MeG1wn5PFM0Ma6SWoIMeAmoDWNvC2qdXQLbk43IKZwnCDlaKClPi3F6SOHx2ln+JUIu1fxhGogBAk/Wj+8t+qDWYDJjDoecryzheJfB4Gf3VaM48WGbKA/2mDgjx2ocpUFh/PzXCpHFiRaU/OQ==
X-OriginatorOrg: sandisk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR16MB6196.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b8efe42-b43f-4d88-715f-08dde93c909d
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2025 09:47:28.9696
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ffe0ff2-35d0-407e-a107-79fc32e84ec4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VsmCg2AT+Mwt4smaFMisCo1nTEv1Okch4pTjOe1R2+kpILEF3z1H8+F0AMtWa5ZgWaxs4I3h2J3Nxh7k+le4ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR16MB5233

PiBGcm9tOiBKYW4gS2lzemthIDxqYW4ua2lzemthQHNpZW1lbnMuY29tPg0KPiANCj4gV2hlbiB0
aGUgY291bnRlciByZWFjaGVkIGl0cyBsaW1pdCwgYW55IGZ1cnRoZXIgd3JpdGUgcmVxdWVzdCB3
aWxsIGJlDQo+IHJlamVjdGVkIGJ5IHRoZSBkZXZpY2UuIFdhcm4gdGhlIHVzZXIgaW4gdGhhdCBj
YXNlIHdoaWxlIHNob3dpbmcgdGhlDQo+IGNvdW50ZXIgdmFsdWUuDQo+IA0KPiBTdWdnZXN0ZWQg
Ynk6IEF2cmkgQWx0bWFuIDxBdnJpLkFsdG1hbkBzYW5kaXNrLmNvbT4NCj4gU2lnbmVkLW9mZi1i
eTogSmFuIEtpc3prYSA8amFuLmtpc3prYUBzaWVtZW5zLmNvbT4NClJldmlld2VkLWJ5OiBBdnJp
IEFsdG1hbiA8YXZyaS5hbHRtYW5Ac2FuZGlzay5jb20+DQoNCg0KPiAtLS0NCj4gIG1tY19jbWRz
LmMgfCAyICsrDQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZm
IC0tZ2l0IGEvbW1jX2NtZHMuYyBiL21tY19jbWRzLmMNCj4gaW5kZXggNDI5YTljNy4uNTk5MDUw
MiAxMDA2NDQNCj4gLS0tIGEvbW1jX2NtZHMuYw0KPiArKysgYi9tbWNfY21kcy5jDQo+IEBAIC0y
MzYwLDYgKzIzNjAsOCBAQCBpbnQgZG9fcnBtYl9yZWFkX2NvdW50ZXIoaW50IG5hcmdzLCBjaGFy
ICoqYXJndikNCj4gICAgICAgICBjbG9zZShkZXZfZmQpOw0KPiANCj4gICAgICAgICBwcmludGYo
IkNvdW50ZXIgdmFsdWU6IDB4JTA4eFxuIiwgY250KTsNCj4gKyAgICAgICBpZiAoY250ID09IDB4
ZmZmZmZmZmYpDQo+ICsgICAgICAgICAgICAgICBwcmludGYoIldBUk5JTkc6IENvdW50ZXIgZXhw
aXJlZCwgbm8gZnVydGhlciB3cml0ZXMgcG9zc2libGVcbiIpOw0KPiANCj4gICAgICAgICByZXR1
cm4gcmV0Ow0KPiAgfQ0KPiAtLQ0KPiAyLjQzLjANCg==
