Return-Path: <SRS0=3zNE=ZZ=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE1AC43215
	for <linux-mmc@archiver.kernel.org>; Tue,  3 Dec 2019 02:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72BAF20684
	for <linux-mmc@archiver.kernel.org>; Tue,  3 Dec 2019 02:50:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="InBKb3Zv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbfLCCuK (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 2 Dec 2019 21:50:10 -0500
Received: from mail-eopbgr820047.outbound.protection.outlook.com ([40.107.82.47]:22880
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726024AbfLCCr5 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 2 Dec 2019 21:47:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HRV4GJfLucaakzACRz36wXMq3g7ItaubE5ik5mZ1R5w5/1Mx26DmVl0zLcf0uFmV0kOrUR0UIrtwVB3CTmfQLwpki3fHk7IF0JmXX3lI6CbKuhExAnlBLyTi277UkEcXVoNjnGmjLiB/NBSVK7NAizRLM/wkP3iPj2eDeLHauh3KqpHzico5T6AHlkKaH8hPq2kj4k90CwwCowOyiyBip0cE6ef5snwuoWOqj9W4qaTmmyNMNcYjv8O05w/aUMqNVCDvgwACnEGD5F27xehuVdl9yBiR2JS3FJNqOpuQaRajxpZaveyl5GF6+vFZpIh/YS51EwpRdxczpHcfKHWZFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4F0imMaI1KtPVQqtQNUgbz9fTgC6fgQlSlNLfzzkRFc=;
 b=ShL1vqF1nw/fdMUspmyrKPZSSGD4N7pYvNh3oToGsaweDqLM+IK4EtqA5yz2XwvuVkMz7qyt4hyMutN913n5RFRB2X8GKddrKvE4OrLIUxc2EP5/8VLweXrlDUWdjGJLk6U9ksDpCG2/cWrQqwPzZ9vk9L1wVMY2ddQ49PMC+7qzuo6alJrtAba1Mpl6qDZqf9e0qEWQ3xcm3de0wCNSJLe08MWJ9w/c/Qcda+v1CsFZOelr73l928zB43X5BkDfan58uoY/T2jC/Qq/y3pvyiFHQH4KQuPjC6Vd/j8ds113+ZrVmXjyTk2Ioi8k6WidQhlcJsZ6pWlA0QwPzYPZeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4F0imMaI1KtPVQqtQNUgbz9fTgC6fgQlSlNLfzzkRFc=;
 b=InBKb3ZvmrK8R+d8BPt09t1Ogna9E09I+RMeO0ztN6iCNk0GiXAKYsFMLKLFRYm7toVG/Jv41rUQez8zKzzBGjkYod66i5ie3/v2aYl/4h8wyAZT8WdE/3kzwTQUSYyGND//ecY6yRqe8iw/KK1t9/jvTUD61ajcq7t7D6Er4/I=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.93.213) by
 BYAPR03MB4183.namprd03.prod.outlook.com (20.177.127.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.22; Tue, 3 Dec 2019 02:47:13 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::708d:91cc:79a7:9b9a]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::708d:91cc:79a7:9b9a%6]) with mapi id 15.20.2495.014; Tue, 3 Dec 2019
 02:47:13 +0000
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Jun Nie <jun.nie@linaro.org>
CC:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH 4/4] mmc: sdhci: Add DMA memory boundary workaround
Thread-Topic: [PATCH 4/4] mmc: sdhci: Add DMA memory boundary workaround
Thread-Index: AQHVqR6bSNy8xcyAyESfm+a1vx+I5KensdkA
Date:   Tue, 3 Dec 2019 02:47:13 +0000
Message-ID: <20191203103320.273a7309@xhacker.debian>
References: <20191202144104.5069-1-jun.nie@linaro.org>
        <20191202144104.5069-5-jun.nie@linaro.org>
