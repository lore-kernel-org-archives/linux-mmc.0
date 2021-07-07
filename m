Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 269A7C07E95
	for <linux-mmc@archiver.kernel.org>; Wed,  7 Jul 2021 14:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D3D061CC1
	for <linux-mmc@archiver.kernel.org>; Wed,  7 Jul 2021 14:43:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232052AbhGGOpl convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 7 Jul 2021 10:45:41 -0400
Received: from de-smtp-delivery-105.mimecast.com ([194.104.109.105]:48619 "EHLO
        de-smtp-delivery-105.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232116AbhGGOpk (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 7 Jul 2021 10:45:40 -0400
Received: from GBR01-LO2-obe.outbound.protection.outlook.com
 (mail-lo2gbr01lp2052.outbound.protection.outlook.com [104.47.21.52]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-21-6MCvNPenNc-j11BEiKL7Ew-1; Wed, 07 Jul 2021 16:42:58 +0200
X-MC-Unique: 6MCvNPenNc-j11BEiKL7Ew-1
Received: from CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:89::10)
 by CWXP265MB2485.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:4c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20; Wed, 7 Jul
 2021 14:42:57 +0000
Received: from CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM
 ([fe80::259d:65ac:ae6d:409d]) by CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM
 ([fe80::259d:65ac:ae6d:409d%9]) with mapi id 15.20.4287.033; Wed, 7 Jul 2021
 14:42:57 +0000
From:   =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
To:     Avri Altman <Avri.Altman@wdc.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>
Subject: Re: [PATCH] mmc: block: Differentiate busy and non-TRAN state
Thread-Topic: [PATCH] mmc: block: Differentiate busy and non-TRAN state
Thread-Index: AQHXbl0Q77+Qfc7HWE6ez2HIF5qrJas1omGlgAAGD4CAAADv5IABbwLggAAg/s6AABt2cIAASmAI
Date:   Wed, 7 Jul 2021 14:42:57 +0000
Message-ID: <CWXP265MB268016982B4DEE728E60AC45C41A9@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
References: <CWXP265MB268049D9AB181062DA7F6DDBC4009@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
 <CWXP265MB26807AC3C130772D789D0AABC41B9@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>,<CAPDyKFq44ZuXXUDQV34NSW-ixB9GAZfDx+dx-Kb8O7=LQ1TSHQ@mail.gmail.com>
 <CWXP265MB26803EFAC659676EC0914F97C41B9@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>,<DM6PR04MB6575B0049B98254E77BA447EFC1A9@DM6PR04MB6575.namprd04.prod.outlook.com>
 <CWXP265MB2680AE8D71546A5656B410DCC41A9@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>,<DM6PR04MB65751AF67891F655ABBAA7C6FC1A9@DM6PR04MB6575.namprd04.prod.outlook.com>
In-Reply-To: <DM6PR04MB65751AF67891F655ABBAA7C6FC1A9@DM6PR04MB6575.namprd04.prod.outlook.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ecd81556-6325-41d2-9f48-08d9415582e3
x-ms-traffictypediagnostic: CWXP265MB2485:
x-microsoft-antispam-prvs: <CWXP265MB24850AD16FC63920BD53568BC41A9@CWXP265MB2485.GBRP265.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: KYSjURUvUwpfuwEsH838byXZbxCYQBj+vLYvy71/Xt3Y6euJPa8P2MLhyqPLXpSqNwxh04ygaXkpbN4mNL0s8V2NAt/MHlIfL5XthaRIyXHxZVT8SQO9p3BNqDCraSVT5KfC1OWc/R+TxypIAkCcyy+Lr+3ihLv6Uo6ST0WnisSSkRKkePyqbF1KRAHBAIizwjNQKvuIHA2QzQxSbAJpzD69gQLCEX4EUkZePiHav370zjmG5b4gHWpbescN1yGgfeL7h1PBoW1SCKW3AI5PxCnZDjKK1eTTfkVKKKc1fKBgqizqnRh3Zl0jFgLp/Z8P1B36Jh3vI86bKxlpV7by0QOp1roKKTPMBFUzcwEHipcNyAZAJ6jn89b7SKTazMcJnLojT6YL7EIekTGtZYEEvVJLt7K4whL6R1kJEpGkANYKqium5rQUGCjzALAamx2FVbt6axYW+aBCoQ0PC6GLYwzkNUzLPv+rsgOU6ANgnQYRvb3x7k4n8lj4kQeYvnd2VWzV6oqEWdLsDr+kkQCm2CS4ER87RiEmA/443foRqG3pcgtxGY9nurdCp93RHuHcTRGubBQtfxfFo4UWUJ5qblj1mj0GlOu8JJ1+2q6+FgHJlusReeStE26wYa3EHV/2rhFAiajuzQviI68D824L7g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(346002)(39830400003)(376002)(366004)(136003)(396003)(5660300002)(4326008)(6506007)(54906003)(316002)(38100700002)(7696005)(110136005)(2906002)(66446008)(122000001)(76116006)(66946007)(66556008)(83380400001)(91956017)(66476007)(8676002)(33656002)(55016002)(8936002)(26005)(86362001)(186003)(52536014)(9686003)(71200400001)(64756008)(478600001);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?5/VLQhnOqsD7NBIgAXJSvo0Le61Fl26hpEg68al/mDbx3agnMPXxeMOiPd?=
 =?iso-8859-1?Q?FsOvIfeWQU0NT+1LkmaJ+S2kTm//TT9TxqVGuJnK4/ErRgOZYaSDKc52dj?=
 =?iso-8859-1?Q?c6lASTT1wqiX4HPJYY1CAfn1srliBKZh3P9twQMHctQJ81gARjQ8a2TPwP?=
 =?iso-8859-1?Q?kWDRUUhD+rIezfIfymV4TawO3za0YVkBUFxJ2Htu3gq9E5mf9U7M2PKWyl?=
 =?iso-8859-1?Q?vOV/WeK4lLZo2PLYrCLCoVVO//Uw0LyALwbHdOFLCxXDshdBBSVxrUeKpW?=
 =?iso-8859-1?Q?EDa53GeBJe+ArLnVEcf65iQgmrHTYCcM0dqXmWi4pHjd+TfjBO9jj+Li0E?=
 =?iso-8859-1?Q?OQyFmIcQjLuyu0ivL17yX8uOrY89pbGmevFuQmT3tnY/CBKXcpwzL05Q78?=
 =?iso-8859-1?Q?MTpKVPWyQ2PTaXg9FG8fyOlA2bKxGOfnBaIicl79IufoFyZG3Lisy7nle8?=
 =?iso-8859-1?Q?PnpN7WmwaWJhWJKAPC9U4c5MCLqOLFEGFm1uBdS4OfbPXf60Bhku5iMXQ3?=
 =?iso-8859-1?Q?PZUPTiZZdHCHlI+LBrw/gVCBdRir0tEFEhBBn+ftpNbUqQXYZYSpNz4gEY?=
 =?iso-8859-1?Q?KfYms6f/kCpoiwF2ImPTwJMwUEP528lqMYC8tFNucbA0wTlNAj9/u7PKJe?=
 =?iso-8859-1?Q?79EF0AdGtsvxNSkKomzM/u8Szl3/u5wDjs+/daXKHu3n3TGDw0jCqn3iF0?=
 =?iso-8859-1?Q?7AhVIATzTKsTMRcKVEq3E5tO2bhWpYX6djbw9r2h7x3lxwc8NUQ5vy3pom?=
 =?iso-8859-1?Q?UNXWqgnsIE8Bm3OTEe9DkPUcNSaa+LrUbcE2wBqOpyT9ABSsxpMO2O1T5y?=
 =?iso-8859-1?Q?ujdVAQQTVRS5/jOOEg6ScwYAKa5bu5ZbKRHwk8HGnyvCApTzGKSk0n9W0I?=
 =?iso-8859-1?Q?+XxFM2mtMjKkXMAzpgyyhf/Vr6ngQpeV11Df54bhXnSSmwBEekZ9oz70hb?=
 =?iso-8859-1?Q?eOkPqpiPGfWUalLkWMm3AASPXK/OVpXlFRxBwvbhjNwXhMjLCpJrPzZmNt?=
 =?iso-8859-1?Q?/inn3/nmIKGWVXK1oc/4PnA8fKnPasN9uRab0F8jbNWnatDkELIPeH4ByU?=
 =?iso-8859-1?Q?yknDhYh1qcqEyCpym8sGPt+ihFuRJ1TjFINsQwz4aaW+kMGZ9oTot5AVg3?=
 =?iso-8859-1?Q?5uV2r0mMMjtK6hWgzubIdKJxl6ZPKRmtopa3cK3nS8veIX7X+Txcw6bGRu?=
 =?iso-8859-1?Q?ZgTcR49Dt/2KBBQ4EqMjevhbaH97USDiZtglsX8urQ/Dnd+/WYoIr7HHqg?=
 =?iso-8859-1?Q?FacLxsAkymgpHD2quTYtRuQQ4rKUCerBGYIMpv5eWbPo9NSf735ACzv+1X?=
 =?iso-8859-1?Q?QAQf/4ua7sTfVxXQcVhO+XFUTvNsO0MQ27F006rdREqvUpQ=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: hyperstone.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: ecd81556-6325-41d2-9f48-08d9415582e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2021 14:42:57.2581
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 86f203eb-e878-4188-b297-34c118c18b11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /0hzvasNRXj5Dravg9ZIVl4jTd2jnbw/fw5fOVQBP9kdz8LvAdguSkgCOA3y03EesQHENrydNq+Rf2EMWapFEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB2485
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: hyperstone.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

>> CMD16 - CMD42 Set PW - (CMD16)* - CMD42 Unlock Force Erase - (CMD42
>> Set PW)+
>> * May be omitted if you craft the CMD42 carefully (i.e. equal data size)
>> + is pretty much irrelevant, can be replaced with anything that is illegal in
>> PROG.
>Oh, OK.  Interesting.
>This functionality is missing in mmc-utils.
>While at it, I encourage you to consider adding it.
>
>Thanks,
>Avri

That is true and I have thought about it. Unfortunately a locked card currently will not initalize, so not be open to the ioctl interface.
So in fear of doing more harm than good I would first change that.
(One thing is reading of SCR is required by linux-mmc but locked cards must not respond to it).
Something I'm working on on the side but don't expect anything very soon.

Kind Regards,
Christian

> 
> >Again, can you share the sequence of the commands you are using?
> >
> >Thanks,
> >Avri
> Hyperstone GmbH | Line-Eid-Strasse 3 | 78467 Konstanz
> Managing Directors: Dr. Jan Peter Berns.
> Commercial register of local courts: Freiburg HRB381782

Hyperstone GmbH | Line-Eid-Strasse 3 | 78467 Konstanz
Managing Directors: Dr. Jan Peter Berns.
Commercial register of local courts: Freiburg HRB381782

