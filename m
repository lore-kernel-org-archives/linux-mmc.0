Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1672C433B4
	for <linux-mmc@archiver.kernel.org>; Fri,  9 Apr 2021 14:19:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76E2761186
	for <linux-mmc@archiver.kernel.org>; Fri,  9 Apr 2021 14:19:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233799AbhDIOTt (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 9 Apr 2021 10:19:49 -0400
Received: from mail-bn8nam11on2061.outbound.protection.outlook.com ([40.107.236.61]:56352
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233713AbhDIOTt (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 9 Apr 2021 10:19:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YCL3AAP2kGf25jg8DdBli2DyT0bgiIQGDhGyWCRCKkt5IP5SI0h09rrs7IokmEqbRa9kXjJ8zgmWL1yAMoGd5xkPDSU6DrQ33u7asAGUkJVh2QGJWJFeubZVWaqXu62W4NedKxi0a80rEri4I5087MMvm2/OYUiE+HxTv8oA6be+MBKpCl7CeKsNJOARFmpF5xP3lFjPgAYIMi6hJ83A3Xlj9x3sga1IphicXcfvPYDtABRR80mTGGe9OGdZQ2zZdaSTwhB0p9IayzWN032vz6cH0A9KnnM+yLAzeNmFEHloZ5PvClrr3D2Je33LJgrRUKOKfpLgsQpeUJbfEACKfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NrEVxvy2BxV0RQ3GN+itXyczJt0T5dzoUiwwGYwyVMw=;
 b=dDqnDAzphochllXxPcwGIL1Fv793ert3b2BR3931HY5codSGiQa/9MGq9gL2y07sOhkU5iTAmJUj53i2W9DmaJHlu81O0UL6sYynoSF3LB0BkdsXmN6s58dWq5qHhBxrnPqCqYrUwLNNAP4mAQrxu+SwBzAA5uY/j+gwdLTRFr+cPTivh1uZIW5sCLGlP3CDVs4EVo+vdHqh9SMu/a4uU2SrLLfBVJpi4CCPQBVNbWk81CAq/if0sA6jZ4FEZ7Zr6FhSmGnJUM1aQ05zBkh/Sr8/4Spuc2C1SkPoN+JP5DgTxBRR+0ucusfj2ZFhpXWKLWWXAHMg4THIl77E4FwAzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NrEVxvy2BxV0RQ3GN+itXyczJt0T5dzoUiwwGYwyVMw=;
 b=HfeiyL8AO2bOFIzaxjMQ4MQwlBBOrjHVFg5vJuN+oiMGOTgG06K1vv9MiFy3lA20WGG9dIybwu8NDrrhCEmvu5GCxjAKWU2H5vBcWz5ReMImmB51R1P9aSeMAa02ELyKrPGvrgyE/OWZB6t1gK4b37Kt7Ns9R6WdG3Q6Q6FfPFY=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3453.namprd12.prod.outlook.com (2603:10b6:208:c3::18)
 by MN2PR12MB3439.namprd12.prod.outlook.com (2603:10b6:208:cf::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16; Fri, 9 Apr
 2021 14:19:33 +0000
Received: from MN2PR12MB3453.namprd12.prod.outlook.com
 ([fe80::1d18:6e9c:8ddf:26b1]) by MN2PR12MB3453.namprd12.prod.outlook.com
 ([fe80::1d18:6e9c:8ddf:26b1%5]) with mapi id 15.20.3999.032; Fri, 9 Apr 2021
 14:19:33 +0000
From:   "Shah, Nehal-bakulchandra" <nehal-bakulchandra.shah@amd.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-mmc@vger.kernel.org, Jasbeer.Singh@amd.com,
        Sudheesh.Mavila@amd.com
Subject: Question on HS400 timing sequence
Message-ID: <e990824b-28c6-3624-3973-4f54c5764e44@amd.com>
Date:   Fri, 9 Apr 2021 19:49:22 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2401:4900:16a2:235c:53b:7699:4e1a:fdeb]
X-ClientProxiedBy: PN0PR01CA0037.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:49::17) To MN2PR12MB3453.namprd12.prod.outlook.com
 (2603:10b6:208:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2401:4900:16a2:235c:53b:7699:4e1a:fdeb] (2401:4900:16a2:235c:53b:7699:4e1a:fdeb) by PN0PR01CA0037.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:49::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend Transport; Fri, 9 Apr 2021 14:19:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 01a766d5-254c-421a-0e5d-08d8fb627ef1
X-MS-TrafficTypeDiagnostic: MN2PR12MB3439:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3439F43CED7F92B1ED295547A0739@MN2PR12MB3439.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d4NOnUkYpZ9yprBAfdZNpKjBnr5cSPBPhCf7cnwQe/giH5ovRLinpVpBLjO29/JfyiYGjLovNhW9jrbjiZVdD/2Pb/MeaCIaTCPpiIjYI/BI2CaG6iV3JLIKDUjmeZq20uNz2jG/zHJh6Z/TR8mwibfaoiKQNxZpllqvA7g79QHTvnq0crLmzJk0Dov6TSm7Sbh7OEJcgReR55E2Gvk1gkYTXMO1MAKyF+ef1hQrrLMlr8Gc4nqODRNkc/G0BKdFcm3obZqUiZ37VFJmauDjj/I03rbgmbsgiTztGLtGcG+0FLPj0JbaVtaeQ5Q6GaHYcjhccC5yCkGDl5Fc7XFZ7/c6j3sUbDDUlndjEx5xSmn75CKwGj77bA41UR0JTNe2Vbopn6ov+fvi+gsfgYDcyfm6ou28Y8zES9gOpzzYDa85PzulKKoCuHXMJzKMRztkDm0pnkyfYE650c1pVdDx+ic1pwaVUn/4ECZ6WtsC+Q8HkJlV0tkRyWdXcsLeQALhQKQNl37s42l6NH6EqONCFmLhhqgUWf1DAJ9IvJHBsnGMJxVuyZdKMqtl0SZf4fKRFscljjsuQ7IBMMkkEuptAmR+AzqqQCtHuaWjDvrsyp0lgD9DdRNUudr1zY1Ykyn/2V0gouMVALDafzO8ZpMzYjbC/C1ri+6RTpnM59Ie+6JujH+0D8V75wiKK6rmIsQYLSiJSaQWo7uEKB0w8eL0wd8Y3HWFzb0/UrKnfvGO9dI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3453.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(39850400004)(366004)(396003)(136003)(36756003)(83380400001)(478600001)(31686004)(38100700001)(186003)(2616005)(66946007)(6916009)(6486002)(2906002)(4326008)(8676002)(16526019)(66476007)(5660300002)(66556008)(31696002)(86362001)(6666004)(8936002)(52116002)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?QXhOV3R2blh4VDdjaXY5RzVhclordkY3YmZSUU5QNncvZWNBTFF6L0JoOCtW?=
 =?utf-8?B?aE9kc3RFcHFUZ1VkR2VHQ05CZG9mcWdSQXhYaDdnc2s4VHI5U1BkL1hEa2o2?=
 =?utf-8?B?cUlIWS8yTG8yaWRFeGdmMnZNSi92a1BMQzFBYzBvSElDWXVoY1BZMndRRVo1?=
 =?utf-8?B?cSsrNFIvc2dQUE84TkRUZGtWRzR0OVRvUG5uQWM1ZWZjck1nMm1nWHZBN2F0?=
 =?utf-8?B?cGNmNm9Jb1dSWGRlcW9pKzFJODNIUDZZaDdITmYyNEV2aG8yemc5N3RkT1Bl?=
 =?utf-8?B?QnlickNTWHZTS2JTYlNkckxsYUxSbG54bTF0ZXRTK0tkL0d4QklyNkRvM1VB?=
 =?utf-8?B?QXZoQXJFaGhySStYUFFoVnR5SDZDUGdQa0ptZXBTdElYeEJ3U2U4clVMZUFB?=
 =?utf-8?B?c25qTUxYOFJFcDgxTU4zaFBxNzhHZjBnMkdWaUNrZHZ5eDdMRlh4a3BIWTBr?=
 =?utf-8?B?YnRFcWdhZlFVSHhNbmRoL09MaUFzcWNOZkFpNVg5VEFMVXdidmNSSjQ5RFZM?=
 =?utf-8?B?YlJkd3VuSHdBNW5Ub0V6ZGQrS1lMSFVSZ0dROVdHVjVEQkt0dHU1dktMaW9G?=
 =?utf-8?B?TktLWkhsaUJVbEJ6UE1ucXVWd0lGdm1SMDh2VFNmMjhHYVdFRUpmVDhQYXhs?=
 =?utf-8?B?K1ZucEFGSjRHYi9CSXA0dzFmNmVoaXZDQ3puTGNTRUJYR1o5cmdPMHJLL3lS?=
 =?utf-8?B?cTQyMHBMU3lFT2c3bFZYL2h4Vk1uU2RCdjZ5MjNJZFlqcUdJVnhhMXdTRXB1?=
 =?utf-8?B?aks3TVlSdE9HWktxOThGMk1nQUYram9GdlNxZzR2OTBxdmd1YWQ4Q2I1ZStz?=
 =?utf-8?B?T0U5VjloaHhCaWVUOEZ1VkQvWjBCV0pLUXFwTWl2K3lzazRsUGhoQllxQ1Uw?=
 =?utf-8?B?K1BFZHNZUkc0dVB6MTRxK1dQUDFPYnpyNG41TGc0WlBqN0xKc1ZvWTJMTmxl?=
 =?utf-8?B?UXZHTVN0Z2VLWENZeDhzL0kxN3BJUXFBb0hhS0dudnpHQlM0cnNYK2dFME10?=
 =?utf-8?B?THVhUWE1c3M3QS8za2phYWpONFNxb2pwbzUvMm5qakVuTThQQzVQVkNjZXdr?=
 =?utf-8?B?cnVvSGhkTUVHdkRNc2NncTNCa1NPVDVJNy9XT0Zrb3pabFhQaGhNWE5VQ3dN?=
 =?utf-8?B?Ymc4eExkaTM3MGFVUUJSdDNjZE0xR0c5dzI0NHM2TFJ4RTg0WnNIN2FqV29Y?=
 =?utf-8?B?R1BFYzFrVVB6ZVhlT3pOTmtPaGJIZ2ljUC9nUWpvVXBvRE1jSHB0Wi8ySkpK?=
 =?utf-8?B?akVOOGRMamhVSG8ramNwSGFOSTRpaExlUk5URTNwOHJJbzNrWlVjQkpIUC9z?=
 =?utf-8?B?OVRMakhydWpBQkQvbXFPQzVoeC9za1NaMXJ6L2VmSEZmajFIb2c1aFhEZlZy?=
 =?utf-8?B?L0NpTW5TNHdtS09icXJvVHRFS3h0TDR3cXBPTVRhWG9hNVNiNi9uTmY2Rmcy?=
 =?utf-8?B?aUNPMXN1M1JMNVgrVFRQMzhZOTZ1L1RvNmN5U25NS09nNTVCeERjK0loQzc2?=
 =?utf-8?B?QkdwUEowc0JlTDlpZTQzMWVodnZKSUovbm1Gdm5FSWFMU1FhRGRzV0NNYXlK?=
 =?utf-8?B?elJ5amVxM0czdFE3Y3YwM2E3WWJjMWpkRXFNRVJERWVuRS8weVIxVVgyWk8v?=
 =?utf-8?B?T1o2VUU3cUNiOVRuR291K0krSDBtRHl1Y2prNURHTlBDQmFNOGduQ0xIMU9S?=
 =?utf-8?B?VHZzbFI5VmdGN1hkOVI1NXBRa0RtSTBBZEhBMUIrS1dEZVdXRzUzN0wwS0dv?=
 =?utf-8?B?bFlmTkt4L05LTDRGTDFzYmpldWovZVNlYVRnZnRyYkc2a2hFeHRXVEpwNTc0?=
 =?utf-8?B?ZTlKUXpaQ0NveEZDbHVySElLTEVQTE1vUndQUWY4WlQ4OXhCZE9KN1Rucmox?=
 =?utf-8?Q?hYiHm0K/mHeCs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01a766d5-254c-421a-0e5d-08d8fb627ef1
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3453.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2021 14:19:33.0187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HGcNtMMWKaC+00sJQ0UcpvDvvobxhATP8tdAFM4+mP/m0NOQJViYvQjrxK494z/a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3439
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Adrian,

as per JESD84-B50 spec for EMMC 5.0 , HS400 timing sequence is following

In order to switch to HS400 mode, host should perform the following steps:
1) Initialize device with “Backward Compatible Timings”
2) Select the device with CMD7.
3) Read the DEVICE_TYPE [196] field of the Extended CSD register to validate whether the device supports HS400
4) Read the DRIVER_STRENGTH [197] field of the Extended CSD register to find the supported device Driver Strengths. (Note: This step may be skipped if changes of driver strength is not needed)
5) Set the “Selected Driver Strength” parameter in the HS_TIMING [185] field of the Extended CSD register to the appropriate driver strength for HS400 operation and set the “Timing Interface”
parameter to 0x2 to switch to HS200 mode.
6) Perform the Tuning Process at the HS400 target operating frequency (Note: tuning process in HS200 mode is required to synchronize the command response on the CMD line to CLK for HS400 operation).
7) After the Tuning Process has completed, set the “Timing Interface” parameter in the HS_TIMING [185] field of the Extended CSD register to 0x3 to switch to HS400 mode.

