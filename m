Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DFC5C433EF
	for <linux-mmc@archiver.kernel.org>; Thu,  4 Nov 2021 07:27:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77DAF6113B
	for <linux-mmc@archiver.kernel.org>; Thu,  4 Nov 2021 07:27:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbhKDH3v (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 4 Nov 2021 03:29:51 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:62220 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbhKDH3v (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 4 Nov 2021 03:29:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1636010834; x=1667546834;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=s3Wa4XpvIJFm0EJyXvJHVa5J0XLjlXx/kmrJ2o57SMw=;
  b=Mp4TyHeNVjB7vy/5aZVDG3UJg6f4Uv0ayWVm6FiyqCWN/mkSF1rID6q0
   OXru/yZMBLlNrMXsNCYJ5PP0LDYIegKNCzSoNxVv6Z90/nr39wUmhx99s
   11NAbNvd6xsNQmFTIqMqTKGC2ZRH13VVRYAB+KHyc+zFj0czlUawfv+aw
   tjsmvLNNygrLDGs2YYDe6rJx7DUThDwV9CjUZUSwN8APQPAjMVXUIVCg9
   PRExz8t/wxyQo02LBoskkhaZ4DPGZx6Wt9EQVc727xB6H1I1sgEIkyMq3
   dhmLe114lyXycCyuNPnQlETJhhJAXAeFWUrr5r9+u7jBNXqyl8LNLabsG
   w==;
X-IronPort-AV: E=Sophos;i="5.87,208,1631548800"; 
   d="scan'208";a="185668872"
Received: from mail-dm6nam10lp2100.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.100])
  by ob1.hgst.iphmx.com with ESMTP; 04 Nov 2021 15:27:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=abPrhWEsNTVYWO5OYfqQRWqAnjjB9CUxW4Ag4srz9tCIvJqDAW+b+YNy5Gzp9riqPcqDw0KVWJIOQYTSmfe+QGVeiQ7QXvEd2h9WXWqNvL+M61bgp8Vifys7ND45LxYPSgVbmUOpyVv880VAi4VlJRXGPl+emJZW6bbjyjMsIQHje44sikNS8CdQb1sFaeJ9HPL1n463bE2evpb/+i/TQQkCN9FU42WVyLSKSewemBSM5DMJHTBSSB/CmK4RdeBK5Syg2E+wFlMyCmxIMRiP/y8JoOPg19OCfXAgTliKt4vH6WrqZrVAVimzRKZIpNlhuTVIRsrXBGRcCR310666Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s3Wa4XpvIJFm0EJyXvJHVa5J0XLjlXx/kmrJ2o57SMw=;
 b=K2e1qNN69hJVmL3D3Xxej+00hD1Lds/tmr+FSr0CgGngb/3zGsjE5wDERAUMHrmDm2uZSpm8kbWOO2myPv62jWmw9IjVlMBZtY1y/PHdRmbw8jCJFk1F9CyclrurRWFOaXLJdvhAcWuOl1lFQW3ov8pbMqQyakQ6i+lrP9WskocbiYaSx+8CJU/NJQyLLgupx+x21drwYjXZhUdlwuMGDCK8So4olHyre7faHpuRUHdCX0Fol4A0Bjlr0Fg2bIzBRK3yBYm4TP1xmRMZ7LaviN5RhcbvFcfoDYRc1a3jzK0/da5UsXk7Lb3rVtQuw+7ksYBZRPM2RdsT8xkksWIgmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s3Wa4XpvIJFm0EJyXvJHVa5J0XLjlXx/kmrJ2o57SMw=;
 b=fg/Kn8FMUzZP7QFKeylVhBYZo/HMmLNu5SDmj4zQSh/mgamz18PYi3urPs9+rdl0HwXYSIreDSvrO1yz1YqaR+YzLNK4W3cxlY8a+JpJt1ijtjXZToBFEzsA3HnUmYZHv8kTmDIdNZRxDkbTZemv+l5oLlRXAP54Y9OFcE82Dn4=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 DM6PR04MB4169.namprd04.prod.outlook.com (2603:10b6:5:9e::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4649.18; Thu, 4 Nov 2021 07:27:11 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::edbe:4c5:6ee8:fc59]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::edbe:4c5:6ee8:fc59%3]) with mapi id 15.20.4669.011; Thu, 4 Nov 2021
 07:27:11 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Huijin Park <huijin.park@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Huijin Park <bbanghj.park@gmail.com>
