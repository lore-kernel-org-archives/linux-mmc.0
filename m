Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3715C433FE
	for <linux-mmc@archiver.kernel.org>; Fri, 17 Dec 2021 13:34:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234200AbhLQNeS (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 17 Dec 2021 08:34:18 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:33090 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231836AbhLQNeR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 17 Dec 2021 08:34:17 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BHCT4eu004111;
        Fri, 17 Dec 2021 13:34:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=zMBI4SqZsJw1qJzDdRjcBubQhzLCv6myZwJSftt8XKg=;
 b=JCq0m+5yfXSCmCG/CYjcc3i/PK2S7L4/WQ3irA8maDCVcx6aq+4HKPjY/4jAizF7qEld
 z92zocQLZ1Dz/Y506Y7BVr8MB1PmgjWppuHlRvTN8DzcQJJjSfK4DThaafDpQPhOmtgB
 phWrVFyuTCxjpQk3E1RUzHPbi4zyCA0FcRVaIC3f4Ww8C8b7SfJBzeTy55gGodCO157p
 OS3DGZ/pGocxjK6l8m9fvKDvlMoXhRwJKnBeosX5520/C0VWbGtnM+g3xKrbZwCpFM5T
 pmzoWIIPN7iHK3/ogf78B8h9yupfbrADcaGCdeZSnqY8XkF4Al03PW6dU7RfLVSjsqEd +g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cykmcnkhc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Dec 2021 13:34:15 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BHDTvrZ189073;
        Fri, 17 Dec 2021 13:34:13 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by userp3020.oracle.com with ESMTP id 3cvnevj9s6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Dec 2021 13:34:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MFf5bam3LjPf2Nl/SLe8/V/FeNFQoxVqk2fizGTvRmdfA68fkEco1kKvfnNdgVIVXRSzPM/XWF3XviaqZKF+b4y40bJpjFJY0VdQv35OY3E09O5kq1t7eWfho03mg0raV/766E1oirlvGkfijZtlfkgfDtd5HXn1Z//coyFM1K1ar99+D1aaO0wGCzwesWs49Gm57liu2P3COIeIVLCnIVSMAat5WW9qje4JV6zW45JOEbfx/RJx0ZNc7Nh1sH4KHh53UggbVq6nBkjHMCjQWMQ5WJeiR93dN/GkqZp+WxzcujrT0BbbkCed4PHCc4B4jhHlLfPs2VTUHUoF+WJfDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zMBI4SqZsJw1qJzDdRjcBubQhzLCv6myZwJSftt8XKg=;
 b=VlipCQAOHnMWpD14q9osXxjUH1Fp4v/lgKb94g6OGJM/4vnTQzfsArSuF06P4zYLGRlguJv8DhuDA9W17Cff2NxXFi43RVZFHnWKjqWLPHk3y+kdBTPcixzeP4u6FMzI0g2CSUmDuwXE5AAMIaPCVKJqj7ZC1JlDYvA1QouhfjRLswAZNfG5R6az+NDo5SEnoip8mBXdKjluR4SzjuQ5xeCdWbQy8YaNL9tMUbSycf543Zm0Wnbkyxo4VMJ5IR6AmNhZKcuH08EY4LS8kHk2q6XMb33O7PFquZY9Citd+I1bRrqrYp/ofGi3u6z+ivHvkovcS/SdWpb91txO3ehooQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zMBI4SqZsJw1qJzDdRjcBubQhzLCv6myZwJSftt8XKg=;
 b=N3VjmXea1AUgCqlLIdsNL9DUIvQcp5CW63N5xcPy9X57Kx4LDJWllTaSt+XF29ho8fdXIJoQn4gIIfOvyCAtOeRbte+U0Y9KKn+VMi518/mzDGdnEiSrfgZU2IRqkx/0fSA1tm3yQb5Ppf8fr73ktGyLnnirpoxV2WKmYwIPtKE=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO6PR10MB5790.namprd10.prod.outlook.com
 (2603:10b6:303:145::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Fri, 17 Dec
 2021 13:34:11 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0%6]) with mapi id 15.20.4801.017; Fri, 17 Dec 2021
 13:34:11 +0000
