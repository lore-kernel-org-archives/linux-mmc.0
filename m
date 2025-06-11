Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F83925F78F;
	Wed, 11 Jun 2025 10:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749637397; cv=fail; b=ISX9IXAK7jgp9u6RavNO2JEwpf6DWTG1PEto3oo/Da+XZjkzajXR509qG1vh2e00oq7l6VHgNK9JsFiHUD3IXgEco9kNKHBcYdx0M5J/UKrEN0m3CZULZokCSTyZzGTVJ2laAeIG559E8PP9IQEhlfNzB20k/Wsu6vi/i4WUey8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749637397; c=relaxed/simple;
	bh=cXSO4jVEz7ZfyXJ0tI1WcacNlvt2JB6BIQNflYpnVNA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=N+BWdmBdZP9O5TLjzwQD+t4wBa+VX5gzHLvUW/AGGxUZi3oY3zH2eTp3snbfWDumnS38+5EpxrYOKCAo3pOtnMBqZI6RkQNcK6RkdW58iVizkHDC9a5eEw2A6VpfXSIgkFxA5/dupVEUBBaQCYfU0lc45yEzcWUVPc45NIGGVmM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=M+O0iwBx; arc=fail smtp.client-ip=40.107.94.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="M+O0iwBx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OiT3zEWObIpLVFsFBtaYqNUH7ips5oy1N8MAcbUhkwbC59g/uv1ZVPpgPBkHlWjL6XCBd6DL+/a0tRSfuLAq7+LeLAWPNIN185yZlolhbUXuyKVd1gZXfjsXppdpKVwI3PHnWnF5Nw9e5cMllBVATj7H5aiMvfz/vPWbZfggfgJvubzQsWapIzApUJ07jUxPRP0mAArXIPc9Wv27b4hDMwvGpZFjaWUY6JmpX77+d/h+zZTVBVGf6P9DO7OajiKkmZYUawuDVNRLMn7Za8i8z2AZ3/R7pX1Pg1bS6gD7BCt8CXhjRaTKvB3ePVfEuvdK5NFsdvhX49LMJaJiCWdXSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cXSO4jVEz7ZfyXJ0tI1WcacNlvt2JB6BIQNflYpnVNA=;
 b=Dhyv1/08dFCvbvn4Urn4nNMJYXo2xuAjAlepQFskYATrix4oVifxge4MauBDuNusbkOMZ52Nydn7Zrj1JhdggNGt5cqYiuLcUFBHvjTTn5zPxB+yq4ZXv4DwMFw2CJ97hFV3n8ZGN/ikiqCumdPuhTA7xbmNlFNi8j37qrNByxhuXpPibr39meytuL91PQ3ugTw39Z9hvRAGcbbpiEOVzi9SsJQ0Of1FmjNKXQoSPz1rIKDaBVY8ld/RFV+nkbr1RCWRJRkYxQE6Cx1i7369qRUOMU6Py7BUDrYvit8OkOE5qkO5zzok3Ra+YdDV0F+uEvjafOhuDXMGYX2JqG7uaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cXSO4jVEz7ZfyXJ0tI1WcacNlvt2JB6BIQNflYpnVNA=;
 b=M+O0iwBxpiTR56GGWSSrpZFFFaS3Y6kLxhpURcDT5Ff85MI4bshIA6jvqQAHPxfKdNlmqpgWdddiM9J+4oKZQErlPk+g4OrpgeNUCKUiKqh40DclKOUZmdwu6tlNbT1iu6ZXiLWdKXQRv+3aCjDKA1Pd9CLT69VU0ZfWs1M8gL4=
Received: from PH7PR12MB6762.namprd12.prod.outlook.com (2603:10b6:510:1ac::11)
 by SA3PR12MB8023.namprd12.prod.outlook.com (2603:10b6:806:320::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.39; Wed, 11 Jun
 2025 10:23:11 +0000
Received: from PH7PR12MB6762.namprd12.prod.outlook.com
 ([fe80::d311:e3b2:b34e:5ea7]) by PH7PR12MB6762.namprd12.prod.outlook.com
 ([fe80::d311:e3b2:b34e:5ea7%4]) with mapi id 15.20.8722.031; Wed, 11 Jun 2025
 10:23:11 +0000
From: "Paul P, Alvin" <Alvin.PaulP@amd.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: "Simek, Michal" <michal.simek@amd.com>, "adrian.hunter@intel.com"
	<adrian.hunter@intel.com>, "git (AMD-Xilinx)" <git@amd.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] mmc: sdhci-of-arasan: Add shutdown callback
