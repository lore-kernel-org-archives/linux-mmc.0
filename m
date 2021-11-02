Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F51C433EF
	for <linux-mmc@archiver.kernel.org>; Tue,  2 Nov 2021 11:14:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2F6E60C51
	for <linux-mmc@archiver.kernel.org>; Tue,  2 Nov 2021 11:14:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbhKBLQs (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 2 Nov 2021 07:16:48 -0400
Received: from mail-bn1nam07on2046.outbound.protection.outlook.com ([40.107.212.46]:55030
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229720AbhKBLQr (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 2 Nov 2021 07:16:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NDEx4i2vVwsw43gT9Fv19at3Whp6GemUflX2Fufg/dckAnCgjkrKgEInHiLgc+9cNXIx6RSp+b3MSnnk93kphkl+ITVE9q905qRtvXPKc5WmFjZgsv+NtiHWeXd5fZjYTxBRMJwIudZITvku0qnGoYd5SRL0O2avIHWG5hDaJLP8jI36VHbUfOVOIifp9SSZZ3Vib5gx4z53mBH29yVOlTgkTDopy20XARu4qWEzIeLQCU47k3mOqoxfCUHQwlbbbjnnCmEHgMK669YWTOJe5Roa8BbExif+MmNtcY2Ql9r8oj5l0KapjK13vAZRfo2gA5MAL5sCIRFODgLtvxtmtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ohlRsf1kOi0bqT7KE7trKuttGIiwl7W8iKw4U+gEc9I=;
 b=LetSs6zyH2V8k2ROA8l9ht1hFDTm9QUqaapuvKN62nhOptOYwzX4PP/G08+t2rPOixfGeEiqqr9bBp4LJHBJ7Iv90FrYBDrSbm21j6jJvohXs7DX0JTRzFRCt0uoqRyyn3UcnxCsG2oqCNbs9JxGsr4HTCorQ6AYMyrAQ+ZU0Jhi5JIR7mDWzu0g+XmzfRwETqVYwhMYntLBaus2JmrHBskKvJTEX5x5lFpxrNlA+wQQoyouNRFaPSi+Kvs2XoE93TRrTwlD1IlE0n5tv0JRcwUbD2oLn8o7p7Px/wpeP+roWbTIvTSv1I5UqjgVueIikCZJbUlvOh/TrTGWwsyIyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ohlRsf1kOi0bqT7KE7trKuttGIiwl7W8iKw4U+gEc9I=;
 b=ii4kqXlRaMfcS/YPFg56XLFZmUL1V1oAfkqnflYRJTPy2Vmo6ra6178gndUaMLQKYXyicdePO8N//lU4QnPhKW+JFHF0UGYZ8SZvt1WdpMagH1k0+UNlsDZsu055AVwexv1Y27ABIVJo4sBZOoEQWx9cyQbr3MAhRdQRfT1Ppsg=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=silabs.com;
Received: from PH0PR11MB5657.namprd11.prod.outlook.com (2603:10b6:510:ee::19)
 by PH0PR11MB5644.namprd11.prod.outlook.com (2603:10b6:510:ef::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Tue, 2 Nov
 2021 11:14:10 +0000
Received: from PH0PR11MB5657.namprd11.prod.outlook.com
 ([fe80::999f:88c6:d2d5:f950]) by PH0PR11MB5657.namprd11.prod.outlook.com
 ([fe80::999f:88c6:d2d5:f950%4]) with mapi id 15.20.4649.020; Tue, 2 Nov 2021
 11:14:10 +0000
From:   =?ISO-8859-1?Q?J=E9r=F4me?= Pouiller <jerome.pouiller@silabs.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Avri Altman <avri.altman@wdc.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tony Lindgren <tony@atomide.com>,
        Bean Huo <beanhuo@micron.com>,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     notasas@gmail.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org,
        kernel@pyra-handheld.com,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [RFC v2 0/2]
Date:   Tue, 02 Nov 2021 12:14:01 +0100
Message-ID: <65944054.TfMWBj6dXo@pc-42>
Organization: Silicon Labs
In-Reply-To: <cover.1635759337.git.hns@goldelico.com>
References: <cover.1635759337.git.hns@goldelico.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-ClientProxiedBy: PR3P189CA0024.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:52::29) To PH0PR11MB5657.namprd11.prod.outlook.com
 (2603:10b6:510:ee::19)
MIME-Version: 1.0
Received: from pc-42.localnet (37.71.187.125) by PR3P189CA0024.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:52::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend Transport; Tue, 2 Nov 2021 11:14:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b88c52f-8613-4fe3-eccf-08d99df1e47f
X-MS-TrafficTypeDiagnostic: PH0PR11MB5644:
X-Microsoft-Antispam-PRVS: <PH0PR11MB5644C2A120CB6638E7AC2F48938B9@PH0PR11MB5644.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d5GfEEqImmJ66Fu6A2u8a8IAL1qFsb5kw4N7mVL1HVBTsM3/12VCYd+LMF3Y/a7EIqJVp8s/tMMZyualVJzePa6/PtANg06ofserAV2c9qzu8h1RLxvrfi9e9DzhrP04nZvGD2/7X0ZcFBj+0jSVK8oGWIdJ+2LoaoXcdL37P7o10INMiBW4ka0Qa9NsQS530MhRWAwULUPOzTQwvtHimurtXS0+OWup8YEqCUSjIsj/sFZjm9aqULbmwrRiZUcBlfYYNtBtRjtCTdWIsvkfUmTNsRIFOufs52jWYNOU1qaaiM1pnU6bKzde8dnyP8Kj7wla2Z3ig28YEfNQFwM62RC68a9v8S8If/Z/PhjUv19A2OtIqe+tr4y+cCnKDUKAGKVglP7efMHRqZRgtg8U8d0FTIRr/cgbbQzSzsTOHs/Zenx5wLr+61G8dWEN0BAB54wic/5ArPANK7VmMoiYI8lnvuPhc5dZSJeFPASh69DOXlawGpgu0z11N7OllZNjoQ9eBs0EMMTjfywYTZL6Tggy6WUgXYauxVaxUiYtvFxQlCjf4QNuwtSL6jI/VCnub+F2dRp6/fNKL6gfO3UflxvqH5Bsi6lZBB8bCYFMQRaFzxfnKiuE1+NXQUCVIP2g261w1mR3dW7Dq9K9jDyM2VTzPmutYuZ44nG6Pz3e4Jom0XfW7atgcXam4LSJ7Ek09t071h3ieroCQjF3esC3zIaMuh424YtGyzeUMd8lpYA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(33716001)(4326008)(316002)(66476007)(86362001)(4744005)(5660300002)(9686003)(6512007)(956004)(66556008)(7416002)(110136005)(52116002)(26005)(66946007)(6486002)(36916002)(508600001)(186003)(6506007)(8936002)(38350700002)(38100700002)(2906002)(6666004)(8676002)(39026012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?HDaho84DFHl+gZh3XxxU66PsrubR0rOghYXv7CFsu/WO+99m5PpP0Ed/w8?=
 =?iso-8859-1?Q?ky25f5oWFxGWuA6KHiarjKJl342keHLZ+sudSMWkHz+PqvMV5Ie7tCcp54?=
 =?iso-8859-1?Q?2mNfcEYgVr20AqAANIEeB0vCkY4vSiI6TC/No/FScM6CbFcjjn5GIui6c9?=
 =?iso-8859-1?Q?jGgu3L03As3xJ2KwnyZAxLhC86QZXx/XbEW2JSmcDQNExIcAbYBxZa6M8x?=
 =?iso-8859-1?Q?yCjYx1H1TTXLnFy/BcFViHDoNfSenkBfQYgOUb/sSD8h5h1/JnfVusDyoB?=
 =?iso-8859-1?Q?PSeds43+68nwDLohOiyrlW3bA+u7QZsnnkE7fpufrGn6GeMQTHsJ7/JuqR?=
 =?iso-8859-1?Q?hiw5jjM2L0VWONvMTyjM+5PUCzD6CPHg0ZPRximHDLj/t9rsnPF9AWc9YK?=
 =?iso-8859-1?Q?xI9XDN1N/bNM3BQX6mtDSWYuygZK+L1CRXnOMUs1h5mzdqJ8xp8B31Ohzn?=
 =?iso-8859-1?Q?zJdZSTKxj3LZTGu3h6Jp4vw1cbpPv5J5sQwZ5T54XU89eDlEQr2jrdT2X7?=
 =?iso-8859-1?Q?saL78h036jLphWwmtjNavm66/h08Qd24hzGUgHxxYIkSYeyJOoZ5hLdPt/?=
 =?iso-8859-1?Q?ILSsP7XEH+A/ASS+vlkozcBN1upqzBzHjKcXQGcrkKSNxHK18Bi7IG3cS8?=
 =?iso-8859-1?Q?r3hMLv6ehBi89D+xrYQ/JoHqzFGhRwjn/uZnYtc8AVCRVqiMz8Hj/bXntd?=
 =?iso-8859-1?Q?5lay8AVdMJ4vdRsh2aTy0UjzRgM7T3Isr9VUEvgLkrjThNu2qOBxTR61Om?=
 =?iso-8859-1?Q?KNuAI7YoK5Jw9zqDtQcXWwBbwh5ypGcefg2/4XVdFO5SdaEymdc5KKOrTp?=
 =?iso-8859-1?Q?bnfzt6pTP6Ofg6pJKk7lRvpbfp499VXKSquddRtfltGkH9GDdFQg235yob?=
 =?iso-8859-1?Q?cnK5bsMBycedeXiyGWdWwe8oxBYjd5AiTOLpc7i7CUv93isURcb4fnUOSF?=
 =?iso-8859-1?Q?Z+rdFzFJOB51td2ohbKPJVYP1GP89oryRQM2DzXwlebx3FtsIEnHs5VweJ?=
 =?iso-8859-1?Q?4uFce58kezI487j4jW4OUUkgo/JTrpu/05LhlFCk/n9ZkHRIfJQdzuRQxj?=
 =?iso-8859-1?Q?QAz33l1E3inUESVhZCMEjAXpW+eocabr/LdWOU5ux8UkzPR40qbf4s8DVs?=
 =?iso-8859-1?Q?tlq2WZo0JrtyQrnJ2I09lrwYSEQkvL2nkHeyxRccB5MgWh/Pj2RW/gUhRD?=
 =?iso-8859-1?Q?OC1GxoSPHmh/+7UUCvnWo9W8eoW5vxDqk+2cS6ksn3pNQutA2797YR3pj1?=
 =?iso-8859-1?Q?6jNE+u9jHPQFaKmQyLzHJ47sTXr0a4t+4xWFQray+Q5gMnSO9QJ1nkZs8f?=
 =?iso-8859-1?Q?bpMl5EzZ9GACx75Yc8iKE8Zbwkmaj3chL8W7gIUSQymLWnqO04ioS2RgcF?=
 =?iso-8859-1?Q?Ft3KU1M5wA/UTMueQBAFkX0TFMRBf4UNHgm0pKI0I6pMT4bYdLX50pWeWz?=
 =?iso-8859-1?Q?E7Vi3aWVCEn86YV3XCePgMoLtkwAUx4MAeUpf5KoZeqF48lUC9bYiHM7KA?=
 =?iso-8859-1?Q?TFQpkbXZZxYhzWFr9OP/IpupeLYdz1HYMIZzDNU6+rHUIblklZsgyUVbtI?=
 =?iso-8859-1?Q?clbcY9XecNAZ4qz1O3zSKLv9Tgdjl8UkD2F+1iqNCXCzxnFO10dTeuRpEf?=
 =?iso-8859-1?Q?mzbITCOyUyTJJaA+vP2E1RRJD7xzksaYfQ1KWmR2yKHsvbnX6WOqK9f/vg?=
 =?iso-8859-1?Q?TQcukkzdK+D7NOOTTd8=3D?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b88c52f-8613-4fe3-eccf-08d99df1e47f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5657.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2021 11:14:09.9438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tuOLOcd9ipXJA5LKKh6uaPfenA9AUFAYHgFBc1Icye4DVsfRzl3+vobOgtRPK9GbSiRa3klU6N3ufRBrqIu/YA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5644
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hello Nikolaus,

On Monday 1 November 2021 10:39:10 CET H. Nikolaus Schaller wrote:
>=20
> RFC V2 2021-11-01 10:24:26:
> * reworked to not misuse mmc_select_card() but add a call to
>   mmc_fixup_device() right after where host->ops->init_card
>   was called before to apply the wl1251 specific quirks.
>   Device tree matching is done by a new table passed to mmc_fixup_device(=
).
>   suggested by: ulf.hansson@linaro.org
>   based on patches by: jerome.pouiller@silabs.com

To make review easier, I think you can include these patches
in this series (BTW, I have no time to care of them until end
of next week. So, it will probably go faster if you take over
these patches).

(I also suggest to add a title to your series to make your work
easier to track.)


--=20
J=E9r=F4me Pouiller


