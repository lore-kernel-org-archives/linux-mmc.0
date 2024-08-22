Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AD41CBE9B
	for <linux-mmc@vger.kernel.org>; Thu, 22 Aug 2024 13:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724333594; cv=fail; b=ZaQ9UeciR/odgW+c1pPynle/W7dBwrrQyaZr+MruojMyqA6Swn9c+Ryye6rai7H/a6PoY4yDEQmfrVEDsQ+YRzJNBOPhBBi/DKqkkmBraMd/I96fpNeZxRJh4wfx3UuAYq6aPlJFgvIkM2bKMDWQ53ERIEPk8Ns2AoRYucgIe6A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724333594; c=relaxed/simple;
	bh=zIfQDRDv0+yL9omQjTpLUmqpZA6sxcnuLVt681h/34w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=javSoalgHYE8HJuILLd3HZoMFkOrxVvsVCSH7YEsQCOEtZBJmQvoAysTf+qR7vw3iPIrxoosRWNaBzgnc1Jbsz8G8zVdDodO+WsksC2DlAPZjzEZi6XALrTRj8zx4Hwkn6ure79ZC1thZMDffj2KUk97YYC/B4UHQgCjbA1zGWE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=iEeo4GAi; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=mI68eW2B; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="iEeo4GAi";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="mI68eW2B"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1724333591; x=1755869591;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zIfQDRDv0+yL9omQjTpLUmqpZA6sxcnuLVt681h/34w=;
  b=iEeo4GAidahjcjex354S24rAVdSm4liD1qzYbHBWtWtG56CbtO+gEINZ
   /6WrOtfjQ39xj8yf5L4RmOiWeHJwn7j3pVan6ke7WjwHtKrXrU/u8cdiU
   dAHLW5pMqBPbvDp/JfqfpNCzjEGwdFFWiZGdaKr4Usj+5qDGEQN2+idi8
   2A04QZRTidQ5qil6XMVzYUxP35xJm4gr8D4UVPs9l0ckjKSnIe1TrNNdr
   jdyZG2KSKodvURD5FUo/ejs1lLHAEcPtVIrB8TBRCn5LaCsdTE/fkamjQ
   mKb6kpRv2pTBtYlDZD9Gvbcpn3Cz4L6cPkru5QojSPAkj1ZkEdhXx9yIk
   g==;
X-CSE-ConnectionGUID: 37ejW+fzRlWYun+6pgChSw==
X-CSE-MsgGUID: rXLG5sT+TICwz3+FXammSA==
X-IronPort-AV: E=Sophos;i="6.10,167,1719849600"; 
   d="scan'208";a="25895692"
Received: from mail-northcentralusazlp17010000.outbound.protection.outlook.com (HELO CH1PR05CU001.outbound.protection.outlook.com) ([40.93.20.0])
  by ob1.hgst.iphmx.com with ESMTP; 22 Aug 2024 21:33:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bznmy8vfpWwBvhVMKtyKoSZ8JMG6ZOKFnHjkTOnKl9ZtBVaSCDVCClXHCjtPicaiNGvkt5TdfC/NXQWdvu2ELpOA1dBdgRxsWBj6KTHAyDw5qV0Hu4WyOgIXFBIquPJfCuck7cADQoQoq9YZ0DytS63hWXEOx4J5BFyvWduYii8km4aeABH07xY2DYqCLadpYAd/ON+3QPbTTe9OlKKIw04bCBX+LZfR35IP0eYQQ+DqVOdEhFiEeaRKIdhxm91dGcfmUXkM/Esrmy4r42wRT+YxECqUn4K/+dg4bSqid3gUO6ZqyOGMKlzCmAj2Ec72wqyuSdNHRUei45nbhppUhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zIfQDRDv0+yL9omQjTpLUmqpZA6sxcnuLVt681h/34w=;
 b=UH2ohtM4lXLnalcTHzL0B2He2sDblbqj+5NlLNwJBoTop7LrLPpSbM39QIzxp+T9GOVeKhH1xi9Zxz37V8Jr7SLF0Y1Ro9pQtc5ZwfkwJvp5bdpkEMINhYRwhmWuU1SHuGBNvfP97/0841EAGdWFXTQQ/Z8A46KDtzLcyAevAvNHunqjRHkYewI3BwOn0yKRKHgJ8QBtOeL3RnnqkWFB+6bihuemoG7G2vJ8vnaHtX86ioPcffpEsKIltR3QSUHtoKBGJCly/JNxBNATdLJU4/QXYXgefEcRtT+FuD7iI8YxXH5gl4anYAz10M3PavsslRnn7S2yAyhoU6olKPR2Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zIfQDRDv0+yL9omQjTpLUmqpZA6sxcnuLVt681h/34w=;
 b=mI68eW2BtypZ3/+44YthuozZuWUWT1WpJozN7EaMnoyJ9G5VJeo3WezrGmUx9b12T0W6qT7rjlDCYBYrXUjb3nx9KEv2jb+9U1CKs/vDCTKcBOIBNwePo/2lv8/78vmkJZGqIP76vYxi7WiTcR8JtutKAK3hov7PXYPNWozbUFU=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 PH0PR04MB8293.namprd04.prod.outlook.com (2603:10b6:510:107::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Thu, 22 Aug
 2024 13:33:08 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f%3]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 13:33:08 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ricky WU
	<ricky_wu@realtek.com>
