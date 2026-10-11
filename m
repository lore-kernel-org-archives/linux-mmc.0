Received: from esa.hc6817-7.iphmx.com (esa.hc6817-7.iphmx.com [216.71.152.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CAD71C75F9
	for <linux-mmc@vger.kernel.org>; Sun, 11 Oct 2026 09:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.152.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791712147; cv=fail; b=q4AVxw1wKRGHHlTRkqJA2zAG5V9NLLiLc+19W+lfqaKXgyPUeH/HwUQAWFIMMxiefiGPTE5nJd5wrCWCqN6/yVSbSj1BxrmFlfevj8e676F+8xb2Wz0hat6xrSqKWDjuRhFOrsIliKpimOJDFpuxhtGfHB/kC4dlh4c/ojZQOr0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791712147; c=relaxed/simple;
	bh=s9VDB6bRIna4A5xhdyOuxSWv7iuITr9tfEb9ykE6bns=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jVEl/NZmg3Q8I5E2JAJ4xPEaf1mwbz2DycGjGH8qNPKVk+7XEBLHvGHSkcItMpTMbx4e0+EZTo6l0vF4AYUvMyde5EF5X+LHcsIo4gPYtQTckwDJWezdGQO6WBG7TWTWv0V3ibtPzh3TeugegsSwvFBZOxA2/IU3Fj6IVa8P60Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=R51ly0Ya; arc=fail smtp.client-ip=216.71.152.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="R51ly0Ya"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkimnew.sandisk.com; t=1791712152; x=1823248152;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=s9VDB6bRIna4A5xhdyOuxSWv7iuITr9tfEb9ykE6bns=;
  b=R51ly0Ya+zwY1FksQ4WYiqBjl4lbKLg73WWvFTFjfGhFIs4hucTRS7bP
   Ha4of2tvlmyOiOsYDoa1/qz0pqlF8C69J8PzWGNpbp6lsLqwsyzIrbzY/
   bOPvyn2XMn6KXmZomXEdnNr8ozCBQsPxH6KzPVBw9I25lB2LUTMeX2bMj
   NnafRiQHaWDIihIENkp8S1b2n4IHZip3fmv29ViXlqiivQ/jyH0Hbh9I4
   biMYRY/CwDZhwoZcl/0crXs857N0LCcscMv91qc/fA3/4bs01/fQNALsA
   hwymqtv7vl6wIHEvnmClantbkhkG7BXOtVTwaSlepNBGjbw9u8g5MoXIH
   A==;
X-CSE-ConnectionGUID: vT+rJgwzTVa+WsGfHXjUtg==
X-CSE-MsgGUID: tr6oCZZQQjudX9hBZsl0Ig==
X-IronPort-RemoteIP: 52.101.57.74
X-IronPort-MID: 31886457
X-IronPort-Reputation: None
X-IronPort-Listener: OutgoingMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
Received: from mail-eastus2azon11021074.outbound.protection.outlook.com (HELO BN8PR05CU002.outbound.protection.outlook.com) ([52.101.57.74])
  by ob1.hc6817-7.iphmx.com with ESMTP; 11 Oct 2026 02:49:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UPFD2CE1Y1Q+LhSH9ODlqKXW4X13fi1W53nFAxvwJAcPUrbVTpBK3d3J+Ofy51oeLuK/17FbbpgcGrsVgEzf1v9yf5nROU9gAnTq6yzeFaM/5D2Xz7VN4PKc5sTCKhkZq3jKvW16UQs37Wi8fir3rytpARFJdhvdHpk+gmNWtkrq4KCmrH1Ukfjmk3dHFYyK4NofzNWOdhsZZNYiW3S6KhujOSRwCPgUu4WwpMBdBv6t5bRLQT506CMjbhIOMQ7SakoskZP68wUpx3P7wtTwf63glQSAwnnS+Xn2imo3S29F/MIv9TkDe0ndu50hKfxF6sZc9CEJq/2gVfzxlNCrEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s9VDB6bRIna4A5xhdyOuxSWv7iuITr9tfEb9ykE6bns=;
 b=Hg3FsduVqKeF9v9nS5CDaLnXkVStUP60w5NKE+N927sELBXNSsLUu/LZ3PP4lMXIsgJxz7vAp2IxPOMcLmrx9grQ7OQ5S9t5iUKPuI8Q6Pq1C8A9wMlXg0xZuHHifMZX+uUf2ddWfwxDFFRCt5cfF/NDBHd4Ngv+fCYHHYknJSnfKZWX632FX7UdPgqA9UIqcsBqqJ/qa6vD1qO29PfyriUC1qLHgMeNLs/wCDZpYqyhcwPlNviIcqOuffR00sqLOW33pGzri8zK6J7nam4mO0aQwzVeGMa67OTwaAvbsdH8m84Vvd3XzeJV8hf8iCpDTqx42PZmsss0NJCRjdn/cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sandisk.com; dmarc=pass action=none header.from=sandisk.com;
 dkim=pass header.d=sandisk.com; arc=none
Received: from BL3PR16MB4473.namprd16.prod.outlook.com (2603:10b6:208:344::6)
 by SA1PR16MB6931.namprd16.prod.outlook.com (2603:10b6:806:4b5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.20; Sun, 11 Oct
 2026 09:48:57 +0000
Received: from BL3PR16MB4473.namprd16.prod.outlook.com
 ([fe80::f768:136d:184a:ebb6]) by BL3PR16MB4473.namprd16.prod.outlook.com
 ([fe80::f768:136d:184a:ebb6%6]) with mapi id 15.21.0496.019; Sun, 11 Oct 2026
 09:48:57 +0000
From: Avri Altman <Avri.Altman@sandisk.com>
To: "sebastien.bacher@canonical.com" <sebastien.bacher@canonical.com>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
CC: "ulfh@kernel.org" <ulfh@kernel.org>, Sebastien Bacher <seb128@ubuntu.com>
Subject: RE: [PATCH] mmc-utils: Use an unsigned byte counter in DO_IO()
Thread-Topic: [PATCH] mmc-utils: Use an unsigned byte counter in DO_IO()
Thread-Index: AQHdV2huQjIdYXKeK0mxlRQ07yjnJ7b4HF0g
Date: Sun, 11 Oct 2026 09:48:57 +0000
Message-ID:
 <BL3PR16MB447307F6270565146D75D9F5E5902@BL3PR16MB4473.namprd16.prod.outlook.com>
References: <20261008-do-io-unsigned-counter-v1-1-744fa81f0a0a@canonical.com>
In-Reply-To: <20261008-do-io-unsigned-counter-v1-1-744fa81f0a0a@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sandisk.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR16MB4473:EE_|SA1PR16MB6931:EE_
x-ms-office365-filtering-correlation-id: 01dcc812-08ab-4140-5f55-08df277cde7b
x-ms-exchange-atpmessageproperties: SA
sndkipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|6133799003|10067099003|55112099003|18002099003|22082099003|38070700021|11063799006|56012099006;
x-microsoft-antispam-message-info:
 WB76fts2J7ZvD88mFDHS1TmBOxfu6jcHfo2DA/Mq2X49Z5rbuR8eT3sTCnWPWHXJu+kHQFMosdC7DqR5PYx+J6sHUTypRxPhgrj2YkyXsM46XTj+JU2czhGaOWGyBr4luqtm2FdGS8/csokJYooHu39TedhuNkNJn0H3wgLp1IVt0EhG7j5vxLyl4Rw2GtV30xterQmL9ZJC42ZaOJqETG3RHEn7reAyCot2RncMpKzL+fYDLz9FTBkoAF0zs7c4b/7HkBu0bZIz5jEtvpwdzyQN4afikhm4JiuiVsCRBcA+HwGrZxmLJluc8HQ0wvzQatzcNBvki98jHEH6kGPyMjeGg8Hjg6jNAwABqG4GlwwE0UznqQgEP5ZwJuUXg/+Tg+VTeGv3ToaEXfBR82xtzs0Yg6QAq1zLSe077z53xpawwa8k6KOtH0d7GX4VPXhXd9qZIFhySh+MueX2hzJgqZe8vbq1x6ucuWJoms/Hq0fVo3n062uvz+rDxdLColXLZzLhxvbEPxgSYczOR0zDQQ8iieXl8y1miScKoywvTCFCp0OP6QQGaBvUsmWQsoJPQXpPfjqHtwTznBQgNBjNSo8nG7qtRm4TRvR4q8+7AsTQkNXADhcXN0UtmXe72ZUwtMFgrH6BVsDIvIR7feNBdjMqJB1fVWkL7tHLli2QZajJwVcaX0mhDT2xUwDQGOSpzcmcL/uvxy98aCdj3SAwZZLsHQQE+gdS65OzC/f8lAY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR16MB4473.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(6133799003)(10067099003)(55112099003)(18002099003)(22082099003)(38070700021)(11063799006)(56012099006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K21sU1hEMDdzOXpZNi9CSjk4by9vUTIzOVYvbGd1VkRKdkJRWFhUdktNWkpT?=
 =?utf-8?B?aTlTVi91Y0xiZ2JWZGoyVldBZkREbSt2T1dMNkdCcVN2RkEvZmNQcWo2aXFs?=
 =?utf-8?B?OHk2R21PYnVZY09rRzlpN1dGMWYrRkNrTWcyWnhiZUU3OWplUElZVHdIanp5?=
 =?utf-8?B?c2JqSkkrS2QyZ1JPL3YxejRnZHc2QzFqYWR4WjNGZHFsVnF0bHFNbjVuN05I?=
 =?utf-8?B?Rlk2ZFhNOFAxZFBOSEMyK1hMbWNQb0dkaWFBZWU1ZWk3UTRjcjVQQ3EwUUxu?=
 =?utf-8?B?M1Y4ckVyUTJmWGw2d0duMlJYRkZNejJzYy9Va00wb0F2NFlHM09uZmZZRy8y?=
 =?utf-8?B?RmpjZHhoWWNMRmdNZklQNU1mKzM4cXljTjZBZkNLVjdwSjBxc0FXaUxJS1J1?=
 =?utf-8?B?OU1mRHNZOGRWSWhCMWNIbTZ0RjRRU3ZXNDBraTV3eXlyZXBuWUVUd2VkdEJy?=
 =?utf-8?B?YWgvdWFJVFd5VE5ManB0eEdBOGF1ODZqZktYWktSRHBldGZjdjB4a2tlZGcz?=
 =?utf-8?B?dDVaa2RudmhlWEVINU1uWHdtLytGYkJyQmdrVi9NMFVGSE8yU3JQZnhYZm9x?=
 =?utf-8?B?emZWQkNPOEV3QTRRUW9SR1hBSHdTQWgwZzVOdnhHcTRvUEx5VWFuMkxXT2pW?=
 =?utf-8?B?Rzd4Q3dCTnNnWEhuakRIeU9KMGpBSENsM0hWL2ltQjc1b0syYlo0cEIxSkxV?=
 =?utf-8?B?aHo4WFcxS0JaS251TS84NmVRZHlQR0tQaDZ3WDNVcFlMYWlxSVM0Wjh3MUZk?=
 =?utf-8?B?ZnBnRmk0bjFFVEdQaitwVWlwdGRyUzJOcmxSYVNNSUo5bENtL3k3YlpjR1U2?=
 =?utf-8?B?RzJSWm5sSUQzVStST0l2T1R0Yi9wdTZMay9iOGFHYVU3WDlGSjk5Vkx6eW5G?=
 =?utf-8?B?SGZXTGZvU2RqUndiaWtzNHJhUjUxYzk4ZC9QdEtnOTVqZHFOeTY5QkFSQUZC?=
 =?utf-8?B?MDljRU1BYkYvc2x6WlhWTmw0Tk9pVjlUNmVFSk5TY1lhc2dZa2pQdmRrSVk2?=
 =?utf-8?B?b2VYZUlxblk2RkQvYm91VVNua2pTMGlGOWVKTms0UW85aXVKSjFkWlZSbTZB?=
 =?utf-8?B?U1hjYS8zRFIrL3d0bDN5YTltYW84Y0dsczJRMXJrL29JTW50bUtxYU8yMjVW?=
 =?utf-8?B?cU5sK2ppcEM4UnRWNnBNTDdkSDk1Y0FoRmhvZ0NEd29LQWhmdFJQcnVpc2lk?=
 =?utf-8?B?VFZyNVVsT21EcUVLZ2UxQXZ4NUZZTklOb2ZiTGw0K0kzeks2bDkvTzl1N3RL?=
 =?utf-8?B?V2NsNHpvRTBOUTZyZTkrM0xYSUJEUHdvUmZyMXFjZ09XU3gwcGsrU0tKa1Fo?=
 =?utf-8?B?dHpQaDM2UllXYks3RDVsZzhFTTAvZDBtbVpUOHk2RERCZnRZdVoyYlBFSzJx?=
 =?utf-8?B?ZUxsT0tzbm1rV3BMN3k3RmZwbVRLMUNlWEZ3OEdvbFVRQWMzdGdMM04yWmNj?=
 =?utf-8?B?ZUlpRlhFam9oRjNGbzVYZ1YweVpYdkt4YUFtekgvNDBQVHJtdlNYM1dyS0xW?=
 =?utf-8?B?MnJtbVVpVGpySHViUStsUEhjRlhWOUhlZXhqQm94Z1BiaWRQVmp0NGJvU0R6?=
 =?utf-8?B?R1c3U2F4QXpkU2J5UlJ3eUZ4dGZPKzlzTEkzSWgvTFE1N211OFNYWnlSWGFp?=
 =?utf-8?B?aTRaRWlPREVIdGtIV0VMc2RuV0RVdnVYRjZYNWNkbk53REdOZ0ZWbHIzbFJO?=
 =?utf-8?B?UDUvKzgvY3BUNXRoMlJQa0UvOWtIT0V3QkFxaEd4WlFmdkt1MVo4U1VoVERp?=
 =?utf-8?B?MDh6OUxOdzlOWllnbnc3QklZb0ZhT2pwV25HcWRVMHp4a2VNQnVLUWZhSTV5?=
 =?utf-8?B?VDVERDBDbzZ6cGRNUHN5eVJON0NNU2xyTlJaKzFjZ1VOL290bzU0NWM5MUFE?=
 =?utf-8?B?TlZXZWhKckZoWUQ5bWZkQWVRUnp3cldLZm9pczQwbW1OTXRPdENxTXo0cENO?=
 =?utf-8?B?S3F6TTVDYUxpbndvcTVWL1VqUG5neW1yVlI5SFZ4dFkzaFhxeGpXd0JMNFFh?=
 =?utf-8?B?bmtiU3RDZmc0bjdHSXlheE1mZE1oc2w5Q1FNc1d4dXJxVE5KM1ozUUNOYkF5?=
 =?utf-8?B?M01ZVHlTTEk1ZGNBV0gwNWRlRVZzQU5yWldremxFaHg4bFg0dVZhWUxWWTBE?=
 =?utf-8?B?SDRuMitxVDZNalQ5Q1Fxei95OXQvY0EzZkt1YWpTT2x5eHZCRlBRUnNCd1FS?=
 =?utf-8?B?RmlWLzE5bE9rNXhIMGZlSlYxaDJqRVFua0dhaGpjQVRXZ0poYWhFWlc1S2k5?=
 =?utf-8?B?UUxhYlg4UXFBZUpHZjdzazdkdFMxc1M2Q2dmdlJNUG8wYW9SU01ObDFxYXA3?=
 =?utf-8?B?elpGUG9PN0lSM1ZpeEJnWDNybHlTR01KWVIvYjhpVXc1cTJuWGhhdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	UbFNXC80aqtq9Fao/cgpzlpI+AUuUDKu9hpS5MHoEleZCdNZpJUQBjsxmypgLVnV1G511O1d44Be4cOB48BirZWWzKlxKuQaMWhAvqsB6AHKbxdgJUfJqa1sXTIkmWBjfxy7WgHMrk8DW5/2UMTjI/7jb3dX8al3LiZ0XzkyfsXKTOu0l7R+2D9Wx1kolxqDeBUCePFtmHYKLjGPuLgxq4w3ROOCofe1eLLBMN5y+COsEEi5B/iE2wrPPJWhNtHwgNNFS+piZCqlNGC62NW2voCLIxxS+Fy1eK6nFadrNO8AnB2Dp76iNUtQ9Di8Nj2gVnu774sFUFVcAQ7tADlf8w==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kCz8CJNAjY+jCYnuc/w8MTJKRtAiPCrap20sUH59Vr5OU+7dRqN1Cq8pwvbptwItgDVJMnyFf7bg5kSrd2N7a5zq4VZeomt8pN6MNcPTjw4d9FbaUn3BW69Kg0+I8v3aQZEUofaRFYxtFYQbnpIweGNFQNCQb+0IH+SK/ZBS/vm0KzRWNHj3VvkgX862U5evYrC3aDkh8sBBMBuLswnrP3YFNqmXb3l8cbmtw38l5+SyLH1tIM6+MesvA8MlycUEN7nWMWW5U19KydX9iAHZReapcGazZt+qGpXHbnPpjtXHh0ykhRM1vLMFiOqSuuln/varZkc9i32HtotXIUSHnoPL5ogjG6bQGCWyAgr0lNW8iOf2PXmAp9bQMWUnacM9VZE0oOcc7UIulDzf8zLkSgGBd5EWN+c1vDBlJxx66QzFagGwEYB2olQCb5y6mUitzHz4McUq6ZAk8TxVZpynrdJIMKKlmIX8hamB23fqAGJVkSdzgrfCFUluy0Gtlek77/9vzxj4ek/HUcuA8QIFH/XyiR5TkWgvIfkSb9VzT+d9AOKiskc3YOaTZwsxnjOuI3YbiZG9GUXhgS4789LlHErA25wge1wcP7UfMR8KVwn8Hp9DHRk+EDLjvM4HODRibmeC3DwXpwCALwgTOOXyfg==
X-OriginatorOrg: sandisk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR16MB4473.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01dcc812-08ab-4140-5f55-08df277cde7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2026 09:48:57.1892
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ffe0ff2-35d0-407e-a107-79fc32e84ec4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5GYoGVCt/FhKODWfCgxG7PnHGNAo9RJ5TiWIvuJKXHkDz7JyVwnZexvIaFXcBWjNY7Bj74I7zTaMYJ3YnesaWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR16MB6931

PiBGcm9tOiBTZWJhc3RpZW4gQmFjaGVyIDxzZWIxMjhAdWJ1bnR1LmNvbT4NCj4gDQo+IERPX0lP
KCkgdHJhY2tzIHRoZSBudW1iZXIgb2YgYnl0ZXMgYWxyZWFkeSB0cmFuc2ZlcnJlZCBpbiBhIHNp
Z25lZCBzc2l6ZV90LA0KPiB3aGljaCBpcyBhbHNvIHVzZWQgdG8gcmVwb3J0IGVycm9ycy4gV2hl
biBidWlsZGluZyB3aXRoDQo+IF9GT1JUSUZZX1NPVVJDRT0zIGFuZCBMVE8sIGdjYyAxNSBjYW4n
dCBwcm92ZSB0aGF0ICJuYnl0ZSAtIHJldCIgc3RheXMNCj4gd2l0aGluIHRoZSBkZXN0aW5hdGlv
biBidWZmZXIsIGFuZCB0aGUgYnVpbGQgZmFpbHMgb24gdGhlIFJQTUIgZGF0YSByZWFkIGluDQo+
IGRvX3JwbWJfd3JpdGVfYmxvY2soKToNCj4gDQo+ICAgSW4gZnVuY3Rpb24gJ3JlYWQnLA0KPiAg
ICAgICBpbmxpbmVkIGZyb20gJ2RvX3JwbWJfd3JpdGVfYmxvY2snIGF0IG1tY19jbWRzLmM6Li4u
DQo+ICAgYml0cy91bmlzdGQuaDozMjoxMDogZXJyb3I6ICdfX3JlYWRfYWxpYXMnIHdyaXRpbmcg
NDg0IG9yIG1vcmUgYnl0ZXMNCj4gICBpbnRvIGEgcmVnaW9uIG9mIHNpemUgMjU2IG92ZXJmbG93
cyB0aGUgZGVzdGluYXRpb24NCj4gICBbLVdlcnJvcj1zdHJpbmdvcC1vdmVyZmxvdz1dDQo+IA0K
PiBUaGUgbG9vcCBjYW4ndCBhY3R1YWxseSBvdmVyZmxvdywgc28gdGhpcyBpcyBhIGZhbHNlIHBv
c2l0aXZlLiBUcmFjayB0aGUgcHJvZ3Jlc3MNCj4gd2l0aCBhIHNpemVfdCwgd2hpY2ggY2FuJ3Qg
Z28gbmVnYXRpdmUgaW5zaWRlIHRoZSBsb29wLCBhbmQgb25seSBjb252ZXJ0IHRvIHRoZQ0KPiBz
c2l6ZV90IHJldHVybiB2YWx1ZSBhdCB0aGUgZW5kLiBUaGUgYmVoYXZpb3VyIGlzDQo+IHVuY2hh
bmdlZDogRUlOVFIgaXMgcmV0cmllZCwgb3RoZXIgZXJyb3JzIHJldHVybiAtMSwgYW5kIEVPRiBy
ZXR1cm5zIHRoZSBzaG9ydA0KPiBjb3VudC4NCj4gDQo+IFRoaXMgaXMgdGhlIGRlZmF1bHQgaGFy
ZGVuaW5nIGNvbmZpZ3VyYXRpb24gb24gVWJ1bnR1LCBzbyBtbWMtdXRpbHMgY3VycmVudGx5DQo+
IGZhaWxzIHRvIGJ1aWxkIHRoZXJlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogU2ViYXN0aWVuIEJh
Y2hlciA8c2ViMTI4QHVidW50dS5jb20+DQo+IC0tLQ0KPiBTaWduZWQtb2ZmLWJ5OiBTZWJhc3Rp
ZW4gQmFjaGVyIDxzZWJhc3RpZW4uYmFjaGVyQGNhbm9uaWNhbC5jb20+DQpSZXZpZXdlZC1ieTog
QXZyaSBBbHRtYW4gPGF2cmkuYWx0bWFuQHNhbmRpc2suY29tPg0K
