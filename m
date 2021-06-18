Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 951D2C48BDF
	for <linux-mmc@archiver.kernel.org>; Fri, 18 Jun 2021 10:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70F5B613D6
	for <linux-mmc@archiver.kernel.org>; Fri, 18 Jun 2021 10:00:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232877AbhFRKDA convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 18 Jun 2021 06:03:00 -0400
Received: from de-smtp-delivery-105.mimecast.com ([194.104.111.105]:48399 "EHLO
        de-smtp-delivery-105.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231565AbhFRKC4 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Jun 2021 06:02:56 -0400
Received: from GBR01-CWL-obe.outbound.protection.outlook.com
 (mail-cwlgbr01lp2055.outbound.protection.outlook.com [104.47.20.55]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-40-0q5TGiLwN0qZ2-g_lHIsag-1; Fri, 18 Jun 2021 12:00:41 +0200
X-MC-Unique: 0q5TGiLwN0qZ2-g_lHIsag-1
Received: from CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:89::10)
 by CWXP265MB4090.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:131::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Fri, 18 Jun
 2021 10:00:41 +0000
Received: from CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM
 ([fe80::259d:65ac:ae6d:409d]) by CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM
 ([fe80::259d:65ac:ae6d:409d%9]) with mapi id 15.20.4242.021; Fri, 18 Jun 2021
 10:00:41 +0000
From:   =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
To:     Avri Altman <Avri.Altman@wdc.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "shawn.lin@rock-chips.com" <shawn.lin@rock-chips.com>
Subject: Re: [PATCH] mmc: block: ioctl: Poll for TRAN if possible
Thread-Topic: [PATCH] mmc: block: ioctl: Poll for TRAN if possible
Thread-Index: AQHXXSMDiXAg1fej0U+LBOvD9D6/9asZlxVh
Date:   Fri, 18 Jun 2021 10:00:40 +0000
Message-ID: <CWXP265MB26809CC8BCD8A0289697CBBDC40D9@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
References: <LO2P265MB26880B222999818677722528C4369@LO2P265MB2688.GBRP265.PROD.OUTLOOK.COM>
In-Reply-To: <LO2P265MB26880B222999818677722528C4369@LO2P265MB2688.GBRP265.PROD.OUTLOOK.COM>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [185.80.168.10]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cbfc0c05-4f4e-4afe-c472-08d9323fee34
x-ms-traffictypediagnostic: CWXP265MB4090:
x-microsoft-antispam-prvs: <CWXP265MB4090F3F45A07BF4E8E322104C40D9@CWXP265MB4090.GBRP265.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: SiPZ5XdFwxtauAcCqNOxNUAo5VVxynLcIe+lZEFCDbTWP7c8GrEVBzhyMe63FZDgEE7okOOhrQYZhozaKmYH24oNyNiSyJRcpEx7I4qJQrjz7jnu7bzA9vf6/R7ievwsbXCmQATy5XZ9HMqlUE2HBTsCboW20HTrCbK3cxWWmJfDUNOzHssRNqRk06bcvBN6Mych8WCUxsMnO99mq/eS+D6hn1BCbuhjh0resb5hHAOVwRq4JsfOkg4HNDM5DiEQ1lwIfHHn5tnC1GpB8cS5XtEIaYoFyg8An3muUS1p+Mn6dHEaVM3KOmo0oAB5dj310SLnCeNL+n3KuzMM4/mi8hsY0e2CcP3pqmNCe2mDjA9guHprZMknoScv/rY0eYkWknanl8g/RhYZk6ZOLOL+BlpW0BXnykt8Y+cOoOB+QTtixSTTsr/iOYzz/U+88QjfH954s7EGdiSH6ihKqEKnSY7JXJE/CHxv9qnKQfSqDDp9PFuTRH/uv4Sgur/qA6e9X/FwjxCfM/MvsrUSdElmud8oZZr+sEy1aQOQ883FgpMrVC9pXub4GYCpb9nMBVeq1wHnDN6JrQvnbsEFTAxtF3Jkkg62L5bYfjJyp/wupfM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(396003)(136003)(376002)(39830400003)(346002)(76116006)(316002)(91956017)(33656002)(86362001)(186003)(26005)(38100700002)(64756008)(66556008)(66446008)(66946007)(6506007)(7696005)(66476007)(52536014)(478600001)(8676002)(110136005)(122000001)(4744005)(2906002)(5660300002)(55016002)(8936002)(71200400001)(9686003);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?d/LTRzwhhMRSEVu1STeyQOezzjBszVX8BRLTK7Zp6a8q3FFRIZHpmotFUm?=
 =?iso-8859-1?Q?mUj7Ke/W77qQwZJTRMDBbuJwLgNolN7zEdVshJXY5GjR7oWkve/WRYMgb0?=
 =?iso-8859-1?Q?iUlPpAgGlNybjB1eMsfSQ5GdrhF+uBmgcGCmgkSgsH1nIThnSXYdCQnHAX?=
 =?iso-8859-1?Q?sssZnXNjcn8busd0c9WFEqsxbnC0om7ApVF0AfHF2eTBtMUieAO8iDAIqa?=
 =?iso-8859-1?Q?8u0kbhG8uZNgXi3Vg51j1jxckkB8K9ny62yGudUNzrDoZL7xtftQY0iRFd?=
 =?iso-8859-1?Q?LEAR9ZUGT6Ndua3D8BGzSkLy0WxTB5Qlyo8RmyvrYl1yhEgsUFIpwR9x0f?=
 =?iso-8859-1?Q?AvrpORyih/mkwXJkTOwQNxpSJp21aiIJAd9PxBLMdzrvVzFt3Xlfg3Q0e/?=
 =?iso-8859-1?Q?VciWxn3zofhC9ftzNZQxoPOKDp/SgwSK/Tu5ogpiNhV6Mg31MK5cZBsq9j?=
 =?iso-8859-1?Q?x2OOYk9fNiMDPimJ9nXd0XVJ/OIlPNo8QKtZoUPdxAzi5RYF94MRVpU7Qw?=
 =?iso-8859-1?Q?TCeLCCdL1q/ddeqwbboVQ9etlB6Jh4GgmWHC/4Bsy0eOchAgDhHIl2Swy2?=
 =?iso-8859-1?Q?7vZ+FloQoDkc2RCYzNgIMX1UMwiQuackCZwcTnb+OCwgOWW/uIaff2j0b5?=
 =?iso-8859-1?Q?Vh72sZ6u0TUnJ9SCs6b7lzecs4HE4kHW/OSY/h+wWjqejKP8oJetMTqcIC?=
 =?iso-8859-1?Q?d9fXT2lw05iqZCkQx6IqKb2pTADXU7d/PD3lCOTuKlyx7W8pDUmbpkJ2mp?=
 =?iso-8859-1?Q?Yb84jzVYHt0nFQYKlZMZwtr+vabf3/V4/75XETveopZiS6EHJF6e7xQ7BB?=
 =?iso-8859-1?Q?vW6r/CiQd5u+PEhcjr1KNYSzw0/hrs2wBlQb7JDZpsg0SYhaCAgS1PH1mr?=
 =?iso-8859-1?Q?BRea18mDYkcWev54/hBpWobIhiY7IvN/3vCSvsAv60Za3yjP0Z1ykL8BDU?=
 =?iso-8859-1?Q?JiaiAuaaiIFt6UI+fkVShaSRgeaPiZcAJp79Ju78sHEVf3jTWHL/6SSxoR?=
 =?iso-8859-1?Q?W7Y7SbkVh1VqOH5Brh1jXUNEFwG94hKziMm/VYIksvb6bmpSOz5RZO+eX1?=
 =?iso-8859-1?Q?1cw2ua0REv58HObrT2FVnxBFqNtS0zfQvYRuQSQJikOpfF69uQ8p2BvH7D?=
 =?iso-8859-1?Q?MBGIlYk2YyrUSpeMPviwL1ZJ/iChOg97h2Iu/3FoMqQzRu/2MkIFHnJ18e?=
 =?iso-8859-1?Q?rK06GhVDaUfZqdo0+epFlcoddT8CBJfzAyoSk0Rd4cxsqyP8Q6vxPNZ52A?=
 =?iso-8859-1?Q?BB3pLnX9i8pRzfU5r2AXmLNufOT16Bx6vwt20qMv8JgPBRC630FKaXCWjj?=
 =?iso-8859-1?Q?eo9JXppGgX9vvqI6h578wmN1tKFkbULxlAkCBhC2tlpVQw0=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: hyperstone.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: cbfc0c05-4f4e-4afe-c472-08d9323fee34
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2021 10:00:40.9892
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 86f203eb-e878-4188-b297-34c118c18b11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BRmjfwkseRVhq4IN28WDR6+EQkAfp+zMb0g7ltqSVhyQXOnGqr7boy0n0Dk2bei28MLUTMfrjYUSbraaVYNCVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB4090
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CDE5A68 smtp.mailfrom=cloehle@hyperstone.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: hyperstone.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

>Poll for TRAN state if the ioctl command will eventually return to TRAN
>
>The ioctl submitted command should not be considered completed until
>the card has returned back to TRAN state. Waiting just for the card
>to no longer signal busy is not enough as they might remain in a
>non-busy PROG state for a while after the command.
>Further commands requiring TRAN will fail then.
>It should not be the responsibility of the user to check if their command
>has completed until sending the next via ioctl,
>instead the check should be made here.
>So now, in doubt, wait for TRAN except for the few commands that will
>never return to TRAN state.

So apart from the fact that I missed a couple of non-TRAN returning MMC
commands, which I will add in v2, are there any other thoughts about this
patch? It would change the behavior of the ioctl interface, but I think it is
the only way to prevent race conditions here.

Best Regards,
Christian

Hyperstone GmbH | Line-Eid-Strasse 3 | 78467 Konstanz
Managing Directors: Dr. Jan Peter Berns.
Commercial register of local courts: Freiburg HRB381782

