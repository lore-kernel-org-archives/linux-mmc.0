Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A80EAC433F5
	for <linux-mmc@archiver.kernel.org>; Fri, 29 Oct 2021 11:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83E5C60E90
	for <linux-mmc@archiver.kernel.org>; Fri, 29 Oct 2021 11:40:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbhJ2Lm5 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 29 Oct 2021 07:42:57 -0400
Received: from mail-eopbgr150055.outbound.protection.outlook.com ([40.107.15.55]:5636
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231950AbhJ2Lm4 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 29 Oct 2021 07:42:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZG6w2hyoGhiTEpAwzmrzK3uPW627VYWRdlxhiZ6ofocl7Zy0gTWqe17z+MQxa/zsiuQL3kZQ/n7mJrXs06cQMzUsglEE8liQBcBgbp4UT5HZvp6V9CbpsY2FRSf7YCyRQthPDE6waZIFRFCiI+VYbzYJaULiVHsig2d6Xb4uAxc5oPLVcb03mVa/O84i5ppPzwUWqjAcpPTFUjEhFh+/ZecEFL8q4EvR52gKFUBykV4Ce589WT3R2iE3zLCy89RpWfZYz5TZRC3dW8K0jPnyL3QQ8RygbP4/K6ndnk8BU9o/9CmlotEAOMhykzPhk/wSoHJfUD58QQnsVYbh39KcXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Zmju4mX3NP80bXdh9lBhKoSEjNCKw99CShUWnoJcL8=;
 b=anPTJ/ODA249NeLr5oREpabLp1sFd/bnC/IL3kcYRI+nfSXfldl4A5Obx6WrYQZQ32DPssDSpnro+n+DN/5WKEMga00taWmicGIq2heCIbZgO7YuYCLYC2ZExtat5atnjqX2Sprv4YWDwxAiBoxaMld60d8HQuUR826NPjobZRCAbCmcAFYo6veS/sTH8EUph0jES2MzOZwtKmLBRDWCthSloIXKHQry8I6ps/q2O+4WjM8yOoek4vVMNlv5lzVEuPkuZfnOkpdtjlU8VvihwqLVYCj9VA0AXOnmbZClvBRjJEZTIJkfjxzrLiKTFjoq0CMywupyTmyOX1nvaxWZlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Zmju4mX3NP80bXdh9lBhKoSEjNCKw99CShUWnoJcL8=;
 b=gu1kbEpbbj+g6LCTK+zlzVMhcgVIdBGunrOOjFPJtRaiC7vG9I4x6+ZtRqdCRSNbXxaySOy0vUwL292r6Yuh9WEx+SwVKyNKz9f0sox7Yn9veAmaFcZ9Rq3Sh+TnrnovEgYxM6jTXiDxTNYLLoKEBjkOJKhtaTmQVu9zXySkJs0=
Received: from VI1PR04MB5294.eurprd04.prod.outlook.com (2603:10a6:803:5a::22)
 by VI1PR04MB4912.eurprd04.prod.outlook.com (2603:10a6:803:5b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Fri, 29 Oct
 2021 11:40:25 +0000
Received: from VI1PR04MB5294.eurprd04.prod.outlook.com
 ([fe80::6c18:7e06:8efa:c8c9]) by VI1PR04MB5294.eurprd04.prod.outlook.com
 ([fe80::6c18:7e06:8efa:c8c9%6]) with mapi id 15.20.4649.015; Fri, 29 Oct 2021
 11:40:25 +0000
From:   Bough Chen <haibo.chen@nxp.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
CC:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] mmc: sdhci: disable ADMA when PAGE SIZE is 64K
Thread-Topic: [PATCH] mmc: sdhci: disable ADMA when PAGE SIZE is 64K
Thread-Index: AQHXyuCSPXRr3b+NwkGp+YnL4lotMqvmVzEAgAOGDyA=
Date:   Fri, 29 Oct 2021 11:40:25 +0000
Message-ID: <VI1PR04MB5294AFD5A60F98A73E12A16290879@VI1PR04MB5294.eurprd04.prod.outlook.com>
References: <1635302841-18997-1-git-send-email-haibo.chen@nxp.com>
 <34233159-2931-b02a-ef16-1029d8d7829a@intel.com>
In-Reply-To: <34233159-2931-b02a-ef16-1029d8d7829a@intel.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a409542d-2e9f-4d67-e96d-08d99ad0e661
x-ms-traffictypediagnostic: VI1PR04MB4912:
x-microsoft-antispam-prvs: <VI1PR04MB491210F92FB15E75D558520290879@VI1PR04MB4912.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Mi5KRHt2aE0qDHzxj+eh2CNgyNVCWoBy8kkWWLjc7sZKokPT6QiTORiaJ1/VmKw9tNTyL9PD/bZicIkHXLXSXU+p3b0AZtfWWwLKBN381KRCwAcI+etqC+R5zXXWLGoB5GhFOlyKiDbJBl2/8XE6iKXb+2eHJDPee1lhIskiCmYqPFvrly7jbTzmr6utgaTLrrxM0AfN20+EI15cDPh+ghiks1k1wsczZLL6bBfOoad7Dog5RPb+dsglK4THBODLgneyT34qd9L8iRnQa2qjQtWZpPpRGnelixfeZOW7jxXF4khxNPapykkzyqUhYIhF1yXJItbDkxACalySmQZtaTRAFolTLN4TpxxvDTXN+3Ll08lwWQmDrMT4iRMz2L/L54Jgxytjzoxl078Kxkn5cfaiPR+M3YgB6Q3XV8/S4g/yVVOEjoOyWMoMB6LozRUTdDyYNhysCtwFBqhNBrmxxl9wRT0v6LqVra2aIh5V9LrLKwwwbPcheKVhwsLGU/XIvti4AQAyTrrdlD7uFYILLplE9fTIDj/RTkya/5g0ENCo8/6OxkSapA5kEGoaZM1Gd6mtRtaZhbzC6IP/XG0/ZkiBKuxxtLGh6XPLmS2USc3cTrwUrvuOl9Vmlm+C4h+NCajRX6VXPH8PGVMCQ6j09qJOJYHo0pB4okSSlgyWkfDM350rgIqHXHYpzvEnu9S/kcYFoJb6KQUqj1CftquRjA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5294.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(316002)(186003)(38100700002)(26005)(71200400001)(110136005)(122000001)(54906003)(38070700005)(7696005)(8676002)(8936002)(83380400001)(99936003)(33656002)(86362001)(52536014)(66476007)(76116006)(66446008)(66556008)(64756008)(66946007)(4326008)(55016002)(508600001)(9686003)(6506007)(2906002)(5660300002)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RUU0cmlwUkxIdUlkc0EycWdGL1VPNTI5Q3lIbEZBcnpvMXRxcktzQmtMemhz?=
 =?utf-8?B?eUE0VTllRm9BVnFhaUdMNTlEUmkwMjdUWTNXMFBzTEp2aDJ3TTlPNXljbDBk?=
 =?utf-8?B?K0JkdHE2d3M4OFFxcXVHbDV5KyszbUEwKzdyc2Q0ckR0VGhqUGEzenIzYlpa?=
 =?utf-8?B?c0Q2LzBxYk9XeHRCbnBhRG85ZlNlSndLU3ZZcHB1TFFHRzdOU1hySVA1OVVV?=
 =?utf-8?B?NklndFVhdDFhREI3MDBDc0ZlL2ljVzUyZFljRkdtWGhPMk41VXJTdFJLVXo5?=
 =?utf-8?B?K0Z2V0VCK1FNajc5OWJiZHdvT3A1TStLZkZiTGZPN2VzNVNVQmh1NDNxMUsz?=
 =?utf-8?B?NzZpbXRHQjlPUGhTTEs2a2UxbnhOUXZSc3g5NjhxWGNPUzdId1VoWlVlWnVC?=
 =?utf-8?B?L3VSSTM5UUpzMG5hTG1HTk5RdnB2cTg1aTViV1lPeU1VQ0kzVjlCUGl1OWQ5?=
 =?utf-8?B?UU1pY1hLYVhhc2VhRFE4enkzcUp4Tm9wbzl1eG1ja1ZsMzgwVFFVcDZuYlZC?=
 =?utf-8?B?MzRjQTRFdGJWdmZJNGdJM3lWcWNtYVQ4bGI0ZURwWG8xeEpPRFdPMVBkLzA5?=
 =?utf-8?B?VTloaFIrL1BsZ2xXdE1rSndxb0pRcGs5RjQvaFlDNG9zQU9XaE01NGNzbmZm?=
 =?utf-8?B?VEJuNkc2TzhXVmt2VGhaQWdKUnlCZzdyT2toSkxqNzd4d3RmR0pMM0NjUlBT?=
 =?utf-8?B?ZXVBcjMxU1FBN1puaC9wMW9IdVR5Y3BxMGdGTTRrYmxaT2dkZVJSdzFrQjht?=
 =?utf-8?B?RDM1RUpYZ0NrRFE3N0xRZDVXU2lhbldZZmtuSDNLdmQ4WnVxVnk5UktkQkI2?=
 =?utf-8?B?ekVpRjVTRDhwenl1Z3VHRlRDcWcwRlQyNzFsTm9SRVp1c0NxWEhsYjVSRHJW?=
 =?utf-8?B?RHR0T0liWEh0S0ZrWElwOXYraHkrdE1Lb3BNSkFKZmdJMUFLZG53UXU3dHUy?=
 =?utf-8?B?NVpTWktNeEM1SXVvKzBvZ1dqN1BPUHAyS0RGOFJzUkhySGRCNG5EbExmYWlk?=
 =?utf-8?B?eGFZeXc1dVgyYWsxQms4VENkcjJyWTkyZCtXTXNkWjU2V1RjQ2JsRzVDTm5H?=
 =?utf-8?B?aHNBSWFoMXhBZVg4MW1lNWlZMi9jMk0wNVdBY0h4SlhvOUtKbHI1b1l5WG95?=
 =?utf-8?B?V2xrK1k0UEF2enlFRE5aZThPM0lKdEc2dHg1aGtCVXUvelNraWg2QkVOakUw?=
 =?utf-8?B?UjRRdVNFcUc1RnBqcW4wVXJnNFVDREdlT2wyMGsxZXQrWE5CUkxLWGF1a2VZ?=
 =?utf-8?B?WGhneTVYRWRCVi9ib2Joa0xQTmprSU1jdWpuemRtdjViSkR3d093WG9YcjBI?=
 =?utf-8?B?NHN6VjVPMndmMW43c01sL01ESXY0aXRpZGZzSHh3WWNqMFk3bmR5eFZyck9Z?=
 =?utf-8?B?Tk9JYmN6M1pEWlVZeDBpQmt5WnlkL1MxQUcrdWkxMVhyenpsSVlDVTlNU2Rk?=
 =?utf-8?B?eUtNVXJ4aDdMb0xRd1E4dW9YOElPclpIWC9SbS9laURSbENkY0JjK1dLYUE2?=
 =?utf-8?B?a0ozU2x4Y1AyME9WR1JzdVYzeG9PZW9QS3pRMG8vOHhwK2Nnd25ucU1aQlND?=
 =?utf-8?B?YlNoSEMvQnZJSkM1SUdxSEFhaDMyODFaa1JRR3d6MWlNQUdMRHpCbGM2WVhn?=
 =?utf-8?B?aTRpdWVocC8rZkFGQmdISFREc2ZmeEx2aUlFblp3VkZYS3RqQWxyem82Y2F6?=
 =?utf-8?B?RDVPcEd4OXNoM2xBZFI3Qm5xUlAvZnVLOXJMOSswbzdOUnVFYTgvTStkTFRO?=
 =?utf-8?B?S3NmTzdNN2ZWMXpROGJjZmNVeVpLamVQbUtwVkxFZy9HTkJrL0pJQVdUWGNX?=
 =?utf-8?B?RXpFdGxEbHNTVktQbGg3SkFlbjJ0MU9qNmRNTDhFY1lQK2ZaZytYRjFGNGM1?=
 =?utf-8?B?Y1dIR1pzVjhBR05Oa01jZDI3VmNlSnpjTDhaelN6SGhYc2FKN2lCM24rRFZG?=
 =?utf-8?B?OTJwMUZGdGZTUXZEZWpSNlNRdVJ4eHpUVDBkem0zcGlzdWZEVlBLRFcxMEgr?=
 =?utf-8?B?NWVLZWpqMTRkTUZxWUJiMFBhM0hmMmVHOHBvZEdqZVdwbVMxTERxbTlGRnRs?=
 =?utf-8?B?NTlzUDlNcWtURFRNN1gyTDllZlNsMmJ1NkVsWUlvUVVMcmI5ZlRNNXB5SmFV?=
 =?utf-8?B?cDF5cERnVm9sUWtWTDhUbzFYWHM1bXBmTVE1WUx3Q1N3WW1Ba0NZa2VuS3ds?=
 =?utf-8?B?WUE9PQ==?=
Content-Type: multipart/signed;
        protocol="application/x-pkcs7-signature";
        micalg=SHA1;
        boundary="----=_NextPart_000_004E_01D7CCFC.D08263B0"
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5294.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a409542d-2e9f-4d67-e96d-08d99ad0e661
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2021 11:40:25.7917
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FkSfvyR+2bQZVNZe+3VQlniB13vvYABA2cCh28TfbJLRgT5Z0ox090OlTpjyM5kL2TYPbBWVl2CIWNSO0XbnYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4912
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

------=_NextPart_000_004E_01D7CCFC.D08263B0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable

> -----Original Message-----
> From: Adrian Hunter [mailto:adrian.hunter@intel.com]
> Sent: 2021=E5=B9=B410=E6=9C=8827=E6=97=A5 13:50
> To: Bough Chen <haibo.chen@nxp.com>; ulf.hansson@linaro.org
> Cc: linux-mmc@vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>
> Subject: Re: [PATCH] mmc: sdhci: disable ADMA when PAGE SIZE is 64K
>=20
> On 27/10/2021 05:47, haibo.chen@nxp.com wrote:
> > From: Haibo Chen <haibo.chen@nxp.com>
> >
> > For ADMA with quirks SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC, it
> limit
> > the max segment size as 64K-1. Currently, linux kernel support
> > 4K/16K/64K PAGE_SIZE. If choose 64K PAGE_SIZE, sdhci in ADMA mode =
with
> > the upper quirks will meet issue.
> >
> > Though mmc driver give block layer the max segment size through
> > blk_queue_max_segment_size(), but in this function, it will compare
> > the argument with PAGE_SIZE, and will choose PAGE_SIZE if the =
argument
> > is smaller than PAGE_SIZE. When PAGE_SIZE is 64K, finally the mmc
> > request queue will get 64K as the max segment size. Once the sg data
> > length=3D64K, ADMA will meet issue. For this case, need to disable =
ADMA
> > mode.
>=20
> Sorry, I didn't look closely enough at this.
>=20
> For the 64K PAGE_SIZE case, did you try blk_queue_virt_boundary() with =
a 32K
> mask instead of blk_queue_max_segment_size() ?
> e.g. a hack for testing purposes like this:

I test on my board, this do not work, I still can see sg data_length =3D =
65536.

Best Regards
Haibo Chen
>=20
> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c index
> b15c034b42fb..4c3a9d999500 100644
> --- a/drivers/mmc/core/queue.c
> +++ b/drivers/mmc/core/queue.c
> @@ -376,8 +376,7 @@ static void mmc_setup_queue(struct mmc_queue *mq,
> struct mmc_card *card)
>  	 * both blk_queue_max_segment_size().
>  	 */
>  	if (!host->can_dma_map_merge)
> -		blk_queue_max_segment_size(mq->queue,
> -			round_down(host->max_seg_size, block_size));
> +		blk_queue_virt_boundary(mq->queue, 0x7fff);
>=20
>  	dma_set_max_seg_size(mmc_dev(host),
> queue_max_segment_size(mq->queue));
>=20
>=20
>=20
>=20
> >
> > Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> > ---
> >  drivers/mmc/host/sdhci.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c =
index
> > dbe87995596c..47e0c0156b94 100644
> > --- a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> > @@ -4187,6 +4187,12 @@ int sdhci_setup_host(struct sdhci_host *host)
> >  		host->flags &=3D ~SDHCI_USE_ADMA;
> >  	}
> >
> > +	if ((host->quirks & SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC) &&
> > +		PAGE_SIZE >=3D 65536 && (host->flags & SDHCI_USE_ADMA)) {
> > +		DBG("Disabling ADMA as it don't support >=3D 64K PAGE_SIZE\n");
> > +		host->flags &=3D ~SDHCI_USE_ADMA;
> > +	}
> > +
> >  	if (sdhci_can_64bit_dma(host))
> >  		host->flags |=3D SDHCI_USE_64_BIT_DMA;
> >
> >


