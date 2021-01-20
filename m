Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 743F7C433DB
	for <linux-mmc@archiver.kernel.org>; Wed, 20 Jan 2021 12:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3013323355
	for <linux-mmc@archiver.kernel.org>; Wed, 20 Jan 2021 12:59:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388846AbhATM70 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 20 Jan 2021 07:59:26 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:13980 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389360AbhATMO7 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 20 Jan 2021 07:14:59 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10KCBDV9029367;
        Wed, 20 Jan 2021 04:14:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0220;
 bh=jt2Mi8z/ljPMxr02vEZ3xlxRbjUPZNyOa0Fng5Snoo0=;
 b=bdBhPzYZotBFctPsSUTw4s5U8iSWb0b317ePVxB10PhFzsUwBVzH0Yhk8bdmizd8W5gl
 WIhe8rcyAy+BLtAOoUsH8FOTgAADP+aCLtnkyvCivG8RL1xOd/X2E8fIvbPINZatroR7
 cnleGF7xBye2wsk70OS++WgRtKAotY7RBfw1t+XUj8P8Mj6P2mNPeVu4dWZN+Y62n70I
 /VIFUw/5iM29xgGgxbglWGmKdp2yWV2fTwLTUJ5cs3V6/JleWCEVc59W8LRjjnLZWdAZ
 VOPBW8Cpv75X96stRTL8svc6Ralc6iReB29Qe4A+RkG1EtzZMB9Udb5q6yLBe0c89EET Ww== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 3668p2t3c4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 20 Jan 2021 04:14:09 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 20 Jan
 2021 04:14:08 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.105)
 by DC5-EXCH01.marvell.com (10.69.176.38) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 20 Jan 2021 04:14:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IxafqsYYVouGmDqiPuf3vwVbKT3WFxgpzPdwWv5Yz0+PUxCmnN+VjD0Z9SgGz4tjIqYiqCIcLjuH15IxqhVQb56zW4Wt/wZ5Mbc3YkDN7IHL6TdMlsQdduaTIcKh0j//IAUoymrPpRXOvmC+OdNknPQRo8xPKMZqOIV0hGDrVPZWrpb1d3KudT4ZN8c2hSWqKjP8/SVnoh/gnsCUx86K9kkkyzWbTFxpWIZeK2uy+rFsiluLc5UMcKUSiGXKDXn1zAGKwcjSLf1WMbO4V2LQJfT6AMOK4nxDxrnX+zFBNcoHs1M5wPieMTssktVQCVcAolo4IuQp8svjvPTk+YFPaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jt2Mi8z/ljPMxr02vEZ3xlxRbjUPZNyOa0Fng5Snoo0=;
 b=VJnoflS1PAloyCWT93BqCxg8nuPIP6k6aE5KNmQQVEaVHF1VCGV9H70BeRJCotZ8VJg0ngX5NTnX99UU23+nVYvp56eCJlHrPmDLD6ZypptfglTFJFwXrVVF+bAisaVVvDmdFoHvZK94eoXshRDr4BrgsMEX0OhPnjqmmeMlNYez6XiT2oayfvYUEtGjqBB48Z7GsG6h1NvS2zCNW/XPPrBdsk/lDKXDpugwOWcgl+C3Q0B4CFnP8zNPvO6UQg8N4uySEzTCP7sT9/QVAtqdWa+7QE7ufOIxAXADtMhYVZDowz0/VmXjW2hTMl/a8Nc+okeeJbQvfmTVlGLtAKstPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jt2Mi8z/ljPMxr02vEZ3xlxRbjUPZNyOa0Fng5Snoo0=;
 b=DTJ/+Rvg5dk+UNSnnv5qUMH0SCLqbo7LsQ09NKArk0dR7YcBuPGPcqGqZ2R05y1wjE080hQtbjtn3r3RxZmXlvsHEhR1kMUtU6zINRLfstXt5OQ7CHpLhFpgltbzXdmYrtjZ/eQR0IYVvEKEO0o8ONYUvP3/2tI7knRhsN/omYs=
