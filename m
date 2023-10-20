Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 668FFCDB47E
	for <linux-mmc@archiver.kernel.org>; Fri, 20 Oct 2023 11:14:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377030AbjJTLOs (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 20 Oct 2023 07:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377056AbjJTLOp (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 20 Oct 2023 07:14:45 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C211F18F
        for <linux-mmc@vger.kernel.org>; Fri, 20 Oct 2023 04:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1697800483; x=1729336483;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GnpPSYyACmw5QQ791HSEAZ4hCahQD21heiB5rwpvXP8=;
  b=LEtYteoWYTxgc6N3F0GVJyQFclaCpuV4uxNJju3wQh9U0K8LeKFi0kPH
   3qNwP0VPdIuDOkGjKJs8vs2GHWFjQuNLGNEdimthe0PcYBLqsRByGjGws
   9bAUa04RNzEr4J48ZtqqQ6VQ0owHWzO12p4Y9CjuKpfAqtRojd1PZBGxg
   BFjcACDGTcKtM6XIKmMWuZ2fuCYfOqGF/e+WGjk/FEEeavp7uuaqFUHXJ
   hdRYV0QVaqm+UQsmDJkyDvrn8tn0vo5/kmAw1Z35fSowt8MIldYT5E6AN
   NjBKcSyH48FO3m80+wtIFHHmNAUMt4cJ0fuOxrcuTFJiOm3p5tABZ51r/
   A==;
X-CSE-ConnectionGUID: S4xx3kGjTuKhwpvZawN3zA==
X-CSE-MsgGUID: xmqFawcPQbex4H8Iti0tFQ==
X-IronPort-AV: E=Sophos;i="6.03,238,1694707200"; 
   d="scan'208";a="227623"
Received: from mail-dm6nam10lp2100.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.100])
  by ob1.hgst.iphmx.com with ESMTP; 20 Oct 2023 19:14:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BkNxe9ZJKHKN6oTjmCGTRwCiXK0dB3EsP+8b5/Wkbf1eOEJhX8vlWKI1aYbbbrCcaYivE0KNyjZCrdUaLU751LcTlBEuJeFN71EcDxTNkOMW0XGeYpc4ACF0cVuesg2Zay7pVoAfRKLw6XZ2vB0BteqjmfVLWi+9hk5vo4OMbddx45oJb1yxyOFTKWQV7vHBWBsQX+8OzSASwHe9G8pqHcA9eb50gdA5YCZpkzqYTEGgZkfcnwqtXvNj1/o9QlLA8dvJFn1tUkds9vVXIQBT4Ik+IzfP2wJRhTWo+9ncHmMWwJI+BHgDp3LwDIFnwibLrMX6f8uXxabr4KXymK0PEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GnpPSYyACmw5QQ791HSEAZ4hCahQD21heiB5rwpvXP8=;
 b=kA4FL565lDbLnYopCnSJi9HP3wS8wu7TC1L/q78/gTsweglg1+dUtO32xH8dhbXI5bmHB/2Wshb6RriRTmVv+KqVleXA+vEtnkYW3nXGwMP07ZdBXjlri5+h844nA1W5ZeDoRbsCeTlbbwWz+meHcd319jpAfOy14NmzeM2XCuZmFckkuISobjRVyrHZB2d0KmPzGYnaUFoU7DpB9qWLoV1mvOINRJQ3KWJucBDQ536HqkRrc17YWMf7a5A3mQarEP8cRo7p1BaQ6wpA3wNkICChyQZsS405qemK+HTr0TaDNRTFeSLlQfdWgFARaNgeqD1JOBb2VM7N9O6THFHpHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GnpPSYyACmw5QQ791HSEAZ4hCahQD21heiB5rwpvXP8=;
 b=gN/lHkoMA+0HlM666Q67tHL+LsOq+OhlvXRJVgx9ka5kTfzm6QNhb4QSmZIs67YDPHTdm0Sm+Gx5VvluHJ7+iYjGCkKnfu/zwgtEqTM7vH5jlkHiatr4mI+k3S8w50lNSng6UgYzpC7CWaMqvlMtMW2KXlsF/DgJg7W6ySEhsCo=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 CO6PR04MB7762.namprd04.prod.outlook.com (2603:10b6:5:355::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.26; Fri, 20 Oct 2023 11:14:40 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::83bc:d5e1:c29:88dd]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::83bc:d5e1:c29:88dd%4]) with mapi id 15.20.6907.025; Fri, 20 Oct 2023
 11:14:40 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