------=_NextPart_000_004E_01D7CCFC.D08263B0
Content-Type: application/pkcs7-signature;
	name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="smime.p7s"

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIgXjCCBU0w
ggM1oAMCAQICCBLkWWZl3+DFMA0GCSqGSIb3DQEBCwUAMGUxIjAgBgNVBAMMGU5YUCBJbnRlcm5h
bCBQb2xpY3kgQ0EgRzIxCzAJBgNVBAsMAklUMREwDwYDVQQKDAhOWFAgQi5WLjESMBAGA1UEBwwJ
RWluZGhvdmVuMQswCQYDVQQGEwJOTDAeFw0xNjA0MDgwOTE1MDRaFw0yNDA0MDgwOTE1MDRaMIG2
MRwwGgYDVQQDDBNOWFAgRW50ZXJwcmlzZSBDQSA1MQswCQYDVQQLDAJJVDERMA8GA1UECgwITlhQ
IEIuVi4xEjAQBgNVBAcMCUVpbmRob3ZlbjEWMBQGA1UECAwNTm9vcmQtQnJhYmFudDETMBEGCgmS
JomT8ixkARkWA3diaTETMBEGCgmSJomT8ixkARkWA254cDETMBEGCgmSJomT8ixkARkWA2NvbTEL
MAkGA1UEBhMCTkwwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDAWrnSkYP60A8wj4AO
kATDjnbdgLv6waFfyXE/hvatdWz2YYtb1YSRi5/wXW+Pz8rsTmSj7iusI+FcLP8WEaMVLn4sEIQY
NI8KJUCz21tsIArYs0hMKEUFeCq3mxTJfPqzdj9CExJBlZ5vWS4er8eJI8U8kZrt4CoY7De0FdJh
35Pi5QGzUFmFuaLgXfV1N5yukTzEhqz36kODoSRw+eDHH9YqbzefzEHK9d93TNiLaVlln42O0qaI
MmxK1aNcZx+nQkFsF/VrV9M9iLGA+Qb/MFmR20MJAU5kRGkJ2/QzgVQM3Nlmp/bF/3HWOJ2j2mpg
axvzxHNN+5rSNvkG2vSpAgMBAAGjga4wgaswHQYDVR0OBBYEFFiVYO5OdO9lIqq97RmpK3qOF50H
MBIGA1UdEwEB/wQIMAYBAf8CAQAwRQYDVR0fBD4wPDA6oDigNoY0aHR0cDovL253dy5wa2kubnhw
LmNvbS9jcmwvTlhQSW50ZXJuYWxQb2xpY3lDQUcyLmNybDAfBgNVHSMEGDAWgBR54UkB4HvONDkp
QxkyZWE8BthVqzAOBgNVHQ8BAf8EBAMCAQYwDQYJKoZIhvcNAQELBQADggIBAAbOUfjWTDj+hByL
1uNjWcpi78tBzOvltka5EfKCj8uuv1WQVfvugF0RsqzpgfWMwj/EnTVHHrM++avuUtapouyqkq7z
8xBFpWa9nsg8vvmyHPCHoQdBqFaIHjCM/Gr6jVB1boBWaQTMr8FEG7DHlhObshlm3zF26il5NjAS
GhwryzJjD6/oHyKiw1BSxHvhpPc01e5nemXPX3C0pY3tcD1LYurGDWvGHVTH1BIMoOkmTa1EXcov
P3WwfSvEQBnM4Zcu8TIrSb+xu4GutPXM6R9G0vrgyJLUcA3LqThr4uZ5hANjLCCzmMRiOLPKbHfO
UCS+JLaduhVv0Bff2AXY2cOcTdIFYgwUeARrgxyCTjxoLNY96XRGzpdEZhUW3/rwjrZbIBMUvyc8
yONci+Ye1Hd+FRIVwDyRnHOz/KSwvgdIXcLlN/bKJ4ew0xVYW9Y0mGYWgsmHpQYZ5MynGhnmwxtd
GMbPyPehlBS2dLbhAAKYoL+eaoUOqnjildk2wD6gFg125oDysOAqLxyK3VY9kB5Z8Vjh30Lk5B5u
O7oxk3/hG8oEdn4qz61lRl7N8TDhBNHcKAm+ls5BBqZUsONASebHhP8yLkS9pKXMe5bjudLk1XVv
cSsm/iIRJYkdbeTXipBu4gjMQ/OCl+QqFqydDvRe9CQdzPqUhr8PgxxgysQJMIIFrDCCA5SgAwIB
AgIITn4GzGWRAEgwDQYJKoZIhvcNAQELBQAwWjEXMBUGA1UEAwwOTlhQIFJPT1QgQ0EgRzIxCzAJ
BgNVBAsMAklUMREwDwYDVQQKDAhOWFAgQi5WLjESMBAGA1UEBwwJRWluZGhvdmVuMQswCQYDVQQG
EwJOTDAeFw0xNjAxMjkxMjQwMjNaFw0zNjAxMjQxMjQwMjNaMFoxFzAVBgNVBAMMDk5YUCBST09U
IENBIEcyMQswCQYDVQQLDAJJVDERMA8GA1UECgwITlhQIEIuVi4xEjAQBgNVBAcMCUVpbmRob3Zl
bjELMAkGA1UEBhMCTkwwggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQCj7P72jqfzYGq/
J6jwexnlOfZGxRwwxYu9TlvW8pM1dQAjhXRixRBEhMH5APbZg+rYqbqLQMjI91HU1ueKw2kNCZUT
buyu125GkHyW9mA44Nf/eGGN5NZFnbY8AgjnuAi8qpkIxRa9hF1hmxIo/7hD6USSzz3Kz3ne2nc8
jwR5TO1PepRN+ztNuAPkD2z7XMI+ojtv9eZdOuRYGbCaaoMcGKPAi/PLm4TcxMG6dVkUCXaQP+OI
GB2P7g7i7n3c3LVz1zgh/pe/Pf4MQiN29tQutTIYhq3Al2/DoXFG3nOeZgp7dXLOxjtmT/wyw5m/
OhI8ExJkFZIeP97x8HAMQMp/pdDQEPtnbsBZNRx12TWymGffwcc7ASmMp87E0Zft9JerPYlpG2Vq
a9KgKt3jOsfl/3iFxJUVw/2cX2bcmpHMCZsZhN3OACMqM9FVYCBpkYXxv+VorkCLyAISLvrsO7My
xeS+P38FDDx/KfnE5jnnNGYWjaNTz9uVbL+OwDBR4QEOjgo9EC49tKI63wl/w1sM68MY8rAQLx17
vpLE+Le6WG4VvRDPGxuTf34RPcjHLfjswBlOOL9rzsZ4gNaL6cJYfBk9BISDR7QtWHu5E01vVyVY
gsQX9tIx7fNPetYpYObMKJOff4+Jyq9gztxaJmLeyuUKQgB5qJq/20xoBndcbwIDAQABo3YwdDAd
BgNVHQ4EFgQUkEhTIyp56oSbPT65DuiZdEBeoLYwDwYDVR0TAQH/BAUwAwEB/zARBgNVHSAECjAI
MAYGBFUdIAAwHwYDVR0jBBgwFoAUkEhTIyp56oSbPT65DuiZdEBeoLYwDgYDVR0PAQH/BAQDAgEG
MA0GCSqGSIb3DQEBCwUAA4ICAQCEgqJeyVvGvlbUtkMyrE930h6kWRDQMk/z8I2bk6rIGB8l4okp
kyI8E3HH9QX2bogCom03L3y3UY8ean+KQnaOapWpPQg1S3v0os/sdWvf+3ZKkgltbOnHxlA8b5Al
XiLWRLA1+TeBQMoLeFHv6s4P6JI7nXrczLP8LPOM3X6zJZFV6eluLM+h/yIT1yRmcP1XTn8gvzxq
VIcg2i1ur6jS1s2GgId0S7u797sx1UhPV4e3x+5vkzXRGHODmn+sS7OvUCqIQ4AZhxW8kOesjyZj
cxzXxEtJwGJUen8aqR/dIWJa+L/+iQshAYy6zUbQJU2qvCsr/ok8H3TvUXNmOjlLWOJXn9Q2HMvK
RKeBxoTf7T/MqIA/a+SKZ8cdDvZImThAjQo69EHUYZ4XpStdE7CTo09gQWLHBN1XMcnaE6aonHlJ
FcTK2003XYFPzBA6VilSZelpp38SPa+dWxLmcdxhtGfYC+b8OCawAn/Qik1oweIDNdmbYKkLRzxI
aLiZZhUDs9rH4+cZcFtn3C0rG9GuRWmI0am5cMJZm9cSTHXXzH4DVKog2ifwNLm1uuR8/ZMt6nvD
NmATpoU3ZDHJd0eziTuBCVOobTgt/uijawdJs7mQBtTjgpjDl8G0ukbunGXJXl+v6iQvvRrlJZhM
8+yhyEOrJod4BaCHH9rj74VGNDCCBfwwggPkoAMCAQICCDWXO7CfYZ/wMA0GCSqGSIb3DQEBCwUA
MFoxFzAVBgNVBAMMDk5YUCBST09UIENBIEcyMQswCQYDVQQLDAJJVDERMA8GA1UECgwITlhQIEIu
Vi4xEjAQBgNVBAcMCUVpbmRob3ZlbjELMAkGA1UEBhMCTkwwHhcNMTYwMzE4MTA1MjE2WhcNMjYw
MzE4MTA1MjE2WjBlMSIwIAYDVQQDDBlOWFAgSW50ZXJuYWwgUG9saWN5IENBIEcyMQswCQYDVQQL
DAJJVDERMA8GA1UECgwITlhQIEIuVi4xEjAQBgNVBAcMCUVpbmRob3ZlbjELMAkGA1UEBhMCTkww
ggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQCly7+CWLCDR2fV3flTSlksy/Bs0Y3VZb/X
mmrMFykb9kGrmr7KCrj/OQSpAAzdxmxKLZTa2OIpk4R+PhyzIQlVkVCLBcym2yYSt+TsEygu1og3
v28U53VvN2NbQdpJNv0aQnsJNxvvP8UoqLBzaPndVU0NHXFUGdQ0RoHUDNA6SnqGC6kKCeWTD1f7
/b6LtQKKmTYlYuymD2ysVofS/CuAwXER+zjXLqIFUPvRH/j6y6hq1e+AW/eW0ZnfH+FqTc3WEeSM
mrehrWNKQuanoqhACptwdOR4qiYw6Y9QkrVioOSl1sa65GRhTci8Jbk5mCV2uSKBw5Now1Rp5lQC
/w/dNO2o3iMin8eWz/bpVH4Kp2gC2bPKkETK84UO3Oo+pXMVd+RSXYdnQkZNgRdQR+cjSxQkLIul
ws7UOOfASnwD656iVgiksBK6kbMYwZnkjk67VGgXZu56wSDBv5ZXsdE0BdOZ7NSHetYubh8ChTC/
WXKwgI58YYlDZWQ17k5fM5u/OOXfQVh0NZvoX7EgPIbQDDF+3hxdlykU4ZHcUfhlnk4f5Q2XUjGc
3BWkZKqbMRTvGehNeXJUfdD+NgMbbsdKggtCn/JEwldbH9efntlVc2brditnflexf3WkwcNGhB0k
EwqTJrzXd2CCaESzNIgFgqqiIW3Udowr8qc/BJIs7wIDAQABo4G6MIG3MB0GA1UdDgQWBBR54UkB
4HvONDkpQxkyZWE8BthVqzASBgNVHRMBAf8ECDAGAQH/AgEBMBQGA1UdIAEB/wQKMAgwBgYEVR0g
ADA7BgNVHR8ENDAyMDCgLqAshipodHRwOi8vbnd3LnBraS5ueHAuY29tL2NybC9OWFBSb290Q0FH
Mi5jcmwwHwYDVR0jBBgwFoAUkEhTIyp56oSbPT65DuiZdEBeoLYwDgYDVR0PAQH/BAQDAgEGMA0G
CSqGSIb3DQEBCwUAA4ICAQCHr83XcZ67rjIJvbUQ7xgQWbwycWuQiRADywkqB1mxAhG6Pt4rNpup
D/t3BtH/oAyz+gxGLEBLP2qLH0kMvGhTj4cCyKkW6EkUxlP9U1OGYqaU0s8wv3SnyhbD3BrSNHo4
Bp+FGCb8gLHMGQdtmP9A3wZdQ89tyu+Jjfb6ddDYyZD1XFaVYCs08dDJxrN+xuPv+vmfP80kqDvT
uLTteabsJTnx8BbO+5WjzjaOJcg2o6Ts6rfL3QvtpIdmulELWTif6C/50eZbnyaHGTwiZtpR/oYl
kA0M2u5/ALz/ayS+ar09JRc7lq0aV3r8IIbYSPW+Wygmg7m/cSUMJFMyPWExW/IqbIv16Ju16EbP
aQMzUsRbrYJiwv9nuV6okhAGutdtw0pIQ7PCktcooAagK4EUaPuwYfKlmQamaF8geLXz440WmCJs
LGVtiARAMlFlf5zNuM+PvSzKOedLQJem0IX0UhZaag0HLUw3ChhVfMxAzBUeAq9KxWayGnPA0AZZ
Dmxw6ExfVqNWuPMrhIFJL7aMGuegO+NXV8K5LI/ZmnRk2hzZhSGbpCg/dAp5vlu380ZL52bsXeJk
Q0cP3H5FZ6EZTVnFOnRCCKsbJRmwMMl+G3sCQsCG3Fi0JbevpuYbDO5ubjrd9id6XAMe29d8UtyF
gqXgRA4jgZsZIOdIpNUJ0TCCB2owggZSoAMCAQICEy0ABsdWyH4wxYEwyQ4AAAAGx1YwDQYJKoZI
hvcNAQELBQAwgbYxHDAaBgNVBAMME05YUCBFbnRlcnByaXNlIENBIDUxCzAJBgNVBAsMAklUMREw
DwYDVQQKDAhOWFAgQi5WLjESMBAGA1UEBwwJRWluZGhvdmVuMRYwFAYDVQQIDA1Ob29yZC1CcmFi
YW50MRMwEQYKCZImiZPyLGQBGRYDd2JpMRMwEQYKCZImiZPyLGQBGRYDbnhwMRMwEQYKCZImiZPy
LGQBGRYDY29tMQswCQYDVQQGEwJOTDAeFw0yMTA5MjIwMTMwMjVaFw0yMzA5MjIwMTMwMjVaMIGa
MRMwEQYKCZImiZPyLGQBGRYDY29tMRMwEQYKCZImiZPyLGQBGRYDbnhwMRMwEQYKCZImiZPyLGQB
GRYDd2JpMQwwCgYDVQQLEwNOWFAxCzAJBgNVBAsTAkNOMRYwFAYDVQQLEw1NYW5hZ2VkIFVzZXJz
MRMwEQYDVQQLEwpEZXZlbG9wZXJzMREwDwYDVQQDEwhueGExMjkzNzCCASIwDQYJKoZIhvcNAQEB
BQADggEPADCCAQoCggEBAMwIT9TWi+9HbVkhS5COw35vY0wHawaDlhh/xAs9Ooxu8CrHq1fN46+Z
cLTvvDp9FNO/tlxRxZt3CUskxOkAq79LhM2ppYC1nTXsBiBtPoWiG/99xmXQOWEkRi/5PHHSixdC
y9kOOg5EhV0W6pzF/hFBA3uMK9Amq+i0LK5NoCT2FG1gyH0U1tUgpDe2nXKgnMLI7KmvT322nlmE
wqfqklA1FUS2CHhh2ZiL6/rlTlXWaqTezzKulDCOk2sKnz0nLWSv1ZdUW5Qb03SC47OcDFIWjUc8
/z4IN2JFd06fNY2r1c1dIKolev86muTvoH7Sg4jHG13rMCsZLXkMOwJzBSkCAwEAAaOCA4kwggOF
MDwGCSsGAQQBgjcVBwQvMC0GJSsGAQQBgjcVCIWCwH6BjvRVhu2FOILrmUuaklY/g5/dGoWovkUC
AWQCATgwHQYDVR0lBBYwFAYIKwYBBQUHAwQGCCsGAQUFBwMCMA4GA1UdDwEB/wQEAwIHgDAMBgNV
HRMBAf8EAjAAMCcGCSsGAQQBgjcVCgQaMBgwCgYIKwYBBQUHAwQwCgYIKwYBBQUHAwIwQQYDVR0R
BDowOKAiBgorBgEEAYI3FAIDoBQMEmhhaWJvLmNoZW5AbnhwLmNvbYESaGFpYm8uY2hlbkBueHAu
Y29tMB0GA1UdDgQWBBRWbh0tRGFocEkr5ZMgCxTGc8JVuTAfBgNVHSMEGDAWgBRYlWDuTnTvZSKq
ve0ZqSt6jhedBzCCAUYGA1UdHwSCAT0wggE5MIIBNaCCATGgggEthoHIbGRhcDovLy9DTj1OWFAl
MjBFbnRlcnByaXNlJTIwQ0ElMjA1LENOPU5MQU1TUEtJMDAwNSxDTj1DRFAsQ049UHVibGljJTIw
S2V5JTIwU2VydmljZXMsQ049U2VydmljZXMsQ049Q29uZmlndXJhdGlvbixEQz13YmksREM9bnhw
LERDPWNvbT9jZXJ0aWZpY2F0ZVJldm9jYXRpb25MaXN0P2Jhc2U/b2JqZWN0Q2xhc3M9Y1JMRGlz
dHJpYnV0aW9uUG9pbnSGL2h0dHA6Ly9ud3cucGtpLm54cC5jb20vY3JsL05YUEVudGVycHJpc2VD
QTUuY3Jshi9odHRwOi8vd3d3LnBraS5ueHAuY29tL2NybC9OWFBFbnRlcnByaXNlQ0E1LmNybDCC
ARAGCCsGAQUFBwEBBIIBAjCB/zCBuwYIKwYBBQUHMAKGga5sZGFwOi8vL0NOPU5YUCUyMEVudGVy
cHJpc2UlMjBDQSUyMDUsQ049QUlBLENOPVB1YmxpYyUyMEtleSUyMFNlcnZpY2VzLENOPVNlcnZp
Y2VzLENOPUNvbmZpZ3VyYXRpb24sREM9d2JpLERDPW54cCxEQz1jb20/Y0FDZXJ0aWZpY2F0ZT9i
YXNlP29iamVjdENsYXNzPWNlcnRpZmljYXRpb25BdXRob3JpdHkwPwYIKwYBBQUHMAKGM2h0dHA6
Ly9ud3cucGtpLm54cC5jb20vY2VydHMvTlhQLUVudGVycHJpc2UtQ0E1LmNydDANBgkqhkiG9w0B
AQsFAAOCAQEAJpGYHveFzmgLQ4J62fcmPkd4wJ8urL46itMWCgyLBPRARYB9oArCqPd4j0Yl0RmS
F1oNZgVDYQTy2aLoe+YGm23TkdJsTx1ExTxtv+njRnvvlSXMMULlOIt25/Vj+vTZ/wjFDq6PJOSZ
MSQHaVHSUrkLBT1H0pBmCA1Ecjuo7gUpG5T2NqD5KJP083pJZ+nogA9TVC9Ob+jNx0d/UR7UgRLf
KOxBG05AakTa4luadPIRktiULtjzG20WDhvAIg4M9w1+9SV+LpvvqBtkovpCfj9Rf4pNRV1CjjTY
AFIH0s3Q11HnFd1UNHKUvpp7/SrTyxaCXBO68U5aJz4zDjwIPzCCB+swggbToAMCAQICEy0ABsdV
/0AV+3f0TucAAAAGx1UwDQYJKoZIhvcNAQELBQAwgbYxHDAaBgNVBAMME05YUCBFbnRlcnByaXNl
IENBIDUxCzAJBgNVBAsMAklUMREwDwYDVQQKDAhOWFAgQi5WLjESMBAGA1UEBwwJRWluZGhvdmVu
MRYwFAYDVQQIDA1Ob29yZC1CcmFiYW50MRMwEQYKCZImiZPyLGQBGRYDd2JpMRMwEQYKCZImiZPy
LGQBGRYDbnhwMRMwEQYKCZImiZPyLGQBGRYDY29tMQswCQYDVQQGEwJOTDAeFw0yMTA5MjIwMTMw
MTRaFw0yMzA5MjIwMTMwMTRaMIGaMRMwEQYKCZImiZPyLGQBGRYDY29tMRMwEQYKCZImiZPyLGQB
GRYDbnhwMRMwEQYKCZImiZPyLGQBGRYDd2JpMQwwCgYDVQQLEwNOWFAxCzAJBgNVBAsTAkNOMRYw
FAYDVQQLEw1NYW5hZ2VkIFVzZXJzMRMwEQYDVQQLEwpEZXZlbG9wZXJzMREwDwYDVQQDEwhueGEx
MjkzNzCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAL6VTRRCbJgUEuoR2bppNZQc3ghr
l0pDEZjK8uaayFYadelTc6iWe8EBLWrrOWd17yNeXc054yw+Yu8eI1IWMEE/mo5l93Kw+BkuCUda
vpqZUMOvaPDKkHNPBNPJ6AP+vmZW8p/46dxo6Nx6xGzkpbUZ1Ju1a9LuxeFQBNNvV54wYbFmoKJF
eQQ3RZdEafNucOw8ukTyWurcC8fPUQwqE1sFRdtjLeJWZBtrvNim4oikb5UFxcmoaQkJ/sqoJGZL
+bR3ZZx3101+Y7RJp56hfqT1eqkJkc7OTz+tsZx3p1a6r266NCB/RBIGVD2cFmhUs2Uitp/oB+9k
BhycuX8wowECAwEAAaOCBAowggQGMDwGCSsGAQQBgjcVBwQvMC0GJSsGAQQBgjcVCIWCwH6BjvRV
hu2FOILrmUuaklY/heaKboS14X4CAWQCATowEwYDVR0lBAwwCgYIKwYBBQUHAwQwDgYDVR0PAQH/
BAQDAgUgMAwGA1UdEwEB/wQCMAAwGwYJKwYBBAGCNxUKBA4wDDAKBggrBgEFBQcDBDCBlAYJKoZI
hvcNAQkPBIGGMIGDMAsGCWCGSAFlAwQBKjALBglghkgBZQMEAS0wCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBGTALBglghkgBZQMEAQIwCwYJYIZIAWUDBAEFMAoGCCqGSIb3DQMHMAcGBSsOAwIHMA4G
CCqGSIb3DQMCAgIAgDAOBggqhkiG9w0DBAICAgAwQQYDVR0RBDowOKAiBgorBgEEAYI3FAIDoBQM
EmhhaWJvLmNoZW5AbnhwLmNvbYESaGFpYm8uY2hlbkBueHAuY29tMB0GA1UdDgQWBBQY587dMxoS
HzI5SkUyoLrumaVa5jAfBgNVHSMEGDAWgBRYlWDuTnTvZSKqve0ZqSt6jhedBzCCAUYGA1UdHwSC
AT0wggE5MIIBNaCCATGgggEthoHIbGRhcDovLy9DTj1OWFAlMjBFbnRlcnByaXNlJTIwQ0ElMjA1
LENOPU5MQU1TUEtJMDAwNSxDTj1DRFAsQ049UHVibGljJTIwS2V5JTIwU2VydmljZXMsQ049U2Vy
dmljZXMsQ049Q29uZmlndXJhdGlvbixEQz13YmksREM9bnhwLERDPWNvbT9jZXJ0aWZpY2F0ZVJl
dm9jYXRpb25MaXN0P2Jhc2U/b2JqZWN0Q2xhc3M9Y1JMRGlzdHJpYnV0aW9uUG9pbnSGL2h0dHA6
Ly9ud3cucGtpLm54cC5jb20vY3JsL05YUEVudGVycHJpc2VDQTUuY3Jshi9odHRwOi8vd3d3LnBr
aS5ueHAuY29tL2NybC9OWFBFbnRlcnByaXNlQ0E1LmNybDCCARAGCCsGAQUFBwEBBIIBAjCB/zCB
uwYIKwYBBQUHMAKGga5sZGFwOi8vL0NOPU5YUCUyMEVudGVycHJpc2UlMjBDQSUyMDUsQ049QUlB
LENOPVB1YmxpYyUyMEtleSUyMFNlcnZpY2VzLENOPVNlcnZpY2VzLENOPUNvbmZpZ3VyYXRpb24s
REM9d2JpLERDPW54cCxEQz1jb20/Y0FDZXJ0aWZpY2F0ZT9iYXNlP29iamVjdENsYXNzPWNlcnRp
ZmljYXRpb25BdXRob3JpdHkwPwYIKwYBBQUHMAKGM2h0dHA6Ly9ud3cucGtpLm54cC5jb20vY2Vy
dHMvTlhQLUVudGVycHJpc2UtQ0E1LmNydDANBgkqhkiG9w0BAQsFAAOCAQEAsjJuJnMzvA59CAlY
87eQCOafWbMF4HfC4oobtAqboB48BtCZ5dOeo+X4XQRaSmTwFJ2hZjX614KFnRGXLk/nDIY4pp8+
fqfgHKUdY1ceVqs+Kjtabk3gY8zq7PtFUsAkwp4OW23kwphh7Awx1tf3XRZeOqwiVuk5V57GT8Tu
dKNiOZqut3mrcdZINNUsqjt7ZA82r4ov5MbEBHeWVjo7CeWbgZFZhKhMKC9+2DKEUkdDJUcDYqxz
+Rh+6B+dgxeYkTGIqHELhkMjMCC5SwRNHfCxXCI+qRy4zIAo2K3V96zs3ungqiFZuFrpatfSBfAL
d86AIrOgsHhvOB0UU1W//zGCBLMwggSvAgEBMIHOMIG2MRwwGgYDVQQDDBNOWFAgRW50ZXJwcmlz
ZSBDQSA1MQswCQYDVQQLDAJJVDERMA8GA1UECgwITlhQIEIuVi4xEjAQBgNVBAcMCUVpbmRob3Zl
bjEWMBQGA1UECAwNTm9vcmQtQnJhYmFudDETMBEGCgmSJomT8ixkARkWA3diaTETMBEGCgmSJomT
8ixkARkWA254cDETMBEGCgmSJomT8ixkARkWA2NvbTELMAkGA1UEBhMCTkwCEy0ABsdWyH4wxYEw
yQ4AAAAGx1YwCQYFKw4DAhoFAKCCArkwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG
9w0BCQUxDxcNMjExMDI5MTE0MDIzWjAjBgkqhkiG9w0BCQQxFgQUhZBb7lYl8glxxbJ58A372hAa
GjcwgZMGCSqGSIb3DQEJDzGBhTCBgjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAoGCCqGSIb3
DQMHMAsGCWCGSAFlAwQBAjAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwICAUAwBwYFKw4DAhow
CwYJYIZIAWUDBAIDMAsGCWCGSAFlAwQCAjALBglghkgBZQMEAgEwgd8GCSsGAQQBgjcQBDGB0TCB
zjCBtjEcMBoGA1UEAwwTTlhQIEVudGVycHJpc2UgQ0EgNTELMAkGA1UECwwCSVQxETAPBgNVBAoM
CE5YUCBCLlYuMRIwEAYDVQQHDAlFaW5kaG92ZW4xFjAUBgNVBAgMDU5vb3JkLUJyYWJhbnQxEzAR
BgoJkiaJk/IsZAEZFgN3YmkxEzARBgoJkiaJk/IsZAEZFgNueHAxEzARBgoJkiaJk/IsZAEZFgNj
b20xCzAJBgNVBAYTAk5MAhMtAAbHVf9AFft39E7nAAAABsdVMIHhBgsqhkiG9w0BCRACCzGB0aCB
zjCBtjEcMBoGA1UEAwwTTlhQIEVudGVycHJpc2UgQ0EgNTELMAkGA1UECwwCSVQxETAPBgNVBAoM
CE5YUCBCLlYuMRIwEAYDVQQHDAlFaW5kaG92ZW4xFjAUBgNVBAgMDU5vb3JkLUJyYWJhbnQxEzAR
BgoJkiaJk/IsZAEZFgN3YmkxEzARBgoJkiaJk/IsZAEZFgNueHAxEzARBgoJkiaJk/IsZAEZFgNj
b20xCzAJBgNVBAYTAk5MAhMtAAbHVf9AFft39E7nAAAABsdVMA0GCSqGSIb3DQEBAQUABIIBADmn
fjYZgSzwSzFemv6qJLO9WLFglaWskMzrT/KYToUiIa3lkyUSXV93rvAKkF2p4PdittrBFSle/6y3
TQouUPbg9e2Qf0d1Scr4b5M6bZVB7u60Y+oHQNBjGTnr1cO+ldnDfFTaMmMcQzElmliUpm5a23iW
QSS1Agor+uRjDeRJYPo8wXhW7um/LWdf+3FkmTlOjJEp/CvAtRRaC9wmuE0K26TK14QXyWuf4wwU
+/plg7yj9795RO/igFNjLKlcckKmsi30A6h50sxKU4Iq9jmdKuit8WDStqNjiWdouCNiRuJQoY53
g2zWwBO5HSIZwr5D0IWPAsQT7uIqkYIpta0AAAAAAAA=

------=_NextPart_000_004E_01D7CCFC.D08263B0--
