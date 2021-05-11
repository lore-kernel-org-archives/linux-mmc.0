Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C336C433B4
	for <linux-mmc@archiver.kernel.org>; Tue, 11 May 2021 16:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65AD761278
	for <linux-mmc@archiver.kernel.org>; Tue, 11 May 2021 16:07:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231939AbhEKQIP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 11 May 2021 12:08:15 -0400
Received: from de-smtp-delivery-105.mimecast.com ([194.104.109.105]:56730 "EHLO
        de-smtp-delivery-105.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231908AbhEKQIN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 11 May 2021 12:08:13 -0400
Received: from GBR01-LO2-obe.outbound.protection.outlook.com
 (mail-lo2gbr01lp2056.outbound.protection.outlook.com [104.47.21.56]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-35-9c7pdnARP3assXMDarw6Yg-1; Tue, 11 May 2021 18:07:04 +0200
X-MC-Unique: 9c7pdnARP3assXMDarw6Yg-1
Received: from CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:89::10)
 by CWLP265MB2450.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:92::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Tue, 11 May
 2021 16:07:02 +0000
Received: from CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM
 ([fe80::a91f:361d:5554:3958]) by CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM
 ([fe80::a91f:361d:5554:3958%5]) with mapi id 15.20.4129.025; Tue, 11 May 2021
 16:07:02 +0000
From:   =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Avri Altman <Avri.Altman@wdc.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: Re: [PATCH v2] mmc: block: ioctl: No busywaiting of non-TRAN CMDs
Thread-Topic: [PATCH v2] mmc: block: ioctl: No busywaiting of non-TRAN CMDs
Thread-Index: AQHXQyyR8BdSxkDtf0eUDDANXygamarX43qAgAaVTzw=
Date:   Tue, 11 May 2021 16:07:02 +0000
Message-ID: <CWXP265MB2680EC0A980A794C3B520DBBC4539@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
References: <CWXP265MB2680DC98B32CD4B49AA8A224C4599@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
 <DM6PR04MB657570DB58E7ABBE2C3B0449FC589@DM6PR04MB6575.namprd04.prod.outlook.com>
 <CWXP265MB2680A8DD0FFA6FECBFDFB027C4579@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>,<CAPDyKFqZ580uHgfob5wfn7a_+Y-q3h0YrvirrNYSFT5Q_St2SA@mail.gmail.com>
In-Reply-To: <CAPDyKFqZ580uHgfob5wfn7a_+Y-q3h0YrvirrNYSFT5Q_St2SA@mail.gmail.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [185.80.168.10]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 99e004ca-937f-4469-ef7d-08d91496d08d
x-ms-traffictypediagnostic: CWLP265MB2450:
x-microsoft-antispam-prvs: <CWLP265MB2450A02188DEB7F1C50134BBC4539@CWLP265MB2450.GBRP265.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:7219
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: O6WnOLj6U7AuYflxhn0LuLvLxDnDg/C/f1qaJ1MK3mb46FwWcw85s5EVHs5gO7vTs7LXTJILvKv7KCIPU0OKgg9mF/heEDPZoX0jvG0V1TXTkFSltP6atM7qeEYWlmg78RIrZrhtiOp1SVNmT1il0pjFPytzs3y0v92QOVRiUz6JTD4ic7GGSZrWh9/PZEf0zQCX/btUQZq8Qk7gySTm3lFkkVoyFfNBnSKnfPSHNHLE6iaygmcHS1+i7Ya2PqE2dsdG4HD/dpXDdMOmR6bPq8nUrwE7qWwaSVWFVDYD0TdXz8o4v7rensDYDUbsT907iyOuWePAAfU/bpLaZn53DYzjZnYB+amCKam5AvF3M0Cm2WBnI8VmxtYowsKJDQ20UbAVCWXyF2nCjWQY7adjFRIp6EEJuEU6wuIVVov66kYqfWSHKXwRKg8bD0QiHDPgQxBEzF0HJT+EiwrqHX+VwrxERSDWoihHF+Go2j+kYD10RPpLvOyNKAKE1wNsEt7KO0VTklw01atAr+ewQBesswsYA5ppNc7n+JHlcEP41l6KBLOHAwIPqOrw1PAaVpw1NSrPrqw+ByJBIAvDVWKOilzfoP/PuhkDRFB/7UiM9p4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(346002)(66446008)(4326008)(54906003)(6506007)(33656002)(53546011)(86362001)(186003)(38100700002)(5660300002)(4744005)(122000001)(71200400001)(64756008)(26005)(8676002)(76116006)(7696005)(508600001)(55016002)(2906002)(66556008)(66476007)(8936002)(6916009)(66946007)(91956017)(52536014)(9686003);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?MvIvAHmadLXiA9f7jzMO0H8mKkTpr+ozSwylT73njW7LOEeBtw9nlFUjUW?=
 =?iso-8859-1?Q?c/hII55SBNjzt4MIQu+t5LDREIqwnYcZyW0b1+MyQtxz9PrkEezIxJwH2J?=
 =?iso-8859-1?Q?ZW131ZL0bN3mXSClqu9aughazd1OpW9t8cDThKRXnzt6U9Qtq3rZaXmbeh?=
 =?iso-8859-1?Q?pgMM1efxh+2HCbQ59Rwc1f3BnBHrxd7khegMppR54Kcitc+4kbzHtllW+U?=
 =?iso-8859-1?Q?B9mNyCNuRysjmGLceVwebYdNHOQc3g0TL7OPz7zP3+n+LHFi6YRh9Ho1Ey?=
 =?iso-8859-1?Q?t/9uZbine0DX9kHA0ooIAVPYWhnEedL1qAj+j4uqQDCB4PSOYIJG+7vF2Q?=
 =?iso-8859-1?Q?fhfbMqAu0ljYRJ3Gc2ZYvEzWgIwmaMHfIRJ4kqJSKFLkVl7bCf8D6GK4vK?=
 =?iso-8859-1?Q?CZ9Gby9Gm0EZuUMWk4gdCInzF+Mba+JFCDbUE/Yuuw/uG9KxoZ/NRug9bj?=
 =?iso-8859-1?Q?rws11a6c7D8KKgI0C//T42Ww9o94n9BqPeJScsk7vAAv2mAk4Z6xG+kJFi?=
 =?iso-8859-1?Q?AJVCZrTVUxl6SEELxlhP3+G2GYPOH4527sn/ssnzLxMUv/rD4mfC+JBYkU?=
 =?iso-8859-1?Q?R0HrwekMjWzigB+kBBASYVFUnpaf+aHRWnsI/VMgqltatmEBcJwPCvItfv?=
 =?iso-8859-1?Q?4plB3pDq6CbjPB9sqYckmPoqu7ySwlDpaLTR0eHmvD3DAVgF3tq6HO2vFK?=
 =?iso-8859-1?Q?/NJAs3IfwQbu3HGTpQlYOPEl+jW0TAZVbmeQh3qlWVIB96tsBCJNXnfrW6?=
 =?iso-8859-1?Q?DnT9Y0Y4mnU2XuSwqrBfz2vqW6rEYIYgWCFHlsci49Bol6IWO78NSRv6F3?=
 =?iso-8859-1?Q?X3xEfkFKncLow8AgoACNzQWQNulu8fO8j74amOZ+HVaoAegTaOnC5s27h1?=
 =?iso-8859-1?Q?6q8h4dtvdRMJLx7trxlZiA37hvaBCwDSI5nUJBE8tE+g4JjmR7OeRyPUoG?=
 =?iso-8859-1?Q?MhQY2aayywT4kE5dSBHDtNlX3I4/WMTTRngvqbzNnQBiyR6rSq8JsHxMNR?=
 =?iso-8859-1?Q?hzGqju1rr4JqXt99ktU7sVLkScRBdSEHvG1RtEufk1LN66HDm3sy6+iayB?=
 =?iso-8859-1?Q?eEc2BNYcex3To+7rCqMTIc70ala8rz6aGpSeIKFy07Ovfhns/rjlYvX1hh?=
 =?iso-8859-1?Q?aCHLtQFOJBtY1P+VP7iFDTinHxrzsKEpGdnG9agfM5kY4fHeU3+xkND5Fa?=
 =?iso-8859-1?Q?0u1x3pUZJdcdls3XhOaIGRoX6KnDrpb3YnOkOKpsg7ZlLNwSo9BMlGZJzE?=
 =?iso-8859-1?Q?rE/kOmsYyOf1Y7WNJWz+o6qhJSXKRVVen6k/sG1qrJZHwABH11TuqT84Af?=
 =?iso-8859-1?Q?4kn0Jc3Tysla45NmtP2AZew3JjCssRTD9cZCVgoopQIquHA=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: hyperstone.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 99e004ca-937f-4469-ef7d-08d91496d08d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2021 16:07:02.5242
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 86f203eb-e878-4188-b297-34c118c18b11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CnOaCYyBN3fOq4cCAOkzoy956pwPl88zc7kaJ70pmk6virhLgyeElPBXK8CFCgZuSEA3Daq++oCHG4+FABjnzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB2450
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

On Friday, May 7, 2021 1:34 PM,Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> None of the commands you are checking for should have an R1B response
> according to the spec, I think.
> 
> That said, I don't think we should do these kinds of sanity checks in
> the kernel for the mmc ioctls, that just doesn't scale.

You are absolutely correct, my bad, I had a userspace program setting the
flags wrong.
Even for a SEND_STATUS R1B is only expected if the card was not selected
and should be set accordingly by the userspace.

Regards,
Christian
Hyperstone GmbH | Line-Eid-Strasse 3 | 78467 Konstanz
Managing Directors: Dr. Jan Peter Berns.
Commercial register of local courts: Freiburg HRB381782