Received: from CY4PR1801MB2070.namprd18.prod.outlook.com
 (2603:10b6:910:7e::28) by CY4PR1801MB1960.namprd18.prod.outlook.com
 (2603:10b6:910:76::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.13; Wed, 20 Jan
 2021 12:14:07 +0000
Received: from CY4PR1801MB2070.namprd18.prod.outlook.com
 ([fe80::bcae:7eef:6788:7770]) by CY4PR1801MB2070.namprd18.prod.outlook.com
 ([fe80::bcae:7eef:6788:7770%5]) with mapi id 15.20.3763.014; Wed, 20 Jan 2021
 12:14:07 +0000
From:   Bhaskara Budiredla <bbudiredla@marvell.com>
To:     Kees Cook <keescook@chromium.org>
CC:     Ulf Hansson <ulf.hansson@linaro.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH v4 1/2] mmc: Support kmsg dumper based on
 pstore/blk
Thread-Topic: [EXT] Re: [PATCH v4 1/2] mmc: Support kmsg dumper based on
 pstore/blk
Thread-Index: AQHW2TmcIyGVE2SPBEu1nOxnH2/TxKolkOIAgAjrZ+CAAQRogIABF8Wg
Date:   Wed, 20 Jan 2021 12:14:07 +0000
Message-ID: <CY4PR1801MB20705C1FDAEBD736274BA404DEA21@CY4PR1801MB2070.namprd18.prod.outlook.com>
References: <20201223144033.32571-1-bbudiredla@marvell.com>
 <20201223144033.32571-2-bbudiredla@marvell.com>
 <CAPDyKFq41CQ8JbyAS0+k26=Cyf=KcOpdeD+VmY1AZxbh4D6f9w@mail.gmail.com>
 <CY4PR1801MB207022E70C53D0DA87EB3F22DEA31@CY4PR1801MB2070.namprd18.prod.outlook.com>
 <202101191130.4A8EC5F9@keescook>