In-Reply-To: <20191202144104.5069-5-jun.nie@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [124.74.246.114]
x-clientproxiedby: TYAPR01CA0240.jpnprd01.prod.outlook.com
 (2603:1096:404:11e::36) To BYAPR03MB4773.namprd03.prod.outlook.com
 (2603:10b6:a03:139::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b6ebd1fe-b419-44bf-52a1-08d7779b1989
x-ms-traffictypediagnostic: BYAPR03MB4183:
x-microsoft-antispam-prvs: <BYAPR03MB4183386FAE367721EDA760F5ED420@BYAPR03MB4183.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 02408926C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39850400004)(136003)(366004)(346002)(376002)(199004)(189003)(102836004)(3846002)(76176011)(6116002)(4326008)(52116002)(66066001)(2906002)(86362001)(66946007)(66556008)(66476007)(64756008)(66446008)(14444005)(256004)(316002)(6916009)(7736002)(386003)(305945005)(54906003)(11346002)(446003)(14454004)(6512007)(99286004)(8936002)(81156014)(81166006)(6506007)(9686003)(229853002)(25786009)(1076003)(50226002)(478600001)(6246003)(5660300002)(71200400001)(186003)(71190400001)(26005)(8676002)(6486002)(6436002)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB4183;H:BYAPR03MB4773.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Lv5HlUUebgQnU8Ny20M8sa2HeOTC1KUgB+cc/9Se2Z4QwNuAkomqvS6iDU0EHjyYCILQrxbTEpAtoujSUvilKpAcvRyO04XofauOPV0wjbonDAj8rkONEswOGLzBrf7gv11LHHHwA3IMdxAiJ6x7TDmAN7JV+r1g7DMQm7STI6/V01mJ72FZOPjjSWDPztYG1nWP0w5bnBNQ50ZwggTb0vFXAlLcf9oiYwweIevajMf5EfEeg5ygugTSJG6U3+CmtUKQYSzTtMywadNd6gyDZRhakTO3yFySr2GZUxv+xmzyTcdE7aRkGLZybyQsWnM0TiP0MfA5JE2fzIB09zFS6MZBFRzqHVmlDkoYoZ7IvvM0s3Od7tkQokiV4rvvtWUR7AL0LGdy8CptsJ0C0DK7c4ZRmWWAivC6rnb5QIQ+lBOjCjnoNIPFgdvJxNH/0cqn
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CCC87292D36FCF4B9B4AF54D77118E12@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6ebd1fe-b419-44bf-52a1-08d7779b1989
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2019 02:47:13.1298
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hDuYsEkJnEUVaCRrnHau5JaZL/kvq4i3+pdY2WL8LsEqmMK5cYvd/CcYM/x3N8hMWY//d9RRvH/esThRqjks6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4183
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon,  2 Dec 2019 22:41:04 +0800 Jun Nie wrote:


>=20
>=20
> DMA memory cannot cross specific boundary for some SDHCI controller,
> such as DesignWare SDHCI controller. Add DMA memory boundary dt
> property and workaround the limitation.

IMHO, the workaround could be implemented in each SDHCI host driver.

eg. drivers/mmc/host/sdhci-of-dwcmshc.c

thanks

>=20
> Signed-off-by: Jun Nie <jun.nie@linaro.org>
> ---
>  drivers/mmc/host/sdhci.c | 20 +++++++++++++++++++-
>  drivers/mmc/host/sdhci.h |  1 +
>  2 files changed, 20 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index d8a6c1c91448..56c53fbadd9d 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -763,9 +763,25 @@ static void sdhci_adma_table_pre(struct sdhci_host *=
host,
>                 BUG_ON(len > 65536);
>=20
>                 /* tran, valid */
> -               if (len)
> +               if (len) {
> +                       unsigned int boundary =3D host->dma_mem_boundary;
> +                       /*
> +                        * work around for buffer across mem boundary, sp=
lit
> +                        * the buffer.
> +                        */
> +                       if (boundary &&
> +                           ((addr & (boundary - 1)) + len) > boundary) {
> +                               offset =3D boundary - (addr & (boundary -=
 1));
> +                               __sdhci_adma_write_desc(host, &desc,
> +                                                       addr, offset,
> +                                                       ADMA2_TRAN_VALID)=
;
> +                               addr +=3D offset;
> +                               len -=3D offset;
> +                       }
> +
>                         __sdhci_adma_write_desc(host, &desc, addr, len,
>                                                 ADMA2_TRAN_VALID);
> +               }
>=20
>                 /*
>                  * If this triggers then we have a calculation bug
> @@ -3634,6 +3650,8 @@ void __sdhci_read_caps(struct sdhci_host *host, con=
st u16 *ver,
>                              "sdhci-caps-mask", &dt_caps_mask);
>         of_property_read_u64(mmc_dev(host->mmc)->of_node,
>                              "sdhci-caps", &dt_caps);
> +       of_property_read_u32(mmc_dev(host->mmc)->of_node,
> +                            "sdhci-dma-mem-boundary", &host->dma_mem_bou=
ndary);
>=20
>         if (of_property_read_u32(mmc_dev(host->mmc)->of_node,
>                                  "sdhci-ctrl-hs400", &host->sdhci_ctrl_hs=
400))
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index cac4d819f62c..954ac08c4fb0 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -608,6 +608,7 @@ struct sdhci_host {
>=20
>         /* SDHCI_CTRL_HS400 value */
>         u32                     sdhci_ctrl_hs400;
> +       u32                     dma_mem_boundary;
>=20
>         unsigned long private[0] ____cacheline_aligned;
>  };
> --
> 2.17.1
>=20

