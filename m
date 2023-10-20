Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30AF6CDB47E
	for <linux-mmc@archiver.kernel.org>; Fri, 20 Oct 2023 11:16:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376994AbjJTLQS (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 20 Oct 2023 07:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376927AbjJTLQQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 20 Oct 2023 07:16:16 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB45B126
        for <linux-mmc@vger.kernel.org>; Fri, 20 Oct 2023 04:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1697800574; x=1729336574;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8bRlIJ8xgZ/FxjrWFk7N88Nqezn8gtqtXPEa+K1qYW0=;
  b=TM6fx6WdcaNci519iohIaYJu9qY/H9B111hIo0DspIWrE/hbWbIbawif
   se14sGM3+ZOn7vwBwDgqX+mIAXolecJsr+/Gdl14pBhymQCzCPZFp3uMf
   4iEXiRLTDRvIDHeXVDnOv1CwTsqoerp8bGyVaWKnYILAM34WsZSkFkCFA
   8C2VyjmxS5LT/Dh0SJrE5eI9jUztEG3VuhI9Ccgiu9IfPkcfYoyjLv7w/
   tx3M2X3wxYscQ7+/GHTJoAJl9EUaBn/AAh9mllhyUG/gXfs6KQ8+hvmTd
   tufqCIen7EvXjnRg3Xp0wMTGLQlGbiWX+SduYLTlAWSMPTMGibSKfV0Cz
   Q==;
X-CSE-ConnectionGUID: SHl/tQLYSWaKvELV4rIJVw==
X-CSE-MsgGUID: UQ7Z9WkmQN25TlvmrG25ww==
X-IronPort-AV: E=Sophos;i="6.03,238,1694707200"; 
   d="scan'208";a="221018"
Received: from mail-dm6nam10lp2100.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.100])
  by ob1.hgst.iphmx.com with ESMTP; 20 Oct 2023 19:16:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GRHw96DHckIGu5OEIkRLa2KzaXuPQAFCDO/SQZ3NmGZZbNHxOf8DpyLCGZKpQ+qkYiWeTfwZAyV6wDUrZus7CFueqmapoaWJ93uCBl9pk/GXYQebn14stDI2+Yl4cK+vnQIhjYV580jK7sW0ceA98jtN0w6VNvcq2gDECDz4GfdlIMfDmE7BdBDPCwkUT3RXHfSBRIvxE5GGke7CWtcw3TOA6ruIoieideQosTyguJKnZ5TlRTbizET/xEImNdg88jJD/bkmci1FSxNOAqiXLe491GsaZ7cwv4YEdgCqxicDUv9uE/pzJAbHNeharz/re24brxdiGZ5GiA09yV+Uaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8bRlIJ8xgZ/FxjrWFk7N88Nqezn8gtqtXPEa+K1qYW0=;
 b=dLMGC1jeKjG5uNxuPrFhVnhQ5hcrkFZbi9/sgO1yMuWD2h0tL2nzhW77fE6VtaWwkBiZW3ZWX3Q7jlS5IW4sGnKEjjnhEJ1mJ3d5jITaEd4f9OzltMWjc7JvMPxVfLgEYP6fJqsJofnYv6itU47tIaujUkOwwjNExHEMnc+VSHazam7tKIvb+FNuMAcgnlj0341T6g2JSELLE6Z1jytkd3SBtX+mh6YoJ5pwrrNWD/W9oSPOAcHizVRSXhBP+jPz2yBy4YzYVkD0q1R5kUcX7mXo2QYytn95wGklZH37PLhCaV71T4i073Nbp+ZxpNZT8ckAM9tGmLYkVGeVu4VhZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8bRlIJ8xgZ/FxjrWFk7N88Nqezn8gtqtXPEa+K1qYW0=;
 b=XXCsnfJEgtXAwZzSjua9qzeEmI5VU2vLLeD3gqyHljb639NUtrL5gDX2LiIuYCU0ox62cfaAT2TsyS7ETAQJeIxtwFyoOIbbuZIzztuEaqHwYywNzZcgm98fzS4iycdY7Pi5caD2hEU4UX2cYlndlE/bnLQ83beT59aTS+O7v0g=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 CO6PR04MB7762.namprd04.prod.outlook.com (2603:10b6:5:355::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.26; Fri, 20 Oct 2023 11:16:11 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::83bc:d5e1:c29:88dd]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::83bc:d5e1:c29:88dd%4]) with mapi id 15.20.6907.025; Fri, 20 Oct 2023
 11:16:11 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
