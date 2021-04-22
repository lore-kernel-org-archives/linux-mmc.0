Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 589B1C433ED
	for <linux-mmc@archiver.kernel.org>; Thu, 22 Apr 2021 09:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A5E7613DB
	for <linux-mmc@archiver.kernel.org>; Thu, 22 Apr 2021 09:41:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235703AbhDVJlo (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 22 Apr 2021 05:41:44 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:32403 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbhDVJlo (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 22 Apr 2021 05:41:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1619084469; x=1650620469;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=T/4gSb/5Kyt0WajIbvNsXTq6uYdXYLigQPdjLGlb1PY=;
  b=By8dHlVkQ0tTJlnDq+AJCgEvMGvaOpsRemeReMqGz/QcVzcJNZo1c+NS
   JzY8ZkAEuPsgGH5GeznFFiXgtfIIE7414AUOUheHkKVE0XIh+3N1C/4Tt
   hKYEjb18IBemr2hOqP8Codpo7IHTs5metloi6ogdkgdIMMl/RzLTvZM8Z
   rBuUTfl5xmVOySW4DbSnB8rXwqRsIJ1BIdkiUEmDNREkVVOX3d+7LlTtT
   aceQppgYbs0zYQhOITJHZu8gTpOWthujAQNEW1mlSvAOzfbuSwy6kxYnb
   hTgkFLtJiPH0Zp9B68qP+cioff6ZdAa8IhOC1HN2BOFcsIs9f1mIOSTO2
   g==;
IronPort-SDR: oVd1C4wp9LJZs1ly2Qzyk1MB0u+ZnS6ll6Xy6ctsE36ABUcyc5aBQFoq1CxSFE7wlAEJ65Z39Y
 0zfFtf5VSdMcDWx1wpXLSDXONjlEggu9CiyovtGWuFiXsKk1GBP+qIjkCVNgT+kPPBtUgRIK9g
 89+NNyP0TkRPVz1sMgq975FO9r3JD52nd7LIWsDfqSR9eWcov1kdoWiQT05mGmZ5+Z82F5k09w
 U8jdCy86aAiOpwrGlT6zHLMfYnAELCS4vmbk9ZT2jngpJFqWzoW22odrefW7Tw1nkDlvCh803s
 pWY=
X-IronPort-AV: E=Sophos;i="5.82,242,1613404800"; 
   d="scan'208";a="165842609"
Received: from mail-dm6nam12lp2175.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.175])
  by ob1.hgst.iphmx.com with ESMTP; 22 Apr 2021 17:41:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YJcffJpTHVCizZHY/ZZcF3wWqrdABlUwfsL53siDzvq2tVralb6d39cygP7kkc5B4WlXt4qhYeQVFnlMDT/l2Cg9Q3vTvjC5AcjvNI1lEohSOhXRa1g7mWaatZaxqB0cuzoStugmBbciAoMz1sL0bYBa6n0UOw4TddUNikzqzWf7zU+CVjrPfCmlhHfrfjygEVX0TCjSGhAFRIkZ4vsy8OldWZ/C7SCZnoYSIOZnf5bfsgXLqxz1u1+2wk7tAe/qC1JqVpEeLYrsZzWYksdn/+7nSq3niHdRvMk8uyunC4AeL0UlyLssW5IwM+ZO3kNLe1srCXE/Rkbx9to+BXQYPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=do+7IOvxkoJezYkP6UNPB6nF07bkpz6aZYUn60p4Hbw=;
 b=XyMpmi5WgwAZWqgr86EIZMVKCGHCIFCWXFj9WkFgKyjfTbLZnQzQuoEo+KtasUnYGr0gkyCOR28lG2JKF5lth8n5r5D51Q66ZPF3gv9Pyh2yOwoDLViEQfRUN/1Vy6IJnkczU8nJe9L/5wBTMFuPWD39XScpDMfAcCS0bXU19isbH6IkQ2EXnU9jyBbl6ytvuMY18aOCjNQwxlOVEtLVK27RxkqmMaQgS8ruBmyb0eDorrGbVXuiiemOsqVFTA8xKmO2H29koRc9FbPTHcxEiJVb7zbsNtIb7++DG0QEWrH+Rm5AyG4NQ+58ewnid3Nlqx+g3UfGi262jYY4sQYDtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=do+7IOvxkoJezYkP6UNPB6nF07bkpz6aZYUn60p4Hbw=;
 b=d23Mb4f+ZHbWMR+e2F4rAav3k9gNgv+R/XCUSN0Snpmh09cfzxkowna3xv8ChhxI+2Dmz5tBNpTEf41JQ+hSsHOk4uxbb7RZwUl2OUkfbDbkniJgxVm+SCelHvISBNQ2QH1KWH8rTIq5zvyBNc/G4ZQ1SJUpCN4gwgBwjIxH9ek=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 DM6PR04MB7004.namprd04.prod.outlook.com (2603:10b6:5:245::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.19; Thu, 22 Apr 2021 09:41:07 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::ed2d:4ccc:f42b:9966]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::ed2d:4ccc:f42b:9966%5]) with mapi id 15.20.4065.021; Thu, 22 Apr 2021
 09:41:07 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Avri Altman <Avri.Altman@wdc.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 0/2] Do not flush cache when it is disabled