In-Reply-To: <202101191130.4A8EC5F9@keescook>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=marvell.com;
x-originating-ip: [183.83.39.121]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fde82b93-1a8b-454a-1b0d-08d8bd3ce2c3
x-ms-traffictypediagnostic: CY4PR1801MB1960:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR1801MB1960818ED3638F239AC89367DEA21@CY4PR1801MB1960.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SoozwpeofjlT0HDZW3s4gpoC5BXYTvC4A+TFYC/LqrPcnKu4yryO8tl7vvS1BL7KSKMhisp0ZEAW05mJOu4vfepsdjGmheCLWdmQaEBXCJFmRxKMPd1kwHMOhD8Cg7r3yDMhBKt7h4ivVizNR3kvIH971WZ03t/Rx8PdRiaTfc8ZaYPlv04cHrCaknZJrlVtUZo8FChg1AgBRrtSjL99P93J2Gt2WacVIHn9migXc2jDsT6Yh+6T7lKBMDeXMvuOFXe9W5WBn38VpVG/qP75/HFJIF4C3GaqQk/P2CKR8GQe1wV8HBHSEwrU8EeTvhi+FrhEKz1zdKN6NT/YURqkh3tJYT9OyTprMTIaX0/kEWMZKG4Pb+XGDdQsMhrP8LMAOko+fUpP+3ODkILx79XThg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1801MB2070.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(366004)(376002)(346002)(136003)(54906003)(2906002)(4326008)(9686003)(26005)(52536014)(186003)(55016002)(64756008)(66556008)(7696005)(66446008)(6506007)(5660300002)(66476007)(316002)(4744005)(76116006)(83380400001)(86362001)(33656002)(71200400001)(478600001)(8936002)(8676002)(66946007)(6916009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?PAfCk/aHHBSeSDUBozCaX9MPoSTzlwiM3fmKffYW80qjPUCPNf9p5rpuddTS?=
 =?us-ascii?Q?YIHtphkcJ9Yu7+w3AjYJagA7Gon7/2g6GgpL8OBbGyWBYRiQuE5dSufJEtHV?=
 =?us-ascii?Q?MKUwpwRJo2cSeytqrx/UH/R6ytp0Zs4JMi2FeWuzTsfbRNXbZzgQbiKxmm4L?=
 =?us-ascii?Q?FHjuxzM+kZxPVTGkvymGZ+bYg9ZnOHa3Zkomfz0kliCbDYfIfPgTbjH/wIGy?=
 =?us-ascii?Q?E7ZxXSrZsFDnaFZNro7VcYbmtjenl8CkShXJfnRCS7nv7q/3yv9OA2fUP21o?=
 =?us-ascii?Q?7PPWuYLE1ADbckvusSBYiusA7YkR0Bx7eBwSjv0TCASUTWVBEZuKaSLfgBET?=
 =?us-ascii?Q?kFVa9ruqmlJTDUgxw9BLY7U2cW6NDeTl6MJUzclEj14+mUZ+q4UDP/5Bj9fg?=
 =?us-ascii?Q?W+4JSzqrwcJxYRIGQzJxSYtF4s5dHjOFsc6tJGcogcyePVWOjduXUcWNHF9j?=
 =?us-ascii?Q?ak0peKXwA/qL1G9YM4JUr2vOsZuogL9qLbDtHsHVlGiW73xDy2tU60MxmRXz?=
 =?us-ascii?Q?PSuiz77ldGBj1yP/jJIl6yigmPQ6svPFYNr7A5/SQSJS9yaQEneyck8OI72l?=
 =?us-ascii?Q?YC0olArh4Wu17X2wynY2/XbwTdQ2v7B2jj7HWn1VZPBbI08taDSpqpD3Lh3i?=
 =?us-ascii?Q?9ZAtXwfIXIEJZ8Gzy38ui6yzhOm9oST6RWnIIc338TUdTyQSuSbCvoXlJ0FD?=
 =?us-ascii?Q?/gkvEpFlIBGimcwXsXcNxD0PoVf5i/1Uc4yu01Z5tukrywsIxCBJv7vocpg1?=
 =?us-ascii?Q?P4kvrba9IngBNgkaY9Cga4WwA4+PDv3S/lc5T5zJIQZQANBJyqgRBQEUPGdG?=
 =?us-ascii?Q?Z4WaWI2ZpJpLqpZCstsZCAVeHeC+SV73cPzWf0QbBlKdTIwka9s/Ih8fEb5R?=
 =?us-ascii?Q?h5DgmkBLUSnW9aPI2/eQxJ20eMLplq5PXKUed+K4Zn3r2p02f9ZMEqyD43Cw?=
 =?us-ascii?Q?mKDZ4IRWcGd6bjn3tq58LcfZW7sW0bMBH3MzB1NCYIXIjw2XUIG5kL92Xswh?=
 =?us-ascii?Q?/E+CB09NwyuHD3XCaqVGSaXhYEBd/1XHWG3vRXKDfgWM6L/+nbu0w3FG2Bit?=
 =?us-ascii?Q?ITudCbMI?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1801MB2070.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fde82b93-1a8b-454a-1b0d-08d8bd3ce2c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2021 12:14:07.2220
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n3bET6KWVzhscrfK50jKmnhOp4KFgjVC6WWBlHDbdnoJNwB4QpSqEbO6r8qA5CMg5ycajrD2Nfd7/kyKL21DVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1801MB1960
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-20_05:2021-01-20,2021-01-20 signatures=0
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Thanks Kees for the quick response.
Just I have submitted those changes through patch v5.

- Bhaskara


>-----Original Message-----
>From: Kees Cook <keescook@chromium.org>
>Sent: Wednesday, January 20, 2021 1:01 AM
>To: Bhaskara Budiredla <bbudiredla@marvell.com>
>Cc: Ulf Hansson <ulf.hansson@linaro.org>; Colin Cross
><ccross@android.com>; Tony Luck <tony.luck@intel.com>; Sunil Kovvuri
>Goutham <sgoutham@marvell.com>; linux-mmc@vger.kernel.org; Linux
>Kernel Mailing List <linux-kernel@vger.kernel.org>
>Subject: Re: [EXT] Re: [PATCH v4 1/2] mmc: Support kmsg dumper based on
>pstore/blk
>
>On Tue, Jan 19, 2021 at 04:11:31AM +0000, Bhaskara Budiredla wrote:
>> Do you see any issues to ACK this if the mmc pstore registration is
>> through register_pstore_blk()?
>> As Uffe said, eMMC would need to go through
>> psblk_generic_blk_read()/write() instead of mmcpstore_read()/write().
>
>I would be fine with that; yes.
>
>--
>Kees Cook
