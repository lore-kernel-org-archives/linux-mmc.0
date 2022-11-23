Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B6E6C3A59F
	for <linux-mmc@archiver.kernel.org>; Wed, 23 Nov 2022 13:54:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236308AbiKWNyy (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 23 Nov 2022 08:54:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237667AbiKWNyd (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Nov 2022 08:54:33 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2085.outbound.protection.outlook.com [40.92.107.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB9067129
        for <linux-mmc@vger.kernel.org>; Wed, 23 Nov 2022 05:48:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GwZHL5olSSHoKSLmPZpH/seMSQDydyZqSe/b8uPoFNbS5rgSJWQvegOTm02ZbjftHzMQC+wmWRwGcbIX+I040QkeOfcqpmKpirPddNV8AfxAXjZnWbqrnhDjOteZI2J9VRNm7HW4kh5rq9vPChmbvgvaId6ABSByrnR/IV+CXXfWEJMk77CUuVPKe90Y5WceLUfQozMfNC7wthSnLS7f92cYqqSWMGNkTz7FwKU3JK8OUqZqkfIPIY5MBGvZ/MI0AZ1eGRBJ3+kzDI1GCrEgOTHTF4tRzCdlz1L0yGHLl6dgHOwOPlpnRsje0UyFY71Va9fathxn/JITwRay8aMVvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8RIudtpOolZW0wGVUhaRwsyCYyFliFqtoZ+5K2dRT+A=;
 b=ECQwco5VTaeS4TD04oy3JF9NUNeGJ4YfsLAp7Zy82A2Ky4TlhhF0SaaFsi06GixnUUVWSTD6ctIxEaVjrTvjhNGPTCgYF051bS+9+4irrnGNP4daClsk5rC+LSiWpaGcSSpPLu35ESR05AhLryyqaqOQJBlRE0dJDUimR6ioYQU6/hEK3TczDLRO5k5iztoZFeAj7Zb6GtkZxzzobXiIUUFYjlHtR0Q1D25mVWfvSVcdN0JxXduOAWzyTHlUA8Ra/1AlhMigo+DHa5p2QZw87Kzm74b/jDcdSg7q32Y7lsB8kNT1oOoFibTTtlo7Py40ZTv6QwMN4wGApy7YG0OsaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8RIudtpOolZW0wGVUhaRwsyCYyFliFqtoZ+5K2dRT+A=;
 b=ntGabuhvNlfDJwiozLOqmp030NlMQteEmS90xAYxEX6Ru3KMxN50fKNPw8A9TYgngRZq3mQmSSxItBjUbbIVgtn79L6rC5Z/vAKQMmhs1ttdBJ5fcvxSQb5oSdYqT/ErQhEC+WUeGnrs+K8uZQKuWya32Ha/VuoBdqZ2Soc0pGZjLSuUWLpNyVMDhjaj7/tDFz7df23mzn/rmOO0g6wE3TLMNIH11XJcOXqAbguoZ7LokN4kQ3oMjxDElwN3baIpYS/pKgv1pyKSKsMrlVMO4JMRPxIe+gZBU51OPQyOLbKvepIXnCFRJwqbIZgTHll5BdCvkxe68rh7affTjjgcXQ==
Received: from SEZPR01MB4445.apcprd01.prod.exchangelabs.com
 (2603:1096:101:49::5) by TYZPR01MB4506.apcprd01.prod.exchangelabs.com
 (2603:1096:400:1fb::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Wed, 23 Nov
 2022 13:48:34 +0000
Received: from SEZPR01MB4445.apcprd01.prod.exchangelabs.com
 ([fe80::ad1d:da59:22a1:d30e]) by SEZPR01MB4445.apcprd01.prod.exchangelabs.com
 ([fe80::ad1d:da59:22a1:d30e%6]) with mapi id 15.20.5834.015; Wed, 23 Nov 2022
 13:48:34 +0000
From:   Patricia Baker <patriciabaker20@outlook.com>
To:     linux-mmc@vger.kernel.org
Subject: Re: Blockchain solutions
Message-ID: <SEZPR01MB44458287D619490426064DB4B40C9@SEZPR01MB4445.apcprd01.prod.exchangelabs.com>
Date:   Wed, 23 Nov 2022 19:18:29 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-TMN:  [jY/sLW2CCkqy0o9SFqrEkpDyI/0eJzvC]
X-ClientProxiedBy: PN3PR01CA0066.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::15) To SEZPR01MB4445.apcprd01.prod.exchangelabs.com
 (2603:1096:101:49::5)
X-Microsoft-Original-Message-ID: <3bd90584-eff7-0a12-d8b2-4fbcc2761bd8@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR01MB4445:EE_|TYZPR01MB4506:EE_
X-MS-Office365-Filtering-Correlation-Id: e08e4f57-a38b-4b2d-8bcc-08dacd596a13
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gBcvGnPP67v5lcEHAOYBRlT3PJ8NhdIsNgmvDWChkf/M4lxlxSbYjxhrZld3BfVH/VFcX4TNyLNdM9ji9Ngy86TXnSEsiWcS01FOrenTeo5DhXxOS/cjlW67qrxt5FxsPsNfvQSMaZGqRAuPK5qUC281m9RoGK9OXOv++4lvHqZqWhOh785ajEGFH1UKetlMeeAHR5O2uS1Ulmryce7vhkrVJHxsBLnyzpcod//1vZ/smv2J+RrDFPk/mJTtrSr4SR7C6fBAu0RWhVEO+kzxk32wYF20HLumh/gAleHjf4XyNlta4YFL58Q7lGnX3xQpbyLJj5BrteR+wbXIc/9Juo2tb6vSGIUgP07YhH9L9imYRE4U6FmzXRcitBYdVXR8Ge2H0b34WL0574YZvNVipnxu65rY+cV3hxaYn0on+76G436NPoGmy9FxdWDOFt4g9FIJlbRFskufbAJXVgl29J6+MOJO8IoPOBujIrNT2YA0BBnb5IlTz3w1D55devdf+q9N/2WUXIPUNdWQA85tFCCp69qniqfmonC718VRNnaJZ9b7dRdmBdZDlw6yWWmNqwpfHZNiEEiaBah0bMYddLwz3N9YO8mWJD4o4fhfIPnjo0tCUz5Ua2W1ZFFarHcfOMuuGywE3nUxO1g3gvdZlQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVEwU1QzaFZ3VFFQY2QrZktZVjdLN0JZZENLV2t1aTBOd0pDTVJqVkpTMndt?=
 =?utf-8?B?S0VBOW54MlhhSTMrcGkzNFFqV1ZHKzMwdFZ3bHZSR0RyVFBwdlk1UHhRQmNz?=
 =?utf-8?B?bDBsalpYSjByUVZMbzdJa0dTc3NFZVQzT0ZwcTJRYjUwdVUxVXRwRENWditQ?=
 =?utf-8?B?ZnhQWVZXaURCaFlEdFRIR3I1Y2ExTWxKUUtQL3ZMRG42anNveklSYkZOWCsv?=
 =?utf-8?B?UXhKbER0dDlvZ0JVTmZsUDdDY1dFOXZIaEc5ZUhxWjk4bnlGRXdoMTV3YTRJ?=
 =?utf-8?B?c0QwWW1jeVlMRFpzUU50bEZYYnVRNHdtSE5BVS84VmJwVG9ZQlIrMHpYTEJo?=
 =?utf-8?B?Z25KUXBndE5EU1ZTTGp2aHdjZGhlZzJsWnI5SjRsdjA2VzNUbVRoT0p2VGFD?=
 =?utf-8?B?Wm52cnQ0RjJWK1JMUVlVRnJsYlRxYjhGWndmdTBPYUoxS2N0OEdVSzVzekda?=
 =?utf-8?B?YjZxM3dxVE8vK1E1c0k3YktMOHFaRHp0azNJMzJpQ25VRlZDWGhIZGovc2Jt?=
 =?utf-8?B?MlJTOWlkamxlNUlsY0kwNkFPYU5vcW41cGlWRjRoRGlGeU1NeHFrbWt4eURX?=
 =?utf-8?B?M3BKOEhKREJVZ3pJRWdHRmxyN21PMHVPSEhZR055dDBwaE8wTW9SNHZpYXNh?=
 =?utf-8?B?bWRxcUpWSmFVVm9taHNKLy8ycW1jMVFYSDIzcVdJd2IzM1U3VnhSM1JkcTRq?=
 =?utf-8?B?SjE1d1hvbFFsNFZMeS9ZbThZVHNCWHVEVDh1TzltV3htWDBDMFdYR3hGY3g4?=
 =?utf-8?B?dDVGZ2c1b3YyTHZNMW15WjkxdTlDbzBJd0dFdFVFY1c4bDR3cy95WnBnand4?=
 =?utf-8?B?Q1pEVlVHQ1FzUmFrSTVCYTdDeHZZay9YZ1hRN2pRWWRaNittNUVFQk9OeTZF?=
 =?utf-8?B?a3RiRzRFY3A2eUh0clloSXJsQmMzRmJaOFNIUUZZWCtxWGxNcU9oZll1UjF0?=
 =?utf-8?B?S0h6WXFWUFpTWUFUTlh3M3ZJOFczUXBnMDQ1RnFxNGlvU1FYRDdjaWliSFVP?=
 =?utf-8?B?cldab200ZFF2YnNnZ1F4OEZMNlhjcyttMmFXV0kwYkZrbWc5eVdabEhHOURZ?=
 =?utf-8?B?WENFUytEbHJyNWdPcVN2bjNWSjZJQ25uT0lMNytyVWxGNktXOTlESTBqK1Rv?=
 =?utf-8?B?TzM1NWhXSzBjbXowRDNVS3U3b1VDSExRRVgvKzhxNnZGelVxWEp5YkpnaDdC?=
 =?utf-8?B?VDJvZDNpcXc5UGVzTng1SE5Gc2FxREtZdjFrQ2VyM25jMkVkV3M3cFMzL3ll?=
 =?utf-8?B?MFUxc1MrRWVXaWpuY1dCNVJBc3JtaWFraFZrNk90ZE41WUIxRmR2eGYxR2R1?=
 =?utf-8?B?dFhTc3prL0htMU9taWZiUnUxT3JkcHVoSjV1VU5Oc3lWMWlqUGIzdlNsbmJY?=
 =?utf-8?B?MTgzc0swTkkwVWVUeTV1WGI0TGE3Y0JQY3FmK21hVnV4TElWTldFMy9lVk5T?=
 =?utf-8?B?cHB4dzUrZWJIOUhDTnRMYkx4ODBrbnh4aEtXT215T2xOd0FmVCsyNmRXTHdI?=
 =?utf-8?B?NnpRcFRQbm85WkIxU2NDQXZEU3FBa2gvRWsxU1BYNWhTVUhWN2dvYk13aXkr?=
 =?utf-8?B?LzF4ZktNSXRpdzJCSUFwb2VKczFBeGUxNWVjam1rOTdzS1dlZUxROWZRV0pD?=
 =?utf-8?B?OU1UajZyQW1NUTdKOFRqRWhEaWovbmxQUzVxSTNIUzZGdyttSVhaaHJlY0kw?=
 =?utf-8?B?YTZYRVNJZThEUm1jREMyalhEcjFnRHdTakVkRENWYUJ0T3IwVEUrZEtmWkM2?=
 =?utf-8?Q?Gj7ZbVWa4jAtKe9HwQ=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e08e4f57-a38b-4b2d-8bcc-08dacd596a13
X-MS-Exchange-CrossTenant-AuthSource: SEZPR01MB4445.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2022 13:48:34.8357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR01MB4506
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


Hello,

I am writing to follow up on my email.

Can we get on a call on Friday (25th November) or Monday (28th November) 
so we can discuss this further?

Please suggest a day and time to connect and also share the best number 
to reach you.

Thank you?
Patricia Baker

On 8/8/2022 2:27 PM, Patricia Baker wrote:

Hello - Greetings,

We are a Software/IT development company. We build Digital Solutions 
using emerging technologies for Startups and Enterprises.

We can help you to become a game changer in your business segment, we 
deliver enterprise blockchain solutions that go beyond optimization of 
workflow and resources. Get a resilient ecosystem to privately 
communicate, accelerate critical processes, and continuously innovate.

What can you expect from blockchain?

     Automation
     Eliminates duplication of data
     Enhance data security
     Reduce risk

Solution we offer:

     Blockchain Smart contract development
     NFT Token and Marketplace development
     Crypto Wallet development
     Defi
     Crowdfunding
     File storage
     Protection of intellectual property
     Cryptocurrency Exchange Software and more

Can we have a free consultation call – we'll tell you how to revamp your 
existing system or hit the market with a new solution?

Please suggest a day/time and share the best number to reach you.

Thank you
Patricia Baker
