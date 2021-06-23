Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C66D4C4743C
	for <linux-mmc@archiver.kernel.org>; Wed, 23 Jun 2021 13:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF1FD61075
	for <linux-mmc@archiver.kernel.org>; Wed, 23 Jun 2021 13:45:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbhFWNrc convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 23 Jun 2021 09:47:32 -0400
Received: from de-smtp-delivery-105.mimecast.com ([194.104.109.105]:26474 "EHLO
        de-smtp-delivery-105.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230283AbhFWNrb (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Jun 2021 09:47:31 -0400
Received: from GBR01-LO2-obe.outbound.protection.outlook.com
 (mail-lo2gbr01lp2053.outbound.protection.outlook.com [104.47.21.53]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-17-0SKPCipcMpilfm6lfumPyg-1; Wed, 23 Jun 2021 15:45:11 +0200
X-MC-Unique: 0SKPCipcMpilfm6lfumPyg-1
Received: from CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:89::10)
 by CWXP265MB2901.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:c1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Wed, 23 Jun
 2021 13:45:10 +0000
Received: from CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM
 ([fe80::259d:65ac:ae6d:409d]) by CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM
 ([fe80::259d:65ac:ae6d:409d%9]) with mapi id 15.20.4242.024; Wed, 23 Jun 2021
 13:45:10 +0000
From:   =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
CC:     Avri Altman <Avri.Altman@wdc.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "shawn.lin@rock-chips.com" <shawn.lin@rock-chips.com>
Subject: Re: [PATCH] mmc: block: ioctl: Poll for TRAN if possible
Thread-Topic: [PATCH] mmc: block: ioctl: Poll for TRAN if possible
Thread-Index: AQHXXSMDiXAg1fej0U+LBOvD9D6/9asZlxVhgAANSQCAB8I3uA==
Date:   Wed, 23 Jun 2021 13:45:10 +0000
Message-ID: <CWXP265MB26809D4177534C6CDE0A902AC4089@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
References: <LO2P265MB26880B222999818677722528C4369@LO2P265MB2688.GBRP265.PROD.OUTLOOK.COM>
 <CWXP265MB26809CC8BCD8A0289697CBBDC40D9@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>,<CAPDyKFr6bfcG+_3f+8ZYFFsuTA9reJ4Ykntxt=yh16-Z_6vxAg@mail.gmail.com>
In-Reply-To: <CAPDyKFr6bfcG+_3f+8ZYFFsuTA9reJ4Ykntxt=yh16-Z_6vxAg@mail.gmail.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [185.80.168.10]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f624bccc-0fd3-4358-4f27-08d9364d1e8e
x-ms-traffictypediagnostic: CWXP265MB2901:
x-microsoft-antispam-prvs: <CWXP265MB29015DE7E3A5A737605F91A1C4089@CWXP265MB2901.GBRP265.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: qXtb1zS9FriuQ3oTmX3mCFuxFRz9qpSJYyHrWB4oMuXL2Co7E+U3BUABjUwnk3MoQloNXovNK5sEBJhuPvgfREgRcc4Ffo8AEND+o3jzDWskqFGNuXYCDFw8+9GWNw/azzgJ5fo3YQImvEzhQKhX/7u2oBrZ3T+IaVsEk1qTiTApUE7c5XjCOYcNGM4k4u/8AVQNY2bh1WLz7krn74dcmGaCzDr79nIJAm4Np2BxRFpKqz2Uyt7d2MysIeGH/KCVVbcLLX0bI3E4DfNaYTA3aoh9H9rVio9/dIcWyvUf0EVtJzqp06lHokZFKQebuChOUmt7E8tfdVScUcIdRtEQiQOZPpc7Yr1uQ9fobKHw2DRn49smJ8UzCWFoTD57ar6itqPE4lKnF5wGsvX5X6VUaxj5dDb4za8qCdklh0ymAO7pd3NFOEywJBSCo/uwAk+D8861MgSLFvFaQjRvbMTFKROOlF+WsrFjWCsdFbV951ihjiBFfq/bzyKPVMWm0lxo6pQbu1g3dWU1QQV6JUynr47p4ACKvPlm7/xr6pGb0fKQKvhNyrqdXB7LB/+86rbPVPDmfMTfcZ9uQLtkzYb/fywNOdzXkZQT0cU+cKbI8zM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(39830400003)(396003)(366004)(346002)(376002)(136003)(7696005)(26005)(33656002)(6506007)(2906002)(186003)(83380400001)(86362001)(8676002)(71200400001)(8936002)(122000001)(55016002)(9686003)(38100700002)(478600001)(66946007)(5660300002)(52536014)(91956017)(76116006)(4326008)(316002)(64756008)(66446008)(54906003)(66476007)(110136005)(66556008);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?NdQoLouhlSiOPoijfQEbpo3Y/jcsZ0Pbt/2yFtmhsHgNgeJ9UVXXa5H6oR?=
 =?iso-8859-1?Q?dqy5imrxNR93QlQoTEVaXMZhXHJUvyvdhpSAwecCG3V0Ek4WYJMOLAvtr2?=
 =?iso-8859-1?Q?fQjrKlovGzTLBLU7edWKVMEXczkE7ap6YJvF8ufM4sVxJG5SzG7h9JiHbk?=
 =?iso-8859-1?Q?gdjQpyDaQ9R17T4LAceo9AP0/oGbvF8WWcj+3H0h+vBgMz5x5WkNGZbqtf?=
 =?iso-8859-1?Q?DduZeaOu21jKuHAR8MG+hKsOqjCRP6ZlZ6TqfreDYraFs1NB8MC8J/Hb6C?=
 =?iso-8859-1?Q?IN83Qq018MqDP/MFpufaE5Em54WFwECwc7itEcbDo0K9+QzZGOIa5OV+n9?=
 =?iso-8859-1?Q?aMv74fOUU0CD52kdZy6nOtCP3r0rSTwBJ4xHGgnqXX+MwUw7WxV8ysbwlz?=
 =?iso-8859-1?Q?+yPA0P9Gp1tzsTa1tWp/3bYjxIdZjzG9/dfdIljznU0DIdUsGr4vL0yPgO?=
 =?iso-8859-1?Q?gt6pBnlzda+M3tOw8h8BaVsGPWZxuT8knOkcwCHM4WX1DrfmjyrMl2hlkF?=
 =?iso-8859-1?Q?DpLz6mDYgQPzeBgxxPw21aKpZ1DE3htiU2/zcQ+8CIduJclVEly1kAOeJg?=
 =?iso-8859-1?Q?yAX9YCuENH0tBo+6TYO/4DgeP0Vv3scYwQKgBXmfaDJ7E9CVouOC1NooXH?=
 =?iso-8859-1?Q?MNJxsjNMmQo903LrzpS8hGDJwoP/AInlH8YAyqyaNWFQ6VlEhh3c3HQVFo?=
 =?iso-8859-1?Q?rT0rA8DSHmar2Ty+o9UdFOIpYc4g93rlHLlBxwpJUXBpitIoELF1qt29X5?=
 =?iso-8859-1?Q?g4HVFmDmSAAdeH4T6bLPVBJDJQiSPZgNZvpVJhC5t5nwyyEGj5fUbP9zkI?=
 =?iso-8859-1?Q?XiYoa3CKeiSnxVc0V5wjcy1cjYTB33Q8t3Abn/+z9UnPkinSZeiaI3U+Ew?=
 =?iso-8859-1?Q?YSJfDugZ1Wn+kKuAWge5AhR2Cvy0AVAsE3KYV5KL67S69PTZNsdg+7x/DA?=
 =?iso-8859-1?Q?NolR2zflIlv6xk8U9J6BCGxvMpc3FJieRJ5fN4vQ9bEhw7TCtMyLxDXvp0?=
 =?iso-8859-1?Q?CNFHb0W/OMsMidmdHVE6njctSkl4kTXuyHId4sU12fymNdmkLjY3hV97n9?=
 =?iso-8859-1?Q?6CJ96owf1iGV/SJk2fkndehxS83NvpySwwwyVNyWvfQP+8Hy6llh4dodHU?=
 =?iso-8859-1?Q?1PLyCRBSo5d+OMQ6uQpXykD6iFetlJYu6klQJy9cn08h9P7Rc87ELBjucB?=
 =?iso-8859-1?Q?+eYi8ha4gRY1wHsk8MyF+y3EJKoAoEmk04SgIi8SzIWYx50K+7bnkN6ECz?=
 =?iso-8859-1?Q?L/HXd/oHXSc2b7mZz8CvAa5egClCt1x/gNp2gMl8H7f5tdBx8QyH+sdXy+?=
 =?iso-8859-1?Q?nKF2SUbObnAiXN3mMMtcLsPUOaQH4K80rJPky1QYlLF/rNE=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: hyperstone.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f624bccc-0fd3-4358-4f27-08d9364d1e8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2021 13:45:10.1276
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 86f203eb-e878-4188-b297-34c118c18b11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N0Tc65Y02NiC0SAvv8M5HOWVl5ihJ7DfiQS3GGVYByTklRvQPi2fHfYWi7llm8hrrKsZZ4ucj9XCQic5NhrJuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB2901
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

Sorry Uffe, Im not quite ready and need some more testing myself before v2.
But I can outline and reason the need for a (now bigger) patch already.

mmc_ready_for_data checks for R1_STATE_TRAN also, comment says something
about cards abusing status bits, please warn me if this is an actual issue and in
what direction (From the code I'm assuming R1_READY_FOR_DATA may be
set when the card is not actually ready, but R1_READY_FOR_DATA is not unset
'randomly')

But for v2 I would keep the ready_for_data check on R1b commands,
but actually only check for R1_READY_FOR_DATA without any state.
(This could include Shawn's hardware busy_detect patch).
Then afterwards, for return_to_tran commands, do additional CMD13 polling.

I'm still struggling to get this 'clean' and race-condition free, because of e.g.
CMD5 MMC_SLEEP_AWAKE always signals busy, but only transitions to TRAN if
sleep bit is not set. Busy detection should be done in both cases, though.
(I then should be able to send MMC_SLEEP_AWAKE sleep and
MMC_SLEEP_AWAKE awake and MMC_SLEEP_AWAKE sleep in direct
succession from user space through the ioctl interface without any further
considerations from there.)
But clearly MMC_SLEEP_AWAKE sleep will never respond to a CMD13 with
busy bit unset, as it is in sleep then. (Shawns's hardware patch could be used
as a best effort.)
Maybe I'm overthinking this for an edge case of a rarely used ioctl interface,
but that is my status so far.
If I leave out perfect MMC_SLEEP_AWAKE behavior (and maybe something else)
then:
if (rpmb or R1b response)
    card_busy_detect (status bit only)
if (return_to_tran_cmd)
    card_poll_until_tran (using cmd13)

would be ideal.
Feel free to comment on my thoughts so far, until I've tested it some more.

Best Regards,
Christian

From: Ulf Hansson <ulf.hansson@linaro.org>
>I need some more time to review, but feel free to post a v2, I can
>look at that instead.
>
>Kind regards
>Uffe

Hyperstone GmbH | Line-Eid-Strasse 3 | 78467 Konstanz
Managing Directors: Dr. Jan Peter Berns.
Commercial register of local courts: Freiburg HRB381782

