Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B6126AC1
	for <linux-mmc@vger.kernel.org>; Thu, 22 Aug 2024 13:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724332621; cv=fail; b=EulMtRENTXncUSCzFebprahVX2MnFW1lrt41oSz29AMF2xZaNlfMQnQyst88MvEpPJqA1Oz6WmKcyIPkcEQwoWE1m6FBQ/GmekXTuJmttdgsLN+HetU3AS6T1uvbWVYHl5shohlBNtGVZNIoBjOLoJaMuAxputOi7cOJyXB/MO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724332621; c=relaxed/simple;
	bh=O+CS2yAVA1aiUT3BqCcqLKqMLom6X6n2ZNNhN2s6yUc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ifcoj3fUQIq1yUm/WWTTpKB6uBUfJUHqMdVVqBVGWOSr59QwqRvLtROENcLM5Ff5uuKO+atcCeBZ5qHNDnlVQMLrvFUY+0ziRXIbLnsxZqTqXe9Eg+sn98gtx2wWU+Vn8AA6XNOuI62PIjQH9dbAuQdpUa3yfkRsfxVTCjgw6Us=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=YagZ+2fv; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Rmh9JXIX; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="YagZ+2fv";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Rmh9JXIX"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1724332619; x=1755868619;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=O+CS2yAVA1aiUT3BqCcqLKqMLom6X6n2ZNNhN2s6yUc=;
  b=YagZ+2fvmbLH+tB4svZTE/If6hh2AKpSXx8Gphfo7PmQBO2SKSPGY7vj
   eHd/JYpc2Y6Ycy8M53yt02AX9zcuAETq3l+p+uElErdtnVprB+/nKobHM
   tdtHZDa7S5B9TmwoJbhENKVm1pG4RCYm1KzFFBdujCLEOU6d5Dtq9kbOA
   C0xwjUilweNzca/J0hXcZo/szfae7Qj48sk9hooHigBCdx7ctfqsclzLY
   spMPkn/MpWwsCPolsPZfN8mUZQYvNvKfa2dBbDM8gb2AEnpJsgcwPHpcQ
   OSgYOwBQ8zrq7j0fRzNRWVBdtC4dCLon/RtLq3JhqtnOotVhaAeas/eNx
   w==;
X-CSE-ConnectionGUID: S8vM6Y9iSLusfOgPStvR8Q==
X-CSE-MsgGUID: RdwrKu9nQfOiW9C6YDQeaA==
X-IronPort-AV: E=Sophos;i="6.10,167,1719849600"; 
   d="scan'208";a="25659974"
Received: from mail-mw2nam10lp2040.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.40])
  by ob1.hgst.iphmx.com with ESMTP; 22 Aug 2024 21:16:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zDnsSojTujbyF9pEkGdCJ3+Nyawv0eCsk/Eun3xorDU3/4hDVeZs+BzeRBqyE2bkA53Nr262Pz1ZwD5GmQZ6fTlkBVWg4UsMPKXJS8qnrqxynQB1y6t9/jUvHtNV9HKpyc5SCNDeugN+6ubG72nquMm98dnpa7xILQId4DOGSkAoaFMPb6OcE90ivW7J+ObDuzMlw6PNWkk6A09BWBhznXr6vFtT0QVjg0KZz1g2bFzqMA1zpuUrBLO4A9lZhAByqtWMgPaZ1I9mCNfRHBCyGD5aEv8sUwzmxJd0VSLO/bl+7+mqZur/42qMTEDpeOWc+ssu0Pq3fxh1HYJiQEUtUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O+CS2yAVA1aiUT3BqCcqLKqMLom6X6n2ZNNhN2s6yUc=;
 b=kbvcpGyujvXpU2opoeD3kiTRQIMKr8Iv5Dj7lvEtyptxvDMO5jQq/F+D07+JluZdeFBaOvfAB33ZM5tsv9zXm7TSL0aF9b7MjC1RgwQIfTGYsfHI9IbCcgzMzfn1Kfnvteyvb++zjz6xNHx3jWz44ettFlNzzwsKKiMu1gxxRMbSkyQ+5b6F6CV4W+tYr+K/nkbNIkDMPw3b8euuWEjmNwo5F/gb2lQIwHHPps1zn7mp/LDCqVhTLxpVLwKMpm8ppDzlJeTHSLP56Aq8PuIpOmrU5dBOe6rp6UEWOlpaa8nHUyptAPYrvh9cdeA82mcIpMZw8sAA5NNherbNKAPnDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O+CS2yAVA1aiUT3BqCcqLKqMLom6X6n2ZNNhN2s6yUc=;
 b=Rmh9JXIXGyuzVsPPBifplCmJRp9Jen7iXiosSWd7sT/WohEA1T0q34DYi4zhRG4rFKnxW4bnge3QimWTCjAuidAfRS3paRQe9/Z7IVoGgCLEeGwjOuwJVq0gxqXUs+rOodrRfLVGZ+GYHadzlYXy8yQZTwXTrGLYJEZ4KwSSZQI=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 DM8PR04MB8183.namprd04.prod.outlook.com (2603:10b6:8:2::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.21; Thu, 22 Aug 2024 13:16:56 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f%3]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 13:16:56 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ricky WU
	<ricky_wu@realtek.com>
