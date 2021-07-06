Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BBCDC07E96
	for <linux-mmc@archiver.kernel.org>; Tue,  6 Jul 2021 09:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 429C560E0B
	for <linux-mmc@archiver.kernel.org>; Tue,  6 Jul 2021 09:09:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbhGFJL6 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 6 Jul 2021 05:11:58 -0400
Received: from de-smtp-delivery-105.mimecast.com ([194.104.109.105]:23201 "EHLO
        de-smtp-delivery-105.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231158AbhGFJL6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 6 Jul 2021 05:11:58 -0400
Received: from GBR01-CWL-obe.outbound.protection.outlook.com
 (mail-cwlgbr01lp2051.outbound.protection.outlook.com [104.47.20.51]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-23-mL_Z4pCcNlGQcH_aagBqFQ-1; Tue, 06 Jul 2021 11:09:17 +0200
X-MC-Unique: mL_Z4pCcNlGQcH_aagBqFQ-1
Received: from CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:89::10)
 by CWXP265MB4006.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:123::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.33; Tue, 6 Jul
 2021 09:09:16 +0000
Received: from CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM
 ([fe80::259d:65ac:ae6d:409d]) by CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM
 ([fe80::259d:65ac:ae6d:409d%9]) with mapi id 15.20.4287.033; Tue, 6 Jul 2021
 09:09:16 +0000
From:   =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Avri Altman <Avri.Altman@wdc.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] mmc: block: Differentiate busy and non-TRAN state
Thread-Topic: [PATCH] mmc: block: Differentiate busy and non-TRAN state
Thread-Index: AQHXbl0Q77+Qfc7HWE6ez2HIF5qrJas1omGlgAAGD4CAAADv5A==
Date:   Tue, 6 Jul 2021 09:09:16 +0000
Message-ID: <CWXP265MB26803EFAC659676EC0914F97C41B9@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
References: <CWXP265MB268049D9AB181062DA7F6DDBC4009@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
 <CWXP265MB26807AC3C130772D789D0AABC41B9@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>,<CAPDyKFq44ZuXXUDQV34NSW-ixB9GAZfDx+dx-Kb8O7=LQ1TSHQ@mail.gmail.com>
