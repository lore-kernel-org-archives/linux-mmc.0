Received: from esa.hc6817-7.iphmx.com (esa.hc6817-7.iphmx.com [216.71.154.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B16931B837
	for <linux-mmc@vger.kernel.org>; Fri, 15 May 2026 16:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778863576; cv=fail; b=Vwmei187VaE8QGZgRSGOC7u4ikJIYYEpyqvPHep0SxlfgAjy++YJZiZ7nOKpBtDO2WPUj4XP1rEEpJ8Uuu8Ea6SmJyFMjXfVePemDyy+O4XbLVUGmyGNu6bVAz0zxWEbRa/GTMeCc5I8JEJ1xad7OHux+PldBKUf4HnvYAl/mOo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778863576; c=relaxed/simple;
	bh=btpUUbRpGPV2H97rDEZ8l4lyLvBD7QFXouXCp2yiQbQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nCKvSvuovqY3F1yNsncWp8JP6oDH1yrF3KnuGzplq91oj3KvBQdP1b9Rsp2wKvxuKBHNocy5+3NELarc7KPTJFLWDoMX7YRCbUjIeVDIeXTpLXhjq1OJuWJQcjSGGQ+u4l+xolXxEGWN3+lbstyi7Htr94322xMnfIzDvqSMvw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=j9SCm7bw; arc=fail smtp.client-ip=216.71.154.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="j9SCm7bw"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkimnew.sandisk.com; t=1778863574; x=1810399574;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=btpUUbRpGPV2H97rDEZ8l4lyLvBD7QFXouXCp2yiQbQ=;
  b=j9SCm7bwowkL9q8LXOnsm+Ouf7BTBavt9qqfte7caG2RQoFQtVY21nJN
   d315T1LJPZg3Lx+aMnpLCuNEnXlxi6PQax+7NVbuV5uMleorZl7fibrQ5
   67QX7E6vFT0mEKaDupBzY/JcKNIWsaI7KBYR28/QOMa0yxGxV5KvUmRRX
   OF8kq0smVMB3Sxl7WuEcWDXoUn7SZMI7RklJT2xwR0hc90lNYlHi6FAqt
   tFsgi49UABBPln2AV7rS3XXtuUcrsyRgUT0QX14QdWfZ/WCliqIXuG0RN
   4zpUeXtdBdCWFGaD50z58K5nKBGFwEj477ypzf1K+LJ7NuGLfM+zoMnTD
   g==;
X-CSE-ConnectionGUID: +Kz1G7nPRMCGaeHyl1WOeg==
X-CSE-MsgGUID: To9zgYnaSRKj/jlP1cXXXg==
X-IronPort-RemoteIP: 52.101.52.70
X-IronPort-MID: 22598237
X-IronPort-Reputation: None
X-IronPort-Listener: OutgoingMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
Received: from mail-eastusazon11011070.outbound.protection.outlook.com (HELO BL2PR02CU003.outbound.protection.outlook.com) ([52.101.52.70])
  by ob1.hc6817-7.iphmx.com with ESMTP; 15 May 2026 09:46:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FR0Ir1BRu/Hv8U84TEOPTbHrWkAKVjDBGQ2i3qjqXEdsTfVwScYW8haSvguvysNTtrvVaO9RBi/lnjdo43Spk5ziBxr+cPzfH3JbNzh9bRYwLfHfLjjzOph80duuCSg9LcgBEBq3K50j0bA6cQdocHE6jE85XN8m6tvR/xafVFSdNS13DEaDfE+Vry++dqj60DAMW2QySW4GeoyGbug8IBS0XHIgnsBQe2PF3FVstq6oR5YRRQ+FNqdRd6ltxlXJmcLDrpPGZiSqrBxDWpMI9Kl/hv2bJNfO7sWRZaADNE7f0avAL85sZyNv0kGcwCJU6DsSISV2ybMSGshXK3Dx7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=btpUUbRpGPV2H97rDEZ8l4lyLvBD7QFXouXCp2yiQbQ=;
 b=pXWxdm8SP4hxA9hrLaBif+7SmyjUA3yayL9OiZnUXEqJ0bLdCQMQCJFmDqDq9NyKjZh71x5GN+ttygVB6DpAp/VBzY/IyzTD+lYHD4sgcuT9IcB44kKXMccSc/9JGsQYKY8HoZRRowOlRmlwFVcof+bF6g7HWGMGI0QVNxXy1q5aeSaIjPcKIe0EO1SPbBgLLJ6t3iG2GpfaWT4r56OE0QGbF+ZwUtiF1uBKnhRV0iEymTASkdAHqzd91gN06WuFMTfbU58PBXHmhP5XScpfs4eo974kPuG7xPGw5R0LnuksVcgJ7coSch+AZqxnTE2qOzxVypALsTmTo8c2JwUkhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sandisk.com; dmarc=pass action=none header.from=sandisk.com;
 dkim=pass header.d=sandisk.com; arc=none
Received: from DS1PR16MB6753.namprd16.prod.outlook.com (2603:10b6:8:1ec::5) by
 SA2PR16MB4139.namprd16.prod.outlook.com (2603:10b6:806:14f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.17; Fri, 15 May
 2026 16:46:10 +0000
Received: from DS1PR16MB6753.namprd16.prod.outlook.com
 ([fe80::72d7:97b5:4539:a90]) by DS1PR16MB6753.namprd16.prod.outlook.com
 ([fe80::72d7:97b5:4539:a90%6]) with mapi id 15.21.0025.016; Fri, 15 May 2026
 16:46:10 +0000
From: Avri Altman <Avri.Altman@sandisk.com>
To: Torstein Eide <torsteine@gmail.com>
CC: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Torstein Eide
	<torsteine+linux@gmail.com>
Subject: RE: [PATCH 0/4] mmc-utils: improve lsmmc usability
Thread-Topic: [PATCH 0/4] mmc-utils: improve lsmmc usability
Thread-Index: AQHc5EYsnUJ8HpUMLEmA4IQiTNAj9bYPJYfggAAbX4CAAArdoA==
Date: Fri, 15 May 2026 16:46:10 +0000
Message-ID:
 <DS1PR16MB6753295FF074D304308ADF78E5042@DS1PR16MB6753.namprd16.prod.outlook.com>
References: <20260515083457.3690804-1-torsteine+linux@gmail.com>
 <DS1PR16MB675343BEA9DE94B268CDE927E5042@DS1PR16MB6753.namprd16.prod.outlook.com>
 <CAL5DHTFvJfV1DVNjBLsdCQ8FP7TmNq0SK=EpA-2wWzdo4+FsRQ@mail.gmail.com>
In-Reply-To:
 <CAL5DHTFvJfV1DVNjBLsdCQ8FP7TmNq0SK=EpA-2wWzdo4+FsRQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sandisk.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS1PR16MB6753:EE_|SA2PR16MB4139:EE_
x-ms-office365-filtering-correlation-id: fb324e90-74b7-485d-0709-08deb2a177c2
x-ms-exchange-atpmessageproperties: SA
sndkipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|22082099003|55112099003|38070700021|56012099003|11063799003|4143699003;
x-microsoft-antispam-message-info:
 fzkEpz2XS5CkHZhVz1wfZRfHH6QL6qaCx2iXN0k8ofXLXuKcVnY/xHBEt4ukEmS1zWn5mXkivcBdoCogkBL32jAKAn1l0JprbP45BD8UK+CWpzc/0GIASL541bpBsLybB3HDdNa2qBGU/hGjYB/cbZR8P2GQ716bZcfHc1SRdaWDwpCJuzmV9in60SVkOGgmKKnO2pLPTk0kMiJQwAwG7vKS+MPCnVdbNxPpu/dfpbXV2pBsvbsTvh+zz8Bmk/jGWc+uEZTfZykFQbWay1dk/an4QJTiycvagoZy/Js8+0ET/yKkSn8t0eJCVAQRnHUXB1w0mykmsrwYO1zy5bx0ZV9EVQOEElubfMTpZ90AQsnor0L9BGf1clrmbXmfkgVvBLfglno/qVPBAZWEOLuGVOB42w3BGgf61THAEZjzmpN8kUlMc/CzfVepNJyhz+j60CnGXniP4MDf6uPTWypBHPsM00d3uQPvxjOZMTpGyB+C8lbQhXL2EIBREyP/DVzcEAOuH55Sm33qGhTEw/gcQ9ggDPPYdicz0hpZDfszT3ksl6xCnHjzRdcwlb7mSHR5gXnomAXfp5+EjRvjzWJDpAvhpif+ouOM8WzVacov3cyAy/dMwHMDtLghPBCfD2JZn+UnENQ2TzF5IE0cjAbUQkRuCQtGVzbYv44KqvD0jblZUzphGuGICOu6HPn9/pNTH5U4mIYuUjnqUmwlIqKkgJnKQgdTIIaLWOxLLrug52olTGLKz4uRTSW1p66hZvR1
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS1PR16MB6753.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(55112099003)(38070700021)(56012099003)(11063799003)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bzlTUG1OK0svUElVV1BJTzB2MEVhUlBrRDYwZ2Y3RlFuQmN0VHhIQStYWGZx?=
 =?utf-8?B?Vk9taXd5TVUvWkFvZDB6REpuZGdvVURNY2F3LzQ5Y0c4MnRUaTlWTWZFT2tT?=
 =?utf-8?B?eEJqNkRzdUJ1cDgrR2NYbXBGNEpPYmw5RFZiNUovSFRVdHQzNXdrbDNOb0NR?=
 =?utf-8?B?VDZWd2RJdXAzaDd0VTd3UElGK1RXQmxpN0VkUFUzMHhtWE02aXp3eVhZYjV1?=
 =?utf-8?B?YnhWdGVubW9ON3FFUWdqTXNsS0I0WUcvdmtHT0Z5eWhZQVRIY2J4bW53STJx?=
 =?utf-8?B?SWNuMFJzYjJZbkY5c2RYbkhlVDhJUExTc2szbERlVEIvb0ZoQmZFQkZENFVK?=
 =?utf-8?B?dFFvdlRpcXo0QmRzOSt4Sm45bWlxcTM1YW1zMFJvdklqc3Y4TW5veWR3YTVH?=
 =?utf-8?B?SjdmYnpBeGNnL1FJRUsxQUNjaHJjYUErcUNyYXhTa2dweHpEZURJSlBTb2ta?=
 =?utf-8?B?NVFTcVNmWVRGcE9VejJmT1NNNjk5UFhuaUFDTm9EMXBBS2hEcVNvc2JWTjlR?=
 =?utf-8?B?VEJOdXd3RmUxT0xJM3B5ak9TdkFHbEpzci9RQTR5Mzl6YXRDeG5wMXpZWkpu?=
 =?utf-8?B?cnBZVExyWHlTNkJ4YzNQY3Y4NHhkOVpaZ3JzU0k1ZXVhRWRqQVQzdEp4SkRQ?=
 =?utf-8?B?NmZGZGZYc1NaZGZKSHNpei9kSGxMM05QYkdGOW9hZjNHWG9MV2ZxSVJRZlUw?=
 =?utf-8?B?WTF0NjBIS1JnOGF4d2VOR2RSZDJST3hHTVNyUVJTNlhQSVNHZzBJaVk0cEM2?=
 =?utf-8?B?SXdHeTJZLy9VckY0RkRiWmF5N3pWWnFuUUxVWEFmQ3BrVkdoS2R5NFlYaDVx?=
 =?utf-8?B?bUE4RmJYamtGamMvc1AvbmNHV1pCWlFhbkhmNnlJTkN0OVJoZTA2SmJpV2M5?=
 =?utf-8?B?bW14L2FDbzJ5ZEF1ald6c1lIUEp3bVBJMWowR1VQTU5lcFdRcklrQmZzRGx1?=
 =?utf-8?B?R1c0ejJCeTRwbVFkZkE5UzhZdW9aenlSNXVJUThLTWQzS2ZVNFdXdTQ3ZmRZ?=
 =?utf-8?B?SmVOYTVES2hDT3RsT3J5eDd0aDIyRXZhS0EyQnZXOTMxRVRxWFppWGtRV1Qw?=
 =?utf-8?B?aCtxYThWd1lpanFWcnJBNmtDeUlhdHlENjQzeEVwTjE4aDBUVE8zb2c0RUJB?=
 =?utf-8?B?NUljZUttbDQ0WlB6NDFyUXZIM01GcU54b05XZStCcVVLelZxM2poZmI0QnJV?=
 =?utf-8?B?MnhibER4c0NSVU0vUE1XSk50VzV2VEpXM1crbE9YckNxaXlaRTZ5WG1RUXZu?=
 =?utf-8?B?UFRzazNaRG5HQWtpTk5TU2ZUU3RyOVVuME5IMXA4c3FMczdCQTY1dTIwdjND?=
 =?utf-8?B?eHFOOTV2K2J2V0tWazVTSWFOdHZ6dEdITS90S1BhRzFONUYrcFBqMjVkT1R1?=
 =?utf-8?B?TCt3ck1ybjlwRHlVNm02MW9maS9Rb3VuKzAvdkF1Z1d4REgzdEo2em5mZ21F?=
 =?utf-8?B?ZlZOdWZMMENwL3I1VmRPOTRLSzlEZElaTENuSjdMV3kyeTFHd3p4aFYrYmYy?=
 =?utf-8?B?U1BvTjVoYytjTXpLamdGRXY4MnFxR1lTdCtWVXpuanlHOHN1NnRHODlJWW5S?=
 =?utf-8?B?YjdscVVKWHFrMnBjb3VnRk90a1ZxTTZvNS9hRWJWeURuOFJiMVAyYUtSSUxP?=
 =?utf-8?B?bkhPZmlkWjBtai9WQkhkbis5TnZzaDU4ME40elRZamxOOGovdWRmMUtlTXNa?=
 =?utf-8?B?c3Q1c2cxcFg1RnZNOTdwQUdFZENDaEZoS1pjcEdwRTZEdlVRUDBxcDEveEk3?=
 =?utf-8?B?ZmtTNDA1dnp4MDZBaG1Tei82dkxIdVBVWTZacFZKaVJMdzd0RG1CSjM4bC9U?=
 =?utf-8?B?d2h3eHRKOTFiWi90d1lFTzhHb3N5ZEhiOWc4VU1jVE5xSHVIZS8rTzR2aVlo?=
 =?utf-8?B?MXArM2FYS3IrTUhyNlVWbHpVVk9jZWY5ZnZ2Y2QzS3dZdFZCWFh2eDVYd2pp?=
 =?utf-8?B?dk5lWnJPQ1kzYUxuRS9HdlgweXV3RzA4VmxLK3dwdXEyTk1aMkMyK3daQkpa?=
 =?utf-8?B?Z01YM2NISGRpejhHVHRRUkR2azJidmJ6S3VvUS9tK1UxSGtieHFtNU0yUU9Y?=
 =?utf-8?B?ODBEejVKQkZ2TkRxaUxhTEFvSm0yVXpyZ2Y1RG5Kd0dpOUhjMEMwMkgxSTFB?=
 =?utf-8?B?ckpqRDYvQjRPRkYvdDVPbFhSS0xWQ1ZOSUpQdmR2em1ZLzZDdjBKTDhvQ09D?=
 =?utf-8?B?V3dVZlFtRmhOcXpMSm94RXJDYTBLVFcwYWdSNUo2aldrM01rcmNDVSsyQjJF?=
 =?utf-8?B?c0EwOW5JL2ZjZnJVRGV1YkUydDdvalVrazB0OHQ5Y2JDUktOMUUyeWI3WkpQ?=
 =?utf-8?B?cWtCRUJZakxFRlZSbDd5MXZ6b3NUVG5mWVVQTmNjVW8vMzFaTG9nZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	Gjbo4skYVxZ8/PZ/61SWzcuWI4HXpG+elUS67tuzbOjGRRjK5ll0pjCjuDYXPAEYEAJ7xsSq3ETKQPB+k2v7maM8h8kmoyJXDF+t/nz6z2NoAOmhVDvxCBc4cr2tbOaxeRTTo34+OiQ5yp+wsvuXBvnx5NrpqpAw5p4OHfXL1FrBBn6nRhafs+4u1d/nd0OeXtFw7Qj1BpdS4qvKq0Jc+yCNagv50D+Wg9lXsaGbZCqbMQ5hAZBui0A35Z3SOjX3zKcQu7PM/mRuUZDoTq4iajEwOpab9/QhNKMWDGIxRhL0Ri7H+LzY53t8Z+9FoEJU702Ac4JXfq8bSiOnhsBLdg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lSDoTZsXHHrAUYvo2rvqbuU7lEuFfYZd4as6fO7vg9211p/W/2UlPSzQIrEv7fYhv/9xv61c6pt3T4yDVt6kKx1xdr63DQr1zXhrcKF4s1EF4drEdd4kJvRklrD0udSIKAhj/uQHDsdaSMMDFS/2PCQP7SJ3t5YNQ5r39LqVFlF08ijIG+ILXskh/EF4ct0M4i5Up8yIVusAlAoLcZqqjUfDwU6un3fKnG1s2mvjZtXkEA4pBE0V9NCXFQBWcsITcjDJ/hxou1dft7It97iVm7YDvnpOC8rxk6/wxKe9l0Uj3eKmeZkRoe6kSW3V5T+UbitPHrFPg8aV3Chh46S7qnd/PNUV445buKC2SQGCvxP1daLFb+ym+Smlk7fLzC9we25ZJiJWsEvC+osfNurKfVsw3B5iN//xcMe+b1S5BMHs13q+or+q3YT3HORWU2IVKSTNJRV2BTDL3DWVvulvcj6So3kQm03ibqgCeTxbnKzWvfIVcR8GKV2Kh9vD7rN1nksf9XlDNQs5DMPWCoA6Xtx8xxWetzTos7u0Wf9S8YAb4s2H/coS96fc6gVpEypq38sD6gbCprDjAxrWdR+THmhoj3EYQ2jwu/N9nksp1pAMl1zbQLYT7nAUFRG2EZqI8yD8WWwftvy8QtpQOcpYjQ==
X-OriginatorOrg: sandisk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS1PR16MB6753.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb324e90-74b7-485d-0709-08deb2a177c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2026 16:46:10.1706
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ffe0ff2-35d0-407e-a107-79fc32e84ec4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QRr3r07jIyQXxDrjCqDVwsgPTIJviiJO0KfQo6IteuxJ0LTdeuzefNwwASK7pZuXTsqwau3mMkOksPK4aRdzhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR16MB4139

PiA+ID4gUmVzZW5kIHRoZSBsc21tYyB1c2FiaWxpdHkgdXBkYXRlcyBhcyBhbiBvcmRlcmVkIHNl
cmllcyBhZnRlciB0aGUNCj4gPiA+IHByZXZpb3VzIHN1Ym1pc3Npb24gY291bGQgbm90IGJlIGFw
cGxpZWQgY2xlYW5seSBmcm9tIHBhdGNod29yayBvciBiNC4NCj4gPiA+DQo+ID4gVGhhbmtzLiAg
U3RpbGwgaGF2aW5nIHNvbWUgdHJvdWJsZXMgYXBwbHlpbmcgaXQgY2xlYW5seS4NCj4gPiBQbGVh
c2UgbWFrZSBzdXJlIHlvdSBhcmUgcmViYXNpbmcgaXQgb24gcmVjZW50IG1hc3Rlci4NCj4gPiBX
aWxsIHJldmlldyB5b3VyIHNlcmllcyBhbnl3YXkuDQo+ID4NCj4gPiBUaGFua3MsDQo+ID4gQXZy
aQ0KPiA+DQo+IA0KPiBUaGUgZmlyc3QgcGF0Y2ggc2VyaWUgaSBtb2RpZmllZCBhZnRlciAgYGdp
dCBmb3JtYXQtcGF0Y2ggbWFzdGVyYCBhbmQgZGlkIGFsc28gZmFpbA0KPiBsb2NhbGx5LA0KPiAN
Cj4gaW4gdGhlIG5ldyBleHBvcnQgIGkgb25seSBjaGFuZ2VkIHRoZSBzdWJqZWN0IGFuZCBkZXNj
cmlwdGlvbiBpbiBjb3ZlciBsZXR0ZXIsIEkgbGV0DQo+IG5vdGljZSBpdCB3YXMgbm90IGhhcHB5
IHdoZW4gaSB0cnkgdG8gYXBwbHkgdGhlIGNvdmVyIGxldHRlciwgYnV0IGxvY2FsbHkgdG8gYSBu
ZXcNCj4gYnJhbmNoIHRoZSBhbGwgYXBwbHkgd2l0aG91dCBpc3N1ZS4NCj4gSSBhbSB1bnN1cmUg
d2hhdCBpIGRpZCB3cm9uZy4NCllvdXIgbG9jYWwgbWFzdGVyIHNlZW1zIHRvIGJlIGJlaGluZCB1
cHN0cmVhbS4gVGhlIHBhdGNoZXMgY29uZmxpY3Qgd2l0aCANCnRoZSBDSUQgZGF0ZS1maXggc2Vy
aWVzIHRoYXQgbGFuZGVkIHJlY2VudGx5IChjb21taXRzIDZmNmI2ZTEuLjIzNjRkYzYpLg0KIA0K
UGxlYXNlIGRvOg0KZ2l0IGZldGNoIG9yaWdpbg0KZ2l0IHJlYmFzZSBvcmlnaW4vbWFzdGVyDQog
DQpUaGVuIHJlLWV4cG9ydCB3aXRoIGdpdCBmb3JtYXQtcGF0Y2guDQoNClRoYW5rcywNCkF2cmkN
Cj4gDQo+ID4gPiBUaGlzIGFkZHMgZXh0ZXJuYWwgbWFudWZhY3R1cmVyIElEIGZpbGVzLCBhY2Nl
cHRzIC9kZXYgYW5kDQo+ID4gPiAvc3lzL2Jsb2NrIHBhdGhzIGZvciByZWdpc3RlciByZWFkcywg
YWRkcyBhbiBtbWMgbGlzdCBjb21tYW5kLCBhbmQNCj4gPiA+IGluc3RhbGxzIGJhc2ggY29tcGxl
dGlvbiBmb3IgbW1jLSB1dGlscy4NCj4gPiA+DQo+ID4gPiBUb3JzdGVpbiBFaWRlICg0KToNCj4g
PiA+ICAgbW1jLXV0aWxzOiBsc21tYzogVXNlIGV4dGVybmFsIC5pZHMgZmlsZXMgZm9yIG1hbnVm
YWN0dXJlciBsb29rdXANCj4gPiA+ICAgbW1jLXV0aWxzOiBsc21tYzogQWNjZXB0IC9kZXYgYW5k
IC9zeXMvYmxvY2sgcGF0aHMgZm9yIHJlZ2lzdGVyIHJlYWRzDQo+ID4gPiAgIG1tYy11dGlsczog
bHNtbWM6IEFkZCBtbWMgbGlzdCBjb21tYW5kDQo+ID4gPiAgIG1tYy11dGlsczogQWRkIGJhc2gg
Y29tcGxldGlvbg0KPiA+ID4NCj4gPiA+ICBNYWtlZmlsZSAgICAgICAgICAgfCAgMTEgKy0NCj4g
PiA+ICBjb21wbGV0aW9uL21tYyAgICAgfCAgNjIgKysrKysrKw0KPiA+ID4gIGRvY3MvSE9XVE8u
cnN0ICAgICB8ICA3NyArKysrKysrLQ0KPiA+ID4gIGxzbW1jLmMgICAgICAgICAgICB8IDQzNCAr
KysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiA+ICBtbWMu
YyAgICAgICAgICAgICAgfCAgIDYgKy0NCj4gPiA+ICBtbWNfY21kcy5oICAgICAgICAgfCAgIDEg
Kw0KPiA+ID4gIG11bHRpbWVkaWFjYXJkLmlkcyB8ICAxNiArKw0KPiA+ID4gIHNkY2FyZC5pZHMg
ICAgICAgICB8ICAyMyArKysNCj4gPiA+ICA4IGZpbGVzIGNoYW5nZWQsIDQ1MiBpbnNlcnRpb25z
KCspLCAxNzggZGVsZXRpb25zKC0pICBjcmVhdGUgbW9kZQ0KPiA+ID4gMTAwNjQ0IGNvbXBsZXRp
b24vbW1jICBjcmVhdGUgbW9kZSAxMDA2NDQgbXVsdGltZWRpYWNhcmQuaWRzICBjcmVhdGUNCj4g
PiA+IG1vZGUgMTAwNjQ0IHNkY2FyZC5pZHMNCj4gPiA+DQo+ID4gPiAtLQ0KPiA+ID4gMi41My4w
DQo+ID4NCg==
