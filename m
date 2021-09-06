Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13BF7C433FE
	for <linux-mmc@archiver.kernel.org>; Mon,  6 Sep 2021 08:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEAD061004
	for <linux-mmc@archiver.kernel.org>; Mon,  6 Sep 2021 08:38:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240795AbhIFIjU (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 6 Sep 2021 04:39:20 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:4691 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240556AbhIFIjS (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Sep 2021 04:39:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1630917496; x=1662453496;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=nx/y2/4mahXB2Uh6z93ePgFAm7jJVguOjln0OI0Fq4k=;
  b=OaRt467C3i4jWHF/s9ol87gDAlUdfmsJXa9izO8OkgXTKEjFNw3t0ggi
   4wPcyqaU8qXNrS4ZpnOhNGNnk1mK0uT7IHk9YVzA9rOEAtGQxpN4hdGq2
   NORXIJnnTOyKldJ2J1e+3SgEpBaHbhO6S8sh6YLJC3amNMHAHpDsHPC7P
   sKeoPE+zVW+7z7bXYBMP1Ji/q1kcZc7Tnxnp/N5CvQbAhCOZ9XdHMSQ21
   qEfaQtrVCImqyQbNYnf2abzo24a+8km/Fz+zgofWk657u/ov44Fy2O2vz
   EcOMqp/mUn9znQnL555WrlnOJFD6y7gDrGjk5pTFO1Zr4hjhp0UOT7gtU
   g==;
IronPort-SDR: AKyIDXwS66Rp3si7J6srTEjtDjwu9VapCji95inPpS8Fwpt1zQsvIKGRg+WRDLfmhZDfG3jBRP
 feivhgp13FOp0nINWHa9WY3Eu9A30vAZL+37cc2HCmPuoFULTqW/F604AbNsaMv8T58T2aUeYu
 ZbpasILk6CVeyGBDKvDAll9Lmh05vpjnSS6t/F9nYKYm+gY5TvNRV7usy0iYyR83zBp/r8YcDl
 bje1sl3IRTwWEVALekSlDqx+accbuhSza4EYU4++DksQGws0JtMT15Z925smV8bKfQhMHmANBs
 oUTKeAkEte1vwir81KKItEMd
X-IronPort-AV: E=Sophos;i="5.85,271,1624345200"; 
   d="scan'208";a="134960350"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Sep 2021 01:38:14 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 6 Sep 2021 01:38:12 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14 via Frontend
 Transport; Mon, 6 Sep 2021 01:38:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i54FOCZmLq/7fyEf76y/goV4fdn9hoNIbixHVAo2Zf7wFEX78c++P53bmdMOU5wLlSUidO78FxyXR4Emd8Y0/ScKqNrutx2iIQVKdRvyqD5SuFLSwYcXDGf5iGLhRzk5NZ6qC0Gk+2g8c5nJhFzEL5El2GtQvFL1Sx0lpNTjHrn2b0x7yNeX24lemcddVZj+flDw2s5pH9BfRAeW95VuW0AbkIeoGIC2sXxCo2emdgUrSo57IAMLQGW7ogw4WyOuzRefoMKw7v2FkH6CkgxPwQdWDI4z8Q+veEBBq6GKkLNbAh+pvVAO7etsDM8q0n37Kg7D3HOdJMkzaUwgY6qclA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=nx/y2/4mahXB2Uh6z93ePgFAm7jJVguOjln0OI0Fq4k=;
 b=P2nAzKV/oIxqQ4N3zegnxIVFTPeDpaB/8wBnNl7yLyDY5mFCrhvbIxnWW9xVXbOeIKbsav8LfQqZ1GIYgeRQW5doEWyop2SXcu8gJo+fWW6A6jvmrhQIkZ2l3jA6aHfSqpaQP/34dnz2obhr6RJ4mL/f31I/D1eF/LJImkwaNb8OgvZasC/gGv+cweusz+3WLy6gDdzEgzHeay/DLkm6GcqdycixnDYLFORHv4jsmeM3ps0OnFf+cfUzXF3+LM1j/yIk1/QBVz+3B3Y4FS808b67l315VbARm0eAiA9xvJ9O2xDZiys1N3IUSf4JkS53SzCf3l+u5eR1rVUQkNTHig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nx/y2/4mahXB2Uh6z93ePgFAm7jJVguOjln0OI0Fq4k=;
 b=qs8m4g5KQUXeCWm4mAd9P5bvl7jWnrKjDaKPiXwKMFiko7ZQ89WZiR6U9KMeRaQyEYTaen+XNFN4RB+1565dR+EyCq41GHsZvN0G4LHfHycNvG3g/Y4J5laGObPq4cH9IVd3efo2JQoz4CSFlv5FLTTWv/iFxJ0Jnc6+XNI6nHQ=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:95::7)
 by MWHPR11MB1709.namprd11.prod.outlook.com (2603:10b6:300:25::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.20; Mon, 6 Sep
 2021 08:38:11 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::d96a:4568:b553:97a4]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::d96a:4568:b553:97a4%8]) with mapi id 15.20.4478.025; Mon, 6 Sep 2021
 08:38:11 +0000
