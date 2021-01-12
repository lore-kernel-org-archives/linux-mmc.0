Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6B10C433E0
	for <linux-mmc@archiver.kernel.org>; Tue, 12 Jan 2021 23:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD6A62312F
	for <linux-mmc@archiver.kernel.org>; Tue, 12 Jan 2021 23:30:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391658AbhALXa1 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 12 Jan 2021 18:30:27 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:59906 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732543AbhALXa1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Jan 2021 18:30:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1610494226; x=1642030226;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Y2Fd0k5bc9muiSzIhM3Yu41kQXNjyE66mjeyaqCVRwA=;
  b=nAUXSr4elPRLwP1myHPn+wCqpHJq5WaNkryH1CH8ChOSq3cwxB3xn7lM
   3HQELWNHiX6evhQMkXFMZ2IV0Vl2owEdbPRzVynF3oIyKgSS5kA71srdg
   SAh1rm7BX3svtRVuI3b8tIWjSIK+mQhz7YTsvu+gaCnANDCByOdqzcz1I
   ASKLpIKPIExD9+/ZDK2pomUxymifllCv6HLgdWvOmL5zctPbGpyUMLFnu
   NrYK8QVuTzK9MHJTqvzof+/0iory+juq8yuqs7q18TcSwkk/xqMIvn2Qe
   ytR0ORfCjDXbwx/eamCv2SMft9ju6msW/OFmbzM8lqTUoW/m9FVPEkPa/
   g==;
IronPort-SDR: D86aCLvwYF1kokYHzHWv3YOui9fgnP4uVXJ6Ezk7kyG6H/IAcAiV3wt3fpZNtz2XYbA2KckQs7
 AQNNe8Iw5zPHER+T6HLOmMCn0M8CaNER/O02ExX3ZHEhmh+0t+BGCDYueuCebVSW5Dd/Z82GbS
 Cuf8WfBBLCVHNQFSoMdU1yaBrBishY05FdoNwNqCYYl92feAsbNabysEVwaWGQEObE61VAN13n
 AA6kpSTlOXZehX+PZ/9ufGvo4LdDHaFqcADin/rGPH5TTXlJC+H4zb58jjMhqyb5+UMRrGUXAY
 KDQ=
X-IronPort-AV: E=Sophos;i="5.79,342,1602518400"; 
   d="scan'208";a="161723032"
Received: from mail-bl2nam02lp2051.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.51])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jan 2021 07:29:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dqeA9nNkzhAFbv0sx2W4c4//EbpZRdXb/rS6hlSEnzzMF/anN84Q9DlqZkLB37nrC5hW0NdDjfHnMjPXAuOKyQFOrtaCb7TjVtWJUWX3zZG38Z+ZpNJmUW0oSvwVhIOXsT5715/K7PCUwPizG36P+Ab589ZcKXoq88ORyxUfNmdis7IzLTsHB3lGjS4AfMqwHVoFYW+IsJsYbvpH38nHG1zDjJbqiCDqVWqpCMHFzndrLBg77PO1EZ3eLwtmnkf5Jh4XvOSAGMe45jSfdecyHOG8EQn+0W4FM0rdphHv1bHtqXTBoLISS5AevE0sPmYmDH3cLlc6Ay6vGLHQVHHzEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lpA3KBOYrK2nQeMaj2qfoAWyt2+GwyBzPvGeZr9hors=;
 b=C69mcBv5/KE7fInVsxYA4hJGWQo3J8tEOKJt+sYTIqJiZXybJRUvJkbDSFsr+HPUodUwMCTcJSh1U5W52frKWr1LCTKNp5AHx9P9ya2vqD8l2rD16fB/dngjHeU8UhXa8NGKbfHvzvyn7euCitu7W1tjnaf2MvANdtsHkldiX7NMFEk6vdcNSBRUSq2bWCB543eG/uf+zyKPP8p7GIRbIypkQ1qwvMjMDIaeogl8Sz1sk4caVwIakHOHDNDv1Hs9739PmFF2tdMwwNKEh38bxzhhR0iYYD1tO76cHxTDQypUibR2zZdBnSZ1jQ/rKKmAj4ZziHg9Yiq46y/2V2i6VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lpA3KBOYrK2nQeMaj2qfoAWyt2+GwyBzPvGeZr9hors=;
 b=PFOwSgxykc4Z4vXSX49RmROSypF5gVCTMh9+KQ8U4X7te7S/N/dWcjffm17g+W6Dznt51YiFVzLV80si+ilSeEl5N9yLseOIoUCl9TDRTcXQPM/ShcejO9RiIM2cy+P5mQvnmQS2P43AjVkFURNhXWqqmAChm3xmog/ftq8Vsqk=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by MN2PR04MB6445.namprd04.prod.outlook.com (2603:10b6:208:1a2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Tue, 12 Jan
 2021 23:29:19 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::2dbb:7e01:f076:eca0]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::2dbb:7e01:f076:eca0%9]) with mapi id 15.20.3742.012; Tue, 12 Jan 2021
 23:29:19 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Peter Collingbourne <pcc@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: Re: [PATCH] mmc: core: don't initialize block size from ext_csd if
 not present