CC:     Daniil Lunev <dlunev@google.com>,
        Asutosh Das <quic_asutoshd@quicinc.com>
Subject: RE: [PATCH 1/3] mmc: host: Quirk - Disable auto-cmd12 during ffu
Thread-Topic: [PATCH 1/3] mmc: host: Quirk - Disable auto-cmd12 during ffu
Thread-Index: AQHZ/Tvc2k9IHhTVgkeUp0Ox7tQQDbBSNEIAgABeQZA=
Date:   Fri, 20 Oct 2023 11:14:40 +0000
Message-ID: <DM6PR04MB65752E4056BD7C3AC5BC466DFCDBA@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20231012184041.1837455-1-avri.altman@wdc.com>
 <20231012184041.1837455-2-avri.altman@wdc.com>
 <cee3c9ac-4beb-4d78-87fc-fe1dab418cc2@intel.com>
In-Reply-To: <cee3c9ac-4beb-4d78-87fc-fe1dab418cc2@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|CO6PR04MB7762:EE_
x-ms-office365-filtering-correlation-id: cfae77cb-b349-4e36-26d7-08dbd15dc124
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9wuUlVbr2mtkqSR26YbakbecoRZe62bf4eaVQ09I9RI0DXDlWAJ9I6P+ta+PT600/Z3ryndw8AqdN9fut6L/X8JMPGQu1Ebooen6dHtGvTcMPyXpXFpARdqBuJdE1hhCOTHWdmrrdqEaHf2KWVZ5esqsp0MU6ctOc0bX60Oq43O2kKfIB7ivryc4x/rVkzevGk6lc0Ji1NXFj9AVP7xjWJA/VjYTfuenHy8CXRRNYYWBNWm54TkDqjMq/SZ4z+TTr01jRh18K1tITzagqkqZ1RPceAQ/Yf9eDgpfI3m9MQBl7cMFOscq/+1ufJGFTFvIcnj651/zMTsh7alIJQUM8V3ViGVRicaYQIY7vH/m4ctqJovFA4oW/5pGit0hjkcP33mIYOskUOOeaBWcusqwg1p0otDfPD7dpIsnHgqF2b6w6UgLiUobM1JguednbwlUdLwivNFn7uOSAriCW8AwY51EC+msCXjLiOEXJagOjHeqPNl/gjFgAkNjosVnD0PsYrJVJ0far9omtBekWApdV6rlllH3QrJAJHmr5b0rnmDEyIaqdNoys9mUusgQYTeOnXKfpEuTKRWNR+3jzQ+kaSEa9VvNr5AQyC3R4rv/InypuCTA6Xsksk9OvnM9JRj2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(136003)(366004)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(55016003)(110136005)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(54906003)(122000001)(316002)(478600001)(82960400001)(86362001)(33656002)(5660300002)(52536014)(8676002)(8936002)(4744005)(4326008)(41300700001)(83380400001)(71200400001)(53546011)(38100700002)(6506007)(7696005)(9686003)(2906002)(26005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WkFjamJaUnJqcU1TejZWOUNXL3J3em11SUk4ZkhYTVZKMXVISkJiMWdYdWdp?=
 =?utf-8?B?L3lNVlZQTytRL3RxQ01lZ29LTXBUbllpSkZGZ29DUG4zYUwwZk9aWEhHZm9t?=
 =?utf-8?B?TWVMa3JwcGV2RmgrRDRpNzN5dGpBQ2t1amVYTkhYaHhrc3MxZ1R1QTZ6L3Np?=
 =?utf-8?B?bXE3SEZ6ZG56bzRmV28zUkRDd3dxZ1pvVEozS2diK2JnZlYzbUx0NEc4QVVv?=
 =?utf-8?B?Zjc3d3NEU2xwNVJZbDd5bzJxaVBKbnMvV3R1MGtHYURHeWNrUmVlcXViM2xV?=
 =?utf-8?B?QW9FLzB5N2RFSlJLemtxcGVYZE0yaTR3cDZnb2JEblhqRkxpNktvM2M5QVM0?=
 =?utf-8?B?NkQ3d1hWR1dCaDdIZ1J2NUt0b1J5SmE0Z0VTVFhqbVh3UDlxb1BkWUVmVUxl?=
 =?utf-8?B?bzVCNFc4aW5uRndNSVRSU25EcXdGTHd0QnRETFl2Q3F1aHVZREVjZGovTWZB?=
 =?utf-8?B?dDB5R0NBZitKaW9NN21BMVllSzdMbk8wRkp1clRnNE1XSC9sUU9ITGptVDh2?=
 =?utf-8?B?UG4yRjJnWlJwMlpReWZoS0JIdHY5QkxSdW5Cb3ZINk1yTUNzVEtDOXVydjZk?=
 =?utf-8?B?T2EwMkhES0VvUFl6WnZyMjZkZmN2T3FNQzdqTTNLeWJPOTZMcXpRWUlSbnBk?=
 =?utf-8?B?cy9SN2s4RUpJRThETVhqUGNGZzFLMzhqTFVpQXZSK2NJbFFDY1R4NzF2MWlQ?=
 =?utf-8?B?RmlycGhJenNDS2drOUswMFJITmZ1VVdnRkowZW0xQWZDNzd3MlhVTFpCQS9y?=
 =?utf-8?B?L3NCMms3aWpxYmZMbkd6bDhwaG9Sb1IyS2lveEZZdDdJclZMaHhJaE9kaDJX?=
 =?utf-8?B?SDlxUzFxdU5YMEczMXhxc0xYZjhuTFYydFgvWmE0Z2o3QmNpeVE4MFBNU3Rt?=
 =?utf-8?B?QmROOGQ1WDJCNG9UWkRFQXlPOXhiaDNZRk54V2Z4dEhRanpEUksxdHh1Y3I5?=
 =?utf-8?B?ZUpqbWt5d3VqaTdQYm9KNHp1UEx2WmFHWlgvMHRpVm41eXZBMmlLVEs4Rkoz?=
 =?utf-8?B?ZEdLeGUzQktSS0Uwbk9oajRDSmk5SmFMM3F6blVGTVBNaFY0c2V5RXdZMVhu?=
 =?utf-8?B?Z2thVkJ5eUk0USsyTVowVDB4OExaZnl0d0JRQ2loa3pLRzFKa3dvUVI1WUIz?=
 =?utf-8?B?VEtIUjgxVVcyb05iTTZuR1I3dTJEd3JTYngzKzdzamlrK3lPM28vMjE5OUlU?=
 =?utf-8?B?d3loY0NIdElBenNXdWZQcnJhblcyaDhJYWUxdklLUHY3OGRGa0hUVjNjMXZJ?=
 =?utf-8?B?T3JSdUR5TGt6aFRRTGgzS1o0aVZuay9xVzNGdnF3ZStDeDBsUG12bEl5MHQw?=
 =?utf-8?B?bTZ0cVhaR3FhUmhDTmN6b09JU3JHYnNpQ3A1em5OSXhuL3ZIMFpUK3FITUw0?=
 =?utf-8?B?VEEzNWEzWTdKSWx0UlRwSGE4bXZReDdzQ1U0THIzaWRLTTdmbEJIajRhaWxI?=
 =?utf-8?B?K2JUMnBiMlgzYlM0RmU4OGo1RGlYSjdBVlFkblV1aGNaMlpyYlF0VENMN3VM?=
 =?utf-8?B?aERRQU85NmN6dGV4bzBjbEtFZkNnQmUxR3JvY05sV3dpNkpSdytzNldLUlZN?=
 =?utf-8?B?L1NaRmg1eVppWGNlUWw4TnNHeGdFQWVBWENRSFUzcU9iRlcvY3AyUnpKOWZi?=
 =?utf-8?B?aDlIL3QvRkMzNUY4aXZ1ZGdCWWpvaDdFWkgzZm9MTkFUdmhaSEh2ekRUdWV6?=
 =?utf-8?B?ZVR1UXFRQ2dLOVJtUDFnSU55d3hUYmNVWnBFalgvbGJ5ZzJQUU15bTVyMW1W?=
 =?utf-8?B?S1N2T1Jwd1RONTRMaisraTAybGJjQ3lJOTgvcklTVkhvTExNbmxFU3Ixd255?=
 =?utf-8?B?cnBSTDVWLzdONUlYTHZtSENpd2NjUlo3T2F3SW8xbWErQmtkWGdmaGNBckFi?=
 =?utf-8?B?U2lKUTJoK041Yzd1TXNQUFFFVTBsdEl3VURiSmYrV2trMTU2R0tlYWFTREtL?=
 =?utf-8?B?cURFWUJiRjhYNFVRM3VubkJndEE3Q1BWeFFVeGRNelorZEFsV0Z4bUtrMk5i?=
 =?utf-8?B?N1pUMUVuM3pOMzRyNDlDUGk4blc1Z0MyYjFCQnhTanlTU3JaZDNrWHJaUG9q?=
 =?utf-8?B?UlFoZGR0amRUZ2lLRTI0MnNVQi9KME5jSTJ6Qy9KelRzcWVzdzl2ZjJuUjlR?=
 =?utf-8?Q?KCzTR7RuekLSF1Zc+TePhwOrM?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: WI7awv66pQrMNbBHhFOnJtS+y0bY0XjOSOF5A0AxVyaHUgMasCr8b5L97ndWBApAFMbf8A7qX55pXluB2yx4aayGpsyY9zH+o5ureU5Nq5EngS4CU0ZVjGMs+5MHNSICCV4WLWAV2JS2MBRnNB2J5KpIJVi4K3YjPINzXNz0p23b+743/fcCSWs13AlzjkeBdGzPfl6LfKxfXZQw7Mi9vcbJNN9uAyv9imk94WXLaP3gp7oOyYeH6YmbfpOR98AB8s/inq8RfJ5+UVL/QPRFQ79g4o+QMn+MfKPeczzuSiOEqDy5XhNwkNN18esgWl0F2TZ34/Z8ijSNZEsXLfthyESSM36UMWdag4lvQNWkMKF3P/U1Ea+foD44zDEKQ3XOmxVwGcbJp189XLGjecoSUSzM6sXhQNpFea0TubJsUQi8VpJLG9olMuJMk0rYqDN/xTMH9ZLd6l8Zrwf4VcY+V7g5RK6rniSpJTKqLqugLewGmUdOwr5JrdD4LW+wxG+tPOd5bMNG0q7GTsfcUxE2/v5wN4E6CDkQ6sPwXpokmOK1bM6wH0MKjH+vT7+KOUTc5xURYc/jEp+LLoAB1GJLQLDqYkVGSRnIOE8fS47tqOJ4OW8mI5w1Wo0fdYr0t0B8aDupL4UiSVXXsP8A5WqaMKMUIPDyso1jqE7EGCI28nhgliAJBdM6Sel9OvMMM7SJ27E7iLQP3kPbhxRa9iZU9wonyVnNJWcTHJMlvUcrJhSGtB077a9E37EUM8V2zo+qhlwMkegI2VYm3zh+VquWfhy4sYL8G2cMmv+N4HugTJZybFYzpuwLgkr28EZ23CqTFZarb263Zma5mEaAgYiMFEvYVgwsCWFvnNWoei+MuQaH+MVbDyfREkG0w4fvHxLtU6Txt69+5KJDPCmMhrDYGA==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfae77cb-b349-4e36-26d7-08dbd15dc124
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2023 11:14:40.5364
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lpKxeJ5aeiiuWy9yMIYzyzQuu6PVvP2lqkNc9IbavekjXE83YBtqMAP/W52fohWU0DWxg0kitNSBAzsa9DrfVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7762
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

PiANCj4gT24gMTIvMTAvMjMgMjE6NDAsIEF2cmkgQWx0bWFuIHdyb3RlOg0KPiA+IEZpZWxkIEZp
cm13YXJlIFVwZGF0ZSAoZmZ1KSBtYXkgdXNlIGNsb3NlLWVuZGVkIG9yIG9wZW4gZW5kZWQgc2Vx
dWVuY2UuDQo+ID4gRWFjaCBzdWNoIHNlcXVlbmNlIGlzIGNvbXByaXNlZCBvZiBhIHdyaXRlIGNv
bW1hbmRzIGVuY2xvc2VkIGJldHdlZW4gMg0KPiA+IHN3aXRjaCBjb21tYW5kcyAtIHRvIGFuZCBm
cm9tIGZmdSBtb2RlLg0KPiA+DQo+ID4gU29tZSBwbGF0Zm9ybXMgZ2VuZXJhdGUgYXV0byBjb21t
YW5kIGVycm9yIGludGVycnVwdCB3aGVuIGl0DQo+ID4gc2hvdWxkbid0LCBlLmcuIGF1dG8tY21k
MTIgd2hpbGUgaW4gY2xvc2UtZW5kZWQgZmZ1IHNlcXVlbmNlLg0KPiA+DQo+ID4gVGhlcmVmb3Jl
LCBhZGQgYSBxdWlyayB0aGF0IGRpc2FibGUgYXV0by1jbWQxMiB3aGlsZSBjbG9zZS1lbmRlZCBm
ZnUNCj4gPiBpcyBpbiBwcm9ncmVzcy4NCj4gDQo+IElmIHlvdSBob29rIHRoZSByZXF1ZXN0IGZ1
bmN0aW9uLCBtYXliZSB0aGUgZXhpc3RpbmcgU0RIQ0lfQVVUT19DTUQxMg0KPiBmbGFnIGNvdWxk
IGJlIHVzZWQgaW5zdGVhZCBvZiBpbnRyb2R1Y2luZyBhIG5ldyBxdWlyazoNCj4gDQo+IHZvaWQg
c2RoY2lfbXNtX3JlcXVlc3QoZXRjKQ0KPiB7DQo+ICAgICAgICAgaWYgZGF0YS1tcnEgYW5kIHVz
aW5nLWF1dG8tY21kLTEyDQo+ICAgICAgICAgICAgICAgICBpZiBmZnUNCj4gICAgICAgICAgICAg
ICAgICAgICAgICAgaG9zdC0+ZmxhZ3MgJj0gflNESENJX0FVVE9fQ01EMTI7DQo+ICAgICAgICAg
ICAgICAgICBlbHNlDQo+ICAgICAgICAgICAgICAgICAgICAgICAgIGhvc3QtPmZsYWdzIHw9IFNE
SENJX0FVVE9fQ01EMTI7DQo+ICAgICAgICAgc2RoY2lfcmVxdWVzdChldGMpDQo+IH0NClRoYW5r
cyAtIHdpbGwgZG8uDQoNClRoYW5rcywNCkF2cmkNCg==
