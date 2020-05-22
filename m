Return-Path: <SRS0=PvXF=7E=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B3FC433E0
	for <linux-mmc@archiver.kernel.org>; Fri, 22 May 2020 02:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95867207F7
	for <linux-mmc@archiver.kernel.org>; Fri, 22 May 2020 02:01:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="AtAgnC+a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbgEVCBP (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 21 May 2020 22:01:15 -0400
Received: from mail-eopbgr80042.outbound.protection.outlook.com ([40.107.8.42]:32996
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726335AbgEVCBO (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 21 May 2020 22:01:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VxQ+jJWIrUZW1OF+GOsBfIXi87wIwKa7HyTpVJXYQNnQYwGh2ijCo8z3dWMMKQMePxckvfuvBoKOslX1ezwXIGk3x/i/LQ/TJzHpcaJFjfsdy6/4/VrKRzMY1yMvJPEDU9uzmdGXfNYJWAfvsZLYDU3Pg1XB2/vSNtzynDoc4o1KfVfSOe8NzgaMuHWxQv7oX1Dp/GyKCWvYZTzbnV7gvJQBJkI4CqDK0YuAQq0KxI0Jl0+QUARWlv6pd2yiLimd5i1Dnto/uycAhO4jNL1molZh/p7MBGC7k9PHnHQZ83HYuSuG7HF5yYlQMh1dG6JnzMSOonUmAGA1SPAr4bZ7og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/BUmvZEQGp1yejt/zLdMmxwWHNNuM2DiPBV98z4tDxU=;
 b=U5lIOj2wPGO1Dlcl33lMfcIWccv5B/ZTJTyaw3bAmuYrUDoWBOsKHGaEBFKfcOeDtNI3ReIk/dWobaetRDeT/NbqHKZpn7IwmGw5Pxhe0knP4Ifw9QKT/QJWyerCiUaG7/rTjZah4jOhSeRZbr20uo3/IgeeUpOSH2vFmlkQNmkkmJNnavBuZHrjCQQFRL6RVAM88SG07RlToqP28JiQ8xkw1R7+OJjOHtYy9Q9Ih0D3N1WtjSslohux1rw52umBg7KnrlkAzn6D6OM1UCW3NTsOLlPyuBbBPdAtYUQGYrR2jwHeIRBFHHhVhEkZUm+6YmfKvIkWw/nr2xuTgbsgrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/BUmvZEQGp1yejt/zLdMmxwWHNNuM2DiPBV98z4tDxU=;
 b=AtAgnC+adjF1Cm2+bn7woCvUSAlJki980Yp3o97YPETF6FtIJL35ozvHq4+VeE5stOZjxm9Bp5NiH3iiWGX3zHtG+VRjlvpgGW6bOU8k795GU3p5bg+W2jQpMxTR57LD1jUsD4PAp/FyLSPToqQDRYMP7BNGl92E9IVlmA1TAjw=
Received: from AM7PR04MB6885.eurprd04.prod.outlook.com (2603:10a6:20b:10d::24)
 by AM7PR04MB6920.eurprd04.prod.outlook.com (2603:10a6:20b:101::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.27; Fri, 22 May
 2020 02:01:11 +0000
Received: from AM7PR04MB6885.eurprd04.prod.outlook.com
 ([fe80::fdc0:9eff:2931:d11b]) by AM7PR04MB6885.eurprd04.prod.outlook.com
 ([fe80::fdc0:9eff:2931:d11b%6]) with mapi id 15.20.3021.026; Fri, 22 May 2020
 02:01:11 +0000
From:   "Y.b. Lu" <yangbo.lu@nxp.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
CC:     Sachin Miglani <sachin.miglani@nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: RE: Query on patch "7ff2760 mmc: core: Add a facility to "pause"
 re-tuning"
Thread-Topic: Query on patch "7ff2760 mmc: core: Add a facility to "pause"
 re-tuning"
Thread-Index: AdYtyU1s4sh3Ym1ST5u56DNSSIuiEwAAvvYAAIO9bTA=
Date:   Fri, 22 May 2020 02:01:11 +0000
Message-ID: <AM7PR04MB6885EC0D3B8E2B1C5EEBB23BF8B40@AM7PR04MB6885.eurprd04.prod.outlook.com>
References: <AM7PR04MB6885850EAB3307DDA0C4FDC3F8B90@AM7PR04MB6885.eurprd04.prod.outlook.com>
 <3d56b588-9519-ed36-4bbe-6929a9f5ee53@intel.com>
In-Reply-To: <3d56b588-9519-ed36-4bbe-6929a9f5ee53@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8709447e-f409-4026-59f0-08d7fdf4003a
x-ms-traffictypediagnostic: AM7PR04MB6920:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM7PR04MB692069A55ABDAC4DB35DBB17F8B40@AM7PR04MB6920.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 04111BAC64
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K+al4gsAeTGcA76kcP13LkshFRO9WztUdU5h0VPPULcWiIairXaoUzfz89k696Gm0CXhfaZYYhTusegYXNDt1wKHveffmrpe1qsR9Ohe/Y+/nw9kzq3r0wVSQVAXeQ5boiU9byo2fXcTEh/hb8gp3KAHUGVobMUGJq6Cnv0/Ry4Onz3Fv6v3uEAizkyjX5OJuMtkYLlu+7NtoO0v7JnAg3epXPbTWbZu5y0ZcPs3/e3d5zY25qrHHk406uwvWOicKdnLF0d9ahlAny447sG0BHT6H4HxdMRn1QScv5+eHaau4m1MwpzqcQOyZLmhCJX1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6885.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(346002)(366004)(39860400002)(136003)(376002)(8936002)(6506007)(7696005)(5660300002)(186003)(478600001)(53546011)(6916009)(26005)(2906002)(9686003)(66556008)(55016002)(4326008)(52536014)(86362001)(33656002)(76116006)(316002)(54906003)(64756008)(66446008)(71200400001)(66946007)(66476007)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 8QdWkX8xdey5xJxyho1nw5zlL3kU5HilGe3EscqhHmJFcNA48bHQa5DkMPQo2IovhSyLwaiQWtdwl5YtQ6TpCun0al4lnxgcGGvJbSIvMKnNJmoTexaXhw9T6mQjX2mOfg0sYqVV22JxcbdrAH0QOA1S+ZazZn/WIX6Zh5fmC8Xj5Uj0Igvg6qsFP9P519fpwWk+S404PwTpGkz+8wfB2BYLXjUcfvLTD6euadO3TD/TJgqzfJI0Y4I8sWUNXLiAEh/6lcPVe4vvNzGerV7I6oj2jhyOldPJ6JEkVaD696CDtUns701mrJzMege+GT3zmFmnnWwWIqukBgvmR2qS0eANeeoZ7Bly6nO1qorcwE8+dzQTMbyRAoYY2FLSY/vyHj1LMC8f9i8E4p0GUe+4kpUv7sSat5zeF2A6caHLNwWLQucythMyEBF2Lo220fiJ19aGnh6eqFytSrqB9WMSwwd9YoVZRdF/kW0cMA8MjWA=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8709447e-f409-4026-59f0-08d7fdf4003a
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2020 02:01:11.2094
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xBOh2t0+Ssaj6oTwnodrduNA7ylwYyYnZ4Tc+qGbkFNyGqm3YZU3RBgjv8bnnBCJ5j1ir48DMtQiUQA7zyhJCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6920
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Adrian,

Thanks for your quick explaining.
Auto tuning mode make sure tuning would not be needed as hardware will auto=
matically take care of drift for data transfer.
And the chances of drift on response line (48 cycles) is very less.

Ok. The retuning can reduce the risk of CRC errors even the risk is very lo=
w for auto tuning mode.
I have no question now:)

Thanks a lot.

Best regards,
Yangbo Lu

> -----Original Message-----
> From: linux-mmc-owner@vger.kernel.org <linux-mmc-owner@vger.kernel.org>
> On Behalf Of Adrian Hunter
> Sent: Tuesday, May 19, 2020 6:57 PM
> To: Y.b. Lu <yangbo.lu@nxp.com>; Ulf Hansson <ulf.hansson@linaro.org>;
> linux-mmc@vger.kernel.org
> Cc: Sachin Miglani <sachin.miglani@nxp.com>
> Subject: Re: Query on patch "7ff2760 mmc: core: Add a facility to "pause"
> re-tuning"
>=20
> On 19/05/20 1:42 pm, Y.b. Lu wrote:
> > Hi Uffe and Adrian,
> >
> >
> >
> > May I have a query on below patch. Do we really need re-tuning before
> > switching to RPMB partition each time per eMMC spec, especially for HS4=
00
> > mode with auto-tuning?
>=20
> It was to ensure tuning would not be needed while accessing RPMB since
> RPMB
> does not support tuning.
>=20
> >
> > What's the impact if no re-tuning here?
>=20
> Increased risk of CRC errors.
>=20
> >
> >
> >
> > 7ff2760 mmc: core: Add a facility to "pause" re-tuning
> >
> >
> >
> > +/*
> >
> > + * Pause re-tuning for a small set of operations.=A0 The pause begins =
after the
> >
> > + * next command and after first doing re-tuning.
> >
> > + */
> >
> > +void mmc_retune_pause(struct mmc_host *host)
> >
> > +{
> >
> > +=A0=A0=A0=A0=A0=A0 if (!host->retune_paused) {
> >
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 host->retune_paused =3D 1;
> >
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 mmc_retune_needed(host);
> >
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 mmc_retune_hold(host);
> >
> > +=A0=A0=A0=A0=A0=A0 }
> >
> > +}
> >
> >
> >
> > Thanks a lot.
> >
> >
> >
> > Best regards,
> >
> > Yangbo Lu
> >
> >
> >

