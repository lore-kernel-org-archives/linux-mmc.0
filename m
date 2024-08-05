Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11010002.outbound.protection.outlook.com [52.101.51.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8506416DC0B;
	Mon,  5 Aug 2024 22:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.51.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722898615; cv=fail; b=kYYrt7j/mDJXePYA5NKUP78PhWSJIyPMF2tJ2Bi1RU2fyOUAQtc6Hyo1EUfO2AejqRQyNtY79p0tMgtxtkPWrZVPfVJSX2Qu6eF+JoaxyksfcJoDXQdrML91CP/LM4VwL5hZumGwA4F14ksij2OrABPRtxflgStMvsjMA2W9X5U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722898615; c=relaxed/simple;
	bh=Cu/4ywuK3faai2DokcViqbGZK4TzI4ossmEGSIKuaf0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=t4uPVcmbembry3WhY1WTLGyrKi7uZj45CTlhoZFUUKaVnxYekd8DUdL9ee/PnPYF/FTZNjC7abwLno5xgX2QUtCQoOYTPtF3waSsCRyf4SnfuntV2FXWrZGFXq0nwZd61MgCbN2veEMDRzwcKxspyHDNNYK7BTRE9SO+3+CPCwM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ni.com; spf=pass smtp.mailfrom=ni.com; dkim=pass (1024-bit key) header.d=ni.com header.i=@ni.com header.b=XUdSkxi0; arc=fail smtp.client-ip=52.101.51.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ni.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ni.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ni.com header.i=@ni.com header.b="XUdSkxi0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V1erAVaoT/iZS5FFfSseyyajCL4wRzDdhtNlPXosXpkyhphuyIsc3XI9ct375vbs8zdUPX3dC6s+G8+i920f2u13v89MpOBQYLE9XcNtI0mkrqkz1cUftlCD+iETyhpYx0CQBJ7uubTj5FjxpsOSMZMzqla0QIgcA5zydA0PrVXoct+q+T0ye294KylRLyK/TXp4MD8F6hdQZNjBMwEeT6RNyIc0OLucB1CfIBOSXd+iKxVTNfVeZOhI3Dn6eUMo6EDUT7/X2yihfjpG8jxLEqZYt7gTNS6LL1zKugadcrcZAQKM+x+Wb6KjkOlpC2FfvG+1NMi5Bq30znFrOrK/VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AW/asmsxYEl3Dzy31/Le81eSRYkxFQx9pElrkh4TmyA=;
 b=ClxRGqU6bj7bMOZjBznRRgB8dKJthx8BWTLxXPKZmDHBh7j55r3pLsFKLhtJ+oBThC4NBwmTxoc2oumJLWJlLW0ZfDibgGTJKq96WXgUsYX6y/abjRcrmVjSfYB4uyN+M5LQ8RIoIwY0F76onbgLdg73IPkS5xrbkP50a61Ykg4zY0w+1eyqEpiO0ZR0ujlJX5DHMVjJzoUUH2/2esej2S9maV4RSAkcHskNVss/PHe86OCi0LWqRXJtKek9eXUaXAyiAlE+/+1LmTAKr/Dtkwq2H8M+r4yakAOkoSN511XGPUkJ83J/BW+DbPY754GVCb/ucrwP0laBRQqBfrS+wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ni.com; dmarc=pass action=none header.from=ni.com; dkim=pass
 header.d=ni.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ni.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AW/asmsxYEl3Dzy31/Le81eSRYkxFQx9pElrkh4TmyA=;
 b=XUdSkxi0Aq6FNAc9WIMinMlZ8hsFajExVkwLkpUNCgtEk2HUeJ3LbwD+9UVNEdwVU0s4LK8ZXgvmQc9cUxvFmDqNBn9QXwKY4l9v7V67uQM2Y1a4USozjO5txTNjFWO667VqeXYHpOiUfk4vWksfCE7vtLpo36xtFiSa3qcbenY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ni.com;
Received: from SJ0PR04MB7536.namprd04.prod.outlook.com (2603:10b6:a03:32b::20)
 by BL3PR04MB8153.namprd04.prod.outlook.com (2603:10b6:208:348::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Mon, 5 Aug
 2024 22:56:50 +0000
Received: from SJ0PR04MB7536.namprd04.prod.outlook.com
 ([fe80::50f6:5b8b:46a9:4228]) by SJ0PR04MB7536.namprd04.prod.outlook.com
 ([fe80::50f6:5b8b:46a9:4228%7]) with mapi id 15.20.7828.023; Mon, 5 Aug 2024
 22:56:49 +0000
User-agent: mu4e 1.8.14; emacs 29.3
From: Gratian Crisan <gratian.crisan@ni.com>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Hans de Goede
 <hdegoede@redhat.com>, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: mmc0: Got data interrupt 0x04000000 even though no data operation
 was in progress.
Date: Mon, 05 Aug 2024 16:33:57 -0500
Message-ID: <87jzgur32p.fsf@ni.com>
Content-Type: text/plain
X-ClientProxiedBy: SN7PR04CA0214.namprd04.prod.outlook.com
 (2603:10b6:806:127::9) To SJ0PR04MB7536.namprd04.prod.outlook.com
 (2603:10b6:a03:32b::20)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR04MB7536:EE_|BL3PR04MB8153:EE_
X-MS-Office365-Filtering-Correlation-Id: 52ccab8c-8f2f-4175-454a-08dcb5a1e3b7
x-ni-monitor: EOP Exclude NI Domains ETR True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?70y5d4Rm4w9U2BYHNFGYKzAufmP6QaOVZwHzGbyScDIrBTla5o4585BJXtjj?=
 =?us-ascii?Q?gSHfEpASkRIa5ECYr2egQedBrzUyjw0+EqbmiIn43np3eENF9iBhPpXTY3D9?=
 =?us-ascii?Q?FC9sZckXEpyOQ3jcidaoo1zrzVDMIClh3bqKuInKeWloxHCbPNlWqgGLjOVk?=
 =?us-ascii?Q?Z/qbMW9+YSX37Bl13zD4n/rTMxgZuU2zZhjRZPvKMtbhC5OKqJHuDKJsVRVw?=
 =?us-ascii?Q?3amRHjWRuB6HLwXjHkCXUI06WGa93/Rio2JxfKYTC5HaGMKhv+D9Ph+wEV1n?=
 =?us-ascii?Q?q5V5jewvZmQjgrmDxfdsvlzZ97nuMTVYjuc44e57uwaRS5t8SXUHCsC8bZFr?=
 =?us-ascii?Q?RjtHGBv/G3DjKtzehUIjjHLqrs9AoGfkIBJIc1YJApqAWTQpnbTDo7wjHrxN?=
 =?us-ascii?Q?Fr+Eo9QqEO9+wYT+2FuaE3+BBemerYuT8LRBczcUAGpUIgn0ehvIKdkMzkDG?=
 =?us-ascii?Q?sDtzXsBf+8Ds+ag4RpiaF5UYGQR1JDxRvSdfdCNFAdX1zPHUFSVhP9FUifIq?=
 =?us-ascii?Q?0XhlbjhhdNBSgTa2b1Uz10GSYfHE6LTn7d5kxYqeBEwhXQ46UW/OrGYbySEW?=
 =?us-ascii?Q?IUQRtF6FTUjx+VPTuPykavOtTWuG2V676tCTkxiSWpQ8fjwR9XfVFon3UGGn?=
 =?us-ascii?Q?LstlmVIRcT834mIO0SJUZXHxvwx+wHr8yB0lUrKwDU0EQ70Bt7azxDWfN/nl?=
 =?us-ascii?Q?8M5T1GoUOysUJqAFAMi/RtjzwD6P0RK/jkv6L6ItSMQ2osUX7fzvbMYqtrHv?=
 =?us-ascii?Q?/N0P19LJVDuA1XBJGLs+MrRgLYeVmkanYwatgl9JHIhoM0dMclzMZoVmmnhY?=
 =?us-ascii?Q?5bcHDlIkmOUVepxunMSwTQJp7BY7FPFA0tqTdsLLoU9TtVSUDVnM8sryf5Z3?=
 =?us-ascii?Q?I5s00bISjHSipYH+gwYMRxyU5Od5vWdIdebkZq4lp3M1GMEfpkyn5LlkQQjv?=
 =?us-ascii?Q?FZbHWNpntrdOxLxxn1PlTDjt+JqnFRjwVkf4p3eaQRGUGnqCA9NGd4Ch3XkP?=
 =?us-ascii?Q?85G86p9SCMVgunFBqTDEgW6X7sKQMPBc6i8HQWKApidAScbnhkNbHsVutBV8?=
 =?us-ascii?Q?foxXnMVvIBpY8Rwx91TG7nwmf8h2E7vnG1YqI8MpuhxmoXQHfEuYFzebeaV5?=
 =?us-ascii?Q?p1vG4w2YvJb92JhybBrk4FDIeDelFHQ8Ri1usasVArd1HfgbeAxXiQVA7j/z?=
 =?us-ascii?Q?s/hvoMQKRxKahsTokmuHWQ2YX6RF6/V4eUNy5vu16+OQ6Daug0/r9pimORGN?=
 =?us-ascii?Q?kGq/1qpyYXLbj+59zIR+bbRnxysEghg8ysyRDlki2904rI+MBOHiu8uV0mvH?=
 =?us-ascii?Q?3b0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7536.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EfyyhhuPzEQwTEKeFTD/YWqYCgHVX65iDVJBNdOoPTHGISVvfTyFVHtr/30+?=
 =?us-ascii?Q?aXl6BYxFBQUOD2cRPL4zCZYR8d+zcxQMPovxNUXm1Q+nZUBHuIuxgGrRViTt?=
 =?us-ascii?Q?3udYe65LCJ7aubtHEvopBRf0rz2xs9Z3gVskkKr4F1Kw+7a2cbA99XdPHd6j?=
 =?us-ascii?Q?5UYsxu4v+oB4R39dY6JakYdu5THmzuHctsIjIDKvoGDPk4Q68fXrYXLvf0hs?=
 =?us-ascii?Q?y70BkEPFMUGlaWKdgcjC318qcMiH2xoE9hbhKZkDT21TvdfuDmi/Yf5qCQBb?=
 =?us-ascii?Q?iJHQd63ro3kCmJ7pJarwQ4d95zw2syeAGZu/UQBUZ0CUHJ8LvWRxgsDQnMjd?=
 =?us-ascii?Q?hvyK6rJNq39rphKii6ADB0BbFOluhFERtsgpNoaaa/J+HQZAnS2mzfBZ2+Z6?=
 =?us-ascii?Q?sz/ZKnwZki1wbOfL058gnH8CsNiRjnwa56POG4cs0UDzNk+elOSX8wkxR9Ac?=
 =?us-ascii?Q?+g0sctBVKuqA2saAKevYQCS/4vMCT3YbpziurGgcKwdkjbDlEEQurBbbDQlK?=
 =?us-ascii?Q?4CKLPuVOu6CySD/H981rIbrmEbvUv9B0eBiq79pZH+T27x+4m2kdJgW+/FCz?=
 =?us-ascii?Q?Weta0DgHCnndK9Iii44hpfpcZGSF39HQ3zRUSCiFkxufNVun5OgUbmf6Xfgg?=
 =?us-ascii?Q?RVN0FZyu8n1K5RKx/q4J7mrrjTO3lK0sevOhj8B4POBQXGt+AmcM4WIqZJzM?=
 =?us-ascii?Q?Lr1PxMA0SOxobI+ti6ubuU6M/r9KmEPMbkN8A12sG1k8HQR0ivT5m6+1lt2i?=
 =?us-ascii?Q?Ewz9d/s5/C3MpUIQzTTm9zKncl6za0JaKkc5yVnQ1g5d3NkFcGPCyQiCaJ4b?=
 =?us-ascii?Q?aWWYuHZep+l6VHZWWQdRVEGPRHeJlxn2gDiPV3ZOK6bdIg/DxZjf/6Olyug1?=
 =?us-ascii?Q?98kcmp+Lz+YWsXbaQ8cPe3aDKqdZkwDM5NCFtruvnbLwZE/IXi4pK4vvC9cA?=
 =?us-ascii?Q?ncYSIguR6/AB8g1spuSc58ipZJuoRU50ZGL816hdMDWySje+IT5FyOST+EL4?=
 =?us-ascii?Q?ohpc8eihrgywCzTRhPEvVx1EBDy2ynFKllumGFuf0sJiqn0ZRCXdUnYR2fO1?=
 =?us-ascii?Q?ww3IC45XKeSAps30wUVSAx67MWiGaQk//IC8JZSi6REx1X0+htA1mYc3/fCA?=
 =?us-ascii?Q?8Ds5TN1AQA+t6D3mRjhILSo9ghsrl9NgYBy6ocvg4qxoN4emjRKrq6ithLY1?=
 =?us-ascii?Q?1iyzqpiqpvWKmZuIROwpKEhQR1kZSN1N7AzJKh/TCr/BSWAL5rQjMu7gHzlT?=
 =?us-ascii?Q?a8rI6Q1MJ3bNr2AybKeA5qcOgOGN4NfqZxvoiKs+K5ZzN95mEmClFcj7d+BR?=
 =?us-ascii?Q?I7ritzF8neLOcRfaKg/gB7m0NAKnbRt3fp9vwZ5osboHNYM/O0wuIeGXCvFq?=
 =?us-ascii?Q?h29O4ast9CQ2rcIgY4XoS2W6z/Q2ZQhafmGb3ErXu8SOmMwMq//fpr2IMu6C?=
 =?us-ascii?Q?0IsZG+qGD1E1e1FC3hNGjYtOAo5kWMXdHbrZiTGwrFVsZ0VFudvvyYQsDWyV?=
 =?us-ascii?Q?hciByluG4xl2Q4DhQaXLoBL7OXt2oZhzq70fzex3xm+i37UsNNhOXc3sw/mg?=
 =?us-ascii?Q?dx615NdC53shLjYInJN8lUgvrdJkx8KTPNNqQkfEmh0E8t2/TtLpIYBFy/lE?=
 =?us-ascii?Q?x+xzG496uuQmo42rbTzTq2AaxDAvHHQdRn+Df6sDKRHx9Pk0nWMQTOdUL8D7?=
 =?us-ascii?Q?cZJM1g=3D=3D?=
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52ccab8c-8f2f-4175-454a-08dcb5a1e3b7
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7536.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 22:56:49.5845
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u6HcFqkI7eBT4rL59vTxPa5zU/Zgx05lQpQQUvDpaoGtRZ7tYzKLXwVA8s2uTkutSpIE7bOyuLFzjPcJbHaJJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR04MB8153

Hi all,

We are getting the following splat on latest 6.11.0-rc2-00002-gc813111d19e6 (and
older) kernel(s):

[    4.792991] mmc0: new ultra high speed DDR50 SDHC card at address 0001
[    4.793550]   with environment:
[    4.793786]     HOME=/
[    4.793985]     TERM=linux
[    4.794201]     BOOT_IMAGE=/runmode/bzImage
[    4.794485]     sys_reset=false
[    4.795791] mmcblk0: mmc0:0001 0016G 15.2 GiB
[    5.333153] mmc0: Got data interrupt 0x04000000 even though no data operation was in progress.
[    5.333676] mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
[    5.334069] mmc0: sdhci: Sys addr:  0x12454200 | Version:  0x0000b502
[    5.334464] mmc0: sdhci: Blk size:  0x00007040 | Blk cnt:  0x00000001
[    5.334860] mmc0: sdhci: Argument:  0x00010000 | Trn mode: 0x00000010
[    5.335253] mmc0: sdhci: Present:   0x01ff0000 | Host ctl: 0x00000016
[    5.335648] mmc0: sdhci: Power:     0x0000000f | Blk gap:  0x00000000
[    5.336040] mmc0: sdhci: Wake-up:   0x00000000 | Clock:    0x00000107
[    5.336432] mmc0: sdhci: Timeout:   0x0000000a | Int stat: 0x00000000
[    5.336824] mmc0: sdhci: Int enab:  0x03ff008b | Sig enab: 0x03ff008b
[    5.337214] mmc0: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
[    5.337605] mmc0: sdhci: Caps:      0x076864b2 | Caps_1:   0x00000004
[    5.337997] mmc0: sdhci: Cmd:       0x00000d1a | Max curr: 0x00000000
[    5.338389] mmc0: sdhci: Resp[0]:   0x00400900 | Resp[1]:  0x00000000
[    5.338780] mmc0: sdhci: Resp[2]:   0x00000000 | Resp[3]:  0x00000000
[    5.339170] mmc0: sdhci: Host ctl2: 0x0000000c
[    5.339468] mmc0: sdhci: ADMA Err:  0x00000003 | ADMA Ptr: 0x12454200
[    5.339859] mmc0: sdhci: ============================================
[    5.340293] I/O error, dev mmcblk0, sector 0 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
[    5.344663] Buffer I/O error on dev mmcblk0, logical block 0, async page read
[    5.346127]  mmcblk0: p1 p2

This is on an Intel Bay Trail based system: NI cRIO-9053 using an Atom E3805.

The issue appears related to the one fixed by commit b3855668d98c ("mmc: sdhci:
Add support for "Tuning Error" interrupts") and discussed here[1].

After adding some debug prints it appears that in our case we get a tuning error
interrupt during a MMC_SEND_STATUS (13) sdhci cmd which has no 'host->data'
associated with it (leading to the splat):

[    4.893298] mmc0: new ultra high speed DDR50 SDHC card at address 0001
[    4.896489] mmcblk0: mmc0:0001 0016G 15.2 GiB
[    4.906048] mmc0: tuning err irq, sdhci cmd: 18, host->cmd: 0000000003b39249, host->data: 00000000c0b4ad8a
[    4.963027] mmc0: tuning err irq, sdhci cmd: 18, host->cmd: 0000000003b39249, host->data: 00000000c0b4ad8a
[    5.384960] mmc0: tuning err irq, sdhci cmd: 17, host->cmd: 0000000003b39249, host->data: 00000000c0b4ad8a
[    5.442877] mmc0: tuning err irq, sdhci cmd: 13, host->cmd: 00000000e1669bad, host->data: 0000000000000000
[    5.443463] mmc0: Got data interrupt 0x04000000 even though no data operation was in progress.

I am new to this area of the kernel so I would appreciate any suggestions on the
direction to take here:

  - Should the tuning error interrupts be handled in common code in sdhci_irq()
    (or at least before the !host->data check in sdhci_data_irq())?

  - Is this more of an issue with tuning not happening when is expected or
    taking too long, since at first we do get the error during data transfer
    commands? Suggestions on what I should debug/trace next appreciated.

Thanks,
    Gratian

[1] https://lore.kernel.org/r/20240410191639.526324-3-hdegoede@redhat.com
