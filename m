Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC318175D2C;
	Tue,  6 Aug 2024 22:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722984673; cv=fail; b=h2kKko7yZGIr+szRCKOZbv+PrB/SVXD78YsAHMuxhA2S90ToLmauvScDm4j6mWHTY4Il1u5/YU/J106nv44K/bqd5tGXrZ2SBXtvEwRf64WjKxjWbeGYUxYAw9P5Ag4dwMnhvBx0iZbSdvAFrk/dt27MwSDVbTGUE+ovYQpdEgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722984673; c=relaxed/simple;
	bh=Lf/f1LEJ62+Zp/xwbjh2LxbcTvkVfQmdHAdZyncXLEo=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=FiUuiNPqWrNnx8qWothlbsU3wmQmUXedHkg+v1T41xxjJ4AaTDnnuFHGGbMga+sUuizDIJhWAfDQ04ZaXZP+DiFPQcVjOROhBZ7alGW0vQCyG/UFSWWh7833YwaJbCHua21jZSHG6WQSTjRa/YMau5c7t4htqo65OsDVFMwDgho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ni.com; spf=pass smtp.mailfrom=ni.com; dkim=pass (1024-bit key) header.d=ni.com header.i=@ni.com header.b=hL5AnqNm; arc=fail smtp.client-ip=40.107.94.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ni.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ni.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ni.com header.i=@ni.com header.b="hL5AnqNm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F9DCwZpKfP6KHtOb2KhaHxzqLWp4NJn1yKM8FI5KoUSnh0hvQ9JOF6hceEM7z8pFBefw4hed+uTh4tZoVHit9zSK0fT5pp62gjYi6xF4MNmF9hDZFXoUT1ta9ITwsmhGYkVJ1o2HV0OQTzEzH2kIyTz2PMG8+N+/zq+dV2Oc/A1+/TWVXCwPiJ+c5RYTEa6EkatdVirancrKbrVmTKDGoHA+TKSURyjj7RuzfTaQ1wTndmIq4bI8KOg8SDZd4zmAR0RY4ro5TAm5VxQWTM2vCr4HLhTGq3NDF5pKjeUTo0lJNfU6ZkrJbVjRc5fKY+Iyb/VAY+aPdnY/KmITmeH0iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tdGGY1dXKEpET8JBGOklIvQA9zSXUOW2uRhJa8kdLXs=;
 b=ei4d2SGIMaZpHeaw+l0nBCAV+hn3ij53eg61haZ6eFTNaBDlG/rSskjzmO6T56yhqgWX5xyt6yWFriE0lmyAdUZVgkCibYIQHmqg7OXhRITOOdYBPvF7AS8iYcobOiUMQesCbXcFcoseR4pRNMtcRgbBSQnHXldDbjRsAPmS87/XgTViuDu0FNv0bh/K6atgl7D5QGCUqTQxeyvNCvAhlNBucliVoIzvtDNWZWbvDh3PMyLuf0FdB2B178gbybHjqEwqoVAfMfSUPbd+Ed0HAqg4dJrkEjtcnWhEWsiwyRzKR01cTSSdVl3w5MF7X67goW6EA8Tjato0lCq1g/MFMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ni.com; dmarc=pass action=none header.from=ni.com; dkim=pass
 header.d=ni.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ni.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tdGGY1dXKEpET8JBGOklIvQA9zSXUOW2uRhJa8kdLXs=;
 b=hL5AnqNmvc+ht72OAvb2D34nH7N31sEjodNVmAGCMj0QWptDvsuY3VD0Ru9VsTPPkpv2oS8EuhVNc8hLCKDLJV65HMolFxSh4QobKKlSurkIZMdpyPRaUo9IulFHmAq9xU8kP4ZBZFvIwIJOQVDHSANuJj3wKvB3dtEzDDHyABk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ni.com;
