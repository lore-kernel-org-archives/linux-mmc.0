Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013002.outbound.protection.outlook.com [52.101.72.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEE125E469;
	Wed, 25 Feb 2026 10:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772014437; cv=fail; b=LCg/37F3PmZttmix8JYlYA8cffnAmJaltdCU+pDLvHdw5Qs0g9VJQtvEuCSZ/vhwNjGG3gYMZrzLVuesUYYCXsJ8fu9Vymq3rEQVzY1xGfhFNPQNT31AyUcLnc+RCuu/h4QZZdK+JfwZAAr+lDERPU7ffVe+d70v+3l03MwfC0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772014437; c=relaxed/simple;
	bh=yKvYiaJiemXBS58W32tU14BcV+Oaz8ta59kcZpXvhYg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MiEevXPPIo2tLR5BG2VMsLE0sHFWsbsWBQY8MiFY8lxjMtmOCs2EkUbeaNWkzkcaeYBRqyrqlEhfQCwCmm6F0EfqRmsr9vuRdUZfbi3/02uYdZUhYpw15onkOpqwm3RoynJ0vvJgeyEn2e71WEBc2jBfMNASjJVPdrtotY28BS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=O/2FLvbB; arc=fail smtp.client-ip=52.101.72.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="O/2FLvbB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ufhZI4HIyLzWq5USXrqkgnvAMqx8kEQAOLKKs7Cf+s3TbUmz4OtMmiT3Bfv8Xmtt5PeYcVv+ccognq0OFtHPJ7mGhQuycYL6crtMwQZVneoqbUj3tB58Xta+4xq1I+t63VmjECSLoE604gMqkT2VF+Zr+GjpJ4f9SNTQeiSRaDkl7Dfa5F3Onwpx6BvGzPFeK6yNTOSmWnMZLsZ7lnnlkEcYMYxhm+pyZGoQ0Y/dz2tTqy4nH3ANtyF8cBGqZ2dAVsBygek09KrdlGTWAZmK2zUSHybnK+M5NblAD4pRXhyv6yqMh7IgHRHF2hkBgUCURdLMmrBFVE2BgXzD6OyGMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1xOC00gjJFPJdpiyn5CHPHbSMzezj8Q9oycUGd7AY8Q=;
 b=VCCE9f7qyG9Vuvpr4abGl/FU3xnVk0N1F7cSpHisZsdRTGbK+qb89afkfD3+7PtCZs7ijND8pHjAzLLG6yBNW+Malzx7QcDqc810Izc0z6mFLu+IyDJ9ZnWyPG3WJKaWRx5HMXl0Bwx/qI0yWqeaJ/MkGS7aYyEVfqN3RyXp+0g8qc9OxzWUMZfBz28vIkdFj4CzOzamAiVXBywpZpThcAosbsis0Qlp7IMl5+AAeafZmF0isuac1YiBbylTtvEzl+KHExDEFpz+SnDAWpMMNAJRPF4Q9L1b3pp68Vvxv0HQDi7WeCG6U6AfGycIUken2GJ+btXlwlRmZkS0920jvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1xOC00gjJFPJdpiyn5CHPHbSMzezj8Q9oycUGd7AY8Q=;
 b=O/2FLvbBaRL85oLNi+PycUvgFFQac2+iKRUph3IaSdqOhfi1/baU5tNje0tJo1dJePnS66IQV+viZj1Xl4q870hDZVtqdn7fTvTPq5BcXbl4nNqatMN85+LsEiqHv/uhljxxrfsFn2xAoHh/s/5E6TYkjC4QdaSXcjmo0AgDNRrYEtkdIpdvCRm48IengCTO60Y+orfUfD60q5kBKMhI6ZXakU20kEulKZzwu8Wwmx2ZWX3KHOk/od76TJ6MY4eNIaMEUHH5P5R9VqLzpwVu/4TFb62Jp4ng1v24jj7VMshxtdVXQ70A5VVh5SM2XAB6O3Mj4SqYWx1XhwNdkOjPbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by GV1PR04MB10845.eurprd04.prod.outlook.com (2603:10a6:150:20d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Wed, 25 Feb
 2026 10:13:43 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0%5]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 10:13:42 +0000
Message-ID: <005e1d75-c326-4017-ad98-92a190099c2c@oss.nxp.com>
Date: Wed, 25 Feb 2026 12:13:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] arm64: dts: freescale: Add minimal support for S32N79
To: Frank Li <Frank.li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Shawn Guo <shawnguo@kernel.org>,
 Lucas Stach <l.stach@pengutronix.de>, Christophe Lizzi <clizzi@redhat.com>,
 Alberto Ruiz <aruizrui@redhat.com>, Enric Balletbo <eballetb@redhat.com>,
 Eric Chanudet <echanude@redhat.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 NXP S32 Linux Team <s32@nxp.com>, Larisa Grigore <larisa.grigore@nxp.com>,
 Andra-Teodora Ilie <andra.ilie@nxp.com>,
 Andrei Cherechesu <andrei.cherechesu@nxp.com>
