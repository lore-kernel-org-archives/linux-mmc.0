Return-Path: <SRS0=G9E5=7V=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8CBCC433E1
	for <linux-mmc@archiver.kernel.org>; Mon,  8 Jun 2020 08:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B71CB2078D
	for <linux-mmc@archiver.kernel.org>; Mon,  8 Jun 2020 08:58:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="zs5ghiCs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729178AbgFHI6a (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 8 Jun 2020 04:58:30 -0400
Received: from mga12.intel.com ([192.55.52.136]:14107 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729153AbgFHI6a (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 8 Jun 2020 04:58:30 -0400
IronPort-SDR: k3x/0ZLFYrXXqat4OPm5cKq3eVUlgPOPPI9O11OvoHvVXAEEIADTkROmVv7u2ziyuOMFoLqx5e
 qq5bxxgQj2dQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2020 01:58:13 -0700
IronPort-SDR: PZkNplM7S1Bhc/NKEXXpXUJUFbkYB+fRrrIIbCbZYXon5fLAN6va3ZDSoRPHp+7QsAeJn07k0c
 8noHLoOEVZBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,487,1583222400"; 
   d="scan'208";a="258637884"
Received: from orsmsx105.amr.corp.intel.com ([10.22.225.132])
  by fmsmga007.fm.intel.com with ESMTP; 08 Jun 2020 01:58:13 -0700
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 ORSMSX105.amr.corp.intel.com (10.22.225.132) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 8 Jun 2020 01:58:13 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 8 Jun 2020 01:58:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jYxAkVFryh1QZ1+DW1fLQl/pZH8VJpijUtZFFCz9O1kXxxWWlYGADmJp+KdjPnVxZOiWo55Qb1bXeZF3gV6f5Uv06K3BZkbh+feaiToxIw/X7LyxSO87OxAk5CCza7xb+pVMswMwuzGMrh4YrKMrUsmePk6hzPbyvXIPY4FwjfmXqIICbL0w3W+yQUOonBbIbmQrS752DR7Uj8o09iJipW84to4drwvnEzkMBHNnquYhiP4fFjMEiVpOaPjgE3nGs1nMVoJ4LCiOk7BcfIyZf1nv64iH9WiP25u3whluEFsZwVz6puwRJL6la05612GZKYoWigcEgeAYbcnVJLQjxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PcC/NVyTtuiBS1XmwhWxWA+ygS7NicI31sEBOrkI/ro=;
 b=RTfmIgblr4wLHmHYWJOcyMXJdJPVvfYGn/lBC8A1K9vIxvS/d0f+gjRyYb3p6XWJlNByamIND1lne9DLMa6F4GUbWOgnkpvgFpyBA9uFb/Zv5+TbEZBANx58ttPm1uTvh+tw37w3JxsqITah+t3cTyUcVY1cd9/xzt3mbVp5pGnHSz7rn62ywGG/gN7gidRpPsLd2DNvrZRZWc43HhYqsLvad6IbShhuNDmNQIJWJSm3/ntOMGkMJin81OnQN1LRL+iGyI3M9UGGzlEIQgEFMD1fkMSgQm7Tlhm76h3qlVVQnc52ye7m4k2GD2ficAiRp19zygG61VnRPc0T43mu4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PcC/NVyTtuiBS1XmwhWxWA+ygS7NicI31sEBOrkI/ro=;
 b=zs5ghiCstUKtU0plD060WUTlVLpFukktr4AmTkgAl0GHZ2xSugO6BePD5UkPLnf6cUIzXQdXUCu6cJhGoppDClm+aCsFiVz4HvcbJpPsBKD4AIPjqrl+Tlaf66WpUNAa/5KgoBavbiDx9HRQ7NDsrSQQCwW20SY3EsQqcKBlyT0=
Received: from DM6PR11MB3721.namprd11.prod.outlook.com (2603:10b6:5:142::10)
 by DM6PR11MB3851.namprd11.prod.outlook.com (2603:10b6:5:146::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.20; Mon, 8 Jun
 2020 08:58:10 +0000
Received: from DM6PR11MB3721.namprd11.prod.outlook.com
 ([fe80::b0cf:aaa:bc78:e0cc]) by DM6PR11MB3721.namprd11.prod.outlook.com
 ([fe80::b0cf:aaa:bc78:e0cc%4]) with mapi id 15.20.3066.023; Mon, 8 Jun 2020
 08:58:10 +0000
From:   "Wan Mohamad, Wan Ahmad Zainie" 
        <wan.ahmad.zainie.wan.mohamad@intel.com>
To:     Rob Herring <robh@kernel.org>
CC:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "Hunter, Adrian" <adrian.hunter@intel.com>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v2 3/3] dt-bindings: mmc: convert arasan sdhci bindings to
 yaml
Thread-Topic: [PATCH v2 3/3] dt-bindings: mmc: convert arasan sdhci bindings
 to yaml
Thread-Index: AQHWMycZ5ATYyO8XsUihaRPx3GJHiai/VhOAgA8gPsA=
Date:   Mon, 8 Jun 2020 08:58:10 +0000
Message-ID: <DM6PR11MB37213C7CFFA95C4BCFEAA3ABDD850@DM6PR11MB3721.namprd11.prod.outlook.com>
References: <20200526062758.17642-1-wan.ahmad.zainie.wan.mohamad@intel.com>
 <20200526062758.17642-4-wan.ahmad.zainie.wan.mohamad@intel.com>
 <20200529172547.GA2594494@bogus>
In-Reply-To: <20200529172547.GA2594494@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.2.0.6
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.218]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3f073678-b2f5-46e7-41d3-08d80b8a11f2
x-ms-traffictypediagnostic: DM6PR11MB3851:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB38517066CD5D3613009649DBDD850@DM6PR11MB3851.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 042857DBB5
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wJ0BuAKFfCF3v7qs9FxSlO2PswrMPiXA7CU5KRRCAV3lPZujPwDgAofRe4uZ2hY0sESIILRq2QbW3RoxWxfaeV8UWXonjoFJXEMeJ+em6EaYwJIJhp1wcnS3Ck6hhIGcD7wIYvUS7V7el/nTIsXF0UojbFl36shEk48KLiTOnfg6iADLGvHYrENcNgQ3Fj/iklPw+LuCa4WGd4GJPMdW4+XVETWOn9Th98aoC+TDnK0fIoiQHz4PlKIbFxf7r5BwqVdOu/Hv/1OfioXmqTScFwo3/dhi+CYI0V/S/sCgirPDaHpY6OIp3G+JOVKeULi6Jry6LBZsni7PCF/9Cc32R+SuG6J3tfmz1sa23YXWD0p5euiOz2nAfsidfvgF9lb1P5h1sfbxHZIra2JJc5pDGA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3721.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(366004)(136003)(396003)(346002)(376002)(5660300002)(7696005)(8936002)(2906002)(316002)(8676002)(30864003)(52536014)(86362001)(33656002)(54906003)(26005)(186003)(4326008)(6506007)(53546011)(66446008)(76116006)(66476007)(64756008)(66946007)(6916009)(66556008)(478600001)(71200400001)(83380400001)(55016002)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: jd28L0tSTuYVP5Yiuf+8/X7xBS7g1PwXmPGSKYzPebipvXMhSRvRY5mkJvq8m8PC5Zmy87B5NVaRXYir26KJ5KNrYNq91VdnRnc0gvlAOeNyxJdghQd0GplP4LdHXB10QBY+TGD7/6HHW2ElSEJZiiU6E/rU0Ho6ZbFcDMhIbTWx0dlbbLMFPSk+oS+b9TWXBiBrgmjQWt8zdqwBpiI+AxhctDFPgPyKoA96al2b3f5gvKyPMgsQF//dhuNJzKP4MScH7jT4TxnAA9SkJyrf+xeWC52tvEvhMeXSY2AmUtm6tnIQfpo8xUcGwB9aJMcL0HCFaRypd1tAPj2ed7W5exmmViW13c/G7Kkv857vdMFpqJEnRQvfkyFk3XT20yPBGklIv7oFh/bX6T2cGFEoUI3C4vu7bsTCcifjYtWZsfnWnoRhqcwwGLSd8CrE9wdOJ/0Od4C4YiEYYmUn8JJ6/KusBBs13cVtXANjhP17CQeXmOwYqVNU2XGsEd/7kcRm
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f073678-b2f5-46e7-41d3-08d80b8a11f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2020 08:58:10.5897
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DH54rVsD6jt/dXNrbJBaJsYNHNQXCeh3mVJJTAxuPhQ6tpCO+1F4oS9S1BB8FrzKyA7Deknzl5PcvvkSEU3nVcy5ydhp5zrVhaT+PHC3onH9hFI6eAX7PnUYN41s0oSP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3851
X-OriginatorOrg: intel.com
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org



> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Saturday, May 30, 2020 1:26 AM
> To: Wan Mohamad, Wan Ahmad Zainie
> <wan.ahmad.zainie.wan.mohamad@intel.com>
> Cc: ulf.hansson@linaro.org; Hunter, Adrian <adrian.hunter@intel.com>;
> michal.simek@xilinx.com; linux-mmc@vger.kernel.org;
> devicetree@vger.kernel.org
> Subject: Re: [PATCH v2 3/3] dt-bindings: mmc: convert arasan sdhci bindin=
gs
> to yaml
>=20
> On Tue, May 26, 2020 at 02:27:58PM +0800, Wan Ahmad Zainie wrote:
> > Convert arasan,sdhci.txt file to yaml. The new file arasan,sdhci.yaml
> > will inherit properties from mmc-controller.yaml. 'sdhci' is no longer
> > a valid name for node and should be changed to 'mmc'.
> >
> > Suggested-by: Ulf Hansson <ulf.hansson@linaro.org>
> > Signed-off-by: Wan Ahmad Zainie
> <wan.ahmad.zainie.wan.mohamad@intel.com>
> > ---
> >  .../devicetree/bindings/mmc/arasan,sdhci.txt  | 192 ------------
> >  .../devicetree/bindings/mmc/arasan,sdhci.yaml | 293
> ++++++++++++++++++
> >  2 files changed, 293 insertions(+), 192 deletions(-)
> >  delete mode 100644
> Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> >  create mode 100644
> Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
>=20
>=20
> > diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
> b/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
> > new file mode 100644
> > index 000000000000..927e2f13958b
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
> > @@ -0,0 +1,293 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: "http://devicetree.org/schemas/mmc/arasan,sdhci.yaml#"
> > +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> > +
> > +title: Device Tree Bindings for the Arasan SDHCI Controller
> > +
> > +allOf:
> > +  - $ref: "mmc-controller.yaml#"
> > +
> > +maintainers:
> > +  - Adrian Hunter <adrian.hunter@intel.com>
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - const: arasan,sdhci-8.9a                # generic Arasan SDHCI=
 8.9a PHY
> > +      - const: arasan,sdhci-4.9a                # generic Arasan SDHCI=
 4.9a PHY
> > +      - const: arasan,sdhci-5.1                 # generic Arasan SDHCI=
 5.1 PHY
> > +      - items:
> > +          - const: rockchip,rk3399-sdhci-5.1    # rk3399 eMMC PHY
> > +          - const: arasan,sdhci-5.1
> > +        description: |
>=20
> Can drop '|' as formatting isn't important.

I will drop in v3.

>=20
> > +          For this device it is strongly suggested to include
> > +          arasan,soc-ctl-syscon.
> > +      - items:
> > +          - const: xlnx,zynqmp-8.9a             # ZynqMP SDHCI 8.9a PH=
Y
> > +          - const: arasan,sdhci-8.9a
> > +        description: |
> > +          For this device it is strongly suggested to include
> > +          clock-output-names and '#clock-cells'.
>=20
> Sounds like a constraint. It's either optional or required though. There
> is no suggested.
>=20
> > +      - items:
> > +          - const: xlnx,versal-8.9a             # Versal SDHCI 8.9a PH=
Y
> > +          - const: arasan,sdhci-8.9a
> > +        description: |
> > +          For this device it is strongly suggested to include
> > +          clock-output-names and '#clock-cells'.
> > +      - items:
> > +          - const: intel,lgm-sdhci-5.1-emmc     # Intel LGM eMMC PHY
> > +          - const: arasan,sdhci-5.1
> > +        description: |
> > +          For this device it is strongly suggested to include
> > +          arasan,soc-ctl-syscon.
> > +      - items:
> > +          - const: intel,lgm-sdhci-5.1-sdxc     # Intel LGM SDXC PHY
> > +          - const: arasan,sdhci-5.1
> > +        description: |
> > +          For this device it is strongly suggested to include
> > +          arasan,soc-ctl-syscon.
> > +      - items:
> > +          - const: intel,keembay-sdhci-5.1-emmc # Intel Keem Bay eMMC =
PHY
> > +          - const: arasan,sdhci-5.1
> > +        description: |
> > +          For this device it is strongly suggested to include
> > +          arasan,soc-ctl-syscon.
> > +      - const: intel,keembay-sdhci-5.1-sd       # Intel Keem Bay SD co=
ntroller
> > +        description: |
> > +          For this device it is strongly suggested to include
> > +          arasan,soc-ctl-syscon.
> > +      - const: intel,keembay-sdhci-5.1-sdio     # Intel Keem Bay SDIO
> controller
> > +        description: |
> > +          For this device it is strongly suggested to include
> > +          arasan,soc-ctl-syscon.
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    minItems: 2
> > +    maxItems: 3
> > +
> > +  clock-names:
> > +    minItems: 2
> > +    items:
> > +      - const: clk_xin
> > +      - const: clk_ahb
> > +      - const: gate
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  phys:
> > +    maxItems: 1
> > +
> > +  phy-names:
> > +    const: phy_arasan
> > +
> > +  arasan,soc-ctl-syscon:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description: |
> > +      A phandle to a syscon device (see ../mfd/syscon.txt) used to acc=
ess
> > +      core corecfg registers. Offsets of registers in this syscon are
> > +      determined based on the main compatible string for the device.
> > +
> > +  clock-output-names:
> > +    description: |
> > +      If specified, this will be the name of the card clock which will
> > +      be exposed by this device. Required if '#clock-cells' is specifi=
ed.
>=20
> The last sentence can be a 'dependencies' schema.

I will add this in dependencies schema in v3.

>=20
> Are there defined names for this?

From the source code, only xlnx,... uses constant names i.e. clk_in_sd0 and
clk_in_sd1. For the rest, any name can be used.

>=20
> > +
> > +  '#clock-cells':
> > +    enum: [0, 1]
> > +    description: |
> > +      With this property in place we will export one or two clocks
> > +      representing the Card Clock. These clocks are expected to be
> > +      consumed by our PHY.
> > +
> > +  xlnx,fails-without-test-cd:
> > +    $ref: /schemas/types.yaml#/definitions/flag
> > +    description: |
> > +      When present, the controller doesn't work when the CD line is no=
t
> > +      connected properly, and the line is not connected properly.
> > +      Test mode can be used to force the controller to function.
> > +
> > +  xlnx,int-clock-stable-broken:
> > +    $ref: /schemas/types.yaml#/definitions/flag
> > +    description: |
> > +      When present, the controller always reports that the internal cl=
ock
> > +      is stable even when it is not.
> > +
> > +  xlnx,mio-bank:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description: |
> > +      When specified, this will indicate the MIO bank number in which
> > +      the command and data lines are configured. If not specified, dri=
ver
> > +      will assume this as 0.
>=20
> default: 0

I will add in v3.

>=20
> Is there a range of valid values?

From the source code, the valid value is 0 and 2.
I will add enum: [0, 2] in v3.

>=20
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - clocks
> > +  - clock-names
> > +
> > +if:
> > +  properties:
> > +    compatible:
> > +      contains:
> > +        const: arasan,sdhci-5.1
> > +then:
> > +  required:
> > +    - phys
> > +    - phy-names
>=20
> Add: unevaluatedProperties: false

I will add in v3.

>=20
> > +
> > +examples:
> > +  - |
> > +    mmc@e0100000 {
> > +          compatible =3D "arasan,sdhci-8.9a";
> > +          reg =3D <0xe0100000 0x1000>;
> > +          clock-names =3D "clk_xin", "clk_ahb";
> > +          clocks =3D <&clkc 21>, <&clkc 32>;
> > +          interrupt-parent =3D <&gic>;
> > +          interrupts =3D <0 24 4>;
> > +    };
> > +
> > +  - |
> > +    mmc@e2800000 {
> > +          compatible =3D "arasan,sdhci-5.1";
> > +          reg =3D <0xe2800000 0x1000>;
> > +          clock-names =3D "clk_xin", "clk_ahb";
> > +          clocks =3D <&cru 8>, <&cru 18>;
> > +          interrupt-parent =3D <&gic>;
> > +          interrupts =3D <0 24 4>;
> > +          phys =3D <&emmc_phy>;
> > +          phy-names =3D "phy_arasan";
> > +    };
> > +
> > +  - |
> > +    #include <dt-bindings/clock/rk3399-cru.h>
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +    mmc@fe330000 {
> > +          compatible =3D "rockchip,rk3399-sdhci-5.1", "arasan,sdhci-5.=
1";
> > +          reg =3D <0x0 0xfe330000 0x0 0x10000>;
>=20
> Examples default to a single cell each for size and address.

I will modify in v3.

>=20
> > +          interrupts =3D <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
> > +          clocks =3D <&cru SCLK_EMMC>, <&cru ACLK_EMMC>;
> > +          clock-names =3D "clk_xin", "clk_ahb";
> > +          arasan,soc-ctl-syscon =3D <&grf>;
> > +          assigned-clocks =3D <&cru SCLK_EMMC>;
> > +          assigned-clock-rates =3D <200000000>;
> > +          clock-output-names =3D "emmc_cardclock";
> > +          phys =3D <&emmc_phy>;
> > +          phy-names =3D "phy_arasan";
> > +          #clock-cells =3D <0>;
> > +    };
> > +
> > +  - |
> > +    mmc@ff160000 {
> > +          compatible =3D "xlnx,zynqmp-8.9a", "arasan,sdhci-8.9a";
> > +          interrupt-parent =3D <&gic>;
> > +          interrupts =3D <0 48 4>;
> > +          reg =3D <0x0 0xff160000 0x0 0x1000>;
>=20
> Same here.
>=20
> > +          clocks =3D <&clk200>, <&clk200>;
> > +          clock-names =3D "clk_xin", "clk_ahb";
> > +          clock-output-names =3D "clk_out_sd0", "clk_in_sd0";
> > +          #clock-cells =3D <1>;
> > +          clk-phase-sd-hs =3D <63 72>;
> > +    };
> > +
> > +  - |
> > +    mmc@f1040000 {
> > +          compatible =3D "xlnx,versal-8.9a", "arasan,sdhci-8.9a";
> > +          interrupt-parent =3D <&gic>;
> > +          interrupts =3D <0 126 4>;
> > +          reg =3D <0x0 0xf1040000 0x0 0x10000>;
> > +          clocks =3D <&clk200>, <&clk200>;
> > +          clock-names =3D "clk_xin", "clk_ahb";
> > +          clock-output-names =3D "clk_out_sd0", "clk_in_sd0";
> > +          #clock-cells =3D <1>;
> > +          clk-phase-sd-hs =3D <132>, <60>;
> > +    };
> > +
> > +  - |
> > +    #define LGM_CLK_EMMC5
> > +    #define LGM_CLK_NGI
> > +    #define LGM_GCLK_EMMC
> > +    mmc@ec700000 {
> > +          compatible =3D "intel,lgm-sdhci-5.1-emmc", "arasan,sdhci-5.1=
";
> > +          reg =3D <0xec700000 0x300>;
> > +          interrupt-parent =3D <&ioapic1>;
> > +          interrupts =3D <44 1>;
> > +          clocks =3D <&cgu0 LGM_CLK_EMMC5>, <&cgu0 LGM_CLK_NGI>,
> > +                   <&cgu0 LGM_GCLK_EMMC>;
> > +          clock-names =3D "clk_xin", "clk_ahb", "gate";
> > +          clock-output-names =3D "emmc_cardclock";
> > +          #clock-cells =3D <0>;
> > +          phys =3D <&emmc_phy>;
> > +          phy-names =3D "phy_arasan";
> > +          arasan,soc-ctl-syscon =3D <&sysconf>;
> > +    };
> > +
> > +  - |
> > +    #define LGM_CLK_SDIO
> > +    #define LGM_GCLK_SDXC
> > +    mmc@ec600000 {
> > +          compatible =3D "intel,lgm-sdhci-5.1-sdxc", "arasan,sdhci-5.1=
";
> > +          reg =3D <0xec600000 0x300>;
> > +          interrupt-parent =3D <&ioapic1>;
> > +          interrupts =3D <43 1>;
> > +          clocks =3D <&cgu0 LGM_CLK_SDIO>, <&cgu0 LGM_CLK_NGI>,
> > +                   <&cgu0 LGM_GCLK_SDXC>;
> > +          clock-names =3D "clk_xin", "clk_ahb", "gate";
> > +          clock-output-names =3D "sdxc_cardclock";
> > +          #clock-cells =3D <0>;
> > +          phys =3D <&sdxc_phy>;
> > +          phy-names =3D "phy_arasan";
> > +          arasan,soc-ctl-syscon =3D <&sysconf>;
> > +    };
> > +
> > +  - |
> > +    #define KEEM_BAY_PSS_AUX_EMMC
> > +    #define KEEM_BAY_PSS_EMMC
> > +    mmc@33000000 {
> > +          compatible =3D "intel,keembay-sdhci-5.1-emmc", "arasan,sdhci=
-5.1";
> > +          interrupts =3D <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
> > +          reg =3D <0x0 0x33000000 0x0 0x300>;
> > +          clock-names =3D "clk_xin", "clk_ahb";
> > +          clocks =3D <&scmi_clk KEEM_BAY_PSS_AUX_EMMC>,
> > +                   <&scmi_clk KEEM_BAY_PSS_EMMC>;
> > +          phys =3D <&emmc_phy>;
> > +          phy-names =3D "phy_arasan";
> > +          assigned-clocks =3D <&scmi_clk KEEM_BAY_PSS_AUX_EMMC>;
> > +          assigned-clock-rates =3D <200000000>;
> > +          clock-output-names =3D "emmc_cardclock";
> > +          #clock-cells =3D <0>;
> > +          arasan,soc-ctl-syscon =3D <&mmc_phy_syscon>;
> > +    };
> > +
> > +  - |
> > +    #define KEEM_BAY_PSS_AUX_SD0
> > +    #define KEEM_BAY_PSS_SD0
> > +    mmc@31000000 {
> > +          compatible =3D "intel,keembay-sdhci-5.1-sd";
> > +          interrupts =3D <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
> > +          reg =3D <0x0 0x31000000 0x0 0x300>;
> > +          clock-names =3D "clk_xin", "clk_ahb";
> > +          clocks =3D <&scmi_clk KEEM_BAY_PSS_AUX_SD0>,
> > +                   <&scmi_clk KEEM_BAY_PSS_SD0>;
> > +          arasan,soc-ctl-syscon =3D <&sd0_phy_syscon>;
> > +    };
> > +
> > +  - |
> > +    #define KEEM_BAY_PSS_AUX_SD1
> > +    #define KEEM_BAY_PSS_SD1
> > +    mmc@32000000 {
> > +          compatible =3D "intel,keembay-sdhci-5.1-sdio";
> > +          interrupts =3D <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
> > +          reg =3D <0x0 0x32000000 0x0 0x300>;
> > +          clock-names =3D "clk_xin", "clk_ahb";
> > +          clocks =3D <&scmi_clk KEEM_BAY_PSS_AUX_SD1>,
> > +                   <&scmi_clk KEEM_BAY_PSS_SD1>;
> > +          arasan,soc-ctl-syscon =3D <&sd1_phy_syscon>;
> > +    };
>=20
> Really need 3 Keem Bay examples?

I believe 2 examples is sufficient for Keem Bay.
I will drop one in v3.

>=20
> > --
> > 2.17.1
> >
