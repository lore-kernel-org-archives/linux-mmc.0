Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E511EC433FE
	for <linux-mmc@archiver.kernel.org>; Thu,  6 Oct 2022 07:03:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbiJFHDv (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 6 Oct 2022 03:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbiJFHDt (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 6 Oct 2022 03:03:49 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173E98C46D
        for <linux-mmc@vger.kernel.org>; Thu,  6 Oct 2022 00:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1665039829; x=1696575829;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+fkA5tcF/BDfR8gfwyLKQlldb7xrtt+ltI04hq/Aw6M=;
  b=SsN1MozLiQ1DZtCTIetPo1OlEOk1iP70uTt+dXqQGF/b7IRgmin04D+u
   L0k3s1LWq/e8FzGYfFQMpfRcgLckqEfQXBUYyAVlCEBdZo8379WH3cVXy
   PYFBQdEZ9/iiGd3PSL2NBURwKkuvOAXWY+YrqOAXCegN/kP1yqGPuur8U
   eMk7RGFf+G7y7TDt43klwo4n9eBBYQ65UtITKUp1GF8/fjQ/SgVlh5k63
   Wi/RUzU8SQ3aR5sYzCcrzuDP7f9Uxkr+maDPBHiTQe4RQRGM6fdD5xH/k
   jWbF8IRVZw3JcSzKN2GmTkX/clhK1Yd6NsDIqzdUd+CpO3OGDX/aT+MhL
   A==;
X-IronPort-AV: E=Sophos;i="5.95,163,1661788800"; 
   d="scan'208";a="211459696"
Received: from mail-bn1nam07lp2048.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.48])
  by ob1.hgst.iphmx.com with ESMTP; 06 Oct 2022 15:03:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LbtlijHtMHCvLWI0VF29heL5CyjeHIQB0b09m2buu6lWKNQBgobTMMAkKMo+pMLPKSXZpIaaRINHUBCHXcznr3Zz4sh6atP4JsPpabAuCF7uRGSLHjJV0oT1J/PQH9b7HQHohUXRYGlXULqbgWfZDSkE2yYXE0g892IoxNN0o308wzcPcgb2J5Sp9NhIaSQ1s6dtxluKvX8g9qxkdbYI3CP24x47zgJOCvez5DWiASzru5s+SQ651AE0dKQRHtmwvWjxaIjQPEGJiYXh8Ln3Zs5RYdCDlLUZksZ9rpP6SOb4vbF+FxUO0noFePSy3KGQY087pI6mEShqQS3N+HFWQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bbag4//q1qN9UQ1h9G5TgbVcivQUzWtPTpp9NuZ69ps=;
 b=E4FB02IiMYsHpQ1pwoGvuz9wUd6i1XfVE/nkh/m113rO65Rx/woOcxhhKOeZTK61ahlcE7ncI7p6sKa7GSvQHHTR3l6xS7lIJ19fjZ3D2mEibZJoeaHoQThsNYXEIucg/OQVvU0pklc3yZRt9vErgXahKb0wdvVpMGJCnT+5RJaWK/F5i9Od9QSV10wFvKf/kVAF0h4J3+7cJgUgn2N7jE+YXGDuJgN3JzGyDgEmw9BUEYXtF/f1lgv0P+tOVWzjyWht4BrclHdoI+Xb3/HtZAj+/Bgig4Pr1iwIFkRwlCp0rizl2tejwsLGQ4GKkcx/qZhcvoaPx5BwL2B98ML/7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bbag4//q1qN9UQ1h9G5TgbVcivQUzWtPTpp9NuZ69ps=;
 b=KgolQ/Y1a3VUE4fIkgeXroFYyLhe7rACKc/YELmG62Orw+F3Hb6XfaXy7isdfkPaJiSe+88FrOkrANPdXSdtHxbtKq4pPNecQms4htVtjRRfyDAHQzwnZywz04BdxYxaOb/l+drWIfzqJZsVfzniwV5Us8DbGVuW9SosHUi+UFc=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 BN6PR04MB1125.namprd04.prod.outlook.com (2603:10b6:404:94::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.28; Thu, 6 Oct 2022 07:03:46 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::2503:ada1:dcf6:8ae1]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::2503:ada1:dcf6:8ae1%6]) with mapi id 15.20.5676.034; Thu, 6 Oct 2022
 07:03:46 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC:     Stefan Wahren <stefan.wahren@i2se.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Alex Dubov <oakad@yahoo.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: RE: [PATCH 03/14] mmc: sdhci: Replace kmap_atomic() with
 kmap_local_page()