References: <20260224111533.3194883-1-ciprianmarian.costea@oss.nxp.com>
 <20260224111533.3194883-5-ciprianmarian.costea@oss.nxp.com>
 <aZ4TcK6GLZTsbGBf@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
In-Reply-To: <aZ4TcK6GLZTsbGBf@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR02CA0162.eurprd02.prod.outlook.com
 (2603:10a6:20b:28d::29) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|GV1PR04MB10845:EE_
X-MS-Office365-Filtering-Correlation-Id: 736db362-4dd4-45ed-7c4e-08de74568dbe
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|19092799006|366016;
X-Microsoft-Antispam-Message-Info:
	x2i/4Tqum2dECcIglH1s8RflTJ/I3lwgmliVuSEVEM/hEMUKDe4q17f+aIXqIGLIbaFzeKrgTb+nAhf5b+lhYzgSaR4JwdUvDBGT2T8CaMCFFc0/hhxhOHJ8rCXeKc3fWOWvre4oM2I0EbiPyQklDYfMS1KnYwLujhef5To1dQ6kzUh+yWUGvzoLI4UBEx543bXAbggj8apQk7LtQeV2d5y7tEDZ9fDcYqlTILW/uvOcMIuvaoA+KH/CBDefjSq1evKj94/ZCdXttPmZTQtN4iTKyKqVWNlTjkFg4Lt80Rw77nhHze/Xa/eJTE1kDCFbY3nN5YNF8Kfojc+Wp8wreUj9PcUU0O4vgrfh4sKUkd77L7dt529vzeAKl3DdWL4HofDHUbVqMBlIR3x77WcGaxbsLCkvdOGGXfZnQNZ3QB8QyU7ylLMjYbck/y+VjcnwPC3uLK7ejAOZ0KrHSVg+2ovAoiK01dtr2IwKQfWAmsjx4vkEC3E0vOUzC4cMGJ583yLPmmIrNaHd9E2+ock5wlVLzJ0JvaJPtBhyHb8UM7ge2/S4eTyLc0VMvv86HewIDNScTeoIl6Gql+gF5LDJ/RBBLcdJgasvo160hZUwgHfxh2wP7ajN56dijXiJTWvzkJz0W9Ktxfqs4E6WqNW/wR5gTChmAvtr84mCSgSyMS6RmUAUZLGdAi5xyu0bcfkpulHMP84Hq8NHSUuicRywQsBZ3pGfCaUBAYVNsfarg/E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(19092799006)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y0hTKzhWZVRuay9jVzlWQVMwWTk1MDZLMWxpNDlOd29aWW91TEtXL0lja2hm?=
 =?utf-8?B?M1c1aEhpMDdVeHNITURDZWkyWFN3UVFFRzhRKzdSM2RKNVRvWnAvSm1CZ095?=
 =?utf-8?B?NHQ0aWw5Q25uR0N4NlpLQmtieFpDNXBzUzRYK2czZFVIV1ArMmsxMGpDbkNJ?=
 =?utf-8?B?R29qbGlEUzFNOG9mRmE5TGF3aEtFYUFOUWkwNkZRUjI5YlFMbTBTNENTZDQz?=
 =?utf-8?B?QlZ6QVg0TXRFR0RrMW01Q1IzTGJUSXFjcDZhclR5d0J0K3E4MHZRNmRFU3Na?=
 =?utf-8?B?dmUvUTRTMkkwNWJEM2Z6eG5DeHBYRmdEOTYxemFqZUdQWU5kNWNSV3BZUm1W?=
 =?utf-8?B?M2d5Mkg1aDExYnFlNy9abVMyQThST09UWWtBcnYvZWc4VStETGhZVTZrbDNQ?=
 =?utf-8?B?OGI5MEdaWkVzVVM0WFE2YVJFNVN1Z3M1UG9UbmJtQVN2ZkpwWFN4bzhYc2pF?=
 =?utf-8?B?TUdXVitNVVNRRzNvTjRwNnBtTXUxRmYyZ0FzdjZDdVIvbEhTK0IxWEh4RGxS?=
 =?utf-8?B?WEJHa0tOeWI3R0I4WDZNNmgvazVsVUVSTHdFcmp3SnNRSWlxQS9DelBXc0Uy?=
 =?utf-8?B?VU96Z3JNNFpjRG5IS2lObVZWMytLZ3hiZ0Q3TzRuN0loa1VvWjVlaW81T3Vw?=
 =?utf-8?B?Zjl6NGZXckI5Q2MxTXVVeFJzc0VocDc3TFJ2MTVXVS9sVEcvV1RWWXRpT1RQ?=
 =?utf-8?B?VjN6ZDh0SFRPd1MvRG12M0plVEFJZ0ViUG9RaVJmV3A5QmFqZDhLcWowazdo?=
 =?utf-8?B?MS9rRk5iZUwrTDJqMWpMS21ldTJLc1hSK05QWXc3WFRybUNCUXNZOHA2VGJL?=
 =?utf-8?B?Uk9hdmZGdU94UkErQS9ONFJoWmx2L0xtUndneFFDbDRpaVVGWGx0TC9WQXpW?=
 =?utf-8?B?N0lXMkZaZG83ODBnZ3oxNldsb24vRkJnVDF3eHh6ZkNQQUh1MFVuQVM1SFB4?=
 =?utf-8?B?azNyNldVZVRLNlFXczBqN1lHRFdGNzVaSEFmR3huWXlxKytSSWp3U2RSOGlD?=
 =?utf-8?B?ZTZHTXhQL3hybkEvYmRPa2I4N1FWOFgwTjQ3YjFNVllrRnRnWS9pUDRPZUls?=
 =?utf-8?B?Rko3VzNQNlN0TE1MY3BqNGlLV2xqTTF3aXBqdFMvaEE3NHJaa2JkU01JRkNP?=
 =?utf-8?B?RTZxaFBtdnBWb3FPSm9zaTVkVjM3QUV3aHkvQjZsUW03cVJyWUx1bzRWaFln?=
 =?utf-8?B?TWxsZkk2ZTFqVE5hUjN2UjFSMVVzdElYNHdJQ2JCMGZUbHQ5SkZNTS96cVZv?=
 =?utf-8?B?bHJEOHhQWURiY2ZFS1B2ZHd0S1BrM0RKVk45V1hxT2xnWVNTVzVQR3h2WXNT?=
 =?utf-8?B?VHpWcXlBTDZrK0hubkowWGoyTHozbzlYNDdIbDJIN1B5Y2R0b1dZUDR6SlVN?=
 =?utf-8?B?WHRrTUNHQ2ptZng4R0cxa2ZJb0M0YWN6L2lDS1dJTFQ0YjZycElwb3VwdDJH?=
 =?utf-8?B?NUs3aCtXZjVVY0sycit2elYwRzF1M1h5S0lvcThBQWZBUmVWSnhONnRSVi81?=
 =?utf-8?B?V2sxYzdENU9zZlBoRFdFWGpUZjJRdUxQV1hBRmsvMWNjRER5NGlBWCtGb1F5?=
 =?utf-8?B?eDlYdXJCWjFreXVOVE9DdzVuRDkvTEd3RDRGYVdTNTQ3eHFVbjQxb1FGNjBj?=
 =?utf-8?B?bDA4Z0N2THpiUkRnRTVjdWgrZjkreVRUcm90UVdicG9Rdzh3L3ZSYVF5YmIx?=
 =?utf-8?B?dytObkJKOHlaZzExYTVoUVJsUWF5dVZkOStLS09KRG0wQmlrWVo0Y1VDVUR1?=
 =?utf-8?B?RFNmeUFHV3NsTElZcllzeVBDcTg0OWtwb0lORitRZFo4M3RxZklNOVNxcnl3?=
 =?utf-8?B?Qmg0bDM0c1Zka3hkdFo4Vk9CcEpQV2RFbGt1MlgxVXpkY2Y1SlJzWTNnTEdD?=
 =?utf-8?B?MVFCZnJkMzlnb29pQjFxbFFjYWQzSm9wMDJiVlBpU1duSnVvWXcwbWlnNGNz?=
 =?utf-8?B?b0xLbGlaVGpkNTVOdXdJK2tKUGoxYzlCKzNxSUowMDhHUU9hUVhwRis4MUxM?=
 =?utf-8?B?SWJZUmR2YWxONmxQSWpTako2QkVNRHlRTGRZTEhhMkRGOXZCcmFYVnMwV0Fp?=
 =?utf-8?B?ZStNNEVka2YyOHpqc1VRK2pGb2dadit1ZUxCeGN6MHo2MGpWdDFaZ0NLcGJG?=
 =?utf-8?B?ZVAzeXV4bnRkUnMvNzlKUnIzNG9POTlyQmF5U01CS2xmbzdneDhZaStLQW9D?=
 =?utf-8?B?N1NYNUp1czU5bnA4enpxZlBuVFdUY2JuZ3VpVHBjZXkrbUdnbkt0eFN4M0dK?=
 =?utf-8?B?TmxHYlJKWTJ2eHROTy9BNEtCMCtGV3JEcUQvQ3k1aU1wMllvbHdka3Z2bmFT?=
 =?utf-8?B?Nzhldml1bGJ2QVpqY2lOKzVPb1BPSE4raGlLWW53OGw2SDRRMDFEU0p5L3p4?=
 =?utf-8?Q?f9oVkZjnMRaeH4qlD1vcIVHNdlYmI/sOQshwW?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 736db362-4dd4-45ed-7c4e-08de74568dbe
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 10:13:42.9135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 43J11f0RZE1hAmFpCoYXKPe2W8DkQHe5jX45U3VFAUkWBzUsOC6SEhoy7IrVrHGwkPTIuXSIxGe5e7Pl67ltj6K6IkMoGgFTjbK+GaB1lMs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10845

