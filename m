Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D52E4C77B7C
	for <linux-mmc@archiver.kernel.org>; Wed, 31 May 2023 06:02:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234304AbjEaGCH (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 31 May 2023 02:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234303AbjEaGCF (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 31 May 2023 02:02:05 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 194BB11D
        for <linux-mmc@vger.kernel.org>; Tue, 30 May 2023 23:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1685512921; x=1717048921;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5vbccZsHlDz7BGkt74Yn8vqaI9Lsl1OGtj6pFrV1usg=;
  b=OrCi3zc0bB+2s+U2USY93mDSTn+tscWvowLnl9saobSe7JLDTTfcEr6H
   5htdZRQGSLxt0+4ex2/iry0m3RQaBNjtxw18vNZ0aNv17g/s3fGoe3KAn
   vL40tgbeI7naPbG24Mem/yoZ7PhSwWfhxQD5bpdLwfd0RkUECK5ez5v6b
   LvfFLBPh/fFxT+ff8exc9qYQXDxzjRYPtCtui5ee/QXA6sCNRcK1YS4Ke
   5JzuWIcEsjOOTXT+mnHtEmwe9D5XwYP8EBudQU2JxqIAyLaoXsmXO/JH7
   2j58fVrHGv/Q6Lk9G6kMneiHKX1EiBy/vkRNadc21NTPG8P4EI5MjLMn6
   A==;
X-IronPort-AV: E=Sophos;i="6.00,205,1681142400"; 
   d="scan'208";a="336524890"
Received: from mail-mw2nam10lp2105.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.105])
  by ob1.hgst.iphmx.com with ESMTP; 31 May 2023 14:01:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ECF7ypc7SJmcDPAtCSVVNQ4UvGsxKYJS7IKx0tUMEXC++RreuozHgOR0cXzXecTprwu0pdmaLwq4H7gfGTqR/jK+HQeHnPyWkITZcgPwNxbbIz5x2tTu0OdAWZSSVrgP1ldRXLce4GDsSle++6SicoWueMQzHckm5wmRQstfYJsz0Wtkk6fT4HlY2mihHj4ejospi0rVRqa7SOO4PM+XBdE3lDU+k58oTN9gMciIoWdp1OM/0eFfrihInZVMVbj4ohUhjXPB74Dt4HK5rpzCVSimCO6COATWQbhQ/CbM3l/Wu3ZGGXGIWIqir7wHxsPL3sn8paZzwZAgUHuneMEmOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5vbccZsHlDz7BGkt74Yn8vqaI9Lsl1OGtj6pFrV1usg=;
 b=mycyXuD9lYkbT995n0Dhim933Iiue37ph+z7tGWmAAMLy/o3lFmsyJOxWEKerAEecWb1aV9lEIFSUJj1eVTAMrKNfTcBS6kQb5f5JtJGC5UtunCsF6t662buxW+/gA5G3JjPj7JgXbObax9MncwOCLo3IpQK2AFMKPMbw/XlGbes7tBgUVzsdDUqgKcmVt/0KESCyJUvOEduvYo6AMFis3ZZ0hdkCnCJ97X3xvlL6iO8eKDDy1g/IpaREXK+d4TmxhBSvr75zO2PmLTas8Gr+RbL6LZQ9KNQTWufE3lJg9/ZW76W63yhG0Cc5K6e+EtQtJ6Uv/AUM38YDvzmkKeGFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5vbccZsHlDz7BGkt74Yn8vqaI9Lsl1OGtj6pFrV1usg=;
 b=TQyhKw91R8RNHcRwqEWQpbU/8BHDFtauVCYG0Bzm83UGfhhlHgQzl6yjx90a2sIguWZ9+AHCGucTy2A6O8rXgAMIrENFq2h0lxDW4q531xmGEASD2anbvn2kvWAYCroDy+JkRzWxppTUNL3VXJTRzhrB4t2ulXCRRBUN4tH09Bo=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 DM6PR04MB6606.namprd04.prod.outlook.com (2603:10b6:5:1b6::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6433.23; Wed, 31 May 2023 06:01:40 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::ede1:ce1f:d515:7650]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::ede1:ce1f:d515:7650%6]) with mapi id 15.20.6455.020; Wed, 31 May 2023
 06:01:40 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Marek Vasut <marex@denx.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
