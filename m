Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013047.outbound.protection.outlook.com [52.101.83.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB9232F747
	for <linux-mmc@vger.kernel.org>; Tue,  2 Sep 2025 06:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756794385; cv=fail; b=Xe43ug1cwmKdJkrV5scWDZr+lugXvf9SAYQDzq0WVBU8YZ7QbPIipR1fWveB48ALE+tdHsKmL7QtcGSynr195LIbZM5vs20ljShZjgYSHCptPD7pBp3z15LHu7MHI9zM4xl+JOV6ZYsReUsSQGCHEgcGNa2whHSJ8q82M5xFsIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756794385; c=relaxed/simple;
	bh=kYx8yMvj1c0nDRAv+yiSzPwef1ZeIx/4UcSFUg0pOW8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LKyzuKwK9yt4/afXlmu1tpJkBJBfV5Zib5ouBbNie+B3/rFhAni9unAZTYquBvcXvu1/8Qb5yi5vuP6/AseZj+pbhu91kaYo8N+GkUXbvvna9CQEFLtzMouQs2Zd/KPpzpZ0CPeLnfMkD9WzXdqb7LBjMylMBhj0G2RxWCTDmsU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=yrXnrxsD; arc=fail smtp.client-ip=52.101.83.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="yrXnrxsD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g8fICWP8a9SOpvFuzWFAxe+EIR6yxhFwz+wmN2XETxITBuqtZU5TaCEbr1gdveTXdPNNhWYBg4G/au1H3K5aXwj7rd2k/d6OWL829Zc2D5ttMc+7GPIo0bPOquYW8NPSHYQbTKLU/BTino3xB5V+O+2XKjwPt8s8rsalBzTCI/MpNaMqh/zq8ePTrGsIpr8JNFdNX6ZpYTa9gjCkS5FGTj1cFPaaaaVzFdADog6O4bKoIFHHGt4EbyEw8D7xSVJMcDnj4jGPXBDf7fyiLrUaCqojETIaG5HKko1PGE0TZGrGEwFNutlvFNgNvQBKwJlqM13EOqwj/HVr6TemzwSMng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TkYZTwnAkbsOOeXW6FmDIw1jGX+oq8Dijv6AZ5spb2I=;
 b=GacCS1XBXkEu/z0rtV+B+7SoXkUzTirtbmADuyQfBFIoCgeScho8NSBA0fnp7pscUTIhpf+53pT/7DMxYGlzrUtqTchmjnZZs5NPhR7QqGjLC/47YgnyQswxzbejsrJPUKKXgZ2Ph9s4fb7ara1OEDTybPS6hd8hdVlMBVVX4nZ8/d/dRGSesKeao2F0hFHKnwk2QG4zTCJ1+3TOLHTxtaeH8FZqnbSsK6vV0E4uEVsz77uOizyBZn3R8hx+sq84ZZOmYnX6jY3SFZcG2q74Vg3z4Sg9kwlxnWVXptgOQgQM9djPYD4l7f/Zs30FqlJRSJHYSqlWaLcu3/+2CfEggA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TkYZTwnAkbsOOeXW6FmDIw1jGX+oq8Dijv6AZ5spb2I=;
 b=yrXnrxsDgTGZ4eLAG22wKjOZt8Nennh3O4RcnvZ7e6w+VxHL42pRaBm233/PBlECLuhAdqbVoKBaA//HkHFq2EoezOpm0I7YEULc61qowwPueSLI2fVUsFGeBPeI8PbmGXpvHES1MIBAH/4EpDzoEbDN1AKDuu0kL+VgpOTZdwAeN4OAM2uabtH2oNX4z31il17KUp7G43f9bEVP209I12eaKmw9Q8HlDO+EUOO21WwyOxjnpaqEQk/ihs1GRbmbb69iKOPhmgD/r/NMYlq8dOw+76+C1OKAnWRGgvgXqC82sscsSSnmaR7UgQLGL2kv8A7hDZKTplzUp0o0ZZXKYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM9PR10MB4023.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1fe::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Tue, 2 Sep
 2025 06:26:19 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.9073.021; Tue, 2 Sep 2025
 06:26:19 +0000
Message-ID: <e6dab400-c23d-4862-a945-c0509b29a172@siemens.com>
Date: Tue, 2 Sep 2025 08:26:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mmc-utils: Correctly handle write counter overflow
 status
To: Avri Altman <Avri.Altman@sandisk.com>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
References: <167acbaa-c61f-4d75-b2b6-9acee22ddee9@siemens.com>
 <PH7PR16MB61961D92DC4EAF96C8378802E507A@PH7PR16MB6196.namprd16.prod.outlook.com>
 <2ec0d3e7-3637-46be-94d9-0d7af9137e12@siemens.com>
 <PH7PR16MB6196528FF366384AB1F7B46BE506A@PH7PR16MB6196.namprd16.prod.outlook.com>
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <PH7PR16MB6196528FF366384AB1F7B46BE506A@PH7PR16MB6196.namprd16.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0133.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM9PR10MB4023:EE_
X-MS-Office365-Filtering-Correlation-Id: 23cf8d91-8188-4050-e74a-08dde9e9a0ad
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZStCeVdDbStDNDVQOFRsMTJpNHVtVlpFaFd2c00zUGxOc0JFTnArRWRra25K?=
 =?utf-8?B?dWJac0FhVEtkOENHZGo0bzFiTHJpNGVVcG5rR1J5cjQwMnNTRWZjV2xWcUF1?=
 =?utf-8?B?NW1RQkhpcVFIYmhtTU5IUG9pWkVjNTR1bktuVXZqbFlUdCtjNmt6RE1pNU5X?=
 =?utf-8?B?Snl4blVaWUVDZEFwVzd0QlFpQWVSbzB1Rlh0TEVZNElid1ZWcEY2cmM0SGov?=
 =?utf-8?B?UHYvLytrQzlzdGRHUFVaeVRWeXUxcVpDdVFTSEdrbzdDYkhURkRIRmViTy9L?=
 =?utf-8?B?M2ZUK2p5MVVoRW5YWklQb1B2Mmk3RktuQjE4TlFPdHZ3WEdWa2hCUjBrenRn?=
 =?utf-8?B?a0MvRlJZK0dxRVAvdEVvV2o3U1FLanMrM3dLdW1aemxla2FiZFdsK0VFcUhT?=
 =?utf-8?B?bitJczZRSmd6YlFYc01TTjgxRmhuQUdqOGVUNmdEMjZXRWxvdEtZNnAvZDgw?=
 =?utf-8?B?S0VWaHI4cXJrTHc3Q24vYktiaXorMks0MmdvTUplY3NFNWxyZ0JCUVZEU2hi?=
 =?utf-8?B?N3dHZ1BsWHBTVUs3a3hEczJCei8vUFArZFhlNy9SZ2ZKTW9sQkJaNnFSV1li?=
 =?utf-8?B?ZkZBREZ2MFNIM0FFOXhjdWd2ejF5YkhmTjIwbTlEcmF1VjhOVkZhNGNyTnNB?=
 =?utf-8?B?NG11TUJMOWxoL05aWDEwQWhtdVVPemViUFZIMXhGSXN1Rkp2ZmZldXc2aWdv?=
 =?utf-8?B?VTlZTmFWckNLMzhNbXgzQyt1QzIyejZYT1pzZ1BpcTBLL09ZcXN0TzFXeHpS?=
 =?utf-8?B?QlByT3FlMVpkUDRrV1dnR0s1enRNbXNhMW9wZE9BNkEvZk9Ebnk1aTNuU1Vi?=
 =?utf-8?B?VmZCZ0FVckIyWEJPZVdnT0xLa0xqd3lxbnZidkJCd0NKZVNZU1FBNlRHdjFo?=
 =?utf-8?B?UDQxZ3FOdHNYTlcrZXFJVzR2eUZGb2x0dGdmbk5VajN6cjA4ay9VUDdnRUQ3?=
 =?utf-8?B?SXAyNERCZEFyZTd3c25xa0pMRnVDREhibnpCaUZuOVI1cGpncWRLcDVJSytO?=
 =?utf-8?B?ak91aldBQ29TOW50c2luMDdpWlZOL1R2bHp5RXF2MmcyNGJiRGR4UHRnMUtX?=
 =?utf-8?B?T25melVrTkZ5WndvbXh6eGFHNFNHczNUQVI1QWxCUFNJZDJVOEozZGJBaExS?=
 =?utf-8?B?SEcrQkdIS1Ntb01abGVsd1ZnT2RYUy9JTnZRcFo1Qk44T2xzQldSWmxXRHVo?=
 =?utf-8?B?a2U5UXlIUlJXS01VRWlTaFdlOU52K0JPTDZnZnF2MnNRWVJqcUhkNW8zeWl6?=
 =?utf-8?B?eUNndUdDaEJ3eCtoNmdyNi9tNDB5TzhpQ3NaRFgxbGpYd3dyM0orT2FjVUZ6?=
 =?utf-8?B?SjhOK2ZVTWRkam16ekRjYlkyS09LTVR2Y0tVdUU4TEtMdzU1UWhieHA1Z3Rx?=
 =?utf-8?B?SzErVmlWdVhnVFMvNEt3YTh6dDFNRWRSdHYvb2dtME9ldW9ZQXZzU09xYVp2?=
 =?utf-8?B?dXNFWmV3SjI2b2hhdmtzVTlvcXluNEdta3libFZKMnFtbGVnVWpDakY1ejZ3?=
 =?utf-8?B?QUcxU2gxVmFIQlVrcGVDLzF1WGdHVUpJTGpMaFNiU1JETXJwR2ZMZ25GcCtp?=
 =?utf-8?B?eko5VkY0LzFYeHdxdG4yR2ZDLzdsYjVXeTE4TVMwazE4aStvTjVCTEFDeGR3?=
 =?utf-8?B?OEtsVUw3aGZHSlpQaHdVNXhRQW9QRUh0c0xqSzBBSVIvblhZYUxnV2VTVUtk?=
 =?utf-8?B?U0dnbWM3VDNPYVliTytmdzlkSjRYUHpIaThKMS84RDZZc0NkcmdxTmMwZWI1?=
 =?utf-8?B?dC80U0pLZEs0VkZVa2lGL283OUMzQmpVeXJPR1B5MkZFekU5TlZmZ0dhcXBs?=
 =?utf-8?B?S2FGbVcvMnd0b2loS014bTNCR0phR3hmN1k0SEd4NFZhVnlWT0EyblpNWGZG?=
 =?utf-8?B?UllobllSYkQ3dmRxVXNETjZQTGNhRVlaUWI3VG0xMmJXVmtDbkQ0TG9raW9s?=
 =?utf-8?Q?W7N8ahXRyZw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RjdoWTJkOVpDUG1jZWZ1MXZSRlBTNEpFVnduK0dsN3EwMVNyTytKclZtNmVS?=
 =?utf-8?B?cE4rMmVLdytOQTZCZVdneXRmSkFNdit6K2JGWWRmTjM4RXZrczRtSXZ6QVk2?=
 =?utf-8?B?SnByTldRSnBWR0tORlpJVElYWG1NNkJzV0laK3VYS1lFaFA4Z0p6dmdFbVVY?=
 =?utf-8?B?SmtobHh1U2tmSkRQTCtWMEo0ZmpSM0JKWkZ5bWlJN0JTeVk5SUltYzdjSVZC?=
 =?utf-8?B?TWNVajBsbk82aHdkR05jdVljVTlVdGI4T2xSZWtMd1pzNDV2d1VqSTV3Ris0?=
 =?utf-8?B?WFk3ZlRUR285WTMxTUJkY0pTTExqK1FSc2V3VE9JbXd4NGlLMTYyUFlnd09C?=
 =?utf-8?B?MXRCclh6cVBBQjdTem1QcHM3czFGS1VaVm5vSjI4U2xsWVBuQ3NxSEY1ajhY?=
 =?utf-8?B?U3l5aGVlbVVqMWsvUUxSTG9aaXNkMjBlUDZnZk9CbzYwWU9KeTRodjBKZkQy?=
 =?utf-8?B?NFRYREF6TVJTR2FHMXN2aFExNCszYURlTHB3R0VHbEJGeWdLRU9hTXB5b3N1?=
 =?utf-8?B?TEFQN3p4QWR5VExTc3RQMUZxeXpPSUszSlBxNHduTmpPeU96dDB0cVQrNGZn?=
 =?utf-8?B?N3pXTlVSUnN5T3pld1JSNVlvN2NURTNhZnZXSWUxdU5BUlIrYTRFblBDVWds?=
 =?utf-8?B?bU0ra0JIek1oWVFtZFkwdUI3bndpL0hpTjFld1FTdjNvbU9VSS9DN0xGcU8x?=
 =?utf-8?B?bGJZYkEySHZXM0hINGZiS01GVkZ3emx6VHFYVElWS2ZTck5jNENlcUhjeTQx?=
 =?utf-8?B?bi9CMGZRb3ZQbWxNWlRqcWllR2JZVTRydGF3QUs2aCtWVlJ4eG1yazdJUVJQ?=
 =?utf-8?B?bzArYjQ5akUwVUVMWGdkNTFMY2IxN1NZQVMrRWZOUUptZlNFMGpudzFPZEtm?=
 =?utf-8?B?Wm1FT0pBbytDZ2xuVE1zUFVQRFZSZU9CeGF3TG9kNWU1SlZoWXdiSElrVkRs?=
 =?utf-8?B?d0hJLzVXY1V3aTdERVl0eFZhYkgrdWdOZitHSmprU2Q1VTRPQ0FPN1N6aFJm?=
 =?utf-8?B?QVBCQjlIV2s3NHp3NmVGR29ndkE5NHVpYlB6TGlleTRQbG5PMVJ1bEx3OE53?=
 =?utf-8?B?THRpRGdERitqVlNsMEYrVWROaFRCdDFJL0ZXR28wNnN5SFQ5NEUyNWl3d2pT?=
 =?utf-8?B?VjRDQjZ2M0xSZjBsMThkNVJMMmJwV1UyeDVucUpORDR2VGd3czRQU1QwaHEz?=
 =?utf-8?B?bGRTTi81N01jUnJTWmgrckM5UUp2YXJ6UG01YzlxeUptM29SVUxKS0ZoRjI4?=
 =?utf-8?B?T2tSMUlNdXVQVy9lRHJUeW5heTRlQmROVVBwcnVFbkg3NzBSNDI3eXNacWk3?=
 =?utf-8?B?WmlpaWhVRnE4RnlxOFllZDBMVmlJUkZqR05ITy9JK1ptcFZGWm5vZkdlUEp1?=
 =?utf-8?B?SXJPZE0rU2ZIa1Y2OFloOS9BejViU0J5b1JaVFh6ZWdJUTMvVEZoYWJwRHpO?=
 =?utf-8?B?S2tJc0EwaC9jWEJycFNQUXNBWUp1TDFSeTV1YWR5cllUYXRhUmhPbmVCa08v?=
 =?utf-8?B?ZVVtQm5JWjZHQkZCaXVmY0EwMldJdHA0bzBBTzV3L3JRa2l0RXdzditYSXor?=
 =?utf-8?B?aFllQlR2d2V6Ylh2WWFDbkJaNVpwd09QK0hxdE9vQzhHRGc4NG0wNWloMzRJ?=
 =?utf-8?B?dzJiQ1VtQUVMQlFHWkFMOXYrL0NEdk5VQTF5Wllwck5vQlZKc1N6ZzlXU3FP?=
 =?utf-8?B?QU5kdWkyYnhtRW03Y0R6Q3JHaWFWWXVJYlVtV2VRVUNnMXlNN201VUpGMG5r?=
 =?utf-8?B?NWp1TUNOV29ieDdDaTl5OVJ6ZWVLZmIrNFZtZDJxYlVRbUZuTzNIN2tHaEk5?=
 =?utf-8?B?M0pGTFNhN3ZXZ2RGc2JzZDFFU01jL3lMdG90VkZFM2tOWmxZeGZTMzlheFRX?=
 =?utf-8?B?MjBCMThaWGpSVUhDRkx1VGZsMHMwdGhqeStCVDlUR2Fndm5JN3VBSHZINEtQ?=
 =?utf-8?B?SHlNRE9zUjUxbERXSlVqbEdtU21mcXE5eFZ3TXNSNEFWcTVuYVYwd2lNRjRN?=
 =?utf-8?B?TUV2RDF0bUdsMzR3Um9ray9nMHJlVm9LYXk5VlltN1V2K1JoYzVnVjBOekd2?=
 =?utf-8?B?cVNGQ0JWNWkwb1lDT1lLRk4xcFJzMzRKMFhTaW4yN0s5TzV0dUlhSjIwVGJF?=
 =?utf-8?Q?EybrTSeFcCyjnHGQIHdds0j7R?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23cf8d91-8188-4050-e74a-08dde9e9a0ad
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 06:26:19.2053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n+jATO11mUEj/5Rt6crjmIxCeBDtlHq2Dj0oEe9nBvotjx5hv6bDsHMs4eVGMx1CkKFGSRloBCaE2T4S5V4c5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4023

On 02.09.25 08:02, Avri Altman wrote:
>>>>         /* Check RPMB response */
>>>> -       if (frame_out.result != 0) {
>>>> +       if ((frame_out.result & htobe16(RPMB_OP_RESULT_MASK)) != 0) {
>>> Given that the Byte order of the RPMB data frame is MSB first, I am not
>> convinced that:
>>> (be16toh(frame_out.result) & 7) and (frame_out.result & htobe16(0x7f))
>>> yields the same output on a Little-endian machine?
>>
>> Because of the different masks? RPMB_OP_RESULT_MASK is reflecting the
>> eMMC standard (Bit[6:0] = Operation Result).
> But we are only interested in bits [2:0] - to cover all possible responses.
> 

No, we are interested in the specified response code range. Your
approach will fail if a future version of the spec adds further return code.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
