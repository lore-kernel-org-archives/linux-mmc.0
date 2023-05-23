Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63B19C77B75
	for <linux-mmc@archiver.kernel.org>; Tue, 23 May 2023 02:03:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232387AbjEWCDe (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 22 May 2023 22:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbjEWCDd (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 22 May 2023 22:03:33 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2074.outbound.protection.outlook.com [40.107.8.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A197CA;
        Mon, 22 May 2023 19:03:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Di0H1//rtEI3iljK1JGAoohIGFQugpZa5Tf+AbWubYr7iAMOFAZvNZqTDf74bMfM2Lk4a6RKavfaTNFL4pXJf3bDmA2DqD6UsyjPRTewOGjenqPyrlyomUNLbTdZPyCYvXJQ737yhmesja86CJWPTbpqRewTUWoS6U8FFV69HxAzhJLxSuJ7Cg/wVJbposE7omRb2RaD+YTr6ld6lp+pPzMtxIQdvaiSvXC6UzkBds8J0uQxYEeoIS3Iytar3Pb5sIZXyhYmkMbrs93+3m05SEgnhE3Lhb8Trz5WyTN20RA8sJ0nyB7dS6tRv/I+2d0YiAWvfpM98JqnHwqCp6BF/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TUh82mQc6HD6g9smvltykSrtbePfzFc8GGItJRzDG44=;
 b=kguCD/YmoPN4woVzBOhisjsl4M9JbVnhtCroFzMXmpECiNjAaHkbBY7Gj2aMkUmjxq/ydRaJVp+lKmcNjpFTbGkGBkdBrRhbdRYSvONWlsMK79iq43OQbjRLT8NgEfBu4B0IsWsGczPo5TDr9Up+63X6ysUEiNezoQnCfvkcj3uCpK5lOE8s+ezVGsWK9D+6dbbqTfT0cknMjIpPLxBrqkxco28i22i6MiMn035FNX1SCV+IUBBVn5QwtiPrlj3mkZUMACDDmWTUj6fPwiEPqfyQereoBTKcBYLpoE6RrPwoxkynDSZpYvDL/6XEE8znEVGAgmCkorsPxn6zOhdjVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TUh82mQc6HD6g9smvltykSrtbePfzFc8GGItJRzDG44=;
 b=Dtgs+iG5U0jA2Ede9F67UDDexYnJiYJ4kujuPeDvrAXOBTMxthwNkUGE6nWSqYwxNrHrptZBwFJOwQbYWf0j5VxAoYAq8dpcxMyIaayo0FpIohxI8e29v5MEbfFmRQ4oxSUyYU21DLdTIqLkPGQgyWLoYh6XxZQ0fl1tuFzXndY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.29; Tue, 23 May
 2023 02:03:25 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4%7]) with mapi id 15.20.6411.029; Tue, 23 May 2023
 02:03:25 +0000
Message-ID: <9ef80685-3ef7-ac59-05a6-0c46e0ecf57e@oss.nxp.com>
Date:   Tue, 23 May 2023 10:03:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 3/4] dt-bindings: mmc: fsl-imx-esdhc: remove property
 "fsl,wp-controller"
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        haibo.chen@nxp.com, adrian.hunter@intel.com,
        ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     linux-imx@nxp.com, kernel@pengutronix.de, festevam@gmail.com,
        cniedermaier@dh-electronics.com, devicetree@vger.kernel.org,
        kernel@dh-electronics.com
References: <20230506074037.522961-1-haibo.chen@nxp.com>
 <20230506074037.522961-4-haibo.chen@nxp.com>
 <d0329227-b579-5557-b449-7961ec0a1463@linaro.org>
