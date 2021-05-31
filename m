Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A37DC47082
	for <linux-mmc@archiver.kernel.org>; Mon, 31 May 2021 08:18:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25F7E611EE
	for <linux-mmc@archiver.kernel.org>; Mon, 31 May 2021 08:18:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbhEaIUS (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 31 May 2021 04:20:18 -0400
Received: from mail-co1nam11on2079.outbound.protection.outlook.com ([40.107.220.79]:1633
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230107AbhEaIUR (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 31 May 2021 04:20:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C3GscgUCSaCnNPpsjktU84HFFfGv8ae4mCNj5A7gkewBVIHOl3jy5JueAK3czpD1AW/YFxaRRFNPOadUI1bP+W23wt7xx+mX/Jcjb6qw55JWJPrQdOwpTfuopW2n+7L9afhmwJs7yLvIHLSgVYu2XLWKNL1bR4hDjFkUrYO3/efG2XzPdgJBTda9L8W4/yPBaAKM8bpr88paJ0Kf2YV2BLVUQ2XjgQJBEFmc75S4pi2g1ISJKN1qbX35KMn9/ChTDwghedvEPPImnxAKQclIXGFW4cR1XjrTSYVEG0bu1aiKSYoBSxVyNSqcNhQr3lmbTjS9J3K6krMI+gkITbJYpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4NkS9ez1W9GBGU1PiC3sLCK3HsKsJTISPzBZIwYx7NQ=;
 b=J1wOFwjDU0hO9Eey7VVkjy8T7QDpTCkpJkb7Eh1f/Awa2jVGRZZqksgWCthmm69HaEO/0mEwNOCz20jQNyQ4pYUKgG3aBKoFMIvzWJnMbZRRQVz8bVxxVA5W9gdZ6xEiKuB87w6tifM5//OwDKMA1Cbq/6pFaa3oqduhsmTshfrZxd6jrMdSKIvIXcgdRhv72OO1ECdW58aj3ZX77uuug9j9+fH+SOwbYH31IKpDH9lAQvlWhOxBlZKq+ee/HmZhBZ8ZOxyqyqeSUGIyMpRAbZSmF2+LdPRcw+Rs3k/CNux1botyTMfImoifoFNsIO1wcBVqiiqlkU6LRXqsF9mjdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4NkS9ez1W9GBGU1PiC3sLCK3HsKsJTISPzBZIwYx7NQ=;
 b=UnDgR+Jw6Kl7utxTnTTfmsgvXXNUmL2lilMBo8qB24kzpwubO1KoOLhqABzHcetQRnczE+SNU4AqRnqoR9nMMF3FYgaMCIZzOq/G/wg3Cs4h7gI7QPBAWRG+3i4qXBI2DGDHQs19RVDu2LRgmdEIu2PiYrztoDj6fD7WZx6F+O8=
Authentication-Results: rock-chips.com; dkim=none (message not signed)
 header.d=none;rock-chips.com; dmarc=none action=none
 header.from=synaptics.com;
Received: from BN9PR03MB6058.namprd03.prod.outlook.com (2603:10b6:408:137::15)
 by BN6PR03MB2820.namprd03.prod.outlook.com (2603:10b6:404:117::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.26; Mon, 31 May
 2021 08:18:36 +0000
Received: from BN9PR03MB6058.namprd03.prod.outlook.com
 ([fe80::308b:9168:78:9791]) by BN9PR03MB6058.namprd03.prod.outlook.com
 ([fe80::308b:9168:78:9791%4]) with mapi id 15.20.4173.030; Mon, 31 May 2021
 08:18:36 +0000
Date:   Mon, 31 May 2021 16:18:23 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Shawn Lin <shawn.lin@rock-chips.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: Re: RFC: RPMB write failed with SDHCI Auto CMD23 support
Message-ID: <20210531161823.3f91725e@xhacker.debian>
In-Reply-To: <a0381554-a17f-1b85-b931-f27f755a4ab3@rock-chips.com>
References: <a0381554-a17f-1b85-b931-f27f755a4ab3@rock-chips.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.147.44.204]
X-ClientProxiedBy: BYAPR02CA0013.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::26) To BN9PR03MB6058.namprd03.prod.outlook.com
 (2603:10b6:408:137::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (192.147.44.204) by BYAPR02CA0013.namprd02.prod.outlook.com (2603:10b6:a02:ee::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend Transport; Mon, 31 May 2021 08:18:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c91a601-702f-4a73-9c4a-08d9240cb003
X-MS-TrafficTypeDiagnostic: BN6PR03MB2820:
X-Microsoft-Antispam-PRVS: <BN6PR03MB2820CF25A7E1F31D71DF5403ED3F9@BN6PR03MB2820.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:224;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sY48+L0K/TaOEFxGha7LhXRQjBoKTTBzBZZskL0OGvTDRJS6Yv1v0KPHeQjQaU6L6ttXCM2BPxrcS/Dw0Zz6mSS+qtHQZcDu5FkrO9KuSIVTTMZmvw+q25QbSU7Y5HwncED1PIIxxmdIsC/JYS9OQK7pKPj6913xzBMkaUQeyIpjwtl0Leh1soi8opEJLcTBmFfNahFs1XoTL6jKvWMm4sREP2Y5kwEqw1p9eGSiEBDIGbn97nGose0CORHGsLFn6omoovIseCUkBKuvOv14NCIg1VheuU2/97C7GGY0f6ezV5Mpq+FrRbZrxys1j8A1QHVny5d7zFkplZlHCZjMk0k4zXMxc6mm2cPQ5XNDw3jF6JrKrq0OkBuDyUyfwZTBAccl1OrGOLGFecEhh65/EYXF/M89HKX684cMJlD7bZmtCTNGgZQ4qedvsK+r8c/c+UYrKmrJj9eqI+/4uxzVknE/QD+KS7o2P4ZfmokqwkBVhtEnkyf/b6O4mXmFvLLwA4HYG1sq9aX6KZegZ/uNRnlNq2uWwHLBpWAx5CBPgBYt9E7CbNv2I3n+jpSBS7zHQDqEBsXPy92aoOpT0RQEsuqiPLYUX8gpOwGx0thykqcwMno1cVihkWGMBsZ6MPgZ4zLMi0D21rhle8Buq4P/vQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR03MB6058.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(396003)(39850400004)(366004)(376002)(38100700002)(478600001)(38350700002)(66946007)(6916009)(9686003)(86362001)(5660300002)(54906003)(7696005)(83380400001)(6666004)(4326008)(66556008)(52116002)(6506007)(66476007)(55016002)(26005)(186003)(16526019)(8936002)(8676002)(2906002)(1076003)(956004)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?dmbhJdpo9PHIOCu3mG+NJ61f3cy39OWJwnb9p1/fBLryRn6zR73daR91b27R?=
 =?us-ascii?Q?0I058/7Q2B7i6YMtRFO3Sm355uxrzGrfJgwT9bPI7QPnZI0f5H37ebyR6S6F?=
 =?us-ascii?Q?VvkRc8yR7Ehfq5Y3vlyNX6tIF9fOkeqaw3wiWWdm2wcNWeD5pQj+GtXDBzrF?=
 =?us-ascii?Q?deueu8CNHQZG/N9NdtOgi6SaAfGEnhapYPvqtJG7HEoSIOI1EUi9Y8N6VjSc?=
 =?us-ascii?Q?NemNNi1yEjKoAkfD3WLKXQDinc1j2bJh2vMnAxSl5Th0RGObeBrQB9gRuuNB?=
 =?us-ascii?Q?06mnFuIXpV/lbhv4ERo+M1qacc/3Wa3PCo2hod1bk/1R3zrSXyDcEIPAqnkn?=
 =?us-ascii?Q?MQcVBfmgcv2Xeas0ofl7DceJ1fFm69ejVUwGmt+KVBPpOyv4f2HvL4ZzraX7?=
 =?us-ascii?Q?p+O+XaGqxaEyxOpeR04w2baENmEA7Zbm5AJjX26xIRRF0xr12SaEvdfZnZuK?=
 =?us-ascii?Q?tRN3qdPXFOny1Cj1XSCuMW0w4IJebJ2vG6vxcJLczM12qs+YFPwgLf9/uCu7?=
 =?us-ascii?Q?6fmDrMdyjLaUu9NGiFxiDn+eRbEyX67PCM1yO8XQUYikx8l8PdWLISYl1SXq?=
 =?us-ascii?Q?Xe9B9Z5G6pDMLlGHQvzmUt6KVcu+hwVrKpAXbkpQYY4uvyjC0gnFccYjyO2k?=
 =?us-ascii?Q?TceaK4iQMNgGXqPIrJEBWil1e43W54KvYlZaqVGgaj0O5LfXl5lIyYikEyow?=
 =?us-ascii?Q?+f9poLq1PeXxWd5tPyRG1QrKblYaDknJLn3nAwfrgN8msqYo8MJ+Rn+iygUP?=
 =?us-ascii?Q?cdBW3qm+X47woJ9BYkasEsgcgJAVunpJtMSq39niEBIF8+Bx/dHGtHux9/G4?=
 =?us-ascii?Q?8W9tKoiO/tDSYsmiC2drqRdgrtqVx7+9H7X3gJ0sBa3Rsx0WoVxkMNjq7Yo5?=
 =?us-ascii?Q?hWMRGMg3zY98KW4eQoQZbkVgt/HL6uFLvecBcg0Ccssx/SxmN/5nLMShFvS0?=
 =?us-ascii?Q?0Uc5u2ChbmafuMgxwBv2CmU9S14St8XIuY7mGh3N20hqhF/x665RkWgXCwb9?=
 =?us-ascii?Q?SVHx1/CTUX9dgOf1vWg8PQovI8+2wmMQaEVhVh1UUpcfUFLYAIhQ+I91YZdd?=
 =?us-ascii?Q?yc/P/YETgSqVkHFVJ96VTzcu/+XkNV8tdLI0eY9QYhsWExR3SZ9HE+Sidodn?=
 =?us-ascii?Q?zZv0585fX6x3PuXmv3ZFH2MIw6ZAJuHv7lFgQbWHhKPbsVG4NPELp/fH0KXt?=
 =?us-ascii?Q?cIzAkNpCMs0Ci31iQJ17UF13aor7K9PwqNb5C2qtPzkudqfkSYvpqisuhwZH?=
 =?us-ascii?Q?zSvALIVF2ZAcCPiEKXA7kLj97+A5xvhN1giv6Of5IzuXDECjEq/tkpKmMF0Y?=
 =?us-ascii?Q?UjH4EjpQUVlRFXK21Yo7N2s5?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c91a601-702f-4a73-9c4a-08d9240cb003
X-MS-Exchange-CrossTenant-AuthSource: BN9PR03MB6058.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2021 08:18:36.2194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y+oXNyPfDDvnY9AHKlqoGspdQHwqiBQB0BNKRi8zXpMDOEzQ1EiJLaEhvKxoNl6fAZh4twKQgfKiafTRoPpxVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB2820
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 31 May 2021 15:51:38 +0800 Shawn Lin <shawn.lin@rock-chips.com> wrote:


> 
> Hi,
> 
>      I got some reports about offical mmc-utils rpmb write failure[1] and
> offical OP-TEE rpmb write failure[2]. Debug it shows the problem is due
> to the AUTO CMD23 support for sdhci. RPMB issues CMD23 perior to multi
> block operations with MMC_CMD23_ARG_REL_WR tagged. This tag is ignored
> by SDHCI AUTO CMD23 routine, so General Failure is always set in RPMB
> operation result.

Which host do you see this issue? I'm not sure whether all sdhci host
has the problem or not. But sdhci-of-dwcmshc does suffer from the problem
I fixed it with commit ca1219c0a7432 ("mmc: sdhci-of-dwcmshc: fix rpmb access")

> 
>      Just ask for some suggestions about how to address it.  Does it
> sound fine to let sdhci_auto_cmd23() or sdhci_manual_cmd23() checks all
> the 29-31 bits of  mrq->sbc->arg and bailout auto cmd23 sound fine?

Is this problem common for all sdhci hosts?

Thanks
> 
> 
> [1]:
> rk3566_firefly_aiojd4:/ # /data/mmc-utils rpmb read-block
> /dev/mmcblk2rpmb 0 1 -  /data/rpmbkey | busybox hexdump -C
> 00000000  79 03 c1 05 a0 6d 45 57  1d d4 7b a4 7c 1f c0 14
> |y....mEW..{.|...|
> 00000010  54 34 44 44 62 e5 1a c1  5c 8b 6b 0c 5d 8e 90 4d
> |T4DDb...\.k.]..M|
> 00000020  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
> |................|
> *
> 00000100
> rk3566_firefly_aiojd4:/ # awk 'BEGIN {while (c++<128) printf "ab"}' |
> /data/mmc-utils rpmb write-block /dev/mmcblk2rpmb 0 -  /data/rpmbkey
> RPMB operation failed, retcode 0x0001
> 
> [2]:
> E/TC:? 0 TA panicked with code 0xffff0000
> E/LD:  Status of TA 8dddf200-2450-11e4-abe2-0002a5d5c53d
> E/LD:   arch: arm
> E/LD:  region  0: va 0xc0004000 pa 0x00400000 size 0x002000 flags rw-s
> (ldelf)
> E/LD:  region  1: va 0xc0006000 pa 0x00402000 size 0x006000 flags r-xs
> (ldelf)
> E/LD:  region  2: va 0xc000c000 pa 0x00408000 size 0x001000 flags rw-s
> (ldelf)
> E/LD:  region  3: va 0xc000d000 pa 0x00409000 size 0x002000 flags rw-s
> (ldelf)
> E/LD:  region  4: va 0xc000f000 pa 0x00416000 size 0x001000 flags r--s
> E/LD:  region  5: va 0xc0010000 pa 0x00001000 size 0x009000 flags r-xs [0]
> E/LD:  region  6: va 0xc0019000 pa 0x0000a000 size 0x00c000 flags rw-s [0]
> E/LD:  region  7: va 0xc0025000 pa 0x0040b000 size 0x001000 flags rw-s
> (stack)
> E/LD:   [0] 8dddf200-2450-11e4-abe2-0002a5d5c53d @ 0xc0010000
> E/LD:  Call stack:
> E/LD:   0xc00118fc
> E/LD:   0xc001155f
> E/LD:   0xc00100fd
> E/LD:   0xc0012029
> E/LD:   0xc001646f
> TEEC_InvokeCommand failed with code 0xffff3024 origin 0x3
> 
> 