Thread-Topic: [PATCH v2] mmc: sdhci-of-arasan: Add shutdown callback
Thread-Index: AQHb0IdRIbqpxdA/7EWMeT26vKnpjrP64xyAgALu1DA=
Date: Wed, 11 Jun 2025 10:23:11 +0000
Message-ID:
 <PH7PR12MB67623A150864DA65927583D5F775A@PH7PR12MB6762.namprd12.prod.outlook.com>
References: <20250529104853.1987456-1-alvin.paulp@amd.com>
 <CAPDyKFok6Ftr6OAHpy_qL3S17cecHT9f2tKWagCd+KvVFSmAFA@mail.gmail.com>
In-Reply-To:
 <CAPDyKFok6Ftr6OAHpy_qL3S17cecHT9f2tKWagCd+KvVFSmAFA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=3dfc7964-1161-42fe-87d7-f9e84cfcd10a;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-06-11T10:13:38Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB6762:EE_|SA3PR12MB8023:EE_
x-ms-office365-filtering-correlation-id: c449d63a-ddec-448c-1f47-08dda8d1f7dd
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UVhwM1BLSVVUYlFzd0xDb0t2RkluZVNZejR6SUlFSlRjUnowZVVPQi93Qi96?=
 =?utf-8?B?OGdieE5PVWpxd1I4eWpISlNGOGpaWWF1bTZIblcwTnlKVEpJUHFHNXUvbW5B?=
 =?utf-8?B?Q3ZHbE4zblVET09mb3dPN0tWVE9iWnFmT3dSampZSWh6ZVVXMnl6cEtub0du?=
 =?utf-8?B?UjNBQjhhS2FoUzdoVmhtY2l2dnNkUm9YUUtjVFlNQm5MdTdseEJJM2YxS0ZU?=
 =?utf-8?B?TGVYRVd2b0ZiMjU5OXp6bXNCNWh6MS9oVzk3TStzRkxiNjAwOFF5bUlSNHdJ?=
 =?utf-8?B?dE1WL2xrVUR5b1hQcWFRSklsUFdyVEU5bVBBNlJUZVIxNlJZWDgwWE5BT0RL?=
 =?utf-8?B?UjBmMDNxd3ZxSmFrejZnSmZJQnFaOHZUMGkwYXUxSUZYYUM4MXJRTmwydUQ2?=
 =?utf-8?B?ajhRZzNGcTQzVHF2RFlydVV4RDRvaG14NHdqeGp6SkJqbnN3NkQ4aEQ3TmVy?=
 =?utf-8?B?UFJEdEQvUzc3QzJobWNiSS95N1hQdit4cHpFQmxPN0tObkNLc0dBVUV2dlBa?=
 =?utf-8?B?dmNqT25HQUlORUNUVThxSWxmdkI0MFkrd2cwWHQ4V0F0SkwyeWVVN1FUdUVO?=
 =?utf-8?B?ZXMwN3hZS0I5WXBzWVlTbE41citYOTVRY1hNSVZtUXUzR09UYVFGeEZIUXZW?=
 =?utf-8?B?NWduZDgxb05GNlg2OTU1UzBXMC9DWWlUZ2JIWk5ObDhYaU9tVXhzek04Nll2?=
 =?utf-8?B?NjNJc2s0RzZnQkYxa0gzakdvMTR5ekZiUjN2c0d0QlBLcDhldUZybkxsczdD?=
 =?utf-8?B?UEx6b1NTSGw2b0MyZktJTzVDYi9nOHBaRmxndXgrQ0Z5VktBNmViekVnZWtH?=
 =?utf-8?B?NVVWb2FyaGtpZXlaZkRKZFNyS3RsUnE5d0M3QTVKaWg2NWMvK3FKU3Zrckxw?=
 =?utf-8?B?eHZIb0JiTGtOczdUZk02Ym1VSkhPb1Q5RHpURnhvdWhtMkY1OGtLbm5rbzFW?=
 =?utf-8?B?V0RvamJud3F3R1NnM3FSL3RDMWhya21JcjBITGp6N3N1K0xTM2w4dTZFM1Ir?=
 =?utf-8?B?cVVqRDlZaUp6UW9ZcVlleUYrVHFFbWZ4NWxCbzFnanpTeWdBek05T3I2VVg5?=
 =?utf-8?B?NURETEYzQXlKcDQydzcvOFB3RTZiS2VLdmlmNnJzc3ZubDhDb1VZZlFKUHN0?=
 =?utf-8?B?TkRjVnVTeW9pa1R1Z29HbXFNZHhCTEozZU1hMEduSEplUGRCSTFvM3ZMR0Ir?=
 =?utf-8?B?dlRHVUQwZWpTOXlBRGN5WDVoMEN3WkFkQ3BEdnZTTzVsNXY2SWlMZnlMdXhv?=
 =?utf-8?B?Lzlsd09hNGxsSmYycnFJeG1ySlFaWmYyY1Y4Tjl3UnZUOHE2S3A0WW8xUnpK?=
 =?utf-8?B?UFdiWUlFQ05SZXFVNE1yUDBpL2NodnRrR2dTY0thUHkyTkJNd0huQTlWcG9a?=
 =?utf-8?B?TVB2dVNPcXV4b3p2V3JMU1hNSnd5UTlpeWJ1b2JZcDN5VGx1NHpFaVNTeDk0?=
 =?utf-8?B?bXg0VWxXNlpSS0ZxWXN5VVlndktHVGxwMWcrZGJjOWR5NDRpRUcrd3NGNUJW?=
 =?utf-8?B?M0tDb1ArYmJkZU1GdEV6QWMzNFBiWFQ4MlNMU2FSbHg3N2RQc3hvaVFrRXFa?=
 =?utf-8?B?d2JmS0hqaVNzRXpIdk1YY1BHSlBqWndkT0tRV3VqcXVBdzlhYW00NitZMEY0?=
 =?utf-8?B?VlFzcExmMlNXL21oclFEZ3A1TzJFTnZOR3BWcmkwMGc3eHBDNkFFMlEvVXRD?=
 =?utf-8?B?Nm5uRGpCSzZ6TmxlVmlNVXJ6Nmc0cXQ5YTJRSWdwUGlCUWpPVEFzWW90TW56?=
 =?utf-8?B?VndUMGUyVHc0UjJKa1FBZjI1Rk9lWDFuRE5ZYzNNajdhdCt1RTBjSTRCWTB1?=
 =?utf-8?B?dmlvWW9NaDF5Zm1UeEhNLzQwZTZhOXNqMjZQUzViWjMyWm9OVjF5MmFBYVlI?=
 =?utf-8?B?alBheCs0WGFlN0dlSlhGMDlQbzlORFFBQm80ZUdQVmYveFl3dXFSVUVERlJl?=
 =?utf-8?B?MzJhbXdBRlp6WDl2SnZmQmQyTC9aRmVVdWtKdTNjZVpReUp0cTZqZlZlUDM3?=
 =?utf-8?Q?Jw4r0oV3c9fWgBIIMECRrrCODBIRW8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6762.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aG9wNHJQbEQrRGp0NmJOQnY1ZGZQQ3dQdDBjM2VQT1pkTENNWmFPR01EQ3dY?=
 =?utf-8?B?ajFiMlhyQzRuL0V6bEhGajFzb3NTeHVUSzRkZFNQRlNTZE05ZGkreDZzRGNV?=
 =?utf-8?B?ZHE4SHdoaFRFdnZpNEkzN0xhenptWlB0OHcvS29FMjBDV3huUGFHa0MxcS81?=
 =?utf-8?B?NnE3TlAzb0VaNFVGbUMrK0ptOW42azVpY2tUUXFjOWttcm4zaU9JNzFqOUJx?=
 =?utf-8?B?K0p1elIvekdodms5Yld6M0JibzNYNk1jcEpIM1BLZ0IwbUxhekhNRFUyMlhr?=
 =?utf-8?B?YWFOb20wcHgrSEVKcS9iZC9OUTZTc1RWUWhua0VLN2VFbUYwT0VGU2Y5elJ4?=
 =?utf-8?B?SkdsZTF3bjlEb3JEdHh4RFJVSUN6Q2xCUFZNN1h1SDlMSWtUa1NzV2pqSkNx?=
 =?utf-8?B?ZndtYU5UMjZvUi9GTDlQcEl3d2RONHBHbHN4RncyK1NYbllVSGt1aTZQbVQ3?=
 =?utf-8?B?aVB2c0tWbGFSbCsvR0oxYmhOMmdiUW9rSDkxZTJxVHZGVnRVb3hNV0Rld0VE?=
 =?utf-8?B?OStvY3NnNkgzcEdOWXFhelhvZVM3MkJlOElaUGdtczN4Z1ZJd0tOelRLcFR6?=
 =?utf-8?B?NHFiZjRzM3A5S05UMHBxZE5zZ1ZuWGxNcUF6Wkk5Wjg5VDBUWWpsd3Q1S0d1?=
 =?utf-8?B?UXd4ZkxKQzNoZkZZTkhBWVJGWUFRWUxISVhvYVllelhQUkpFenc2YjMyNFFa?=
 =?utf-8?B?THd6TmswZ0RTYUpVLzRxK1g5Y2JwclhvWXRvUUJvRmU3T1FTVmw5T3dxK0xt?=
 =?utf-8?B?WW52aldrTHh2cWJQNGhqVWJKRzFzaDY5RzFzaWEwSlRxcWo0V1FzRUpDekFB?=
 =?utf-8?B?QVc4N0g2RUFKMjA1OGFvMUlPeFAwTTJsQWl3ZFhNYzNuWmNaRWpCdzBoeVh4?=
 =?utf-8?B?SUpOVUF3QXgxTjFDM2Q0ZzB5WkhGMnBBT0pvWTVFbFl6bkRJNVN2ZDRyaUUz?=
 =?utf-8?B?Sk9BdGEzS3B1NllPM2lvcWRQTnhoMCt6dkkwb3grZG5MVnRGVEwxV2N5dVpG?=
 =?utf-8?B?OXJvTUg5QjdIWnBlbXFtZG8zOTVxdmVNcDFxNEJmdE01TmVhV0hTbmljYlp4?=
 =?utf-8?B?cnBwaGNHWWlqSXBUVnU3enhrcGFuVXNiSnd0cDhxaGhUbmJVVGdQREtyeSs3?=
 =?utf-8?B?bWVWS1dESUQydW1WbzdKS092eCtBTmtJK2dyT3Y5SEZlUmxzT0N4Nk9LRDRH?=
 =?utf-8?B?QXBHMXkvZzF3cW1kUm1WNk5HMnQ1U0VhbGxHY3NaN0ViS2lER3dRVlJUQlk2?=
 =?utf-8?B?QlRadHFmbjJKZTJITUFFU1BSbk1IaFNSbDZWRkp3TGRiczN3cGFtVENZNlpT?=
 =?utf-8?B?MkhtcnRoQ0NKOEI3M1RuUXdmRUY0M0RtQXhKUC82aEZXbVAvV01yM3FTU25M?=
 =?utf-8?B?WFh6cWxSYnBvWHFsZmpXMWRpNnQyTVN3bStQODVZOGRNVHRFcDdXZEhKMEht?=
 =?utf-8?B?OXkvZDQ1ekhjZVBXNS83M2dXenRUUXJ4YS9xNW93dDhzTW9ENncrcnJQQWRJ?=
 =?utf-8?B?Nnp4UDRIRWhkWkFkOGVRQkFSUERza1lQRXR4K3FLbGxWSFpCN3FhVFU3Mjc0?=
 =?utf-8?B?SFFwVmVHL0xucVQwT0hxeVEwTG96c0J6dkUwTzVjTURpbUNvbit6dlcvd0pX?=
 =?utf-8?B?Y3pUN0c5Z2pwRXhUdU5Jck1yN3ZnNEtMTkVLRWszRTZFdXFFd1NwdWwvaUNu?=
 =?utf-8?B?NmFrakp3ckVOVHlsQ1pRSElsdmNQQWRhL1pWSnlpNkk0Y3Vsb0Q4b0xDanpM?=
 =?utf-8?B?YmZDVFdJc0NXMEFXNHRHOHdLcTY1TExVV0JRTUdyS3A3UGNXOXBEMGFDUVdO?=
 =?utf-8?B?eFE2a09NRTZFZHhhZHFyT1BseVJSK25TTWJwS2Jib3pmOTZ0NWtDNHhPU0FV?=
 =?utf-8?B?U3VaVUlLKzFJVmVBNmNOQUpVY2oyL2hHV3lpWTdIM3JwcXB2Zks5SmsyTUNV?=
 =?utf-8?B?YUl0RjFYQUc1UzgvVlk3UG53OUFqQnRyMWpySVRWUU1wcWtRc1dFZTBzaWZs?=
 =?utf-8?B?d2N4VllHek5Pem1sOWFMZzBHOVZ2b0lEMnZnK3dGaXdmUkQrNXV1QXJhVitm?=
 =?utf-8?B?eUFBRFpjVElMamtNT3h4aTdMN3F3SmVXc1V4Vk5xS0FuS2NjS1JydVREMmlT?=
 =?utf-8?Q?lgLE=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6762.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c449d63a-ddec-448c-1f47-08dda8d1f7dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2025 10:23:11.5964
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SjWxkSRGR9L8pJ4Ffxa/A852dvS/I9sUUrO3HhQAxwzGtOy7oGmHMWJckJCLvqLmT2PbpVSDrTyKnArqXGVMpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8023

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KSGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVWxmIEhhbnNz
b24gPHVsZi5oYW5zc29uQGxpbmFyby5vcmc+DQo+IFNlbnQ6IE1vbmRheSwgSnVuZSA5LCAyMDI1
IDY6NTYgUE0NCj4gVG86IFBhdWwgUCwgQWx2aW4gPEFsdmluLlBhdWxQQGFtZC5jb20+DQo+IENj
OiBTaW1laywgTWljaGFsIDxtaWNoYWwuc2ltZWtAYW1kLmNvbT47IGFkcmlhbi5odW50ZXJAaW50
ZWwuY29tOyBnaXQNCj4gKEFNRC1YaWxpbngpIDxnaXRAYW1kLmNvbT47IGxpbnV4LWFybS1rZXJu
ZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgtDQo+IG1tY0B2Z2VyLmtlcm5lbC5vcmc7IGxp
bnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2Ml0gbW1j
OiBzZGhjaS1vZi1hcmFzYW46IEFkZCBzaHV0ZG93biBjYWxsYmFjaw0KPg0KPiBDYXV0aW9uOiBU
aGlzIG1lc3NhZ2Ugb3JpZ2luYXRlZCBmcm9tIGFuIEV4dGVybmFsIFNvdXJjZS4gVXNlIHByb3Bl
ciBjYXV0aW9uDQo+IHdoZW4gb3BlbmluZyBhdHRhY2htZW50cywgY2xpY2tpbmcgbGlua3MsIG9y
IHJlc3BvbmRpbmcuDQo+DQo+DQo+IE9uIFRodSwgMjkgTWF5IDIwMjUgYXQgMTI6NDksIFBhdWwg
QWx2aW4gPGFsdmluLnBhdWxwQGFtZC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gSW1wbGVtZW50IHNo
dXRkb3duIGhvb2sgdG8gc3VzcGVuZCBob3N0IGFuZCBkaXNhYmxlIGFsbCBtbWMgY2xvY2tzIHRv
DQo+ID4gaW5jcmVhc2UgcG93ZXIgc2F2aW5nIGR1cmluZyBzaHV0ZG93biBvciByZWJvb3QuDQo+
DQo+IFNvIGhvdyBsb25nIGlzIHRoZSBzaHV0ZG93biBwcm9jZXNzIGZvciB0aGUgcGxhdGZvcm0/
IFdoYXQgZG8gd2UgcmVhbGx5IGdhaW4/DQo+DQo+IEluIGdlbmVyYWwgd2UgZG9uJ3QgcXVpdGUg
Y2FyZSBhYm91dCBwb3dlci1zYXZpbmdzIGR1cmluZyBzaHV0ZG93biwgYXMgd2UgYXJlDQo+IGdv
aW5nIHRvIHR1cm4gb2ZmIHRoaW5ncyBhbnl3YXksIHJpZ2h0Pw0KPg0KDQpBZ3JlZSwgdGhpcyBw
YXRjaCBtYXkgbm90IGJlIHBhcnRpY3VsYXJseSB1c2VmdWwgZm9yIHRoZSBzaHV0ZG93biB1c2Ug
Y2FzZSwgYnV0IGluIGtleGVjIGZsb3cgZHVyaW5nIHN5c3RlbSByZXN0YXJ0IHByZXBhcmF0aW9u
LCBpdCB0cmlnZ2VycyBkZXZpY2Ugc2h1dGRvd24uIFRoaXMgcGF0Y2ggZW5zdXJlcyBhIHByb3Bl
ciBob3N0IHNodXRkb3duIGJ5IHVzaW5nIHNkaGNpIHBsYXRmb3JtIHN1c3BlbmQuDQoNCldpbGwg
dXBkYXRlIHRoZSBjb21taXQgZGVzY3JpcHRpb24gdG8gcmVmbGVjdCB0aGUgc2FtZS4NCg0KVGhh
bmtzLA0KQWx2aW4NCj4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFBhdWwgQWx2aW4gPGFsdmlu
LnBhdWxwQGFtZC5jb20+DQo+ID4gLS0tDQo+ID4NCj4gPiBDaGFuZ2VzIGluIHYyOg0KPiA+IC0g
TWFrZSB1c2Ugb2YgcGxhdGZvcm0gc3VzcGVuZCBpbnN0ZWFkIG9mIGRyaXZlciBzdXNwZW5kIGFz
IGRyaXZlcg0KPiA+ICAgc3VzcGVuZCB3aWxsIG9ubHkgZ2V0IGRlZmluZWQgaWYgUE1DX1NMRUVQ
IGlzIGNvbmZpZ3VyZWQgd2hpY2gNCj4gPiAgIHJlc3VsdHMgaW4gYnVpbGQgZmFpbHVyZSBpZiBp
dCBpcyBub3QgY29uZmlndXJlZC4NCj4gPiAtIFVwZGF0ZWQgY29tbWl0IGRlc2NyaXB0aW9uLg0K
PiA+DQo+ID4gIGRyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktb2YtYXJhc2FuLmMgfCA2ICsrKysrKw0K
PiA+ICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1vZi1hcmFzYW4uYw0KPiA+IGIvZHJpdmVycy9tbWMv
aG9zdC9zZGhjaS1vZi1hcmFzYW4uYw0KPiA+IGluZGV4IDhjMjk2NzZhYjY2Mi4uNGFiZGFkM2M0
ZTViIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktb2YtYXJhc2FuLmMN
Cj4gPiArKysgYi9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLW9mLWFyYXNhbi5jDQo+ID4gQEAgLTIw
NTYsNiArMjA1NiwxMSBAQCBzdGF0aWMgdm9pZCBzZGhjaV9hcmFzYW5fcmVtb3ZlKHN0cnVjdA0K
PiBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ID4gICAgICAgICBjbGtfZGlzYWJsZV91bnByZXBh
cmUoY2xrX2FoYik7ICB9DQo+ID4NCj4gPiArc3RhdGljIHZvaWQgc2RoY2lfYXJhc2FuX3NodXRk
b3duKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpIHsNCj4gPiArICAgICAgIHNkaGNpX3Bs
dGZtX3N1c3BlbmQoJnBkZXYtPmRldik7IH0NCj4gPiArDQo+ID4gIHN0YXRpYyBzdHJ1Y3QgcGxh
dGZvcm1fZHJpdmVyIHNkaGNpX2FyYXNhbl9kcml2ZXIgPSB7DQo+ID4gICAgICAgICAuZHJpdmVy
ID0gew0KPiA+ICAgICAgICAgICAgICAgICAubmFtZSA9ICJzZGhjaS1hcmFzYW4iLCBAQCAtMjA2
NSw2ICsyMDcwLDcgQEAgc3RhdGljDQo+ID4gc3RydWN0IHBsYXRmb3JtX2RyaXZlciBzZGhjaV9h
cmFzYW5fZHJpdmVyID0gew0KPiA+ICAgICAgICAgfSwNCj4gPiAgICAgICAgIC5wcm9iZSA9IHNk
aGNpX2FyYXNhbl9wcm9iZSwNCj4gPiAgICAgICAgIC5yZW1vdmUgPSBzZGhjaV9hcmFzYW5fcmVt
b3ZlLA0KPiA+ICsgICAgICAgLnNodXRkb3duID0gc2RoY2lfYXJhc2FuX3NodXRkb3duLA0KPiA+
ICB9Ow0KPiA+DQo+ID4gIG1vZHVsZV9wbGF0Zm9ybV9kcml2ZXIoc2RoY2lfYXJhc2FuX2RyaXZl
cik7DQo+ID4gLS0NCj4gPiAyLjQ0LjENCj4gPg0K
