Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA36ECAAA1
	for <linux-mmc@archiver.kernel.org>; Tue,  6 Sep 2022 15:35:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233409AbiIFPfr (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 6 Sep 2022 11:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233358AbiIFPfT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 6 Sep 2022 11:35:19 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2130.outbound.protection.outlook.com [40.107.104.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F134C57542
        for <linux-mmc@vger.kernel.org>; Tue,  6 Sep 2022 07:44:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L9lGfMuDRKsqBexnCvt6fx+SyZYuOg6Ps6NfENUOjL3wiqkd2gZOxD4ZYFRa5N21ZThWcGkR9f7enk9MIRAF8Gwqzw8sOYiqLzHNcf4FFHaE5QpsVEaQH7lmXg8vB6akewR4UbA1sBMnyNYfN+cIoZfTMoK1C2+PXcVohVL9plWBoAXChp/AP23bJRanw81W6xUc4/OJQ+z04SxIVDeNvn7ZFD9S8b8F9sHoAGBS+u8zmPW1Q/ELtu3do1Tvd3IlP58+Ls1SeXdADwAT7UenotBuTQpp9UdW928L1Rybi5vyAi79FXaPK2s+nd0+46RUKZgp52XM5S39VNdAPk4brw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bulUNP8FIw7UsI2haholsUFBxaxPudPeB8PnYzpRv/U=;
 b=nazAov8/RHwuwxDAOIsf8qx9K71ytSJLN6jU9+KbHN+qHGH9V0wzgOT1ndDG7kk08pY9hPGtfEy+B7AvqX3GKgvbdc9IDEfFtn2KryLbl1QXYmDC0nrCPTpkAM1zY7ELRJZnM04cLBGCEV4XrGN5iWj0jGaBQ5njc9J1hAP3wUWZAvX0odWA85nDufT6Hb+Fdhjw997SzX/PbBgrqBwOeT71DztlFkAzYO5KyO4ScooStAxfgk6GI4HRaHWUCtAAjjnrKaznhg1oymHfCacjEOzg0Af93DqS92apQXqcC9YNJbBOtCKedWPzBJTH6GlRdib6kTjKTx+CmiJa3QDrXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bulUNP8FIw7UsI2haholsUFBxaxPudPeB8PnYzpRv/U=;
 b=s+p1lAbzWE08a8AFMkRdqE/d2sD5qQJD3Hm1jKod73GvabPonROCmsxMoXMzFH0krhByuFgrqIDWBHs8pM6PNN6yXD/rRHker6FUyFki+UetYUCKjnXPSl3fash+rZjPiz/EnWUCvYUDPBUKI3B1KRYGbzOTH2RxZSWHu8OjJWQ=
Received: from AM5PR0701MB2964.eurprd07.prod.outlook.com
 (2603:10a6:203:4e::11) by AM6PR07MB6181.eurprd07.prod.outlook.com
 (2603:10a6:20b:3f::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.11; Tue, 6 Sep
 2022 14:44:33 +0000
Received: from AM5PR0701MB2964.eurprd07.prod.outlook.com
 ([fe80::542a:5d98:f0f4:3640]) by AM5PR0701MB2964.eurprd07.prod.outlook.com
 ([fe80::542a:5d98:f0f4:3640%7]) with mapi id 15.20.5612.012; Tue, 6 Sep 2022
 14:44:32 +0000
From:   "Matic, Bruno (Nokia - DE/Ulm)" <bruno.matic@nokia.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Avri Altman <Avri.Altman@wdc.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        =?utf-8?B?Q2hyaXN0aWFuIEzDtmhsZQ==?= <CLoehle@hyperstone.com>,
        "Rossler, Jakob (Nokia - DE/Ulm)" <jakob.rossler@nokia.com>,
        "Heinonen, Aarne (Nokia - FI/Espoo)" <aarne.heinonen@nokia.com>
Subject: RE: [PATCH v2] mmc-utils: correct and clean up the file handling
Thread-Topic: [PATCH v2] mmc-utils: correct and clean up the file handling
Thread-Index: AdjB2XU9gUyV8Jz7S6KzzdFddt0bHgAGX7qAAALp12A=
Date:   Tue, 6 Sep 2022 14:44:32 +0000
Message-ID: <AM5PR0701MB296449F4FDC9D463A416D63FEF7E9@AM5PR0701MB2964.eurprd07.prod.outlook.com>
References: <AM5PR0701MB29649D655F1BB8F2156300E2EF7E9@AM5PR0701MB2964.eurprd07.prod.outlook.com>
 <CAPDyKFrZWi31sKVmeUs_xkyM1ZCo=suo-61Y_ccBvMb1hL3h2g@mail.gmail.com>
In-Reply-To: <CAPDyKFrZWi31sKVmeUs_xkyM1ZCo=suo-61Y_ccBvMb1hL3h2g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM5PR0701MB2964:EE_|AM6PR07MB6181:EE_
x-ms-office365-filtering-correlation-id: acf0277e-522d-4f7d-a671-08da90164fc4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DP97MJAaBfzqcEmU8q1LXRwlo54xapBS+0kZgxcKUbRe+3SCUj2xxiB6lBiBKSltPNI953lAHytWYQ27UDVa6y4PG8ScoftTyXutl8XWjB9fhZsAvH92QyVDUuln8qy2hkz59KuBnLsMtp7ziaP0grIoR3Rtwc+kLNMtOwxFJwzoV4uJnxbCme/sFOLMOn7MfJ9v91+eGY31wi9nlN8X1BHilYown6KPNxbmTLq1OgrDYPgotCdH+urFDYnEmJIjdaT03mIfXN75ptuL6i8Qikt2ZXxpuQBxRFNBeI8X28tHz3YXe6lJGKvDyjpAq06izRfdepikYX9GaM8Rr/dZ2URNq4Ml28uTeUb7M6Pz7hOHlHH3l1U4PQd4oOsSdpI9Y2dh8VJO2j6OaPbvjL2+WgzWp6lCBov5J48w2/KWgrILsog/TXiqDiO33pFObVO9WoNrMkRBLVkjeaARTGB9IJ+Y/bMKKLHjPVLy+0HPbi9pLjPjPelTlAnpt43KA8mQRHP0LWDqLl3amHx5oauO2amw43ydazewyFv3dgyd9in4qgubMIDNX2EZ32yCuQRstyQT1+0S3YkUMISeoGqJHSqYZUSmUuqjVCygKRkbnu5Y75ed0eDSpgGbKNK/aYbdrVxvO+nktcpwS6fxFLfiAY1mPT3U/4bDxDb/aTkoCIP0NQAkSV8zePDbOQU//9Wbd4e11PnpUGSVIUMyol2ocorw++bvgJC2wgga1nnir4g2DXZPB/+DwqhMyMdboPPbll3eGiNVvDb5FQX6FMaCxQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR0701MB2964.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(376002)(366004)(346002)(39860400002)(5660300002)(33656002)(316002)(83380400001)(4326008)(66556008)(66946007)(8676002)(76116006)(66476007)(52536014)(6916009)(54906003)(2906002)(64756008)(8936002)(66446008)(41300700001)(71200400001)(55016003)(478600001)(26005)(9686003)(86362001)(107886003)(186003)(7696005)(6506007)(82960400001)(38070700005)(122000001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aUIxRmhjTEs5dlJFZ3lUQnlaWDlqUjdsdHBKckRYU0prSXRrbHE5QkZJNnhT?=
 =?utf-8?B?MDlsSTNhVWJ0RkRsZnYxQTArTHRSbU96VTUrTHlxN01mcjkyNG1PbkFlUUho?=
 =?utf-8?B?OWNMazk1My9NZ1M0em9JaGJoL2t2RENpcmszeHBmVjRNWDBPMFp3blJ4MXBP?=
 =?utf-8?B?RmhUOFZkMHJ6ejZ4NWw3anpuQWFXblhOK09lV2pRaGZQY3hjdU9oUzFLRHcw?=
 =?utf-8?B?eFBqSVpLbzJLMVVaaThpdHAydUZ3K1Z4L0NVK0xIa2lBa3g1RlN3SFJEVTA2?=
 =?utf-8?B?eXF0TmNwNFRxQmNMQTVndFNJQ3Q1SHBjd1B2eVpBZ3V2WGlxR2NqT3VPZjhu?=
 =?utf-8?B?Ym01aG15RnB2UU1iZlVYc0dUY1NsR3llU0l0MjNFTlpBc0JSZmIyU0ZVckZX?=
 =?utf-8?B?SVpwUEQ5eFRtNFpvOHlRbHFpNUM4K0l4STNnTVh6cUdYR3dXTGQ4VnhnTll0?=
 =?utf-8?B?WExsNzRpMjh1VElhRkthTGxoZ0ttdGRBLytTeDVEZHNIY3BScm53cDI3dlR1?=
 =?utf-8?B?MnBPOSs3aWI2UE4rWGFrQjhNb0tOSjA1ODAzbGR2cWM2TFBoa0RrcmtDb2xM?=
 =?utf-8?B?Y0xFdi9uRTE2VUpRa3dxeHczNmZCeFNZM1J4THNwc3lSdWFES3oyWUZFMWFh?=
 =?utf-8?B?YTlSVXpvMVZXeW5MOVlaWU5IeTVyMGtJeFQyV242Z21GNStKdVdOVVBUSDJo?=
 =?utf-8?B?Yyt6dWVoelo4ZXRGL0lCak9FSHkwSDVNWG5QM096SjgwNWFQWEJKb3FNMjhT?=
 =?utf-8?B?ZzVIYlVHK3dUNFQyYURrdnVzVlBNcjNJZktmZ3RlcU5xK2FWd01hcytXbU14?=
 =?utf-8?B?S2hsRW0waTZEUm9ZSXd6cjc0ZUpwVStCSkFuWFZXdGpVZjNOWFpzeVI3UTRT?=
 =?utf-8?B?Wm9Ccm5hOEZlb1h3V3ZHdFlUSXFLZUgwbHoxMkNtdVJrZEloSy9VblZqdjBM?=
 =?utf-8?B?L1FZQVMwRGJEbUVUd0xaNDlVdWNxVThyQlM3Z09iRkxOZmYyU2RLckxIYktj?=
 =?utf-8?B?WUl6VGl1eUg3OGtwU21wcnpoeFR5Z09naTI2NjNhZWxlN1FIdUp3SjlMV0lT?=
 =?utf-8?B?em1FVFAyb0paQ3FsMnpsM3UzM0ovbXlrNUNBbExtNjRNV051cFZ3QUtmSHl5?=
 =?utf-8?B?UjRIeFlSVytuWWlFaVdTUk8yTmtoaXJTNTJ2QkIwRWdQekdhbWdVd1JUQ0NK?=
 =?utf-8?B?RXZBa3VKUngwK2VWQ3MvVG9MZXEzVkx4LzI0Ny9kcXF3MzFIQjl0TFNIWlZ0?=
 =?utf-8?B?TlFFSjF3eE9jbWdxT1BKbWx2OGFpNUxmWUYrOWNmWUpZS2JUQWFwOUVnMktv?=
 =?utf-8?B?cG9oUmQvZ2I5UUdzS1VrUjFWRFhHaUlabSswNVZpb1R6dzV4UGUrNXNuS2p6?=
 =?utf-8?B?UkFYVG1rRm1ubDgzOUhFOEY0M1RkdmhrOE8yb05LOXRTanZ3MWtzdDEyeE5h?=
 =?utf-8?B?Vk5aYzZBUGxDamdDa1FpN2JTdHdmS3BxdzM4YkJkVEJmSkxBK2N3Y3VwZVFy?=
 =?utf-8?B?Wlo3MGMyblpSdmlwbzRERzlZMGx2ZkMxTS96NGtDN096NEt6a0RoUWRsUExO?=
 =?utf-8?B?aW9PK3QrVHpaeGE1ak1BMW5BTjlER3pwY0M0RmVQVUVRT1pTa3phMFY1eWM1?=
 =?utf-8?B?dE1XdTcyMzBOZUkxVWU3dVpzZDc2WisxQ3d1aXA5M2hYU2hZUjlBL1FQaWZ1?=
 =?utf-8?B?NFJqTktaL1M1SHFKQVVSdzNQQk1sZ2lsWHJkQit4cnpSbFRWWVd5U2lqRXNR?=
 =?utf-8?B?cnM2bndYWnEvY0llVXVhd3VzMTY2M0llODFscEpka3hjT3I1NTdUWVl2UGJs?=
 =?utf-8?B?NUZwUm5xQjNnYkJhdXp1L3dDODEzWmNDSlBjZUNJQnVibVFQMjZGanhRS2tG?=
 =?utf-8?B?R0twcFRPblFnbkczYThtK2p3cWJvS05BU2lleHROOTEvU2RVZVdJenU5VVJB?=
 =?utf-8?B?Z0JVQ3VpZ2dOVU5oT0tQM09kbVZiZnA3U05iZkhack9RTVNiN3RyOWNSaGZR?=
 =?utf-8?B?b1IxQWZueDIycFZoYmlxTE1sODNTTmJra2kydDl0U0F1cndZLytObm9XYXVn?=
 =?utf-8?B?amdmeHg5SDR3aElMZTJkbDZFc0g0WmlHV3NPTExpeUpQQk5SellWbTZUbndZ?=
 =?utf-8?Q?9SU+1CLeDe2qUdorSEeXu4ff6?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR07MB6181
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

QWRkIHRoZSBjaGVjayBpZiB0aGUgd2hvbGUgZmlybXdhcmUgd2FzIGxvYWRlZC4NCkNsZWFuZWQg
dXAgdGhlIGxlZnRvdmVycyBvZiBoYW5kbGluZyB0aGUgZmlsZSBpbiBjaHVua3MuDQoNClNpZ25l
ZC1vZmYtYnk6IEJydW5vIE1hdGljIDxicnVuby5tYXRpY0Bub2tpYS5jb20+DQotLS0NCkNoYW5n
ZXMgaW4gdjI6DQogIC0gdXNlIHBlcnJvciB0byBwcm9wYWdhdGUgdGhlIGVycm9yIG9uIGZpbGUg
cmVhZA0KDQogbW1jX2NtZHMuYyB8IDY2ICsrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCAzMiBpbnNlcnRpb25zKCsp
LCAzNCBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL21tY19jbWRzLmMgYi9tbWNfY21kcy5j
DQppbmRleCAxMmI3ODAyLi5lZjFkOGM2IDEwMDY0NA0KLS0tIGEvbW1jX2NtZHMuYw0KKysrIGIv
bW1jX2NtZHMuYw0KQEAgLTI3NjUsNyArMjc2NSw2IEBAIGludCBkb19mZnUoaW50IG5hcmdzLCBj
aGFyICoqYXJndikNCiAJX191OCAqYnVmID0gTlVMTDsNCiAJX191MzIgYXJnOw0KIAlvZmZfdCBm
d19zaXplOw0KLQlzc2l6ZV90IGNodW5rX3NpemU7DQogCWNoYXIgKmRldmljZTsNCiAJc3RydWN0
IG1tY19pb2NfbXVsdGlfY21kICptdWx0aV9jbWQgPSBOVUxMOw0KIA0KQEAgLTI4NzksNDUgKzI4
NzgsNDQgQEAgaW50IGRvX2ZmdShpbnQgbmFyZ3MsIGNoYXIgKiphcmd2KQ0KIAltdWx0aV9jbWQt
PmNtZHNbM10uZmxhZ3MgPSBNTUNfUlNQX1NQSV9SMUIgfCBNTUNfUlNQX1IxQiB8IE1NQ19DTURf
QUM7DQogCW11bHRpX2NtZC0+Y21kc1szXS53cml0ZV9mbGFnID0gMTsNCiANCi1kb19yZXRyeToN
Ci0JLyogcmVhZCBmaXJtd2FyZSBjaHVuayAqLw0KKwkvKiByZWFkIGZpcm13YXJlICovDQogCWxz
ZWVrKGltZ19mZCwgMCwgU0VFS19TRVQpOw0KLQljaHVua19zaXplID0gcmVhZChpbWdfZmQsIGJ1
ZiwgZndfc2l6ZSk7DQorCWlmIChyZWFkKGltZ19mZCwgYnVmLCBmd19zaXplKSAhPSBmd19zaXpl
KSB7DQorCQlwZXJyb3IoIkNvdWxkIG5vdCByZWFkIHRoZSBmaXJtd2FyZSBmaWxlOiAiKTsNCisJ
CXJldCA9IC1FTk9TUEM7DQorCQlnb3RvIG91dDsNCisJfQ0KIA0KLQlpZiAoY2h1bmtfc2l6ZSA+
IDApIHsNCi0JCS8qIHNlbmQgaW9jdGwgd2l0aCBtdWx0aS1jbWQgKi8NCi0JCXJldCA9IGlvY3Rs
KGRldl9mZCwgTU1DX0lPQ19NVUxUSV9DTUQsIG11bHRpX2NtZCk7DQorZG9fcmV0cnk6DQorCS8q
IHNlbmQgaW9jdGwgd2l0aCBtdWx0aS1jbWQgKi8NCisJcmV0ID0gaW9jdGwoZGV2X2ZkLCBNTUNf
SU9DX01VTFRJX0NNRCwgbXVsdGlfY21kKTsNCiANCi0JCWlmIChyZXQpIHsNCi0JCQlwZXJyb3Io
Ik11bHRpLWNtZCBpb2N0bCIpOw0KLQkJCS8qIEluIGNhc2UgbXVsdGktY21kIGlvY3RsIGZhaWxl
ZCBiZWZvcmUgZXhpdGluZyBmcm9tIGZmdSBtb2RlICovDQotCQkJaW9jdGwoZGV2X2ZkLCBNTUNf
SU9DX0NNRCwgJm11bHRpX2NtZC0+Y21kc1szXSk7DQotCQkJZ290byBvdXQ7DQotCQl9DQorCWlm
IChyZXQpIHsNCisJCXBlcnJvcigiTXVsdGktY21kIGlvY3RsIik7DQorCQkvKiBJbiBjYXNlIG11
bHRpLWNtZCBpb2N0bCBmYWlsZWQgYmVmb3JlIGV4aXRpbmcgZnJvbSBmZnUgbW9kZSAqLw0KKwkJ
aW9jdGwoZGV2X2ZkLCBNTUNfSU9DX0NNRCwgJm11bHRpX2NtZC0+Y21kc1szXSk7DQorCQlnb3Rv
IG91dDsNCisJfQ0KIA0KLQkJcmV0ID0gcmVhZF9leHRjc2QoZGV2X2ZkLCBleHRfY3NkKTsNCi0J
CWlmIChyZXQpIHsNCi0JCQlmcHJpbnRmKHN0ZGVyciwgIkNvdWxkIG5vdCByZWFkIEVYVF9DU0Qg
ZnJvbSAlc1xuIiwgZGV2aWNlKTsNCi0JCQlnb3RvIG91dDsNCi0JCX0NCisJcmV0ID0gcmVhZF9l
eHRjc2QoZGV2X2ZkLCBleHRfY3NkKTsNCisJaWYgKHJldCkgew0KKwkJZnByaW50ZihzdGRlcnIs
ICJDb3VsZCBub3QgcmVhZCBFWFRfQ1NEIGZyb20gJXNcbiIsIGRldmljZSk7DQorCQlnb3RvIG91
dDsNCisJfQ0KIA0KLQkJLyogVGVzdCBpZiB3ZSBuZWVkIHRvIHJlc3RhcnQgdGhlIGRvd25sb2Fk
ICovDQotCQlzZWN0X2RvbmUgPSBleHRfY3NkW0VYVF9DU0RfTlVNX09GX0ZXX1NFQ19QUk9HXzBd
IHwNCi0JCQkJZXh0X2NzZFtFWFRfQ1NEX05VTV9PRl9GV19TRUNfUFJPR18xXSA8PCA4IHwNCi0J
CQkJZXh0X2NzZFtFWFRfQ1NEX05VTV9PRl9GV19TRUNfUFJPR18yXSA8PCAxNiB8DQotCQkJCWV4
dF9jc2RbRVhUX0NTRF9OVU1fT0ZfRldfU0VDX1BST0dfM10gPDwgMjQ7DQotCQkvKiBCeSBzcGVj
LCBob3N0IHNob3VsZCByZS1zdGFydCBkb3dubG9hZCBmcm9tIHRoZSBmaXJzdCBzZWN0b3IgaWYg
c2VjdF9kb25lIGlzIDAgKi8NCi0JCWlmIChzZWN0X2RvbmUgPT0gMCkgew0KLQkJCWlmIChyZXRy
eSA+IDApIHsNCi0JCQkJcmV0cnktLTsNCi0JCQkJZnByaW50ZihzdGRlcnIsICJQcm9ncmFtbWlu
ZyBmYWlsZWQuIFJldHJ5aW5nLi4uICglZClcbiIsIHJldHJ5KTsNCi0JCQkJZ290byBkb19yZXRy
eTsNCi0JCQl9DQotCQkJZnByaW50ZihzdGRlcnIsICJQcm9ncmFtbWluZyBmYWlsZWQhIEFib3J0
aW5nLi4uXG4iKTsNCi0JCQlnb3RvIG91dDsNCi0JCX0gZWxzZSB7DQotCQkJZnByaW50ZihzdGRl
cnIsICJQcm9ncmFtbWVkICVkLyVqZCBieXRlc1xyIiwgc2VjdF9kb25lICogc2VjdF9zaXplLCAo
aW50bWF4X3QpZndfc2l6ZSk7DQorCS8qIFRlc3QgaWYgd2UgbmVlZCB0byByZXN0YXJ0IHRoZSBk
b3dubG9hZCAqLw0KKwlzZWN0X2RvbmUgPSBleHRfY3NkW0VYVF9DU0RfTlVNX09GX0ZXX1NFQ19Q
Uk9HXzBdIHwNCisJCQlleHRfY3NkW0VYVF9DU0RfTlVNX09GX0ZXX1NFQ19QUk9HXzFdIDw8IDgg
fA0KKwkJCWV4dF9jc2RbRVhUX0NTRF9OVU1fT0ZfRldfU0VDX1BST0dfMl0gPDwgMTYgfA0KKwkJ
CWV4dF9jc2RbRVhUX0NTRF9OVU1fT0ZfRldfU0VDX1BST0dfM10gPDwgMjQ7DQorCS8qIEJ5IHNw
ZWMsIGhvc3Qgc2hvdWxkIHJlLXN0YXJ0IGRvd25sb2FkIGZyb20gdGhlIGZpcnN0IHNlY3RvciBp
ZiBzZWN0X2RvbmUgaXMgMCAqLw0KKwlpZiAoc2VjdF9kb25lID09IDApIHsNCisJCWlmIChyZXRy
eS0tKSB7DQorCQkJZnByaW50ZihzdGRlcnIsICJQcm9ncmFtbWluZyBmYWlsZWQuIFJldHJ5aW5n
Li4uICglZClcbiIsIHJldHJ5KTsNCisJCQlnb3RvIGRvX3JldHJ5Ow0KIAkJfQ0KKwkJZnByaW50
ZihzdGRlcnIsICJQcm9ncmFtbWluZyBmYWlsZWQhIEFib3J0aW5nLi4uXG4iKTsNCisJCWdvdG8g
b3V0Ow0KIAl9DQogDQogCWlmICgoc2VjdF9kb25lICogc2VjdF9zaXplKSA9PSBmd19zaXplKSB7
DQotLSANCjIuMjkuMA0KDQo=