Thread-Topic: [PATCH v4 0/2] Do not flush cache when it is disabled
Thread-Index: AQHXNeudjX2Qn6LgIUetxlee6skg3KrASyEw
Date:   Thu, 22 Apr 2021 09:41:07 +0000
Message-ID: <DM6PR04MB6575483C655477218FB74E72FC469@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20210420134641.57343-1-avri.altman@wdc.com>
In-Reply-To: <20210420134641.57343-1-avri.altman@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [212.25.79.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c128f009-e4dc-40dd-95c4-08d90572c129
x-ms-traffictypediagnostic: DM6PR04MB7004:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR04MB70044F26B133EB759AC1EC8CFC469@DM6PR04MB7004.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gqV9/njYDaT0ZYZFphZZZiqFIgWVm9LVYrrto5IQAPi2p95IN45C03awI41ZDPmq/3Z1TySsNl7SGMgIUucjLTaap4PlmWFREIkpvp23GsIGwigwWHqgu/i8ZMzo5dGMcexN90C/mrXwi47jALtzn1oiAVq9gCttELyONhodhtdImrBB0V1gL9ryEQ2MRCG4ApwTFvzgFub/3hd0UFzJ0u3cHbXi38AUoLL9xbTj1I6+mcKaSVNmy9jSMY56X4Rg5ZfdalhHx7H2j91kSN0ciMq6XECluQl01G9TzgrHXQ7fsiJWh0SJL5H7rUxDAyELiNgDIAhiJ7jRmdt7/QAJf8skX2J65MQhdgwPwSAqlRR856/n5edy9KgJmBYUT+u4wQSQuq30bpA8zwiEGrj6E6vXRtaGCwhTXYa75+hrzUUxYeBCSdhf9yNnOOtPh4mgc1MFkaRNhUYJH1rFqkG4SHoqPt61ECiulLeoRjFhAWOZKIRq3EAqaE+/KPh5g9DaMh6XZicGNF6hCbC9Y3kiR165Rhgr6XQSxmK0qMVTMN60lES5FvdzR3zMpHLU1k8e9cJjwchDf2CEEInQigrpmeSg9eHlskDoFAzfKhuyrrE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(396003)(376002)(136003)(366004)(5660300002)(8936002)(66556008)(55016002)(66476007)(110136005)(52536014)(83380400001)(66946007)(9686003)(33656002)(71200400001)(316002)(4326008)(26005)(38100700002)(66446008)(86362001)(76116006)(186003)(478600001)(8676002)(53546011)(2906002)(7696005)(6506007)(122000001)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?gXJ0Luep4ZKtPwfK9ZvEdTHOw0cTBlzRgWjRT8POX9ioDsMmFnOTlQigwNZY?=
 =?us-ascii?Q?PnUdjRTBZuhPRjI3JxtpPWf86wNXLLX0dR9jZ2pfUCkKoKaRLW6oKRSS3Dpp?=
 =?us-ascii?Q?1TqkKvwxAWnlG8lQhQ1Q+8tBsCuQzUjrgT/yFUhsUdHAXfend3emnT7DTiIB?=
 =?us-ascii?Q?gpFSBGkjaqoTrsf68b6v8A2qqITxPH7X/jMzJjIUS9H++AqV2Goow3g3Ysx0?=
 =?us-ascii?Q?EGSAyXP4RlUXIey6Xmh9Kp4Y63itauy+HNghe124MIFhuIRp0IUodoeb11aE?=
 =?us-ascii?Q?2wflqVt4d5kd7fVyu/IZ2kQV+jOCI00ypx02rpxzPgxdc/b0rz0HlbC6JrZ3?=
 =?us-ascii?Q?5IzSgBto8q4YAQtRuMkJTQJq7kmw78qs3mXJoHCuEkdlcuwiUPDVnBkODx5j?=
 =?us-ascii?Q?9ddVwIArS4iZ9Eyk7y5beREvOjbLFcntEYx3NExaBiaQZTU7Eg9O2b2wEIup?=
 =?us-ascii?Q?SLlvSeJk7QzrGzzbeZilbIqhIs9kdqZMlQyDu6UR6N1+woho7D4EcBjRGhrP?=
 =?us-ascii?Q?fej3WuYd1EWEDd7b+8QaiqV+chsrtczy5WvlMfInLvDTNnXFIGvJs8lXklcj?=
 =?us-ascii?Q?6kl+vSWLiuBqpCqpiiPusAKIMgeNfNEadJQ7YOKZaqkZhgAtwOZDUnQsfXKE?=
 =?us-ascii?Q?ZN8wEoALFIGEx+H4x86WB6PaHtHXOAuk+FZKBUe9+4bF/t+8p3h3d9I5XC8P?=
 =?us-ascii?Q?DTPaKYUTHk03DP7qHvsNr79MzTezrWFitKsNbcJmEk8GOLOUoNoVciLWDhDu?=
 =?us-ascii?Q?O2DfkHQZqmanXw3qxP2rUP28NH7pYxevCD0x/vbOD9ftjeDaw3StNAS5Qng9?=
 =?us-ascii?Q?8uJOx5aPeNFsyuXNxu9pShuRjKlZqEPSf2N81JUjTev6qqk5v1iUi4VYw+cH?=
 =?us-ascii?Q?3bB/1SBcdhFtmWuChPGeHto8Div6etENiELkvQnmL4siLHAMIPCxzqztbm7T?=
 =?us-ascii?Q?axKaIBiCc0FbevmC7Ad2wynwmw5sMGsdN6UeSh5cnwC8KjCDi2vcMxElU9bd?=
 =?us-ascii?Q?MWkw5Uj0i3jOEhO+fFJbQrPia3KbRlOBOWyToG13WcU3xgi/86SzI/VOc+KM?=
 =?us-ascii?Q?PY5ChJxwATJoag1vg9MGAaqnAtla1WgSPCR0qk6gcESMmzlFGfQorlwD8PIf?=
 =?us-ascii?Q?DV+KNRVYV0tU3Danvi94gKjn9w2JWhxc5OvHapJNfe9QoaIUYkwK0Vx4ovOe?=
 =?us-ascii?Q?kbxZGW3xmLOCB/PFxDb+t80wcildHjYSogcCy+rdzw2uCSd+1MoGTgLZGLPR?=
 =?us-ascii?Q?h7UJutwx8EvEH3A3vTYz0yY83MWjc5zk1ziQf7OYhnAgHFQCvnMBylmunYub?=
 =?us-ascii?Q?1Cpiwb1DQeDcGj8+DlM8PXbP?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c128f009-e4dc-40dd-95c4-08d90572c129
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2021 09:41:07.4485
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PFbxJNuT4AqiWQHT1QWV+bmIgrTanxPzManWMwaPabAW+btXx+5DGA5SN95nlv+JsuUbSG56PiEHiqiL29vZQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB7004
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Ulf - Would you consider picking this sires up now?
I was hoping to close this bug.

Thanks,
Avri

> -----Original Message-----
> From: Avri Altman <avri.altman@wdc.com>
> Sent: Tuesday, 20 April 2021 16:47
> To: Ulf Hansson <ulf.hansson@linaro.org>; linux-mmc@vger.kernel.org; Adri=
an
> Hunter <adrian.hunter@intel.com>
> Cc: linux-kernel@vger.kernel.org; Avri Altman <Avri.Altman@wdc.com>
> Subject: [PATCH v4 0/2] Do not flush cache when it is disabled
>=20
> v3 -> v4
>  - Attend Adrian's comments
>  - Add Acked-by tag
>=20
> v2 -> v3:
>  - rebase onto recent cache changes
>=20
> v1 -> v2:
>  - Attend Adrian's comments
>=20
> Cache is a temporary storage space in an eMMC device. Volatile by
> nature, the cache should in typical case reduce the access time compared
> to an access to the main nonvolatile storage.
>=20
> The cache function can be turned ON and OFF. Once OFF, the host is not
> expected to issue a flush-cache command to the device.
>=20
> Avri Altman (2):
>   mmc: block: Issue flush only if allowed
>   mmc: block: Update ext_csd.cache_ctrl if it was written
>=20
>  drivers/mmc/core/block.c   | 21 +++++++++++++++++++++
>  drivers/mmc/core/mmc.c     |  2 +-
>  drivers/mmc/core/mmc_ops.h |  5 +++++
>  3 files changed, 27 insertions(+), 1 deletion(-)
>=20
> --
> 2.25.1