From:   <Conor.Dooley@microchip.com>
To:     <robh@kernel.org>, <krzysztof.kozlowski@canonical.com>
CC:     <atish.patra@wdc.com>, <ulf.hansson@linaro.org>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <geert+renesas@glider.be>,
        <yash.shah@sifive.com>, <yamada.masahiro@socionext.com>,
        <piotrs@cadence.com>, <linux-mmc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH 2/6] dt-bindings: mmc: cdns: match MPFS MMC/SDHCI
 controller
Thread-Topic: [PATCH 2/6] dt-bindings: mmc: cdns: match MPFS MMC/SDHCI
 controller
Thread-Index: AQHXlRFN69/REKfa4kixjgWeXAi1C6uCv/iAgABLIACACSzUgIAKkv6A
Date:   Mon, 6 Sep 2021 08:38:11 +0000
Message-ID: <b607f187-5eee-6afa-f50a-c6532acf19e5@microchip.com>
References: <20210819154436.117798-1-krzysztof.kozlowski@canonical.com>
 <20210819154436.117798-2-krzysztof.kozlowski@canonical.com>
 <YSUDTSuNlsOmu/G+@robh.at.kernel.org>
 <9423ddab-4635-ea15-7a9d-dbcf1bc215dc@canonical.com>
 <CAL_JsqKU4opYerjxXTnAuouLc5-GQQKnPX+qZEMBuzYV-inmJw@mail.gmail.com>