On 2/24/2026 11:09 PM, Frank Li wrote:
> On Tue, Feb 24, 2026 at 12:15:33PM +0100, Ciprian Costea wrote:
>> From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
>>
>> Add device tree support for the NXP S32N79 automotive SoC and the S32N79
>> Reference Design Board (RDB) [1].
>>
>> The S32N79 features eight Arm Cortex-A78AE cores organized in four
>> dual-core clusters, with a three-level cache hierarchy (L1/L2 per core,
>> L3 per dual-core cluster) and 32GB of DRAM memory. It includes an SMMUv3
>> for IOMMU functionality.
>>
>> On S32N79 SoC, peripherals are organized into subsystems, such as:
>> - CIS (Coherent Interconnect Subsystem).
>> - COSS (Connectivity Subsystem)
>> - FSS (Foundation Subsystem)
>>
>> This initial support includes basic peripherals:
>> - GICv3, SMMUv3 from CIS Subsystem
>> - PL011 UARTs and IRQ steering controller from COSS Subsystem
>> - uSDHC from FSS Subsystem
>>
>> Clock and Pin multiplexing settings for the chip are managed over SCMI.
>>
>> [1] https://www.nxp.com/products/processors-and-microcontrollers/s32-automotive-platform/s32n-vehicle-super-integration-processors:S32N
>>
>> Co-developed-by: Larisa Grigore <larisa.grigore@nxp.com>
>> Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
>> Co-developed-by: Andra-Teodora Ilie <andra.ilie@nxp.com>
>> Signed-off-by: Andra-Teodora Ilie <andra.ilie@nxp.com>
>> Co-developed-by: Andrei Cherechesu <andrei.cherechesu@nxp.com>
>> Signed-off-by: Andrei Cherechesu <andrei.cherechesu@nxp.com>
>> Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
>> ---
>>   arch/arm64/boot/dts/freescale/Makefile       |   1 +
>>   arch/arm64/boot/dts/freescale/s32n79-rdb.dts |  70 ++++
>>   arch/arm64/boot/dts/freescale/s32n79.dtsi    | 361 +++++++++++++++++++
> 
> all new dts, run https://github.com/lznuaa/dt-format to keep consistent
> node order
> 
> Frank