In-Reply-To: <CAPDyKFq44ZuXXUDQV34NSW-ixB9GAZfDx+dx-Kb8O7=LQ1TSHQ@mail.gmail.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [185.80.168.10]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7fe5bb83-1a84-4cc9-cb0c-08d9405dbb05
x-ms-traffictypediagnostic: CWXP265MB4006:
x-microsoft-antispam-prvs: <CWXP265MB4006DBD9C8AAD1F10FB4DCD4C41B9@CWXP265MB4006.GBRP265.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: OayZVYdoJchMqzsG5wcp7dO/2wFZKlneIVtZLlM81qxgAVpxzKdf8VQurqGaVXXo8VlCYo4YYZ+WSrogdqenGwH2uFEFyxw768Lqw0t2b6RvMSaE1rJ2yu4d7NKKjswBbt8o3yM+ZczHC5vx9e2O2PzBgiK56Xiq3+lMo3SNSj8EiZ3eH6EOvwtH1CbbXTRMJT0LTEE4/GZjTkHjjW/hSF3zc/5XkIhLGgJeQVumfZSFQlAYyK/ojhbaOESKgAqwjokF0OdG6DcP2iFjbbFY/F/L6GS14Isn9GhOPxYFPjta/iyXeCBgrxL81cbAWKX6DXX+gyBthaRa2FTZVzApCm3mx83KDzxFqZ2EKu9VUVfBLZ5nhfQ7CYRAdJ7M1nW3EFLbUdy5LREe+Ladf8GSeykgfcfcSwtuX0uBu1BIEK30MSbaq6Nfbq1EbikYjzbOfuCqkb/LmO2qfEZAQsM1+iuV9kYoanjD5TcjzTjXsFMbud+XLDgXml9Xu4CDzoFp+JgGqUYJTpPBO8PnMPNuhw0SKlz5t303ZZH1bl2DwTKYMtXor5+vfALeLJ31l1vgVSvK5/cFwuEHglgDE3DIhdpneSNdFeTUNpX3pViOCR+hZKfNLr/v83bshBG35ZPlrO87ZS0o6hlDT4TraQV4Mg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(136003)(39830400003)(396003)(366004)(376002)(346002)(86362001)(2906002)(478600001)(7696005)(186003)(91956017)(71200400001)(6506007)(8936002)(52536014)(9686003)(4326008)(55016002)(66446008)(66946007)(316002)(76116006)(66476007)(64756008)(66556008)(8676002)(38100700002)(122000001)(83380400001)(33656002)(54906003)(6916009)(26005)(5660300002);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?bbPhBamf1xsh7aMSid7wRkPTbiwqbe4uZNmoeOQ/wXz1tEF/ze2tb2ETUn?=
 =?iso-8859-1?Q?iEBAq412VK4okL6nMutbtNnN+o1XzN7VYNqbB7eWxWnQQiwteyBgNhprBF?=
 =?iso-8859-1?Q?RaIdqWuygJz6gIuKfey1at60oz+I29eQSSxesoIOU+HQT048BcvfnQfLJF?=
 =?iso-8859-1?Q?beYnx4Xbt7sc5gtzo8aj3VGi7P6aYuJ2wRDlhQ9H6zBzbEGLcrsyeCMBfk?=
 =?iso-8859-1?Q?DkASSSYIrA+g87+oEuuOHuaxY4xPA1KB5tH27jaNxwpN5nnPzmUUSwsWVl?=
 =?iso-8859-1?Q?mVMT/Zyi4t16+l+n/gAJCPd+i6zcpJcTe2lEhXSSspJcdiGR6Kl/y6z5Gk?=
 =?iso-8859-1?Q?ijFmJa2iRGVJIj34iCyZDW2xgzMl1DSfjRWfI2GVGIUGBw6sTK+6TBHfQd?=
 =?iso-8859-1?Q?eDhAftgYqTe4qCsLkkRt8k2KNP6E0wVEu3dnPeaViqGw1+OlAv5gCPfLyv?=
 =?iso-8859-1?Q?j1vsp6vZHkU4mRLqtdA6KiM9IyE8IwsS0ngISAHNXi2aJRf+jzk0yWCiQX?=
 =?iso-8859-1?Q?5IPADOz8zHod2Rw7UfBW0VykraeNKmcjU/HkduBuZTlX80bujmMAoDgoKS?=
 =?iso-8859-1?Q?bTkKliE6/4BzdAwgvdtNIp+9eVuu5HQW9xb7jxQ6VNQ70FwyNxYzJThGQ9?=
 =?iso-8859-1?Q?gLJ/ioR3wpkF0YyAGkSBsNXTxST/GS41u7GepmgIjCTZlr1u1ZMF5U8h2p?=
 =?iso-8859-1?Q?1RPrZ6bGiyOBkfOn9PUfCAS8J4zXeJeTIIKNHU4nVR+Ge8DZVjkMHbm6d3?=
 =?iso-8859-1?Q?Y58KFEXnqjyTUx4rChl6XKSSQv82c9TafJYYpKjz+Gk/i42oZYadcCS4KO?=
 =?iso-8859-1?Q?NzH1LibQpv0bnMEm6S4I6EaTFG6cQMxkVK6etu/hellGlGrT/xFBhd84wC?=
 =?iso-8859-1?Q?1YNhnCFJ8vu3TmARQF4FFGhQ3WevhewZl0KitaO5hQqDllGO13b6Vop21n?=
 =?iso-8859-1?Q?fpEmOhHswrWBE33nCeu3FHLpmHk3T64oUlAuMSxpp0aPL8Z4g1hSCGOpkW?=
 =?iso-8859-1?Q?EhpbSl5rMyyV6vfWSlZicGB8qmpBzvJz83aX3YSKh3O8fAxP/adhDJmvpA?=
 =?iso-8859-1?Q?YOsfi3PgohEPjqd2VyTMyRRQXOSqOiu06rXB57UOqRWLtnxMEQjI1j+V4q?=
 =?iso-8859-1?Q?OaesP7Hzmoio+C9NT+daWfYwPmwE1S0UBobweM9nnv0t40LDxPRYML1QgQ?=
 =?iso-8859-1?Q?iNuuqZmGLA/olBNOphstp7cZ1bAINQUOAIwnoYFFne+prPbbGkb+N796Kk?=
 =?iso-8859-1?Q?BpVzFSSOwScp82QwNvBKfrt6rlhbtLbi76vMb77pBvjtL0YxjYqeMRQ25P?=
 =?iso-8859-1?Q?VOp9sXQsHU2C6eOV/rnO4gmRR+tW/j5/Yq0gocnzy+cCacw=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: hyperstone.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fe5bb83-1a84-4cc9-cb0c-08d9405dbb05
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2021 09:09:16.2624
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 86f203eb-e878-4188-b297-34c118c18b11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UEGVgZC7J9Tr6+jVbMT/3y5QL6As+qTnPCFFidWHwjJMq8bbzzFuTmEarBTsArds6v4blD6uSgUqZ+g+oeLxhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB4006
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