Thread-Topic: [PATCH 03/14] mmc: sdhci: Replace kmap_atomic() with
 kmap_local_page()
Thread-Index: AQHY2KQci0FgJe0COU+dvYwmkgcQ8K4A8ZQQ
Date:   Thu, 6 Oct 2022 07:03:45 +0000
Message-ID: <DM6PR04MB6575FDD9B40D5EE3C9239822FC5C9@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20221005101951.3165-1-adrian.hunter@intel.com>
 <20221005101951.3165-4-adrian.hunter@intel.com>
In-Reply-To: <20221005101951.3165-4-adrian.hunter@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|BN6PR04MB1125:EE_
x-ms-office365-filtering-correlation-id: 67fe1a4a-8848-4346-e882-08daa768e968
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jCCvpeTLKuNDvrzVvLnaiNCjrbfAhtErHH7wwGK7A1wXvBpPzxm3n/CEnOJzjgvwxAcCpVQrHRo9SMZhj8ZWGlzMFvMK5U/YbZFIR7a92x5peM5mjcT7KzUkydV1X+xZHOlcmmuyXp/t3EDAIhMIY90EZ0YERjaL1QhMPULIZzl75QaX7Lxyn7yVGdA2kU459FOrxj8CIiHG2QmbFCkhrbQIqDBl2wz6amxqixVHxutU/LK3xcCsKaiJi2BWIlBGQHR/yoOydKWv5pusXjh2A4BziVotqTNhVe4GkprWdGoRXyRIYYtqs4jn2e0NwsJka1CFF+mBRDIF7MByx3hQcICO8mMLF3DV9cNoZPFNTZ/kcv+2VjrWQK9ahgBPXN0rhkaJWy2204T22gY3VHUJFX8847oezokDV9zqbarnAokpFgUkagDGaURA7LEI83pwmOVBh9/0NLxOWXOmK5LBkGCSDyg26kjgyfaXdnvahNX3qAigJUqYHfrXTPgaETC3XDRrKXBxyEzOAxeFNjKUYFx+yflprEqEFzWBiVERBlWSB8ocOQNUffQdn4WXxLYV/wVF2KWk9DJqt0gpoO9oyy2k9llyX04ypmwhWyVYVaLZGjYDIfCH248Leg+4B7n3mnU9CvUuJISUbsLkUsDb13EkPatr6uKSxKVA4z8WVKJIXSrbPwcCvkyKjCI8dn6nbiA+vULp2el0aW1+VkvX2KZFpQL8oMuAsdahjfjLny6ysnbL9cVcSEoC51VhqMw7QpSFwJk+naciqMYRb9jKxA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(346002)(376002)(39860400002)(396003)(451199015)(83380400001)(478600001)(71200400001)(54906003)(110136005)(7696005)(6506007)(64756008)(4326008)(33656002)(9686003)(41300700001)(66446008)(26005)(8676002)(5660300002)(66476007)(66556008)(8936002)(66946007)(76116006)(52536014)(55016003)(86362001)(2906002)(122000001)(186003)(316002)(38070700005)(38100700002)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3O6Wdo1hqK8qmej+1VzsY1I4SzJaqAUUGPqGNIRtkXppmR23sF3xJV9yR/3Q?=
 =?us-ascii?Q?QXFzMUbKlS+BbnySi7DUueFCg1JKhQ6L+hy7yrSwrNMbubOP3WYSb6K+bLz6?=
 =?us-ascii?Q?GbtkP2mac71roXF+Kl3s5kNaIGMWU3tzX8P6/LVCE8IXWcVo766tEJwjK1ly?=
 =?us-ascii?Q?xiTG9XLeuYLs/1bfCR5shRfmULowyTj/9wjrq27hMl0B1uJjFPmqvDaiPHLG?=
 =?us-ascii?Q?zv8dXFYHNDRfSDKyjbnYesl5FFbd3z4sizoCIBP1s+oP6ya+V/a40OK3pnEw?=
 =?us-ascii?Q?MMMNUPt1T/eaHd3+cZgo+jcxCSSZDDiooQ3wOLsDrlg54i0PckXR3XHz/AOG?=
 =?us-ascii?Q?foaec0gtfNkyTztrNsgRUnuVMVca4X709bMlZiELv4/FTzsSUvtHA0XaZ1j/?=
 =?us-ascii?Q?UaeOTxS4lXDBc9FSIk04wiWcO9hI/4wVAr3WCJdSU8XsnzACv6LqX6H9WLuj?=
 =?us-ascii?Q?oNwlUYstMPVR7FBu6mwxa9iyYF+us2+mn/aYu0ACoUmwQVFQ4vnBpYvKjfro?=
 =?us-ascii?Q?LpWZ1EYYsfn0DyYnxj6rQzglQEAQbZKyZUQX+3QTExA4Ki3Ax5I7hZ6uLWmq?=
 =?us-ascii?Q?6FE/ag+y+0679d9OPetfCitzJTesXh28MKQIWUKy7cbt2DmZwEqAd3FP4rC2?=
 =?us-ascii?Q?kHrUloGMsugIwqPXehv403DZP8xCYj/EjoKGgxDQ6El1kBDZdkx/tNyO+iVQ?=
 =?us-ascii?Q?RmBBUz/XsQe2pg4GpNE69EzHQVRCkC4HCkkpSfxWbtBfok0GMIz4ghb1iTYS?=
 =?us-ascii?Q?867/ykBvxqG+JaaEzPXF38UrBiSmIpjGQ+hyrs42HHFhMQH8k0ppRnpAK9I2?=
 =?us-ascii?Q?O2KzNOSDeglOEqaRx4MvVIAAyELqwYJ23Lvqe/40hBW4OKQqJt9PlFgi3GBT?=
 =?us-ascii?Q?A5orzFnOaj4ItNBGD0tN5Gr8Py+LM6yiU0BqRQq1FpwsnDM+rn/UeY33HTD2?=
 =?us-ascii?Q?kkj13J/At4OjZn1drq5sX57hr/rOyH7jg8DF2wLNK0doDPjIPl+fg/UeCpYV?=
 =?us-ascii?Q?yzLnbYV2n7CucmGKSj0PZ6SVdUDM8P1qi8E9EuX/DsRb0LKukGPZnb+OkXsY?=
 =?us-ascii?Q?P+ek7S9oV2EFKddfN6dA/5c4JXq2WWzmMMqvgXLTINOTMa/AkjDRa1CCmrBC?=
 =?us-ascii?Q?LwL/mUJYQLmlGtBC68iBX68xAz339gF10JeBTpSO6KV3Ppdo15T1Vm/Ub2Kq?=
 =?us-ascii?Q?wj8RQQ3pfqTP182E42kbh6t0PIxcE1eRARf8VstODHY9XgM4NE47D+0liQu4?=
 =?us-ascii?Q?C2bO9KGJSrbl13DJFVr+CSPGINLxs1fYlB4l/hvYI0phrn+o5aVHXQL8FxsT?=
 =?us-ascii?Q?gkqHKLoo8MlBWXJhUoffxeYaYMzEijeCCyr2XXS+TReZerL9QUSRtS7G9fom?=
 =?us-ascii?Q?bKnnyCGuaTXTnaUBtUT8xVrswWRcCWRIF7HSRcJmpTID064ZHIJjiE8lNPQ1?=
 =?us-ascii?Q?9NJ3usOzrU6CIaegvO6ey8DpFLMpbqb0MyYdfRO7RM2E+AA04sgAXVOkPwpZ?=
 =?us-ascii?Q?3Je8DnftZzu0Qsie6fACzuKKM50+Yf2G06uAQrxmMbQjYBmrvRdwuUDPGZjL?=
 =?us-ascii?Q?Dh7nogprdYGleFzBpn97Av2w8IOlloa3DHpbF3va?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?VyHGo7m3G6FjH5JbDNR3lM9dnJEggFgGSWGRPbhxhY+ZDXX4+FLiSNdn0zWf?=
 =?us-ascii?Q?PZclbHfpP9TpGhwRuAC29+QijqQ0h68kih1CrXKBqvXGN11cVfPvktLG8hHY?=
 =?us-ascii?Q?hZHQ05ifdoBk2JAxAGyEMUS4NYHDQXPhrD9HNK/Vx0YFnCVqYa1ZoJr5JYiJ?=
 =?us-ascii?Q?1B97JiWDp26DHRsUeGeWibBSJXKHHQ1cv28ds5GKb3QdJtPlX1SWpLtNWPJ7?=
 =?us-ascii?Q?flMrWeof7kqOJYW0oEyiIVrMVb0/7miWqhfe8qwVN3/jmUMZFKOfhnZ0QPMi?=
 =?us-ascii?Q?tREyqh70mpVNINbUpCFpKykHb/iJgbTiT1u7wmVzXzlo92FYF9RR3GuEdMm/?=
 =?us-ascii?Q?tRJsQ+BxYYy7Ia7YlkncEw6Wmk/nyyxDfT8PtcEnM7nJp6tBgaNAPjU17U/N?=
 =?us-ascii?Q?ovnISmx7ihE9gSlWM8SqN6dWhCnCRfLBuX+sPSWi6mnXYk/T/yE6LUU7Gv4F?=
 =?us-ascii?Q?wEad8gWVzYiLjk6ePQCLY0nd2m7c7ZYNxHztVGSPy7ENOo9btiK3GviIfomY?=
 =?us-ascii?Q?VsHFjH7FxZq9NWs0DMyFd86Xam1FSskitNeIEkQWHvvDmDj58vxL9AbDDoM9?=
 =?us-ascii?Q?X0aXFoLS+6prAyMz0+LrkKTsAl6zMCiJoLAz5gZ33HVeg2ZYnMv+zV7jLIpI?=
 =?us-ascii?Q?0CNmcM4vdvs42EeWx7nXaQs2c14nBi4nuenbm+n9oTBwKdcVEW+Ohxz+OOmD?=
 =?us-ascii?Q?t+NYkX42GO3aaOp6v1sE2P1m/rRiMfcqKfsGpGTiFEOTN3MeEk1dvGoaMMaX?=
 =?us-ascii?Q?22GNyVgU0eFBhFqIRa9Tm6UjPwmW2je2J580YkdaytbooCOml2srWVKohnCf?=
 =?us-ascii?Q?YPbxX9+r1kI3oFSQSpHbizrbRSEVXnHfXxP4lyNmYQuRbJk5nlsEOI5Mlf9o?=
 =?us-ascii?Q?x02f4mfEfUPxSMeSfPu7T1OKshw+Aa4PlngbUm3wO70QwUAwl6RtiQg+Zt1/?=
 =?us-ascii?Q?k2Orx+tOP2wDsqlEwKZzx+JPJqrynXmIY9QL4T1Upbx52IMD/B0GwgKfeiOb?=
 =?us-ascii?Q?gfIi?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67fe1a4a-8848-4346-e882-08daa768e968
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2022 07:03:46.0438
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8+KC2x1YyCMaX1vSsussXyQWpZS0j64HmpJlvYGKsu9xWGeXOcm6Ahxw/7q0S5tqmrLLcaqddQwftCbjRLa+8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR04MB1125
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