Date:   Fri, 17 Dec 2021 16:33:56 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     thomas.petazzoni@bootlin.com
Cc:     linux-mmc@vger.kernel.org
Subject: [bug report] mmc: sdhci: use WP GPIO in sdhci_check_ro()
Message-ID: <20211217133356.GA30427@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0013.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::23) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a38148f-112e-4643-1d66-08d9c161e8b0
X-MS-TrafficTypeDiagnostic: CO6PR10MB5790:EE_
X-Microsoft-Antispam-PRVS: <CO6PR10MB57902EFE40D64AB92ABE64528E789@CO6PR10MB5790.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SMNYoP3ojGrm8ub3j1htg5PsyQbWCsrpXlH58lVFQiinfE4yal6WlfseFKPDR5SqE2ic5V0r32aJEC3gqOHQBSFSIVRrYTRfdYMUpifBi3zIsqOzZHqD6UyQpeb5V7ieXvVNzRBxHS3LK0qtXm9U6w6IWfjWydyUXlGnJ9wj4dNdXt1SMAfr2e7te2k1b7JVjFMCZQoDVVZEzq12TSlEDXOw3PXYX4818MZVvmCuA70Tqqaplya/eOvshJ2DIJIndRHKgQ/lBbkGCgEeLuEXWz/G8qGG7oocvhwZTFGKvF35JMS1Of1SSlV3mG8MwfDKYXqW6aMTM5DtWfNo78RKb0GLVYnCPVkS8nT2dBjUnSHUAkWxgrjluP2b9K+0NuGEqBQLqxYOC2DK7UvgZctA9FuKunVTGPaaHaetGbw9AhsdfHlOO0yf9wHCHfAjWNWsCVJFOH/qb1qfnVwxdepZHZq2Ckr8XqFp1kKnI2QHD/KdwWNBlHyhsjEE5b29eJgbhW6ES5IMoMsGLvo/572JTSVBlIUfMYMN3pI3pzb/J4xy+/8WJaWfIgIqMg6ye7Cap9tME2LradD7tN98I5lDZDgwW3sW94w9pd+9kiusbMjHS7GPZ1/Ca36Ls1imI8wSSukg2FVgKa1f9p3iVjB4Jab8/Y60ersjoIxwfNqo/Mm7UljPy0JnEGkmrL83zjQMezc4myRGEhYbvw27ojOqpQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(1076003)(26005)(316002)(8676002)(6506007)(6916009)(8936002)(86362001)(38350700002)(38100700002)(6486002)(52116002)(44832011)(6666004)(508600001)(83380400001)(6512007)(33716001)(9686003)(66476007)(66946007)(66556008)(4326008)(33656002)(5660300002)(186003)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UMH2FKTPzRQBxHS90O1BTMRUlQd24NlSV/4R586ZP5wYknDvA4NAQLKJNLDW?=
 =?us-ascii?Q?TLJFovk0BBRVdK1nnHv9Ya5kvY732cWt9HGKyJhY744IPhFDQW4pjVeKGDvI?=
 =?us-ascii?Q?tPYG2GNql49KogGWehRSm/bmqfgNkLyJdLu8S8UgihrOu41o/Kcm27AT2R5c?=
 =?us-ascii?Q?w5xItF2RDj9LJxQMTVP7uSe4NdzwYKf0zCRBvOkvWlvG2fiNwIYWkPH3qc0n?=
 =?us-ascii?Q?t/QsUnAFjmG5XN3aFQeeJSngxpBKJuVpVaAOxL+VMql//2zLXJNKFkIFtEfe?=
 =?us-ascii?Q?n4N6JZO3Y+jP7trICmWD6AC7IoCDPFkATHIdG7PkbroUvv0o32c+kYm1sVQl?=
 =?us-ascii?Q?dTyQn2p+WMOtiJ111ebmUZyxFNg2yx0u/XFX03wIl3lsPN4fAiFhT66+yPbN?=
 =?us-ascii?Q?L/Is3MOP3j2nwPMM0aCdk1k1ScRc2f05KXhXio3fugNWDxgEHpcvKkXhVCge?=
 =?us-ascii?Q?aV56WqwMsIn1CRtRYhlL5s0GGFq5gnEWC/7CbVHnIGf1wb1CD4KfWiU0EtgY?=
 =?us-ascii?Q?pzc8HhHu7q80KyeVRUfQZsgJ9D4WKbyJUQL2uFb60R5myj1xkBC3DHBSa0DM?=
 =?us-ascii?Q?IhgcF6GcfRYDz2y3hLM8NwK45Gut0gCOJ9c7ncbJHeVCz2GFUW66n2TaNkXZ?=
 =?us-ascii?Q?+SGr5qHN+KK+0SnDnanRaGpqkcxdkS+m5n7c6nCtq56RJY0cnwiAnN3Dq9pm?=
 =?us-ascii?Q?Ki7ZusXlwwwSbkhoABHD+RbSqRQnH4rUzoleY30P6WFKpBkRia+ZNBLEu5NW?=
 =?us-ascii?Q?s8+tBWwxbYt7XHUUcVtwfVk/8JCPYLET2uy9ETBXZNp3RVl0Y00OS4ggpUaH?=
 =?us-ascii?Q?/m4p6C/Ochf6ySXorvQgvnEx0GSjDUmk8oO/mhvTKwwAmlBJgcrjTCilqgwL?=
 =?us-ascii?Q?rHkIv+wLmazW7TUnwi7Kf9vNGpaLZ/Dq64IsuKiA2fvd6GtvaPz6BC7U1A9u?=
 =?us-ascii?Q?AbKeipKg7q/pSEIR4aGgYcE3QK20JYX09eRZonmJNwa65kJVzqPUruIUg7xa?=
 =?us-ascii?Q?pNwKgfP+SLsNxI6H21ros09pM6owE48Cca1N2ReWbHpzpzHm49mU42912AV3?=
 =?us-ascii?Q?cW0J+mx8h1BQw++yAK5wuKjNfXnMBD8tQD/X3w7XHHOsy26PGvtpVTRPU9jj?=
 =?us-ascii?Q?5YVjnP3en/FRenVvCB/sug0ftghN5Spgi6K2B8VIRVkhtNZKa1XS3JHvdMqa?=
 =?us-ascii?Q?6kw4g4oh6bExyefeSSRBLu4NLjIDI/b25gZZyb4929ENW8wWiwLrGus2d8NW?=
 =?us-ascii?Q?rqflmYGDdjCdcv5VZc8ww3ZnPHlIchxK+5k7sEk/NtBGpFh8ZE+TmAT816ke?=
 =?us-ascii?Q?1WXR4JrOPnaJM803OpoXe1eYPbDp9rvqk1lN8kuIxwJJHnEk5QcftK7kPfNs?=
 =?us-ascii?Q?x698TYdS4DLScmo+oS0FmVqVrt5GfBaeNtxPts0UZGrcl8OdHY8uOZoqQBnU?=
 =?us-ascii?Q?U3i0dvle2i0d3wF8QRwLCaF52gweUPshLE013vUrPICEzZREs0LKVjlytWa3?=
 =?us-ascii?Q?OK3KKnGMv5UCzGNdPPKOg6n84XPUyPX7BHfPb11A4lQ6ZfjiDEl4h+gIc2zr?=
 =?us-ascii?Q?VaAva5ZNbVq3l6/Y9Seepxs2kLv08JEPScj1PpvtPN320HJ3fiaMAdGKBBri?=
 =?us-ascii?Q?nhyMdjqj32Ez/Qyk7osjGK3xMTZTo6HvEAvTMaZo87dPnshqSJEAhXounEem?=
 =?us-ascii?Q?KHzgkA947/bL7lti1GkARPk9vMM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a38148f-112e-4643-1d66-08d9c161e8b0
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 13:34:11.1019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CFuF8fknGdeX06Cm2MhJ3uhtfLHmpzPUkgV13upTtOLrepTTIqTrGCH26mQJC1NUqZxwQL8Dq0c0F8TKWVK+WENEEMuaotUL6tXf+LMvzkU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5790
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10200 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 bulkscore=0 spamscore=0 mlxlogscore=576 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112170078
X-Proofpoint-ORIG-GUID: z8gSAyyhdvQnsJne3UNi6jGa3J0LOjVz
X-Proofpoint-GUID: z8gSAyyhdvQnsJne3UNi6jGa3J0LOjVz
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hello Thomas Petazzoni,