Subject: RE: [PATCH v3 01/10] mmc: sd: SDUC Support Recognition
Thread-Topic: [PATCH v3 01/10] mmc: sd: SDUC Support Recognition
Thread-Index: AQHa7hv5Ydq9RlOAV0W/wH5xYncXY7IzNPcAgAAVdeCAAAfwAIAAAMQg
Date: Thu, 22 Aug 2024 13:33:08 +0000
Message-ID:
 <DM6PR04MB6575DCA0D3DF6C2025AA126EFC8F2@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20240814072934.2559911-1-avri.altman@wdc.com>
 <20240814072934.2559911-2-avri.altman@wdc.com>
 <CAPDyKFqafoeiBSAbU30d0jMUJPHvED3Z7khz6rqpn_NAgYurDw@mail.gmail.com>
 <DM6PR04MB65758AA7B324B1E6F1BD29C7FC8F2@DM6PR04MB6575.namprd04.prod.outlook.com>
 <CAPDyKFpTpzFcntDurKTbd2+Y64HG-Znhtbk+2yNsWMo0i4ShLQ@mail.gmail.com>
In-Reply-To:
 <CAPDyKFpTpzFcntDurKTbd2+Y64HG-Znhtbk+2yNsWMo0i4ShLQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|PH0PR04MB8293:EE_