Subject: RE: [PATCH v2 2/2] mmc: core: adjust polling interval for CMD1
Thread-Topic: [PATCH v2 2/2] mmc: core: adjust polling interval for CMD1
Thread-Index: AQHX0UXXkUPjyjTLAk2vNoCrnxqMKKvy966A
Date:   Thu, 4 Nov 2021 07:27:11 +0000
Message-ID: <DM6PR04MB657559D2E25D4FF21689116CFC8D9@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20211104063231.2115-1-huijin.park@samsung.com>
        <CGME20211104063250epcas1p36056caad956e599300146bae77f799d6@epcas1p3.samsung.com>
 <20211104063231.2115-3-huijin.park@samsung.com>
In-Reply-To: <20211104063231.2115-3-huijin.park@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: samsung.com; dkim=none (message not signed)
 header.d=none;samsung.com; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a92414d3-a542-476b-cc4a-08d99f64845d
x-ms-traffictypediagnostic: DM6PR04MB4169:
x-microsoft-antispam-prvs: <DM6PR04MB4169591A2BAC0DEDF9B3C902FC8D9@DM6PR04MB4169.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YPykpGui3XuougvFQb5aVi4r1ix6NNgUfoZzCotdID8TlnQmd3tImtkD0nMtaAvMBItDMGnAkw8RNLv4aut4GrFpKC6bkZlty3w3mNJ2FWuzUb6B2AzcdeIfpb5P/oQFy34p8qzdfuR19RUsKS7iexwdjY5HeXsCsd0tUx6guLHB/X6pKPPVFZTbh7xEc49H2OccFkxKvbL1NtOkraR5+bSK7lX52qNNBGF5GXR8MUjxwSn6ByvZ6HFuJ4wNzo+S4Dm30srEMmwIIpouawsCEIRSKwgKy6RTDD2b14zuZHkTruwV6wVQwo2qVDucAts1bMJaeAwiMDsQN7k0OIW1VoK3NBOu5/Qk89MNExmCu9f76cP/w9oS35VysejK55epFpeQMoEaz513kO4OgX2foNfLCC8VlMI4WbIU4vMIQx5Spbw4eOhtga7CmB3Ww7TvIgjzjSf8/WskFIB1Etf3WcyHbVLeqLaFUr+bNUt5n0P0Nss6YOEgVmIfwmRilp+aZ5NyxmQmoaWkRZqcJD38MQxYp1Ly0mqYYrc6jA8jR6NYBy6+YTybzrxS1FWkO5mG03EE4x5BiDW2G7bjbyTH7lLegr30RoMwSjyxsWN8jx8yJ4ZhWWSyNUIPy4ZU0sroD1BLv+v/bJuiqy09669p63aWDUvFBW+syu1END7kMJMPmjf1NvU0EQmdTdd57XZ0eibRTeJ+DkxI+/BNixDNgw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(7696005)(71200400001)(52536014)(54906003)(76116006)(66446008)(86362001)(66476007)(64756008)(110136005)(66556008)(316002)(4326008)(66946007)(508600001)(8676002)(9686003)(8936002)(55016002)(33656002)(4744005)(186003)(2906002)(26005)(82960400001)(6506007)(38070700005)(122000001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R3krc1RrclR6WkZ6c1dPMWh0dC9pVy9HaUxqOTMvUHZIVXM1VkRLdkl5YUZI?=
 =?utf-8?B?Mnpnc3dzTkpmR0g5OVgvWnVpMHZMd1p3Nm54RWY3NDJBeUp4SkZFQklKY25Y?=
 =?utf-8?B?WDljb09HOFUwUjd2N0RqbnMrcVFRd3BncExpeWZuSUl6RHUyaXNrY2lKTXlm?=
 =?utf-8?B?WnF1WGx6U0tHSnphbFFPb3hJQWlLb1Z0aitYeVJ6SnBTQlhQYkY2TFVudmxn?=
 =?utf-8?B?Q0pGWHN2dUxMYXdpdnRTc2JRNUJQREpTMzlrMnNleHV2UTc0eThBaWdnTmhS?=
 =?utf-8?B?VnZsUFhacVYycmhEbHJUemEwN3hHRTE0U3lLYmZqNHhuamdiZjIzcjYvQWtq?=
 =?utf-8?B?QmR1N2ttR2Flcnk2QlFNajg2bC90RGxnUDEzM3lqVFFuengzdnhoRk4zVkZU?=
 =?utf-8?B?d2J4SkFZcWIrNDhJdENWZmdpWkhYdzBSWGE5WU1vUEI5a1dSWUhMYzlXR1Fk?=
 =?utf-8?B?SVRUb01tTlQ2R3VRd1B5WTRmU0kyVVlQZkc4NkRERFl4SGlvYWM5WmE4RVZK?=
 =?utf-8?B?S3FmZUV1cGhyT0hFYnN4RjJDTUpleHg0aFpKclB3aWJwV3I3YjFqa2I0SUoy?=
 =?utf-8?B?ZXlTODNVdzJCemtFQnNBNXlRVlk3c09ZN1lWb01Md2xFYkFOYlFnMjFlNzNp?=
 =?utf-8?B?Qk56OFhwTWxzNXpoRHArN3Q0NnVrN1BKbk9zWGV1ZXRBdUcySEU4OGhsRVl5?=
 =?utf-8?B?U0hVazNjYmFHK3F5bjlpbTZCSHBkRTJmTE1BN2VlQWlnVHJtZVlybVVsbGxV?=
 =?utf-8?B?bThmLzAzZ3VZVVNFQ1RiS1diSU1rK2RwS0pJL2hsUHByWlZLNjh0elVSOFhu?=
 =?utf-8?B?b0tsNEcwajRPYW5sOUpLZVRhMm5KMFNBQkFJVStEWEdWTzNIa1FHMmREUVZI?=
 =?utf-8?B?RDdCWkQ5aUVIL2UzRUdHeEtUeFRrTVBVc1VKdlNQMjZISTZiV3kwbGVuY1dD?=
 =?utf-8?B?dkpydSt2VzlDbFdzaFAvZlpibE9mV2ttNVN5RGg4aXJTQjZwdUh6eWFmbi9t?=
 =?utf-8?B?Qnp0S1hMVHVJYzdQQnZjSVFPM0Z1M1ZPbmkrQnpnMVhwM0tpeWR1TlQ2ak53?=
 =?utf-8?B?RTRYdnoxaTBINm9QTnI4STdDUjM5Qi9HMWNmaUo4ak5MOTNEbzArN2lGczh5?=
 =?utf-8?B?ZzFsSjJJby9DRlJwNnlqRkVPcyt3RFFHRmY4QXpOTXZ3OGtqbThPaWp1ODd3?=
 =?utf-8?B?S2I2MHpnaWpKNlJFcE5ibWh1TjVBVmlVbHhLbDZkeDlRZEROb2JpUEpXdm1v?=
 =?utf-8?B?QWx3Y0E4ck5GamtpY0JFNzF0L0xoOWx6RzQ0bmZabW5aRWNBbm1aaWFPNGY0?=
 =?utf-8?B?RVpkc3lNZFpONS9tZnFrd0lINlBzOHRFd2pzV043eXJONEFyYVZwbEJRalFQ?=
 =?utf-8?B?eGR2YndCeitudlhoMm8xSWs2bnBqdUgvZFoxNkZxZUFISHFVTDBRNU9kbkI0?=
 =?utf-8?B?NytTbVp6NVBpdUVnMGcwanhkNG14WndZVEFsQ2RqWDBoV0JxMGdIcXZxM0pr?=
 =?utf-8?B?TWR2UTltOHE3T0lkbnl3dHpZVVlUYVdYRHdTaXVoVWpsZWhDUHVjSkluY0Zu?=
 =?utf-8?B?a2Mxam5mSmh6Q3dBejErRGR6TUNQclBUNWpZbGszZXB5enRkaFU5ZStrcURs?=
 =?utf-8?B?MXBrbnZneHFOQjhoTDJWcnovb25xbnpmUzJ1Z3o1NVZ1U2ZicGZNN0xiTUdD?=
 =?utf-8?B?MXBjQkkyZ094WDAyejJBRTczOGkxZnRWTy80b2pRUkYxSC82TThaaDRTd1hm?=
 =?utf-8?B?bmZsZmduQkl3R0xZTEw0UXRqVmlYY1ZPSXJ0SjhJZXhoRWM2WjB3VVdFQ0tm?=
 =?utf-8?B?RlJyS0VlU1c2M3RMaVNiNnBhcCtKOGhmNVdxYnhTZzR3ZzBLN3BZVjg4QlNE?=
 =?utf-8?B?a2hvOVJJd21QdkJuVXZiMmN1RVhBTitWOVkyYzRkeFFMa1p1MEdxc0pTdkVN?=
 =?utf-8?B?aW9reVMwRWI4SHRmM0FBUUVQWkRwWkRDYnkvdDJvWFhXa2NRcjV2eXU3anRw?=
 =?utf-8?B?YUlnNFZHa0NJY2NUbTlLYTJ3TXp3WXJCT3RSOWpHVm14UEVrL0c3cXlXdVhL?=
 =?utf-8?B?aUwzTzREVEZIZi9xcFRTWXVSM0ZhU3d3M0JHRVRmMHcySCthMlNmNWp4UnZB?=
 =?utf-8?B?QlBDNEl1VkFvaHgzdzJlYWhpVTRCS01obEhyQnMxSW85dE9WVHFwS2tOMzlK?=
 =?utf-8?B?SFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a92414d3-a542-476b-cc4a-08d99f64845d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2021 07:27:11.4099
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mpgt3K5D6zxC62zYDsbgrsxozCqcqdJBjXn0FWAmviERFir/5/FeOtsc1Dk0pSj1ALkoByXE+m0GRH+HPcocZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4169
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

IA0KPiBJbiBtbWNfc2VuZF9vcF9jb25kKCksIGxvb3BzIGFyZSBjb250aW51b3VzbHkgcGVyZm9y
bWVkIGF0IHRoZSBzYW1lDQo+IGludGVydmFsIG9mIDEwIG1zLiAgSG93ZXZlciB0aGUgYmVoYXZp
b3VyIGlzIG5vdCBnb29kIGZvciBzb21lIGVNTUMgd2hpY2gNCj4gY2FuIGJlIG91dCBmcm9tIGEg
YnVzeSBzdGF0ZSBlYXJsaWVyIHRoYW4gMTAgbXMgaWYgbm9ybWFsLg0KPiANCj4gUmF0aGVyIHRo
YW4gZml4aW5nIGFib3V0IHRoZSBpbnRlcnZhbCB0aW1lIGluIG1tY19zZW5kX29wX2NvbmQoKSwg
bGV0J3MNCj4gaW5zdGVhZCBjb252ZXJ0IGludG8gdXNpbmcgdGhlIGNvbW1vbiBfX21tY19wb2xs
X2Zvcl9idXN5KCkuDQo+IA0KPiBUaGUgcmVhc29uIGZvciBhZGp1c3RpbmcgdGhlIGludGVydmFs
IHRpbWUgaXMgdGhhdCBpdCBpcyBpbXBvcnRhbnQgdG8gcmVkdWNlIHRoZQ0KPiBlTU1DIGluaXRp
YWxpemF0aW9uIHRpbWUsIGVzcGVjaWFsbHkgaW4gZGV2aWNlcyB0aGF0IHVzZSBlTU1DIGFzIHJv
b3Rmcy4NClRoYXQncyBhbiBpbXByZXNzaXZlIGltcHJvdmVtZW50Lg0KQ2FuIHlvdSBzaGFyZSBz
b21lIG9mIHRoZSB1c2UtY2FzZXMgaW4gd2hpY2ggMTBtcyByZWR1Y3Rpb24gaW4gYm9vdCB0aW1l
IGlzIHJlcXVpcmVkPw0KDQpUaGFua3MsDQpBdnJpDQo=