Subject: RE: [PATCH v3 01/10] mmc: sd: SDUC Support Recognition
Thread-Topic: [PATCH v3 01/10] mmc: sd: SDUC Support Recognition
Thread-Index: AQHa7hv5Ydq9RlOAV0W/wH5xYncXY7IzNPcAgAAVdeA=
Date: Thu, 22 Aug 2024 13:16:56 +0000
Message-ID:
 <DM6PR04MB65758AA7B324B1E6F1BD29C7FC8F2@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20240814072934.2559911-1-avri.altman@wdc.com>
 <20240814072934.2559911-2-avri.altman@wdc.com>
 <CAPDyKFqafoeiBSAbU30d0jMUJPHvED3Z7khz6rqpn_NAgYurDw@mail.gmail.com>
In-Reply-To:
 <CAPDyKFqafoeiBSAbU30d0jMUJPHvED3Z7khz6rqpn_NAgYurDw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|DM8PR04MB8183:EE_
x-ms-office365-filtering-correlation-id: ebf5d57c-d8da-4459-e47f-08dcc2acb293
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MUxmR3lqek15b0ZlakNhc25xdmpsUTQ4QkwxTmxZanNZTWl6Nk51TTNFM0Zs?=
 =?utf-8?B?UFo1VnhKWklhcDFFNjMra2htSklKcGZBUWJxZFR2cFhSamIveU00bE9uOExa?=
 =?utf-8?B?STkvTW54dkx4NTBoNzROaTNDa1pFZ2JVZkJwbzNVdEEvdzcvVk5XeFRFano2?=
 =?utf-8?B?Tm9EMDd3UWk0MlVaSnE0VHdyQzE1bURNUDNFa05vKzZOL1NjQWpsUDlPQ2ZH?=
 =?utf-8?B?djBEU0hRaTBZSWl5cFo2K1VoMFc2OEc1ZUlMMmVTSFBIbG4ya2l6RzBRR0hR?=
 =?utf-8?B?RXUxVmtvTVRLV0JKazhxYnZ6TGYwMjgvdEJ5YTVSTjk2bUpIVU9rb0ZYNkVG?=
 =?utf-8?B?c0piUlFXYlV6Y0RGdVZnUE5MZ2RHNi9kL3FMQmg4cGJ5YU9WWERJWk9YZmxI?=
 =?utf-8?B?TG1LeEdpY2FNU2FSazkzdFRKdi8yVHJNSmdUMDcrekNwVnI0RFRRYUtGRVlM?=
 =?utf-8?B?Q1FiSU52ZGsvN015cnFYMnowNVNlRm9rbGhQTGZBaE5wZjhwVktUN1B3ZEdO?=
 =?utf-8?B?MzZhdFoxWUtKRktoY1VyLzRyWUw0OWI1bTJpbVpnSFJzQ0Fydmx5a1d3d2x0?=
 =?utf-8?B?NUFXakJvSm82NWxIbnE0Qlh1MG1KbkpnUW83eDZhTFUwKzJIMEo0SEM4QnRX?=
 =?utf-8?B?bzNMUlIyMGoyUjVzZzBFYkJPWnBIZ0ZsREFaYzk1Qlg4VTg1YlZQSm9zUENJ?=
 =?utf-8?B?RlZrcVNycExaTXM3NERGVVFCbVgyQU96aEhpeG5VY3Z3YmlXK1BVZ2U1SmtJ?=
 =?utf-8?B?bndxQXNETFFwN2RYRHlrd2xaaU5aWnBoVlhIWlhDemIxRWN1K25vc3hqemlF?=
 =?utf-8?B?azd3andsdWNid2c5eHdCbnRvMU9BTG9pYXF4anY0N0ZwVzVVUXNQbUt5WUtN?=
 =?utf-8?B?cGVBLzkzYjdDbUF2MTYwcHNEQkcvT2ZyYWp1ME5icytpZlVQYWxxNUYrTGNP?=
 =?utf-8?B?VmVEdzF0QzF1SXA0WHBLSEZWcGFPbjZoZ2VsM3VQVGNVcHNZdXJXcUltemNi?=
 =?utf-8?B?TGZxMTV3WmRxbDVONVhjVXAwL1VYUEdWajRXZVZlNHVHVnBhdEpXNlhKN25Y?=
 =?utf-8?B?a2puVm50QjJpQnNXWmY2Yk9ySkpBdlVCbEJQU1ZoYWRpUGtPcysrektMTnNV?=
 =?utf-8?B?Z2ErdzRibEFTNkhxZFNib3dXVUU0NEUwQkN5aFBxZnphNkJDbGl1RjkrWWJw?=
 =?utf-8?B?d1B6ZkRWOTA3NHAwemlIdUlwOTEvbmJMMldteXBFanpsOVlpeU1BWENjSCtX?=
 =?utf-8?B?ZGs2elpWYk0yazN6Nk00UE96RXYwaEl6bm0vOEZjL09lSFExVWNzY29kUFpy?=
 =?utf-8?B?dXRaNmJuK0h1Uzh2Q3hvMFgrTHVURjVXcG5OSWdUS29QMDVyY1cxRDROcHFE?=
 =?utf-8?B?MFNwdXhYZG45ZjR5MU10TENlQWxZdTFpYkk1TFNLaHhKUVdsL2owVXpoTVQy?=
 =?utf-8?B?emhYdVBsVTUwMFhKK0dmTFhQTjIrVmZnNnQyYXBzYUNiNUExMEp1cXR5ckdI?=
 =?utf-8?B?Q1FIeG9MdVlWbzhCVmpiQlB3MjFPRlN1WTRRQUZ1cUlxVzV4dG9CQlcybXBO?=
 =?utf-8?B?ZXdIU0Z0THhBN0lBNURObUNESldhZ1o0cTFBS0tJdXNyM1prdHhlTTNrdXYz?=
 =?utf-8?B?TVRPc3paNzJmTGNhbzJoeStwSzlDRTJFa2Y5MTUyWk9ycmxqNHpkVG44eFp2?=
 =?utf-8?B?Zy9hWXNRck1RSWlxdUtNV2NjcEYySGlYYkJRSkEzdW5WSkIvaEpkdk9PRHlv?=
 =?utf-8?B?cmJFV01CalhqNGFXTTNyWnNXRzJyWS8wd2M2K0VIR0xsbnhNMUlFeE1UdWl0?=
 =?utf-8?B?SWNDdnhIQ0RSOE50UEJ3d1Y1dkVWQ2JBVHRrN3BGeTJkWGw2aEs0MUVodTV1?=
 =?utf-8?B?S2JuaEExdUhDNHlGMEwxODhmSCtmTHJHQ0lnYnNlMFJrcXc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NnpyMGRad254R3hNNW5tdWV1MEJzdXgyczFmSUx0UlBqRU9IL1lXYmRhVUlM?=
 =?utf-8?B?d3JIT1Z0WlNhYW5EQ3dLWlB1b3VBU2xqeWhoZHZiMUcwY0hYWVlBWTdnZ2pT?=
 =?utf-8?B?QWRwMXJLc054STNrdlpnT0Jjampob3c1WjBTZ3Ntdm9SMkdVUTh4Y2hJdnZ3?=
 =?utf-8?B?cEp0OHpKOHNybDJQaHRVb0QrOUt6ZFNtTlp2UUE4bzl5OGFhM2lVQ2Z2U2t5?=
 =?utf-8?B?WGU0ME9lL3JiWmxvOEZhaEl5YTdrdlh5MkJ5NnVKaWUySCt0MytaS0d4cUx2?=
 =?utf-8?B?YjVkeVNkR1Vlbjh6NEtIZVF3ck0wNUorV0tlcU5TNGVnMVVHU29qYlJPR3hW?=
 =?utf-8?B?MExzdzArTHloM2FYRFlYdTVDcExhOUo4VEd5VzVkaFNNYmtuMFdvSlNITDYx?=
 =?utf-8?B?VDE3UUtia3VHK2dobVJORXBweUZCd2Y3a3F0S2tsRERJVTFJWTZDMmdZWjRZ?=
 =?utf-8?B?L2JlUVRYTEc1TTZ5VG41V09vVGZySm5sSnRnQW1RQ2NGK2hPOWc3b2JNQnlh?=
 =?utf-8?B?aG9zdTdIM1Y1UXJDTUVwdUVZNmhzZjdQU3ZzV3ZPK0NjSEdpOVhwcGpzNkY5?=
 =?utf-8?B?MUU1THRPZnNKNTFuZnNHcnBiQURmR0xCQlFxNWNWMEEzQXVCMG9iVStaOVJS?=
 =?utf-8?B?Nk5ZRUxFeWw0N2EvMC9OclhDRWRlcFVmRENYQTI1WklkNDJRQ014ZnJLM3Ft?=
 =?utf-8?B?NVo4K2FRQlZDU2ZVYi9hRXUxYnlRb1RCLzZ3cWdDSEJteHNldkQvYjFqalEv?=
 =?utf-8?B?RCtvYTJoREVFd0lkem9MMHo2ZXFVbmhWV0JWb2tBSmx3M3hRT1FRQ1J2RDhL?=
 =?utf-8?B?aVNvRHlOV1huazVtY01YMm1GVmlGNU1GWGtiOEc5aHdlQ2F4YjJ0dEdUODFU?=
 =?utf-8?B?ZjhXY2NBd3U0RE5KN21RSG1xN0p6dDdFdU0wZ3JXK1BJeS9ITjRrZnNneElB?=
 =?utf-8?B?TFpkOWZVdnh4YzF4eitZMEdqWC9mZ0Y0eFJGS1Q4TlZHakViSWZKb2Q3TnNV?=
 =?utf-8?B?RWxacStTK3BGUXlndG5SdWhxckRCQkl0MUxSYnBvOWxEOGppd1k5ams5dVlD?=
 =?utf-8?B?cW9sbEtPVTNlemQ4VFJPVTdUQ0ZDOHovQWJOMThEQ3M4bDZXeW5pZ3RUOTZm?=
 =?utf-8?B?SDZBUkJ3YzBmWWhIR2NEK1Jwd1h1QSs3ZkJMa21JU1ZYYXlpOVpQN3Fyd3Mw?=
 =?utf-8?B?MmFTTEVtSDk2aGR6Wi9YdWpZeDlrRGpJVW0wbXh1MXNJL0dIUFFQTW4xbDVw?=
 =?utf-8?B?V1FHZ2ViSHE4QXVqZmFFQmwySDRWN0pTOForK2ZUSDY2MU1ZQ0pnbW5EQ3dK?=
 =?utf-8?B?RkVha0JLdU9nQU1KWTkvRXBWdlJzcE9ZVElTSVltNWRiejBtTFhxOGYxQ3do?=
 =?utf-8?B?S1lsbGF1MFIrZ2RYNVVCYVRjV05RcUUvbFp6dG13N2RzU2E5VE5DY1JJbUk2?=
 =?utf-8?B?N3I3dGVrVk5XQzYvb05SMHhOakE4dldQS0pEVk04N01YU0xMNEN4S1E4UVFS?=
 =?utf-8?B?a1lFTjZibjJDU1lBZmNzRUtZUE55bzU5cWE2R2JuQWZGSVJsTDNuRHZRMktK?=
 =?utf-8?B?amtobi9WQ3k0bXdHZEU4dStlU2prd0ZvTUQ1V0xqSG1lL1Zkd0wweWtBRUI5?=
 =?utf-8?B?QWkrTUpZVUVFK1lHaHVMUXFibTFHRDZHWEhGemNSdkJ2VE9lcitjc2pnN096?=
 =?utf-8?B?bjhvZVBSd0hxVXJwZGpFUE9ZdU02VFY3N2VucnBkRkR2d2NnV0xTN29YWm9I?=
 =?utf-8?B?WXhadnVIQVErd3FIRis2OEZjWmNYbDBFMStwdWZqQU1CcXR4bjVVbjdNc3lR?=
 =?utf-8?B?MC82WEkzekl6MkJqZzVIL09kZVlDVUpJclg1ZWs1NmFnMDBOcUhILzcwSmNp?=
 =?utf-8?B?UlRTbTdORndkVXNjYjNBek5GZXAyZ3hpMHBKN1h1UDFVSnNFYk5ZaFNXVURN?=
 =?utf-8?B?ZkliM2NhbzFXVnF5TFdUd0p0ejFuWHE2V2ErSmt3d0VlVjZtZGNDbHhab204?=
 =?utf-8?B?eXc4WStxVmpYM3hrMStCSkdoc2trMERtdXp1Y2tsanJ4b1ZYME9INVc0QUxX?=
 =?utf-8?B?SGFyVTkxbVNqRmFyY0JLZEtEb0MxcFc4K1VaeW0zWnUzaEtxVi9DcUZzRkNS?=
 =?utf-8?B?UDl2K3k4NnRiQ3lXVnRkdm5EaXMwRGxROS85S2J6NEN3M252dnRZbEQrbW5U?=
 =?utf-8?Q?DTY7GCC0mUE3kcl3HBw8v+SMaABbrpbHrPExYevkBK7+?=
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
	f0/1y5TApIZVEXEDkDdQjvdjc47YEIxtbPsD83BOnoOdzxc9BkDdksk0Ky4iC19+7+r+2x1fR+ATuvO3SgTzHru3iHnBUnWbLlgxmvJbv4lkSieF9zyCOS5JSB2tE5J/8lPUoUQFcGGLZqCSfnDnD2ZLpykq0mE0Q04Shpq+j/fdVuJsi6//KEZlYXagww+K586atIL8cBR2sCFprIc319Rdg3SRrDKuItvrbYi5Rh9KVZBTz3gRJsG5Mor/vhWQ7FC/iL7xlpDR5sr9QIbvcrgJ/Tt6sthlOj/Mem79IBBZE6H7y4u7rXF8TGICpiTTm49r4+DDdW8zS5QBreIrocZRTiwNhRzV+WMFoQKeTfpaiS0AA59vSp2jljhZleJ494itjiQsaqftAObf7ps+EOJUVy4d+aLMNNg4DNmurMJKPqC/jyeKOmQQyDRfqhOghfxuPljMTAZQiY3JKOFb1t4J0KGS7V7fvAh5NwnC2kFoyzzbIxvG/mhvscVtJfFfCPlSabecd4EfXohVzVA11A7XuVbysgWYv6pFlMhMtajzLYzkYfpK2AaIv0a9uIS+hzJ1uMBk+tuDGA/KCbRIV68OjEsiWcn7HgBAj/iP9euoShr41lE+bUxmt5aA6roO
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebf5d57c-d8da-4459-e47f-08dcc2acb293
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2024 13:16:56.5518
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j+QKc43pyvgFPq/z4Ke41NLekXlGp5dzrCd1ISrOJbf/vQEgOsza8yidrLygYFHTXQdf0zSDoG5kyGEAV6qmhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB8183