Received: from SJ0PR04MB7536.namprd04.prod.outlook.com (2603:10b6:a03:32b::20)
 by PH0PR04MB7269.namprd04.prod.outlook.com (2603:10b6:510:1c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Tue, 6 Aug
 2024 22:51:08 +0000
Received: from SJ0PR04MB7536.namprd04.prod.outlook.com
 ([fe80::50f6:5b8b:46a9:4228]) by SJ0PR04MB7536.namprd04.prod.outlook.com
 ([fe80::50f6:5b8b:46a9:4228%7]) with mapi id 15.20.7828.023; Tue, 6 Aug 2024
 22:51:08 +0000
References: <87jzgur32p.fsf@ni.com>
 <dcde3b9f-ccc8-4e1e-8737-74768193f0af@intel.com>
User-agent: mu4e 1.8.14; emacs 29.3
From: Gratian Crisan <gratian.crisan@ni.com>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Hans de Goede
 <hdegoede@redhat.com>, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: mmc0: Got data interrupt 0x04000000 even though no data
 operation was in progress.
Date: Tue, 06 Aug 2024 16:35:11 -0500
In-reply-to: <dcde3b9f-ccc8-4e1e-8737-74768193f0af@intel.com>
Message-ID: <87frrhqn8n.fsf@ni.com>
Content-Type: text/plain
X-ClientProxiedBy: SA9PR03CA0010.namprd03.prod.outlook.com
 (2603:10b6:806:20::15) To SJ0PR04MB7536.namprd04.prod.outlook.com
 (2603:10b6:a03:32b::20)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR04MB7536:EE_|PH0PR04MB7269:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cca3b82-dee8-48ef-8eaf-08dcb66a4281
x-ni-monitor: EOP Exclude NI Domains ETR True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pVFJ54ceBtzO/6mAf/Z54tmevwhHsK5r2WUlB0nBPdXG1WUFUrkkxkrP+dXa?=
 =?us-ascii?Q?osx5gGNCV79lgvog2oViyaoRIjST2fywU+ay6JiK3qoSdVPkAQC99mYWATUI?=
 =?us-ascii?Q?yFesotoeWXpShjN0QPqhIPnmn7vXuSdwsK4fABBdkXbNXRL14gGMpw5GxFX7?=
 =?us-ascii?Q?bLwZYjlS+3gCGQ4ahfiQK3KGMWcZjo88cm2Wqq8sV3ISSrE3X723bQ9NdkpD?=
 =?us-ascii?Q?Y0m3dKBG1v8OtRSHfc++b0jnJF/6jDpvR0tHebb50o+1kNfUoX5nSHCFWd1r?=
 =?us-ascii?Q?fXiMswKShpTDgLrgh4IjLsUaLohmg7qEDuOTBKXrJ03EMNPYgRutJRpdryF6?=
 =?us-ascii?Q?vRuHaW7CuVkEbSm3piusOrBwedMPRnMJuwNd3338a8EpTj7cjEz2mw1gMLKy?=
 =?us-ascii?Q?BSBgd3ncWfS8xrDwGbNLP/s/I9pNglmi1Zx994CL92VnvcifiAS2YK9+yLfg?=
 =?us-ascii?Q?hwSqFuI8EHNnvmTxUv+cRGgwTmCGwnk4to1Oi9EIfOh6SraIlYpFcF5265a2?=
 =?us-ascii?Q?zNTb5v4bkBIDm9FHdirFfu0+y0NPgFhj6mElzr45gzSl2yMmYiooyFr1FqTl?=
 =?us-ascii?Q?s18vPAFxRXnXbC35w4TwRuGkHdWgHxnZT4ARwinaIOfRu6GCffQsUmxmTmsd?=
 =?us-ascii?Q?0wOIyTSOlvrKo4qnVJ4CjlhqD9N863ish5ondFbcO2VxNdV+v1+SiNPs3YrR?=
 =?us-ascii?Q?mbDcOFeK+NKxgwgUfmo1ylJqRlcGdllwUpRpQBM9EFMfPZ/2iBy9SRNGdswj?=
 =?us-ascii?Q?L+06jJH/nyHvmKjOpxCVFWtZ1nPCfczFhKTopL9x8ELsj13IFIlGDDw+kJxH?=
 =?us-ascii?Q?DVIlCNvt8MxDIH2z8mv0OP1GJhu0Hok+7zrQHgTABz3i+rv3KM+3GvhE2Ll4?=
 =?us-ascii?Q?w38o9P5S2wBMjdA3ZvFD+QCRy6qzX26ZuqQwTZTFDZw+g1O1t294/VSHQfXt?=
 =?us-ascii?Q?S25uWSRSsbOrS5b5ntL4RTR7T7mEdAlMZkYpOJLcrrsOW7K76YQw+he/tU7+?=
 =?us-ascii?Q?mDbwIElwgsJT3RF/Mu+lsOENdROu0U0UvXuZplsWdDsLyJqTDOnJphmjFFk2?=
 =?us-ascii?Q?i6rLWzn/Q9kBYu1TgfRYGF3X5AwtPDYksLZDivVCEhlo+yMnUEVPUIeGRY5N?=
 =?us-ascii?Q?eAAiQv5aZ1ZvLsohLseSfe5kAuT8brFzojJD8Lq5nVTwIkedmPEdq4mwaN0J?=
 =?us-ascii?Q?SnIhLWL6CMk7flp6ZZYy3yYcrMmiC9lsc3i2NseDr/cm8cvRdkd+R0QGbOBG?=
 =?us-ascii?Q?FuqIhZjh7esKbkNNpmkQY46mJexYT4I/1S71uD3jrpTP5PPGgSkNFxA+YHuo?=
 =?us-ascii?Q?exICfCRQlYLcgySSNTSTHPRz65lwNVQoFu2DGKgmQyRbsA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7536.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+TT4tqoEeN9/C3nzC1yqcCjBMXa6Ix3a4GRi2nAkLPyMnMTKoAeZmLuCrbUu?=
 =?us-ascii?Q?eIdXc5f76XQViShRpnMAoSoCSZtokkuaes+8PaV//KDKRnjpWCMCtPiadXjQ?=
 =?us-ascii?Q?D9psTKAuyFaIcUwn7GEJ1XoZHl6lhHG7PzzzyNwkoBO+ZvrXkjqeNmuBKiWy?=
 =?us-ascii?Q?1lTObdIzVzcL7SImc1xy4Me6QW9Y0nrjHJaABkdkqOt5KX4dV7b3L3PG3cNF?=
 =?us-ascii?Q?EhidTShm5HwTt6jYv6nmHTisf/pahPGpajLJClnO/yWq956EcPRhTeIdoEJY?=
 =?us-ascii?Q?tU6d81ClS6jNQb0Opm0XzevR0C+N8VIxjyhbd7f62v8g2FOYKLk5K09oF7di?=
 =?us-ascii?Q?2+q9gFcJX23xGuAUurNgLLAVvBUdyfcf+f3U2exd163G7vXcm+R4HfZ8IBzb?=
 =?us-ascii?Q?ET0XzcPi3LdE2cisyDjye7agEsAZSakR1xZ4seKbAvjg/rm0aKoZAuOArwrG?=
 =?us-ascii?Q?p2IN6r9rsJeOU3ZoAYbg0SCKgJgd/gjVE+yvQytz21ZYLV0HrUmSoN/fHk1p?=
 =?us-ascii?Q?sV782jpvfof9Kqqj45+CEUVz34HTZ6Fp2kECq0uHVC/hATASUAxHQCrkukv6?=
 =?us-ascii?Q?umzK3VLYznF1++m66F9QzGPpnLfXCFkAWUcTugo7wpbHNPNx2U1rytiHrFA2?=
 =?us-ascii?Q?7pLWfRz21mmNvYuubBGkX1ohnZIwVUwbeIPwdFkVHbwuUT4X/bZK8eu0uJ17?=
 =?us-ascii?Q?qV8qNybGSLQlwnzwCl+otWoVwqgwg09NayfREw1oSOgHjx4hXwc1HgQNIGVm?=
 =?us-ascii?Q?NTux5EvtknGkGrOwR/LhIjSeVlBeaL4/pZrIhM5xllZN9UpcqR55aiHbm6nZ?=
 =?us-ascii?Q?R6n7Ul3ip04OdkDLSu2F8LDmC/Eb1vIvkHfzuqg+KGyJpe5y429Kw7PNCPG5?=
 =?us-ascii?Q?wslTmFuZ8p5E48ar0KNlhiCsABg48Lsj6aldMKPZwE4yVwdntQqSGPXddJad?=
 =?us-ascii?Q?ke9fu0MmcVWu907qMZOfZoD9owdcfrE1KIZNtHvQJvK5oDG+HN2ccknQpk4I?=
 =?us-ascii?Q?aQenNDiIo4SybIH8vUDDz7jsIapwAlGd+TAPmcHxk4zAAEq9IvSNFiMMByHR?=
 =?us-ascii?Q?fhnbgrAPv5XIukWUmGjtVKkuiubh3x+Y3Ygkrk55RF7SiwPtrQfqSnWMlSDP?=
 =?us-ascii?Q?lgTSlnh7nsBz5NJMVVFYZ13kgu0TeipY2Pdm82g3DpvJAuvYFjaG2uCQW2ck?=
 =?us-ascii?Q?PTqTvYsIwucU2zWOOzLtuBHUYB66mCyVakQNGXxX1ARm1R2OUCQBgIRPUYGE?=
 =?us-ascii?Q?ZIFxCjpXqsVI6IPjjuRF7XGd/4KF580xsKeRr8K8foBFf9vXrvwFQD3Yx5Vb?=
 =?us-ascii?Q?bRV1EYg8Sr6Q0V1lWX4Qw8NPYTVN3X0vPRjbTTJq78WnoP1qDz9RReuDAtiQ?=
 =?us-ascii?Q?twB6nlCmrXX8EZmKSQQtNhYhh3ULM5zhLDEsHs9v6+EYT7O/iMQPx4kXRaFx?=
 =?us-ascii?Q?qrYy2MsANnrz998QI98YV7LBsNnikjEoTrEBMfmb1siSmfUecLVYH/TCt/gb?=
 =?us-ascii?Q?rjsiQLmvWYn6ZK4X7op41ZSWaQR48909L+Aqx6Ojgsa/iXvV4lmkQ8VwkYg1?=
 =?us-ascii?Q?Wma6xrIL58tOQ3qZVZRwF0qPmLnEsFaqwHVi+rMYzHl0LH+67H/n8tvwvfOk?=
 =?us-ascii?Q?j9wL68UXWXsrRRafocqDM127joQancydKNwRK/8yhVFJSCjK2tAE2PQ1VSuk?=
 =?us-ascii?Q?yQUMoQ=3D=3D?=
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cca3b82-dee8-48ef-8eaf-08dcb66a4281
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7536.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 22:51:08.1205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: whVp+xhHXoAEYacNVaO59ojlM5YbVIjpHfCuL1PdDBJ7A3luumBDN7iM10kGCYusjOm56V8Vywu16KxUCpotTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7269


Adrian Hunter <adrian.hunter@intel.com> writes:
> On 6/08/24 00:33, Gratian Crisan wrote:
>> 
>> We are getting the following splat on latest 6.11.0-rc2-00002-gc813111d19e6 (and
>> older) kernel(s):
>
> Do you know a kernel version that does not get an error?
>

Sorry for not being more clear in my original email - this is not a new issue. I
believe this Bay Trail hardware always had an issue with receiving "Tuning
Error" interrupts with certain SD cards. At least as far back as 4.9.47.

Up until commit b3855668d98c ("mmc: sdhci: Add support for "Tuning Error"
interrupts") these resulted in a "mmc0: Unexpected interrupt 0x04000000" splat,
which b3855668d98c fixed.

However, now that "Tuning Error" interrupts are treated as data interrupts and
handled in sdhci_data_irq() we are hitting a corner case where that tuning error
interrupt comes in after a MMC_SEND_STATUS command with no 'host->data'
associated resulting in the new splat.

Hence the question in my previous email: Should the tuning error interrupts be
handled in common code in sdhci_irq()?

>> 
>> [    4.792991] mmc0: new ultra high speed DDR50 SDHC card at address 0001
>> [    4.793550]   with environment:
>> [    4.793786]     HOME=/
>> [    4.793985]     TERM=linux
>> [    4.794201]     BOOT_IMAGE=/runmode/bzImage
>> [    4.794485]     sys_reset=false
>> [    4.795791] mmcblk0: mmc0:0001 0016G 15.2 GiB
>> [    5.333153] mmc0: Got data interrupt 0x04000000 even though no data operation was in progress.
>> [    5.333676] mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
>> [    5.334069] mmc0: sdhci: Sys addr:  0x12454200 | Version:  0x0000b502
>> [    5.334464] mmc0: sdhci: Blk size:  0x00007040 | Blk cnt:  0x00000001
>> [    5.334860] mmc0: sdhci: Argument:  0x00010000 | Trn mode: 0x00000010
>> [    5.335253] mmc0: sdhci: Present:   0x01ff0000 | Host ctl: 0x00000016
>> [    5.335648] mmc0: sdhci: Power:     0x0000000f | Blk gap:  0x00000000
>> [    5.336040] mmc0: sdhci: Wake-up:   0x00000000 | Clock:    0x00000107
>> [    5.336432] mmc0: sdhci: Timeout:   0x0000000a | Int stat: 0x00000000
>> [    5.336824] mmc0: sdhci: Int enab:  0x03ff008b | Sig enab: 0x03ff008b
>> [    5.337214] mmc0: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
>> [    5.337605] mmc0: sdhci: Caps:      0x076864b2 | Caps_1:   0x00000004
>> [    5.337997] mmc0: sdhci: Cmd:       0x00000d1a | Max curr: 0x00000000
>> [    5.338389] mmc0: sdhci: Resp[0]:   0x00400900 | Resp[1]:  0x00000000
>> [    5.338780] mmc0: sdhci: Resp[2]:   0x00000000 | Resp[3]:  0x00000000
>> [    5.339170] mmc0: sdhci: Host ctl2: 0x0000000c
>> [    5.339468] mmc0: sdhci: ADMA Err:  0x00000003 | ADMA Ptr: 0x12454200
>> [    5.339859] mmc0: sdhci: ============================================
>> [    5.340293] I/O error, dev mmcblk0, sector 0 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
>> [    5.344663] Buffer I/O error on dev mmcblk0, logical block 0, async page read
>> [    5.346127]  mmcblk0: p1 p2
>> 
>> This is on an Intel Bay Trail based system: NI cRIO-9053 using an Atom E3805.
>> 
>> The issue appears related to the one fixed by commit b3855668d98c ("mmc: sdhci:
>> Add support for "Tuning Error" interrupts") and discussed here[1].
>
> Does reverting that commit help?
>

Reverting the commit brings back the original splat that commit fixed (albeit
without the I/O error):

[    4.893032] mmc0: new ultra high speed DDR50 SDHC card at address 0001
[    4.896238] mmcblk0: mmc0:0001 0016G 15.2 GiB
[    4.905944] mmc0: Unexpected interrupt 0x04000000.
[    4.906272] mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
[    4.906664] mmc0: sdhci: Sys addr:  0x126e6200 | Version:  0x0000b502
[    4.907059] mmc0: sdhci: Blk size:  0x00007200 | Blk cnt:  0x00000008
[    4.907451] mmc0: sdhci: Argument:  0x00000000 | Trn mode: 0x0000003b
[    4.907842] mmc0: sdhci: Present:   0x01ff0206 | Host ctl: 0x00000016
[    4.908234] mmc0: sdhci: Power:     0x0000000f | Blk gap:  0x00000000
[    4.908625] mmc0: sdhci: Wake-up:   0x00000000 | Clock:    0x00000107
[    4.909015] mmc0: sdhci: Timeout:   0x0000000a | Int stat: 0x00000002
[    4.909408] mmc0: sdhci: Int enab:  0x03ff008b | Sig enab: 0x03ff008b
[    4.909800] mmc0: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000001
[    4.910193] mmc0: sdhci: Caps:      0x076864b2 | Caps_1:   0x00000004
[    4.910581] mmc0: sdhci: Cmd:       0x0000123a | Max curr: 0x00000000
[    4.910976] mmc0: sdhci: Resp[0]:   0x00000900 | Resp[1]:  0x00400900
[    4.911371] mmc0: sdhci: Resp[2]:   0x00000000 | Resp[3]:  0x00400900
[    4.911765] mmc0: sdhci: Host ctl2: 0x0000000c
[    4.912064] mmc0: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0x126e6200
[    4.912456] mmc0: sdhci: ============================================
[    4.913301]  mmcblk0: p1 p2
[    6.401855] EXT4-fs (mmcblk1p2): mounted filesystem d57a3d3c-a1f9-4f8e-8cbc-19dc5bb4fc4c r/w with ordered data mode. Quota mode: disabled.

>> I am new to this area of the kernel so I would appreciate any suggestions on the
>> direction to take here:
>> 
>>   - Should the tuning error interrupts be handled in common code in sdhci_irq()
>>     (or at least before the !host->data check in sdhci_data_irq())?
>> 
>>   - Is this more of an issue with tuning not happening when is expected or
>>     taking too long, since at first we do get the error during data transfer
>>     commands? Suggestions on what I should debug/trace next appreciated.
>
> SDHCI driver does not enable the "Tuning Error" interrupt, refer
> the kernel messages above:
>
> 	Int enab:  0x03ff008b | Sig enab: 0x03ff008b
>
> but it happens anyway, so the "fix" was to handle it anyway.
>
> But it begs the question, wasn't the error happening already?
>

Kind of: Before we were getting "mmc0: Unexpected interrupt 0x04000000", but
somehow it didn't result in a I/O error. That may be just lucky timing.

Now we're getting "mmc0: Got data interrupt 0x04000000 even though no data operation was in
progress." followed by an I/O error on READ.

I appreciate your reply. I'm happy to work on a patch or test things if I'm
pointed in the right direction.

Thanks,
    Gratian