The patch 6d5cd068ee59: "mmc: sdhci: use WP GPIO in sdhci_check_ro()"
from Feb 12, 2019, leads to the following Smatch static checker
warning:

	drivers/mmc/core/slot-gpio.c:69 mmc_gpio_get_ro()
	warn: sleeping in atomic context

drivers/mmc/host/sdhci.c
  2459        static int sdhci_check_ro(struct sdhci_host *host)
  2460        {
  2461                unsigned long flags;
  2462                int is_readonly;
  2463
  2464                spin_lock_irqsave(&host->lock, flags);
                      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Holding a spinlock.

  2465
  2466                if (host->flags & SDHCI_DEVICE_DEAD)
  2467                        is_readonly = 0;
  2468                else if (host->ops->get_ro)
  2469                        is_readonly = host->ops->get_ro(host);
  2470                else if (mmc_can_gpio_ro(host->mmc))
  2471                        is_readonly = mmc_gpio_get_ro(host->mmc);
                                            ^^^^^^^^^^^^^^^^^^^^^^^^^^
This is a sleeping function.  See below.

  2472                else
  2473                        is_readonly = !(sdhci_readl(host, SDHCI_PRESENT_STATE)
  2474                                        & SDHCI_WRITE_PROTECT);
  2475
  2476                spin_unlock_irqrestore(&host->lock, flags);
  2477
  2478                /* This quirk needs to be replaced by a callback-function later */
  2479                return host->quirks & SDHCI_QUIRK_INVERTED_WRITE_PROTECT ?
  2480                        !is_readonly : is_readonly;
  2481        }

drivers/mmc/core/slot-gpio.c
    62 int mmc_gpio_get_ro(struct mmc_host *host)
    63 {
    64         struct mmc_gpio *ctx = host->slot.handler_priv;
    65 
    66         if (!ctx || !ctx->ro_gpio)
    67                 return -ENOSYS;
    68 
--> 69         return gpiod_get_value_cansleep(ctx->ro_gpio);
                                      ^^^^^^^^

    70 }

regards,
dan carpenter
