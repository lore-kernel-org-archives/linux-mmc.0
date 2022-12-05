Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96945C4708D
	for <linux-mmc@archiver.kernel.org>; Mon,  5 Dec 2022 15:00:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231800AbiLEPAO (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 5 Dec 2022 10:00:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231696AbiLEPAL (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 5 Dec 2022 10:00:11 -0500
Received: from CAN01-YQB-obe.outbound.protection.outlook.com (mail-yqbcan01on2139.outbound.protection.outlook.com [40.107.116.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B0AF95B3;
        Mon,  5 Dec 2022 07:00:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ehyAeHJBSbx5g2FEGIBtet7H+tdEo5TFB9zuqZ3q4OvYEF+IyoBXHaWZd5LSBzFBmDKbNbWaDV+qFjCF23yOBOsTIknXBrjHJX94MG0jjRlrf9NOhVrp5fc2SRonMAdxKStwHkqhf0nYi4pW3A+FJI2HsFPzl0L4N1LL81Qyn/znGZyzYv63J/Nt22iWiKI8QcGLo+nE03nU9XLWTHMkFH2Pe63FLJLkYjEoe/WCjMrW9UPfUpapjXuYbg7/mlOc/fkkuSFpfctMID3/mHoaJd76AZbgah1uM2uT048GuDFHrQzIe8wytkNF5p1Fgm1XnuzlflDpgdRxODaDgtrByg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qCKSlHlg2X/PLFnW8T9wzR+MlUIxdRXWZtORtKv11HQ=;
 b=PsvII6dtE2bBB8QREGBsuCsIIsY2rmVRwNb8OmOAHxoxsLB5MZkGD38U+iaX7kW6YHuZXeHVEgJn9x7Hf/Fk2C/UsMaCVf5S/nO4E7vFpjJ4M5OJx6C35N5Kcw5a7V6mzo7yXmnwhOUgcATH4vUr4VwQv5JyEXHzg1U/iQhe3QGvBTo6V52ypEFW5hKghx6FYa0VFzACgdX7PXp3TRuAsgIe4nHDdJn/EUj4uqu3D7zO2uz7HZ3w6X3agi7LM7O9hidMRYNRYc716bUhzYaKMVO+AZkDKxzlyDn3dEoDTZiy9hAPhPtA/rsEN5WMv5RQMtOyF5OnU08cxIdSR4oxDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lenbrook.com; dmarc=pass action=none header.from=lenbrook.com;
 dkim=pass header.d=lenbrook.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lenbrook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qCKSlHlg2X/PLFnW8T9wzR+MlUIxdRXWZtORtKv11HQ=;
 b=FUfnh8QtEuPFfgh4EVMk+9c//PSZI5cIuITmJSCulUHdNFwLLCW4V+N43qfO9xXpzTh2jhRQqZcN8mzrcMFLnwq7nJIoJ9pRQTkX6gY+Nqs8lXZI/4vhDp7VbPgDe27J8blPc9+xW4WZWHJyJXz8Qbrt+5jee1G9VpfIq38IvpE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=lenbrook.com;
Received: from YT4PR01MB9670.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:e8::12)
 by YT1PR01MB8395.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:c3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Mon, 5 Dec
 2022 15:00:05 +0000
Received: from YT4PR01MB9670.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::94a9:f6fc:9cd8:7bf8]) by YT4PR01MB9670.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::94a9:f6fc:9cd8:7bf8%9]) with mapi id 15.20.5880.014; Mon, 5 Dec 2022
 15:00:05 +0000
Message-ID: <a429ea6c-f2d9-ddc8-15b8-23309b3a5051@lenbrook.com>
Date:   Mon, 5 Dec 2022 09:59:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 4/6] mmc: host: sdhci-esdhc-imx.c: disable auto-tuning
 when necessary
Content-Language: en-US
To:     haibo.chen@nxp.com, adrian.hunter@intel.com,
        ulf.hansson@linaro.org, shawnguo@kernel.org, robh+dt@kernel.org,
        s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com,
        linux-mmc@vger.kernel.org, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <1629285415-7495-1-git-send-email-haibo.chen@nxp.com>
 <1629285415-7495-4-git-send-email-haibo.chen@nxp.com>