> kmap_local_page() is equivalent to kmap_atomic() except that it does not
> disable page faults or preemption. Where possible kmap_local_page() is
> preferred to kmap_atomic() - refer kernel highmem documentation.
>=20
> In this case, there is no need to disable page faults or preemption, so r=
eplace
> kmap_atomic() with kmap_local_page(), and, correspondingly,
> kunmap_atomic() with kunmap_local().
>=20
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  drivers/mmc/host/sdhci.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c index
> 31d87ec7d055..fb6e9a81f198 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -697,12 +697,12 @@ static int sdhci_pre_dma_transfer(struct sdhci_host
> *host,
>=20
>  static char *sdhci_kmap_atomic(struct scatterlist *sg)  {
> -       return kmap_atomic(sg_page(sg)) + sg->offset;
> +       return kmap_local_page(sg_page(sg)) + sg->offset;
>  }
>=20
>  static void sdhci_kunmap_atomic(void *buffer)  {
> -       kunmap_atomic(buffer);
> +       kunmap_local(buffer);
kmap_local_page documentation, indicates that the unmapping should be done =
in reverse order.
Isn't it something that the callers of sdhci_kunmap_atomic now needs to att=
end?

Thanks,
Avri

>  }
>=20
>  void sdhci_adma_write_desc(struct sdhci_host *host, void **desc,
> --
> 2.25.1