Hey Uffe,

>> +static int is_return_to_tran_cmd(struct mmc_command *cmd)
>> +{
>> +       /*
>> +        * Cards will never return to TRAN after completing
>> +        * identification commands or MMC_SEND_STATUS if they are not selected.
>> +        */
>> +       switch (cmd->opcode) {
>> +       case MMC_GO_IDLE_STATE:
>> +       case MMC_SEND_OP_COND:
>> +       case MMC_ALL_SEND_CID:
>> +       case MMC_SET_RELATIVE_ADDR:
>> +       case MMC_SET_DSR:
>> +       case MMC_SLEEP_AWAKE:
>> +       case MMC_SELECT_CARD:
>> +       case MMC_SEND_CSD:
>> +       case MMC_SEND_CID:
>> +       case MMC_SEND_STATUS:
>> +       case MMC_GO_INACTIVE_STATE:
>> +       case MMC_APP_CMD:
>> +               return false;
>> +       default:
>> +               return true;
>> +       }
>> +}
>>
>What exactly are you trying to do with the user space program through
>the mmc ioctl with all these commands? The mmc ioctl interface is not
>designed to be used like that.
>
>In principle, it looks like we should support a complete
>re-initialization of the card. I am sorry, but no thanks! This doesn't
>work, but more importantly, this should be managed solely by the
>kernel, in my opinion.

Doing initialization itself through ioctl is silly, I agree, and does
not work on other ends. This patch is not about that. it just explicitly disables
any CMD13 polling for TRAN for some of those commands. the behavior
for such commands thus is the same as without the patch.
The reason for this patch is to not run into the race condition that a 
following (ioctl) command will be rejected because the card is in e.g. PROG state
of a previous ioctl command. As stated earlier, I encountered this a lot when
doing a unlock force erase -> lock/set, in both scenarios, issued as two single
ioctl commands and bundled together.
But this race condition exists on any (non-R1b/ RPBM) currently. As there is
no CMD13 polling happening after the response (or whenever the driver marks
the request as done), the card's status is therefore generally unknown.

So in short I don;t want to do anything too crazy from userspace, but the
alternative now is to do like 100ms sleeps in the hope that the card is
actually finished with the issued command (not just the host driver so to say).

Kind Regards,
Christian
Hyperstone GmbH | Line-Eid-Strasse 3 | 78467 Konstanz
Managing Directors: Dr. Jan Peter Berns.
Commercial register of local courts: Freiburg HRB381782