x-ms-office365-filtering-correlation-id: e0679a15-d7bf-4244-6238-08dcc2aef5f0
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UDU2bDdtMEdMNERPT0I2Z3BySW5WUVFDb2k0KytZM0k1SkxtMmZOQXZONHgv?=
 =?utf-8?B?U3dEaVV4Q3kzZVJPaG5UbCtxSDIxdnJFYTk3elpmdmY1QzlUSklPY3dySXRF?=
 =?utf-8?B?eStDL2N3QzBNd0VCakt5aDREd2paZVdlV3plcjlYWm1CbHB2bEJqaG4zWmFi?=
 =?utf-8?B?NTlqcmF3V2U5eUtuQnNQdnI4R0FRdUhVT2JibFgreFlpZGxHRUxPRHhML2pM?=
 =?utf-8?B?cDdSK2hVWlM4VGhsdXM2ZUtPS005cjVjQ2UrcXRCMG9DZjgvWUlMZTZvUjdk?=
 =?utf-8?B?dXI3WHM3RGZtVlozdStlSXVlWXVMYnN3Vlc2S0VSQTdmdTdlM3NjVkhRYUdP?=
 =?utf-8?B?dDlMaXNrTXZERGw3UjBNREUvTHNFVlBsQkZJMW1odmhObE0rdGJ3c1NlUTZq?=
 =?utf-8?B?ZGFQckM0MHhBb2V1b1I3bVZ3V0l1VVRZMk9LeTdlZk5PZS9OcWVKVG14VlpQ?=
 =?utf-8?B?NkNRd1R6MU4ybUhxZm5kYWFmTUpNR0pqOVdOeW9FUDBIL2xRYi9HT3ZtdTcz?=
 =?utf-8?B?S1FmRXFaNE1iTVczVzNrQWF0ZXFUaWZBRVV1MVFTZFdHbFJaMmlDMmVrdzQ1?=
 =?utf-8?B?Y2x1RnFFTmpteU1UekVXM2JKM1BsVjJVMDVCYzJNNjlKYi9SMHowYy9VeWM2?=
 =?utf-8?B?RkNIcHVvTHpNYStLMjIvQ1NyRHRxM1Y2dHdGWVExck01WTZIVWZNdTRhd01I?=
 =?utf-8?B?cGtTV0NiS1BMVmVGbWZYZ2xJZDFPNkdoVkpyTVJBaFBWdkZtRGhYNzIrbHJX?=
 =?utf-8?B?ZkVWc280cCt3RmF1ay9yZWJhaXlJRlZDMTByOWh6VXBnbGU3RU45UjRlMXVh?=
 =?utf-8?B?dmNJRS92QWM4U2dKUjBqMGRiclB2YlB1VzJiN2tkQjZKWjZHNUxRTUZwU0I5?=
 =?utf-8?B?V0RqRU55cnhVV2kzdmRuWWpMdC9UZ0luY0VjZnhKZFRkY1lLL1YyT1hOMmk3?=
 =?utf-8?B?RTlzaGRoUFhpZE5BZndiN3lGTndLQlJwcHBjL3RaTjdKcnJ1QUxRb1Z1R0sw?=
 =?utf-8?B?ZkQxWmJhenZHYzFRdVpoSTBrcFBzTVRLNHZnNVMzaTNFdHI3b010MkR3OE1Z?=
 =?utf-8?B?MzRwcmNuSisrSDdRaDBOTGx0UlE2TE5KbzBESitNVUtMQ2FFYVJ2dkg0L2ts?=
 =?utf-8?B?VSs5WlpXaE9tWWJ5dnllQkNybS9GTVFYaG9weGwxekZpUlRSNWFBYldZYXZh?=
 =?utf-8?B?ODl0cGNuUkM1SHMvRitwWG1CRk13QXlqVEVIL0duU2I0bkc1NUlEOVp1SFlQ?=
 =?utf-8?B?NWtlK1hhOVRjM3RZWFpVTXRDOHV0ZU4zbnl4bVgvZExjYks1eVBQTVZoL0Yz?=
 =?utf-8?B?Vm1XckFGMzdFRFQvazNSNnFZNFZFRDdKMXh1TXNzRysxK1RyWUp4S25ZdEFI?=
 =?utf-8?B?MEt6Mi9KNmVKa3BHb0pOby9lOElDS0YzZGE0M25UYWpnVjhmN2c4dHV5VENp?=
 =?utf-8?B?bDgwc05hNDVoQ1BoT2JReENlNlJMd21kZURmMXRkZDVVa0RzRDFOU0dDRGVh?=
 =?utf-8?B?eVJybVJmQWVGSHRHWXN4NGx2ODQxZXlRS1g4d0dCa1NrT3VESmNNbXlrWHdJ?=
 =?utf-8?B?NFhwaHJ3T1FOQUZ0TU5iOEtkZS9yWGJLQnlyZDZPdXZ2bFY2cTdSSEtoSk12?=
 =?utf-8?B?U05pVDFoUjlOUkI4aFhUR2Rwd2h6N01WTU0yMFRJZUhIMWkxSXZabU9YUzdT?=
 =?utf-8?B?K3Q5SkFmbldYbStsSktZTjBYT1YrckF0YkhHVmlqWktDQjRWNnpWUnNHNnBh?=
 =?utf-8?B?SEw0WjhUZ282RDU2SWtiT0N5VUJJSWdGVHBMUDE4VHFjY3BlRUxrbHV6T2JP?=
 =?utf-8?B?dC9RUS82WmRteGk2QVZTUUhJbnZHNm9iL1M0RUhleHc3clRoYUd5U1hNVEVJ?=
 =?utf-8?B?WlZUR0VkSkg2aWF0M0Q0NUNyTng1NTExUW5WRUpNT2Rmemc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Y0VBUVNSRStOTURySHFWZzg0eDM3NUtxczlKdFJkbEtQdFIwQ0NBS01jR3hT?=
 =?utf-8?B?SFV4ang1b3FFaEVtSVRuWHJSUVBCcVZPSDYxZkJ3MUdwZUhscHZKdDZTcVhQ?=
 =?utf-8?B?dmU4L0JERGxCSmtyTktZak1kODdoV1VBNXRMeXRad2ZUcFk5QWd2T3FtZ2Z5?=
 =?utf-8?B?UDRrbmdXODZYTkZ6TkVjS2FraHNjRmhidlRXVlhNNUgxN2RCbVhidnlBWHZM?=
 =?utf-8?B?M0tQRjU0dFpFREh2Wk8zemY1ZUM4S2RGckl0eGZZd1JTNUtQRzVZbFQ3eXZl?=
 =?utf-8?B?bE03TVJqbmgwaU9OOWhOaFJ4Sng5eFJFenFOM2F4aFNBNXdNL0VPRHl6OHRT?=
 =?utf-8?B?UU1FL2VyQ0JoZnFYSGJ4bEUvdGFVQThUWXR2Qi9pQUladnlCMWlGNDZ0Mytv?=
 =?utf-8?B?WVpIemdrZVRDOHFleEZHQjBJYXhlMGx6eG1xVGVudW1tcllDVHIyQWh1cXJ4?=
 =?utf-8?B?cTZUSUgvOWlYejFvZEkzenFUdWhvUklaS1VVNFNvSmlySndKQzdjTzBIb1JD?=
 =?utf-8?B?VGFXUDA5amdpY0xJdk9XTmJFcHYrd0Q3TDhpcWlvSnJ6UnJxeHN0OTJMRkdw?=
 =?utf-8?B?aktWSEF6bGk4a3JiZjVmVkZkejJCZ0o0c0JmcVl1elVjODRSOGRjOG9yQ0Ev?=
 =?utf-8?B?M3BnVElGM0xTd1k4YUpmdEtsTWY2dm9iL0FhWVZkTGxaYzhxV0RTZDFXZnhG?=
 =?utf-8?B?V0ZoTHY3L1NJaERSVUFBOVlFQlQ4aldnZGxaOE5rY1N2K3J5bVVXT1lLUHh2?=
 =?utf-8?B?V0xXekk2WExIZlRsRytVUkVUZnQ4eVN1SmEzS0podW45RmlmNE1sUTJ0dDB5?=
 =?utf-8?B?b2RIWXVoZGEwVWlFVW1YTE5KcG54WGd1ZzVIK0FoT2IyOU5JVFQzb095OEwr?=
 =?utf-8?B?REovQXVQcGJieVFPL2l1RGNJOWlEUmdYcGtjeGM3Q2M2R3lmS0tKVHFiOFFC?=
 =?utf-8?B?eVJPNmducnlESWlhZzR3V3pwRHBMUFhyMm9jc2toSXNkbUI1MnRQMktBVHpI?=
 =?utf-8?B?LzNMNzFKVDNwcUFhdlJPWERHOHpBa0NseVhmVWFlRStyc3pxK1AzNitkODV6?=
 =?utf-8?B?aklBckE2Vk5laWR5MHYybHhFRnR2d1lwanNxNkNCL1lFNVpiUnZFWmFaZTUx?=
 =?utf-8?B?SmpWeUh0QWhiTzQxcjNMS0VrdDcvYlpUc1ZLMWdHWWRYT3FqYXVPZjFSMnZ5?=
 =?utf-8?B?TXVVc0hIMmhsaXFhSFVaT0tLWXdBbjNVV09SYm1pczZuL1VaN2tRQ05ZYkQx?=
 =?utf-8?B?TTl1WnVUQk1TSkpDaGhvZlNrZkxFaU1HSlcxcEtLTHM2ZFhoVHBzaTNiVmNR?=
 =?utf-8?B?aWFhU3YxejlCWjJsT3dRbmJlK3lFY3dOK0ZlTVV0YWJOQ0puTGs3VWpCbHNt?=
 =?utf-8?B?bjhuaFhoQkdOVk1KaWN5YWN1WG1HWjNqT0dYSE9tYWZETFBGeEZURTJYT04x?=
 =?utf-8?B?RjVveFg3eTdDMmJ4U0RHQ1AwRGlBMEtieSs4R0c1UkdQT2EzR2hJd0dHRXhT?=
 =?utf-8?B?RW5NVEwzUnJycGtQWXYrQTN5VE5CQTdLWUpEaU5vSkRLVEdnZG12b1hmQVJ1?=
 =?utf-8?B?VHNBWVBKTG1rMnhDZldlU0dEazUvWXB0eXphSDgraGt1bU9WNVNaeitFWlhO?=
 =?utf-8?B?M0pCWE9IbkRrMU85UGNlbUwwMzNRUVpzTXBYWVpXNmhKMEdIVTZqNFJOTDN3?=
 =?utf-8?B?ajFEOHBWNWVHajNpdXJtbkJWcE1seXVBSERiT0dnUmhCSEtaS2VCMHNXbFpz?=
 =?utf-8?B?cVptWWhjSVpiUTh1aWhhMkxkb0p5WVMwZ09IcFJjUTlwOWRwQVhuNkE3Nml5?=
 =?utf-8?B?MFg4T1Jad1hFUVE2QmNPdndia0loVjBCa2laN3NSWEd0UnlINVRIK0JzUmN3?=
 =?utf-8?B?WHkrQTg5WlU4M0lpQitZRGtzMEt6Tnlrc1FQNHZhREI1bzZpNEg3STErbEQv?=
 =?utf-8?B?ZTJaeTdqRjBpZjZGY3RPTm1RVDlVM01GM1hyVWJqY0lQVlBGZUt0R2h2dHo2?=
 =?utf-8?B?OTZBdFpncFZPaDNSZHFrZ0djaGFBamdxYXlYVDM3bVEyc2IrQkhtTWNDL2wz?=
 =?utf-8?B?UXRrQ1M4c3F0emNqRzVvQTNScXFjOTZQNGJheERrU1RQOHZ6VlZuc3kxVlNp?=
 =?utf-8?B?cjZ0Uk5Ld0t1SWRCM3Y4RGNBVDVmNzlwTjJIcHp1cUtsNFlWV3F0YnNUM3JQ?=
 =?utf-8?Q?XbsP8ZKv2WVo7RGyhs7YFLnJolVJL+CVpr5+jjWZkNJK?=
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
	feGWG9ApVbYh79HYWlvU2WsyNeG4Hyf9mu9ZBzJRRE3PlQh2b4urDRC3rNoQQAOVgsBwPlnVG92ILWeaPkVNvfxz37K2gUKpnUOsaBZVD/9w8fn2dL8k5IOtpMSvfMxSvLGeKOlhoeM4acDGaWT0kvIfoI3uP9V7zMg9/jCNvBwj6mfBvAWCXsmzwOlBjnYdCsqIV1aWBn5hzewSZnXUBr4N0ur1UIQws8m8TD8YkVpWK6TLqHDsAdit2gIgxAZtvxdcwJd23pZmkHHCkpdk5kC+29ZZKNTfK0NF6KTOv3gLSBGvnBq7ZMYH7IEnvP/+0smV946bCaew2Rmzs0ltO/aHn0EykCHHhD/WOG7LCLtJtqhE2lVc0d2BcFB38jlsco1ExBG0wQvFZwqqYgvnqSSEg1r+SQ16aGGpZmPxGUDYDwWtlHMJNw/NxoclA3Cu48QD8Ofae861lgpVc997U85YOfbRoUJrfwHZxtw4py/IlfkZhb7xbkN/diV/HSdePgd9nVetCdmkEX6Ck1O1gSp9OHbZlWVsE0/2finpe1jykwQCYl2SCaegWLg6J3O9+cpYQ6DmfH2EMV2qYzi7J6G2PI956xLVsIlvbqluWgPZtaorabo8+v4knedYw2YW
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0679a15-d7bf-4244-6238-08dcc2aef5f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2024 13:33:08.5784
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UqKDfAIuDvk6ndQfVX0Fub8BSM5MOAu2iwAUzjTLO57pYCMid0kckumcb8YFrx78xQ3BfpOwtCFkcO4VP4i3eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB8293