From:   Peng Fan <peng.fan@oss.nxp.com>
In-Reply-To: <d0329227-b579-5557-b449-7961ec0a1463@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::13) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM0PR04MB6900:EE_
X-MS-Office365-Filtering-Correlation-Id: b5ae4132-59df-4b38-108f-08db5b31e463
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gr6QOcEvTe8IiiQmMsMvgfhYMWZiVeAR1Gej8GKTPHxSvU45QXo0KyX1KlgP0tKEBpRxTtwSZSG/z7GOu1/+yxMxia6RhBKv0Ym9+MAB6SRbg6mB+15NR4oNw6nuanNm+6H+72uv4+cxAADstSuqs7SYN94TB/YdxvL++zQd3jXaSYBSDRdmsp70NGg8d1y9YPCz2xDDdo424C5f/bJb1ljBILZXIbkmM+Tt2gJdUAHmvdQAcKtX6zRzfgeM2aJwTinWyMdLjfOeJshHirvbTd0M6AbLV6De5i/x12VXGNjRRt4JAxfR7RruJBWfWn79RALnzEjdXG8J02f+mvDGrDrgzGdSw1c4wnzY6DM2RUAhoeDfTlleqtY1FR6wS3o0yzMV8ZnN329hxqMfkZbIfDigkVbosQAWLDhCyGO5or+FtLktPa2vRcqAW/iOEzd87R2SDJK8leaprHAfeJTG21hGPJwAPa6jFa91D0Vv9UKcVPwnreLCCyOGq4GvaZe7HzpRYq9fVHCKoR2rxxZ4s+Diks3B/FTMtsaql6ITEiqGxbpIeTwYowlLZxMxllcDr3y9z9G52Id+luLnyf+MExA8VXzq771uwiX3YkIs9eM54O8aEFsc39ewXfCoraX9MvQnoKi77GJ0hUC9iAfN7Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(366004)(396003)(136003)(346002)(451199021)(2616005)(186003)(2906002)(44832011)(7416002)(8676002)(8936002)(6512007)(6506007)(26005)(53546011)(5660300002)(478600001)(66946007)(66556008)(66476007)(4326008)(31696002)(86362001)(38100700002)(31686004)(83380400001)(41300700001)(6486002)(316002)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dThRTHdqQWVPU3pZcXB4QTFpT1pVZGZRVjFleS9GRytySzNrSEN1MXlLZnRC?=
 =?utf-8?B?aGRXQ1RFSFhzZ21MU2xvRWs3L0tGYktlaHFGOUhsUCtteTYwMWNnenBPUEtG?=
 =?utf-8?B?Mnh3ZDBxaHNlbUlENmR1UUZDc3lJaHlndkw5bUNXSWcwUnVndldxc0pzN0po?=
 =?utf-8?B?Qkx0Nmc0a01jTklzMG5XeG9uMUU0ME1MNmMzWnduYTFFQldsMWkzdU5RODN3?=
 =?utf-8?B?SDFCbjVrZ1BlWGkxZkFkSjJiQURrNW9NZXRDNTdIbmEyTVcraUYwWXZXOS9Z?=
 =?utf-8?B?bHFuaHF5eHNQKzljZ2pobC9PWXR4aFgzblJsRTVxakZycDZnSUtvRmIySGwx?=
 =?utf-8?B?RnRWOXhyS3lpdkptWTQ4NWVwN3NINFFBRTd3ZUx5T0E3RmM5Yi9mRXNLTlV0?=
 =?utf-8?B?NGh0WjJIOEczQUgxd213ZGoyYTRqNFlORXdaQXVpbjdETDZLS0Vac0dEK1RZ?=
 =?utf-8?B?cU5JMVRRcDRIQVlrZWhqWkJkNGVyTE5VL2ZVQ2c3SEk5M3U4M0dJbGFOS0lw?=
 =?utf-8?B?QWZxNTQ2Y2x4T2doTUs4QXJXc3dTUHREaVBmcm9VamgwK3FPYWlXV2hvL25u?=
 =?utf-8?B?Y3FFSHJrOU9zWTg0YWV6VGlwbElHUnF4dHFQMUIyRGRBS3hidE00RVBDazBZ?=
 =?utf-8?B?QU5ta3BBKzNiRmZxSno1T0RSZzI3bW5oNXFTelFSemJNa2x2b1VRcFE4dCtQ?=
 =?utf-8?B?MHBpMFFGdXlYNlRJWXJLMnJ5M2Fsb0s0QzkyNkhacVliejlpRTVZUGx3SnVW?=
 =?utf-8?B?YmpaclQ5d3JWRDdBNGlVWkVyYnRna2RsYk5odHFFYjZjNTk0NVVtT01VbFY2?=
 =?utf-8?B?TE1VRHF5THdzM0RPdHZ1dWpvbDZJK3Fnc0w3c2gwaXFpUzFTNWsvTUcxMXpR?=
 =?utf-8?B?amVHeFNKVkRyQngveFFEUnVYQU9kL1ZPYVBWYk1DLzY1YSttVkFpTFYwSVdi?=
 =?utf-8?B?WDZCRWZSN3A5cVExN0hWQU1OWTRsendQOExkQ3V2NWdnL0FrL2EvWVA2V09X?=
 =?utf-8?B?UDZWZjVxS0dKUm0weVEwOE1ZLzR6Nzh4R0tOdU94aVFiSHYyYjBDYS9GL3k3?=
 =?utf-8?B?NU9oNUdVVjA1UFF5dU9mOWxqM3RpVldaUitQVXh1WEdaVzlNYTJLOHdOUUEy?=
 =?utf-8?B?bEZPelE2eGRlUkk0cXd5M05xTVV6M2xneEJuNXNXL3FDY2MzVVpxQzZoT2Jn?=
 =?utf-8?B?alZGaHVwcUhnQlRhT0RGYmh5aktreTIwTXY0aSszZWh2cTd3T0FxaXdZNUlP?=
 =?utf-8?B?bXNyZUE3c2dQQndoenh6blFyV2l6S3ZLV0NmM082TWRGODd2Q0NXZ2hSTTky?=
 =?utf-8?B?UjVSeGpudTI0QmZEOFlEc0x4aWEzMHNSSXFkekhndnliYmxQWEhBM29aMzgr?=
 =?utf-8?B?L3VHa1QveWl2L0RLN1RFVkZrdEliM01LdE5DMWlXOHZCUkt2OThLZmJacS9u?=
 =?utf-8?B?SzA5NkRhZjJvTG04RW1JaVZycjVUTzc0elM3V3A0aTJsWnVaTGdSNkkyVS82?=
 =?utf-8?B?UGN5ZU9SOGRUMDVLMEZzL3FHOHRjRUZYZ2tSczdjMDdLTEVLSjRFMUxReWZz?=
 =?utf-8?B?eWh5ak5SSDA5Mko5eE9LUEI3VHE3eXB6ZWNkQWZjVS9RS3lvQ1kxczZZdEZL?=
 =?utf-8?B?NzNWOG9DMnI3Z2ltdnZEUXg0UkVPai9rWmZwNlVmQXp2TDVDZ1IrUmh0dnM3?=
 =?utf-8?B?YVZiWGhLcmxkZWtqTkUwN1RHbjZDQWI0Y3BPOUdxcHhyNlZOcHhQcmxYdC9w?=
 =?utf-8?B?aFpPbFNHTWtrcDhtSmhNY0d6UTZhWDI4TmZiZmZlUHI1dnEvREV5T0xoTW5m?=
 =?utf-8?B?TXM0em9MWkMzbENHMjJWUG1obkltSjUrQnhHeE9aOXJ1bTRTUndhbDc0WHpt?=
 =?utf-8?B?ZW1DOVphc2hGN0ZJdlJPN044UnorUzYwS3J3Nm1odU9IQloyMitvamlxcTFw?=
 =?utf-8?B?RzRSakQ4M0FqUWJldkszS0tQVnJEY2EwYllsajR3MU5uejlyUTBWcXF6Z1FE?=
 =?utf-8?B?K1BrUkZMYzVGL3JKM3ZNbXFtZFNoVUFUd0prM2dSUURFakZyTHFpWktoTGNM?=
 =?utf-8?B?VWs1amVNWnkrTnBtU0g2QVhReVdZSlNkRlM2ZXgvQ3RVZ2RUaHh1MHpzYTNL?=
 =?utf-8?Q?d/837Lec1LB9T76K3ODM8ZMNx?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5ae4132-59df-4b38-108f-08db5b31e463
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 02:03:25.0588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b/402VL2x7a2utgazw8RTKmb7bklRAHIhLV+XHPB2bfozW11YZ4moOW+6Cpyi3ZD5RIPGRxADDYmnOvyAAOmDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6900
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org



On 5/6/2023 6:59 PM, Krzysztof Kozlowski wrote:
> Caution: This is an external email. Please take care when clicking links or opening attachments. When in doubt, report the message using the 'Report this email' button
> 
> 
> On 06/05/2023 09:40, haibo.chen@nxp.com wrote:
>> From: Haibo Chen <haibo.chen@nxp.com>
>>
>> Driver do not use this property, so remove it here.
> 
> You still need to expand the commit msg and justify why this property is
> being removed. "Driver" is vague, as it can be BSD driver which also
> might use this binding. Instead describe why this property should be
> removed, so we can understand also ABI implications.

The better approach would be mark it as deprecated.

Regards,
Peng.

> 
>>
>> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
>>
>> ---
>> v2:
>> -fix dt-binding-check issue, also remove "fsl,wp-controller" in examples.
>> ---
>>   Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml | 6 ------
>>   1 file changed, 6 deletions(-)
> 
> Best regards,
> Krzysztof
> 
