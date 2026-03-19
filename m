Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013071.outbound.protection.outlook.com [40.107.159.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D65322533;
	Thu, 19 Mar 2026 18:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773946689; cv=fail; b=CYpm7lufhlk0gPjlXXG/3Iap1oFldkmd07qmkqMAOQbCDfZAaGQRbOWS0FZxcGtiB9Qa8ak/GAbroj1DY0gz6rs6KFmlF2vZD2F1143BpkQzD48wCIXETHy7zjhLO2u9gk+cFLKErcE2oHkNl6Q33OAgy8VD6UiAp3FNncAsvXg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773946689; c=relaxed/simple;
	bh=dfU4ImpyGVwho3SQEDGL2fLHMEl0retmjRpbQ28/oL8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sVj7kRM6o6jS0F1SGRk6Fyx+sA+/vHEPf4LGeEKIOt6NeKtWB63iXD+7dFbhuRmpJxzu02xgIjhuD/bF0BPHoLJONKOWYJv1lDucEyrwQAiIG7VIxJgdopgraO9vdNvLbbyyzBLdpcDEMnveenTOPqKRdr0W4cJY/swHC1AFIIA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bR7h1tmV; arc=fail smtp.client-ip=40.107.159.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bR7h1tmV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KbeqD48ehqYG49WK53V/77Cgon3OSxj6khPjby+fISAY0umXQx5qfLzSQudflZ4wukKWotpHpeNGiAjySce3rT6ThIXjojn51tiOazU3uxES3oBavU2CI33uHL/sgJ2QwsR8DQjeYbJG/Etd7cO4fc/0gVl0o0MQhLi3fe2iz4js21PYNwMg1AjiyfF17u+tkZU8ifyH6YTTS4NipWsNaxkACHiekTamug+NhgI/tzJKc2pjtOE6mVmOdUJtrBSDpBcYHckwTJNIF4C/vGeXPB/7hHzg9CO6Rb8Eas4PSBvrVMqWtAjSc5gjnlgTSF6ibO2yJWYMqjHGTiP1PvTnCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OSvHn6cNdODq8IL0bfof4+dfo59RrTT4g60WU2ybMlY=;
 b=EzKck/Kp1jygBk3yeqoT9mVdEJ6KjsUft80BZ/ObiJGnkjZfFGVEzew7cGIfZxOwwkgiViY/u0WO4N37unAI27a93jpJ5gvp2r8cAAZVUjqPpeyHJsUEmzn+aHQMqG5vwryVMj4QtHI2jm8TmPXuRfJMpFhZ2EwQMKo2AL1t0FTrBxub/hEDsJUXaTl0KnQHzxfSHmhzyZmM+EOgKO2tW4g2eDcL51IWOTfsrNnFw7oQw0HYG/jqV8fj4Ccrod1DkHfWNerjJNnrxvIqup782TkgYZN/IkXe1AGNq6LM1SN4jUDt6IO3IXb7IQSnbDIWOSCe6V1C3Ng5YSGSAxAR7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OSvHn6cNdODq8IL0bfof4+dfo59RrTT4g60WU2ybMlY=;
 b=bR7h1tmVqjCVsUwVU46A1c2qQ2VhiEOeYrxoBKHx0CipgxVUbwu/y4SVu748JUtE12ZVn4RDZidt+FdcsG/7Rq98iP3oLAqyp60w7/1THTBJt/S5PFbFn7YJUSbb6UNpl2nz2uWACa7ihLTNSnfWqT7UbX7QrjyXFhw8A7Y9MOG79CJEG79Mqz2J+BTcnJpx/8hAAQXhMmNTQohlYpB8Qj3uBPYAIegDmmy1hHv4W4A/5Th7MTbwkNYHAzQZeKxgoWuYfKz9Z2ofv31q4e6675p7drG/dJk/FTq41SFAvPstockrhoTLf35a/Ggqz114tlCnrAaHdq19Mg/lzUDMFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9255.eurprd04.prod.outlook.com (2603:10a6:102:2bb::13)
 by VI0PR04MB11889.eurprd04.prod.outlook.com (2603:10a6:800:305::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 18:58:03 +0000
Received: from PAXPR04MB9255.eurprd04.prod.outlook.com
 ([fe80::1eb5:3ebc:9f11:f20b]) by PAXPR04MB9255.eurprd04.prod.outlook.com
 ([fe80::1eb5:3ebc:9f11:f20b%4]) with mapi id 15.20.9723.018; Thu, 19 Mar 2026
 18:58:00 +0000
From: jeff.chen_1@nxp.com
Date: Fri, 20 Mar 2026 02:55:57 +0800
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
	johannes@sipsolutions.net, wyatt.hsu@nxp.com
Subject: Re: [PATCH] mmc: sdio: add NXP vendor and IW61x device IDs
Message-ID: <abxGvaylqulUeN8N@nxpwireless-Inspiron-14-Plus-7440>
References: <20260113031517.244714-1-jeff.chen_1@nxp.com>
 <CAPDyKFp0+70OSrW_zrV+-fdr-BUScKkyNzTHkN==+9k52Z5j3g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPDyKFp0+70OSrW_zrV+-fdr-BUScKkyNzTHkN==+9k52Z5j3g@mail.gmail.com>
esFrom: Jeff Chen <jeff.chen_1@nxp.com>
X-ClientProxiedBy: FR4P281CA0153.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::14) To PAXPR04MB9255.eurprd04.prod.outlook.com
 (2603:10a6:102:2bb::13)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9255:EE_|VI0PR04MB11889:EE_
X-MS-Office365-Filtering-Correlation-Id: cb6c1941-0853-4757-61a3-08de85e9713a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|19092799006|38350700014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	t1adSCjfAWxpcXC1chy/o/9YasT3dlCIXSnbUQDGIhHNXNck32LacAQNRhRFFSiF7ZJ4UluNll+bWHDHwe91uRqlAOA9uyDeI+Mp76JpbP/m7K4eXOf7iiQKSUZcjUtRT7xfHujs0pjPNEm7S+l8o6c9mwLxAfGJH6XhBVLpqwDTYsTdEgiYwbn0P+W4JBkf3+eRo4jhvH0oSWEwC1ka+Y8O6XLtc6/4UxJRK9wYJ5IOQZp5SFYR1YVlqpASO9iDkN/trzrqZ9macpRaEiWc566uLNHLJgI3cTlGSYLttW0HMqSfXBFaugis9NNdk2eAAKW3b5VvTGTMfoJusDwCqZbvGNvNDOVaF9NnKMq4ortd+ig4TZyh2Emh2twbAJ3JGM22b8efsKcEHzAecJEbIkBQdC8wmoBo5QEGtGYBxuMM1G0msc8eHIS/FnjSq0Oj7WdweMQ3eYikSfwLLCZOMjpXISmzW8ajtb/aBd6G8qgUyiNiEzjpBFG0Wf7fl2zSW93FZP2EtmDA2xZp5Y6MQsIllQZVwVNFP1ReB+MM37qDDffYMh8fU6Z64bo9A/V/FZaRSiPeluiFZnQa6oQ/usGSiWeHFWRx1LU5Pd7h3F8ZM9qNJn5xxfyd2oQuAjuyuQoTqL4dEWNrEnsYqt4AyMu4g4XvgkHpsIYWyJ/vswKlu3YvtsXI6JC/cqmXIj6OCbTUwgNkM6EpT5j1shczmKFupH26i3/PUHAHiwVuVGzD0larRXyJBg5dceOsbgiuhO3wHTBuiDHG+FTFbyy19OWbezcMAj56hxu0bDQkMBM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9255.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(19092799006)(38350700014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cEQwUGtDSHVxRjFhMXR6UU5RaHZTK1RscFB0QU5Rc1F2VVFtTmVCZjViZE5G?=
 =?utf-8?B?MUVzSFBwNUVzQTR5cEl2TDVqZkg0aHhBV2hhdm1kSW5YWjFLMlFwa3pyRkxm?=
 =?utf-8?B?dzJidDNzTlM5WnZUZlpOVjJZYTJibVZ2U3JXT1lobDQzOTM2RkEzVnFhaXp4?=
 =?utf-8?B?RDBjTXFIcmE3ckYxU1B0SDRvdGpOeWVlS0toZ0lyZVo0MlZ3bVJxbGQ5c1Zm?=
 =?utf-8?B?NFdDQ0kxaysvUGpUL3dsQWF2cUhNa1VPWmN1anhyRHhPSDJEeWVlZ0RqV2Jx?=
 =?utf-8?B?YzkzNVJlTlA1NTYrVmlhV0Y4S1JpQkJicDZYMDVXbE5VcTcwVXdoWnhuME9r?=
 =?utf-8?B?ZWhCRExrMkRzS2wvTGFuU2Z4aEhZWnVkNXowaUxLd0h2bzZ0NS82Y0hNaVl3?=
 =?utf-8?B?Ky9ZbG4yV0kvYUd5VWR4Z3Rlck0rYjVRWmRHZHZlYjNTanRGeUhMaFBoZkVP?=
 =?utf-8?B?Uy9Gd0xGd29HVmw3ZUJmN1E0Z0pDbml0NGFvam5JWlVzUXpLSXRMYWxQT1Zy?=
 =?utf-8?B?ZDNZSzNsRy9LamF5QWlIdG1YcnZ0aG0rVkRJQkt0U2FNazljclJuSU1EQzBY?=
 =?utf-8?B?Z2lOMHRndy9aWkpUc2ZScWNJMTVaMjd4TUo4N29wR1NVaVFhZmpLZmJiUCti?=
 =?utf-8?B?RGNrK3JROVhtcDl1WlIrd3EyTU4yVVR4cEl3aUMxRWdiVlZtaDRETHlJZ2FD?=
 =?utf-8?B?ay9aaFhQc3ZId0xSeGxidWZNazRXZW5MQzUxSVhPZ1F5cEFrTE1OUFR4ZUNT?=
 =?utf-8?B?a1M5WCtZZzcyaERnRXByWjhWMFlDNS9Ha1pwNGh2OHJURm5wMStRZ04weHYv?=
 =?utf-8?B?d0d4aThkb1U1aXg5bjQrdW1VRmxnOERpVnFvQkpheHpJUk92cWd0WnA3aTFV?=
 =?utf-8?B?TnNraEpBRXU5VUZLbmFKbmxrbysrZFVuRFA0alFLMmFGZHFmZGVMb2ViTVVn?=
 =?utf-8?B?UUNSV1FSTGhIWjZseWxIQURUUzR6SlV1YVpqMFJCK2tiaEVWSERKMXBpYVhl?=
 =?utf-8?B?aVg2S0FkR3g5eGhYSmFja2xrWjMwc2pyb0FqQ1BLZ0hhUkFtOWE5TkFDMkE2?=
 =?utf-8?B?dXFkRzFDMU4xemp6MER0ZVMxRUVlQXl1YUVIRjZiYW9EN3pLZUtLeHlSZXNh?=
 =?utf-8?B?NGlyM0R0eVhVYlo0Zjl2V0cwbDl1dllaSllQQlhwbC9EQ3hTM3UvMmdsT1Z0?=
 =?utf-8?B?bU9OWVN5dVF4VTF2VjhhM0Ivd1NSdTZSTnBDWGE0L1Q4RitYNlh4ZHJyUGh6?=
 =?utf-8?B?RkdLRkdZeEZKWlkrV2ZiaE5jbzZNdDg4dVk0NXdoUkpxVitEbTAvMjZsZmZu?=
 =?utf-8?B?VVlaSjdmWUVuWkJGdTZwSHFjOEtuMlNVMkI0TEdtaXJ6ZndNa3FkTjdSbk14?=
 =?utf-8?B?ZGFWd3NLVDJOMUZWYnduVnpkaTZDQTBRcmxsdDdkNW45V2xhR1pudE1Dbm5Q?=
 =?utf-8?B?ak9wM0UxVGNoN2VlbHA4eWo1ZnFTaWNNUCtYVGlMTWZDdThhNWdvY3JFOGFq?=
 =?utf-8?B?VEFvTHJhdkNva1VOUzR1RmxsSE40a0IvOEZpRkRSVkhQcTF4c0NWOWRQZ1F1?=
 =?utf-8?B?MXBoYXFaT3BJTTBicVV1eUdDOG9OTmlXSTkyaFRQY2gwY2hVZ1FyZ2g3dFpz?=
 =?utf-8?B?RFlsSEtmWFdGOHRrK3k0bldTMXp4N0JsV2JBZWVBNnFiaUQ0Y0MwdTRrMEx4?=
 =?utf-8?B?dTJNRzdYUHdCbVp2TDBSOG1pWTlLbjVra3NVNWU2WGMvbzh6ZDkrUXhkbVRy?=
 =?utf-8?B?MGE2MzYyeFFNZitpbDRrdEVYR3N4eVR3V3M3bGN2TEFBc1FkRzF5SHRIQ0Jv?=
 =?utf-8?B?cFBvY3RxUlhwdHdJK1F2U1ZScDBiUDEzMVpPNUNCSlY0OGNoZURTVGd3TGdF?=
 =?utf-8?B?YytKOHp2ZG5HNWs4MUZ3Zjl5RHZqTDZoVkU4Tm9POEhjMjN1ZWdoL21jUVdZ?=
 =?utf-8?B?L25vTnVwVGswVHlBaGJlYmtKd21SUFJtOW5oenl1MFVtSUpxeXVUUkl6OUFR?=
 =?utf-8?B?MVdmWkdaemI2bDZxTkh1TnM5czhBNkY3OFhFK01RUk1Sck9nMExIazRYdjB3?=
 =?utf-8?B?Ym5Da1NpZkI4ZjJvYnNkWEhWU004Q1ByRlFqa3oxQWJDZ2t3SjZKZktHbms3?=
 =?utf-8?B?aXJzV2MraFBKN3BidWRtV1puM0tmU1dUZy9KQ3JDSHVwQzQ2VkxVOFg1eHMy?=
 =?utf-8?B?Q25jM2NpdTBndXl2WWFuaHNVYnBiaUFqTWkrLzNUY1RQZUErdUVYNGlTSFpp?=
 =?utf-8?B?MXErbUVPU1JzQTBJZzNNcmtoVW1zUFUvaUVRS2xaalYyN3d6SGxYWXRFTHJx?=
 =?utf-8?B?RVRJY1JVTEtRSndWdCtobDJyLzVEdXIvTUwrSTFyUG0wNHlncG5FUT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb6c1941-0853-4757-61a3-08de85e9713a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9255.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 18:58:00.8250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zHdX71Xoum7PaRVa2mV4V8xvlsimEP5vcfzv46hSrCo+yh3nUVRjJcRh4Sku92LsNL71Ga1sY+IPcPiXqgDY6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11889

On Thu, Jan 22, 2026 at 07:03:19 PM +0100, Ulf Hansson wrote:
> On Tue, 13 Jan 2026 at 04:16, Jeff Chen <jeff.chen_1@nxp.com> wrote:
> >
> > Add NXP's SDIO vendor ID (0x0471) and IW61x device ID (0x0205) to
> > sdio_ids.h for future support of NXP Wi-Fi chips over SDIO.
> >
> > Signed-off-by: Jeff Chen <jeff.chen_1@nxp.com>
> 
> Applied for next, thanks!
> 
> Kind regards
> Uffe
> 

Hi Ulf,

Thanks for applying the IW61x SDIO ID patch to mmc-next.

May I ask when you expect this patch to be queued for mainline?  
The reason I ask is that the nxpwifi driver is currently under review in
wireless-next, and without these SDIO IDs available in mainline (or in
wireless-next), the nxpwifi series cannot be built by itself. This
blocks further review and testing on the wireless side.

If the patch is not expected to reach mainline very soon, would it be
acceptable for you to temporarily drop it from mmc-next?  
In that case, I can include the SDIO ID addition directly as part of the
nxpwifi patch series submitted to wireless-next (and keep your Ack), so
that wireless-next can build cleanly during review.

Please let me know which workflow you prefer. I’m happy to follow
whichever option fits best with your merge plans.

As discussed earlier with Johannes:
https://patchwork.kernel.org/project/linux-wireless/cover/20260305143939.3724868-1-jeff.chen_1@nxp.com/

Thanks again for your help.

Best regards,
Jeff
> 
> > ---
> >  include/linux/mmc/sdio_ids.h | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/include/linux/mmc/sdio_ids.h b/include/linux/mmc/sdio_ids.h
> > index 673cbdf43453..39ac2b612e4a 100644
> > --- a/include/linux/mmc/sdio_ids.h
> > +++ b/include/linux/mmc/sdio_ids.h
> > @@ -116,6 +116,9 @@
> >  #define SDIO_VENDOR_ID_MICROCHIP_WILC          0x0296
> >  #define SDIO_DEVICE_ID_MICROCHIP_WILC1000      0x5347
> >
> > +#define SDIO_VENDOR_ID_NXP                     0x0471
> > +#define SDIO_DEVICE_ID_NXP_IW61X               0x0205
> > +
> >  #define SDIO_VENDOR_ID_REALTEK                 0x024c
> >  #define SDIO_DEVICE_ID_REALTEK_RTW8723BS       0xb723
> >  #define SDIO_DEVICE_ID_REALTEK_RTW8821BS       0xb821
> > --
> > 2.34.1
> >
> 