Hello Frank,

Very interesting tool. Thanks for the suggestion.
I will address the 'dt-format' findings in V2.

Best Regards,
Ciprian

>>   3 files changed, 432 insertions(+)
>>   create mode 100644 arch/arm64/boot/dts/freescale/s32n79-rdb.dts
>>   create mode 100644 arch/arm64/boot/dts/freescale/s32n79.dtsi
>>
>> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
>> index 700bab4d3e60..e79807bf1820 100644
>> --- a/arch/arm64/boot/dts/freescale/Makefile
>> +++ b/arch/arm64/boot/dts/freescale/Makefile
>> @@ -501,4 +501,5 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mm-phygate-tauri-l-rs232-rs485.dtb
>>   dtb-$(CONFIG_ARCH_S32) += s32g274a-evb.dtb
>>   dtb-$(CONFIG_ARCH_S32) += s32g274a-rdb2.dtb
>>   dtb-$(CONFIG_ARCH_S32) += s32g399a-rdb3.dtb
>> +dtb-$(CONFIG_ARCH_S32) += s32n79-rdb.dtb
>>   dtb-$(CONFIG_ARCH_S32) += s32v234-evb.dtb
>> diff --git a/arch/arm64/boot/dts/freescale/s32n79-rdb.dts b/arch/arm64/boot/dts/freescale/s32n79-rdb.dts
>> new file mode 100644
>> index 000000000000..c8b1dcefa2db
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/freescale/s32n79-rdb.dts
>> @@ -0,0 +1,70 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
>> +/*
>> + * Copyright 2026 NXP
>> + *
>> + * NXP S32N79 Reference Design Board (S32N79-RDB)
>> + */
>> +
>> +/dts-v1/;
>> +#include "s32n79.dtsi"
>> +
>> +/ {
>> +	model = "NXP S32N79-RDB";
>> +	compatible = "nxp,s32n79-rdb", "nxp,s32n79";
>> +
>> +	aliases {
>> +		serial0 = &uart0;
>> +		serial1 = &uart5;
>> +		serial2 = &uart6;
>> +		serial3 = &uart7;
>> +	};
>> +
>> +	chosen {
>> +		stdout-path = "serial0:115200n8";
>> +	};
>> +
>> +	memory@80000000 {
>> +		device_type = "memory";
>> +		reg = <0x00 0x80000000 0x00 0x80000000>,
>> +			<0x88 0x00000000 0x03 0x40000000>,
>> +			<0xc0 0x00000000 0x03 0x40000000>;
>> +	};
>> +
>> +	reserved-memory {
>> +		#address-cells = <2>;
>> +		#size-cells = <2>;
>> +		ranges;
>> +
>> +		scmi_shbuf: shm@93000000 {
>> +			compatible = "arm,scmi-shmem";
>> +			reg = <0x0 0x93000000 0x0 0x80>;
>> +			no-map;
>> +		};
>> +	};
>> +};
>> +
>> +&irqsteer_coss {
>> +	status = "okay";
>> +};
>> +
>> +&uart0 {
>> +	status = "okay";
>> +};
>> +
>> +&uart5 {
>> +	status = "okay";
>> +};
>> +
>> +&uart6 {
>> +	status = "okay";
>> +};
>> +
>> +&uart7 {
>> +	status = "okay";
>> +};
>> +
>> +&usdhc0 {
>> +	disable-wp;
>> +	no-sdio;
>> +	status = "okay";
>> +};
>> diff --git a/arch/arm64/boot/dts/freescale/s32n79.dtsi b/arch/arm64/boot/dts/freescale/s32n79.dtsi
>> new file mode 100644
>> index 000000000000..ff4e004fcd7c
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/freescale/s32n79.dtsi
>> @@ -0,0 +1,361 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
>> +/*
>> + * NXP S32N79 SoC
>> + *
>> + * Copyright 2026 NXP
>> + */
>> +
>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>> +
>> +/ {
>> +	interrupt-parent = <&gic>;
>> +	#address-cells = <2>;
>> +	#size-cells = <2>;
>> +
>> +	cpus {
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +
>> +		cpu-map {
>> +			cluster0 {
>> +				core0 {
>> +					cpu = <&cpu0>;
>> +				};
>> +
>> +				core1 {
>> +					cpu = <&cpu1>;
>> +				};
>> +			};
>> +
>> +			cluster1 {
>> +				core0 {
>> +					cpu = <&cpu2>;
>> +				};
>> +
>> +				core1 {
>> +					cpu = <&cpu3>;
>> +				};
>> +			};
>> +
>> +			cluster2 {
>> +				core0 {
>> +					cpu = <&cpu4>;
>> +				};
>> +
>> +				core1 {
>> +					cpu = <&cpu5>;
>> +				};
>> +			};
>> +
>> +			cluster3 {
>> +				core0 {
>> +					cpu = <&cpu6>;
>> +				};
>> +
>> +				core1 {
>> +					cpu = <&cpu7>;
>> +				};
>> +			};
>> +		};
>> +
>> +		cpu0: cpu@0 {
>> +			device_type = "cpu";
>> +			compatible = "arm,cortex-a78ae";
>> +			reg = <0x0>;
>> +			enable-method = "psci";
>> +			next-level-cache = <&l2_0>;
>> +		};
>> +
>> +		cpu1: cpu@100 {
>> +			device_type = "cpu";
>> +			compatible = "arm,cortex-a78ae";
>> +			reg = <0x100>;
>> +			enable-method = "psci";
>> +			next-level-cache = <&l2_0>;
>> +		};
>> +
>> +		cpu2: cpu@10000 {
>> +			device_type = "cpu";
>> +			compatible = "arm,cortex-a78ae";
>> +			reg = <0x10000>;
>> +			enable-method = "psci";
>> +			next-level-cache = <&l2_1>;
>> +		};
>> +
>> +		cpu3: cpu@10100 {
>> +			device_type = "cpu";
>> +			compatible = "arm,cortex-a78ae";
>> +			reg = <0x10100>;
>> +			enable-method = "psci";
>> +			next-level-cache = <&l2_1>;
>> +		};
>> +
>> +		cpu4: cpu@20000 {
>> +			device_type = "cpu";
>> +			compatible = "arm,cortex-a78ae";
>> +			reg = <0x20000>;
>> +			enable-method = "psci";
>> +			next-level-cache = <&l2_2>;
>> +		};
>> +
>> +		cpu5: cpu@20100 {
>> +			device_type = "cpu";
>> +			compatible = "arm,cortex-a78ae";
>> +			reg = <0x20100>;
>> +			enable-method = "psci";
>> +			next-level-cache = <&l2_2>;
>> +		};
>> +
>> +		cpu6: cpu@30000 {
>> +			device_type = "cpu";
>> +			compatible = "arm,cortex-a78ae";
>> +			reg = <0x30000>;
>> +			enable-method = "psci";
>> +			next-level-cache = <&l2_3>;
>> +		};
>> +
>> +		cpu7: cpu@30100 {
>> +			device_type = "cpu";
>> +			compatible = "arm,cortex-a78ae";
>> +			reg = <0x30100>;
>> +			enable-method = "psci";
>> +			next-level-cache = <&l2_3>;
>> +		};
>> +
>> +		l2_0: l2-cache0 {
>> +			compatible = "cache";
>> +			cache-level = <2>;
>> +			cache-size = <524288>;
>> +			cache-line-size = <64>;
>> +			cache-sets = <512>;
>> +			cache-unified;
>> +			next-level-cache = <&l3_0>;
>> +		};
>> +
>> +		l2_1: l2-cache1 {
>> +			compatible = "cache";
>> +			cache-level = <2>;
>> +			cache-size = <524288>;
>> +			cache-line-size = <64>;
>> +			cache-sets = <512>;
>> +			cache-unified;
>> +			next-level-cache = <&l3_1>;
>> +		};
>> +
>> +		l2_2: l2-cache2 {
>> +			compatible = "cache";
>> +			cache-level = <2>;
>> +			cache-size = <524288>;
>> +			cache-line-size = <64>;
>> +			cache-sets = <512>;
>> +			cache-unified;
>> +			next-level-cache = <&l3_2>;
>> +		};
>> +
>> +		l2_3: l2-cache3 {
>> +			compatible = "cache";
>> +			cache-level = <2>;
>> +			cache-size = <524288>;
>> +			cache-line-size = <64>;
>> +			cache-sets = <512>;
>> +			cache-unified;
>> +			next-level-cache = <&l3_3>;
>> +		};
>> +
>> +		l3_0: l3-cache0 {
>> +			compatible = "cache";
>> +			cache-level = <3>;
>> +			cache-size = <1048576>;
>> +			cache-line-size = <64>;
>> +			cache-sets = <1024>;
>> +			cache-unified;
>> +		};
>> +
>> +		l3_1: l3-cache1 {
>> +			compatible = "cache";
>> +			cache-level = <3>;
>> +			cache-size = <1048576>;
>> +			cache-line-size = <64>;
>> +			cache-sets = <1024>;
>> +			cache-unified;
>> +		};
>> +
>> +		l3_2: l3-cache2 {
>> +			compatible = "cache";
>> +			cache-level = <3>;
>> +			cache-size = <1048576>;
>> +			cache-line-size = <64>;
>> +			cache-sets = <1024>;
>> +			cache-unified;
>> +		};
>> +
>> +		l3_3: l3-cache3 {
>> +			compatible = "cache";
>> +			cache-level = <3>;
>> +			cache-size = <1048576>;
>> +			cache-line-size = <64>;
>> +			cache-sets = <1024>;
>> +			cache-unified;
>> +		};
>> +	};
>> +
>> +	pmu: pmu {
>> +		compatible = "arm,armv8-pmuv3";
>> +		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
>> +	};
>> +
>> +	timer: timer {
>> +		compatible = "arm,armv8-timer";
>> +		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
>> +			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
>> +			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
>> +			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
>> +	};
>> +
>> +	firmware {
>> +		scmi: scmi {
>> +			compatible = "arm,scmi-smc";
>> +			shmem = <&scmi_shbuf>;
>> +			arm,smc-id = <0xc20000fe>;
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +			status = "okay";
>> +
>> +			clks: protocol@14 {
>> +				reg = <0x14>;
>> +				#clock-cells = <1>;
>> +			};
>> +		};
>> +
>> +		psci {
>> +			compatible = "arm,psci-1.0";
>> +			method = "smc";
>> +		};
>> +	};
>> +
>> +	cis-bus {
>> +		compatible = "simple-bus";
>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>> +		ranges = <0x4f200000 0x0 0x4f200000 0xc00000>;
>> +
>> +		gic: interrupt-controller@4f200000 {
>> +			compatible = "arm,gic-v3";
>> +			#address-cells = <1>;
>> +			#size-cells = <1>;
>> +			#interrupt-cells = <3>;
>> +			interrupt-controller;
>> +			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
>> +			reg = <0x4f200000 0x10000>, /* GIC Dist */
>> +			      <0x4f260000 0x100000>; /* GICR (RD_base + SGI_base) */
>> +			ranges;
>> +
>> +			its: msi-controller@4f240000 {
>> +				compatible = "arm,gic-v3-its";
>> +				reg = <0x4f240000 0x20000>;
>> +				msi-controller;
>> +				#msi-cells = <1>;
>> +			};
>> +		};
>> +
>> +		smmu: iommu@4fc00000 {
>> +			compatible = "arm,smmu-v3";
>> +			reg = <0x4fc00000 0x200000>;
>> +			interrupt-parent = <&gic>;
>> +			interrupts = <GIC_SPI 1 IRQ_TYPE_EDGE_RISING>,
>> +				     <GIC_SPI 4 IRQ_TYPE_EDGE_RISING>,
>> +				     <GIC_SPI 8 IRQ_TYPE_EDGE_RISING>,
>> +				     <GIC_SPI 2 IRQ_TYPE_EDGE_RISING>;
>> +			interrupt-names = "eventq", "gerror", "priq", "cmdq-sync";
>> +			#iommu-cells = <1>;
>> +			dma-coherent;
>> +			status = "disabled";
>> +		};
>> +	};
>> +
>> +	coss-bus {
>> +		compatible = "simple-bus";
>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>> +		ranges = <0x4a000000 0x0 0x4a000000 0xff0000>,
>> +			 <0x4e000000 0x0 0x4e000000 0x1000000>;
>> +
>> +		uart0: serial@4a030000 {
>> +			compatible = "arm,pl011", "arm,primecell";
>> +			reg = <0x4a030000 0x1000>;
>> +			clocks = <&clks 0x9a>, <&clks 0x9a>;
>> +			clock-names = "uartclk", "apb_pclk";
>> +			interrupt-parent = <&irqsteer_coss>;
>> +			interrupts = <264>;
>> +			status = "disabled";
>> +		};
>> +
>> +		uart5: serial@4a060000 {
>> +			compatible = "arm,pl011", "arm,primecell";
>> +			reg = <0x4a060000 0x1000>;
>> +			clocks = <&clks 0x9a>, <&clks 0x9a>;
>> +			clock-names = "uartclk", "apb_pclk";
>> +			interrupt-parent = <&irqsteer_coss>;
>> +			interrupts = <269>;
>> +			status = "disabled";
>> +		};
>> +
>> +		uart6: serial@4aa30000 {
>> +			compatible = "arm,pl011", "arm,primecell";
>> +			reg = <0x4aa30000 0x1000>;
>> +			clocks = <&clks 0x9a>, <&clks 0x9a>;
>> +			clock-names = "uartclk", "apb_pclk";
>> +			interrupt-parent = <&irqsteer_coss>;
>> +			interrupts = <270>;
>> +			status = "disabled";
>> +		};
>> +
>> +		uart7: serial@4aa40000 {
>> +			compatible = "arm,pl011", "arm,primecell";
>> +			reg = <0x4aa40000 0x1000>;
>> +			clocks = <&clks 0x9a>, <&clks 0x9a>;
>> +			clock-names = "uartclk", "apb_pclk";
>> +			interrupt-parent = <&irqsteer_coss>;
>> +			interrupts = <271>;
>> +			status = "disabled";
>> +		};
>> +
>> +		irqsteer_coss: interrupt-controller@4ed00000 {
>> +			compatible = "nxp,s32n79-irqsteer";
>> +			reg = <0x4ed00000 0x10000>;
>> +			interrupts = <GIC_SPI 527 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 528 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 529 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 530 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 531 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 532 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 533 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 534 IRQ_TYPE_LEVEL_HIGH>;
>> +			interrupt-controller;
>> +			interrupt-parent = <&gic>;
>> +			#interrupt-cells = <1>;
>> +			clocks = <&clks 0x9a>;
>> +			clock-names = "ipg";
>> +			fsl,channel = <0>;
>> +			fsl,num-irqs = <512>;
>> +			status = "disabled";
>> +		};
>> +	};
>> +
>> +	fss-bus {
>> +		compatible = "simple-bus";
>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>> +		ranges = <0x5b490000 0x0 0x5b490000 0x1000>;
>> +
>> +		usdhc0: mmc@5b490000 {
>> +			compatible = "nxp,s32n79-usdhc";
>> +			reg = <0x5b490000 0x1000>;
>> +			interrupts = <GIC_SPI 472 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&clks 0x58>, <&clks 0x50>, <&clks 0x5f>;
>> +			clock-names = "ipg", "ahb", "per";
>> +			bus-width = <8>;
>> +			status = "disabled";
>> +		};
>> +	};
>> +};
>> --
>> 2.43.0
>>