In-Reply-To: <CAL_JsqKU4opYerjxXTnAuouLc5-GQQKnPX+qZEMBuzYV-inmJw@mail.gmail.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5a53f2f8-3f3c-4211-121a-08d97111a910
x-ms-traffictypediagnostic: MWHPR11MB1709:
x-microsoft-antispam-prvs: <MWHPR11MB1709B33CD325A81D30E887AC98D29@MWHPR11MB1709.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lJvnAJIi4mv3vC+e8BNjMxeY0O49T2SzpueHOv4UCP6XJfAPkq3T0YaurhDKo9nbphsNnWUqb46RXzpx6IXtBsS35LITxk5Ut91u3Uz+VerGm1/pT+zvGbvrE1eBawFxVpozUtt85ka0EDp3WhzFiwD/Ot/qkhl5IQWlkiiGJYjWhLvA3nbMuhErWvebw7SgDEMVftjvCtLB+FozULZ3xgY8IOuX/nrXVbwUa0aOdkTykKDA5HaHqMJEiZNYl8Vt4Yc0iM3J3qsZ3ZIeEoxyQ4ja+A0CUP9gfUFpUdB1hW8Sq6IvG+KOuV9wKiGbsBOtaOJniV1dJA4KtxCiGhW0LB66HJXGVuE97t8PsPTi1xqvkIFt+uQyiw8Bt2t5rD6oY0WZKSc1myIY1QVHcyGdA3W5TWNQG7KhWQr++iRCdVcMmmzEes4/dqSHH2Kjkt0ADyn3lWyqJBoBW2fYYGyO14E6+lfZwDSWm/0dQWDHOb/+NQPlAKmHjYE8drsJ+SF4t/MwnxcVxvN2jxB8GwRGRISK77UZ8df5N4LlXpysrUEad6dESQZy/Fw96Vcj9VD+UjmSk+c7qLsV4n56oNXR8IDOf89Svf3CFeQpaYPHzb/5VUqj0BvhYwWzoKL5TkRqpvMj1hwQs8A9T87cSqMii9KwTgSwo8rbA1h5XvoGycTuo06B4sEJ7JKsQDvY4cuNO/5v69aSy8A+vE9kAlOja/tIJTMJ1BoU9NjkmzesfSEs/yJe2NScUADE/aJG7GU5fQrkvdFAfwHumEPEnqqifjxPFEnu9FiNNkbZ6W3bouMiLY0lUosJhrmE2BoKjbS4tN778TA8khkqIQwMikhbG/MU9yx04XVVLmVsN1NMOCU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(376002)(366004)(346002)(396003)(316002)(66946007)(110136005)(91956017)(66476007)(54906003)(71200400001)(7416002)(186003)(6512007)(86362001)(53546011)(66446008)(38100700002)(2616005)(6486002)(478600001)(26005)(6506007)(966005)(38070700005)(31696002)(76116006)(66556008)(122000001)(4326008)(2906002)(36756003)(83380400001)(5660300002)(31686004)(8936002)(8676002)(64756008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d1BrbGYrQVNvTjFjejhWOE1LdS8yeGE2TXlMNnNoR3VYV0FNQ3UzUzE0VmRJ?=
 =?utf-8?B?MzdtTzBFemxGQldUcHFENnNBWHlrcjBPSjV4WUFpeFZhTWpoYUlVL0gycWRz?=
 =?utf-8?B?aGNkNllXc0RlQWRpeXhOMm1PMFF3NC9UQXQ2M01sekdCNnNQVDRQWVdaSVpI?=
 =?utf-8?B?V0QyK2o5ek50L005dlllT2h4UmYrZWFnRm9FTDZycllHL2oxSmZhUTdxRXFl?=
 =?utf-8?B?RjJPQlVhNm1lbWxzRGMwL3dObytZYm9POUhTWDlTWXhsRjZ2bjhhZkRGWjg5?=
 =?utf-8?B?TDhLN0dOYkhSWHE0SUdPUkVPKzIzdTltQ25BTXhBU3Z0a0IxNlZvaCtmNlR6?=
 =?utf-8?B?aTRmQmhXL1l5N1c2TTZrTkh1a2szSVBmdFdaMEFIUCtDQzMvamtJSy9Tbklx?=
 =?utf-8?B?d0FTUXR4RTA1TVhKUy9SSDRpUmVxcmNwcVNES3VudlQ2Rm5FV0lMMVVZaUZR?=
 =?utf-8?B?ZnZ6NWwxbnJnMjIvZk5QK2VLOHhWR3lxUzZ0Y0ZDL29EVDE4K3BZclpuS2Ur?=
 =?utf-8?B?Z0liMnNEU3VWZWcxaEd1N1RBNlBLNlkvMTQrd0RvOXdyQUs4Ry8yZnp6T2Rh?=
 =?utf-8?B?TVF4QVkrbVljOXlUb2VqdDVHYWYzVE1kdEpZYS9PRnNmemtuU1VTWFdtQ1p2?=
 =?utf-8?B?aTVzMVY3Z0FScmtmY3RjSWhvcTg3UVhHRXhFWEVaY2JNWXNYOFNCbXNYV0lX?=
 =?utf-8?B?dis2ZGNaZkVhOGNBTG1xblpNbFc4MkZxcHBTNkhYZEhyQmdpTGlqYlYvR20r?=
 =?utf-8?B?RU0vZ3BneGxveWxZa0tMblc4THVycCtNMTRZQVBadEVRMGlKTUwxWEorSHJ3?=
 =?utf-8?B?anQxRU96Q3FYMlhpa2tTaWFidzJyQ1hxMjV3WmNNMzhXOGI0dHlRRzlZR0Ft?=
 =?utf-8?B?dEZkVFltVDJnNksvUXQva0NrVFRBQVNaR2hJaXllTGFjVXlGUHBzVmNveGV1?=
 =?utf-8?B?QVNSS2RMMEU1VmpEdzNTeXg3Mm9KdFVhTFUvcHBIZVVmeXgydWFJamZlT1dU?=
 =?utf-8?B?N1NsaU1BMHRQZnN2QU5BcHBHUm9wQ0VTSzBZTjFoWVFNTnVvZ2dueG1vLzdS?=
 =?utf-8?B?eWcyc3NaVnZVSFVsVnpsVEJJZWc1UXE1d05pSVhqVFVYMEVlT2l3Mk5sQk5S?=
 =?utf-8?B?M0d1ZnJyQlBpc0p3UnlOcUw2Q3pIZmprQTU1WFMwQWZtUEt1NkIzd01LbklT?=
 =?utf-8?B?MGFCVW9LcGdMQ05JbVZCVStMSEZ1eldrdUpjZTdSSGtMODk2MTdxbWRZMENz?=
 =?utf-8?B?N1BBZ0JoODlsZnUyaUs4V0xEbFFnMFBlTVhKb0RINVd1SjVCN2JNeUgvZE5B?=
 =?utf-8?B?bTJ0am9jTU9Xa0JneGl6YlVyc3UwVWEzSHBadjJPeENYV1JJYmUzTmpYc2N6?=
 =?utf-8?B?THFJdjdsNDgxaGp4NEZKMEdrMUxPOThYUlMyeis4UEhoOTF4QmdERDV5ZHJt?=
 =?utf-8?B?WDRCNFc4VE81cStXYkRCOTRWMGtZT0FPdU0xNklDWGJmc212NEdqSVhtOTZw?=
 =?utf-8?B?bHM1cUthdkNaTURicFJDMS9MQnQ4QSt3S2RSdWF1djRzcnZNRys3bHUzK1Z4?=
 =?utf-8?B?Y0I4OHZrd0Q3eFV5bVdvSTZ3T01lREhTYytYclMwK2NNZFAvUUFia01HUXk2?=
 =?utf-8?B?QzZsTnlFOVBNN0JKNDJkWWVnSHRkbDVHRVhYQnd2UUNiWGZleGZIZitzU1RU?=
 =?utf-8?B?NjF4UDlaS1duczFXVFBoTUhaRUF0T3ZvZkptbXBQa29xQlRQUFlpT0plUHFF?=
 =?utf-8?Q?o0GS18WzMrW+w2HkHA8C+VvOl7zJ3rW/b/ZTyO9?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <83F72399C8F5444AA9C1EA776B86CA82@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a53f2f8-3f3c-4211-121a-08d97111a910
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2021 08:38:11.3365
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fncN3n5JaCBRAzeqs2y770LvEt/LWan92QiI26eyiGvHm1j14lUxSkvMyQX52+fh4tgThfpq8nCTBpy0DKByffjDXa/0y6s6BQkPpEsXKSo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1709
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

T24gMzAvMDgvMjAyMSAxNjowOSwgUm9iIEhlcnJpbmcgd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlM
OiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cg
dGhlIGNvbnRlbnQgaXMgc2FmZQ0KPg0KPiBPbiBUdWUsIEF1ZyAyNCwgMjAyMSBhdCAyOjAyIFBN
IEtyenlzenRvZiBLb3psb3dza2kNCj4gPGtyenlzenRvZi5rb3psb3dza2lAY2Fub25pY2FsLmNv
bT4gd3JvdGU6DQo+PiBPbiAyNC8wOC8yMDIxIDE2OjMzLCBSb2IgSGVycmluZyB3cm90ZToNCj4+
PiBPbiBUaHUsIEF1ZyAxOSwgMjAyMSBhdCAwNTo0NDozMlBNICswMjAwLCBLcnp5c3p0b2YgS296
bG93c2tpIHdyb3RlOg0KPj4+PiBUaGUgTWljcm9jaGlwIE1QRlMgSWNpY2xlIEtpdCB1c2VzIENh
ZGVuY2UgU0QvU0RJTy9lTU1DIEhvc3QgQ29udHJvbGxlcg0KPj4+PiB3aXRob3V0IGFueSBhZGRp
dGlvbmFsIHZlbmRvciBjb21wYXRpYmxlOg0KPj4+IEkgdGhpbmsgdGhlIGxhY2sgb2YgdmVuZG9y
IGNvbXBhdGlibGUgaXMgdGhlIGVycm9yIGhlcmUuIEV4cGVyaWVuY2UgaGFzDQo+Pj4gc2hvd24g
dGhhdCB2ZW5kb3Igc3BlY2lmaWMgY29tcGF0aWJsZXMgYXJlIG5lZWRlZCBmb3IgbGljZW5zZWQg
SVAuDQo+Pj4NCj4+IEluIHN1Y2ggY2FzZSB0aGlzIGNvdWxkIGJlOg0KPj4gMS4gYSBzcGVjaWZp
YyAibWljcm9jaGlwLG1wZnMyNTB0LXNkNGhjIiwgd2hpY2gNCj4+IHNlZW1zIHRvIGJlIG9uIE1Q
RlMgSWNpY2xlIEtpdDoNCj4+IGh0dHBzOi8vd3d3LmRpZ2lrZXkuY28udWsvZW4vcHJvZHVjdC1o
aWdobGlnaHQvbS9taWNyb2NoaXAtdGVjaG5vbG9neS9tcGZzLWljaWNsZS1raXQtZXMtLXBvbGFy
ZmlyZS1zb2MtZnBnYS1pY2ljbGUta2l0DQo+Pg0KPj4gMi4gb3IgYSBnZW5lcmljICJtaWNyb2No
aXAsbXBmcy1zZDRoYyINCj4+DQo+PiBBbnkgaGludHMgaGVyZT8NCj4gQmVzdCBmb3IgYSBNaWNy
b2NoaXAgcGVyc29uIHRvIGFuc3dlciwgYnV0IHN1cmUgdGhlcmUncyBzb21lIGV4aXN0aW5nDQo+
IGNvbXBhdGlibGUgc3RyaW5ncyBmb3Igb3RoZXIgYmxvY2tzIG9uIHRoaXMgY2hpcCB0byBmb2xs
b3cgdGhlIHNhbWUNCj4gcGF0dGVybi4NCj4NCj4gUm9iDQoNCiMyIHdvdWxkIGJlIGlkZWFsIHNp
bmNlIHRoZSBjb250cm9sbGVyIGRvZXNuJ3QgY2hhbmdlIGFjcm9zcyB0aGUgcGFydCANCnJhbmdl
LCB0aGUgMjUwdCBiaXQgaW4gdGhlIHBhcnQgbmFtZSBqdXN0IGNvdmVycyB0aGUgc2l6ZS9jb25m
aWd1cmF0aW9uIA0Kb2YgdGhlIEZQR0EuDQoNCkNvbm9yDQoNCj4NCj4gX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj4gbGludXgtcmlzY3YgbWFpbGluZyBs
aXN0DQo+IGxpbnV4LXJpc2N2QGxpc3RzLmluZnJhZGVhZC5vcmcNCj4gaHR0cDovL2xpc3RzLmlu
ZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1yaXNjdg0KDQoNCg==
