Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEEE1C48BCF
	for <linux-mmc@archiver.kernel.org>; Wed,  9 Jun 2021 11:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A528761364
	for <linux-mmc@archiver.kernel.org>; Wed,  9 Jun 2021 11:31:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234611AbhFILdi convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 9 Jun 2021 07:33:38 -0400
Received: from de-smtp-delivery-105.mimecast.com ([194.104.111.105]:25757 "EHLO
        de-smtp-delivery-105.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234243AbhFILdh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Jun 2021 07:33:37 -0400
Received: from GBR01-LO2-obe.outbound.protection.outlook.com
 (mail-lo2gbr01lp2053.outbound.protection.outlook.com [104.47.21.53]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-12-tCTfXPlNPPOsvIjlie_uXw-1; Wed, 09 Jun 2021 13:31:40 +0200
X-MC-Unique: tCTfXPlNPPOsvIjlie_uXw-1
Received: from LO2P265MB2688.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:143::6)
 by LO2P265MB2576.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:13d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Wed, 9 Jun
 2021 11:31:39 +0000
Received: from LO2P265MB2688.GBRP265.PROD.OUTLOOK.COM
 ([fe80::4c99:397e:488f:4c60]) by LO2P265MB2688.GBRP265.PROD.OUTLOOK.COM
 ([fe80::4c99:397e:488f:4c60%7]) with mapi id 15.20.4195.030; Wed, 9 Jun 2021
 11:31:39 +0000
From:   =?Windows-1252?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
To:     Avri Altman <Avri.Altman@wdc.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "shawn.lin@rock-chips.com" <shawn.lin@rock-chips.com>
Subject: Re: [PATCH] mmc: block: ioctl: Poll for TRAN if possible
Thread-Topic: [PATCH] mmc: block: ioctl: Poll for TRAN if possible
Thread-Index: AQHXXSMDiXAg1fej0U+LBOvD9D6/9Q==
Date:   Wed, 9 Jun 2021 11:31:39 +0000
Message-ID: <LO2P265MB26880B222999818677722528C4369@LO2P265MB2688.GBRP265.PROD.OUTLOOK.COM>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [185.80.168.10]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c7a4fc51-2b96-4015-a474-08d92b3a2636
x-ms-traffictypediagnostic: LO2P265MB2576:
x-microsoft-antispam-prvs: <LO2P265MB2576E323839B235D58569814C4369@LO2P265MB2576.GBRP265.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: 3KtiNIlB99AvE4kMKPZfL2ACnBzKKDbce843UMHbtXZbb+Vqw+eGFlQcnuWWKsMaBiyYzUP1mnkC4w/n6kU3C49xKscuWprzYpyjGfJaRIZQtPqYSYlAOf9dyATTsd4gRFVQSgJpd0Ky8a3yRRBA51guaEMBmOZad9khhm12u/ITBC6W0mL3n04z2HwE+CIZmqEOwzZgmqhesaFLiIaWYf9ocAer++yUcwU1a2jGhcuI6OL1Ttx2/A58WlrPTiAZeuYYD+h9G6+v39KLu6sBZb3gKn+FCBd0kxqUFz3ibQP/oTMu+VSxZhlCFQZ2PG4xEQtMEey6+/fO/4lulkBlQ9PEduX6NfVkE9L/ahZOC/fO3GTWrRvzQa07wpnPhCZn+ArwxIsGxcAeOXnvmwOpID08eIRO7BEu1q+d4R0fIkTB8Wa6wXNsWSCSQLVvSsPauwydlbrDzduMolFEOajh2UoqM4K1JkLK5AyEtvRC9RAqeEUJXku9Fn+z4DBNLFM0tY0ct3tL2Eiad2YibSyldAUXANZoFFtr+anx97CTJw8vEnePc3JkseBMjPgBYzn7dRYnLB3NwDpQxoQa2LctW8ahw5hOhqv9X15uMKOCTLY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB2688.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(346002)(396003)(39840400004)(376002)(136003)(366004)(66946007)(478600001)(86362001)(76116006)(2906002)(7696005)(71200400001)(122000001)(186003)(66446008)(64756008)(91956017)(316002)(110136005)(5660300002)(26005)(33656002)(66476007)(9686003)(8936002)(8676002)(52536014)(38100700002)(66556008)(55016002)(6506007);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata: =?Windows-1252?Q?DhPZdkG0rEZhjzSYZLq7pZhQQJXPB0HjMVkLAxxuYF9LDBdA6ijq6/BQ?=
 =?Windows-1252?Q?xSYeHp5VcAMXpGMzLjLwmRKLAB3L42gRk4d7xHhLEK+2vOPKVC7ZmAQQ?=
 =?Windows-1252?Q?pnL64/XIGi/UnAahQ7W0Aw4TfbGcYNvI0bSu2jl1WDbcZNrvYzmAM22x?=
 =?Windows-1252?Q?FczOMtI2Rle0liW4fdEnFqz56dYq1UtjrSx73SJ3A55BoiOLvJofYmKJ?=
 =?Windows-1252?Q?rpM9CfTIKAuOxg+CJsvPgb1prkRrFEUwPfKrTRjj+3bBonylKzmfxme7?=
 =?Windows-1252?Q?Ah3jKe4Mxhq+9Yp8lea7RRVkB/iqZPeXcMRQ8p/fNpUXg6bR+dO6iR2p?=
 =?Windows-1252?Q?wy2nWMebf9j11A5FvYerYpBPYwFggmylgYLebwwBdlTTAMyzHB//JGJL?=
 =?Windows-1252?Q?UZIbld7FnfcrnEgk8HXMCLIEl1j20KaaWkK1GYubawWxQcXt7pRViHCb?=
 =?Windows-1252?Q?NOdibhquNlBcCNdFysZ7OiaxrVe+eWHkkEu1Cek+rxG77hFJwCzvUYtA?=
 =?Windows-1252?Q?dQ4ch4dcvTplk7YAKXzD0mj3GsTfyEfKA2dNj61a3NVpGnPDA4d9+Tme?=
 =?Windows-1252?Q?bQBdehOhUMnQJfoqaTytw/tpR3d5opNsLlxUG/NDweapHFd9A6nZ/TAr?=
 =?Windows-1252?Q?LyiCSVF7qLYaTRXNqWBxwQRBNV4ZyJW7kTL6NdbjRW4Rl8mNi8wLv8R8?=
 =?Windows-1252?Q?m55PWQmfEOjKHgapHyUbO0OgCCr/HXKPpHZhNMHqerCMI3hpA7QqBVOx?=
 =?Windows-1252?Q?IEj1cdIRNokciuGNz6ayhbZ2kZOkqmOlVCYzjtxmFVAMajQKh5OPo/rZ?=
 =?Windows-1252?Q?BUvvNWBWLXfXnCcK9iKM/PHxO8VypNZh6TvSyrXUMd/MP23BjuNllvc/?=
 =?Windows-1252?Q?ZE3iLSQszpWUZDH2CPtrlk01s4lvfjpEl/UVb07NHPM/fGSnWtIcQrIE?=
 =?Windows-1252?Q?JksEL6WLXRM01R3RBGiqRHC6V/zlhCC4SM5GCVQZEk1CqFLAKxvbUei6?=
 =?Windows-1252?Q?RnsZCLTCCCd1NOUY0cGzDkefms4OJF7coUkydbt9xiuqfZKyVCxPLisA?=
 =?Windows-1252?Q?UZb4/k4s6tlthP56v633/97gn/mRQ2G/nW1wxkgFYFpeBCWxRnbRK5Ex?=
 =?Windows-1252?Q?+WlkqIaUIoXJ70USkS5EWZpZ0jXohNZ8BQIAgRdBSwx0wl+lPwZwIArK?=
 =?Windows-1252?Q?KN18AyXV9x7uI9LiiuBDio8r+tsu/oixcFcoS9P8pVHvQGZM77yVtNjM?=
 =?Windows-1252?Q?+Q9bTf+vk5Uk6PXfLXBt9eXAYzREgP1lUx4G4ANxIct2LRGa9LeayicV?=
 =?Windows-1252?Q?PICZJiNQMKF83ou7ROQLLOVYXg0Fz7QtWjOqeC7ZwHUXzdfPSFrheLbh?=
 =?Windows-1252?Q?xLtxI36LwouQrCx2paiGjrURlgOu//ywANg=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: hyperstone.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB2688.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c7a4fc51-2b96-4015-a474-08d92b3a2636
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2021 11:31:39.7444
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 86f203eb-e878-4188-b297-34c118c18b11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aSHQl+QK5kZEfVsmbDcvu6iMlTdjz9cWy6wTqP78MyGX7vDpZuGlLE2f7oCmODNPINOnOvkIdDoPOzUYwvmINA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB2576
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CDE5A68 smtp.mailfrom=cloehle@hyperstone.com
X-Mimecast-Spam-Score: 1
X-Mimecast-Originator: hyperstone.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

>> +        */
>> +       return !(cmd->opcode == MMC_SEND_CID
>> +                       || cmd->opcode == MMC_ALL_SEND_CID
>> +                       || cmd->opcode == MMC_SEND_CSD
>> +                       || cmd->opcode == MMC_SEND_STATUS
>> +                       || cmd->opcode == MMC_SELECT_CARD
>> +                       || cmd->opcode == MMC_APP_CMD
>> +                       || cmd->opcode == MMC_GO_INACTIVE_STATE
>> +                       || cmd->opcode == MMC_GO_IDLE_STATE);
>> +
>Aren’t you only interested in cmds that move to tran state from other state?
>According to the Device state transitions (table 61 in eMMC5.1) it only concern
>cmd7 (stby->tran), cmd12 (data->tran), and cmd14 (btst->tran).
>
>Thanks,
>Avri

No, I'd poll for any command where this is possible, so I only exclude the
ones not ending up in TRAN.
The TRAN->RCV->PRG->TRAN commands are the ones that need polling
to be race condition free.
Technically CMD16, 23  and so on (TRAN->TRAN directly) don't need the
CMD13 polling but it does not hurt either, especially because the cmd->opcode
itself overlaps for general and sd commands.
Tracking whether CMD55 was the last command would have been awkward and
CMD13 polling wherever possible seems the more sane option.
If adding a flag to disable any inter-CMD13 polling of none-R1b commands is
desired, I can add that, but I did not see a good reason for that right now.

Regards,
Christian
Hyperstone GmbH | Line-Eid-Strasse 3 | 78467 Konstanz
Managing Directors: Dr. Jan Peter Berns.
Commercial register of local courts: Freiburg HRB381782