CC:     =?utf-8?B?Q2hyaXN0aWFuIEzDtmhsZQ==?= <CLoehle@hyperstone.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jens Axboe <axboe@kernel.dk>,
        Michael Wu <michael@allwinnertech.com>,
        Ming Lei <ming.lei@redhat.com>,
        Seunghui Lee <sh043.lee@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: RE: [PATCH] [RFC] Revert "mmc: core: Fixup support for
 writeback-cache for eMMC and SD"
Thread-Topic: [PATCH] [RFC] Revert "mmc: core: Fixup support for
 writeback-cache for eMMC and SD"
Thread-Index: AQHZk1bB0Z5+lF5h80WsDPUHWGpTFa9z4Svg
Date:   Wed, 31 May 2023 06:01:40 +0000
Message-ID: <DM6PR04MB65757BA6C2B6FFFF3C16A901FC489@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20230531002740.1235620-1-marex@denx.de>
In-Reply-To: <20230531002740.1235620-1-marex@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|DM6PR04MB6606:EE_
x-ms-office365-filtering-correlation-id: e1815374-b203-4859-8ee5-08db619c80d6
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dr3Cnm3xc9nHUykmPxQYG9woNOdjAITFkpF5TvfRiHtcc8D7X4idaJlaHggr1tpvhJxcyjZZSVjdRHzT9BKFxPBWiVxlTuxzP6vyY2nkjZSRBfts89tC33nVVaK0ZutBULc9gndVtvKJbcKLwBF0PQhoA6sfz+JhyccoAHlewOcSwAD9axt0XH44Nzkoq+duil5qylaxX2TFWBDpWJDJGffuUjReUp8eddCazWyaIsTa+FqeSbh786xA0SfbCEBFOiAWnwEwLKhgEzlqIL4dofGNZqsCET152py8ayZb/Wih1lcBWDVyXaSxmw8PPMIQIwseTLUYotbN4twTkLDS+rD4S4nixo9eDXjicGK5uXTlkDFE2/Cyc2XoTcRYxBEeITZA1oHw0jMeNyuP9DIcoxNQiRaFwqsE8i1tQen98lJ1QEDdJrRqz+vNnRSrNVPCjkLl7yhpRmwYuwLwgNmzRGYwDvoDvGsj1t+iml5wgRUGNEcBmX52GyJPLnndgvWYE/RGoLEpcpwF9EEKOyfGy/74kwqe+v09eMvDRr8ln5aT1KBQ1jmISGGx0BGVUwcDF+40CbE5GgANswtzBPszNIiwkAR6yjeyAUTWsdOPjL6qXggz9vcQYfDon/076X5D
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(366004)(39860400002)(376002)(136003)(451199021)(71200400001)(110136005)(478600001)(54906003)(8936002)(8676002)(5660300002)(52536014)(2906002)(33656002)(38070700005)(86362001)(76116006)(66556008)(66446008)(122000001)(66946007)(4326008)(66476007)(64756008)(82960400001)(316002)(55016003)(41300700001)(38100700002)(186003)(9686003)(6506007)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VmpBQnpDZ1NtMG55RTB1Wkl3UjBmN2xaZ1NMaUlOSldabWJRSUxTVmhqWkVi?=
 =?utf-8?B?eCtEVzM0RWpJOEU2NWRldGNWZTRVaDVETXdzcDJubjFNWlRVSG9OY244dFFr?=
 =?utf-8?B?dE5rMXZ6YUJ5UjhreFNCVENmNHNKV3k4QytpZ2p1ZzhvQm5LL2tRWWFZcGxm?=
 =?utf-8?B?NW9wS3crV21pY3M2YndyOUdOQWdpajJzOVVna015djIrRE5qT3Z0VVVkOWJl?=
 =?utf-8?B?dXNGU3NnbjMrTU4rZmdUaFMwMFVsbG13Z3dxZ3JhRHp4bE9XNE1hMW56bXlr?=
 =?utf-8?B?MWFMRGVDcGdlanZRLzdsZ1RIb3p1eUlZM1BLWFRQdll3QmwvcUFmT2JsMy8w?=
 =?utf-8?B?SkovbU1nN01obWlITC8rclNWOW9aVzZ5c2RJVlVCRjJxZ1d6M1dBWWNrUFF2?=
 =?utf-8?B?NlM1YkZ4V1NmeUtoNk9CbGs0S0ZHbUovZ2UyemJpc3RFWHFHdGowQjhEdlFi?=
 =?utf-8?B?bnk3NkcyL2lhbFhsNERabkhCYTJMWjQ5TW9ROC9XU3NJUFY4alBvclhQYkhY?=
 =?utf-8?B?c0xQVWhVa2xMalJnbTJuMWhySnFjOXBsbW40eEtqK3hmbVM4UGpQRTRuR1NB?=
 =?utf-8?B?U2ZyUS9yUTdpaFRWdk1YOElVMndjNnVOb0F4dm4vYkxaRmZmZTdKL2JtOXJD?=
 =?utf-8?B?NFVVTkwzdUNSSGZCWjI2WTh5Y3JuZkRSY3hiMWRCYzhadUxGbFQzOTNwcHZK?=
 =?utf-8?B?M1FxdG1STDZLVlE4b1I1UjZrVEwxOERQdFpsZk85Y2c0QkdBaHRrS0pGNUxV?=
 =?utf-8?B?a0FrVWxSb2VCS1JNUXdLMGtJTktiNU1wTWNZRkFNWXNhdVpnM2RUUnZ0Umor?=
 =?utf-8?B?VE55Uk5xTlE1bXRDa3REMUVkcDBpWGdmRVZzK3JoNHdabGNMMy9kbXhmTW9u?=
 =?utf-8?B?aHV6azNIQXJsbTdrOGNuMUhmblFaZXZUZGcrd3htbkFUNUJWRHFFVG05MThV?=
 =?utf-8?B?cjZMdWUxbkZCYVZxSDl2czBIRkN4S281Sjlzbk11VDR0WFlXMEdWeVJRWkR1?=
 =?utf-8?B?Yk5lSHp5QzV3b3BkeWwzNGhxSmppTEUva3NES2VGL1hlblRXanJiYXVoalR0?=
 =?utf-8?B?RWJ0TUE3MnRPanpEMkJYS3hlbWx1NGRBNnpuVmozV285eWJYLzFENGZSYmNk?=
 =?utf-8?B?MVJOS3NHbGJkajZHL3plYlVqeW1pTjRkQllKbFlVZWFUc3M5TmNTaU9URXJo?=
 =?utf-8?B?NFRMdE5xQ016Ty9HWFdjMFFsRGZmQ3ExV1N2MmJ4UEEzWW8zRy9oTG1TSFho?=
 =?utf-8?B?Z24wOU1SNFFRRVJZVWFZeUMrNWd5bHhpckxFSU1TRmFtc09CQkhuc2FlSnJq?=
 =?utf-8?B?ZUFPcGdsQ21wSkd6SkU5WStrV1FOemJLaUZlS1lyZDF1b0ErT0VaYXpFZXIz?=
 =?utf-8?B?d2lpeVBhOGxpZG9VenArUDU0Y1NNNHpqTGdtTHc0VVUzdlp6TFlxVUJBYVQx?=
 =?utf-8?B?ejA5eHMvVEpEa2l5bXhGcnpQWFp2SDZ5b1k2Q2paL0owN3hkdmF3RVBKOENs?=
 =?utf-8?B?OUlMWTFQRTZ3cnl0d01QeDMzZWtjcXZ4aTZma3dmSmtaYldHRWV1SHZlWVBS?=
 =?utf-8?B?UTRySXRYOGNBWm1xVzlaWXpLL0RBdFdJNjR3Mkp6Uyt3RjY4U3ZpU2ljNUpn?=
 =?utf-8?B?blNtS3grYjFHekhtY2ZGY0NveFVYd2NSazFFVXREM1VidVI4ejlMYnN3a2pW?=
 =?utf-8?B?RDlXaVNocnordmdoVVhkODU4M0Q2L093eC85ZTFjMDR2WVRGcU9BTy9EdW9E?=
 =?utf-8?B?MXh0aC90K2VIaEdueEpBMERmbEhsUzdFTE80WW9PODdFTnE1MTR5dVZBbzMy?=
 =?utf-8?B?cjduSXhUcXluTUtBejFiYjJMZmc5cDh0MTNGMDFKOTJYWGlZZDlhYVZ5SEVu?=
 =?utf-8?B?dTR4MWlGUXdJWnErWVhNNDBHVHp2YmNTY2tHejR0WU8rNVNIblJLR2dzeUgz?=
 =?utf-8?B?d2FZQVB2ajR6OUNsbDV0Nk9tQ1N2RjEvVUdKU3N6NzZFYzJzU3Q1b0p0SVc0?=
 =?utf-8?B?RnlXWWE3L3lYUzdXQ3FDNm9xSXFKTHNIcXIvbnQvRHlFQXdYbXlPZUZPOFJB?=
 =?utf-8?B?aGk0Rm5GQlhzM0JxODlrU2NJYmVMRVN5d0MvQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?TEVQNElYdVNQbmM3djlFc2tvajVURzhwWnlQdkZGK05DQ3d6TUk3YlhVR1FO?=
 =?utf-8?B?L3NrSnlna0VlemxrWEhqTU43ZzdTTHVNMVpxcU8zYWpLQ05FNFN5YWVaZElv?=
 =?utf-8?B?K00yY2xtbS9YV0VxK0VPVmhiZ00rOEgvS1RGOUh0eitQL3c3dXc5Ui9JUHN5?=
 =?utf-8?B?QmVSN05hc1FISXNQM1AyUnU3RjJtUVA3WkwwQ2gwMktQNG5HREZmTDVuUDlm?=
 =?utf-8?B?SEFuMk1DaHgyL1NVWCtGd2tpMFBJbUEvaWo5MjlkQnN2R2pPOVdML2dRZVAz?=
 =?utf-8?B?KytLZ05hSzF2NDFxbGZaZm1LVW9iRDZGSWVRM2tNZkhEQTJTM01RWm01VmZ3?=
 =?utf-8?B?WFhaMTZsQlFlNjJla1FFY2ptMStkdm5hNTI1WVhLMnd3cC9XK3ZzSGloblQz?=
 =?utf-8?B?dGpPSnBYL1pTK21VUm5zS0lrWGVLVk1CWjBGTjQ5S29aNlNveTYwYjl0dExv?=
 =?utf-8?B?R2FFYXp0NC96RGlubmJvMXQ1Mml1QmpPUlRZWFhjNDUvM1pLdzRiU0RtVVRM?=
 =?utf-8?B?L2xRQ2sxM1V3QnZzMXRlYmNXa1djeHY5VEdVYUxaRVEzVU9Ua05QVk9jOWt3?=
 =?utf-8?B?d1F6WGxrZ1crZmNFakM2aFVRdG95QkVLRmVIdUNPY0FTbW1DSVI3ZG1GTjE5?=
 =?utf-8?B?b0FsbDF1Qno5dTRTb0ZaWVdCSE5HY1loZVVhaGV5dDRIR2pLYjM3Q3dsK3h6?=
 =?utf-8?B?Sy9SSkJvVlZkV2tvd21rOS9lMTNXUEtPWGNMOFEwckl0NGd2MElpQWVmNXJu?=
 =?utf-8?B?TW91dE1mUU95RC84OE15UVE1MHFPSW9qcnpXaXgwTW13U1ZGeXFINVI2MzFm?=
 =?utf-8?B?Vy9lb2J4dlNaY3I4MHNmaXVKMnhrK3M5UEVTaTNrMzJqNUdpOHVLTzVpTGxn?=
 =?utf-8?B?blI0WGJyYjl2Z1dPS1lSQ2FocU9FMzNIQndFb20wZW0vMzBLOWxZbkowOFJD?=
 =?utf-8?B?VWQ1UFNmdEQzbnhVMDhmaC85eGZuTkd5dHREQWNGcHlnNUhCbGdOWTZ4Y3dP?=
 =?utf-8?B?MzdyQ2M1eHBVc0EzWkdFS2VTekF2ZWx1NGMza1B6U2RiVFJVSHdIVGdRT2lP?=
 =?utf-8?B?ZHA1WTlDN1EzY3lESjhhTDAzWTVhOWZSREdHMkorWmE3OElBYlNCR2pna1pS?=
 =?utf-8?B?a2VxUGV6TjBNODBURlNOMmhUVlNYQkxFQlhBUVZtMHExOTlhUjVkRnpHMEs0?=
 =?utf-8?B?enRNMTlQV3NoNitVdWRtL1ZaUXVTdENNazNEbEtOVWtBQWhUSDFkVnc4c3BC?=
 =?utf-8?B?L01Kd1FUU2J0V2wrZ0dwaG05TFRHd2F5cXlYT3lQb2R6NWFUMDlOU3IwZG9v?=
 =?utf-8?B?em5tMWtaOGpMY2lBcm9RdmQ0ei9vc3BNVlYySDRGeTY1TTF2OWJ6OG4yU2tn?=
 =?utf-8?B?T1RQNFVrVDA1NXc9PQ==?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1815374-b203-4859-8ee5-08db619c80d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2023 06:01:40.6811
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w1W9I0EJRDoZ28iDfaqKdpwzZOfxLr/DRW9zjbLbF7ZsIR9QUgnLekXt/FqZTUN4zBCR8YvtXGFOEuokEGjiJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6606
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