Thread-Topic: [PATCH] mmc: core: don't initialize block size from ext_csd if
 not present
Thread-Index: AQHW6SdIQi6BrqA0+0GYkT4j4gyYlw==
Date:   Tue, 12 Jan 2021 23:29:19 +0000
Message-ID: <BL0PR04MB6514664049F0BC952D5DAA73E7AA0@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210112210944.605953-1-pcc@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:e53d:bea0:4863:19b6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 722630d1-1489-495e-c795-08d8b751e27b
x-ms-traffictypediagnostic: MN2PR04MB6445:
x-microsoft-antispam-prvs: <MN2PR04MB6445C800813A178F2849BFB6E7AA0@MN2PR04MB6445.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VdOsaHGXdc3VIJcipg492s4xWKwZH4RRwwS5ds8yohe671JYstnFePnCVCSbK+t791coE/sRsepxb2N1PY9eoxowcs2tXTmMgYQvRoYQwmlZAcojPdZ1J+Bc+xilQC4GUOGBMmcKOvzOY5KDzc+mkJ8qFjH30qzSJcuZnCfzFNkGw8IyBvgf3gJhAMrK8ZnuUDFMEimpkypoQ5B4XnPbl59ON9FKZW+DkXPiIY/yn+7QCiZsGFGTChFSM7p6FhDZFp+bawTSYLKkxgxgSgd4YFtcImbsA3VYzLg0q04/FLgNB7IC2eg6+W4TtXFU+fzuFarFNl30rs+TtGjbmlqvdoANLBd60BJEka7wMBcMQIX60nVK2wnVNGPb9h1iU5TC9ZmSP/dKIdJTuBisWN2fQ6VL5cwmJzf33AxHzdKUj1YtnUyaerKfzNOYGGrqRqSJ4Bs1ui8oZ4+HVTwtYcIdAw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(136003)(396003)(366004)(376002)(53546011)(52536014)(66556008)(64756008)(2906002)(66446008)(91956017)(66476007)(316002)(33656002)(55016002)(7696005)(9686003)(478600001)(76116006)(66946007)(71200400001)(86362001)(8676002)(4326008)(8936002)(6506007)(5660300002)(83380400001)(966005)(110136005)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Eov/ZgX6GFKtSMgMgg9asCJNahsMxZh3s3gMlq8F2JNvZG/mPGpUHf20OG74?=
 =?us-ascii?Q?Oa/Equy8eVjeVyxu75s9hvHomlG2Y41lVnZkaiuBKKLgH1QXo/vSv0TP3N+G?=
 =?us-ascii?Q?JnKpWJWdDnKci370zqiNzGZNR0/E+Bz/UzmXodop4IV0jWTbf3eSeRMHjVFm?=
 =?us-ascii?Q?twwyqozsXYvoBIbWeZU69t/dcyPvKPMWh2uqFefmCXkmsd+i2npYT3Tym1B2?=
 =?us-ascii?Q?bEw/rvfon0tWPK8Gq6XJZUIuSX2b+i23RICVnqtfnerPSUAr6Skln886+W6+?=
 =?us-ascii?Q?A5Kn5U+NmWGwQZrRBMm8H3S6SSicxmWmQVX0sgZGTYoYgZKuEiMo43ZZnECa?=
 =?us-ascii?Q?Mdk07tFm/f5Nav8mCF9IcPedOi4YU+DDUaL9t8+TO552rtMb/nH9JWrmXz6v?=
 =?us-ascii?Q?EZknmsN+0IhlOppBUje4be/LDP2D32cWxEX4QoyfctMMYiCxR0MvXdfa72fP?=
 =?us-ascii?Q?4VQbqXL9DCHuWgUjJPXSpJT6iaKe0GRYGjK6oLBgbKEB6l1djhOlQbG9ozfc?=
 =?us-ascii?Q?yvgtOr/PCWfdO6aPSHLMNlUnCQhqS0NriGDTibR9P+673b5LDu710zvQXNNZ?=
 =?us-ascii?Q?X34uP+Sq1v0y0mP9nftn8pAwAIlRKqpNa7UmpHdENQWTn3aje1JbnSmDkCwL?=
 =?us-ascii?Q?LsyYk9OYsPiuX5pa5hZt9DkHruyaKKusvC8261nSRiVrMuBLuLcvJ8rRX4Yx?=
 =?us-ascii?Q?MQl0S3/3DOSBSIyPwR/RiYJ/EPMYdhcZZhFAxv5ElpsH6vEsNvEA0tEW9tAT?=
 =?us-ascii?Q?SWah87+LTLDy3fZnRbkAt+SrxEx4n/MBXXwQq01KxkgbdV6BFZ5+Kjev7jWv?=
 =?us-ascii?Q?VtvTSuuVNYkjYbc/5Uf9JfN7wzBSMAhQnxx0qCRWa3PxqOGD5CoB+UHk/MPF?=
 =?us-ascii?Q?IwZHEpYFgdOR+7B6rf2db/CCsYHKIobUKYreJaR/uYyAR5XB8AY9m2dzBBGH?=
 =?us-ascii?Q?92jUUh4skG2LK/hWE9VNvTvMlIwQEmJx+Ym445auzR5bBv9LQJYv488tgYvY?=
 =?us-ascii?Q?NvWExUr/+OF6384VhJz+u4YieiAbq/JlkfzI0Hw7gfA/AXQ7tTtzWoAfJYUJ?=
 =?us-ascii?Q?Ix1G19G5?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 722630d1-1489-495e-c795-08d8b751e27b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2021 23:29:19.1428
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qpWAS1CTvt+9j8LM0xs0JOR/LWH0Q2hhL+bsaNHRmKzz+UOv52HV3y1AzZrV799U9aGYoGWx8hTyq06Oh3iAWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6445
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 2021/01/13 6:09, Peter Collingbourne wrote:=0A=
> If extended CSD was not available, the eMMC driver would incorrectly=0A=
> set the block size to 0, as the data_sector_size field of ext_csd=0A=
> was never initialized. This issue was exposed by commit 817046ecddbc=0A=
> ("block: Align max_hw_sectors to logical blocksize") which caused=0A=
> max_sectors and max_hw_sectors to be set to 0 after setting the block=0A=
> size to 0, resulting in a kernel panic in bio_split when attempting=0A=
> to read from the device. Fix it by only reading the block size from=0A=
> ext_csd if it is available.=0A=
> =0A=
> Fixes: 817046ecddbc ("block: Align max_hw_sectors to logical blocksize")=
=0A=
> Signed-off-by: Peter Collingbourne <pcc@google.com>=0A=
> Link: https://linux-review.googlesource.com/id/If244d178da4d86b5203445943=
8fec295b02d6e60=0A=
> ---=0A=
>  drivers/mmc/core/queue.c | 3 ++-=0A=
>  1 file changed, 2 insertions(+), 1 deletion(-)=0A=
> =0A=
> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c=0A=
> index de7cb0369c30..735cdbf1145c 100644=0A=
> --- a/drivers/mmc/core/queue.c=0A=
> +++ b/drivers/mmc/core/queue.c=0A=
> @@ -20,6 +20,7 @@=0A=
>  #include "core.h"=0A=
>  #include "card.h"=0A=
>  #include "host.h"=0A=
> +#include "mmc_ops.h"=0A=
>  =0A=
>  #define MMC_DMA_MAP_MERGE_SEGMENTS	512=0A=
>  =0A=
> @@ -384,7 +385,7 @@ static void mmc_setup_queue(struct mmc_queue *mq, str=
uct mmc_card *card)=0A=
>  		     "merging was advertised but not possible");=0A=
>  	blk_queue_max_segments(mq->queue, mmc_get_max_segments(host));=0A=
>  =0A=
> -	if (mmc_card_mmc(card))=0A=
> +	if (mmc_card_mmc(card) && mmc_can_ext_csd(card))=0A=
>  		block_size =3D card->ext_csd.data_sector_size;=0A=
>  =0A=
>  	blk_queue_logical_block_size(mq->queue, block_size);=0A=
> =0A=
=0A=
This looks good to me. I wonder though if we should add a WARN() in=0A=
blk_queue_logical_block_size() if it is passed a 0 block size to more easil=
y=0A=
catch this kind of bug.=0A=
=0A=
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
