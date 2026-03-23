Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010051.outbound.protection.outlook.com [52.101.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8535E1A2C0B;
	Mon, 23 Mar 2026 09:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774258055; cv=fail; b=LO3mXy5wo1smhz2APxY63g0WA5QzYimpKZVXAlPuiQiHZ3pcMMsqNQfSWUkGdR9kUXb+if8jomnqiqyvWf/2lx4rSEziJOpwgdmDgH0xgGex0dj62eZrXq6xbe3vpfN0PObTL3QBXKBMrZcDPu6cUFKmyvsvc+5jY/NhLJjOE64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774258055; c=relaxed/simple;
	bh=nnA3BZvTYRCiSHHthtZtEc28Mq9BER3O+cFzfSphglc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hIPsdURf9JbpjazEjiXmisIcTVR9G58PJtJu842g1Ly2/o/c+/L2q9uEOWpqC3qLRPtJedlV+prHAfDVUEPvTlzr2nzoZpWev/1FuDhsyO/1FWvAdzMyYY8LdRDEmAJ4P9kxHCnYVhtk4CGn46oAAdk4qbJmodzj574xFeTMVT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BU4B/oUU; arc=fail smtp.client-ip=52.101.193.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BU4B/oUU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mrGaqVPjKCpyqC7EPRiycIKTBs/UqwnFnPEBEe1OTGsJ8Qa+KnWhGh84H6kXdJI1ES2ayrUF3nIFrsc5lfiSRrEDKh+C1EQefC4WAfzVXqscvRES/iv+oaGQ4Nu0KKui3NMBA6J1ywfbR5RqYmBWwFvvW+6rr2EJXOvW0WUIyn9UN9fP0NEBz1nZtD3IO+xZ3l/2DcCWtk2aZKjCKn5sOkNZMpR3ismnwZTAO9KANCXI2zijOYwB8kPUbIaTxRiEssfeExIeipkSfOMU3vrg+LwksPPgm0LT4wp2FmarWG8cHx448XqjVLjtPmlUZ+4X1zw2wgg6vmUp5npWO9Srtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uD1Ur98OBIVkP+cWTnejfae5qx6F1NscRxQUtEKUuQI=;
 b=gIOqNYfwGO3RwiP896AoPT/cpx/ANBfWRvygDveM8PukNtmqDq3n9kR63eiUX1BrNsY6luHqedEXOAkDmHbo4IuMk2d1hl+JJ9soppwgbrnOjeBsLj7Beh0Tf8Dotm1xzaDcSAQT6jEtNfWuFd7CuCjLMcw98tJfI3spZRZRhOsUzuw4sEFgHa1PcC2VFL94ptpIXl+ZEif7KpJjjMlobdYyV7Oe9wKXxq3P1Eq4yY7kYYVycb7SoO8gDCbDGMP8NbVUlAVJEdUl+YXEl34l6Niun9yFrHvpszbpWI/n4i9GxcF9Fp+qA325SPPVgVCJq+gB/DuhC5ttb2ubUtX/rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uD1Ur98OBIVkP+cWTnejfae5qx6F1NscRxQUtEKUuQI=;
 b=BU4B/oUUGB0e92Jcnp96cHu+7xIr7t8VWLlgnVpfldMSqknV+X7EViMCT/wrvrpkzzmBNeaon4NK9GhM/FHKLX/gPYxJn7TyaJ7xU2wja+WBZgunkByM9E33Oi4BROHBnChe1hzhOFpoobxnMMTgHA8FLLdjBgDrJ7lId7ZORQY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8690.namprd12.prod.outlook.com (2603:10b6:a03:540::10)
 by SN7PR12MB7024.namprd12.prod.outlook.com (2603:10b6:806:26e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 09:27:30 +0000
Received: from SJ2PR12MB8690.namprd12.prod.outlook.com
 ([fe80::18c4:be41:febf:7e45]) by SJ2PR12MB8690.namprd12.prod.outlook.com
 ([fe80::18c4:be41:febf:7e45%6]) with mapi id 15.20.9745.012; Mon, 23 Mar 2026
 09:27:30 +0000
Message-ID: <844991dc-870c-47aa-8a58-a83645d35029@amd.com>
Date: Mon, 23 Mar 2026 14:57:24 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: sdhci-of-arasan: Use standard mmc_clk_phase_map
 infrastructure
To: "Simek, Michal" <michal.simek@amd.com>,
 Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1773713843-118137-1-git-send-email-shawn.lin@rock-chips.com>
 <dbeaa75f-7ba3-4dfe-b4e6-1395ea699d65@amd.com>
Content-Language: en-US
From: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
In-Reply-To: <dbeaa75f-7ba3-4dfe-b4e6-1395ea699d65@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0217.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1f3::8) To SJ2PR12MB8690.namprd12.prod.outlook.com
 (2603:10b6:a03:540::10)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8690:EE_|SN7PR12MB7024:EE_
X-MS-Office365-Filtering-Correlation-Id: 0312fe37-63ee-4852-1ed0-08de88be679a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|22082099003|56012099003|18002099003|7053199007;
X-Microsoft-Antispam-Message-Info:
	Qhd0LPMWq2E3YKNTUTqFQoEiJL6zk+sLotRe7cFXzNna9VuJ1NXtaM2bycUUojd3HLa0OIpBnQ4Yw9QyFfbV7isbXVihOmBDyxJDdWFQcUKUF/riZrOjY2dvFQI7jxxj2r+uxvMBhnP78IQf2r9DuWxmwnikncT169DAnFiuYt0AO8oBVSJrkrQM4AyFj6ks9S1It9IqXqleADSNlqTxqnxb9JNOmfswItRFiwf1CagS5N8c4iDVxVjJq7TnuKbOKHd3JGYyyvNXmixKg46UWbXiQji9H/vSfINMmyM74K8DofpvY5pdqU2NvfyEjiKCED7j1dGsc6mkJu+5zqdCetw03HhiF1VjIU1v+w/eWIa2ixfGdpL+I87kHZgdDS+IqObcyhtAwpNCdZoXOwxR1s6/0NNU08SnxbVOlWHYkI9zqXJA7DVo93fBSPigBBtwAEVthzHq0xKo7Qnh6KyAq9ckaOpRLmn43WLHASG+MmLfjMH2lR1zFckj0JCSFboTCmBvfreSqEtVsu4Qya7mYlIsO9AFMGYxjiQYcoM7fBaEO3AySe2uDblKqAUi/7nw39UUk8szoRd8O3H49ph5P5FrIwF6w7kf/a7DULi+ay0mDIqXWnaHR0OvvkKupsjxmXAce4kdTSctLj6DvT+89QVbrZrQJLPqlHKp5DdS/KhbJvjPggQUnlhRFiCo9tVa1KU7tjiw5C04L27tcLtTfquoncd1b75o3p9RcF1APQk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8690.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(56012099003)(18002099003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RXc5ajdaOUsycDB0bm0ydEx1TzNlUTJrRGo3REJVWG9sNEkrcGhZOUdGU1pZ?=
 =?utf-8?B?M1luVlFmZEdnMkdFNHE2bFBZckJQWDNUaXdVdTZDTHY4OVFjaGlaVVNuZU5Z?=
 =?utf-8?B?R0pkTlFKZ0hoSjk5b1drdmpHc0xidFYvUlpOZFc3UkptOUZqSUxYaFplM0M5?=
 =?utf-8?B?SW1pT0o4ZlFadW5EZVVYT1Z2eW9JdWM2NHkvWHJIV1J4ZnNkbFh1TkM0SWpn?=
 =?utf-8?B?czNnMjE3eVMwUVk5TTV6T0w3aVNoNjVYYzRJRlFNbkplaXF3WWdDaXNtUEEv?=
 =?utf-8?B?SG81SXpsVHRBb1hzOHdqL3hNbHBRZmZUcVpyWDAvc3VVRjBaZC9OSktyMWhQ?=
 =?utf-8?B?SllkbXBKOGQrdnJ0eWVUYmtNK3k4RjEwc3VxTmczczV1eEJMYUxJZzM3N09D?=
 =?utf-8?B?ZEo1cWhMd3dBVHl4c0dLcGR5WHNhL3NTTVZGZXAzZExKRDhyYTlqVndLZzVr?=
 =?utf-8?B?dXBnMkU1UVZSR096Y0NWWWVvZktCRy9qcDVUV3RLWHQ0MkVBUDNLNE9KZ3ZM?=
 =?utf-8?B?M2MyQzRJemFDTGtiQnc3bDdQdUw4N1lUUUhIU0lSRVZJejlSQjV6Um5GV2R6?=
 =?utf-8?B?c0VmRWY4WVpKTlZzV2IvQ1BaM25Cei9ydHgyTmZUdjM0dmhLQmdna1AwYzJK?=
 =?utf-8?B?WjQzb2F0ZzV0bE9XcmRFUjFjOWxLN3dna2hJWXNTb0p5NkNPMnNqM253Qmxi?=
 =?utf-8?B?UnZPTHc0YXR2ODlnRCswYnNTWG1peEdBK09FbElMT0U5MmQwMUF3MTJMUXhE?=
 =?utf-8?B?YWYvVTRpK0JlWXRxSjBlR1ZPR3ZGYXFyT21SbWtXTzBJNC85dDIzUWFueVd2?=
 =?utf-8?B?aG41NnM4bUNXVGVvOCt3T1dQeFVvVVpxbGJRczBVUnAvS2lNTWF1UmcyQ3Vm?=
 =?utf-8?B?MERZMklvM1J4SDFaVERuNmxCUGkyTVEwR2xGS2FYYnhoUEZ2R1h1NkFqbmFU?=
 =?utf-8?B?aUgyYmd3SnVkZVV1V0YrWUNqTXk1RHgvWThWdy9ZTHJWOXFmbVRyaXNLSER4?=
 =?utf-8?B?ekk2N3RZM2l6ckQ3a2xnZDkyMXRhL3VuSWg3L05lTVg0RHZROWtIZ1NFckpX?=
 =?utf-8?B?SVhZQnR3VzRTY0Q2eXJwRG9VbEFzaGFYRENYdkFzNnFTVlA3TElXc283aU0w?=
 =?utf-8?B?RkMzMW80amlJeHpjYWtlOGN6dDFEMmpGNjZ1cXE5RDB0Z3dNN2hiWjlPQWlD?=
 =?utf-8?B?K3pSempFRVBqaVlRQUJPL290elJpSXByUUEwUmlzYzlzNjhzakVZRjcyd1Q0?=
 =?utf-8?B?WUZDaWk2TFhIdktPc3dZa29hMVV1S2U1QmdoOUE4QUJzMmNXaDBJd2RvZWo0?=
 =?utf-8?B?N09rekw0cnFZWkdGeW1HVW56YW1OUTcvNjlCazc2SEp3RWZ1aC9tVDkyQjk4?=
 =?utf-8?B?cFV4Ty9DWDBlK0FjWGpEekxXckJ5VDJOaXRJOHFubkVzeGlpYmcyQytmVXl3?=
 =?utf-8?B?MTdCbjcycUoydWV4eWNXeStWZDBEZEJJWjdaK09ZWEpNUFJ4b2R1akloV0xo?=
 =?utf-8?B?blRPZlF0SGcrcjI3TndPOWpVTjdWUFlFVmlITmZHTDJWaGRqT2tPbWJCMlM0?=
 =?utf-8?B?cWVzYWQ3eE1yVUtiVlhCRThoV2d0MC9idmxsNDhNUHRlelZKMmQvUUFueWp3?=
 =?utf-8?B?d2pIdktWTWdFNGpxM2pwMFZBWGpSL2hWUU1mOWdvYUhkSzl0UWpMdUc5N2cx?=
 =?utf-8?B?SWpiTzNkU1ZMNW95Q1RSVUdlWEJUSTR2ZXVoODdFUk9Qam1YZktIK0dvOEU3?=
 =?utf-8?B?SStiUEVUbFh2YWMyYVhxVnkrSUJFZjQ3RUtOZG8wU0srRDd1YitlQ3NJaktE?=
 =?utf-8?B?SjRqQTJGUHVUSlhPa3lPdEo0ZzBnd2NMdG9Zd2I4WVRISk51a1VxSWx2MFJH?=
 =?utf-8?B?dlo2NW9LekphTlZyY244S1pwT0VBcENSUGF1L1hkeHlXaUdtRHVlRkh3TG5u?=
 =?utf-8?B?Y0ZVR0p3WlV3ZzZ6Tkk0d0lBZHExM29kR2txQ2JNNWlScGh0NzNmeTR3L2lF?=
 =?utf-8?B?ancvTEJiU1JJa0Y0alQ3YVRBNDRzYk9TNHBFOXVaOG42cUlQcDdmMGs1cnYw?=
 =?utf-8?B?azJhdWwvS0ZRTGo1eDBhWVlBYkM2TjVxWVpEalQvc214NzdSVFU0UWNSUi9v?=
 =?utf-8?B?Y3BIZUZsbkxnMEdXYjFEOU1OYmtndXl3SzZOL2hua3YvSVg2aTRvOWUwbmdQ?=
 =?utf-8?B?L1NZaHdKOC9EKzE2STNUZ0FvZCtyUDZWVi93SHJNS3lFc05FMzNVMGZiNUpv?=
 =?utf-8?B?clJCYnphYTVGd2JlSU50Y0MwTjFSKzJtTmRFTzdZNk92T1cwcEt2cElZKzlR?=
 =?utf-8?B?WHpJellNOHpYMmFySjFlRlQ2eFhRbFE4RWs2WVVnb0ZEYlc3ZDhOZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0312fe37-63ee-4852-1ed0-08de88be679a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8690.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 09:27:30.0008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ePvR2MvFt5lv17d4hHqzBnw2MjPgBRSkbRXKLfV7uq8n5x8YaXEe5Rq5WDNLfRXhQylqZarSWa6EA9lgfVbjsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7024



> -----Original Message-----
> From: Simek, Michal <michal.simek@amd.com>
> Sent: Thursday, March 19, 2026 3:39 PM
> To: Shawn Lin <shawn.lin@rock-chips.com>; Ulf Hansson
> <ulf.hansson@linaro.org>; Potthuri, Sai Krishna
> <sai.krishna.potthuri@amd.com>
> Cc: linux-mmc@vger.kernel.org; Adrian Hunter <adrian.hunter@intel.com>;
> linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] mmc: sdhci-of-arasan: Use standard
> mmc_clk_phase_map infrastructure
> 
> +Sai,
> 
> On 3/17/26 03:17, Shawn Lin wrote:
> > Convert the Arasan SDHCI driver to use the mainline standard
> > mmc_clk_phase_map infrastructure instead of custom clk_phase_in/out
> > arrays as well as arasan_dt_read_clk_phase().
> >
> > The phase values for ZynqMP, Versal, and Versal-NET platforms are
> > still initialized from the predefined tables, but now follow the
> > standard phase_map format with valid flag.
> >
> > Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> > ---
> >
> >   drivers/mmc/host/sdhci-of-arasan.c | 79 +++++++++-----------------------------
> >   1 file changed, 18 insertions(+), 61 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-of-arasan.c
> > b/drivers/mmc/host/sdhci-of-arasan.c
> > index caf9723..b97d27c 100644
> > --- a/drivers/mmc/host/sdhci-of-arasan.c
> > +++ b/drivers/mmc/host/sdhci-of-arasan.c
> > @@ -152,8 +152,7 @@ struct sdhci_arasan_clk_ops {
> >    * @sdcardclk:		Pointer to normal 'struct clock' for
> sdcardclk_hw.
> >    * @sampleclk_hw:	Struct for the clock we might provide to a PHY.
> >    * @sampleclk:		Pointer to normal 'struct clock' for
> sampleclk_hw.
> > - * @clk_phase_in:	Array of Input Clock Phase Delays for all speed modes
> > - * @clk_phase_out:	Array of Output Clock Phase Delays for all speed
> modes
> > + * @phase_map:		Struct for mmc_clk_phase_map provided.
> >    * @set_clk_delays:	Function pointer for setting Clock Delays
> >    * @clk_of_data:	Platform specific runtime clock data storage pointer
> >    */
> > @@ -162,8 +161,7 @@ struct sdhci_arasan_clk_data {
> >   	struct clk      *sdcardclk;
> >   	struct clk_hw	sampleclk_hw;
> >   	struct clk      *sampleclk;
> > -	int		clk_phase_in[MMC_TIMING_MMC_HS400 + 1];
> > -	int		clk_phase_out[MMC_TIMING_MMC_HS400 + 1];
> > +	struct mmc_clk_phase_map phase_map;
> >   	void		(*set_clk_delays)(struct sdhci_host *host);
> >   	void		*clk_of_data;
> >   };
> > @@ -1248,37 +1246,13 @@ static void sdhci_arasan_set_clk_delays(struct
> sdhci_host *host)
> >   	struct sdhci_arasan_data *sdhci_arasan =
> sdhci_pltfm_priv(pltfm_host);
> >   	struct sdhci_arasan_clk_data *clk_data = &sdhci_arasan->clk_data;
> >
> > -	clk_set_phase(clk_data->sampleclk,
> > -		      clk_data->clk_phase_in[host->timing]);
> > -	clk_set_phase(clk_data->sdcardclk,
> > -		      clk_data->clk_phase_out[host->timing]);
> > -}
> > -
> > -static void arasan_dt_read_clk_phase(struct device *dev,
> > -				     struct sdhci_arasan_clk_data *clk_data,
> > -				     unsigned int timing, const char *prop)
> > -{
> > -	struct device_node *np = dev->of_node;
> > -
> > -	u32 clk_phase[2] = {0};
> > -	int ret;
> > -
> > -	/*
> > -	 * Read Tap Delay values from DT, if the DT does not contain the
> > -	 * Tap Values then use the pre-defined values.
> > -	 */
> > -	ret = of_property_read_variable_u32_array(np, prop, &clk_phase[0],
> > -						  2, 0);
> > -	if (ret < 0) {
> > -		dev_dbg(dev, "Using predefined clock phase for %s = %d
> %d\n",
> > -			prop, clk_data->clk_phase_in[timing],
> > -			clk_data->clk_phase_out[timing]);
> > +	if (!clk_data->phase_map.phase[host->timing].valid)
> >   		return;

This check breaks platforms relying on default phase values. When DT
properties are absent, mmc_of_parse_timing_phase() sets valid=false,
which causes sdhci_arasan_set_clk_delays() to skip phase configuration.

Regards
Sai Krishna

> > -	}
> >
> > -	/* The values read are Input and Output Clock Delays in order */
> > -	clk_data->clk_phase_in[timing] = clk_phase[0];
> > -	clk_data->clk_phase_out[timing] = clk_phase[1];
> > +	clk_set_phase(clk_data->sampleclk,
> > +		      clk_data->phase_map.phase[host->timing].in_deg);
> > +	clk_set_phase(clk_data->sdcardclk,
> > +		      clk_data->phase_map.phase[host->timing].out_deg);
> >   }
> >
> >   /**
> > @@ -1315,8 +1289,9 @@ static void arasan_dt_parse_clk_phases(struct
> device *dev,
> >   		}
> >
> >   		for (i = 0; i <= MMC_TIMING_MMC_HS400; i++) {
> > -			clk_data->clk_phase_in[i] = zynqmp_iclk_phase[i];
> > -			clk_data->clk_phase_out[i] = zynqmp_oclk_phase[i];
> > +			clk_data->phase_map.phase[i].in_deg =
> zynqmp_iclk_phase[i];
> > +			clk_data->phase_map.phase[i].out_deg =
> zynqmp_oclk_phase[i];
> > +			clk_data->phase_map.phase[i].valid = true;
> >   		}
> >   	}
> >
> > @@ -1327,8 +1302,9 @@ static void arasan_dt_parse_clk_phases(struct
> device *dev,
> >   			VERSAL_OCLK_PHASE;
> >
> >   		for (i = 0; i <= MMC_TIMING_MMC_HS400; i++) {
> > -			clk_data->clk_phase_in[i] = versal_iclk_phase[i];
> > -			clk_data->clk_phase_out[i] = versal_oclk_phase[i];
> > +			clk_data->phase_map.phase[i].in_deg =
> versal_iclk_phase[i];
> > +			clk_data->phase_map.phase[i].out_deg =
> versal_oclk_phase[i];
> > +			clk_data->phase_map.phase[i].valid = true;
> >   		}
> >   	}
> >   	if (of_device_is_compatible(dev->of_node, "xlnx,versal-net-emmc"))
> > { @@ -1338,32 +1314,13 @@ static void arasan_dt_parse_clk_phases(struct
> device *dev,
> >   			VERSAL_NET_EMMC_OCLK_PHASE;
> >
> >   		for (i = 0; i <= MMC_TIMING_MMC_HS400; i++) {
> > -			clk_data->clk_phase_in[i] = versal_net_iclk_phase[i];
> > -			clk_data->clk_phase_out[i] =
> versal_net_oclk_phase[i];
> > +			clk_data->phase_map.phase[i].in_deg =
> versal_net_iclk_phase[i];
> > +			clk_data->phase_map.phase[i].out_deg =
> versal_net_oclk_phase[i];
> > +			clk_data->phase_map.phase[i].valid = true;
> >   		}
> >   	}
> > -	arasan_dt_read_clk_phase(dev, clk_data, MMC_TIMING_LEGACY,
> > -				 "clk-phase-legacy");
> > -	arasan_dt_read_clk_phase(dev, clk_data, MMC_TIMING_MMC_HS,
> > -				 "clk-phase-mmc-hs");
> > -	arasan_dt_read_clk_phase(dev, clk_data, MMC_TIMING_SD_HS,
> > -				 "clk-phase-sd-hs");
> > -	arasan_dt_read_clk_phase(dev, clk_data, MMC_TIMING_UHS_SDR12,
> > -				 "clk-phase-uhs-sdr12");
> > -	arasan_dt_read_clk_phase(dev, clk_data, MMC_TIMING_UHS_SDR25,
> > -				 "clk-phase-uhs-sdr25");
> > -	arasan_dt_read_clk_phase(dev, clk_data, MMC_TIMING_UHS_SDR50,
> > -				 "clk-phase-uhs-sdr50");
> > -	arasan_dt_read_clk_phase(dev, clk_data,
> MMC_TIMING_UHS_SDR104,
> > -				 "clk-phase-uhs-sdr104");
> > -	arasan_dt_read_clk_phase(dev, clk_data,
> MMC_TIMING_UHS_DDR50,
> > -				 "clk-phase-uhs-ddr50");
> > -	arasan_dt_read_clk_phase(dev, clk_data,
> MMC_TIMING_MMC_DDR52,
> > -				 "clk-phase-mmc-ddr52");
> > -	arasan_dt_read_clk_phase(dev, clk_data,
> MMC_TIMING_MMC_HS200,
> > -				 "clk-phase-mmc-hs200");
> > -	arasan_dt_read_clk_phase(dev, clk_data,
> MMC_TIMING_MMC_HS400,
> > -				 "clk-phase-mmc-hs400");
> > +
> > +	mmc_of_parse_clk_phase(dev, &clk_data->phase_map);
> >   }
> >
> >   static const struct sdhci_pltfm_data sdhci_arasan_pdata = {
> 
> please take a look at this patch.
> I was talking to him yesterday and he needs to finish two things before he has
> time to look at it. That's why please give him some time.
> 
> Thanks,
> Michal