PiBPbiBXZWQsIDE0IEF1ZyAyMDI0IGF0IDA5OjMxLCBBdnJpIEFsdG1hbiA8YXZyaS5hbHRtYW5A
d2RjLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBBQ01ENDEgd2FzIGV4dGVuZGVkIHRvIHN1cHBvcnQg
dGhlIGhvc3QtY2FyZCBoYW5kc2hha2UgZHVyaW5nDQo+ID4gaW5pdGlhbGl6YXRpb24uICBUaGUg
Y2FyZCBleHBlY3RzIHRoYXQgdGhlIEhDUyAmIEhPMlQgYml0cyB0byBiZSBzZXQNCj4gPiBpbiB0
aGUgY29tbWFuZCBhcmd1bWVudCwgYW5kIHNldHMgdGhlIGFwcGxpY2FibGUgYml0cyBpbiB0aGUg
UjMNCj4gPiByZXR1cm5lZCByZXNwb25zZS4gIE9uIHRoZSBjb250cmFyeSwgaWYgYSBTRFVDIGNh
cmQgaXMgaW5zZXJ0ZWQgdG8gYQ0KPiA+IG5vbi1zdXBwb3J0aW5nIGhvc3QsIGl0IHdpbGwgbmV2
ZXIgcmVzcG9uZCB0byB0aGlzIEFDTUQ0MSB1bnRpbA0KPiA+IGV2ZW50dWFsbHksIHRoZSBob3N0
IHdpbGwgdGltZWQgb3V0IGFuZCBnaXZlIHVwLg0KPiA+DQo+ID4gVGVzdGVkLWJ5OiBSaWNreSBX
VSA8cmlja3lfd3VAcmVhbHRlay5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogQXZyaSBBbHRtYW4g
PGF2cmkuYWx0bWFuQHdkYy5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvbW1jL2NvcmUvc2Rf
b3BzLmMgfCAxOSArKysrKysrKysrKysrKystLS0tDQo+ID4gaW5jbHVkZS9saW51eC9tbWMvaG9z
dC5oICB8ICA2ICsrKysrKw0KPiA+ICBpbmNsdWRlL2xpbnV4L21tYy9zZC5oICAgIHwgIDEgKw0K
PiA+ICAzIGZpbGVzIGNoYW5nZWQsIDIyIGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+
ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvY29yZS9zZF9vcHMuYyBiL2RyaXZlcnMv
bW1jL2NvcmUvc2Rfb3BzLmMNCj4gPiBpbmRleCA4YjliMzQyODZlZjMuLjdmNjk2M2RhYzg3MyAx
MDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL21tYy9jb3JlL3NkX29wcy5jDQo+ID4gKysrIGIvZHJp
dmVycy9tbWMvY29yZS9zZF9vcHMuYw0KPiA+IEBAIC0xNjgsMTIgKzE2OCwxNiBAQCBpbnQgbW1j
X3NlbmRfYXBwX29wX2NvbmQoc3RydWN0IG1tY19ob3N0DQo+ICpob3N0LCB1MzIgb2NyLCB1MzIg
KnJvY3IpDQo+ID4gICAgICAgICAgICAgICAgIC5jbWQgPSAmY21kDQo+ID4gICAgICAgICB9Ow0K
PiA+ICAgICAgICAgaW50IGVycjsNCj4gPiArICAgICAgIHUzMiBzZHVjX2FyZyA9IFNEX09DUl9D
Q1MgfCBTRF9PQ1JfMlQ7DQo+ID4NCj4gPiAgICAgICAgIGNtZC5vcGNvZGUgPSBTRF9BUFBfT1Bf
Q09ORDsNCj4gPiArICAgICAgIGNtZC5hcmcgPSBvY3I7DQo+ID4gKw0KPiA+ICAgICAgICAgaWYg
KG1tY19ob3N0X2lzX3NwaShob3N0KSkNCj4gPiAtICAgICAgICAgICAgICAgY21kLmFyZyA9IG9j
ciAmICgxIDw8IDMwKTsgLyogU1BJIG9ubHkgZGVmaW5lcyBvbmUgYml0ICovDQo+ID4gKyAgICAg
ICAgICAgICAgIGNtZC5hcmcgJj0gKDEgPDwgMzApOyAvKiBTUEkgb25seSBkZWZpbmVzIG9uZSBi
aXQgKi8NCj4gPiAgICAgICAgIGVsc2UNCj4gPiAtICAgICAgICAgICAgICAgY21kLmFyZyA9IG9j
cjsNCj4gPiArICAgICAgICAgICAgICAgY21kLmFyZyB8PSBzZHVjX2FyZzsNCj4gPiArDQo+IA0K
PiBUaGlzIGNvZGUgZG9lc24ndCBiZWxvbmcgaW4gbW1jX3NlbmRfYXBwX29wX2NvbmQoKSwgYnV0
IHJhdGhlciBpbg0KPiBtbWNfc2RfZ2V0X2NpZCgpLCB3aGljaCBpcyB3aGVyZSB3ZSBhZGQgb25l
IHZhcmlvdXMgT0NSIGJpdHMgYmVmb3JlIHdlIGNhbGwNCj4gbW1jX3NlbmRfYXBwX29wX2NvbmQo
KSB3aXRoIGl0Lg0KPiANCj4gRm9yIGV4YW1wbGUsIGlmIHRoZSByZXNwb25zZSBvZiB0aGUgU0Rf
U0VORF9JRl9DT05EIGNvbW1hbmRzIGluZGljYXRlcw0KPiBhbiBTRCAyLjAgY29tcGxpYW50IGNh
cmQsIHdlIHRhZyBvbiB0aGUgU0RfT0NSX0NDUyBiaXQuIEl0IGxvb2tzIGxpa2UgdGhhdA0KPiBu
ZWVkcyB0byBiZSBleHRlbmRlZCB0byB0aGUgU0RfT0NSXzJUIGJpdCB0b28uDQpPSy4NCg0KPiAN
Cj4gPiAgICAgICAgIGNtZC5mbGFncyA9IE1NQ19SU1BfU1BJX1IxIHwgTU1DX1JTUF9SMyB8IE1N
Q19DTURfQkNSOw0KPiA+DQo+ID4gICAgICAgICBlcnIgPSBfX21tY19wb2xsX2Zvcl9idXN5KGhv
c3QsIFNEX0FQUF9PUF9DT05EX1BFUklPRF9VUywgQEANCj4gPiAtMTgyLDggKzE4NiwxNSBAQCBp
bnQgbW1jX3NlbmRfYXBwX29wX2NvbmQoc3RydWN0IG1tY19ob3N0ICpob3N0LA0KPiB1MzIgb2Ny
LCB1MzIgKnJvY3IpDQo+ID4gICAgICAgICBpZiAoZXJyKQ0KPiA+ICAgICAgICAgICAgICAgICBy
ZXR1cm4gZXJyOw0KPiA+DQo+ID4gLSAgICAgICBpZiAocm9jciAmJiAhbW1jX2hvc3RfaXNfc3Bp
KGhvc3QpKQ0KPiA+IC0gICAgICAgICAgICAgICAqcm9jciA9IGNtZC5yZXNwWzBdOw0KPiA+ICsg
ICAgICAgaWYgKCFtbWNfaG9zdF9pc19zcGkoaG9zdCkpIHsNCj4gPiArICAgICAgICAgICAgICAg
aWYgKHJvY3IpDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgKnJvY3IgPSBjbWQucmVzcFsw
XTsNCj4gPiArDQo+ID4gKyAgICAgICAgICAgICAgIGlmICgoY21kLnJlc3BbMF0gJiBzZHVjX2Fy
ZykgPT0gc2R1Y19hcmcpDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgaG9zdC0+Y2FwczIg
fD0gTU1DX0NBUDJfU0RfU0RVQzsNCj4gPiArICAgICAgICAgICAgICAgZWxzZQ0KPiA+ICsgICAg
ICAgICAgICAgICAgICAgICAgIGhvc3QtPmNhcHMyICY9IH5NTUNfQ0FQMl9TRF9TRFVDOw0KPiAN
Cj4gUGxlYXNlIGRvbid0IGFidXNlIHRoZSBob3N0LT5jYXBzMiBmb3IgdGhpcyBwdXJwb3NlLg0K
PiANCj4gSW5zdGVhZCBsZXQncyBrZWVwIHVzaW5nIHRoZSBjYXJkLT5zdGF0ZSB0byBrZWVwIHRy
YWNrIG9mIHdoYXQgdHlwZSBvZiBjYXJkIHRoaXMNCj4gaXMuIFlvdSBtYXkgaGF2ZSBhIGxvb2sg
YXQgaG93IHRoZSBNTUNfQ0FSRF9TRFhDIGJpdCBpcyBiZWluZyB1c2VkIGFuZA0KPiBqdXN0IGZv
bGxvdyB0aGF0IGJlaGF2aW91ciBmb3IgdGhlIFNEVUMgY2FyZHMgdG9vLg0KPiANCj4gTW9yZW92
ZXIsIHJhdGhlciB0aGFuIGFzc2lnbmluZyBjYXJkLT5zdGF0ZSBhdCB0aGlzIHBvaW50LCBsZXQn
cyBkbyB0aGF0IGZyb20NCj4gbW1jX2RlY29kZV9jc2QoKSBpbnN0ZWFkLCB3aGVuIHdlIHJlYWxp
emUgdGhhdCB0aGUgY2FyZCBzdXBwb3J0cyB0aGUgbmV3DQo+IENTRCBzdHJ1Y3R1cmUgdmVyc2lv
biAzLg0KSnVzdCB0byByZWNhcCAtIHNvIHdlIGFyZSBhbGwgb24gdGhlIHNhbWUgcGFnZToNClJp
Y2t5IHN1Z2dlc3RlZCB0aGlzIGluIHYxIGFzIHdlbGwuDQpBbmQgd2UgaGFkIGEgZGlzY3Vzc2lv
biBpZiB3ZSBzaG91bGQgdXNlIHRoZSBzdGF0ZSBmaWVsZCB0byBpbmRpY2F0ZSB0aGUgY2FyZCB0
eXBlLg0KSG93ZXZlciwgUmlja3kgaGFkIHNvbWUgZ29vZCBwb2ludCB3aHkgaXQgc2hvdWxkIGJl
IGhlcmU6DQoiLi4uDQpJIHRoaW5rIGhvc3QtPmNhcHMyIGlzIGZvciBob3N0IHRvIGNsYWltIGNh
cHMsIGhlcmUgY2FuIGp1c3QgY2FsbCBtbWNfY2FyZF9zZXRfdWx0X2NhcGFjaXR5PyANCkRvbid0
IG5lZWQgdG8gd2FpdCBjc2QsIGJlY2F1c2UgU0RYQyBhbmQgU0RIQyBuZWVkIHRvIGlkZW50aWZ5
IGJ5IGNhcGFjaXR5LCBidXQgU0RVQyBjYW4gYmUgaWRlbnRpZmllZCBoZXJlDQpBbmQgYWxsIHlv
dXIgbW1jX2NhcmRfaXNfc2R1YygpIEkgdGhpbmsgY2hhbmdlIHRvIG1tY19jYXJkX3VsdF9jYXBh
Y2l0eSgpIHRvIGtub3cgdGhlIGNhcmQgdHlwZQ0KLi4uIg0KVGhpcyBpcyBiZWNhdXNlIGFjY29y
ZGluZyB0byB0aGUgc3BlYywgU0RVQyBpZGVudGlmaWNhdGlvbiBpcyBub3QgbWFuZGF0ZWQgYnkg
aXRzIGNhcGFjaXR5LCBidXQgcmF0aGVyIGJ5IHRoZSByb2NyLg0KDQpJIHdpbGwgZm9sbG93IHlv
dXIgc3VnZ2VzdGlvbiB0byBzcXVhc2ggMSAmIDIgYW5kIHNldCB1bHQgY2FwYWNpdHkgYmFzZWQg
b24gdGhlIHJvY3IuDQoNClRoYW5rcywNCkF2cmkNCj4gDQo+ID4gKyAgICAgICB9DQo+ID4NCj4g
PiAgICAgICAgIHJldHVybiAwOw0KPiA+ICB9DQo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGlu
dXgvbW1jL2hvc3QuaCBiL2luY2x1ZGUvbGludXgvbW1jL2hvc3QuaCBpbmRleA0KPiA+IDg4YzZh
NzYwNDJlZS4uYTljMzZhM2UxYTEwIDEwMDY0NA0KPiA+IC0tLSBhL2luY2x1ZGUvbGludXgvbW1j
L2hvc3QuaA0KPiA+ICsrKyBiL2luY2x1ZGUvbGludXgvbW1jL2hvc3QuaA0KPiA+IEBAIC00Mjcs
NiArNDI3LDcgQEAgc3RydWN0IG1tY19ob3N0IHsNCj4gPiAgI2RlZmluZSBNTUNfQ0FQMl9DUllQ
VE8gICAgICAgICAgICAgICAgMA0KPiA+ICAjZW5kaWYNCj4gPiAgI2RlZmluZSBNTUNfQ0FQMl9B
TFRfR1BUX1RFR1JBICgxIDw8IDI4KSAgICAgICAvKiBIb3N0IHdpdGggZU1NQyB0aGF0DQo+IGhh
cyBHUFQgZW50cnkgYXQgYSBub24tc3RhbmRhcmQgbG9jYXRpb24gKi8NCj4gPiArI2RlZmluZSBN
TUNfQ0FQMl9TRF9TRFVDICAgICAgICgxIDw8IDI5KSAgICAgICAvKiBTRCBvdmVyIDJUQiAqLw0K
PiA+DQo+ID4gICAgICAgICBpbnQgICAgICAgICAgICAgICAgICAgICBmaXhlZF9kcnZfdHlwZTsg
LyogZml4ZWQgZHJpdmVyIHR5cGUgZm9yIG5vbi1yZW1vdmFibGUNCj4gbWVkaWEgKi8NCj4gPg0K
PiA+IEBAIC02MzgsNiArNjM5LDExIEBAIHN0YXRpYyBpbmxpbmUgaW50IG1tY19jYXJkX3Vocyhz
dHJ1Y3QgbW1jX2NhcmQNCj4gKmNhcmQpDQo+ID4gICAgICAgICAgICAgICAgIGNhcmQtPmhvc3Qt
Pmlvcy50aW1pbmcgPD0gTU1DX1RJTUlOR19VSFNfRERSNTA7ICB9DQo+ID4NCj4gPiArc3RhdGlj
IGlubGluZSBpbnQgbW1jX2NhcmRfaXNfc2R1YyhzdHJ1Y3QgbW1jX2hvc3QgKmhvc3QpIHsNCj4g
PiArICAgICAgIHJldHVybiBob3N0LT5jYXBzMiAmIE1NQ19DQVAyX1NEX1NEVUM7IH0NCj4gPiAr
DQo+ID4gIHZvaWQgbW1jX3JldHVuZV90aW1lcl9zdG9wKHN0cnVjdCBtbWNfaG9zdCAqaG9zdCk7
DQo+ID4NCj4gPiAgc3RhdGljIGlubGluZSB2b2lkIG1tY19yZXR1bmVfbmVlZGVkKHN0cnVjdCBt
bWNfaG9zdCAqaG9zdCkgZGlmZg0KPiA+IC0tZ2l0IGEvaW5jbHVkZS9saW51eC9tbWMvc2QuaCBi
L2luY2x1ZGUvbGludXgvbW1jL3NkLmggaW5kZXgNCj4gPiA2NzI3NTc2YTg3NTUuLjg2NWNjMGNh
ODU0MyAxMDA2NDQNCj4gPiAtLS0gYS9pbmNsdWRlL2xpbnV4L21tYy9zZC5oDQo+ID4gKysrIGIv
aW5jbHVkZS9saW51eC9tbWMvc2QuaA0KPiA+IEBAIC0zNiw2ICszNiw3IEBADQo+ID4gIC8qIE9D
UiBiaXQgZGVmaW5pdGlvbnMgKi8NCj4gPiAgI2RlZmluZSBTRF9PQ1JfUzE4UiAgICAgICAgICAg
ICgxIDw8IDI0KSAgICAvKiAxLjhWIHN3aXRjaGluZyByZXF1ZXN0ICovDQo+ID4gICNkZWZpbmUg
U0RfUk9DUl9TMThBICAgICAgICAgICBTRF9PQ1JfUzE4UiAgLyogMS44ViBzd2l0Y2hpbmcgYWNj
ZXB0ZWQgYnkNCj4gY2FyZCAqLw0KPiA+ICsjZGVmaW5lIFNEX09DUl8yVCAgICAgICAgICAgICAg
KDEgPDwgMjcpICAgIC8qIEhPMlQvQ08yVCAtIFNEVUMgc3VwcG9ydCAqLw0KPiA+ICAjZGVmaW5l
IFNEX09DUl9YUEMgICAgICAgICAgICAgKDEgPDwgMjgpICAgIC8qIFNEWEMgcG93ZXIgY29udHJv
bCAqLw0KPiA+ICAjZGVmaW5lIFNEX09DUl9DQ1MgICAgICAgICAgICAgKDEgPDwgMzApICAgIC8q
IENhcmQgQ2FwYWNpdHkgU3RhdHVzICovDQo+ID4NCj4gPiAtLQ0KPiA+IDIuMjUuMQ0KPiA+DQo+
IA0KPiBLaW5kIHJlZ2FyZHMNCj4gVWZmZQ0K
