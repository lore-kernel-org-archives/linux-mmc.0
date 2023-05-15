Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B5D0C7EE22
	for <linux-mmc@archiver.kernel.org>; Mon, 15 May 2023 07:09:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239768AbjEOHJg (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 15 May 2023 03:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239663AbjEOHJf (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 15 May 2023 03:09:35 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46054E60
        for <linux-mmc@vger.kernel.org>; Mon, 15 May 2023 00:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1684134573; x=1715670573;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=qnVKWE3ubwp0ZeSFp/0lGxNbQFDxhQAlw1En3FM62qA=;
  b=BpMJeoAdT7pVMs4Hk9tI9phRwOGiAvY/C0YxTJIH9yjSecTi5O4hSi1x
   /RUjIcpF1Q/ssyxzi+jCnxIx1O5qw4AfZDcS2uOeJVNRFRk9rVqZpCJhK
   PCMULdBCzNpLZH/6gwZ5CbFFbui9W8GdW39bfdxv7h1vcVKcSVWgC0MSP
   eGRlX0ts6n8Ttg7CHbraxktQu3FipIZhC6F+ksG0SNtvVMWCe5eq/HRHT
   Cs6KiHTHExulmpWy9e50KxLLmN7SEeYAQ3MphRHzgfcjdH3MN7Ql5aXUm
   Pwhp4fcmmbZMBpEDZYEU2TBh9sKJmzT1/okdTFzTv14cnFprr8YJSEpq/
   w==;
X-IronPort-AV: E=Sophos;i="5.99,275,1677567600"; 
   d="scan'208";a="152043795"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 May 2023 00:09:31 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 15 May 2023 00:09:31 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 15 May 2023 00:09:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CWXBhMvSzJIRgI5V1v15NZsbayxUmdXKHVTtYrE0Fsig7mYJng/qNHEHhaQYErBcfFLdaQ8JVvYTsmVl23SqtRUsP3EsHs41ZqMDcnDb67FvLqAMzF8P4dj9uaNp/1ZBr+/BwqO+Ru7ZYOl3guY+RmY3YEtxR1aw3moTJBsAuo43O/B3XQNZSjuYhhDBjazEakd1aa1mkIrKlUx6gZHVKEDtZcsJMWgP3WLz2o/C7vpFGBhspO+GSF0tGi2a8KC3GN2A3Zoze6faJA7Hphj1OGf0Juj/zh1JUKWK+Ky36cAmNoGI0yYi67eQzxPjAQ7zwY2CvV1Xhbj9SSwSfo4/5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qnVKWE3ubwp0ZeSFp/0lGxNbQFDxhQAlw1En3FM62qA=;
 b=RFp3HTS1aov0OaQU9d4YHOyVU/5LGZLVDr5I938vDan7IaeyyZOetvlHYxN9YYSWrBJ9M+hPDeE3dUGimLcqYXzzTGTP8tL1odsc+F5WUadvoAov9l8n8bOftK+PFRpQFlpEps3RaZG0MWD43NIF9g7TpVWfleMv3y3dE3TqHi1Wz5vC3xfx2UDHvXFWvIiNAQdCQ3HQAy5N4az76GgX1Z0SXmLISW7+teK+MTZ/914P0HGUBTy5is0vGaPWzQfZLFXezV1hwoYOAKCo8VNZF7B50F0IvSzARkyccabuNbiARinz0Vmooa6mm7V4NK3zuQOZsyzJIg3mgFoHaTSZcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qnVKWE3ubwp0ZeSFp/0lGxNbQFDxhQAlw1En3FM62qA=;
 b=hvfzvKInq6G4st1H7nHBjU04nVsstq9JBFbqBuKBKux4ST2zcaXs4Ytevz9H5l1yfmztL29AGvar3cbM3IphNj+r606VkuZRecPudECFWiVY0dT8/b9Ttyu1wmcgQa+JURe8ard0sS73lu8ju2MsAsz7mWQMb9WqfnlcNpY8Qq8=
Received: from SJ2PR11MB7648.namprd11.prod.outlook.com (2603:10b6:a03:4c3::17)
 by MW5PR11MB5860.namprd11.prod.outlook.com (2603:10b6:303:19f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 07:09:29 +0000
Received: from SJ2PR11MB7648.namprd11.prod.outlook.com
 ([fe80::27bf:a69f:806f:67be]) by SJ2PR11MB7648.namprd11.prod.outlook.com
 ([fe80::27bf:a69f:806f:67be%5]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 07:09:29 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <marex@denx.de>, <linux-mmc@vger.kernel.org>
CC:     <Ajay.Kathat@microchip.com>, <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: pwrseq: sd8787: Fix WILC CHIP_EN and RESETN toggling
 order
Thread-Topic: [PATCH] mmc: pwrseq: sd8787: Fix WILC CHIP_EN and RESETN
 toggling order
Thread-Index: AQHZhvwwcKA7ZDxaS0C6DFVN/mifKw==
Date:   Mon, 15 May 2023 07:09:29 +0000
Message-ID: <2698d02b-19b3-ca55-37c2-b5a3a352005e@microchip.com>
References: <20230513192352.479627-1-marex@denx.de>
In-Reply-To: <20230513192352.479627-1-marex@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR11MB7648:EE_|MW5PR11MB5860:EE_
x-ms-office365-filtering-correlation-id: c4aa3802-0fa1-46a0-a776-08db55135352
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 61dJl1yiAdBlPzjj1S8PoYEAPCmg67gh01B56j9pchaIYpPHaDxg7vSDC7qUxukUfv660kL8XX6ck9eS2Ku2/i8sA9zd8sqwOtooQsARCwoJNy+BO4MOnxdNhUBAqJ7aB8KpmWVVbMpIDPKFUPJ49CG8JYym9wsSEHF/m2cqYBSGpdfgvuVQeWXYElMCBiZcIriF3eOAAyecY7ao/wQLao495oiVjrZ6rGNtEGTe5obaZMkXpOsKJfiCil4E6WI0XjcEk/LBGf2md/BptLHCcULZ95MHO2bDjJZ0csJ4Qs5jZQJnbNrxtiNTIx0XXBhYBDmsPTJKnYPmazjjWzBiokRITSMb5tW5QqnQiqZ+uhcjL6Aw+Gv562pRBvQ0HA/TRUaIPT3uJQBYDa0/58V1Rn5ujdMdhSDHHVqAU3UaehCPUdIrCTMaCsTZYnbSvv1GelUN4DowrHw4uxCZ3I4DpvmRMusToRmt8dyCuGTt5363eheDrqqf07nWbk7W5591QeCtmRLESxVEfck4IsyojCl61bX+lZCOpOqpTF1J+PEHZIbCwjAybiY9lJp7xJ+r9EMTlCtHDGZmgtSW4REYmyCBG62JfPf8W7dkxDpQayU9RvWLdmTJcfl0td8gjKmxDmi7dcT5GFfXiwHox3Chy5cfUM/ydElPgSzsFZyNXMX3jaLsSt2EirDLpGwCOIBEHEQdoxIWDndlUtqvzImS7w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7648.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(346002)(396003)(376002)(366004)(451199021)(2906002)(478600001)(41300700001)(316002)(110136005)(54906003)(71200400001)(6486002)(8936002)(64756008)(4326008)(91956017)(31686004)(66446008)(5660300002)(8676002)(76116006)(66946007)(66556008)(66476007)(966005)(26005)(53546011)(6506007)(6512007)(83380400001)(186003)(2616005)(36756003)(38070700005)(86362001)(38100700002)(122000001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eXlYR3g4UzRyUGk5VDM0YklLT1dFQWdlT3VjUzBwRk1PaEtUQXBKUnNPa1U3?=
 =?utf-8?B?NTFxUWVSSk5sMktyV0o3MllMVmZKL0h1VHVGTGJxUi8xbmZ0QVhzZ1lWREZ6?=
 =?utf-8?B?VUw3WDE2SUJuaTNWMUpBMnoxakxXNkVJOUlBaDI5dVQ4NEpzNWFWTlpBUi9x?=
 =?utf-8?B?c1RFNUp2elB4UXpWT3haWTg5MVF5T1FpVC93ekFjc1hvMm1RLy9aOHBPVHRp?=
 =?utf-8?B?cGExNUlGMTdXVXJlQWVwbDlYSWtXN3AxYnlpTVllQWM4cS81dXk2Y1ZhUTZR?=
 =?utf-8?B?VGtkU3hvVGI5U0Vpa0plNEhhaVgvT1VkNTJQWnpJekErKzlrWU85UUxtVENT?=
 =?utf-8?B?MnNKSzVqYTB1NVRkNCtoeklxdU5JM1pXRVZ3K2Q3dzJhb0laVzhNWEVlZDFK?=
 =?utf-8?B?Y1ZXRDBkNkd3Um5YSU1GQ3dzOXlYaGVWc2RMQUpGVVpNM0V3dXRWaUJLT1N4?=
 =?utf-8?B?bFFWMFU0R3p6RDUxd1ZmbjBLNDlPcmY5VXlwMHhMQzRGcnFYRUNGZ1pBUnZL?=
 =?utf-8?B?Sjc0OVY0Q3RLdU13L0cxM0VZcGdWSkFoeUxGWEZZYlBIcmR2aWtxcEh3Z1VQ?=
 =?utf-8?B?UG9ZK3JFRjA4THowNmtRdzN1UzhUb09FODZ2a3J3UE15VHYwZVVrNWkxYmY3?=
 =?utf-8?B?ejFsbFJ0MklYOFdxVTR5cmQybElIcGJRSkgxOTArVVpGNC9yMkdxbU5hUjhq?=
 =?utf-8?B?S3VYeHpDUEQxU1FEN3A5WGZ3T0xOMGdZa25peFVhMXE4ekVGc3hCNUFBRlNU?=
 =?utf-8?B?UWpzS2xQNlk4cHNGVUZ0TVZUeFVaa2xBalhmWGs0b3AwRXYybURHd25rb2ZX?=
 =?utf-8?B?bzJrY2dOUXZRVk1iSVRiaGh6THVjbTdSSHMyR2ovczk2VjVBaGhlaUZLeDF4?=
 =?utf-8?B?QnZZM1JNWlB3UzU5T3hNRkhZdWRxbGxQTjNHcDkvVFo2cmZad0lWRnZERExw?=
 =?utf-8?B?MW5JT1pDbm5lbTA1ZWF2ZWFtUUlDTUhrZXBGdSsvQ2kybGpubkZta3JBN2Iw?=
 =?utf-8?B?UzZycVpRRWdmYUFaQm02ZlVNU1BvUHhYZEY3TDNReGR0cEhNcXpXWXlNOWti?=
 =?utf-8?B?SHYzZmJDd1hmMXg4ZVk3SmVBM1FLRnp0aTlRSE1ZYVcraGlGRjl0Uk8waDF5?=
 =?utf-8?B?RXlza1BLTnYxUlNEaWRzOW1ZS0hkcFBOdUc1TGhUbUtnOEMzc3VtYjdFMG9k?=
 =?utf-8?B?aHh5dlk2MzlIYWJVb2FDS1l5aTBwSk1xdXlhSWVhTnNBQXBST0FieHJNQm1u?=
 =?utf-8?B?RnVLdHJUaXpDYnlWVUgyeWtBSWk3RklRSXYzS0hpQ0VEbTdHZDd6SzQyQWs1?=
 =?utf-8?B?Unl4NW12bFBGQThmMGNZTUg0bjdxQXpraVRKS1pGUEFROVdvSHkzcXd4YWNB?=
 =?utf-8?B?OHlCa2FxSVM1Q04wYWoyRjJXRHg3RFZWVWRPM0hZb3FFVW9IeDlDNGJoL1hP?=
 =?utf-8?B?MGJTbC9rYy9LcktxdWgyUFBWRGZtS0ZUNFRCUjZvcEllV2x6ckk3QWN3Rit3?=
 =?utf-8?B?YkFWWXdrY245NVZGRXphYmR5OGs2QXFldm56Qm41ZlNYVUN1M0VKdFVjNURY?=
 =?utf-8?B?Sm9vVVhWZUxvcFcyZGFmK2pKSHl6K0ZtN2ZyQmZYS1NaMHIwb0daTVZ5TUth?=
 =?utf-8?B?Q3VDR25QeXIyYjVObUxBUGM0YWc5b0dBMXZFVzdjbmdZTHhJUGcxSFYyNWVz?=
 =?utf-8?B?Q1VXK2VHZFpjR0R5YTJiRjc2NHk4THZCTjJCdDlzRXNyRU9Rd1ZLMXdOVHNK?=
 =?utf-8?B?b1JvVitEcnNFeWs0czM0SVYvZlBlVHhkU2UrU2NDTm9vTkRoS0dRaDFBZGFo?=
 =?utf-8?B?Z2p2VTgrVG1acHN6U01wT0tOYkFsMkk1MlJydllkWDVmdC9FVWlBb2hSaDdW?=
 =?utf-8?B?OWRGSk1xMWlnUHNsNy9JOE55MUhVQXRKR0xPanI1UWN1SkNaZnlmNm5yZHRI?=
 =?utf-8?B?S0I2clJNSlN2V1pnNmRxODVDK09SaDhJek9jNmYwMkx0dVpMMEd6TTJTNkI0?=
 =?utf-8?B?aGcxazNhemVkWUFBM21ueDNwZnd3bjhJY09JQkZRanJYQ2RYV3Y4d2N6TXpm?=
 =?utf-8?B?YURVY2dydDBZMmVXUXR6Nml6QXp3UnJSVUF1LzBtYXlkeTR1WExYQmdvZ0xh?=
 =?utf-8?B?cDFIWkVsSnFMcnpZYVBUallHSjV2L25LbWFybnVFbmdjcUNXMnBaVFlsbnE4?=
 =?utf-8?B?RFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0513F81F759C344585773A5A9AE1F53A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7648.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4aa3802-0fa1-46a0-a776-08db55135352
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2023 07:09:29.3198
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hMuhTHHSyXii4MzT7anQkJICiEOYvWf0GFqbNU45Rm6fCr9IUbpWAbLd9rWp45f8MSqrl5EM1XB0osqjRzRA0kD5aFO6b8pNRG/E1Ip2CkY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5860
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

T24gMTMuMDUuMjAyMyAyMjoyMywgTWFyZWsgVmFzdXQgd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlM
OiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cg
dGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gQ2hhcHRlciAiNS4zIFBvd2VyLVVwL0Rvd24gU2Vx
dWVuY2UiIG9mIFdJTEMxMDAwIFsxXSBhbmQgV0lMQzMwMDAgWzJdDQo+IHN0YXRlcyB0aGF0IENI
SVBfRU4gbXVzdCBiZSBwdWxsZWQgSElHSCBmaXJzdCwgUkVTRVROIHNlY29uZC4gRml4IHRoZQ0K
PiBvcmRlciBvZiB0aGVzZSBzaWduYWxzIGluIHRoZSBkcml2ZXIuDQo+IA0KPiBVc2UgdGhlIG1t
Y19wd3JzZXFfb3BzIGFzIGRyaXZlciBkYXRhIGFzIHRoZSBkZWxheSBiZXR3ZWVuIHNpZ25hbHMg
aXMNCj4gc3BlY2lmaWMgdG8gU0RJTyBjYXJkIHR5cGUgYW55d2F5Lg0KPiANCj4gWzFdIGh0dHBz
Oi8vd3cxLm1pY3JvY2hpcC5jb20vZG93bmxvYWRzL2FlbURvY3VtZW50cy9kb2N1bWVudHMvV1NH
L1Byb2R1Y3REb2N1bWVudHMvRGF0YVNoZWV0cy9BVFdJTEMxMDAwLU1SMTEwWEItSUVFRS04MDIu
MTEtYi1nLW4tTGluay1Db250cm9sbGVyLU1vZHVsZS1EUzcwMDA1MzI2RS5wZGYNCj4gWzJdIGh0
dHBzOi8vd3cxLm1pY3JvY2hpcC5jb20vZG93bmxvYWRzL2FlbURvY3VtZW50cy9kb2N1bWVudHMv
T1RIL1Byb2R1Y3REb2N1bWVudHMvRGF0YVNoZWV0cy9JRUVFLTgwMi4xMS1iLWctbi1MaW5rLUNv
bnRyb2xsZXItTW9kdWxlLXdpdGgtSW50ZWdyYXRlZC1CbHVldG9vdGgtNS4wLURTNzAwMDUzMjdC
LnBkZg0KPiANCj4gRml4ZXM6IGIyODMyYjk2ZmNmNSAoIm1tYzogcHdyc2VxOiBzZDg3ODc6IGFk
ZCBzdXBwb3J0IGZvciB3aWxjMTAwMCIpDQo+IFNpZ25lZC1vZmYtYnk6IE1hcmVrIFZhc3V0IDxt
YXJleEBkZW54LmRlPg0KUmV2aWV3ZWQtYnk6IENsYXVkaXUgQmV6bmVhIDxjbGF1ZGl1LmJlem5l
YUBtaWNyb2NoaXAuY29tPg0KDQo+IC0tLQ0KPiBDYzogQWpheSBTaW5naCA8YWpheS5rYXRoYXRA
bWljcm9jaGlwLmNvbT4NCj4gQ2M6IENsYXVkaXUgQmV6bmVhIDxjbGF1ZGl1LmJlem5lYUBtaWNy
b2NoaXAuY29tPg0KPiBDYzogVWxmIEhhbnNzb24gPHVsZi5oYW5zc29uQGxpbmFyby5vcmc+DQo+
IENjOiBsaW51eC1tbWNAdmdlci5rZXJuZWwub3JnDQo+IC0tLQ0KPiAgZHJpdmVycy9tbWMvY29y
ZS9wd3JzZXFfc2Q4Nzg3LmMgfCAzNCArKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLQ0K
PiAgMSBmaWxlIGNoYW5nZWQsIDI2IGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvY29yZS9wd3JzZXFfc2Q4Nzg3LmMgYi9kcml2ZXJz
L21tYy9jb3JlL3B3cnNlcV9zZDg3ODcuYw0KPiBpbmRleCAyZTEyMGFkODMwMjBmLi4wYzVmNWUz
NzFlMWY4IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL21tYy9jb3JlL3B3cnNlcV9zZDg3ODcuYw0K
PiArKysgYi9kcml2ZXJzL21tYy9jb3JlL3B3cnNlcV9zZDg3ODcuYw0KPiBAQCAtMjgsNyArMjgs
NiBAQCBzdHJ1Y3QgbW1jX3B3cnNlcV9zZDg3ODcgew0KPiAgICAgICAgIHN0cnVjdCBtbWNfcHdy
c2VxIHB3cnNlcTsNCj4gICAgICAgICBzdHJ1Y3QgZ3Bpb19kZXNjICpyZXNldF9ncGlvOw0KPiAg
ICAgICAgIHN0cnVjdCBncGlvX2Rlc2MgKnB3cmRuX2dwaW87DQo+IC0gICAgICAgdTMyIHJlc2V0
X3B3cmR3bl9kZWxheV9tczsNCj4gIH07DQo+IA0KPiAgI2RlZmluZSB0b19wd3JzZXFfc2Q4Nzg3
KHApIGNvbnRhaW5lcl9vZihwLCBzdHJ1Y3QgbW1jX3B3cnNlcV9zZDg3ODcsIHB3cnNlcSkNCj4g
QEAgLTM5LDcgKzM4LDcgQEAgc3RhdGljIHZvaWQgbW1jX3B3cnNlcV9zZDg3ODdfcHJlX3Bvd2Vy
X29uKHN0cnVjdCBtbWNfaG9zdCAqaG9zdCkNCj4gDQo+ICAgICAgICAgZ3Bpb2Rfc2V0X3ZhbHVl
X2NhbnNsZWVwKHB3cnNlcS0+cmVzZXRfZ3BpbywgMSk7DQo+IA0KPiAtICAgICAgIG1zbGVlcChw
d3JzZXEtPnJlc2V0X3B3cmR3bl9kZWxheV9tcyk7DQo+ICsgICAgICAgbXNsZWVwKDMwMCk7DQo+
ICAgICAgICAgZ3Bpb2Rfc2V0X3ZhbHVlX2NhbnNsZWVwKHB3cnNlcS0+cHdyZG5fZ3BpbywgMSk7
DQo+ICB9DQo+IA0KPiBAQCAtNTEsMTcgKzUwLDM3IEBAIHN0YXRpYyB2b2lkIG1tY19wd3JzZXFf
c2Q4Nzg3X3Bvd2VyX29mZihzdHJ1Y3QgbW1jX2hvc3QgKmhvc3QpDQo+ICAgICAgICAgZ3Bpb2Rf
c2V0X3ZhbHVlX2NhbnNsZWVwKHB3cnNlcS0+cmVzZXRfZ3BpbywgMCk7DQo+ICB9DQo+IA0KPiAr
c3RhdGljIHZvaWQgbW1jX3B3cnNlcV93aWxjMTAwMF9wcmVfcG93ZXJfb24oc3RydWN0IG1tY19o
b3N0ICpob3N0KQ0KPiArew0KPiArICAgICAgIHN0cnVjdCBtbWNfcHdyc2VxX3NkODc4NyAqcHdy
c2VxID0gdG9fcHdyc2VxX3NkODc4Nyhob3N0LT5wd3JzZXEpOw0KPiArDQo+ICsgICAgICAgLyog
VGhlIHB3cmRuX2dwaW8gaXMgcmVhbGx5IENISVBfRU4sIHJlc2V0X2dwaW8gaXMgUkVTRVROICov
DQo+ICsgICAgICAgZ3Bpb2Rfc2V0X3ZhbHVlX2NhbnNsZWVwKHB3cnNlcS0+cHdyZG5fZ3Bpbywg
MSk7DQo+ICsgICAgICAgbXNsZWVwKDUpOw0KPiArICAgICAgIGdwaW9kX3NldF92YWx1ZV9jYW5z
bGVlcChwd3JzZXEtPnJlc2V0X2dwaW8sIDEpOw0KPiArfQ0KPiArDQo+ICtzdGF0aWMgdm9pZCBt
bWNfcHdyc2VxX3dpbGMxMDAwX3Bvd2VyX29mZihzdHJ1Y3QgbW1jX2hvc3QgKmhvc3QpDQo+ICt7
DQo+ICsgICAgICAgc3RydWN0IG1tY19wd3JzZXFfc2Q4Nzg3ICpwd3JzZXEgPSB0b19wd3JzZXFf
c2Q4Nzg3KGhvc3QtPnB3cnNlcSk7DQo+ICsNCj4gKyAgICAgICBncGlvZF9zZXRfdmFsdWVfY2Fu
c2xlZXAocHdyc2VxLT5yZXNldF9ncGlvLCAwKTsNCj4gKyAgICAgICBncGlvZF9zZXRfdmFsdWVf
Y2Fuc2xlZXAocHdyc2VxLT5wd3Jkbl9ncGlvLCAwKTsNCj4gK30NCj4gKw0KPiAgc3RhdGljIGNv
bnN0IHN0cnVjdCBtbWNfcHdyc2VxX29wcyBtbWNfcHdyc2VxX3NkODc4N19vcHMgPSB7DQo+ICAg
ICAgICAgLnByZV9wb3dlcl9vbiA9IG1tY19wd3JzZXFfc2Q4Nzg3X3ByZV9wb3dlcl9vbiwNCj4g
ICAgICAgICAucG93ZXJfb2ZmID0gbW1jX3B3cnNlcV9zZDg3ODdfcG93ZXJfb2ZmLA0KPiAgfTsN
Cj4gDQo+IC1zdGF0aWMgY29uc3QgdTMyIHNkODc4N19kZWxheV9tcyA9IDMwMDsNCj4gLXN0YXRp
YyBjb25zdCB1MzIgd2lsYzEwMDBfZGVsYXlfbXMgPSA1Ow0KPiArc3RhdGljIGNvbnN0IHN0cnVj
dCBtbWNfcHdyc2VxX29wcyBtbWNfcHdyc2VxX3dpbGMxMDAwX29wcyA9IHsNCj4gKyAgICAgICAu
cHJlX3Bvd2VyX29uID0gbW1jX3B3cnNlcV93aWxjMTAwMF9wcmVfcG93ZXJfb24sDQo+ICsgICAg
ICAgLnBvd2VyX29mZiA9IG1tY19wd3JzZXFfd2lsYzEwMDBfcG93ZXJfb2ZmLA0KPiArfTsNCj4g
DQo+ICBzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBtbWNfcHdyc2VxX3NkODc4N19v
Zl9tYXRjaFtdID0gew0KPiAtICAgICAgIHsgLmNvbXBhdGlibGUgPSAibW1jLXB3cnNlcS1zZDg3
ODciLCAuZGF0YSA9ICZzZDg3ODdfZGVsYXlfbXMgfSwNCj4gLSAgICAgICB7IC5jb21wYXRpYmxl
ID0gIm1tYy1wd3JzZXEtd2lsYzEwMDAiLCAuZGF0YSA9ICZ3aWxjMTAwMF9kZWxheV9tcyB9LA0K
PiArICAgICAgIHsgLmNvbXBhdGlibGUgPSAibW1jLXB3cnNlcS1zZDg3ODciLCAuZGF0YSA9ICZt
bWNfcHdyc2VxX3NkODc4N19vcHMgfSwNCj4gKyAgICAgICB7IC5jb21wYXRpYmxlID0gIm1tYy1w
d3JzZXEtd2lsYzEwMDAiLCAuZGF0YSA9ICZtbWNfcHdyc2VxX3dpbGMxMDAwX29wcyB9LA0KPiAg
ICAgICAgIHsvKiBzZW50aW5lbCAqL30sDQo+ICB9Ow0KPiAgTU9EVUxFX0RFVklDRV9UQUJMRShv
ZiwgbW1jX3B3cnNlcV9zZDg3ODdfb2ZfbWF0Y2gpOw0KPiBAQCAtNzcsNyArOTYsNiBAQCBzdGF0
aWMgaW50IG1tY19wd3JzZXFfc2Q4Nzg3X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBk
ZXYpDQo+ICAgICAgICAgICAgICAgICByZXR1cm4gLUVOT01FTTsNCj4gDQo+ICAgICAgICAgbWF0
Y2ggPSBvZl9tYXRjaF9ub2RlKG1tY19wd3JzZXFfc2Q4Nzg3X29mX21hdGNoLCBwZGV2LT5kZXYu
b2Zfbm9kZSk7DQo+IC0gICAgICAgcHdyc2VxLT5yZXNldF9wd3Jkd25fZGVsYXlfbXMgPSAqKHUz
MiAqKW1hdGNoLT5kYXRhOw0KPiANCj4gICAgICAgICBwd3JzZXEtPnB3cmRuX2dwaW8gPSBkZXZt
X2dwaW9kX2dldChkZXYsICJwb3dlcmRvd24iLCBHUElPRF9PVVRfTE9XKTsNCj4gICAgICAgICBp
ZiAoSVNfRVJSKHB3cnNlcS0+cHdyZG5fZ3BpbykpDQo+IEBAIC04OCw3ICsxMDYsNyBAQCBzdGF0
aWMgaW50IG1tY19wd3JzZXFfc2Q4Nzg3X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBk
ZXYpDQo+ICAgICAgICAgICAgICAgICByZXR1cm4gUFRSX0VSUihwd3JzZXEtPnJlc2V0X2dwaW8p
Ow0KPiANCj4gICAgICAgICBwd3JzZXEtPnB3cnNlcS5kZXYgPSBkZXY7DQo+IC0gICAgICAgcHdy
c2VxLT5wd3JzZXEub3BzID0gJm1tY19wd3JzZXFfc2Q4Nzg3X29wczsNCj4gKyAgICAgICBwd3Jz
ZXEtPnB3cnNlcS5vcHMgPSBtYXRjaC0+ZGF0YTsNCj4gICAgICAgICBwd3JzZXEtPnB3cnNlcS5v
d25lciA9IFRISVNfTU9EVUxFOw0KPiAgICAgICAgIHBsYXRmb3JtX3NldF9kcnZkYXRhKHBkZXYs
IHB3cnNlcSk7DQo+IA0KPiAtLQ0KPiAyLjM5LjINCj4gDQoNCg==
