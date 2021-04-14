Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E0CC433B4
	for <linux-mmc@archiver.kernel.org>; Wed, 14 Apr 2021 08:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E141610E8
	for <linux-mmc@archiver.kernel.org>; Wed, 14 Apr 2021 08:49:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345563AbhDNIuN (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 14 Apr 2021 04:50:13 -0400
Received: from mail-mw2nam12on2079.outbound.protection.outlook.com ([40.107.244.79]:56545
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232696AbhDNIuL (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 14 Apr 2021 04:50:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WLEuDk0A+o5+QebYiKUJfhoOL/wXj9imr5qdU5yLSgtjEqRWWDHBKtKuyj2D0XScsKUHvOSv6aF1wPlqywKoop3TAdvG/cnjtgydaJC05uEXP8khVbBfTG4paFy3PCYR7DkaTmEpPIROMeYvQwZhf2fhtNn2A46+rMG9lWZPNhsH1QZyZ2RT48+TH34yNF2nmcRDKC3wukT31XwyeDUOHmZK7GiCmJsPU5NDrLgongYYD+FdtIhE2xiUNyLW/YTzyy8Pkz5aSihIba33hY8f+dXXOmf22SJuiMWLRarf9zEJnLGhhrEr2bU4kMhIBsXtVbiX48s/UM6j3oRpbFhmnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L40s87SDsOJhDAmGVs/hYTfxqo76MqvVS78TNsHuOmg=;
 b=CXoE4O4OuCokYQXgc7RZSinkKZnW21ccEmwDM6IbyUGKzQjNUMgjP8v4/saxj8HsD0rb+oKdYV4xLEWxrdbP+KnUhxOIOcA1XjbjalYJFNCvPwz0bK/blFt0JrpZukCE5OpU2QbVPWn64VEehKqHVxV83etjL4LVWBUgq2jVerENTTJZHv9ayC8UgNVdE+Zg/htJ3gokV6Tr0UyxlZ96PBHQtTScvuw/TGrugQXJQP0TZOt8jxodL8iclNYPhX2N3di3ZsTNy3YKcnJ78TFbBbr5eQCDhwmwfNNjw1AHPAmyV/RxOG3OmCtHkx8xA2uBjcpDL14kz5lTS3Yyk7AHtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L40s87SDsOJhDAmGVs/hYTfxqo76MqvVS78TNsHuOmg=;
 b=PGH5OWWXARl7Tuv0WGulsn6Ems2e0bqY8CbI3xzwC8vErqNRAFXJfbMnhsJD92ZTyJU+978PUpI0e2K4SD0p1E1zjPKm5vFog/YyKJ/DY76z2GmkUI2JtT/NCmAOuc2kSkLOAYgRjTvf1f/pXh68kCwT4ctPHv0dFq2e3I9nvGk=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3453.namprd12.prod.outlook.com (2603:10b6:208:c3::18)
 by MN2PR12MB3119.namprd12.prod.outlook.com (2603:10b6:208:ca::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.22; Wed, 14 Apr
 2021 08:49:49 +0000
Received: from MN2PR12MB3453.namprd12.prod.outlook.com
 ([fe80::1d18:6e9c:8ddf:26b1]) by MN2PR12MB3453.namprd12.prod.outlook.com
 ([fe80::1d18:6e9c:8ddf:26b1%5]) with mapi id 15.20.4042.016; Wed, 14 Apr 2021
 08:49:49 +0000
Subject: Re: Question on HS400 timing sequence
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-mmc@vger.kernel.org, Jasbeer.Singh@amd.com,
        Sudheesh.Mavila@amd.com
References: <e990824b-28c6-3624-3973-4f54c5764e44@amd.com>
 <0c27d8cd-a102-8daa-dcd4-57647fff0f25@intel.com>
From:   "Shah, Nehal-bakulchandra" <nehal-bakulchandra.shah@amd.com>
Message-ID: <e08b3d2f-a6f1-3bf1-72fb-ef817dec7357@amd.com>
Date:   Wed, 14 Apr 2021 14:19:38 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
In-Reply-To: <0c27d8cd-a102-8daa-dcd4-57647fff0f25@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [165.204.159.242]
X-ClientProxiedBy: PN1PR0101CA0011.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:e::21) To MN2PR12MB3453.namprd12.prod.outlook.com
 (2603:10b6:208:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.35.91] (165.204.159.242) by PN1PR0101CA0011.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c00:e::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend Transport; Wed, 14 Apr 2021 08:49:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d2b39c1a-2be2-41f7-14aa-08d8ff2242c6
X-MS-TrafficTypeDiagnostic: MN2PR12MB3119:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB31197F55CA56924A909A28C1A04E9@MN2PR12MB3119.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZM5tAHkDEcfXI8IVUQT55HnAxyfNhz5du7XTAZcEXBgpnDzWe3ylIch6ITExsnrd1V+z2sZabGrx+Pl6EuNGbgGCc24ChVwllBkPb3f8KZJG2iFiP5ilZoWrDGhpXKSlRgHyjqfMIJw3lB1SgiAkg/MzvVX+LtnhSgINgLQKPIyNhpDgQP5SaYi8MCbHAZu4Bp2s2CKkr2uO769Ny/uBSr8okZVGMOm01f8IFBzc98KGZ37tkkKCXy0IUhTXBVyVLWBWn05lMoSi+y/DDdn6zz8zDwHAn8BP+5mwggswvbnI9avfvYN9RlQbQ3qLVxmnlU1EC9BNgRAvNweGBFY0PzmyfEVQBBIrs/oGlUqK0648SG+hPJVtn56ixRYli/KeVdLPgP91PBVExFv4JUmIAFDM/YfPMYCHaDp4Uib61I3DVMqSGPvN7oBv/U3xvWxOV46d/7XpZVee9CfOF/r+FBPVN+HZ7wZ0KXC/ryp3yH76iWXC52Z6dVV/jh9mgLq8IAgKrKu1lspmLAKsso5mpcgyn6lywF8bjYB9u9a50MMvk/pmOsE7aQ90mCIpcq1oh5mFKMyIYAxdjMQcAipSvKTAo6Qugy7i5eZB+6fHSA5OyWOr/EB5CW6p7bMTtp6Lqj4TJn9WQMEWAHJ30g2vzwnB/bdHVc8sYukRmnVH2nTnOrbglv8aruFoGQBNunwXURNhqK+xq75ROJY3D5RgkYFnKRB9Ft7hs1wTqRIwIcw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3453.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(346002)(366004)(376002)(39860400002)(4326008)(26005)(66946007)(186003)(86362001)(8936002)(16526019)(52116002)(5660300002)(36756003)(16576012)(8676002)(38350700002)(316002)(6486002)(38100700002)(66476007)(2616005)(83380400001)(53546011)(2906002)(6666004)(956004)(6916009)(31696002)(478600001)(31686004)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?WG85UHNvbDFMY0Y0ZEdJS25EMHovWEw5U2prbGlIM1JZV3UzQXZzYnVqbVlG?=
 =?utf-8?B?anUxTHQ0VjB3TEZnR21ZZ2Zlbmc1OHJEVmtkSCtRS0xXN3pCZjA2UTFRT0lM?=
 =?utf-8?B?MkZUSjErODZqRkJHREJiWEVKZGFtSksydHoyWnE0NWg2V3BjUHkrdElFQSts?=
 =?utf-8?B?cUx1VmRSOHVyY3duQkdrZ2RDNDlqR0ZMa3AyQU9sTjUzSkU2NG5CUktWVHNU?=
 =?utf-8?B?K3o1UmRMaU9LTW1NcnRSM05maW52MitsMkZPN3NxMkROOERGbVhuUk5XcEI2?=
 =?utf-8?B?NzZDLzllTE1pM2lmVy9MNUgrTkYwaHFXTjJrY2ZxVjFiZ1ZEYnMrZjVrMURL?=
 =?utf-8?B?N2syNVRUWjM3VG5tU3NNeGtxS2ZkaFZxaWVvbldIWm8rQ1B4RkhSTTNIbVN1?=
 =?utf-8?B?cTNiU2plWG5wWXhuSjFZVUZrVzRZeEpGcDNWOVFUbnlGeHV3TW5HT2JJZXpo?=
 =?utf-8?B?WW1KR1pkR1k1VTBtM293VlAvRUdaU1RSUG44OUhvRDgza0JPdUp1bFBIVkVk?=
 =?utf-8?B?dk1ZSXZzUFlyQjQwR003NUg2Ky9BR2pmNzEzTm1CaVZBbSt6ckJtbVVOYU5R?=
 =?utf-8?B?bU1PS2dzVmM2VkVXWERGd3ljOUdkaVdPbHAxSzN1b1RlOW9YVEpHTm9FTkdS?=
 =?utf-8?B?Q0FCNzdmcGJFd3hOZVNWMTg1Q0haby9wbUFhNTFUZnZoM20xNDJULzlheFJC?=
 =?utf-8?B?OVhTYlU4OW0xRFQ4UXhDYzdXQ3hIZnNEQ2c0bEFvelZrVEs5VVdQck92R09W?=
 =?utf-8?B?OEhSeXNmUXpyM2VDUzFPUkM0UWJhN2JCZEJicmpOKzl4cWMzSzRybHl5cmdu?=
 =?utf-8?B?MzZLblNxMVBhaUtsVjVLYWVVZVVDRGhuMmpZWDBrQ3lMNW8zZ3JHN3UwR0Zh?=
 =?utf-8?B?ZmU1algwMmUvSldINDZQUHRyRzJUK3ZNYkVFTkJoV2pyak1tZVpxTTY0S2cv?=
 =?utf-8?B?eklTaTZRUjBEblBEUHV3U0RLeDB2ZEF6R25LQk5tQ1VWTElzSmVHUFRKRTZq?=
 =?utf-8?B?T28xSTZuTmU3U3JWSU5POVNUUUR1eTFhMUhRODZBUVNxV1B0UjlXYTV6NFpN?=
 =?utf-8?B?YUdBUW9aQmMwdWxuVTVEZjQxWmNIaXZQelVFTWpVcEM0aTJIWVBmcUZpK0wz?=
 =?utf-8?B?L2xlbGVDQktBa1ZZM0xGUUtwRElabmthWVI2OW10OXp5Rml5T3JSU056amRr?=
 =?utf-8?B?REpESFQzRzZMcXRlU0VIOVQ3UXAxMk1EbHRvbndkYWROUHJ6VmRyUTlobVF6?=
 =?utf-8?B?NnQ4dVIxTllhU3h2MDdJVlZjb3liZ2NhdEpvOXdHQWN1L0ZOeURtNEduR1p6?=
 =?utf-8?B?dFM3Zys4RXZNVDVyM0FZWjRTc0lvOTdSaEh6bEU4ckYwRDd6bnJPRmlhMVYz?=
 =?utf-8?B?Rk1salViVno5VU4zWFpQMlJFeVV1blhqV241c3VEd0RlSmE4SUl0U05SZFZm?=
 =?utf-8?B?UXdreFRWT3NOQ1ZQSmZMemVzblZjRjRsZFpVanlhajBIMUlIZkVBaG1lOFg4?=
 =?utf-8?B?YVA0c0RWZ0xDUE56Y2hEc0M3U1VySFArL1NiODFJR3oxVDk5TDVQZGhxcHM1?=
 =?utf-8?B?ZDc0emwzaFFEemVxNFFQZks1YVJmdW5zNjlrRjAzelJMS0NHNkJJM2swd2Nz?=
 =?utf-8?B?ZWtGaTA2dXNveGhIdmdWU3ZQb2ZSN2ExL1lIS29ndlZaWG93U0NaS1daR0Y5?=
 =?utf-8?B?TEhwSk9WMy93SHlOWVd2UmJuUGFwVU82d20wR0lyaVFCazA4aFlOT2tzN0Fk?=
 =?utf-8?Q?t1/wJU/xvGBHftujWjNfcRaT4B9hIbcfgpxIAcB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2b39c1a-2be2-41f7-14aa-08d8ff2242c6
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3453.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2021 08:49:49.0501
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PPUze51XQRl9i2R2SWUoBsDR5CblRFF3zfGXYG2kZ07hP4mO3SSLP0vCLNyqjqLT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3119
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Adrian
On 4/9/2021 8:52 PM, Adrian Hunter wrote:
> On 9/04/21 5:19 pm, Shah, Nehal-bakulchandra wrote:
>> Hi Adrian,
>>
>> as per JESD84-B50 spec for EMMC 5.0 , HS400 timing sequence is following
>>
>> In order to switch to HS400 mode, host should perform the following steps:
>> 1) Initialize device with “Backward Compatible Timings”
>> 2) Select the device with CMD7.
>> 3) Read the DEVICE_TYPE [196] field of the Extended CSD register to validate whether the device supports HS400
>> 4) Read the DRIVER_STRENGTH [197] field of the Extended CSD register to find the supported device Driver Strengths. (Note: This step may be skipped if changes of driver strength is not needed)
>> 5) Set the “Selected Driver Strength” parameter in the HS_TIMING [185] field of the Extended CSD register to the appropriate driver strength for HS400 operation and set the “Timing Interface”
>> parameter to 0x2 to switch to HS200 mode.
>> 6) Perform the Tuning Process at the HS400 target operating frequency (Note: tuning process in HS200 mode is required to synchronize the command response on the CMD line to CLK for HS400 operation).
>> 7) After the Tuning Process has completed, set the “Timing Interface” parameter in the HS_TIMING [185] field of the Extended CSD register to 0x3 to switch to HS400 mode.
>>
>> But in case of JESD84-B51 spec  EMMC 5.1, HS400 timing sequence is following
>>
>> 1 )Initialize device with “Backward Compatible Timings”,
>> 2) Select the device with CMD7,
>> 3) Read the DEVICE_TYPE [196] field of the Extended CSD register to validate whether the device
>> supports HS400,
>> 4) Read the DRIVER_STRENGTH [197] field of the Extended CSD register to find the supported
>> device Driver Strengths,
>> NOTE This step may be skipped if changes of driver strength is not needed.
>> 5) Set the “Selected Driver Strength” parameter in the HS_TIMING [185] field of the Extended CSD
>> register to the appropriate driver strength for HS400 operation and set the “Timing Interface”
>> parameter to 0x2 to switch to HS200 mode,
>> 6) Perform the Tuning Process at the HS400 target operating frequency,
>> NOTE Tuning process in HS200 mode is required to synchronize the command response on the CMD line to
>> CLK for HS400 operation.
>> 7) Set the “Timing Interface” parameter in the HS_TIMING [185] field of the Extended CSD register to
>> 0x1 to switch to High Speed mode and then set the clock frequency to a value not greater than 52
>> MHz,
>> 8) Set BUS_WIDTH[183] to 0x06 to select the dual data rate x8 bus mode,
>> 9) Set the “Timing Interface” parameter in the HS_TIMING [185] field of the Extended CSD register to
>> 0x3 to switch to HS400 mode.
>>
>> So basically in case EMMC5.1 for HS400 mode selection, there is some difference after tuning. However driver
>> existing driver always follow spec of EMMC5.1 . Is there any specific reason for the same? So on our some AMD platforms
>> with EMMC5.0 driver is failing but if we modify the driver as per EMCC5.0 sequencing it is passing. So can you please provide
>> your inputs?
> Hi Nehal Shah
>
> There was another specification between those two, namely JESD84-B50.1 eMMC 5.01 which has the same procedure as eMMC 5.1
>
> AFAICT the 5.0 text was almost immediately "clarified" in 5.01 to match the 5.1 text.
>
> So we have only 1 HS400 sequence.  But some host controllers do have issues, which is why there are additional hooks like ->hs400_downgrade() and ->hs400_prepare_ddr()
Sure we will try the same.
> Regards
> Adrian

Regards

Nehal