From:   Kevin Groeneveld <kgroeneveld@lenbrook.com>
In-Reply-To: <1629285415-7495-4-git-send-email-haibo.chen@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0076.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::19) To YT4PR01MB9670.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:e8::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT4PR01MB9670:EE_|YT1PR01MB8395:EE_
X-MS-Office365-Filtering-Correlation-Id: 53b44c0e-50fe-4b96-4eb4-08dad6d1648e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UCZXX6N+e5Dxm5robnDgTm/Kp7qlaDJAwBFZpMCHifYukoZ/XDjQiK1XAiINJxDcSuVXxpjlegtuNaY7Pvy88H54iEd2KobOgjfuFNfIPQecslSmhKweGTx4VSySHIF9K0+mM65bajJXJlMirugSKxL6QBmVIC+vOZQIxUj6IsVHVmRSivIdQdzuS5UuEJW58+WETvctSus7TzVoTIuNRGCiNSkKUtWazWIXBX8XESFPGQXTy3RJYq8NeMLkNzTuMvUuk5tdiFNAQh9bhadlYmpU5qIq65OuEkfXkucBhkr8da8hsrDi56ZvAmlOh610+GRDEgSjo9P76UohhfInZ5fAuKm5Jzoa9kxeYOyPF7EjaFsbjFeY3dQmcexDQxUQ/z/lQsOvkf7CqTKe5h5N53euqE9yq/n3v63t27F86w3EbFpVUub6f94Mci434GKc83ZdzZ4TxVfQyogCz3vvoN+Qa1o4b9WGheVFykVLsqdjcKpaIYk+gzCLT/W+C9MdeaJqnNlmkiiOdd8MkLIFLPbJkG6sGpEBJGPJISpf8oFDr7bqEhI5t1RiBa0EsN0ia3pyEY2t3o0BiU6g14aRptz2SkvPuK6BJygGZ55/CSsIaKtU21jYMuRW3i37C9INT8ib7SfHzm0Odz/+ra3oJTEdVSkpkRmmGvIMlkrujnUGNAlSIexcpz6zhnkrMPXD5ONwHLuy64OtpmPKZj0/b/LaqLKK5GOjA+GMtE5MrK+2HQFWurzY+e6rNs5XVpUj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT4PR01MB9670.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(39840400004)(376002)(366004)(136003)(451199015)(38100700002)(83380400001)(86362001)(31696002)(7416002)(66946007)(8936002)(2906002)(4326008)(66476007)(41300700001)(8676002)(66556008)(5660300002)(6512007)(6506007)(26005)(53546011)(186003)(6666004)(316002)(2616005)(478600001)(6486002)(966005)(31686004)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zk9vcnNjNzRHT0Z3cE11amN6Q0wrSkNiYTVieEhFdjFaeVo3UFFuQmovL1Ar?=
 =?utf-8?B?OUgrZHcvR2J2b2pFRHJ6aDBiVmhLYWlNZUVwR3lVY1lsZjB0YStYd2dGckFR?=
 =?utf-8?B?SU9wcU9Scnc1cjFjWTJEUUZPanJVVE5JdkhVdzRPelcvTkdQNFNBZzBYRDY5?=
 =?utf-8?B?eW1XTW5GaHduSDlaNGZsL2Y0SFFPZHJvbXk5WklSMGppNWcwVVZ5NlVTekhI?=
 =?utf-8?B?Yk8rN1c1bVlHMkd3K041ZTZxTVViZFNmMjFhSlN3cklpUmU2aGNXLzcyNUhD?=
 =?utf-8?B?VW1UZGVLSVBkUG9nMkQzQzMzUjRsL1lwZWFyOVpkRFd1SUxyTTlXeTdvMlF3?=
 =?utf-8?B?WWxaN3Vhem51eFQva3gwNStDVHVNd3RwMkVucVl1OVRvVEVGZ1RWKzlmSWho?=
 =?utf-8?B?R0ZReWY0c3l3SzlPYXNFNXpMZjhsYUpMeVBKamtDRTczK3ZCdUU5WDVJUlph?=
 =?utf-8?B?U2d4TnNJamJFUExPTC9LVTY1VFdpejJha1dsbE9IeXRxTjZRenBxZGlyU0Jt?=
 =?utf-8?B?RzZwMTNLU2ozRVd3SUtqVlVITDZabDBQU3luV1RucXV6bnlKMDk1NzZXNjVy?=
 =?utf-8?B?cGlUbzBSaWVvQXFzelVBRnNwc1hkSjFIajQybDVuQ1RmU1BLSmpVUVcvRWRi?=
 =?utf-8?B?dlNxTmtoeGFMQ1k3QkphU3B3cWZ2bWtaZFhwUnV1WEVra3BIS0ovWVlCTS9w?=
 =?utf-8?B?TERzMnpWM0RCNkJQL1lnZ21iVXdYNURwZEpiSXo5L2ZvdUxGVGZYV3B2bGtY?=
 =?utf-8?B?RlhYMGJmY1E4dExKM2VMVzJRcVQxQTEwL2o0M0c5WStLc2FIUGpQS0NxRTkw?=
 =?utf-8?B?cmVreXAvbnZHbzdUMWZudVFKbWZZUDE5aUxTMkRXS1gvOTJNVW9KMy9xT1Zr?=
 =?utf-8?B?Mmg1U3RuWWdhcmE1WmRLbmFWLzloTE5ZcTdFR05HYTMrZjk1bUxiSFFaNDg3?=
 =?utf-8?B?NEFvUGRXbG13K0E0Q3E0bjdRRGtLckd1ZHJSOHhyY05qK0V2bFYyRWdweWpu?=
 =?utf-8?B?YStqcHk1U0hHYm1CdkY4TWZLai9sTE55Qy9PV1NSYkdnVk43WjFiTjJqZll1?=
 =?utf-8?B?OCtiRURZSm5EY25RWWM3dkl3Q0NhTjhQSnp4bkJRbmhKcVZjcStNeGt0MHl3?=
 =?utf-8?B?RE5EQVZtVlhSUHFpYXFpTEN1aGQyOGx4Vk9qbVczZFc0aXVGRTV5NDhtMWJN?=
 =?utf-8?B?YjFOMEo0cVUyb2RmajgwV0RjcG1pSjRVQmpsTDZwTHN1ellSZjl4YXI0UWlj?=
 =?utf-8?B?S3hyU2NENFcvY1JnUTdhU0dFZDBDTGd4T3FWLzBidGtVQnhXN1JJTmNjTjdT?=
 =?utf-8?B?UlRKZmd4cVlZcW9HaU5EZUU0SHIveFRXRzVaVHpUb0M5TU8veWU0ODFlSmN6?=
 =?utf-8?B?dVBNZzJiaTRZNVRraWExbWY2aFRxTzV4WXFhNk94SmFhTHBDNFZkYjgrWTMy?=
 =?utf-8?B?MWQ1MXY3Q0xDWXYwRDlCRWdGekhhZVhqQklldytIZkxUa0habWNsRExoNjJF?=
 =?utf-8?B?OUxRSGpGWmg4OGc4ZnEwRG8xczIrUmRYRXc5eVp1c25uN0kzK25Mdm0vdm1u?=
 =?utf-8?B?MGNnSkVsdTV4VGl3d2NCTzJGRUlpMlJVSVdrZGdNS0xuK3lPaVBCTnVWVjJT?=
 =?utf-8?B?ZThSS1podzdSUDNUTzJveU9jb0dnbnVob0Y4aG1tR2RyVnB1VE9pV2pZeHl3?=
 =?utf-8?B?cXVMUXhJVkl3NHJkTmcyL1grUTZaZXBqbXdxVjJoMTNHS09UZ0VHeHczeEhu?=
 =?utf-8?B?cDdPS0lXOWR0aXI4ZXJlQzVmRi8yUm50ODROeHpybjh2dXlnQ0lyUmN6d2x3?=
 =?utf-8?B?ODd0Qzlhb3FTcDNRQXZBQ0xrdzFmeWlKZ3dnYm9HTGRTdzdONVBIYzFLL3pL?=
 =?utf-8?B?SlpMWDlYRDV3MlBnRUhJMG9lOC9BQVprNTJKTmlORkxWemJCcVhuTHJwTzla?=
 =?utf-8?B?N3ZzNlN6eDdURVMyQ3BtTHcrMGJ1MDF5bmp4c0lrR0NSeW5NaUplMFRmdUlM?=
 =?utf-8?B?UTJXRi9yR1V5ZmdqK0xJaFlHNnVoSUFGLy83dVVmM3Z6ZkF4VEhhT1VEMjky?=
 =?utf-8?B?K1BRRkI4dEo2amptTWtEUDJsRTJCcm1JSTIvYnhnajVlT3hYcHI4RFFOUWdM?=
 =?utf-8?B?cDFFb0RuRGx1L045Z1NqQzlqNXY5Q1JCa0FhbDBvUkVSdDhQTzNaZlg1Zk5D?=
 =?utf-8?B?MGc9PQ==?=