CC:     Daniil Lunev <dlunev@google.com>,
        Asutosh Das <quic_asutoshd@quicinc.com>
Subject: RE: [PATCH 2/3] mmc: core: Mark close-ended ffu in progress
Thread-Topic: [PATCH 2/3] mmc: core: Mark close-ended ffu in progress
Thread-Index: AQHZ/TvoIPsdlGXdqU6Y9ZmtQRv1WbBSN6gAgABbLEA=
Date:   Fri, 20 Oct 2023 11:16:11 +0000
Message-ID: <DM6PR04MB6575291FFD8C10258A30000CFCDBA@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20231012184041.1837455-1-avri.altman@wdc.com>
 <20231012184041.1837455-3-avri.altman@wdc.com>
 <d1505d2f-90f9-4fd6-a928-a590b72fce37@intel.com>
In-Reply-To: <d1505d2f-90f9-4fd6-a928-a590b72fce37@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|CO6PR04MB7762:EE_
x-ms-office365-filtering-correlation-id: c681f76c-ca10-4862-31c4-08dbd15df770
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BATWFe2qJpsnZ8RG9BZ/79DKWdB2F/0tsmDlKXb8T2HAPuQo8U5bLoyDjF1U3h2UfTOAmeRy7sK74FmS/Cm/6BIppfHAIcOu3hy2QGIz7giqFCIWt5h9tZK4R2ZCuzIXhCzxBq38fS9yxSXLJSPNZrGrIF2HdLCNHZ20J+ieH+xxzgLzx7vZSFh9WnHshj+Lk8Oi29O9F6WxQ7TLxdUcooF4CYcD918u+e+Q+iZ+3Zy9+g7StiU6+J0Zuqyog/w6AlQNuh+xh4Ms27+rOcX10qY8pAHb8eYVgqtsiENesNhMnaeHavzaxHQW3O0lxUSfGP3K+QsJXJYDNhcZujt84gx/uJ+H/9Y4G40mHhxQGEAxMYT2hcLRMraXcOewDD6rLgb96DBlM0aFtBCVZb9xl0YvdlfsahlE0dMmZJmaBYP2Xk6A8PiuNeruDeMP/R5vyCMmQk97NsOeQm8WK9tAdS+Q4J1XAmSaXRvagSzjA4lJS8ZVaDNNjo2hlwhFJqYNLTQY906AwOIq0xeZ/ewnHWYhK/UJZbxvbn1/rq5nauEtGPmF41gVVvQoPURJMWVg/SDBZI7Ki4fEI3QaLREN5iM4Nt/IAT1AN3vBdh6BF4zDgMwme295zr4cKyMxf5XF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(136003)(366004)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(55016003)(110136005)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(54906003)(122000001)(316002)(478600001)(82960400001)(86362001)(33656002)(5660300002)(52536014)(8676002)(8936002)(4744005)(4326008)(41300700001)(83380400001)(71200400001)(38100700002)(6506007)(7696005)(9686003)(2906002)(26005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N1Q0ZXV5WFpQMmRyd0VrWEtHUXZ3UzQyQ05XejJMVXBHcFFRMkxZbXFnRjgw?=
 =?utf-8?B?cXE0UTNVbUM1MWtvcm5LMDgwTnpQcjBCVXpqZmJaUFQwQ0VPY3lzdmZFNEdP?=
 =?utf-8?B?QmtFNWg2RzhhcXZ1c2kwNnhLQVg4S01FZGFJbU5mNFNKQXkxTmtmV0gzUEw3?=
 =?utf-8?B?WGwzOUdoVEY5M1VscVZ0MUgvRmhUUUF5R0c1ZVpwVmF4eldiRXRtRTREUFda?=
 =?utf-8?B?Ty9GZ2VSeHpRcGMrckZ3U1N5Z25nenJ0VWhjQ0FLN0ZPWmN0UnhOczhKVURp?=
 =?utf-8?B?K1pSNVlYYVZiZDc5aHViUERQaXQramRLMWtVeXl4Y3VjUzNyUi9qNE9Fdk44?=
 =?utf-8?B?S2JKM3pvUVVXbHZqQm5nMTcya0hvdjNGTGRQK254L0xYczNIZzVqQjVuVTVZ?=
 =?utf-8?B?UTlNUHpHN3dEbFNCYWwwTjBUQlB0MGNKRS9PWWlsUkNFaVJ1UTRuTzlIRy84?=
 =?utf-8?B?Mzlsc1VsL0I5TTB2UzJqRmdqaXI5VnN5a0wxQSthcjVKUjd4aldZNVAwZmMw?=
 =?utf-8?B?OGx5RDQzR09wZlRLalRnQ2dBWFYxbVp4TmxHQUgyemQyR2tEblUxK3MvbGhj?=
 =?utf-8?B?b3FqTCtmMXd1Z3A2WVh5MWYwNjNFMU8yQlphaTRKL2RrUUVZdnlsVEt2c3Vz?=
 =?utf-8?B?UmYzWmREV2FHR3RqV2ZuRXpRVkN3MnhzVW5nSE4vRTZwWFNBUFJUTnFsc3d4?=
 =?utf-8?B?dW8wSm5OVkQ2TmR4d082Ulp5c3ZmZjRhNE5OQUVwOHlSa2VGdjROSFR0cjFi?=
 =?utf-8?B?QVg1TXdXcjJwOGQ3MVVPY0pFZnRqb0hYZ0phbSthUnFMK3BGcnpnK3RpVys2?=
 =?utf-8?B?V3BwUHBkdGdlN2psd2QwSjJMYVN5ZWRtQkNzWDVKekx5YlkzYnc1NG9wSEx3?=
 =?utf-8?B?dDREeUJwZmwvMUJWcTFMeDFJTmM0dC9YQ0pjTkFLWVoxcWRsb3RhbFo3SDdS?=
 =?utf-8?B?Ly9wclNOcDVHRCsyK1cwWk53ekp5aFNiTVM1TFR3bDhMNVhBanNaODBFanI0?=
 =?utf-8?B?aFd3QTZPd2VYYU1uRGxLZTZqK0JjQlkvQzJLbHpwaU9UMkJyOFlKREV0K0FI?=
 =?utf-8?B?bWFsUVVqY3IyeTdXWVg2a1YxTmhOek9QVlBtdXhyRlJUMnJYMEhrR0ZtUHBE?=
 =?utf-8?B?eWZURHJBU1pFdTNXSnFVZXRrL2RCK0pMaWpwVVl4UGMzVGdWYlZ2d1ZzT2V0?=
 =?utf-8?B?MStLaXFIczgwNGlKM2EzbmNGV2dKamk2YUhZNGhNbGNrTndPaVllcWcxRXRS?=
 =?utf-8?B?Ulplb2pieG8vczkzUVBERXZGWTNHTkNTbTJZa0NCWENsZmNlb3luVVlmZGJj?=
 =?utf-8?B?eUs3WjlKbjhvNHpibEMzaFJJbGsrMFhzc1ladkR5VXJiVzhvOGtreGZ4SUls?=
 =?utf-8?B?SEpWa3pUeDlPR0R1cGNNQnVFbVB0MHU5dFFpaTNMZ3JYc0VkcWs0U0dvRm40?=
 =?utf-8?B?QytrdmRudTdXWE00Rnk0NHNCMWdhb3F2ZVZocWdiTkVVYmpVcVE5czZwME1j?=
 =?utf-8?B?VHFyMDN1bGZFTzhESW1vTXczamZYVW9SMHRJclNPSko0ZkdZN3ZJV3d1NERV?=
 =?utf-8?B?ckI5dytqMkFRcU9YNDBncENlem9OdTJ2WURPb3FuR1dRUXpQbE1UK2ZsTElF?=
 =?utf-8?B?ZmlWOXdRYWdUNXk2SFhId1JtaUpWZ0ZLL3E3Zmt2WnhWdUtDRUFmeGRMdmNS?=
 =?utf-8?B?dWpvaHhwU25qR2JOakRjN0ltY2Z4K3U2SlAvZlI4YjNjaWx0VkZ4c1JMOVFK?=
 =?utf-8?B?TnZSdE1mNkZLWkFqQlAwSnlkdDdDMDdnMUVuZFBFWEhORlpSVldXY3VEbFNl?=
 =?utf-8?B?S1JITDZwSWVWRVNxeXhKeTFUSkdFK09oTDkwM1Q4YzhaWkRsU0xSMlMxMDln?=
 =?utf-8?B?TFlzYXRaSVVZTUtjY0d0ZEZqdHRtNWJnUWQ1RHVKMkp6U2FpZEVnc2hxdVhD?=
 =?utf-8?B?NURrQ1V2cVdKMHNwQzA5NElmVk5qK0lVbWlLVmdCTFJzMnhiNENnVStJbFM5?=
 =?utf-8?B?RmZKSzlNNGppVjdxSkI5bVF5WjFNNVNFUlg3Mll0MGZRZE1NSkZBbE50clVo?=
 =?utf-8?B?eXZaUWxzdTRNUU1yeG5TSmk0TmJoSjZDN3NRVFljTXpwYlRjeitreHNzT1Vi?=
 =?utf-8?Q?/BGfTgXL4zTId1tplQk7zwARf?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 5LJ9BMJOW3kvkIJsbYTusMrIPPShfPps4gpXmgWDz2FwbuoX8joY9i8twAYBGOYdjqRCkht6iV6ZfESx0MMFn3LsvwMvz/ZUg9pQ+4EdFanl4T5wDR5m9OjqXQnPkilQ+gr0Kj4OGgKa5yK01IF/X4f8/bxAKk/UOQ4Mm1G01O1pWIdGQeFwYDelv0xcz9NsjD/ygW2Sh7aTWXB9t7v1IBEk8MuretYlK0oVh43UPxIkZ3OqjAKWlByoMwZm+a54HcEdF4QxIJ6iwPylNXKmpPmpg8S3KrUkE6e76AUSYYkTNvPjf6ghNVl0oRMPTOVnmXOgHuxGpFvstweQ0unjqWyReJuGG1/qgExYszkfOYzwD6uXk4WrT8zwewYAjwMaImcGG3HVTu6C1wSEpUZ1Oll+20rVI9xo7mhrpZQsdNwQi56RDHjYl0xM2wjICuuvvhgTtN9XI4USz/FXriUW3Ghw5i5i6qsmpRXaZdwRBCvtms7aXkp3PMj6MfiIDIyBm2wbMAyZF61IMbsj/2kprTPlFxsz2/MrcZXNaJ89BfIbciZNOaXN/wkAv8vQeP2PiaDEQRwuuMgzb2IyVnZzMfPMrLdfupkUx8ja87V4vr+pNjT3Y+wXIs7tDMy5Ru332KwHTnPh3qCFf7jujpzabyQ0kGvz23ggh0e2Ij/xnAewbsew5nRWmUZ6Zs5HyKtu5LNg930Gn0NRUAdBzj3CxMIj/zfmxch3DRt45eZeMF8uFTyHDmDOPcpt85sbRGZYxpjfMx3w0cYmIFNONAhnakSj9tklHTD11xy83ZDVkEmdkarwaVSJOE2TwWOG9/V8turHZRUuBsyNXwoXu89Pwbn4FqnHyEuF/FjmQuk4ZbhbuhMxOw7VdZdzofHWinepHStnZMcyKjwPPKVF6Zl6mg==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c681f76c-ca10-4862-31c4-08dbd15df770
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2023 11:16:11.5993
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vz0Jz5YWpjTr4l+9sYItr5+Uzs/1J+B1VyBf8OiPSyPV7d8NBw5GwOHIoN1ye4J4NwZjH5820d96kr6tt7uRJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7762
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

PiA+DQo+ID4gKyAgICAgaWYgKChNTUNfRVhUUkFDVF9JTkRFWF9GUk9NX0FSRyhjbWQuYXJnKSA9
PQ0KPiBFWFRfQ1NEX01PREVfQ09ORklHKSAmJg0KPiA+ICsgICAgICAgICAoY21kLm9wY29kZSA9
PSBNTUNfU1dJVENIKSkgew0KPiA+ICsgICAgICAgICAgICAgdTggdmFsdWUgPSBNTUNfRVhUUkFD
VF9WQUxVRV9GUk9NX0FSRyhjbWQuYXJnKTsNCj4gPiArDQo+ID4gKyAgICAgICAgICAgICBpZiAo
dmFsdWUgPT0gMSkgew0KPiA+ICsgICAgICAgICAgICAgICAgICAgICBtZC0+ZmxhZ3MgfD0gTU1D
X0JMS19GRlU7DQo+ID4gKyAgICAgICAgICAgICB9IGVsc2UgaWYgKHZhbHVlID09IDApIHsNCj4g
PiArICAgICAgICAgICAgICAgICAgICAgLyogc3dpdGNoIGJhY2sgdG8gbm9ybWFsIG1vZGUgaXMg
YWx3YXlzIGhhcHBlbmluZyAqLw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICBtZC0+ZmxhZ3Mg
Jj0gfk1NQ19CTEtfRkZVOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICBtZC0+ZmxhZ3MgJj0g
fk1NQ19CTEtfQ0U7DQo+ID4gKyAgICAgICAgICAgICB9DQo+ID4gKyAgICAgfQ0KPiA+ICsNCj4g
PiArICAgICBpZiAoKG1kLT5mbGFncyAmIE1NQ19CTEtfRkZVKSAmJiBjbWQub3Bjb2RlID09DQo+
IE1NQ19TRVRfQkxPQ0tfQ09VTlQpIHsNCj4gPiArICAgICAgICAgICAgIG1kLT5mbGFncyAmPSB+
TU1DX0JMS19GRlU7DQo+ID4gKyAgICAgICAgICAgICBtZC0+ZmxhZ3MgfD0gTU1DX0JMS19DRTsN
Cj4gPiArICAgICB9DQo+ID4gKw0KPiA+ICsgICAgIGlmICgobWQtPmZsYWdzICYgTU1DX0JMS19D
RSkgJiYgbW1jX29wX211bHRpKGNtZC5vcGNvZGUpKSB7DQo+ID4gKyAgICAgICAgICAgICBtcnEu
ZmZ1ID0gdHJ1ZTsNCj4gPiArICAgICAgICAgICAgIG1kLT5mbGFncyAmPSB+TU1DX0JMS19DRTsN
Cj4gPiArICAgICB9DQo+IA0KPiBDb3VsZCBpdCBiZSBhIHNlcGFyYXRlIGhlbHBlciBmdW5jdGlv
biBzbyBpdCBlbmRzIHVwIGxpa2UNCj4gDQo+ICAgICAgICAgbXJxLmZmdSA9IG1tY19pc19mZnVf
Y21kKCZjbWQpDQo+IA0KPiBCdXQgcGVyaGFwcyB0aGVuIG1ycS5mZnUgaXMgbm90IG5lZWRlZCBh
bmQgc2RoY2ktbXNtLmMgY291bGQgY2FsbA0KPiBtbWNfaXNfZmZ1X2NtZCgpIGRpcmVjdGx5Pw0K
WWVzLiAgV2lsbCBkby4NCg0KVGhhbmtzLA0KQXZyaQ0K
