Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06681C433B4
	for <linux-mmc@archiver.kernel.org>; Mon, 26 Apr 2021 16:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C85A61139
	for <linux-mmc@archiver.kernel.org>; Mon, 26 Apr 2021 16:12:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234113AbhDZQNJ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 26 Apr 2021 12:13:09 -0400
Received: from mail-eopbgr770071.outbound.protection.outlook.com ([40.107.77.71]:15235
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233736AbhDZQNI (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 26 Apr 2021 12:13:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UNMCVd3dgEZgb4nskGY5UctCtc6dEn8KXvlm7L5sfIvmcUGlQwLMBSIolUhfXHT7uvHAdCOG+a8ruzG90tN3UDCAPPnqon55PPx22VWKUqr6qk8xmZEI7qcIs1UpQDrpwWNLU0sHRvT7J8PfgddfVwTGMHJ6tld36/JVw/COdBglp2dSr4Nxr+81B2cM9rZoPdWpMUNtjt2B0NZI5nsiUTdtCpVXG1aBoes41N3qW7vHtRB5Z/u4Axq1NGBYV/zIcXx3hzdUd3P2KPrnygLOoTBm3x1R3K+hZH4h9KwjqINuEGLLkCpHlneYrfvJWYL9+IO3jRzo9JAOov4Cujg1ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mh2RsHOavj4dccx00iu+pKBZFRmdFh30e1Rar860qdg=;
 b=buooaoKlWMMcysUvngekPCYqYFkOFSanM80JRyb+EaUC77DkIoXJzGUr5ti2MZHs5jL2meXzrVuB67NZcoZbl/qgRWwUNFJXOmUtP+8NF5jGnMzaD/i6t5hT5TUecWCQKOwKXyH7KkSd72a3kdoJivgBLUvxi+nk+mWfIVo2Dto/MU8xdK7TsXA0UpQNZF2EYBJMFge52KfcdlN07xLQfCG5FKM0aLavyDgB4xJw2bJ47r3WnmeoP8pguFUCIyg0uhgqLd369zVMGmoRuGfTBgK08+ZXsISsTyOR4iAfh017OhB1Du0XVs0NbXyqaf6uM8L+z0GBaHabzY70Az71CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=micron.com; dmarc=pass action=none header.from=micron.com;
 dkim=pass header.d=micron.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mh2RsHOavj4dccx00iu+pKBZFRmdFh30e1Rar860qdg=;
 b=Sh0L5G9dawnQOwVIXtNb04N5l+QeMuYwvDdTyXx2BgfP34971j8bANbnFdyZq0F77/y/f5PZ96ZWzrLCNi9yeBuO2hSozqQ1CAbVuQLQiRbOW1EKuuBGZ9HHppRxTKFDkTwtkvfgUr9XNnBEK75el7Jw9o/V9eGmSsEKNiBzNqc=
Received: from BYAPR08MB5527.namprd08.prod.outlook.com (2603:10b6:a03:c4::12)
 by BYAPR08MB4231.namprd08.prod.outlook.com (2603:10b6:a02:ff::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Mon, 26 Apr
 2021 16:12:21 +0000
Received: from BYAPR08MB5527.namprd08.prod.outlook.com
 ([fe80::f5ca:a87a:9f1e:5fee]) by BYAPR08MB5527.namprd08.prod.outlook.com
 ([fe80::f5ca:a87a:9f1e:5fee%3]) with mapi id 15.20.4065.027; Mon, 26 Apr 2021
 16:12:21 +0000
From:   "Raj Kamdar (rkamdar)" <rkamdar@micron.com>
To:     Bean Huo <huobean@gmail.com>,
        "kimito.sakata@oracle.com" <kimito.sakata@oracle.com>,
        Avri Altman <Avri.Altman@wdc.com>,
        "luserhker@gmail.com" <luserhker@gmail.com>,
        "Bean Huo (beanhuo)" <beanhuo@micron.com>,
        "kenny.gibbons@oracle.com" <kenny.gibbons@oracle.com>,
        "chris@printf.net" <chris@printf.net>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
CC:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kimito Sakata <ksakata@Kimitos-MBP.hsd1.co.comcast.net>
Subject: RE: [EXT] Re: [External] : RE: [PATCH RESEND v3] mmc-utils: Re-submit
 of the erase command addition plus remval of MMC_IOC_MULTI_CMD ifndef for
 erase. Re-committing the change per request by Avir.
Thread-Topic: [EXT] Re: [External] : RE: [PATCH RESEND v3] mmc-utils:
 Re-submit of the erase command addition plus remval of MMC_IOC_MULTI_CMD
 ifndef for erase. Re-committing the change per request by Avir.
Thread-Index: AQHXOEzagB/88/YZNUO8uo7LYlemK6rGj9KAgABtSlA=
Date:   Mon, 26 Apr 2021 16:12:21 +0000
Message-ID: <BYAPR08MB5527E93440863C19FA9ABE0BC3429@BYAPR08MB5527.namprd08.prod.outlook.com>
References: <20210422161255.4610-1-luserhker@gmail.com>
         <DM6PR04MB657557ACD70FF26950CF0B0AFC459@DM6PR04MB6575.namprd04.prod.outlook.com>
         <DM6PR04MB6575ABF56616177093F75D80FC459@DM6PR04MB6575.namprd04.prod.outlook.com>
         <08442250-bc20-eaea-f383-cb36f4370102@oracle.com>
 <ce3adbd6f546fd43eb0db75c3895b1d664afee61.camel@gmail.com>
In-Reply-To: <ce3adbd6f546fd43eb0db75c3895b1d664afee61.camel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_Enabled=true;
 MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_SetDate=2021-04-26T16:12:20Z;
 MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_Method=Standard;
 MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_Name=Confidential;
 MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_SiteId=f38a5ecd-2813-4862-b11b-ac1d563c806f;
 MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_ActionId=beb830cd-e17e-4c61-9faf-f830e27048b5;
 MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_ContentBits=3
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=micron.com;
x-originating-ip: [99.67.18.40]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 45ec279d-13da-472f-d5da-08d908ce12a6
x-ms-traffictypediagnostic: BYAPR08MB4231:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR08MB4231DD4AE1C7210DD178DA39C3429@BYAPR08MB4231.namprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tcQ0HZ15EDN80IBJ5u4/BKdL3XaXppqWh+b8ttg5BJGkDEyiPDsUFFcWM18DEGmhuQ2jEzYk/cA4zmJFbiXRTgUfSErGf+T2o3CD3mybOIDY0dgi1bOOwhFW8Z0FhGvohM/fxwKuye2scmpnwlBzIoxa70RDPLgneHRmZhzBPKllbQW0k5T7exWOtMe4F5OP5MXUuqz6NsVbjc8sC6Pg1AK0KISKxf4eOQfYDhAbZrvBxutHkTViWkaWvwSMMGs3bWUSfTuuGmrKseibq2aVILHS2TksiBTSIVJiX+qccv3fh48+7Zi48Yjg+1Vh04J3H7oAWCmgUtUgxAzZmco5zkgmBizNmNnJGMXYY8cuT6ya0Le7j2FEPVnJerXIfTtPzLxFKhmNwfo2r6jFDnvG3WJZwj+73ge5l0FOqR3xbgCR0gC4eAcYm10ZIet7cZ4leFTKLR5JqAcodpGQzVOIFdAYYDaXTHp/528s+VsooUXGWVZGhPjYn+MeeEhRMjSs/RgsxjMYCosYOBEXRFXI3Zgr5QyBG2TnE5P2Ru0NKEh7oraftR6/uXptu91FY246SJ4yCY8Z0184IfU5dnR55FgTwe386y/9huR8jtTJkJc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR08MB5527.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(396003)(366004)(376002)(136003)(53546011)(5660300002)(71200400001)(66446008)(122000001)(6506007)(8676002)(4326008)(83380400001)(76116006)(478600001)(38100700002)(66476007)(66556008)(52536014)(7696005)(86362001)(64756008)(66946007)(2906002)(33656002)(9686003)(54906003)(55016002)(8936002)(26005)(186003)(7416002)(110136005)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?UDVZT0ZqUEpMZXJMTWY5UjlLZHFjaFJPbVpyaUxnQWZsb2t6SmZmVEhYZzVl?=
 =?utf-8?B?Y0c2ZDlKUFpsb1pWakNlTzFLUk5SK1RlQ1ZPVGRycmJXUGlPVmdKYWZqZXlx?=
 =?utf-8?B?RU5BcUxVS3ZlWHZZaWczSFZmQmM3bzZTTDhuaTEwZ0JRZW1IM0orNWtvcEUy?=
 =?utf-8?B?cnlNY0JHSnd0UUYybGYzZG85YTFmNzgzVWJMYklmcE42TnNUcVl2bk9EV0JJ?=
 =?utf-8?B?N0p1ZHZpQTF4QXBWTW5iNU90eFNZRU1BWE1sc2xJMHdIanFTbnh4S1YzTEhs?=
 =?utf-8?B?VzZCdFRRZm9oQ1NEdEg2ZmRmVi9kTENxQXkyT1NMcVZNaEk0VDFrTXIvbnRR?=
 =?utf-8?B?Z0JQSm5sVzNROWh4Zys3UXZ2WDRoM2xYN0ljOUViMGtZTXRzRTlVTHE0WTJN?=
 =?utf-8?B?V2dPdlE2bGxNZ3kyQ09lOUg4MjhnWlVQNFV5anRReFpZUVloSE5MN2JmODNm?=
 =?utf-8?B?Sy8zZ0lCOTRQSFNJRFFPWThXT3Riakx1eUJHZkNRMktKdDNYTzNrVjNLM3ZD?=
 =?utf-8?B?T2VpcXdlOUlKMHNPbXo2bHFaUjBsczdGRkVWdlRZUDFhbXlCRklCYkMwQUYz?=
 =?utf-8?B?ZEVZdlk2REpoOEhUUXBRZmdXbFoyaW9VU1BXS3d0U2tub25vVXBqMXhHd1po?=
 =?utf-8?B?NXBwb3ZBbUhTOHNBUmdyeVN6OWkyV3JrR2NGVS9CN3R0Qy9aL2ZvL3dnS0Vz?=
 =?utf-8?B?b3ZnekJTaVNVakNrNTZFKytlNkFKalBDc0JDa0Uvc203Ry9wYUF4WGZ1R2E2?=
 =?utf-8?B?SDc1OFZQYjhmRmcvZ2ozVTQ3ak5jQmFxMEZ2Z25hZU1EVHBBajhLc0UxVzlE?=
 =?utf-8?B?WmtmbWo5RWs1ZUpad0tibWpSdGxVOXNkc2dUcDlpbWVCRWZEVHdmTXVzRisx?=
 =?utf-8?B?anM4V2twazlqN2NTWnVDMTdENEk2OXN4Q0pJRGNqRlE5S2gzbFIvcDVacGNt?=
 =?utf-8?B?WUtPWXNjUExRYmtNMjVWV0xFOFczZEhZaUwzUHZ2MkorV2trVzBVTFhmc3pB?=
 =?utf-8?B?bWlxalg1bVhLY3ljZldDWmM3Zmg0bWF4UEhyZm5vV2pWeDE3S3RNbjBxMGdL?=
 =?utf-8?B?QkxnVmJldDFxbVF6Um9uY2NWbzk1VWhOb0hDTVhpRS9XWUxmUktUdjJha3V5?=
 =?utf-8?B?cWZSdnNlbmxkOHo5VDI0N2xIdWsvejZJTmJ1UWtReVc1cnhJMHpyVDFib0F6?=
 =?utf-8?B?b09RZmNkd2U2a1hEUFJDeVd0Yzc3eUZEa3Fzc2NkUVIvNmxYTk1jZDgwWFlm?=
 =?utf-8?B?RVpnRzVkTHFSdWVQRGhIdjFQaFZBVjNSRXBzc3JOVDJJNWFNT2N0b3JvSWg2?=
 =?utf-8?B?VGQ1eXlLRklsYkVyTXJucE5nZTRzMHdiaFN0L2xGak14QUV4T3ZOUnZNNXNV?=
 =?utf-8?B?TnBjSFpIaWE0dXFEYmtLMG1TMm9HeXU5RXdHWUg2TUlEMnpRMFQ0anZtWGdI?=
 =?utf-8?B?OFRDaUk2b25OR29zanJIczNJdlFMckkrYkNwaUZwdHA1WTd1V1hPTWhOQWJp?=
 =?utf-8?B?UVd2L0d2UUhOaDdhOFNkaExkWXVmaVIrd1RUaEs0b0VjZmRNSWZrRlFrWmMr?=
 =?utf-8?B?V0M0QlBENFZlQ09lU21wQ1JaNTlwdEtCQnpDamFxRGlnWVo2aUR6b0lJNE10?=
 =?utf-8?B?cTVXUzRmejNGUm9mVGh4K2tMSUtsby9ZUWhrOG94MVJJUGF6bzlXTk1iLzY1?=
 =?utf-8?B?ZHpDNVJPY3ZTNUI3WjFBYjZnOFVmbEU1RFN4RFlkNUFycHhLbi9BOTloVVZy?=
 =?utf-8?Q?tKOJjA2H4bU5FvocLg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR08MB5527.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45ec279d-13da-472f-d5da-08d908ce12a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2021 16:12:21.7845
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q+EJvvIQihVpQnnWFIWUHGRkb4XCDARIE9jEe83mHNpbnOzZagvI2NFJCSnGB48HvKwobTGgllYe0IEcY7egPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR08MB4231
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

TWljcm9uIENvbmZpZGVudGlhbA0KDQpCZWFuLA0KDQpJZiB5b3UgY291bGQgaGVscCB3aXRoIHRo
aXMgaXQgd291bGQgYmUgYXBwcmVjaWF0ZWQhDQoNClRoYW5rcywNCg0KUmFqIEthbWRhcg0KDQoN
Ck1pY3JvbiBDb25maWRlbnRpYWwNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206
IEJlYW4gSHVvIDxodW9iZWFuQGdtYWlsLmNvbT4gDQpTZW50OiBNb25kYXksIEFwcmlsIDI2LCAy
MDIxIDI6NDEgQU0NClRvOiBraW1pdG8uc2FrYXRhQG9yYWNsZS5jb207IEF2cmkgQWx0bWFuIDxB
dnJpLkFsdG1hbkB3ZGMuY29tPjsgbHVzZXJoa2VyQGdtYWlsLmNvbTsgQmVhbiBIdW8gKGJlYW5o
dW8pIDxiZWFuaHVvQG1pY3Jvbi5jb20+OyBrZW5ueS5naWJib25zQG9yYWNsZS5jb207IFJhaiBL
YW1kYXIgKHJrYW1kYXIpIDxya2FtZGFyQG1pY3Jvbi5jb20+OyBjaHJpc0BwcmludGYubmV0OyB1
bGYuaGFuc3NvbkBsaW5hcm8ub3JnDQpDYzogbGludXgtbW1jQHZnZXIua2VybmVsLm9yZzsgbGlu
dXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgS2ltaXRvIFNha2F0YSA8a3Nha2F0YUBLaW1pdG9z
LU1CUC5oc2QxLmNvLmNvbWNhc3QubmV0Pg0KU3ViamVjdDogW0VYVF0gUmU6IFtFeHRlcm5hbF0g
OiBSRTogW1BBVENIIFJFU0VORCB2M10gbW1jLXV0aWxzOiBSZS1zdWJtaXQgb2YgdGhlIGVyYXNl
IGNvbW1hbmQgYWRkaXRpb24gcGx1cyByZW12YWwgb2YgTU1DX0lPQ19NVUxUSV9DTUQgaWZuZGVm
IGZvciBlcmFzZS4gUmUtY29tbWl0dGluZyB0aGUgY2hhbmdlIHBlciByZXF1ZXN0IGJ5IEF2aXIu
DQoNCkNBVVRJT046IEVYVEVSTkFMIEVNQUlMLiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBh
dHRhY2htZW50cyB1bmxlc3MgeW91IHJlY29nbml6ZSB0aGUgc2VuZGVyIGFuZCB3ZXJlIGV4cGVj
dGluZyB0aGlzIG1lc3NhZ2UuDQoNCg0KT24gRnJpLCAyMDIxLTA0LTIzIGF0IDA4OjI3IC0wNjAw
LCBraW1pdG8uc2FrYXRhQG9yYWNsZS5jb20gd3JvdGU6DQo+IEl0cyBiYXNpY2FsbHkgdGhlIHNh
bWUgY2hhbmdlcy4gQmVhbiB3YXMgY29hY2hpbmcgbWUgb24gaG93IHRvIHNlbmQgDQo+IHRoZQ0K
Pg0KPiBjaGFuZ2VzLg0KPg0KPiBUaGUgb25seSBkaWZmZXJlbmNlIGJldHdlZW4gQmVhbidzIHN1
Ym1pdCBhbmQgbXkgbGFzdCBvbmUgaXMgVWxmDQo+DQo+IHJlcXVlc3RlZCBtZSB0byBtYWtlIGEg
Y2hhbmdlIGluIG15IGNoYW5nZXMgdG8gcmVtb3ZlIHRoZQ0KPg0KPiBNTUNfSU9DX01VTFRJX0NN
RCAjaWZuZGVmIHNlZ21lbnRzLg0KPg0KPg0KPg0KPiBUaGFua3MNCj4NCj4gS2ltaXRvDQoNCktp
bWl0bywNCg0KSSBqdXN0IHNhdyB5b3VyIGxhc3QgZW1haWwuIHdlIG5lZWQgdG8gcmUtc3VibWl0
IHRoaXMgcGF0Y2ggYmVjYXVzZSB0aGUgZm9ybWF0IGlzIG5vdCBjb3JyZWN0LiBJZiB5b3UgbmVl
ZCBtZSB0byByZXN1Ym1pdCBpdCBvbiBiZWhhbGYgb2YgeW91Lg0KbGV0IG1lIGtub3cuDQoNCkJl
YW4NCg==
