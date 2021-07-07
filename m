Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC14BC07E95
	for <linux-mmc@archiver.kernel.org>; Wed,  7 Jul 2021 14:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9941761C37
	for <linux-mmc@archiver.kernel.org>; Wed,  7 Jul 2021 14:36:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232042AbhGGOio convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 7 Jul 2021 10:38:44 -0400
Received: from de-smtp-delivery-105.mimecast.com ([194.104.111.105]:30059 "EHLO
        de-smtp-delivery-105.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231993AbhGGOio (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 7 Jul 2021 10:38:44 -0400
Received: from GBR01-LO2-obe.outbound.protection.outlook.com
 (mail-lo2gbr01lp2056.outbound.protection.outlook.com [104.47.21.56]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-26-uJ57HpaDM66CVp4f0KSwog-1; Wed, 07 Jul 2021 16:36:01 +0200
X-MC-Unique: uJ57HpaDM66CVp4f0KSwog-1
Received: from CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:89::10)
 by CWLP265MB3828.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:110::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.31; Wed, 7 Jul
 2021 14:36:01 +0000
Received: from CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM
 ([fe80::259d:65ac:ae6d:409d]) by CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM
 ([fe80::259d:65ac:ae6d:409d%9]) with mapi id 15.20.4287.033; Wed, 7 Jul 2021
 14:36:01 +0000
From:   =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
CC:     Avri Altman <Avri.Altman@wdc.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>
Subject: Re: [PATCHv2] mmc: block: Differentiate busy and PROG state
Thread-Topic: [PATCHv2] mmc: block: Differentiate busy and PROG state
Thread-Index: AQHXcwny68++j12etUaztO/Yg7lHlas3aFYAgAAVZiM=
Date:   Wed, 7 Jul 2021 14:36:00 +0000
Message-ID: <CWXP265MB26804E1F676F532D08A9BBFBC41A9@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
References: <CWXP265MB268049D9AB181062DA7F6DDBC4009@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
 <CWXP265MB26807AC3C130772D789D0AABC41B9@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
 <CAPDyKFq44ZuXXUDQV34NSW-ixB9GAZfDx+dx-Kb8O7=LQ1TSHQ@mail.gmail.com>
 <CWXP265MB26803EFAC659676EC0914F97C41B9@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
 <DM6PR04MB6575B0049B98254E77BA447EFC1A9@DM6PR04MB6575.namprd04.prod.outlook.com>
 <CWXP265MB2680575489E508DC75D84857C41A9@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>,<CAPDyKFrCtRTHZYRjUecvrqr=YyhrTw+HXtdLRHeOTxoK94iSRg@mail.gmail.com>
In-Reply-To: <CAPDyKFrCtRTHZYRjUecvrqr=YyhrTw+HXtdLRHeOTxoK94iSRg@mail.gmail.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 95cc116b-e3d7-4cbf-cff4-08d941548aca
x-ms-traffictypediagnostic: CWLP265MB3828:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CWLP265MB3828C706E56B8A2164AF8DA5C41A9@CWLP265MB3828.GBRP265.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: lKc8vMnqXpLcwkdZejwBnu278Uirr+aEbJ6MVBKobacyFBYV78BtBdVIwkPTgvNFRK5ngyKZzb5U64aHp3IM64+5qHpCj1dyYkrDjM71IT6WS+Myw+AdJfpV8lliZ502dVkD9Plz5WmBj79doTLFV4P3gqQPR9jNEXsOisYWJMEGdmYEk5Pa3c+crjdTLLMi9AAR2UJYlqDqex/55x75dYANyTqyzQhwcT3JEmDVl1dndUAH+WvqqK29OqDICbYaqRBLkj7jwH36WUBIXVk91LcyxK1hS1ckwB7ZdRPZQ1AGF5UdsnEBAJaMgEZ65cB4hSq43YQgNahSiofWw2iaUQFF3g/HaR73Sv+d9Mo6TvNhCMmXy4QI0se/KWHlRVxWPvSh3BznQjSTQySOgir6oP72i7Sy8NLvIAc93cV0jKrnymFz7RmDsy+9L7Z93D073V1pJw3cv+g+odWF/Hh4d4sCGgEHbb6QIEAwOtl2bP+wyVFvSWFDHCslRpXHgCSq7a7/mbF5s4Bklbwr9yPxgzIW94bhgb8QetVqzfanhBrGv4Frbv7BKHe8+p7PE3Zd8Ov/IAgwLUvcR57tT5Oax5NUpjIua7bQVy5AansJN86mYSnWCOBR59JWKpe9wwAz+1Eyrwh+KSzVOFm/rNMh3Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(39830400003)(346002)(396003)(376002)(136003)(83380400001)(110136005)(33656002)(122000001)(55016002)(71200400001)(38100700002)(86362001)(26005)(91956017)(6506007)(76116006)(8676002)(316002)(66946007)(64756008)(4326008)(66556008)(66476007)(2906002)(9686003)(478600001)(7696005)(5660300002)(66446008)(8936002)(186003)(54906003)(52536014);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?e7WEYSuN+gO4q+naQQn1V9Wp/IGfrZPrlGGCBzavOYTRlASUSW9Dd1lnOE?=
 =?iso-8859-1?Q?mkV5DoQd2kTUVzPyfVuZUl9b2A2mbx0PepENLKQwyX/9kHXlRrQ3kzbmGB?=
 =?iso-8859-1?Q?LP6Ei6ToP8TmE8MKtkUhowzlJzHKHI3ziYR+jyyCwtuRIaxYD00zeTonK9?=
 =?iso-8859-1?Q?DjliCfhck20oP5QC9I2Vy51EC3uISEkrRWmXjugEJGq3vHlO7YdF2HSUXK?=
 =?iso-8859-1?Q?Tv9YXG0duf5SscbHO48w/mxhDjTe3umWSw9sdfyFxTh/xen/WBUKcG1Vpc?=
 =?iso-8859-1?Q?vEkA5t1d5uOABFM0VKIjKq797le/jDbF3zWimP/A/VWOY4VeCf19BnKYOL?=
 =?iso-8859-1?Q?BgvXwxfcHwr0gBXhJGe0NT7BJY1iKI4CdEAMwmFBmbMkLjr/i+f9XfdxWC?=
 =?iso-8859-1?Q?TAvfGbMTKr8bE1TBSUrIsZ/1IGOVpLFA23b1/Uslh4bhh8pWmEZdAOEM75?=
 =?iso-8859-1?Q?mOv4cnqZsolnuS1nOsLwdZd1Q31hoB/cdAxz3nPVpSuOkE4Hey9wJKVUDE?=
 =?iso-8859-1?Q?t/+9ywTEdfEO3EofOsAAUvJhvi3TX+3rhhQGwA+oXj825qGq+AECrZJWsY?=
 =?iso-8859-1?Q?PNZAzjpGT7ErsnEDtY1+8bBB0u/hnthVn05RJ5wec09lziEX5ScP97+d/u?=
 =?iso-8859-1?Q?ll+Vmyp0lgzxJwop+kb/zWZ/M5s8/XjhH5TL65qLtjpEP23+eUJ5TU+I4j?=
 =?iso-8859-1?Q?6HRHtrQjahv1lIlgwpueprUuboFJX98cAzEXNo7YUIYROwQhBsrA/hlfWt?=
 =?iso-8859-1?Q?cgxWxZ+mFG2+Hpf+hR9uo36o9MRQPnRZ/CzkP6r68oIYb5H1CJSuCsdcmu?=
 =?iso-8859-1?Q?NvBeavSalOiKMVqSqzvG1md0KbiflLz1lAtkSt/IH2XiQdDyJpz/3kclmR?=
 =?iso-8859-1?Q?Mi+e8id+UWNUdwzbXnFKFcdDWqt/jpOCL805htiefoBf8MKvmxMlmJMwmp?=
 =?iso-8859-1?Q?VWIzG32PGDNniU6AcDeqbRz7VJv3QbvOZPqbjqdYFF6MGjSPnebtHlhww7?=
 =?iso-8859-1?Q?mX3tRM19/a2roBWpUJpj4X2uIrDDtr5lofAht25ETRdzHFwH6nQLkxES7x?=
 =?iso-8859-1?Q?lcNt8QFxpwELa7QyMEQsDuPLVo4pe64NuYk72KEi2JJ1MojOFYIcNo6vdR?=
 =?iso-8859-1?Q?2IqtoRzn3aCKpcDGbHXicGzmmZx66YjfEK6CouH7H14i4eKLnvRs/xz8uU?=
 =?iso-8859-1?Q?ohukK33OzpCyPxzEt4FTezCe+iKIkhATujT32/DKEzCrb+yKFOBnbk0veg?=
 =?iso-8859-1?Q?dLV+a1XjAyiM0rnz/6H7Dum0Iv+/mgIrjeLJuXnrspfwxnlFciQfpzJirf?=
 =?iso-8859-1?Q?JqwbUcwItwPNC5B2rVkbXVSs0rEti8sW/1ZzoStXgTnfWTM=3D?=
MIME-Version: 1.0
X-OriginatorOrg: hyperstone.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 95cc116b-e3d7-4cbf-cff4-08d941548aca
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2021 14:36:01.0106
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 86f203eb-e878-4188-b297-34c118c18b11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4fbTkQRvZixSN8p9+xfqe8AvabnFUV3pOjCvavWGJ8w9megajrMfqVF9WCZ4sGNdU8R+1FXWNdD2XP9A3kVAkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB3828
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

>>
>> Prevent race condition with ioctl commands
>>
>> To fully prevent a race condition where the next
>> issued command will be rejected as the card is no
>> longer signalling busy but not yet back in TRAN state.
>> The card may be in PROG state without signalling busy,
>> for some of the commands that are only R1, but also
>> for R1b commands, the card will signal non-busy as soon
>> as receive buffers are free again, but the card has
>> not finished handling the command and may therefore be
>> in PROG.
>
>Can you please point me to the corresponding information in the spec
>that states that the above behavior is correct?

Sure, unfortunately it is blanked in the simplified spec so I (think I) cannot simply cite it now.
If access to the full spec is a problem for many contributors of the list, I would reconsider the legal aspects.
The part I'm referring to is the last (two) sentence(s) of the section "Single Block Write" in 4.12.3 Data Write.
(Single Block Write is the correct section as all R1 (no b) commands with data behave like Single Block Write.
This info itself is scattered throughout the (simplified) spec, but for CMD42 it is:
"The card lock/unlock command has the structure and bus transaction type of a regular single block write command."
For some other commands it is in the command description column of the 4.7.4)

>
>In principle what you are saying is that busy signalling on DAT0 is
>*entirely* broken, at least for some cards and some commands.

I wouldn't say broken, it seems to do what is described.
But right now busy polling is essentially CMD13 polling, right? at least for card_busy_detect.
So it doesn't hurt polling for TRAN.

But not for all commands busy signalling <=> PROG state is true:
"The card may provide buffering for block write. This means that the next block can be sent to the card while the previous is being programmed." (4.3)
"There is no buffering option for write CSD, write protection and erase. This means that while the card is busy servicing any one of these commands, no other data transfer commands will be accepted. DAT0 line will be kept low as long as the card is busy and in the Programming State." (4.3)
Definitely leaves us with MMC_PROGRAM_CID, CMD20, CMD42, MMC_SET_TIME, MMC_GEN_CMD and both SD_WRITE_EXTR.
Furthermore I think the cleaner solution is to poll for TRAN anyway. Just in theory there does not seem to be a timing constraint for when the card starts signalling busy for R1 (non-b) commands.
Just in theory the ioctl handling could be done BEFORE the card ever moves to PROG and starts signalling busy. (Im not sure about this though)

>>
>> -static int card_busy_detect(struct mmc_card *card, unsigned int timeout_ms,
>> +static int is_prog_cmd(struct mmc_command *cmd)
>> +{
>> +       /*
>> +        * Cards will move to programming state (PROG) after these commands.
>> +        * So we must not consider the command as completed until the card
>> +        * has actually returned back to TRAN state.
>> +        */
>> +       switch (cmd->opcode) {
>> +       case MMC_STOP_TRANSMISSION:
>
>This has an R1B response, hence we already do the proper polling that is needed.
>
>In other words, we don't need to explicitly check for this command
>here, as we are already checking the response type (R1B) in
>__mmc_blk_ioctl_cmd().

Fair. I will happily remove any multi block write commands.
Just seemed like the safer way to do so, but I have not specifically checked if any cards violate this here.

>
>> +       case MMC_WRITE_DAT_UNTIL_STOP:
>
>What's this used for? It's obsolete, at least in the eMMC spec. Please drop it.

Okay.

>> +       case MMC_WRITE_BLOCK:
>> +       case MMC_WRITE_MULTIPLE_BLOCK:
>
>These are already supported via the generic block interface, please
>drop the checks.

Might make sense to let userspace issue read/write, too.
But I understand if this is not desired.

>> +       case MMC_PROGRAM_CID:
>> +       case MMC_PROGRAM_CSD:
>
>Let's discuss these, since they have R1 responses.
>
>Although, according to the eMMC spec, the card moves to rcv state, not
>the prg state as you refer to in the commit message. Normally, we
>don't need to poll for busy/tran completion of these commands.

Why not? Sure they move to rcv first, but if data stops they move to PROG.
>
>Have you observed through proper tests that this is actually needed?

No, seems unlikely to hit this, as PROG will likely be shorter than getting a second command through.
>
>> +       case MMC_SET_WRITE_PROT:
>> +       case MMC_CLR_WRITE_PROT:
>> +       case MMC_ERASE:
>
>The three above have R1B, please drop them from here as they are
>already supported correctly.
>
>> +       case MMC_LOCK_UNLOCK:
>
>Again, this has an R1 response and the card moves to rcv state.
>Normally we shouldn't need to poll, but I have to admit that the eMMC
>spec isn't really clear on what will happen when using the "forced
>erase" argument. The spec mentions a 3 minute timeout....

Again I don't know why you would not need to poll.
The force erase has a good reason to remain in PROG for long, but whatever, a card may decide to just take 5 seconds in unlock PROG. (to prevent bruteforcing passwords lets say)(Not anything I have seen or expect to see)

>
>> +       case MMC_SET_TIME: /* Also covers SD_WRITE_EXTR_SINGLE */
>> +       case MMC_GEN_CMD:
>> +       case SD_WRITE_EXTR_MULTI:
>
>Are these actually being used? If not, please drop them from being
>supported. I don't want to encourage crazy operations being issued
>from userspace.

GEN_CMD is extremly interesting for issuing vendor commands from user-space.
Not sure if anyone uses it (yet), but if so it's unlikely to be seen in the wild.
SD_WRITE_EXTR_MULTI is simply too new to really say.
MMC_SET_TIME probably not used.


>
>Overall, it looks like we need to add a check for MMC_LOCK_UNLOCK to
>poll for busy, but that's it, I think.

See above.


>>         } while (!mmc_ready_for_data(status));
>
>I don't quite understand what we accomplish with polling for TRAN
>state in one case and in the other case, both TRAN and READY_FOR_DATA.
>Why can't we always poll for TRAN and READY_FOR_DATA? It should work
>for all cases, no?
>

Well in theory you're then dropping the buffered writing feature of the SD spec if waiting for TRAN, too.
I'm fine with that, especially since it is not desired to be used through ioctl anyway?


Kind Regards,
Christian
Hyperstone GmbH | Line-Eid-Strasse 3 | 78467 Konstanz
Managing Directors: Dr. Jan Peter Berns.
Commercial register of local courts: Freiburg HRB381782

