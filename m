Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B2C1C433F5
	for <linux-mmc@archiver.kernel.org>; Thu,  2 Dec 2021 16:19:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359376AbhLBQW5 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 2 Dec 2021 11:22:57 -0500
Received: from mail-eopbgr00041.outbound.protection.outlook.com ([40.107.0.41]:11583
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1359409AbhLBQW5 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 2 Dec 2021 11:22:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lZQ6WelFzEWb7pEo5sKvalnF7NrjIj0t6oMjo94ScfuwfaW3g8N9AQRJgHMOk9uhgaSRzdMGsr75sDElN9uqODzBy0TJALwngq7ljQjip22elAdKBdlMuA7gMO5FSkqialwttZ6CQO6KfIfVRNtlvP8ujONOQ4grx/7KLwW/HGk3urAlGbfpG/j1JeLlW12INWtvsiVPl68y1cRpGleV4g+dNPBFimErbwBq/pTZZPIXyPEf6t417lt1/IR2C3+CsifD66aUULLXN0XVmv3Ow1I6YvE3thNss4Tv9AQZCpc2A4NC4BRm8sRoY5/Xf3GwIcHYVCscbP8qjWNFEjCJ4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=802ril0btSk8eLrwP3Gy7ojs/4ULMHe0jyWukiHkaTw=;
 b=aVmdNuB5W7K8tsYCT/vyBckTRrBj/omiwxqLS/JHlB9fBunXBYqeuSDWmF/ufOhMR3QzYc48CfeL22D/qYYN+ZdmhQazL7VYURlzCaO0S5PWDQd++1bCBiy0yeSz7pLLxT57Rsi1ccwU205EeQ/P3h4lttIsa25xkQN9Og4opRjesG/pfIgn4aatHynmR7F9hWRnIs3EWLBkE0eI3ip0mggqE462ExnbCoiVaL4FKKdWhPri7OoWLeQvezsMIHya4N8BHlt3kZhWo8zNR1+kg2JFIJlZg7EHcCoJq1KpRPv+De6w2DA0py22Ku+pWkQN8hMfGLn53//7uHbycivQZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherrycloud.onmicrosoft.com; s=selector2-cherrycloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=802ril0btSk8eLrwP3Gy7ojs/4ULMHe0jyWukiHkaTw=;
 b=esjTAY26Sp1p4g46PxCqbJmJyYfOpXHeqmj5HGbYjcQzJHAoxkr+dT79c2nX7smsuAGyx2Yqc/ALVmQGkUXHjdenProlwONN9End7CHZU4O5a+BHJ23PtQJ/JLbPQM98Z/Y34ustk3QGTsXT28UZDssdJ9WlfPV3rCj4JEbjOIA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from AM0PR0402MB3348.eurprd04.prod.outlook.com
 (2603:10a6:208:24::24) by AM9PR04MB8100.eurprd04.prod.outlook.com
 (2603:10a6:20b:3e3::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Thu, 2 Dec
 2021 16:19:31 +0000
Received: from AM0PR0402MB3348.eurprd04.prod.outlook.com
 ([fe80::d56f:ec59:3bd0:6d7a]) by AM0PR0402MB3348.eurprd04.prod.outlook.com
 ([fe80::d56f:ec59:3bd0:6d7a%5]) with mapi id 15.20.4755.016; Thu, 2 Dec 2021
 16:19:31 +0000
From:   Quentin Schulz <quentin.schulz@theobroma-systems.com>
Cc:     linux-mmc@vger.kernel.org,
        Quentin Schulz <quentin.schulz@theobroma-systems.com>,
        Quentin Schulz <foss+kernel@0leil.net>
Subject: [PATCH] mmc_cmds: add HS400 data rates
Date:   Thu,  2 Dec 2021 17:19:10 +0100
Message-Id: <20211202161910.3944640-1-quentin.schulz@theobroma-systems.com>
X-Mailer: git-send-email 2.33.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS8PR07CA0054.eurprd07.prod.outlook.com
 (2603:10a6:20b:459::32) To AM0PR0402MB3348.eurprd04.prod.outlook.com
 (2603:10a6:208:24::24)
MIME-Version: 1.0
Received: from localhost.localdomain (92.42.140.82) by AS8PR07CA0054.eurprd07.prod.outlook.com (2603:10a6:20b:459::32) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Thu, 2 Dec 2021 16:19:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 24576705-ecc8-4cb0-7f14-08d9b5af8567
X-MS-TrafficTypeDiagnostic: AM9PR04MB8100:
X-Microsoft-Antispam-PRVS: <AM9PR04MB8100B71888D8930622F1E6A8C2699@AM9PR04MB8100.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B0wmnIDdMwcxVpAkzlOX+x70nyDTGyrV6+HsgygCyuqCEPW5l6CPYpie9RNI3svoMYFKCAouNajkwEp8kw33L8vvHWNUwjwSP/NuAUI/Q0YeEXjrUp9gtP4XyzdmAZN7VvIGOrXjAAJcEO/LmAGoXDOsrUzNqrZ3mH3l38pw9jSWlwAcddtVJrJHwC/KDHkL9etJbGMgCm5kh/6GpJDdrum/09zsEUDZjXhI/splpBvI/VIuc7VpitQzr7wlJxRy/6uiuFzR1MokfedHVEEieIPjFTj7QgnTM9O6EplzzBEWp43qY/4dE19nX23rfbNbMQDFJRXtgjltljaLxxiTem/MbqmJ7yxYdm2wJqEYmNGVAOH1V7/6iAylrT/lFk+QtidZAjBBdEpZPabagOQO+tlA+tiDQFR7S3mKXDiRPPK9bvWWgrT+GOy4VEFZSfauA7197sgCgvQlusGWTJnZ5gDH5056lGYuuKcBTrUvWXUAmhGTVVV/zgeGeJ8vM4Us+WTDupHKytBL+knDHlSwERBpnJtjhQxTEX6dHufBUVQ6fDUIZrl3F+hiFuvLtd37PiRMvdnctOSHu7508RjTE6ROMEHvjU5yZ7PyM74hl/wSnYJ7nv+Ii/PuLEkbwO+ftVE6a8MVZu0EKjRVg1zJspxIn1/nowPjqo9wI+8OjtAWwkv2xa170zgBniY+ps/Yb5mQesfp5O4X2Lmz3SBhEHhyzqXqvMajMIk0XpAnDBg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0402MB3348.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(508600001)(5660300002)(36756003)(6486002)(86362001)(52116002)(109986005)(316002)(1076003)(54906003)(38100700002)(2906002)(38350700002)(8676002)(44832011)(956004)(8936002)(26005)(66476007)(66556008)(66946007)(6512007)(2616005)(6506007)(4326008)(186003)(6666004)(266003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SmZDc0N5Uys4d3FRb0k2ZExPdCtyLzB1cGVyQ2NvRHltYVpBdy9Ea25Ha0h2?=
 =?utf-8?B?TTdvNlE5blJTT1FleEhyLzNkeUZUMTlHcWFsbkZmV0hoNHlFdER3N01mYjg5?=
 =?utf-8?B?Q1R0UHdKejVUekQxWWxLVGZPbjFZa203Q1JHcmgzUW9SdExSKzJDY3RvdFlD?=
 =?utf-8?B?SktUUFVxYnNVWFlxTjJBM0twQXU3ZEJ0ZnA4dTN3Y3kzYVQ5dkE0Vys5b2hr?=
 =?utf-8?B?MEJrVm1oVkYrWmdGbFMyM2w5Mm9RUFpDTUdRckFGbytzWFlmM3grNkt6WDRn?=
 =?utf-8?B?SFk3UDlLNDJxb2hvRk1YbnBWQlI4d0lHTFQ1ZStZTFM4NjFXVGRRUzFtVFFF?=
 =?utf-8?B?clpYUENyVFFNeE9pK1RObDBsanNJYk5Fc2UyOUNJTnhUcjlkNnVEMGhVN3hN?=
 =?utf-8?B?Zkt0TnhER084MjBRRVBGamZnZWxQc2xKUVh3bVViaFFreFovc1NZa3lqdWth?=
 =?utf-8?B?N3hwUzZuSnBFa1gwNjE1S1Z0YWxiSmE3Wmt3UnlZZDAyTE42emlIb3NIRVE2?=
 =?utf-8?B?eGtQN21aUTVKbmVyUHdtTHh1cGJ5TDhJcHhqNnpkTUlqUTBFbzBlN0JCcExy?=
 =?utf-8?B?MWtqaVFBTFBpOXc2NmhRVWdvMEljTnBQaXp5Nk9LVmVWQjIzekQ4QkZBaGdt?=
 =?utf-8?B?QjFFTjVVWmo2NCt2QVorQzBsdjJydnp6Y2x3aC9hb3V1elM2NnBjUExLVXIx?=
 =?utf-8?B?d09tdFNiOStoaVN3MlVjSXh6clQwQ1I3VzVjQ1pQRUwyMjlsWjg4cVZ0aFFy?=
 =?utf-8?B?YXdiS0hnVEdNc1F2dGg1bk5CYVJiL25Idk55MWlXRXlUSHZ0TUlpckl3bXJD?=
 =?utf-8?B?YWpZRVFGcS85NGdqWTJCUHpqVlRqdDBCVWNwQ0JoNFN4RWRHblZjd0dIdVpp?=
 =?utf-8?B?NW1tc3drektBNlpaYjBjQXVBRGhkeXlWQ2NPcVRrUkQ3a2NDK0FnbTNHcHl4?=
 =?utf-8?B?S3JCZWlCL1Z0ZzFkRkFIMmovaVRwdE1uV05vdXFrMjU0cThKMjFTejQwZXZQ?=
 =?utf-8?B?VEtzNXBiUjVra3FSVDRGdGUxaTRuUVBOWEduQnVGS0RWM1dLQ1BpUXdsdzIz?=
 =?utf-8?B?STM3dWJ6RkhTODQ2WnRkUURaSUxqcGRQMisyOHBnZlp4dkN2UnlVREZYa2RY?=
 =?utf-8?B?akdWbWM0N05qNGNqeDhLa25wOTFEOUwxVlorOWp4WEwxdElsTm42OHdwQ2sy?=
 =?utf-8?B?Vmc3UC93dFZrRGRLZThidmxtQUlubGF1SW52M1llL1EwcTJQSjZzSUhBNTAr?=
 =?utf-8?B?YXYrbTRscXZTbnBSbEpORmV6NTd3U3pwOWZJY2RMVTlVazRydFgwZWpiOU1w?=
 =?utf-8?B?U1VvY2tDcWc5Wlpod01lYmNjWlV0b3hYT2o1Q1VCdmVpT1E4cVgrWUh2Kzdh?=
 =?utf-8?B?SmNqTXZESVF4aGJSV0pQVlJTemFnbmNDYjBYUk1hTllkdUZzOEVzU3BDQ1pY?=
 =?utf-8?B?ZGs3RGhRNEprU1VsaGkvL3NQY2JSNUxnblBkSnVHK25IUkpCb0xLbFF2NG5M?=
 =?utf-8?B?dklLTEFiU2xwa3pFb29RZHBRbFovc2FwQXd4bDRTVk5aTXkxOTZGY2dkVFZE?=
 =?utf-8?B?OHpwN3pCRnZkbXZ4RTQ4Vm1pK3Fvc1g0Mm9RMWhPVTJYd3d1UVFyUUhrcjRz?=
 =?utf-8?B?RUsyMk1HZFRiMVVTc3Jab3kzcFp5R2NYRWlWWEd3YzBFZXVCZEwzcnh4WFZj?=
 =?utf-8?B?SElCS08wUXh1RVFhWXhFblVOeVlVTmZGdXpudGxScFNXcDVkZzJtOEQ1bEkr?=
 =?utf-8?B?aVVpa0o5aHhDQ0kwM3pPYkkzWkp4WXZRWDUrSm84cSsxaXZPQWVlMzNYVElP?=
 =?utf-8?B?aE5MOElxSmhxY1c3bVZwUTRBWCs2OU1JNjVtTkUzVG4wT3VBOGJhMnk2cVVh?=
 =?utf-8?B?eGJncS9uT011TXRyRzBVS2YrYzlaQjJka0VPTE83dHRIdDdYcFdzR1NzUXdU?=
 =?utf-8?B?elhOa0NyeVM5RFlBSXdISUpOVWNVbEpGTDZZYzRzV1B1YWtYU0JRNzlwZ01H?=
 =?utf-8?B?dE94QTBYRmIreE16VHpNY3VxT3VnZ01pUzBTeFNSYitSSm1nOEp5eThzWUt4?=
 =?utf-8?B?eGtlY2EzQXp5NGtpcWJYRVFycHhxVitVU2tuVUpTNVlzaTRQVkI2emNkTzd2?=
 =?utf-8?B?ajhCODJpaHlZSFhibkNpeHppTTM2ZC85TDN2anhXZHVET280aDdZWWI0MGJr?=
 =?utf-8?B?a2t6SWJURU5uSjg0R2Y5Z1BESTFBNzdlVExnVG8vRytudkJzVjJxUVY1bkNC?=
 =?utf-8?B?bzJjSUw2eHl5aDcwcXBQMUdsSWhXZElPVnBBdXdRT09ISm1BSGh4SnBkMzFk?=
 =?utf-8?B?K3ZHUTFzYW94bnlqa2MxcDYzaTJWV2VCeXZKanVVay8wbHZORC9yZz09?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24576705-ecc8-4cb0-7f14-08d9b5af8567
X-MS-Exchange-CrossTenant-AuthSource: AM0PR0402MB3348.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2021 16:19:31.2552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +AC3pecI7VgJVbDBSIp4cPWOxU9WdCJ+mFdf2zl0iQ76XuyWaJw7K0mA3uwKZRBb7UWWS3+7f2zdRtZZfVFBYE7sLYaa8vz269cse75HsIdI5OPkp/KTlWnM92q688mi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8100
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

JEDEC 5.1 JESD84-B50.1 DEVICE_TYPE [196] specifies that bit 6 is for
"HS400 Dual Data Rate e•MMC at 200 MHz – 1.8 V I/O" and bit 7 for
"HS400 Dual Data Rate e•MMC at 200 MHz – 1.2 V I/O" so let's add those.

Cc: Quentin Schulz <foss+kernel@0leil.net>
Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
---
 mmc_cmds.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mmc_cmds.c b/mmc_cmds.c
index 73bd32a..769e317 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -1613,6 +1613,8 @@ int do_read_extcsd(int nargs, char **argv)
 	/* DEVICE_TYPE in A45, CARD_TYPE in A441 */
 	reg = ext_csd[196];
 	printf("Card Type [CARD_TYPE: 0x%02x]\n", reg);
+	if (reg & 0x80) printf(" HS400 Dual Data Rate eMMC @200MHz 1.2VI/O\n");
+	if (reg & 0x40) printf(" HS400 Dual Data Rate eMMC @200MHz 1.8VI/O\n");
 	if (reg & 0x20) printf(" HS200 Single Data Rate eMMC @200MHz 1.2VI/O\n");
 	if (reg & 0x10) printf(" HS200 Single Data Rate eMMC @200MHz 1.8VI/O\n");
 	if (reg & 0x08) printf(" HS Dual Data Rate eMMC @52MHz 1.2VI/O\n");
-- 
2.33.1

