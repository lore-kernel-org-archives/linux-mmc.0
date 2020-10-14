Return-Path: <SRS0=DFdp=DV=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 798E6C433E7
	for <linux-mmc@archiver.kernel.org>; Wed, 14 Oct 2020 10:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FA1D21527
	for <linux-mmc@archiver.kernel.org>; Wed, 14 Oct 2020 10:42:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="kFF9Sq0e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387843AbgJNKmp (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 14 Oct 2020 06:42:45 -0400
Received: from mail-dm6nam12on2040.outbound.protection.outlook.com ([40.107.243.40]:47457
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387774AbgJNKmp (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 14 Oct 2020 06:42:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kua7vtaPU8X8ZxDmq/VYalZUTecLwWTSajOFrlI+9/wSxwtJUqHI2KUkvkIguaoKupBbEyq2C0/B45/x0Su1ANWg9IQlyWwQnBMcxH5CIQUnctJcoS+iTmRbmTESFLbAar5uGk3GX9W81EpNGeJfF1LqetzmoYV/uLcsjFKiU+Pk3mGuT5xXEEinVEHC+J7iPtAQjThjmpZa5wybsepllJLXEc33iwb3fVgBt6hfvx/oXlv/v1YQ6/AtUBq+242AaOCj9Mq/DDRmId+odbVQfcwSOH2qySFKjFZEOijsY9zRz5gkUCMOOH6UpS3fMVnihduANJFpwBF9MF+6Z3zjJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2i9GL+qOF8EUliKvmQmLMyYa45wpxeG/rvNbI5CBDyQ=;
 b=XNq2Ubiu66dRfW/E9KMVLqmplQIEgoJ8LcyGiWO8E6T7+pDQ3lwLvGWOqgtDH/9bvxW2iB5GV9xOc3prXWjLDcrajcOC0pw+qrhLAa2CU0w18Y91dOOFmt0y0SgVJETMBN5UR3zIQLLYJwIsKKUGYkjvfxik1hkhqJ9+m4qg5ugZiJEUOAcTXcx4CnS1WLhqNJaFuihIVl8ntXdHVe5nDYuT51TljmbhiIIDQCMy//KQTFxM7rhT6+IcbYzQ/bIIEKQAFEAFn1Fo4GeLm27l7RKr2qA6T/IjGRZPA0Oa0nLIxTYBmwxmLavHgVTyVJT+5yLELFLsGNsxLmtWpPieBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2i9GL+qOF8EUliKvmQmLMyYa45wpxeG/rvNbI5CBDyQ=;
 b=kFF9Sq0etgJFJIN0r76z1gdRRMqoz4U+4pJu6Bh8ovcFZlxJys0sbIhlM422yeY7wiSJG/t3C3SGt2K0PgiHWm9MfsezRsYovkt0MIYC15y8/jTmlKaukVhE8fvyQh/nFqRN2WmHh74RppD8/cy/HG8m1GCv2pK9zePuC5XUvNg=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=synaptics.com;
Received: from DM6PR03MB4555.namprd03.prod.outlook.com (2603:10b6:5:102::17)
 by DM5PR03MB3321.namprd03.prod.outlook.com (2603:10b6:4:40::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.44; Wed, 14 Oct
 2020 10:42:42 +0000
Received: from DM6PR03MB4555.namprd03.prod.outlook.com
 ([fe80::e494:740f:155:4a38]) by DM6PR03MB4555.namprd03.prod.outlook.com
 ([fe80::e494:740f:155:4a38%7]) with mapi id 15.20.3477.020; Wed, 14 Oct 2020
 10:42:42 +0000
Date:   Wed, 14 Oct 2020 18:42:31 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: Re: eMMC performance regression caused by 427b6514d0953bf
Message-ID: <20201014184231.7f4872ef@xhacker.debian>
In-Reply-To: <87a39115-5843-a6a3-7564-e36ae1f16903@intel.com>
References: <20201013190851.715df9ad@xhacker.debian>
        <CAPDyKFo-Q-+wK1RjtTyoC42_M7UL-HteKwzLmWR-ctD6oKc=rA@mail.gmail.com>
        <87a39115-5843-a6a3-7564-e36ae1f16903@intel.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [192.147.44.15]
X-ClientProxiedBy: BYAPR11CA0038.namprd11.prod.outlook.com
 (2603:10b6:a03:80::15) To DM6PR03MB4555.namprd03.prod.outlook.com
 (2603:10b6:5:102::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (192.147.44.15) by BYAPR11CA0038.namprd11.prod.outlook.com (2603:10b6:a03:80::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20 via Frontend Transport; Wed, 14 Oct 2020 10:42:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 205d6690-5ff7-4feb-58c1-08d8702de0ff
X-MS-TrafficTypeDiagnostic: DM5PR03MB3321:
X-Microsoft-Antispam-PRVS: <DM5PR03MB3321289D53D2939BEFE04256ED050@DM5PR03MB3321.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:506;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3423eIruz8vbGgZEgB6OgFXgKFfrfUHrH/PXsVCZ4lfa0u+Yar18LAQcnnuXi0JEDgCm6IUHMHbrJQLYF/0Ctw+hQpKiexIPpS51Zv912qo+5hGFxdQXqiqVpcWTkCvt3wws8xk+jLalgD9oB9xdnaRnCy6ULkJXL5DAanMZ0NWKe/E9GjqF7aQMfgi7Minc+TxcfZBCs9r8Zt4xko7ODDO6OTCB1M9TJP/JAkhhpPH3wEHTS1z5qvk8S4dCB3jx4zp7ngmLsdQ+eFiukkHuhu4RdEFJfAo0N2CYExGP8rHy0ADWbK3PccR4OTws1XqHEpjWo08y8TYyp/iTfF7LvA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4555.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(136003)(376002)(396003)(346002)(6506007)(186003)(8676002)(26005)(9686003)(478600001)(6916009)(83380400001)(956004)(66556008)(55016002)(54906003)(86362001)(53546011)(1076003)(8936002)(6666004)(316002)(7696005)(66476007)(2906002)(5660300002)(4326008)(66946007)(52116002)(16526019);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 1Hh6cJREScayDejYuabJ4FpTWdeUq6Z4AvNjgB34v/+f6ZhaWSou2fIJspadXAzISOnk67EMP5TSKIdFO/dAhcWPct1nyvOhmCksHbykK1Rle9YFmjqWRmEv5o8xQ1+/Mj31M6rvm/V5bxDYsubctTUW68yKmwdFsB3InFgrHVUwXSIAvLfWtJjsGwzN8nGaSrN/vNKLSe/JKKXM6B1R7BfDml+D9hFrHsIPNBQT7Dmw3CiyZKmTNJBOMLdNBCKVGk/F0JqYCbQLH2LLqF0ic/vI472em0kZ/ueQ3PnQibWXLBEvEP0kerDv+DnWvUNvhayeJs4jICnxbmYKepJ/M3qIYD8inRU0ETPZC8acUKDPnG0IsNx6kjCjLExWjVomGB3wsKKpg2JLTVLgCHozN5vpsIdIXzX44YsQUZLjKFNACcJmPruRgl3YIQj4a07xhJ/WsdKQUXdnp64KAohqMqsWXZjO0Il26ITjBO56mQqrxc5gLd8rm+ijZFauf8ovVprkWDPfxox7YbHcEDzxNSmpSmP/PBNNuqv4NNBnHhV/oltt/qO1/+z/3b7YS6kwZajUr8m+tgw5Nu8cI/GWj6Pd8qDTTtfjeXSzrRwO7ANDfVnlv2UAGgCNAnAokcEb3inG2ThxqvDszAdX3y4qFg==
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 205d6690-5ff7-4feb-58c1-08d8702de0ff
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB4555.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2020 10:42:42.6833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m8rcIQsuy0k3XAevfpPpK1sAPjCPa3U5bYJj2D7mrlb4sZ6HQ7avpposck36Q9b2RvhZNymYoHIBtM2LYG7MyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB3321
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 13 Oct 2020 16:23:36 +0300 Adrian Hunter wrote:

>=20
> On 13/10/20 3:32 pm, Ulf Hansson wrote:
> > + Adrian
> >
> > On Tue, 13 Oct 2020 at 13:09, Jisheng Zhang <Jisheng.Zhang@synaptics.co=
m> wrote: =20
> >>
> >> Hi,
> >>
> >> I found an emmc performance regression with below simple benchmark cmd=
:
> >>
> >> dd if=3D/dev/mmcblk0 of=3D/dev/null bs=3D8192 count=3D100000
> >>
> >> This regression has been bisected to commit
> >> 427b6514d0953bf (=E2=80=9Cmmc: sdhci: Add Auto CMD Auto Select support=
=E2=80=9D)
> >>
> >> If I revert this commit, the performance is good now.
> >>
> >> I=E2=80=99m not sure whether this is common issue or not. =20
> >
> > Can you provide some data, like how much is the regression and how
> > many tests did you run?

before the commit, 120MB/s
after the commit, 51.3MB/s

tested 10 times

> >
> > Did you try different block sizes of the dd command? =20
>=20
> Also what is the SDHCI version?  The patch in question is for version >=
=3D 4.1

V4.2

>=20
> What driver?

sdhci-of-dwcmshc.c, but some phy tuning code isn't mainlined yet.

>=20
> Can you tell if the patch changed which auto command is used?

autocmd23

Now I have a fix, the Auto CMD auto Select can only be used when v4 mode
is enabled. Although the HW supports v4.1, but drivers may haven't enabled
it due to various reasons. I just sent out the fix a few minutes ago.


Thanks