PiBUaGlzIHJldmVydHMgY29tbWl0IDA4ZWJmOTAzYWY1N2NkYTZkNzczZjNkZDE2NzFiNjRmNzNi
NDMyYjguDQo+IA0KPiBPbiBTVE0zMk1QMTUzQyBESENPUiBEUkMgQ29tcGFjdCB3aXRoIG1pY3Jv
U0QgY2FyZCBLaW5nc3RvbiBDYW52YXMNCj4gR28hIFBsdXMgTWljcm9TRFhDIEkgNjQgR2lCIFUz
L1YzMC9BMiBTRENHMy82NEdCIGl0IGlzIG5vIGxvbmdlciBwb3NzaWJsZQ0KPiB0byBtb3VudCBl
eHQ0IGZpbGVzeXN0ZW0uDQo+IA0KPiBHaXQgYmlzZWN0IHBvaW50cyB0byB0aGlzIGNvbW1pdCB3
aGljaCBpcyBiZWluZyByZXZlcnRlZCBoZXJlLiBBIGJpdCBvZg0KPiBpbnZlc3RpZ2F0aW9uIHNo
b3dzIHRoYXQgZm9yIG5vbi13b3JraW5nIG1pY3JvU0QgY2FyZHMNCj4gICBjYWNoZV9lbmFibGVk
PVRSVUUgZnVhX2VuYWJsZWQ9ZmFsc2UNCj4gRm9yIHdvcmtpbmcgbWljcm9TRCBjYXJkIChLaW5n
c3RvbiBDYW52YXMgUmVhY3QgUGx1cywgTWljcm9TRFhDIElJDQo+IDY0IEdpQiBVMy9WOTAvQTEg
U0RDUjIvNjRHQikNCj4gICBjYWNoZV9lbmFibGVkPUZBTFNFIGZ1YV9lbmFibGVkPWZhbHNlDQo+
IA0KPiBJdCBzZWVtcyBlbmFibGluZyB0aGUgY2FjaGUgZm9yIFNEIGNhcmRzIGNhdXNlcyB0aGUg
aXNzdWUuIEJlZm9yZSB0aGUgcmV2ZXJ0ZWQNCj4gY29tbWl0LCB0aGUgY2FjaGUgd2FzIG5vdCBy
ZXBvcnRlZCBlbmFibGVkIGZvciBTRCBjYXJkcy4gSSBhbSBub3Qgc3VyZQ0KPiB3aGV0aGVyIHN1
Y2ggYmx1bnQgcmV2ZXJ0IGlzIHRoZSBjb3JyZWN0IHNvbHV0aW9uIGhvd2V2ZXIsIGFueSBpZGVh
cyA/DQpUaGUgY29tbWl0IHlvdSBhcmUgcmV2ZXJ0aW5nIGhhcyBhIGNvdXBsZSBvZiBmaXhlcyB0
YWdzIC0gc28gcmV2ZXJ0aW5nIGl0IHdpbGwgcmUtaW50cm9kdWNlIHRob3NlIGlzc3VlcyBpdCBh
aW1zIHRvIGZpeC4NCklmIEkgcmVjYWxsIGNvcnJlY3RseSwgSSBhc2tlZCBvdXIgc2Qgc3lzdGVt
IGVuZ2luZWVyaW5nIHRvIGZvbGxvdyB1cCBvbiB0aGlzLA0KQW5kIHRoZXkgaGFkIG5vIHByb2Js
ZW0gd2l0aCB0aGUgbG9naWMuDQoNCkkgdGhpbmsgdGhhdCB3ZSBuZWVkIG1vcmUgZGF0YSB0byBl
c3RhYmxpc2ggdGhlIHJvb3QgY2F1c2Ugb2YgdGhpcyBpc3N1ZSwNClByb3ZpZGVkIHRoYXQgaXQg
aXMgbm90IGEgc3BlY2lmaWMtdmVuZG9yIGlzc3VlLg0KDQpUaGFua3MsDQpBdnJpDQoNCj4gDQo+
IFNpZ25lZC1vZmYtYnk6IE1hcmVrIFZhc3V0IDxtYXJleEBkZW54LmRlPg0K
