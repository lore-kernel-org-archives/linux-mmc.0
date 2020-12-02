Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	URI_HEX autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2801C64E8A
	for <linux-mmc@archiver.kernel.org>; Wed,  2 Dec 2020 06:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 730E32223C
	for <linux-mmc@archiver.kernel.org>; Wed,  2 Dec 2020 06:37:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbgLBGhO (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 2 Dec 2020 01:37:14 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:42636 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726485AbgLBGhL (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 2 Dec 2020 01:37:11 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0B26P4mi000500;
        Tue, 1 Dec 2020 22:36:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0220;
 bh=XkW+ihgv4G5mvhhjjkADnSiIZRxI6I+CACTvHSKMLcQ=;
 b=hU4jk3mp0ANFn+OUpTDQ5iFWEmDY5i6dXRS8B4GF5LvA/bVfOm9FBqe2oH7o4Q1yypoM
 P6dcVU5yBd8aA1/HA+vxRDTo2KkoMfjAmZ7UarWMvmC/FmbeFC1s/4NTtLI8AMDQDmUl
 oUEGvfylec5604GtJNrPExe6hmmSPLw/AEnG7hT86Mhts1k4yrcv2WUBUE1OKXYJ3n6X
 9jxKDjUFteHCZWb8Qb6I8MTAjuSEpUM0EGSoTyj0539QcthOIDi21doqmLsdFFvOq/My
 TKERHK0cTq5OUtD6qoa0j/zkvVLnE3Z6GVnzoxW2cNflBVroRciU058hoqKwkPnwBYR6 PQ== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 355w5d1be6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 01 Dec 2020 22:36:24 -0800
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 1 Dec
 2020 22:36:23 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Tue, 1 Dec 2020 22:36:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iy9kaNO2KWN3bl90HUDVdB4Nz6hi1mH/Dny8ExrIDQCoCMc+ZtiII3ZQuavT4jvx8ih7pEmoF/4Q4RiRadgw3/J+6LVBxisuPpAyy+eXNge/OoKWSTyZDTJ7y8VJOMORYwI/lkN7vclssnnyfM5GVdSRrJeTF3COzMA5nU7ne4uRnIxlcG3FSRCHTXyQEwp/plCbDhOYq47fuu+VI/uCay9TB4/sNYW7hvDffLckvC4b1srLDBKfHHfhpKHg0cUcQi2IT1vYXHzELSv481REm/KhP6iQmVo45onjSivYn8fVnKL15b4WHv/huL3WELGwlAs4u+a0U5iB0BT0JimmPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XkW+ihgv4G5mvhhjjkADnSiIZRxI6I+CACTvHSKMLcQ=;
 b=mf9G0RiXyt1r3Mes7Pcfqejk1HP33viauSnZSN1FdctvJ1Rs49d4QE+jCZnEIv4gOozB/A/drcsnCwidsaPpJ6zAI0+OpyTzlE+P3Z641IAdUuDKotlWydYB7tVZ1GKqw6+5+92WE1HFWcnRHO/e2Orjj7NHzE8Qw17nmLksRDCxPkY1ofC+U2E9jPyOPjiBw/dcfOTxQi1wh40YUcfbsE+2xnA9akWgJ0QlyfG2bPWyFpV1UIyb7kPV232lHy6eQeIgUSANdo/TZMEVWH0VedokOiUP0lx05PGWNy/XKEBsAhkeUZp3OWb9ZOCGas8mSHLGySk+EuocbU19rYWwBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XkW+ihgv4G5mvhhjjkADnSiIZRxI6I+CACTvHSKMLcQ=;
 b=udDc9RPvh+HmaTeM0IEY2dokNrKbv/Pxlofil1DS4vgNeF/KU+W2jvOpsjOjeNKn/z0rp2aWFfjwGvJIxS76hTucBJ9+t3yXIe6gBuZUCYQAfnYjgeSxhe80jLZh5796RFPQjyt6PM9Se5NZNO8CXb+ib6vEy6KHi44bXhP0wpo=
Received: from CY4PR1801MB2070.namprd18.prod.outlook.com
 (2603:10b6:910:7e::28) by CY4PR18MB0935.namprd18.prod.outlook.com
 (2603:10b6:903:aa::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.25; Wed, 2 Dec
 2020 06:36:21 +0000
Received: from CY4PR1801MB2070.namprd18.prod.outlook.com
 ([fe80::c9c8:b925:516f:9090]) by CY4PR1801MB2070.namprd18.prod.outlook.com
 ([fe80::c9c8:b925:516f:9090%7]) with mapi id 15.20.3611.031; Wed, 2 Dec 2020
 06:36:21 +0000
From:   Bhaskara Budiredla <bbudiredla@marvell.com>
To:     Kees Cook <keescook@chromium.org>
CC:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "ccross@android.com" <ccross@android.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "Sunil Kovvuri Goutham" <sgoutham@marvell.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "outgoing2/0000-cover-letter.patch@mx0b-0016f401.pphosted.com" 
        <outgoing2/0000-cover-letter.patch@mx0b-0016f401.pphosted.com>
Subject: RE: [EXT] Re: [PATCH v2 1/2] mmc: Support kmsg dumper based on
 pstore/blk
Thread-Topic: [EXT] Re: [PATCH v2 1/2] mmc: Support kmsg dumper based on
 pstore/blk
Thread-Index: AQHWwYqKGp95SRIfpkeLwxPInxlbBqnivWIAgACfeiA=
Date:   Wed, 2 Dec 2020 06:36:21 +0000
Message-ID: <CY4PR1801MB207097391BD8DE37A0F49102DEF30@CY4PR1801MB2070.namprd18.prod.outlook.com>
References: <20201123111925.28999-1-bbudiredla@marvell.com>
 <202012011218.3B6566C5@keescook>
In-Reply-To: <202012011218.3B6566C5@keescook>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=marvell.com;
x-originating-ip: [2401:4900:16bd:610d:cce9:4937:ad92:fc0a]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4fb4a942-7a30-4809-a208-08d8968c950d
x-ms-traffictypediagnostic: CY4PR18MB0935:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR18MB09353AFA2B423978C6484D97DEF30@CY4PR18MB0935.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1227;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QhoNSwDM13mvR7sBk+gwvmsx9fhnWfQdjj6iZYGGQVbrzhHFRMen5sTqX8Xn++h+FKRcCmX7uXuqlFm9psuzfBgpLu3lgn2jfGa0o53Ili2PlDz7GdjJ+WP1qyCBZTASIqJbiroRt+6ZLMbhZHuiOogwyDBgRx02Lhf5AwZ2RNG6uRBm6wOO9sXs3RMrvIA1wa8mOLgfFLarv1r5L3wOBib1O44jbRZxfHhHUwmQobdlv6VY4Azas4c1VrfpvaS9pAAaLqkXKoQdtvpxPYIoYuOjJvbaAhotPIPbHiqB8y0o4D+BGiuB2YPS3JSCF07ccxsqiPYbNDY1MJ/Ym/jmMw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1801MB2070.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(136003)(376002)(346002)(39860400002)(6506007)(9686003)(86362001)(54906003)(7696005)(2906002)(33656002)(4326008)(316002)(8936002)(55016002)(8676002)(6916009)(186003)(66946007)(5660300002)(478600001)(52536014)(30864003)(83380400001)(64756008)(66556008)(76116006)(66446008)(71200400001)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?t9rGb1NP7sx5e/ftua8kfcHH4QWb1ulDuJLxxHQGaiSLiPhMl0O3QVW8kH7S?=
 =?us-ascii?Q?2ZwGi+d+uzmuFThKCJ/dgpka2KW/Bk813Jlm9fAeJiLfXTl58bbACjC5stcW?=
 =?us-ascii?Q?KqXnGfVtOx8ql2PqtoejVLhzlHMa8nn5voCiMjT8ArvCTVK6Ip5bs1xOiUF4?=
 =?us-ascii?Q?zkuH63Py3SuOeDXUwORK4lle1lPSI0blnorVOtx1fsby0KXUY+1TioYPMe/N?=
 =?us-ascii?Q?1mS4weNFx0eR0hJufm/CKxz/0LADap1S6bkeh4UrsFeIwx7+cdAK316NwBnr?=
 =?us-ascii?Q?NBOMQGgqGh1QKRoJFWO2vWo+aCP5nXOmO7dfYIONmVy8idg7jHXJ2Jc8v2Ti?=
 =?us-ascii?Q?dPZpSGjD7LSDuhZI1MkpousGhjhzruyMj5vWAfMXyiVlGT6MmlqqDUUiLmuy?=
 =?us-ascii?Q?0cCZ/2VKMSyq9NqyVjViRtqDMo0XP7jVJ1p6bTP/6CD0WDi0vj/0vJWqMzAX?=
 =?us-ascii?Q?woxhqD100aRndTZRIBcXp9oAZiKVaWWYYroiHI88EKXk0tbpF0Duc5ANo+OF?=
 =?us-ascii?Q?i/iVqcPlN5JSf5fj9eIF6iWG6z9GiTGy45zqH8sTIvIXsCLOFst1QXX/jAsq?=
 =?us-ascii?Q?O4z6tsr7PMbjd2VLUSP8YQb42OLlZ5AHTbnGVHPvKUeHtgieyUjP9ZddJUsn?=
 =?us-ascii?Q?9FrwjnCTRr5YppWmGkCuIu4ro7EBAb8xx4MIWcbelLI+RfEKdy4LU6j+uKpI?=
 =?us-ascii?Q?y2Y01DG2IQgjKJ28na/f2rKdhDlzw2M/iLEjHI8Nae4sKk4T90Gq/Gk/A38o?=
 =?us-ascii?Q?bAMBb17feFWe6vnQwHQCBDpR6BI3erTJ5/iCmU4kT9SUWBIsvR68uciX3PMa?=
 =?us-ascii?Q?pRGSqkV+7QyCNnd7qjaEGN4GS8+l1/EIKm/lbw0q5eLW7nwykPd+5BH1GKRU?=
 =?us-ascii?Q?1+ZkVb6ddFCGrqqJeJmoYAKepWzHjRXH9YLfuIo1MpBXB5VkaOpdUofrr8Of?=
 =?us-ascii?Q?4nocubJHSWcr+yZ1oqFbLJerHHobw3LRZNRVuMN1eqLQ01uB9Pm2ThM2mXrx?=
 =?us-ascii?Q?loJbjmuU/d6xjWAeG/5WpastJUXWGRw2dR/s5nPNb+YnApE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1801MB2070.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fb4a942-7a30-4809-a208-08d8968c950d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2020 06:36:21.2252
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Sl48ZwtMzeD51FLI4FkFZsGwrvb4mYu3Poh9L+D7HDTkWthpPLxAkUB2PypsxF9zQJJjt0bbjQ8ilodGmBv0+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR18MB0935
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-02_01:2020-11-30,2020-12-02 signatures=0
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org



>-----Original Message-----
>From: Kees Cook <keescook@chromium.org>
>Sent: Wednesday, December 2, 2020 1:56 AM
>To: Bhaskara Budiredla <bbudiredla@marvell.com>
>Cc: ulf.hansson@linaro.org; ccross@android.com; tony.luck@intel.com; Sunil
>Kovvuri Goutham <sgoutham@marvell.com>; linux-mmc@vger.kernel.org;
>linux-kernel@vger.kernel.org; outgoing2/0000-cover-letter.patch@mx0b-
>0016f401.pphosted.com
>Subject: [EXT] Re: [PATCH v2 1/2] mmc: Support kmsg dumper based on
>pstore/blk
>
>External Email
>
>----------------------------------------------------------------------
>On Mon, Nov 23, 2020 at 04:49:24PM +0530, Bhaskara Budiredla wrote:
>> This patch introduces to mmcpstore. The functioning of mmcpstore is
>> similar to mtdpstore. mmcpstore works on FTL based flash devices
>> whereas mtdpstore works on raw flash devices. When the system crashes,
>> mmcpstore stores the kmsg panic and oops logs to a user specified MMC
>> device.
>>
>> It collects the details about the host MMC device through pstore/blk
>> "blkdev" parameter. The user can specify the MMC device in many ways
>> by checking in Documentation/admin-guide/pstore-blk.rst.
>>
>> The individual mmc host drivers have to define suitable polling
>> subroutines to write kmsg panic/oops logs through mmcpstore.
>>
>> Signed-off-by: Bhaskara Budiredla <bbudiredla@marvell.com>
>> ---
>>  drivers/mmc/core/Kconfig     |  15 +-
>>  drivers/mmc/core/Makefile    |   1 +
>>  drivers/mmc/core/block.c     |  19 +++
>>  drivers/mmc/core/block.h     |   9 ++
>>  drivers/mmc/core/core.c      |  24 +++
>>  drivers/mmc/core/mmcpstore.c | 302
>+++++++++++++++++++++++++++++++++++
>>  include/linux/mmc/core.h     |   4 +
>>  include/linux/mmc/host.h     |  12 ++
>>  8 files changed, 385 insertions(+), 1 deletion(-)  create mode 100644
>> drivers/mmc/core/mmcpstore.c
>>
>> diff --git a/drivers/mmc/core/Kconfig b/drivers/mmc/core/Kconfig index
>> c12fe13e4b14..505450a6ea2b 100644
>> --- a/drivers/mmc/core/Kconfig
>> +++ b/drivers/mmc/core/Kconfig
>> @@ -34,9 +34,23 @@ config PWRSEQ_SIMPLE
>>  	  This driver can also be built as a module. If so, the module
>>  	  will be called pwrseq_simple.
>>
>> +config MMC_PSTORE_BACKEND
>> +	bool "Log panic/oops to a MMC buffer"
>> +	depends on MMC_BLOCK
>> +	default n
>
>"default n" is redundant and can be dropped.

Yes, I have removed it.

>
>> +	help
>> +	  This option will let you create platform backend to store kmsg
>> +	  crash dumps to a user specified MMC device. This is primarily
>> +	  based on pstore/blk.
>> +
>> +config MMC_PSTORE
>> +	tristate
>> +	select PSTORE_BLK
>
>I don't understand why this is separate?
>
>> +
>>  config MMC_BLOCK
>>  	tristate "MMC block device driver"
>>  	depends on BLOCK
>> +	select MMC_PSTORE if MMC_PSTORE_BACKEND=3Dy
>>  	default y
>>  	help
>>  	  Say Y here to enable the MMC block device driver support.
>> @@ -80,4 +94,3 @@ config MMC_TEST
>>
>>  	  This driver is only of interest to those developing or
>>  	  testing a host driver. Most people should say N here.
>> -
>
>Why isn't this just written as:
>
>config MMC_PSTORE
>	bool "Log panic/oops to a MMC buffer"
>	depends on MMC_BLOCK
>	select PSTORE_BLK
>	help
>	  This option will let you create platform backend to store kmsg
>	  crash dumps to a user specified MMC device. This is primarily
>	  based on pstore/blk.
>

The idea was to compile MMC_PSTORE as part of MMC_BLOCK driver,
provided it is optionally enabled.
The above arrangement compiles MMC_PSTORE=20
as module: if (CONFIG_MMC_PSTORE_BACKEND =3D=3D y && CONFIG_MMC_BLOCK =3D=
=3D m)
as static:     if (CONFIG_MMC_PSTORE_BACKEND =3D=3D y && CONFIG_MMC_BLOCK =
=3D=3D y)

>
>
>
>> diff --git a/drivers/mmc/core/Makefile b/drivers/mmc/core/Makefile
>> index 95ffe008ebdf..7cb9a3af4827 100644
>> --- a/drivers/mmc/core/Makefile
>> +++ b/drivers/mmc/core/Makefile
>> @@ -16,5 +16,6 @@ obj-$(CONFIG_PWRSEQ_EMMC)	+=3D
>pwrseq_emmc.o
>>  mmc_core-$(CONFIG_DEBUG_FS)	+=3D debugfs.o
>>  obj-$(CONFIG_MMC_BLOCK)		+=3D mmc_block.o
>>  mmc_block-objs			:=3D block.o queue.o
>> +mmc_block-$(CONFIG_MMC_PSTORE)	+=3D mmcpstore.o
>>  obj-$(CONFIG_MMC_TEST)		+=3D mmc_test.o
>>  obj-$(CONFIG_SDIO_UART)		+=3D sdio_uart.o
>> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c index
>> 8d3df0be0355..ed012a91e3a3 100644
>> --- a/drivers/mmc/core/block.c
>> +++ b/drivers/mmc/core/block.c
>> @@ -2870,6 +2870,21 @@ static void mmc_blk_remove_debugfs(struct
>> mmc_card *card,
>>
>>  #endif /* CONFIG_DEBUG_FS */
>>
>> +#if IS_ENABLED(CONFIG_MMC_PSTORE)
>> +sector_t mmc_blk_get_part(struct mmc_card *card, int part_num,
>> +sector_t *size) {
>> +	struct mmc_blk_data *md =3D dev_get_drvdata(&card->dev);
>> +	struct gendisk *disk =3D md->disk;
>> +	struct disk_part_tbl *part_tbl =3D disk->part_tbl;
>> +
>> +	if (part_num < 0 || part_num >=3D part_tbl->len)
>> +		return 0;
>> +
>> +	*size =3D part_tbl->part[part_num]->nr_sects << SECTOR_SHIFT;
>> +	return part_tbl->part[part_num]->start_sect;
>> +}
>> +#endif
>> +
>>  static int mmc_blk_probe(struct mmc_card *card)  {
>>  	struct mmc_blk_data *md, *part_md;
>> @@ -2913,6 +2928,9 @@ static int mmc_blk_probe(struct mmc_card *card)
>>  			goto out;
>>  	}
>>
>> +	if (mmc_card_mmc(card) || mmc_card_sd(card))
>> +		mmcpstore_card_set(card, md->disk->disk_name);
>> +
>>  	/* Add two debugfs entries */
>>  	mmc_blk_add_debugfs(card, md);
>>
>> @@ -3060,6 +3078,7 @@ static void __exit mmc_blk_exit(void)
>>  	unregister_blkdev(MMC_BLOCK_MAJOR, "mmc");
>>  	unregister_chrdev_region(mmc_rpmb_devt, MAX_DEVICES);
>>  	bus_unregister(&mmc_rpmb_bus_type);
>> +	unregister_mmcpstore();
>>  }
>>
>>  module_init(mmc_blk_init);
>> diff --git a/drivers/mmc/core/block.h b/drivers/mmc/core/block.h index
>> 31153f656f41..2a4ee5568194 100644
>> --- a/drivers/mmc/core/block.h
>> +++ b/drivers/mmc/core/block.h
>> @@ -16,5 +16,14 @@ void mmc_blk_mq_recovery(struct mmc_queue
>*mq);
>> struct work_struct;
>>
>>  void mmc_blk_mq_complete_work(struct work_struct *work);
>> +#if IS_ENABLED(CONFIG_MMC_PSTORE)
>> +sector_t mmc_blk_get_part(struct mmc_card *card, int part_num,
>> +sector_t *size); void mmcpstore_card_set(struct mmc_card *card, const
>> +char *disk_name); void unregister_mmcpstore(void); #else static
>> +inline void mmcpstore_card_set(struct mmc_card *card,
>> +					const char *disk_name) {}
>> +static inline void unregister_mmcpstore(void) {} #endif
>>
>>  #endif
>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c index
>> d42037f0f10d..7682b267f1d5 100644
>> --- a/drivers/mmc/core/core.c
>> +++ b/drivers/mmc/core/core.c
>> @@ -569,6 +569,30 @@ int mmc_cqe_recovery(struct mmc_host *host)  }
>> EXPORT_SYMBOL(mmc_cqe_recovery);
>>
>> +#if IS_ENABLED(CONFIG_MMC_PSTORE)
>> +/**
>> + *	mmc_wait_for_pstore_req - initiate a blocking mmc request
>> + *	@host: MMC host to start command
>> + *	@mrq: MMC request to start
>> + *
>> + *	Start a blocking MMC request for a host and wait for the request
>> + *	to complete that is based on polling and timeout.
>> + */
>> +void mmc_wait_for_pstore_req(struct mmc_host *host, struct
>> +mmc_request *mrq) {
>> +	unsigned int timeout;
>> +
>> +	host->ops->req_cleanup_pending(host);
>> +	mmc_start_request(host, mrq);
>> +
>> +	if (mrq->data) {
>> +		timeout =3D mrq->data->timeout_ns / NSEC_PER_MSEC;
>> +		host->ops->req_completion_poll(host, timeout);
>> +	}
>> +}
>> +EXPORT_SYMBOL(mmc_wait_for_pstore_req);
>> +#endif
>> +
>>  /**
>>   *	mmc_is_req_done - Determine if a 'cap_cmd_during_tfr' request is
>done
>>   *	@host: MMC host
>> diff --git a/drivers/mmc/core/mmcpstore.c
>> b/drivers/mmc/core/mmcpstore.c new file mode 100644 index
>> 000000000000..1113eae0756c
>> --- /dev/null
>> +++ b/drivers/mmc/core/mmcpstore.c
>> @@ -0,0 +1,302 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * MMC pstore support based on pstore/blk
>> + *
>> + * Copyright (c) 2020 Marvell.
>> + * Author: Bhaskara Budiredla <bbudiredla@marvell.com>  */
>> +
>> +#define pr_fmt(fmt) "mmcpstore: " fmt
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/pstore_blk.h>
>> +#include <linux/blkdev.h>
>> +#include <linux/mount.h>
>> +#include <linux/slab.h>
>> +#include <linux/mmc/mmc.h>
>> +#include <linux/mmc/host.h>
>> +#include <linux/mmc/card.h>
>> +#include <linux/scatterlist.h>
>> +#include "block.h"
>> +#include "card.h"
>> +#include "core.h"
>> +
>> +static struct mmcpstore_context {
>> +	char dev_name[BDEVNAME_SIZE];
>> +	int partno;
>> +	sector_t start_sect;
>> +	sector_t size;
>> +	struct pstore_device_info dev;
>> +	struct pstore_blk_config conf;
>> +	struct pstore_blk_info info;
>> +
>> +	char *sub;
>> +	struct mmc_card	*card;
>> +	struct mmc_request *mrq;
>> +} oops_cxt;
>> +
>> +static void mmc_prep_req(struct mmc_request *mrq,
>> +		unsigned int sect_offset, unsigned int nsects,
>> +		struct scatterlist *sg, u32 opcode, unsigned int flags) {
>> +	mrq->cmd->opcode =3D opcode;
>> +	mrq->cmd->arg =3D sect_offset;
>> +	mrq->cmd->flags =3D MMC_RSP_R1 | MMC_CMD_ADTC;
>> +
>> +	if (nsects =3D=3D 1) {
>> +		mrq->stop =3D NULL;
>> +	} else {
>> +		mrq->stop->opcode =3D MMC_STOP_TRANSMISSION;
>> +		mrq->stop->arg =3D 0;
>> +		mrq->stop->flags =3D MMC_RSP_R1B | MMC_CMD_AC;
>> +	}
>> +
>> +	mrq->data->blksz =3D SECTOR_SIZE;
>> +	mrq->data->blocks =3D nsects;
>> +	mrq->data->flags =3D flags;
>> +	mrq->data->sg =3D sg;
>> +	mrq->data->sg_len =3D 1;
>> +}
>> +
>> +static int mmcpstore_rdwr_req(const char *buf, unsigned int nsects,
>> +			unsigned int sect_offset, unsigned int flags) {
>> +	struct mmcpstore_context *cxt =3D &oops_cxt;
>> +	struct mmc_request *mrq =3D cxt->mrq;
>> +	struct mmc_card *card =3D cxt->card;
>> +	struct mmc_host *host =3D card->host;
>> +	struct scatterlist sg;
>> +	u32 opcode;
>> +
>> +	if (flags =3D=3D MMC_DATA_READ)
>> +		opcode	=3D (nsects > 1) ?
>> +			MMC_READ_MULTIPLE_BLOCK :
>MMC_READ_SINGLE_BLOCK;
>> +	else
>> +		opcode =3D (nsects > 1) ?
>> +			MMC_WRITE_MULTIPLE_BLOCK :
>MMC_WRITE_BLOCK;
>> +
>> +	mmc_prep_req(mrq, sect_offset, nsects, &sg, opcode, flags);
>> +	sg_init_one(&sg, buf, (nsects << SECTOR_SHIFT));
>> +	mmc_set_data_timeout(mrq->data, cxt->card);
>> +
>> +	mmc_claim_host(host);
>> +	mmc_wait_for_req(host, mrq);
>> +	mdelay(mrq->data->timeout_ns / NSEC_PER_MSEC);
>> +	mmc_release_host(host);
>> +
>> +	if (mrq->cmd->error) {
>> +		pr_err("Cmd error: %d\n", mrq->cmd->error);
>> +		return mrq->cmd->error;
>> +	}
>> +	if (mrq->data->error) {
>> +		pr_err("Data error: %d\n", mrq->data->error);
>> +		return mrq->data->error;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static ssize_t mmcpstore_write(const char *buf, size_t size, loff_t
>> +off) {
>> +	struct mmcpstore_context *cxt =3D &oops_cxt;
>> +	int ret;
>> +
>> +	ret =3D mmcpstore_rdwr_req(buf, (size >> SECTOR_SHIFT),
>> +		cxt->start_sect + (off >> SECTOR_SHIFT),
>MMC_DATA_WRITE);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return size;
>> +}
>> +
>> +static ssize_t mmcpstore_read(char *buf, size_t size, loff_t off) {
>> +	struct mmcpstore_context *cxt =3D &oops_cxt;
>> +	unsigned int sect_off =3D cxt->start_sect  + (off >> SECTOR_SHIFT);
>> +	unsigned long sects =3D (cxt->conf.kmsg_size >> SECTOR_SHIFT);
>> +	int ret;
>> +
>> +	if (unlikely(!buf || !size))
>> +		return -EINVAL;
>> +
>> +	ret =3D mmcpstore_rdwr_req(cxt->sub, sects, sect_off,
>MMC_DATA_READ);
>> +	if (ret)
>> +		return ret;
>> +	memcpy(buf, cxt->sub, size);
>> +
>> +	return size;
>> +}
>> +
>> +static void mmcpstore_panic_write_req(const char *buf,
>> +		unsigned int nsects, unsigned int sect_offset) {
>> +	struct mmcpstore_context *cxt =3D &oops_cxt;
>> +	struct mmc_request *mrq =3D cxt->mrq;
>> +	struct mmc_card *card =3D cxt->card;
>> +	struct mmc_host *host =3D card->host;
>> +	struct scatterlist sg;
>> +	u32 opcode;
>> +
>> +	opcode =3D (nsects > 1) ? MMC_WRITE_MULTIPLE_BLOCK :
>MMC_WRITE_BLOCK;
>> +	mmc_prep_req(mrq, sect_offset, nsects, &sg, opcode,
>MMC_DATA_WRITE);
>> +	sg_init_one(&sg, buf, (nsects << SECTOR_SHIFT));
>> +	mmc_set_data_timeout(mrq->data, cxt->card);
>> +
>> +	mmc_claim_host(host);
>> +	mmc_wait_for_pstore_req(host, mrq);
>> +	mmc_release_host(card->host);
>> +}
>> +
>> +static ssize_t mmcpstore_panic_write(const char *buf, size_t size,
>> +loff_t off) {
>> +	struct mmcpstore_context *cxt =3D &oops_cxt;
>> +
>> +	mmcpstore_panic_write_req(buf, (size >> SECTOR_SHIFT),
>> +			cxt->start_sect + (off >> SECTOR_SHIFT));
>> +	return size;
>> +}
>> +
>> +static struct block_device *mmcpstore_open_backend(const char
>> +*device) {
>> +	struct block_device *bdev;
>> +	dev_t devt;
>> +
>> +	bdev =3D blkdev_get_by_path(device, FMODE_READ, NULL);
>> +	if (IS_ERR(bdev)) {
>> +		devt =3D name_to_dev_t(device);
>> +		if (devt =3D=3D 0)
>> +			return ERR_PTR(-ENODEV);
>> +
>> +		bdev =3D blkdev_get_by_dev(devt, FMODE_READ, NULL);
>> +		if (IS_ERR(bdev))
>> +			return bdev;
>> +	}
>> +
>> +	return bdev;
>> +}
>> +
>> +static void mmcpstore_close_backend(struct block_device *bdev) {
>> +	if (!bdev)
>> +		return;
>> +	blkdev_put(bdev, FMODE_READ);
>> +}
>> +
>> +void mmcpstore_card_set(struct mmc_card *card, const char *disk_name)
>> +{
>> +	struct mmcpstore_context *cxt =3D &oops_cxt;
>> +	struct pstore_blk_config *conf =3D &cxt->conf;
>> +	struct pstore_device_info *dev =3D &cxt->dev;
>> +	struct block_device *bdev;
>> +	struct mmc_command *stop;
>> +	struct mmc_command *cmd;
>> +	struct mmc_request *mrq;
>> +	struct mmc_data *data;
>> +	int ret;
>> +
>> +	ret =3D pstore_blk_get_config(conf);
>> +	if (!conf->device[0]) {
>> +		pr_debug("psblk backend is empty\n");
>> +		return;
>> +	}
>> +
>> +	/* Multiple backend devices not allowed */
>> +	if (cxt->dev_name[0])
>> +		return;
>> +
>> +	bdev =3D  mmcpstore_open_backend(conf->device);
>> +	if (IS_ERR(bdev)) {
>> +		pr_err("%s failed to open with %ld\n",
>> +				conf->device, PTR_ERR(bdev));
>> +		return;
>> +	}
>> +
>> +	bdevname(bdev, cxt->dev_name);
>> +	cxt->partno =3D bdev->bd_part->partno;
>> +	mmcpstore_close_backend(bdev);
>> +
>> +	if (strncmp(cxt->dev_name, disk_name, strlen(disk_name)))
>> +		return;
>
>Why isn't this just strcmp()?

The mmc disk name (disk_name) doesn't include the partition number.=20
strncmp is restricted to something like /dev/mmcblk0, it doesn't cover full=
 /dev/mmcblk0pn.
The partition number check is carried out in the next statement.
=20
>
>> +
>> +	cxt->start_sect =3D mmc_blk_get_part(card, cxt->partno, &cxt->size);
>> +	if (!cxt->start_sect) {
>> +		pr_err("Non-existent partition %d selected\n", cxt->partno);
>> +		return;
>> +	}
>> +
>> +	/* Check for host mmc panic write polling function definitions */
>> +	if (!card->host->ops->req_cleanup_pending ||
>> +			!card->host->ops->req_completion_poll)
>> +		return;
>> +
>> +	cxt->card =3D card;
>> +
>> +	cxt->sub =3D kmalloc(conf->kmsg_size, GFP_KERNEL);
>> +	if (!cxt->sub)
>> +		goto out;
>> +
>> +	mrq =3D kzalloc(sizeof(struct mmc_request), GFP_KERNEL);
>> +	if (!mrq)
>> +		goto free_sub;
>> +
>> +	cmd =3D kzalloc(sizeof(struct mmc_command), GFP_KERNEL);
>> +	if (!cmd)
>> +		goto free_mrq;
>> +
>> +	stop =3D kzalloc(sizeof(struct mmc_command), GFP_KERNEL);
>> +	if (!stop)
>> +		goto free_cmd;
>> +
>> +	data =3D kzalloc(sizeof(struct mmc_data), GFP_KERNEL);
>> +	if (!data)
>> +		goto free_stop;
>> +
>> +	mrq->cmd =3D cmd;
>> +	mrq->data =3D data;
>> +	mrq->stop =3D stop;
>> +	cxt->mrq =3D mrq;
>> +
>> +	dev->total_size =3D cxt->size;
>> +	dev->flags =3D PSTORE_FLAGS_DMESG;
>
>Can't this support more than just DMESG? I don't see anything specific to =
that.
>This is using pstore/zone ultimately, which can support whatever frontends=
 it
>needs to.
>

Yes, as of now the support is only for DMESG. We will extend this to other =
frontends
on need basis.

>> +	dev->read =3D mmcpstore_read;
>> +	dev->write =3D mmcpstore_write;
>> +	dev->erase =3D NULL;
>
>No way to remove the records?
>

Yes, at this time, no removal of records.

>> +	dev->panic_write =3D mmcpstore_panic_write;
>> +
>> +	ret =3D register_pstore_device(&cxt->dev);
>> +	if (ret) {
>> +		pr_err("%s registering with psblk failed (%d)\n",
>> +				cxt->dev_name, ret);
>> +		goto free_data;
>> +	}
>> +
>> +	pr_info("%s registered as psblk backend\n", cxt->dev_name);
>> +	return;
>> +
>> +free_data:
>> +	kfree(data);
>> +free_stop:
>> +	kfree(stop);
>> +free_cmd:
>> +	kfree(cmd);
>> +free_mrq:
>> +	kfree(mrq);
>> +free_sub:
>> +	kfree(cxt->sub);
>> +out:
>> +	return;
>> +}
>> +
>> +void unregister_mmcpstore(void)
>> +{
>> +	struct mmcpstore_context *cxt =3D &oops_cxt;
>> +
>> +	unregister_pstore_device(&cxt->dev);
>> +	kfree(cxt->mrq->data);
>> +	kfree(cxt->mrq->stop);
>> +	kfree(cxt->mrq->cmd);
>> +	kfree(cxt->mrq);
>> +	kfree(cxt->sub);
>> +	cxt->card =3D NULL;
>> +}
>> diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h index
>> 29aa50711626..3889c2a90faa 100644
>> --- a/include/linux/mmc/core.h
>> +++ b/include/linux/mmc/core.h
>> @@ -166,6 +166,10 @@ struct mmc_request {
>>
>>  struct mmc_card;
>>
>> +#if IS_ENABLED(CONFIG_MMC_PSTORE)
>> +void mmc_wait_for_pstore_req(struct mmc_host *, struct mmc_request
>> +*); #endif
>> +
>>  void mmc_wait_for_req(struct mmc_host *host, struct mmc_request
>> *mrq);  int mmc_wait_for_cmd(struct mmc_host *host, struct
>mmc_command *cmd,
>>  		int retries);
>> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h index
>> c079b932330f..7d6751005ac6 100644
>> --- a/include/linux/mmc/host.h
>> +++ b/include/linux/mmc/host.h
>> @@ -173,6 +173,18 @@ struct mmc_host_ops {
>>  	 */
>>  	int	(*multi_io_quirk)(struct mmc_card *card,
>>  				  unsigned int direction, int blk_size);
>> +
>> +#if IS_ENABLED(CONFIG_MMC_PSTORE)
>> +	/*
>> +	 * The following two APIs are introduced to support mmcpstore
>> +	 * functionality. Cleanup API to terminate the ongoing and
>> +	 * pending requests before a panic write post, and polling API
>> +	 * to ensure that write succeeds before the Kernel dies.
>> +	 */
>> +	void	(*req_cleanup_pending)(struct mmc_host *host);
>> +	int	(*req_completion_poll)(struct mmc_host *host,
>> +					unsigned long timeout);
>> +#endif
>>  };
>>
>>  struct mmc_cqe_ops {
>> --
>> 2.17.1
>>
>
>Otherwise, sure, this looks good to me as far as pstore is concerned.
>
>--
>Kees Cook