But in case of JESD84-B51 spec  EMMC 5.1, HS400 timing sequence is following

1 )Initialize device with “Backward Compatible Timings”,
2) Select the device with CMD7,
3) Read the DEVICE_TYPE [196] field of the Extended CSD register to validate whether the device
supports HS400,
4) Read the DRIVER_STRENGTH [197] field of the Extended CSD register to find the supported
device Driver Strengths,
NOTE This step may be skipped if changes of driver strength is not needed.
5) Set the “Selected Driver Strength” parameter in the HS_TIMING [185] field of the Extended CSD
register to the appropriate driver strength for HS400 operation and set the “Timing Interface”
parameter to 0x2 to switch to HS200 mode,
6) Perform the Tuning Process at the HS400 target operating frequency,
NOTE Tuning process in HS200 mode is required to synchronize the command response on the CMD line to
CLK for HS400 operation.
7) Set the “Timing Interface” parameter in the HS_TIMING [185] field of the Extended CSD register to
0x1 to switch to High Speed mode and then set the clock frequency to a value not greater than 52
MHz,
8) Set BUS_WIDTH[183] to 0x06 to select the dual data rate x8 bus mode,
9) Set the “Timing Interface” parameter in the HS_TIMING [185] field of the Extended CSD register to
0x3 to switch to HS400 mode.

So basically in case EMMC5.1 for HS400 mode selection, there is some difference after tuning. However driver
existing driver always follow spec of EMMC5.1 . Is there any specific reason for the same? So on our some AMD platforms
with EMMC5.0 driver is failing but if we modify the driver as per EMCC5.0 sequencing it is passing. So can you please provide
your inputs?

Thanks
Nehal Shah


