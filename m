Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10703C07E95
	for <linux-mmc@archiver.kernel.org>; Wed,  7 Jul 2021 09:01:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC94C61A2B
	for <linux-mmc@archiver.kernel.org>; Wed,  7 Jul 2021 09:01:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbhGGJDs convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 7 Jul 2021 05:03:48 -0400
Received: from de-smtp-delivery-105.mimecast.com ([194.104.109.105]:33438 "EHLO
        de-smtp-delivery-105.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230219AbhGGJDr (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 7 Jul 2021 05:03:47 -0400
Received: from GBR01-CWL-obe.outbound.protection.outlook.com
 (mail-cwlgbr01lp2051.outbound.protection.outlook.com [104.47.20.51]) (Using
 TLS) by relay.mimecast.com with ESMTP id de-mta-7-XoIVZwVgPlOg0s9j-Rf5vA-1;
 Wed, 07 Jul 2021 11:01:05 +0200
X-MC-Unique: XoIVZwVgPlOg0s9j-Rf5vA-1
Received: from CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:89::10)
 by CWXP265MB1813.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:3f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.19; Wed, 7 Jul
 2021 09:01:00 +0000
Received: from CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM
 ([fe80::259d:65ac:ae6d:409d]) by CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM
 ([fe80::259d:65ac:ae6d:409d%9]) with mapi id 15.20.4287.033; Wed, 7 Jul 2021
 09:01:00 +0000
From:   =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
To:     Avri Altman <Avri.Altman@wdc.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>
Subject: Re: [PATCH] mmc: block: Differentiate busy and non-TRAN state
Thread-Topic: [PATCH] mmc: block: Differentiate busy and non-TRAN state
Thread-Index: AQHXbl0Q77+Qfc7HWE6ez2HIF5qrJas1omGlgAAGD4CAAADv5IABbwLggAAg/s4=
Date:   Wed, 7 Jul 2021 09:01:00 +0000
Message-ID: <CWXP265MB2680AE8D71546A5656B410DCC41A9@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
References: <CWXP265MB268049D9AB181062DA7F6DDBC4009@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
 <CWXP265MB26807AC3C130772D789D0AABC41B9@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>,<CAPDyKFq44ZuXXUDQV34NSW-ixB9GAZfDx+dx-Kb8O7=LQ1TSHQ@mail.gmail.com>
 <CWXP265MB26803EFAC659676EC0914F97C41B9@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>,<DM6PR04MB6575B0049B98254E77BA447EFC1A9@DM6PR04MB6575.namprd04.prod.outlook.com>
In-Reply-To: <DM6PR04MB6575B0049B98254E77BA447EFC1A9@DM6PR04MB6575.namprd04.prod.outlook.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 08530566-c672-40fc-fb42-08d94125bdb6
x-ms-traffictypediagnostic: CWXP265MB1813:
x-microsoft-antispam-prvs: <CWXP265MB1813944B0CAAC11AE2F4BB50C41A9@CWXP265MB1813.GBRP265.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8882
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: OiB8PJIvXK2UpKory9g9cpNYAUNN+H8m5RPmjx3DCG7Z67upFDMzg8R21eiwXI4PROLGJnGBJMEgyQRrW0NMryVgfDiYmwwqK7GWalWjbv7ZXRf3rz+yWj1ZRWmgHwepdYIdMtc4efO/IgKbg0Mf0SaasYHiv0LdB2lrPSYYGQ1hFbwfVKyDi6FTY5s0x+l+jjnQlD1yZF+MWIB9wG1x5ujGCOaCgJuMe1L39eq8hbkRLxxhmlCMlFVhgT6eaBr6Ncm6DehnS5VI/h796hAZ1ckXFnKK5G9xeUlVjog/qhanl6qC4HqJijH61XFKjAXZWL8RtC6Whh7J2OG+7EVd5CRcBndA0qcPHNGlgd/52T+ShWFB8tlxWPzVTjkVtGLAepZSO75u2VKrGuQKbZ1xiDXEwa3wYQ8h1BPU2LS9S5kRdFwY1KQl6entI7+zBdj0PFFk8/dSMulX9VOW1l5+IetJ9ALtMJloyEnhxiQdNV5aOvsdvTqr9JevpoUrPn9BCASYsZJOpDwfZcA9yEQu+g7B+ay+3yFKLVUbwDolw2KOUXPP+D4Lhss5dV4XytIdyZ2urglBsl58P4msxytsGXcpeeP6xqZmmaGSEvpLFPNx6T7ACzIFrF+rjcUu3zkwPBawNwsoep8S2SuLoTbNcg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(39840400004)(346002)(376002)(396003)(136003)(366004)(71200400001)(54906003)(33656002)(8936002)(122000001)(110136005)(66476007)(6506007)(186003)(8676002)(55016002)(38100700002)(83380400001)(9686003)(478600001)(4326008)(2906002)(5660300002)(26005)(86362001)(316002)(7696005)(66556008)(52536014)(91956017)(64756008)(66946007)(76116006)(66446008);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?mf4G8Ve+OEmjjmHlvTB0+2vHzE4WI+ZDGwYfIhdAQpqCNcbHSlHRgRjXpt?=
 =?iso-8859-1?Q?i71jxlGB41k87alsA0RFnUUvrttGFF229acGGmfedVTAXcADub4g+VKuBy?=
 =?iso-8859-1?Q?R/zNNn5VuqKCrUPet5n1MYCPIG23aV1jJ9MNyHBi+10XJAEX5jiRoEXdWw?=
 =?iso-8859-1?Q?5JjL3xv5mzlQqDLjSMNhtwIw0oJjGe9ENhF+eRTiimzuAyuo0LKtyA5U4U?=
 =?iso-8859-1?Q?MJJ3VMD7a2L2TrWCYkm4pOTSbwujpoJo1gQb+pbHlp7+tA9xJTck9Ic8QX?=
 =?iso-8859-1?Q?B441GTc6wld6JRwMeJBmDVbCM/dTk9+x/fXX6E6iWwQ0hrp0LQFE3GUoBb?=
 =?iso-8859-1?Q?hYHqlyLQmvI+/8MM0LUhkOZw6nYNlYPEsSZYJ51/K2EfRnB6VuI5RyO8hb?=
 =?iso-8859-1?Q?g5VPQaWVhoIkLi7iXlzVMXKhpVgzAyp2OulcJxf6S0kRh+AydGdQAP6irE?=
 =?iso-8859-1?Q?p8gJLdjnNE1D4WzSgX2iiAkNcWf8iqxr4HLUymdFap9wA04m3f2U0AjxPq?=
 =?iso-8859-1?Q?+3EUWYorvyqom6hYYTZqt4lMn40Fe5+d42dNwEkGr+Uj0zS3MUZCZduKVS?=
 =?iso-8859-1?Q?i8DGvpwndmgF50JBNgskafWv2UVaU9+I6AZiAUUxYZC/GN7az7QerE3qg3?=
 =?iso-8859-1?Q?n6tZySYQ0KASfNEFxtklX+UluwOWQJlB6Jlog18NAkbpWzC4hYakhmQYHI?=
 =?iso-8859-1?Q?iAxDM8TSLejB+kgfV3+X7kJmckf2sgk+Zsqn+koMn8n+6tZl3JInhMrq0Y?=
 =?iso-8859-1?Q?5P01OjQx6uiC0BuC1b00WnMmBxd058ZOavXmHR3JW90Xikfqbf9O/HmoJi?=
 =?iso-8859-1?Q?adadZsEtRzkX9+iTAzCXX1GzvSwpkOCQSu5q4pPT6ItI3FEMmGz6dAV0dn?=
 =?iso-8859-1?Q?k89/oN76w5xMANltw7CeCG91+YEH6PhwSJSEluxCYr9GmwAmEeqFRoqUgM?=
 =?iso-8859-1?Q?VbU4oaq+L1BRrAmGl4VuUdPKLHJVB9rEZks7U83QPkt4xwjvHYch/UsRcl?=
 =?iso-8859-1?Q?5DTU04KpigKBzmssA/TGEasgDSM6kirKvneg7rc1INf0ZT5yZ/NStOmeYX?=
 =?iso-8859-1?Q?7TD6JsVuGMCT/kq6ZHwP06DjXBqxQcmprFedRB2Ws/Vge7RdmOKPzR54JO?=
 =?iso-8859-1?Q?a+ZN58yqbCNMC4to5CUlnesQ6ZkYTFn+hYAdOXZciFbYwrFVGE4mjofNj6?=
 =?iso-8859-1?Q?BO3d2b9i84dVNBdjZ9i8a6IJJpz6fsVizRWi91vRsDqWDP4rcNG/qYhJrY?=
 =?iso-8859-1?Q?Y08wR1cYJATQq0/oRsrkJE8mjFYAUf7k0OALOHziZ2HvuRZ+KJKNWEo/bc?=
 =?iso-8859-1?Q?UWWhzulaZzCc0y1bQkoMjrV+OL3sMY0yq4OhJHdpdcrbC88=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: hyperstone.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 08530566-c672-40fc-fb42-08d94125bdb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2021 09:01:00.1390
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 86f203eb-e878-4188-b297-34c118c18b11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sWT7hYK8uyX7KW4Q4f1gNeeLcYDXAT5P5k6JIqS7Gsq1whaM8Jm6jUL927hDIomopzQ0Pa+KWfprzq8QQmQY6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB1813
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: hyperstone.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hey Avri,

>Are you using mmc-utils?
No, Im accessing the ioctl interface with my own application.

>Can you share exactly the sequence of commands you are sending?

The one I initially encountered was, as stated earlier, a Unlock-Force Erase
into a new Lock with set password. Basically any R1 (no b) command that
transitions to PROG, so behaves like a write command, could trigger this.
But obviously Unlock force erase is the best example, as a full erase will
take quite some time and many (all?) cards will not accept new commands
(i.e. stay in PROG) until the erase has actually completed. The current
code will not check anything for CMD42 after the response.
I have not hit the race condition with anything but CMD42.

So to be verbose:
CMD16 - CMD42 Set PW - (CMD16)* - CMD42 Unlock Force Erase - (CMD42 Set PW)+
* May be omitted if you craft the CMD42 carefully (i.e. equal data size)
+ is pretty much irrelevant, can be replaced with anything that is illegal in PROG.

>Again, can you share the sequence of the commands you are using?
>
>Thanks,
>Avri
Hyperstone GmbH | Line-Eid-Strasse 3 | 78467 Konstanz
Managing Directors: Dr. Jan Peter Berns.
Commercial register of local courts: Freiburg HRB381782

