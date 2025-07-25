Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2075.outbound.protection.outlook.com [40.107.100.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C32242D83;
	Fri, 25 Jul 2025 05:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753422589; cv=fail; b=QxpWrPAvrwtNnzOrdJD4mJJHPDEl9LKiq409LCjxuC4cSLnR4k+vMoy1raibUDeB0vdvdxspVvuDKvo01HkuN9gzfaZy1Q/HCFIsqvLP1CaQk/LA5hwq+ifAUdHmEeoPlfVlJ8ev1QQpFKpReYPvbC019FhAyaGvhckXQby+jYg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753422589; c=relaxed/simple;
	bh=9cfdDuF4AmKKzNC5MdBhzKOT6OF8SJWnpJgdlc79LPk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sm/Sysdut4UyyJULXU0TVhIHmqGu0ZbddfQkUBIJ1EqZFxsL6k0wt2fNBLmdehNzCJFIUgA6BPNm68xvu/YU8CtqRDd378FgChRUBVrh5FK0Wc/yo+P3av05QHutnqnjkUlv7h+P/PXL/dOWk0mw+00KjLZlBC4Jquj34Jhsz6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sTTPXgyv; arc=fail smtp.client-ip=40.107.100.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sTTPXgyv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SZ5FuMyhPHT2y0dcHZQayKQAtc/KQHlbfSDYWeb+/5erJum7MHOoGAYBuRz7t94CFFREGiJ0Er5YuaofNlzBKWYQjGvK1l+KF/coAqyPbmb/JOjShCShyoPQaAAt/Op8cep9G0ZOu5fog6OYlWJ5yUXBC3CXganzdSVlg7ikNNXqKIQb2mrf9OlDX9Rq1xT43p4pPpVHaAXInS/bOb9qVpmuD55HUXA3cRNDiOwoppw1QG4T+/I4XBS6gR3C/uwN0NMTAIlQHaCq6jNj+TpAlnanaEnU/KGXB5s0s/Dnz8/XWj9ZLSNpKyU/acawN3uRJqyFoc7NHs2etsAzCTi6Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9cfdDuF4AmKKzNC5MdBhzKOT6OF8SJWnpJgdlc79LPk=;
 b=T7a9n8cgGr50Yhq3WmofK+DZPvplXwQD48iyuMyKp+nj1Qg3WAp3RWXqvZ+v9l9CUDkAF4XY/2x6lIGcBGv5YjD0D0n4qTP759Y9rfpCoyj1OQjMqhA7Q654hldI+17QrMQRHWYGsWbqMkAZXvNvJsFLmr4wF/BrijYZ2vnaEi7vzZ7rgZcjN1l2eWX4XB/PWMLidX8FC/ajuOTJU4sz8YdOvmt2oZmGUgK5rTk/qfKYw1ilqki4knLGhAPzH1dkwvCzPEZjN/TeH4v6fsPRs2j7a9hK6or1UxuI/YTfyNvm35z/X4GK1WNXzSA5/nLwYgu6umTbioLZ1J6QYcdFWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9cfdDuF4AmKKzNC5MdBhzKOT6OF8SJWnpJgdlc79LPk=;
 b=sTTPXgyv00vuAKjzbFJ6rsd9IOa/1brX0vWSUIZnVvkEjupmsx8Y00qf9XNEQsjFmznFPFBCsmy51jzjgbubUMK09EWHEaZoEy+bMig3ZYcPpMP/VIgQ87ACLMpFP7mUykSOpLoVL5ck8tDrOV1nlVe9vYsnJj0wNdK+wp6ieRw=
Received: from BY5PR12MB4258.namprd12.prod.outlook.com (2603:10b6:a03:20d::10)
 by DS2PR12MB9711.namprd12.prod.outlook.com (2603:10b6:8:275::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.24; Fri, 25 Jul
 2025 05:49:42 +0000
Received: from BY5PR12MB4258.namprd12.prod.outlook.com
 ([fe80::3228:a925:2191:98b3]) by BY5PR12MB4258.namprd12.prod.outlook.com
 ([fe80::3228:a925:2191:98b3%7]) with mapi id 15.20.8943.029; Fri, 25 Jul 2025
 05:49:42 +0000
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
Thread-Index: AQHb+iV59JsftOMvbkGqvxMjsJtJdbRBeViAgAAfaPA=
Date: Fri, 25 Jul 2025 05:49:42 +0000
Message-ID:
 <BY5PR12MB425804611D4B29ADDCC82906DB59A@BY5PR12MB4258.namprd12.prod.outlook.com>
References: <20250721095357.3783222-1-sai.krishna.potthuri@amd.com>
 <cf04326b-4de4-4637-aa3b-fa1c358b9ae4@intel.com>
In-Reply-To: <cf04326b-4de4-4637-aa3b-fa1c358b9ae4@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-07-25T05:45:17.0000000Z;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR12MB4258:EE_|DS2PR12MB9711:EE_
x-ms-office365-filtering-correlation-id: 7ae3df62-df92-4279-0999-08ddcb3f0d8b
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NlJCQWYrc0g4RDM0YzZNSnFPWU9Sa05PaGpKeGQ1bFkrUk9ocXkwYU42QnBY?=
 =?utf-8?B?Z3Y0aXZpZEVkMWVRbG1rb3lSS3ozZUYvN0t6NzFURjhRVnlSc3NvaU4xbFRU?=
 =?utf-8?B?UEs0T2xZdWtHQnVXUnpCb2h0VEpwU21kQy8rVlVOdGhqdWg2TlBPMWErTzYz?=
 =?utf-8?B?UlZDZUMwaHI0T2hLeVhESE1GQXBZc05rZC9ic3NVMUlDS0VyNG1rMlhUWUdy?=
 =?utf-8?B?dTc2UFpzUFZKYXdoL3N5N0hLd0pOUGRPOHlRbG9PSFd5R1VyeEVVNm1qSlZo?=
 =?utf-8?B?TmU0d3ZwbVBlWTlMZFlOdmo0Zlora2I4VE1Mb3hpUkNtblRjVUovTkpiTk9Z?=
 =?utf-8?B?ZFFvaGg5RCtkOFJ6V3c1Z1RyOU1SdTZmTzlNS0p6SUlGaGdnMWJPakJYN2NY?=
 =?utf-8?B?dVoxRi9LNmRpS2V0OW1XUXUxSlIxU0QrNEE0MGZSOGhRQ3U0R2p0TmRLWk5G?=
 =?utf-8?B?emZrOEdudE9iN2pwVTM3Q29ZdlVvajdnMW1XMWdTZklUdzgvMS80dmRFNUV6?=
 =?utf-8?B?L1Z2d0lqVEZiemd2M3c4QUJzajAyNW4wNy9zcHQwSGRNWlNzZ3lwOTdlZWc3?=
 =?utf-8?B?ZTBhUElYT2EreEQwSHlsaGpvZGpzQ0FueXJPbE1vUzdpYVNiVVB3ckJ1dW1B?=
 =?utf-8?B?Z2t6MXRuakJYbnk0M1VQMmNnQ0RDOHFTNjR3bFMxaVhrR0g4OEFhNXo2S2lw?=
 =?utf-8?B?V256SzdFcWxNcXlzQjVHbkdYOXMvNkpqSm5XVk1lSWd2NFQvTWo1eWk1R05R?=
 =?utf-8?B?NE0wSXhkTlMyaGw3MS91cTJtQ0c5N0RFU1c3R2tTd1NZUGk5N0llQTRxeUR2?=
 =?utf-8?B?TmRwSFhsanJNQjh0SElBZzFYZVZJeG4vc3VaQTlYdXRqZSsxaCs2cDM2M3Ni?=
 =?utf-8?B?TE5CemZld3lqcmxqK2ptTjhuRkJKTTBld2NCRytVblpGWG5YV2lId2RlK20r?=
 =?utf-8?B?QzNRN1BhVXJhdTNYTXhqamNNR3hicitKSlh4MldTbGJnK3hzT1VWTGdaR0w3?=
 =?utf-8?B?RzkrcjU4V2pOb25Bb2xKdkd0T2pqT3ZVVzV6LzFia0k5Snd0SHBXSHZQYzdV?=
 =?utf-8?B?cW1MNW51S2NTSUtkaEhIay9QWFViOVJWeWlnWmRqNmJ5c2RDOHJuZDBNMGZU?=
 =?utf-8?B?VVJwbUlCVTIvZnlOYnZDdTZlZ3ovaFk5NUdibDlYVStFcTN1bW8zcTlhU0Vm?=
 =?utf-8?B?U1dQSlF1YW50SVRid05CaUZzbllTZzlIQURxMWZORzV0dVkzNi9LcUo1WlFQ?=
 =?utf-8?B?bENHT0l5MGFFcEdyaUpVejhTMlNqZHQwckpuOU56dUl5WERWdjNDRTFTb0Zq?=
 =?utf-8?B?V3JDMUpDSkxHU3BZRmYvSE9zMjdMSmtYNW5DL2l3K2dFamRVdGRlbzJSNDh1?=
 =?utf-8?B?UlE3L2hwQ1hIakx5RTN2SklZcms1RmZ6bVZyRDVJZ2lKZGVrR3ZTQ2o0SEU3?=
 =?utf-8?B?SGpSa2hOUGQzcXhDVnlQcmhodS9FUHRKNW5jTms0d2Q4ZDZxVE9XdGp4MlhZ?=
 =?utf-8?B?Yk9Dc2ZiQkxmblg2Sm5vR0RmZUlLa2xEUVJYd1pwY2lrNEJRbWZlTGtpdjBF?=
 =?utf-8?B?Sk90OG9uTnVhenhFd2VnMStiRGdmZHpqM1lxZTBHaVlRV3JxOWlGY2krZ05a?=
 =?utf-8?B?d1BPSVlFczhuNm1oTVFEM3g3UFVleDZXZjdrTHA2UmRxaXBZYTZJdFdEYXFt?=
 =?utf-8?B?Y083MDNWaVNFRWd6anBMZDV3aHNBUWpXLzA1c3YvdnJxT01FTERHOWk3TTlm?=
 =?utf-8?B?VFdKbDRYM0pTT0k1TDNhdVZMeW1CT0pRd0tpMm92UG9GaEsvN2h6SWlNOVR3?=
 =?utf-8?B?R1FpUk9MdDNHdENMSkN4Y1ZDNytabXQrRWZLa1UwYWhUenI1dWFwNUgyYkJ4?=
 =?utf-8?B?Q3pxc01HQzh1MW1oMUFIUjZGREhQbnpVMEdDc2FuS0NrT3pmKzZFQ3I1YkIv?=
 =?utf-8?B?b1BaMGt2TlMxMS81USszVzEra0hzVHhuNWhVU0xDN0ZVZmI2YUd3T0RMdUt0?=
 =?utf-8?Q?8iyog3pVz0JHsjC7JRdCJPkvjyoeqY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4258.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?N0ZzSkdFTGN3QUdtSDhUMzhxYTlRcm82Wmp5UGFybjdQWXIzMUJVdVQrbGE2?=
 =?utf-8?B?NHlNczN5SGFUTTVXblBzeHBzT2pOdEJzdUtHd3RObVdXcjhZc0haZjRSMTRD?=
 =?utf-8?B?MjNibzlaeXBJYThlcXVXa1NrcVRKa3k5cjRWdlVFRWZJeEs1THJNbmNjWEVv?=
 =?utf-8?B?cG4rTWpvZFg3M2FSWUg3c2tpQUlqdmFuSjlBaUlhS25SdjNmc201NWtuVW1Z?=
 =?utf-8?B?clV3TFBiTDIyVUpQTk5GenRncThkRTczN0ZVeGx6Mzl6Y0xzMzhYUWlEZzBy?=
 =?utf-8?B?VFF6MTNHcTRXUlZUNnlvTEhxQVdDVFArbVJ1YkUzWkdKemlHYVorTkVOWEtH?=
 =?utf-8?B?Y1lQdVVFbmRoaFdIMXRoTzZlcndBSk9XSnRjUVVRRVpENFBGZTZ0eGdpZ1k1?=
 =?utf-8?B?SHVYNURPRzg2TC9ndG04WEFwSEhkeDVmMi9OMElCY0hQc1hBTm9BYUp6emEv?=
 =?utf-8?B?Q0FQYlczL2JxWUhubVI1SVV3ZHZTeGxPRlFvSE5qQURWQWhza1lheThhSnVj?=
 =?utf-8?B?Znh4TjFJT1dqZ1h0MXM0Wmptandyby9GYm9xM0RtKzlRaE1jUmovNkRCZUtX?=
 =?utf-8?B?bE5FRUJZM3czZkJQaVdLdExxbXlHcm1admVrQTFsVldJYVJ2MGI0dER1R0Rq?=
 =?utf-8?B?RDF0ZUFXWnBid3VJalR3R2ZYQmdVTTgyQUlqZlYvSExHYlJVbUlad3M2enRr?=
 =?utf-8?B?SDhWeG1DR2JmdDVDOWZUTk45NGtnQ1dKWm10RE5RTE1lWGpkSGx4T0wwQ2xz?=
 =?utf-8?B?cnFybVhSck03eEVrM3VmeWdUUGhFVHduNCsrMTY1R2FPMHhESEd2YmJRM0Ew?=
 =?utf-8?B?bXJmam5JSEsyUUo3Z0hHWHlpL3dGQVFDWUtaUFIwVlhTQ1JXT2o3VVRTc2NJ?=
 =?utf-8?B?TlAxRVRyL3hKbngySnlhSFlkUVU5cTZXVFNmWWNwT011RzdMSnVUb3BZVVZX?=
 =?utf-8?B?c3JzWmxPcHVuSmp5djl4S01ld1FlRkt3bEE4a3U2aDlzd1Q0ZUVKUitWSTMr?=
 =?utf-8?B?REIrWExVQnNsa0pZaW9uZW9PRXlSZW85TTlwY29FVHg4enFUTGxzU1lDeVd2?=
 =?utf-8?B?Mk5vSXA1Nkdwb1Q4WGxUemRoNWRrWVVXOGtzUW9FdFpVZmlNNk9vNlIvcGR5?=
 =?utf-8?B?dDNOZlB2MC9MZjJTaXRISEVodThOa2pEYXNRcjRzK00wd3NYa1hIUEEwT0hq?=
 =?utf-8?B?dXVIb0dheWJETStPdExNUVZ1UERJVktWSERtT2ZLQ0dwajdIOXpnZ3dmeWNy?=
 =?utf-8?B?emZkV2krTVYwQTQ1OVloMFplaFluNGwyMEZ5S01Bcmk4NU1YSi9ieW1pdUhK?=
 =?utf-8?B?MnJPMlA3eG84U2ZRTU1MTEc4cURrN1ZNaUhjVDkrT3BYVUdVV1gxOHRkVUJE?=
 =?utf-8?B?STROcDVmVDhHd0hpUDFSMnlTb3hXM205enZSUk92MTBES2owZWFmVHQyM0NG?=
 =?utf-8?B?NnRvMXlWSURQYlR3WVJPN3l2aWwvNzFjMmwvdTUrMS8xcVNvbzZxc2cremdQ?=
 =?utf-8?B?L1pwTkJ5L2lJRGxqV2Z4eHowZXEyckd3YVBHNXdBeUpNUWV3SThEemw1Y210?=
 =?utf-8?B?ZVgzWlZwOFpJWlZLY0hqRENXakxMS1BMNzFFRVpZWDFPeTZwOE1ncXAzd2t3?=
 =?utf-8?B?VzRHdEhKWVFJaWpRekhSMGdDeHlBZnVRZU9YdHdhcHlsazY3ZTZBRVBUdUhR?=
 =?utf-8?B?TWtoeHQyRVROVktnRFVnWVluZXYxRStLZ2JnSGtObTF5a2t5VXJJaDVZeFVS?=
 =?utf-8?B?QVpWYjFxQ0VIbVp5VDlRYVBrK01PY3J1NW1zRDVUVEk1TW1OaDhwaWxNRGVP?=
 =?utf-8?B?SDRXV2Rnck5aaXFGQXFjdEJBQ0xwQk9LUDdlQkt4aFliZ0JDelJtMzlrSXpp?=
 =?utf-8?B?cDdZeFhwclB1TFdNakdwSDFMaVBiSVFKVjlVbHBHMzFQcmx2c1pMUnpoOHFz?=
 =?utf-8?B?cEVzQ1MzKzJwNXkzVHR4Njh6TzJuZythRnZsdmUyODN5WjN1OWdBcG4ybVNO?=
 =?utf-8?B?OU1Ha2Faa0JvTXZKRmhLV09DQmVldWxKU05lQjFoOURrbEJaVngwdXR3eHNY?=
 =?utf-8?B?cncwQ3NlYVRZSk5FOUd6TFZ2aVZVZW8wWGgzdEY1dXB0c05rS29tYWd6Z3Nt?=
 =?utf-8?Q?63EI=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ae3df62-df92-4279-0999-08ddcb3f0d8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2025 05:49:42.6757
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S7iiHiVebvdq4WKnldChHUV+8Rw68q0SWmrUf/mdMCBeBHa/D/QU6wBi247oUWxZFYEtjCBAcXfc5zVrzgVymw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9711

W1B1YmxpY10NCg0KSGkgQWRyaWFuLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+
IEZyb206IEFkcmlhbiBIdW50ZXIgPGFkcmlhbi5odW50ZXJAaW50ZWwuY29tPg0KPiBTZW50OiBU
aHVyc2RheSwgSnVseSAyNCwgMjAyNSA5OjUwIFBNDQo+IFRvOiBQb3R0aHVyaSwgU2FpIEtyaXNo
bmEgPHNhaS5rcmlzaG5hLnBvdHRodXJpQGFtZC5jb20+OyBTaW1laywgTWljaGFsDQo+IDxtaWNo
YWwuc2ltZWtAYW1kLmNvbT47IFVsZiBIYW5zc29uIDx1bGYuaGFuc3NvbkBsaW5hcm8ub3JnPg0K
PiBDYzogbGludXgtbW1jQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5p
bmZyYWRlYWQub3JnOyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgZ2l0IChBTUQt
WGlsaW54KSA8Z2l0QGFtZC5jb20+Ow0KPiBzYWlrcmlzaG5hMTI0NjhAZ21haWwuY29tDQo+IFN1
YmplY3Q6IFJlOiBbUEFUQ0hdIG1tYzogc2RoY2ktb2YtYXJhc2FuOiBFbnN1cmUgQ0QgbG9naWMg
c3RhYmlsaXphdGlvbiBiZWZvcmUNCj4gcG93ZXItdXANCj4NCj4gT24gMjEvMDcvMjAyNSAxMjo1
MywgU2FpIEtyaXNobmEgUG90dGh1cmkgd3JvdGU6DQo+ID4gRHVyaW5nIFNEIHN1c3BlbmQvcmVz
dW1lIHdpdGhvdXQgYSBmdWxsIGNhcmQgcmVzY2FuICh3aGVuIHVzaW5nDQo+ID4gbm9uLXJlbW92
YWJsZSBTRCBjYXJkcyBmb3Igcm9vdGZzKSwgdGhlIFNEIGNhcmQgaW5pdGlhbGl6YXRpb24gbWF5
DQo+ID4gZmFpbCBhZnRlciByZXN1bWUuIFRoaXMgb2NjdXJzIGJlY2F1c2UsIGFmdGVyIGEgaG9z
dCBjb250cm9sbGVyIHJlc2V0LA0KPiA+IHRoZSBjYXJkIGRldGVjdCBsb2dpYyBtYXkgdGFrZSB0
aW1lIHRvIHN0YWJpbGl6ZSBkdWUgdG8gZGVib3VuY2UgbG9naWMuDQo+ID4gV2l0aG91dCB3YWl0
aW5nIGZvciBzdGFiaWxpemF0aW9uLCB0aGUgaG9zdCBtYXkgYXR0ZW1wdCBwb3dlcmluZyB1cA0K
PiA+IHRoZSBjYXJkIHByZW1hdHVyZWx5LCBsZWFkaW5nIHRvIGNvbW1hbmQgdGltZW91dHMgZHVy
aW5nIHJlc3VtZSBmbG93Lg0KPiA+IEFkZCBzZGhjaV9hcmFzYW5fc2V0X3Bvd2VyX2FuZF9idXNf
dm9sdGFnZSgpIHRvIHdhaXQgZm9yIHRoZSBjYXJkDQo+ID4gZGV0ZWN0IHN0YWJsZSBiaXQgYmVm
b3JlIHBvd2VyIHVwIHRoZSBjYXJkLiBTaW5jZSB0aGUgc3RhYmlsaXphdGlvbg0KPiA+IHRpbWUg
aXMgbm90IGZpeGVkLCBhIG1heGltdW0gdGltZW91dCBvZiBvbmUgc2Vjb25kIGlzIHVzZWQgdG8g
ZW5zdXJlDQo+ID4gc3VmZmljaWVudCB3YWl0IHRpbWUgZm9yIHRoZSBjYXJkIGRldGVjdCBzaWdu
YWwgdG8gc3RhYmlsaXplLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogU2FpIEtyaXNobmEgUG90
dGh1cmkgPHNhaS5rcmlzaG5hLnBvdHRodXJpQGFtZC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZl
cnMvbW1jL2hvc3Qvc2RoY2ktb2YtYXJhc2FuLmMgfCAyNCArKysrKysrKysrKysrKysrKysrKysr
LS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDIyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0p
DQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1vZi1hcmFzYW4u
Yw0KPiA+IGIvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1vZi1hcmFzYW4uYw0KPiA+IGluZGV4IDQy
ODc4NDc0ZTU2ZS4uM2NlNTUwMDliYTRhIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbW1jL2hv
c3Qvc2RoY2ktb2YtYXJhc2FuLmMNCj4gPiArKysgYi9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLW9m
LWFyYXNhbi5jDQo+ID4gQEAgLTk5LDYgKzk5LDkgQEANCj4gPiAgI2RlZmluZSBISVdPUkRfVVBE
QVRFKHZhbCwgbWFzaywgc2hpZnQpIFwNCj4gPiAgICAgICAgICAgICAoKHZhbCkgPDwgKHNoaWZ0
KSB8IChtYXNrKSA8PCAoKHNoaWZ0KSArIDE2KSkNCj4gPg0KPiA+ICsjZGVmaW5lIENEX1NUQUJM
RV9USU1FT1VUX1VTICAgICAgICAgICAgICAgMTAwMDAwMA0KPiA+ICsjZGVmaW5lIENEX1NUQUJM
RV9NQVhfU0xFRVBfVVMgICAgICAgICAgICAgMTANCj4gPiArDQo+ID4gIC8qKg0KPiA+ICAgKiBz
dHJ1Y3Qgc2RoY2lfYXJhc2FuX3NvY19jdGxfZmllbGQgLSBGaWVsZCB1c2VkIGluIHNkaGNpX2Fy
YXNhbl9zb2NfY3RsX21hcA0KPiA+ICAgKg0KPiA+IEBAIC01MTQsNiArNTE3LDIzIEBAIHN0YXRp
YyBpbnQgc2RoY2lfYXJhc2FuX3ZvbHRhZ2Vfc3dpdGNoKHN0cnVjdA0KPiBtbWNfaG9zdCAqbW1j
LA0KPiA+ICAgICByZXR1cm4gLUVJTlZBTDsNCj4gPiAgfQ0KPiA+DQo+ID4gK3N0YXRpYyB2b2lk
IHNkaGNpX2FyYXNhbl9zZXRfcG93ZXJfYW5kX2J1c192b2x0YWdlKHN0cnVjdCBzZGhjaV9ob3N0
ICpob3N0LA0KPiB1bnNpZ25lZCBjaGFyIG1vZGUsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICB1bnNpZ25lZCBzaG9ydCB2ZGQpDQo+ID4gK3sNCj4g
PiArICAgdTMyIHJlZzsNCj4gPiArDQo+ID4gKyAgIC8qDQo+ID4gKyAgICAqIEVuc3VyZSB0aGF0
IHRoZSBjYXJkIGRldGVjdCBsb2dpYyBoYXMgc3RhYmlsaXplZCBiZWZvcmUgcG93ZXJpbmcgdXAs
IHRoaXMNCj4gaXMNCj4gPiArICAgICogbmVjZXNzYXJ5IGFmdGVyIGEgaG9zdCBjb250cm9sbGVy
IHJlc2V0Lg0KPiA+ICsgICAgKi8NCj4gPiArICAgaWYgKG1vZGUgPT0gTU1DX1BPV0VSX1VQKSB7
DQo+ID4gKyAgICAgICAgICAgcmVhZGxfcG9sbF90aW1lb3V0KGhvc3QtPmlvYWRkciArIFNESENJ
X1BSRVNFTlRfU1RBVEUsIHJlZywNCj4gcmVnICYgU0RIQ0lfQ0RfU1RBQkxFLA0KPiA+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBDRF9TVEFCTEVfTUFYX1NMRUVQX1VTLA0KPiBDRF9T
VEFCTEVfVElNRU9VVF9VUyk7DQo+ID4gKyAgIH0NCj4NCj4gRG9lc24ndCBuZWVkIHt9DQpXaWxs
IHJlbW92ZSBpbiB2Mi4NCg0KPg0KPiBXaWxsIHRoaXMgd29yayB3aXRoIGFsbCBBcmFzYW4gdmFy
aWFudHM/DQpZZXMsIHRoaXMgaXMgZXhwZWN0ZWQgdG8gd29yayBhY3Jvc3MgYWxsIEFyYXNhbiB2
YXJpYW50cyB0aGF0IGNvbXBseSB3aXRoIHRoZSBzdGFuZGFyZA0KU0RIQ0kgcmVnaXN0ZXIgZGVm
aW5pdGlvbnMuIFRoZSBTREhDSV9DRF9TVEFCTEUgYml0IGlzIGRlZmluZWQgaW4gYm90aCB0aGUN
CnN0YW5kYXJkIFNESENJIHNwZWNpZmljYXRpb24gYW5kIEFyYXNhbidzIHVzZXIgZ3VpZGUuDQpP
biBYaWxpbngvQU1EIFZlcnNhbCBhbmQgWnlucU1QIHBsYXRmb3JtcywgdGhlIENEIHN0YWJsZSBi
aXQgaXMgdHlwaWNhbGx5IHNldCB3aXRoaW4NCmEgZmV3IG1pbGxpc2Vjb25kcy4gSG93ZXZlciwg
dG8gYmUgb24gdGhlIHNhZmVyIHNpZGUgYW5kIGVuc3VyZSBjb21wYXRpYmlsaXR5IGFjcm9zcw0K
YWxsIEFyYXNhbiB2YXJpYW50cywgYSB0aW1lb3V0IG9mIDEgc2Vjb25kIGlzIGFkZGVkLg0KUGxl
YXNlIGxldCBtZSBrbm93IGlmIHlvdSBwcmVmZXIgdG8gaW5jcmVhc2UgdGhlIHRpbWVvdXQgb3Ig
aWYgdGhpcyBsb2dpYyBzaG91bGQgYmUNCmVuYWJsZWQgYnkgYSBwbGF0Zm9ybSBzcGVjaWZpYyBx
dWlyay4NCg0KUmVnYXJkcw0KU2FpIEtyaXNobmENCg0KPg0KPiA+ICsNCj4gPiArICAgc2RoY2lf
c2V0X3Bvd2VyX2FuZF9idXNfdm9sdGFnZShob3N0LCBtb2RlLCB2ZGQpOyB9DQo+ID4gKw0KPiA+
ICBzdGF0aWMgY29uc3Qgc3RydWN0IHNkaGNpX29wcyBzZGhjaV9hcmFzYW5fb3BzID0gew0KPiA+
ICAgICAuc2V0X2Nsb2NrID0gc2RoY2lfYXJhc2FuX3NldF9jbG9jaywNCj4gPiAgICAgLmdldF9t
YXhfY2xvY2sgPSBzZGhjaV9wbHRmbV9jbGtfZ2V0X21heF9jbG9jaywgQEAgLTUyMSw3ICs1NDEs
Nw0KPiBAQA0KPiA+IHN0YXRpYyBjb25zdCBzdHJ1Y3Qgc2RoY2lfb3BzIHNkaGNpX2FyYXNhbl9v
cHMgPSB7DQo+ID4gICAgIC5zZXRfYnVzX3dpZHRoID0gc2RoY2lfc2V0X2J1c193aWR0aCwNCj4g
PiAgICAgLnJlc2V0ID0gc2RoY2lfYXJhc2FuX3Jlc2V0LA0KPiA+ICAgICAuc2V0X3Voc19zaWdu
YWxpbmcgPSBzZGhjaV9zZXRfdWhzX3NpZ25hbGluZywNCj4gPiAtICAgLnNldF9wb3dlciA9IHNk
aGNpX3NldF9wb3dlcl9hbmRfYnVzX3ZvbHRhZ2UsDQo+ID4gKyAgIC5zZXRfcG93ZXIgPSBzZGhj
aV9hcmFzYW5fc2V0X3Bvd2VyX2FuZF9idXNfdm9sdGFnZSwNCj4gPiAgICAgLmh3X3Jlc2V0ID0g
c2RoY2lfYXJhc2FuX2h3X3Jlc2V0LA0KPiA+ICB9Ow0KPiA+DQo+ID4gQEAgLTU3MCw3ICs1OTAs
NyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHNkaGNpX29wcyBzZGhjaV9hcmFzYW5fY3FlX29wcyA9
IHsNCj4gPiAgICAgLnNldF9idXNfd2lkdGggPSBzZGhjaV9zZXRfYnVzX3dpZHRoLA0KPiA+ICAg
ICAucmVzZXQgPSBzZGhjaV9hcmFzYW5fcmVzZXQsDQo+ID4gICAgIC5zZXRfdWhzX3NpZ25hbGlu
ZyA9IHNkaGNpX3NldF91aHNfc2lnbmFsaW5nLA0KPiA+IC0gICAuc2V0X3Bvd2VyID0gc2RoY2lf
c2V0X3Bvd2VyX2FuZF9idXNfdm9sdGFnZSwNCj4gPiArICAgLnNldF9wb3dlciA9IHNkaGNpX2Fy
YXNhbl9zZXRfcG93ZXJfYW5kX2J1c192b2x0YWdlLA0KPiA+ICAgICAuaXJxID0gc2RoY2lfYXJh
c2FuX2NxaGNpX2lycSwNCj4gPiAgfTsNCj4gPg0KDQo=
