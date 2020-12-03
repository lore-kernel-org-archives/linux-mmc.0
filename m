Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URI_HEX autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64BD6C63777
	for <linux-mmc@archiver.kernel.org>; Thu,  3 Dec 2020 05:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 006EB2086A
	for <linux-mmc@archiver.kernel.org>; Thu,  3 Dec 2020 05:42:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgLCFl6 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 3 Dec 2020 00:41:58 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:64764 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725979AbgLCFl5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 3 Dec 2020 00:41:57 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0B35fC0a016546;
        Wed, 2 Dec 2020 21:41:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0220;
 bh=VUrEd4DbSMO9MaRxJg6MX/xCHYKneFGvnXfs7BEhmek=;
 b=YAUtkSfLqXT6+EtrIJ0Esfe1h3RZkI6+V5J/02mybg6fl+JTXPB58K2d2RRrIDCLP5lQ
 8TIcvmI1YnKlkJjRTtY8erLcy2RLv53BU1jRfPFK7bhbrWwMMbu4dT9f0SwkCMgouTNG
 A3iHCXkGf8v8ShDzhPPxDW5xBnTSa1X9R5xpXS567nJhb5SErJdfb78T/zNt6oxn7KK6
 tOSqExIMBdqAK3/4W+9zMKqu4E03GJ/yi0TDDFrxUP+Ot/2RYcBeMzhwdTLS+/UvF4+i
 DBqNhXA7DbAhqCXmKscOU7CqB79Y9GJLLF06Ols7dAzRFUqrSzLcfWHRy/x7ODiLWEFk 1Q== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0b-0016f401.pphosted.com with ESMTP id 355w50crv9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 02 Dec 2020 21:41:12 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 2 Dec
 2020 21:41:10 -0800
Received: from SC-EXCH03.marvell.com (10.93.176.83) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 2 Dec
 2020 21:41:10 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.102)
 by SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 2 Dec 2020 21:41:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EWBdYUS/igNnVNsWmdS3XNJ8TrFIqEJNJZm1jpMCFGFr/X9MXqO1LWXF3M4iAky7apOqvhPjRgQGwN5j+HhurCFhaKSk3sWcT8x/aw3DDch+M5Uw2lLGY0bVYHowhuQ4QghVITNf//ORyjGfiR3JFCVLJqvCcPOnFaxh3WzDcBZ4ssUFjS7aXrVn4nf7tfqoRifBvWEXJBHeok2KR4kd1mMCzyWksOa3OfnWtKvyIPJg2Wk3F+cPCLkmiyn23PUCXYZJ9rZg/W2uvWPeFTNzUEuWD3LzbP1p2vNYBJysaFT1gwmR5iFuCEESoDyXp6R3P0ZH2DEB29sYGmrFFYyhPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VUrEd4DbSMO9MaRxJg6MX/xCHYKneFGvnXfs7BEhmek=;
 b=V6vELxmlDndU5H7ednLZFERVLL+IzuIH7eu/olHVq3X5upLLlghwl403ZTy/D1cfYHbeWSFBn40hPUjI4pkdP/8F3ma/SUI+cxEkhUuOKBGdIiSgkW64XKxXl4ty6T6HryB5C2yCXC9ZjbTTSbYaRPwXVeqLa3pJG+Q0ajU37UQUfjT96kLIb61E0f2ptbzoHsefKySIB0P0aUiSEzzsceAC7Yu92SChJyRL2YkXdt4YNuUrEThkSmsNLt4390BduKBU3Wa7VsxRvLJ4Hc+hvO060sucYPzO64OEIBUBUd+Fjfci0ffAgPYEIF+ukqCfwd2ROJsrvQFzELmNdI66Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VUrEd4DbSMO9MaRxJg6MX/xCHYKneFGvnXfs7BEhmek=;
 b=OPtOKKWaLWGk7eq9e1iMOjDVgFD/XtwoaFIw1PN31RxuFOB5IWc+qwrll4QuYy0mslSxwM0Uj5jgx34I6NGetfNUYI/IadvM3XiVxUnJVZ9SvolAXx89UoaCPITNryAv8BVi6xcP9HRoQRBrLKP9fxx8oV/yX/29er+6ppD7KIg=