X-OriginatorOrg: lenbrook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53b44c0e-50fe-4b96-4eb4-08dad6d1648e
X-MS-Exchange-CrossTenant-AuthSource: YT4PR01MB9670.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2022 15:00:05.3808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3089fb55-f9f3-4ac8-ba44-52ac0e467cb6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sVHQSWFH0I9jY1G67GajkfXupcsDjJizaST5SGMIERPKSoB+uuYB1exXNYOP3Q9Kgv2oy0kSTBa/ItfpJc0cfEjfjbwVU7gQYifFXl1ZdcA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PR01MB8395
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Thank you Haibo for pointing me here from 
https://www.spinics.net/lists/linux-mmc/msg73270.html.

On 2021-08-18 07:16, haibo.chen@nxp.com wrote:
> Add a method to enable/disable auto-tuning function. auto-tuning function
> is conflict with sdio interrupt. For sdio device with sdio interrupt,
> need to disable auto-tuning function.

I tested this patch on an imx8mm system and it made things completely 
unstable. I was never really able to log into the system properly and 
just got lots of messages similar to the following:

[   31.946640] rcu: INFO: rcu_preempt self-detected stall on CPU
[   31.952422] rcu:     0-....: (2106 ticks this GP) 
idle=849/1/0x4000000000000000 softirq=902/904 fqs=743
[   31.961663]  (t=2100 jiffies g=33 q=1158)
[   31.965682] Task dump for CPU 0:
[   31.968915] task:kworker/0:1     state:R  running task     stack: 
0 pid:   33 ppid:     2 flags:0x0000000a
[   31.978859] Workqueue:  0x0 (pm)

While working on this I also came across 
https://community.nxp.com/t5/i-MX-Processors-Knowledge-Base/uSDHC-auto-tuning-and-possible-SDIO-failures/ta-p/1352855 
which seems to address the same issue as your proposed patch.

That article suggests only enabling auto tuning for one data line as a 
workaround. I tried this method and so far it seems to have addressed 
the -84 errors I was seeing with SDIO communication to a WiFi module.

Some thoughts / questions:

Why does this proposed patch make my system unstable? (I was testing 
with a v5.16 mainline based kernel, but I did not see anything in later 
versions of sdhci-esdhc-imx that seemed like this should be a problem.)

Why does this patch try to disable auto tune entirely vs just setting it 
up for one data bit as suggested in the NXP knowledge base article?

As some other have suggested it seems like it would be nicer if the 
workaround could be applied automatically if the device using the SDIO 
interface enabled IRQs. Having to include a non standard entry in the DT 
for a hardware bug you may not know about or understand seems error 
prone. I guess maybe some device could generate an IRQ before they 
actually enable IRQs? In that case maybe a DT entry is required, but 
maybe the driver could generate a warning if IRQs are enabled without 
the DT entry?


Thanks,
Kevin