PiBPbiBUaHUsIDIyIEF1ZyAyMDI0IGF0IDE1OjE3LCBBdnJpIEFsdG1hbiA8QXZyaS5BbHRtYW5A
d2RjLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiA+IE9uIFdlZCwgMTQgQXVnIDIwMjQgYXQgMDk6MzEs
IEF2cmkgQWx0bWFuIDxhdnJpLmFsdG1hbkB3ZGMuY29tPg0KPiB3cm90ZToNCj4gPiA+ID4NCj4g
PiA+ID4gQUNNRDQxIHdhcyBleHRlbmRlZCB0byBzdXBwb3J0IHRoZSBob3N0LWNhcmQgaGFuZHNo
YWtlIGR1cmluZw0KPiA+ID4gPiBpbml0aWFsaXphdGlvbi4gIFRoZSBjYXJkIGV4cGVjdHMgdGhh
dCB0aGUgSENTICYgSE8yVCBiaXRzIHRvIGJlDQo+ID4gPiA+IHNldCBpbiB0aGUgY29tbWFuZCBh
cmd1bWVudCwgYW5kIHNldHMgdGhlIGFwcGxpY2FibGUgYml0cyBpbiB0aGUNCj4gPiA+ID4gUjMg
cmV0dXJuZWQgcmVzcG9uc2UuICBPbiB0aGUgY29udHJhcnksIGlmIGEgU0RVQyBjYXJkIGlzIGlu
c2VydGVkDQo+ID4gPiA+IHRvIGEgbm9uLXN1cHBvcnRpbmcgaG9zdCwgaXQgd2lsbCBuZXZlciBy
ZXNwb25kIHRvIHRoaXMgQUNNRDQxDQo+ID4gPiA+IHVudGlsIGV2ZW50dWFsbHksIHRoZSBob3N0
IHdpbGwgdGltZWQgb3V0IGFuZCBnaXZlIHVwLg0KPiA+ID4gPg0KPiA+ID4gPiBUZXN0ZWQtYnk6
IFJpY2t5IFdVIDxyaWNreV93dUByZWFsdGVrLmNvbT4NCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTog
QXZyaSBBbHRtYW4gPGF2cmkuYWx0bWFuQHdkYy5jb20+DQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiAg
ZHJpdmVycy9tbWMvY29yZS9zZF9vcHMuYyB8IDE5ICsrKysrKysrKysrKysrKy0tLS0NCj4gPiA+
ID4gaW5jbHVkZS9saW51eC9tbWMvaG9zdC5oICB8ICA2ICsrKysrKw0KPiA+ID4gPiAgaW5jbHVk
ZS9saW51eC9tbWMvc2QuaCAgICB8ICAxICsNCj4gPiA+ID4gIDMgZmlsZXMgY2hhbmdlZCwgMjIg
aW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4gPiA+ID4NCj4gPiA+ID4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvbW1jL2NvcmUvc2Rfb3BzLmMgYi9kcml2ZXJzL21tYy9jb3JlL3NkX29wcy5j
DQo+ID4gPiA+IGluZGV4IDhiOWIzNDI4NmVmMy4uN2Y2OTYzZGFjODczIDEwMDY0NA0KPiA+ID4g
PiAtLS0gYS9kcml2ZXJzL21tYy9jb3JlL3NkX29wcy5jDQo+ID4gPiA+ICsrKyBiL2RyaXZlcnMv
bW1jL2NvcmUvc2Rfb3BzLmMNCj4gPiA+ID4gQEAgLTE2OCwxMiArMTY4LDE2IEBAIGludCBtbWNf
c2VuZF9hcHBfb3BfY29uZChzdHJ1Y3QNCj4gbW1jX2hvc3QNCj4gPiA+ICpob3N0LCB1MzIgb2Ny
LCB1MzIgKnJvY3IpDQo+ID4gPiA+ICAgICAgICAgICAgICAgICAuY21kID0gJmNtZA0KPiA+ID4g
PiAgICAgICAgIH07DQo+ID4gPiA+ICAgICAgICAgaW50IGVycjsNCj4gPiA+ID4gKyAgICAgICB1
MzIgc2R1Y19hcmcgPSBTRF9PQ1JfQ0NTIHwgU0RfT0NSXzJUOw0KPiA+ID4gPg0KPiA+ID4gPiAg
ICAgICAgIGNtZC5vcGNvZGUgPSBTRF9BUFBfT1BfQ09ORDsNCj4gPiA+ID4gKyAgICAgICBjbWQu
YXJnID0gb2NyOw0KPiA+ID4gPiArDQo+ID4gPiA+ICAgICAgICAgaWYgKG1tY19ob3N0X2lzX3Nw
aShob3N0KSkNCj4gPiA+ID4gLSAgICAgICAgICAgICAgIGNtZC5hcmcgPSBvY3IgJiAoMSA8PCAz
MCk7IC8qIFNQSSBvbmx5IGRlZmluZXMgb25lIGJpdCAqLw0KPiA+ID4gPiArICAgICAgICAgICAg
ICAgY21kLmFyZyAmPSAoMSA8PCAzMCk7IC8qIFNQSSBvbmx5IGRlZmluZXMgb25lIGJpdA0KPiA+
ID4gPiArICovDQo+ID4gPiA+ICAgICAgICAgZWxzZQ0KPiA+ID4gPiAtICAgICAgICAgICAgICAg
Y21kLmFyZyA9IG9jcjsNCj4gPiA+ID4gKyAgICAgICAgICAgICAgIGNtZC5hcmcgfD0gc2R1Y19h
cmc7DQo+ID4gPiA+ICsNCj4gPiA+DQo+ID4gPiBUaGlzIGNvZGUgZG9lc24ndCBiZWxvbmcgaW4g
bW1jX3NlbmRfYXBwX29wX2NvbmQoKSwgYnV0IHJhdGhlciBpbg0KPiA+ID4gbW1jX3NkX2dldF9j
aWQoKSwgd2hpY2ggaXMgd2hlcmUgd2UgYWRkIG9uZSB2YXJpb3VzIE9DUiBiaXRzIGJlZm9yZQ0K
PiA+ID4gd2UgY2FsbA0KPiA+ID4gbW1jX3NlbmRfYXBwX29wX2NvbmQoKSB3aXRoIGl0Lg0KPiA+
ID4NCj4gPiA+IEZvciBleGFtcGxlLCBpZiB0aGUgcmVzcG9uc2Ugb2YgdGhlIFNEX1NFTkRfSUZf
Q09ORCBjb21tYW5kcw0KPiA+ID4gaW5kaWNhdGVzIGFuIFNEIDIuMCBjb21wbGlhbnQgY2FyZCwg
d2UgdGFnIG9uIHRoZSBTRF9PQ1JfQ0NTIGJpdC4gSXQNCj4gPiA+IGxvb2tzIGxpa2UgdGhhdCBu
ZWVkcyB0byBiZSBleHRlbmRlZCB0byB0aGUgU0RfT0NSXzJUIGJpdCB0b28uDQo+ID4gT0suDQo+
ID4NCj4gPiA+DQo+ID4gPiA+ICAgICAgICAgY21kLmZsYWdzID0gTU1DX1JTUF9TUElfUjEgfCBN
TUNfUlNQX1IzIHwgTU1DX0NNRF9CQ1I7DQo+ID4gPiA+DQo+ID4gPiA+ICAgICAgICAgZXJyID0g
X19tbWNfcG9sbF9mb3JfYnVzeShob3N0LCBTRF9BUFBfT1BfQ09ORF9QRVJJT0RfVVMsDQo+ID4g
PiA+IEBADQo+ID4gPiA+IC0xODIsOCArMTg2LDE1IEBAIGludCBtbWNfc2VuZF9hcHBfb3BfY29u
ZChzdHJ1Y3QgbW1jX2hvc3QNCj4gKmhvc3QsDQo+ID4gPiB1MzIgb2NyLCB1MzIgKnJvY3IpDQo+
ID4gPiA+ICAgICAgICAgaWYgKGVycikNCj4gPiA+ID4gICAgICAgICAgICAgICAgIHJldHVybiBl
cnI7DQo+ID4gPiA+DQo+ID4gPiA+IC0gICAgICAgaWYgKHJvY3IgJiYgIW1tY19ob3N0X2lzX3Nw
aShob3N0KSkNCj4gPiA+ID4gLSAgICAgICAgICAgICAgICpyb2NyID0gY21kLnJlc3BbMF07DQo+
ID4gPiA+ICsgICAgICAgaWYgKCFtbWNfaG9zdF9pc19zcGkoaG9zdCkpIHsNCj4gPiA+ID4gKyAg
ICAgICAgICAgICAgIGlmIChyb2NyKQ0KPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAq
cm9jciA9IGNtZC5yZXNwWzBdOw0KPiA+ID4gPiArDQo+ID4gPiA+ICsgICAgICAgICAgICAgICBp
ZiAoKGNtZC5yZXNwWzBdICYgc2R1Y19hcmcpID09IHNkdWNfYXJnKQ0KPiA+ID4gPiArICAgICAg
ICAgICAgICAgICAgICAgICBob3N0LT5jYXBzMiB8PSBNTUNfQ0FQMl9TRF9TRFVDOw0KPiA+ID4g
PiArICAgICAgICAgICAgICAgZWxzZQ0KPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICBo
b3N0LT5jYXBzMiAmPSB+TU1DX0NBUDJfU0RfU0RVQzsNCj4gPiA+DQo+ID4gPiBQbGVhc2UgZG9u
J3QgYWJ1c2UgdGhlIGhvc3QtPmNhcHMyIGZvciB0aGlzIHB1cnBvc2UuDQo+ID4gPg0KPiA+ID4g
SW5zdGVhZCBsZXQncyBrZWVwIHVzaW5nIHRoZSBjYXJkLT5zdGF0ZSB0byBrZWVwIHRyYWNrIG9m
IHdoYXQgdHlwZQ0KPiA+ID4gb2YgY2FyZCB0aGlzIGlzLiBZb3UgbWF5IGhhdmUgYSBsb29rIGF0
IGhvdyB0aGUgTU1DX0NBUkRfU0RYQyBiaXQgaXMNCj4gPiA+IGJlaW5nIHVzZWQgYW5kIGp1c3Qg
Zm9sbG93IHRoYXQgYmVoYXZpb3VyIGZvciB0aGUgU0RVQyBjYXJkcyB0b28uDQo+ID4gPg0KPiA+
ID4gTW9yZW92ZXIsIHJhdGhlciB0aGFuIGFzc2lnbmluZyBjYXJkLT5zdGF0ZSBhdCB0aGlzIHBv
aW50LCBsZXQncyBkbw0KPiA+ID4gdGhhdCBmcm9tDQo+ID4gPiBtbWNfZGVjb2RlX2NzZCgpIGlu
c3RlYWQsIHdoZW4gd2UgcmVhbGl6ZSB0aGF0IHRoZSBjYXJkIHN1cHBvcnRzIHRoZQ0KPiA+ID4g
bmV3IENTRCBzdHJ1Y3R1cmUgdmVyc2lvbiAzLg0KPiA+IEp1c3QgdG8gcmVjYXAgLSBzbyB3ZSBh
cmUgYWxsIG9uIHRoZSBzYW1lIHBhZ2U6DQo+ID4gUmlja3kgc3VnZ2VzdGVkIHRoaXMgaW4gdjEg
YXMgd2VsbC4NCj4gPiBBbmQgd2UgaGFkIGEgZGlzY3Vzc2lvbiBpZiB3ZSBzaG91bGQgdXNlIHRo
ZSBzdGF0ZSBmaWVsZCB0byBpbmRpY2F0ZSB0aGUgY2FyZA0KPiB0eXBlLg0KPiA+IEhvd2V2ZXIs
IFJpY2t5IGhhZCBzb21lIGdvb2QgcG9pbnQgd2h5IGl0IHNob3VsZCBiZSBoZXJlOg0KPiA+ICIu
Li4NCj4gPiBJIHRoaW5rIGhvc3QtPmNhcHMyIGlzIGZvciBob3N0IHRvIGNsYWltIGNhcHMsIGhl
cmUgY2FuIGp1c3QgY2FsbA0KPiBtbWNfY2FyZF9zZXRfdWx0X2NhcGFjaXR5Pw0KPiA+IERvbid0
IG5lZWQgdG8gd2FpdCBjc2QsIGJlY2F1c2UgU0RYQyBhbmQgU0RIQyBuZWVkIHRvIGlkZW50aWZ5
IGJ5DQo+ID4gY2FwYWNpdHksIGJ1dCBTRFVDIGNhbiBiZSBpZGVudGlmaWVkIGhlcmUgQW5kIGFs
bCB5b3VyDQo+ID4gbW1jX2NhcmRfaXNfc2R1YygpIEkgdGhpbmsgY2hhbmdlIHRvIG1tY19jYXJk
X3VsdF9jYXBhY2l0eSgpIHRvIGtub3cgdGhlDQo+IGNhcmQgdHlwZSAuLi4iDQo+ID4gVGhpcyBp
cyBiZWNhdXNlIGFjY29yZGluZyB0byB0aGUgc3BlYywgU0RVQyBpZGVudGlmaWNhdGlvbiBpcyBu
b3QgbWFuZGF0ZWQgYnkNCj4gaXRzIGNhcGFjaXR5LCBidXQgcmF0aGVyIGJ5IHRoZSByb2NyLg0K
PiANCj4gSW4gcHJpbmNpcGxlIHlvdSBhcmUgcmlnaHQuIFRoZSByb2NyIGluZGljYXRlcyB3aGV0
aGVyIGl0J3MgYW4gU0RTQywgU0RIQywgU0RYQw0KPiBvciBhbiBTRFVDIGNhcmQuDQo+IA0KPiBP
biB0aGUgb3RoZXIgaGFuZCB3ZSBhcmUgY2hlY2tpbmcgdGhlIENTRCBzdHJ1Y3R1cmUgdmVyc2lv
biBmb3INCj4gU0RTQy9TREhDL1NEWEMgLSBzbyBJIHdvdWxkIHJhdGhlciBiZSBjb25zaXN0ZW50
IHdpdGggdGhhdCB3YXksIGFzIGl0IHNlZW1zDQo+IHRvIHdvcmsgZmluZS4NClllcy4NCg0KPiAN
Cj4gQWNjb3JkaW5nIHRvIHRoZSBzcGVjIHRoZSBDU0Qgc3RydWN0dXJlIHZlcnNpb24gMyBpcyBk
ZWRpY2F0ZWQgZm9yIFNEVUMgY2FyZHMsDQo+IHJpZ2h0Pw0KWWVzLg0KDQpUaGFua3MsDQpBdnJp
DQoNCj4gDQo+IFsuLi5dDQo+IA0KPiBLaW5kIHJlZ2FyZHMNCj4gVWZmZQ0K