Received: from CY4PR1801MB2070.namprd18.prod.outlook.com
 (2603:10b6:910:7e::28) by CY4PR18MB1190.namprd18.prod.outlook.com
 (2603:10b6:903:110::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20; Thu, 3 Dec
 2020 05:41:08 +0000
Received: from CY4PR1801MB2070.namprd18.prod.outlook.com
 ([fe80::c9c8:b925:516f:9090]) by CY4PR1801MB2070.namprd18.prod.outlook.com
 ([fe80::c9c8:b925:516f:9090%7]) with mapi id 15.20.3611.031; Thu, 3 Dec 2020
 05:41:08 +0000
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
Thread-Index: AQHWwYqKGp95SRIfpkeLwxPInxlbBqnivWIAgACfeiCAAOO4AIAAn9QA
Date:   Thu, 3 Dec 2020 05:41:08 +0000
Message-ID: <CY4PR1801MB20702A51343093FD43A53A50DEF20@CY4PR1801MB2070.namprd18.prod.outlook.com>
References: <20201123111925.28999-1-bbudiredla@marvell.com>
 <202012011218.3B6566C5@keescook>
 <CY4PR1801MB207097391BD8DE37A0F49102DEF30@CY4PR1801MB2070.namprd18.prod.outlook.com>
 <202012021126.20ACBBD@keescook>
In-Reply-To: <202012021126.20ACBBD@keescook>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=marvell.com;
x-originating-ip: [27.59.143.196]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d7b7400f-0ed7-40a8-62a4-08d8974e08bd
x-ms-traffictypediagnostic: CY4PR18MB1190:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR18MB1190BFE9A5F244DD7EA923DDDEF20@CY4PR18MB1190.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2276;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7WnE4vMU73fF2edpY8Q5P75eA7XXv9BrBaqg90upE+dkyyyZZqRGh/TwlGUL5vfYwDRufq4wp0fd7o6JpE5HoLatb4nUCBlLjEqIuKo/lZU9cJxhZ7A/w0FgJW48B0d5UzymGbJbmnUKMy9fyYKAVVjG3+ji0WipXXlCADsCIlVJOEU68qZTsEC1K9WsTkiet+yy5vKZdz9OjZtuQh6tfql06+qbz0yYZaezfbP7kCBJ/8PTx6lBfZp2Nk5apf5La/3Qo+VceM1PsOYApIyn/3slg05VOObWY5Q+oprnJ90h3NAe4c6L5f6z3WUXXXqqEfsSEhYOWzf7QyOeh6Mxxg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1801MB2070.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(346002)(366004)(136003)(39860400002)(52536014)(8676002)(316002)(26005)(478600001)(33656002)(76116006)(7696005)(6506007)(83380400001)(66946007)(86362001)(71200400001)(66476007)(54906003)(64756008)(66446008)(9686003)(8936002)(6916009)(2906002)(4326008)(186003)(55016002)(66556008)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?kWBnS5HIAx0tEYjMG7TG1YKCTU95ZksfhXlQ56opYCVgzDmujapd1htSAenv?=
 =?us-ascii?Q?xiTPHuSTZq1JuYIrSWq8YP8BSR40IAnf0RwSD0JfbBPk8BlPYhjuEG3MEeru?=
 =?us-ascii?Q?INn7BqFdU1NNK/n4eYI4pWLOqEMoXH6dlrFopC1rjy2ctHvPMxsuDEWXghX5?=
 =?us-ascii?Q?/dYntGaRBgLLFODJ1NWyf+xH3Qve7JWBAJGTjP4dphQwMPuU3qCW8y4rjYvj?=
 =?us-ascii?Q?W1NwbcDOA28X2PP2MEKgonOyztARs6qRWadaA88iqYFFZZfLNt7aj+nlCqSO?=
 =?us-ascii?Q?v5376BSaQR19CgVGHJ2VyTsx0cSvLgnpNSWk/I8UYvzmwBwQa+93MogD08uG?=
 =?us-ascii?Q?Vj8TiUg/CBGisiR5POBajAy8Y1g4qqW4N4GgLLzwZQC4R/gSG/48xhV4Itd/?=
 =?us-ascii?Q?EmY8qryaE0lu+nW8Dvvnhe5wyMcShqqO/VSnADxgvo5Xb9/qhT+Rw/7mZFOF?=
 =?us-ascii?Q?2ikLh0EKbcZWamcFUUAXsCraefrGNlrabX0KPp2hwq5ivAK5eGZ0eGKCkNEb?=
 =?us-ascii?Q?dQmO8UuSDaltGkxiJp7W4pfhqLigpxvAkmO6EuAH6OHLQYjUjUgqJNo7CIlB?=
 =?us-ascii?Q?2gDSQBohpecG/MsS/u9q731PeDNbFBgEsBsi7uXYy6o0/iLA3wFH5hlk8Hw2?=
 =?us-ascii?Q?mAgOCm0wKZg+6xwpmCWL0wXQH8PG6uoDVHqQ/+sI+yA/TjE0PEBvMXTPAYwt?=
 =?us-ascii?Q?ZoxKLGNlkJAdQvWldTl8cjFNBEnKnl2tf49pEU8iiIUD/z2qA/iIpZQngmQz?=
 =?us-ascii?Q?Af87IaiQrf4DWhSJrvh5mjLrlU5FEUu45PUA3S/cXd8QXlU7mrt+c6kEmN5t?=
 =?us-ascii?Q?R+61zbNV1iiIrXJ09WFu6+o6junh3ooxlOlD5n26R6g2406epg0IC1zxzERu?=
 =?us-ascii?Q?oXTC5PDSwhd48u1mahAxDBrtuflGY/Lxmrx+sb3TchFIOj5RAei1Gy62Kh2l?=
 =?us-ascii?Q?S6Cz+9K2ay5L1h5tBOYIsNNtPnlYkkauJCaRaqtKahE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1801MB2070.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7b7400f-0ed7-40a8-62a4-08d8974e08bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2020 05:41:08.1138
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oezJLdecWlwE14IITIznC3hKKGA8EY+L3In5v1Oe59K+ErR4Wws+bNbkfm6EKheIdDYwtWNDlwP6w41B4LpWlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR18MB1190
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-03_01:2020-11-30,2020-12-03 signatures=0
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org



>-----Original Message-----
>From: Kees Cook <keescook@chromium.org>
>Sent: Thursday, December 3, 2020 1:02 AM
>To: Bhaskara Budiredla <bbudiredla@marvell.com>
>Cc: ulf.hansson@linaro.org; ccross@android.com; tony.luck@intel.com; Sunil
>Kovvuri Goutham <sgoutham@marvell.com>; linux-mmc@vger.kernel.org;
>linux-kernel@vger.kernel.org; outgoing2/0000-cover-letter.patch@mx0b-
>0016f401.pphosted.com
>Subject: Re: [EXT] Re: [PATCH v2 1/2] mmc: Support kmsg dumper based on
>pstore/blk
>
>On Wed, Dec 02, 2020 at 06:36:21AM +0000, Bhaskara Budiredla wrote:
>> >From: Kees Cook <keescook@chromium.org> On Mon, Nov 23, 2020 at
>> >04:49:24PM +0530, Bhaskara Budiredla wrote:
>> >Why isn't this just written as:
>> >
>> >config MMC_PSTORE
>> >	bool "Log panic/oops to a MMC buffer"
>> >	depends on MMC_BLOCK
>> >	select PSTORE_BLK
>> >	help
>> >	  This option will let you create platform backend to store kmsg
>> >	  crash dumps to a user specified MMC device. This is primarily
>> >	  based on pstore/blk.
>> >
>>
>> The idea was to compile MMC_PSTORE as part of MMC_BLOCK driver,
>> provided it is optionally enabled.
>> The above arrangement compiles MMC_PSTORE as module: if
>> (CONFIG_MMC_PSTORE_BACKEND =3D=3D y && CONFIG_MMC_BLOCK =3D=3D m)
>> as static:     if (CONFIG_MMC_PSTORE_BACKEND =3D=3D y &&
>CONFIG_MMC_BLOCK =3D=3D y)
>
>Ah, okay. If it's a tri-state, wouldn't it track CONFIG_MMC_BLOCK's state?=
 As
>in, does this work:
>

Yes, it's a tri-state but not compiled as a separate driver.=20

>config MMC_PSTORE
>	tristate "Log panic/oops to a MMC buffer"
>	depends on MMC_BLOCK
>	select PSTORE_BLK
>	help
>	  This option will let you create platform backend to store kmsg
>	  crash dumps to a user specified MMC device. This is primarily
>	  based on pstore/blk.
>

No, this will cause problems for MMC_PSTORE=3Dm and MMC_BLOCK=3Dy
MMC_PSTORE automatically have to be selected as module or static
based on MMC_BLOCK selection. There were couple of function calls
from the code in MMC_BLOCK to MMC_PSTORE. Uffe prefers them
to be unconditional calls (as per discussion in v1). =20

>> >> +	if (strncmp(cxt->dev_name, disk_name, strlen(disk_name)))
>> >> +		return;
>> >
>> >Why isn't this just strcmp()?
>>
>> The mmc disk name (disk_name) doesn't include the partition number.
>> strncmp is restricted to something like /dev/mmcblk0, it doesn't cover f=
ull
>/dev/mmcblk0pn.
>> The partition number check is carried out in the next statement.
>
>Okay, gotcha; thanks!
>
>> >> +	dev->flags =3D PSTORE_FLAGS_DMESG;
>> >
>> >Can't this support more than just DMESG? I don't see anything specific =
to
>that.
>> >This is using pstore/zone ultimately, which can support whatever
>> >frontends it needs to.
>>
>> Yes, as of now the support is only for DMESG. We will extend this to
>> other frontends on need basis.
>
>Okay -- I assume this has mostly to do with not having erasure (below).
>
>> >> +	dev->erase =3D NULL;
>> >
>> >No way to remove the records?
>>
>> Yes, at this time, no removal of records.
>
>Okay. (I think this might be worth mentioning in docs somewhere.)
>

Would it be sufficient to add corresponding notes to the commit message?=20

>--
>Kees Cook
