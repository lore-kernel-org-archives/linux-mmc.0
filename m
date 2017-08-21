From: Biju Das <biju.das@bp.renesas.com>
Subject: RE: [PATCH ] mmc: renesas_sdhi: Add r8a7743/5 support
Date: Mon, 21 Aug 2017 09:47:36 +0000
Message-ID: <KL1PR06MB1702E32A5BF249BC5D5FB767B8870@KL1PR06MB1702.apcprd06.prod.outlook.com>
References: <1502710766-44361-1-git-send-email-biju.das@bp.renesas.com>
 <20170821082523.GA2418@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relmlor3.renesas.com ([210.160.252.173]:10299 "EHLO
        relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751959AbdHUJrm (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Aug 2017 05:47:42 -0400
In-Reply-To: <20170821082523.GA2418@katana>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Chris Paterson <Chris.Paterson2@renesas.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>



> -----Original Message-----
> From: Wolfram Sang [mailto:wsa@the-dreams.de]
> Sent: 21 August 2017 09:25
> To: Biju Das <biju.das@bp.renesas.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>; Rob Herring <robh+dt@kernel.org=
>;
> Mark Rutland <mark.rutland@arm.com>; Simon Horman
> <horms@verge.net.au>; Magnus Damm <magnus.damm@gmail.com>; Chris
> Paterson <Chris.Paterson2@renesas.com>; Wolfram Sang
> <wsa+renesas@sang-engineering.com>; devicetree@vger.kernel.org; linux-
> renesas-soc@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> mmc@vger.kernel.org
> Subject: Re: [PATCH ] mmc: renesas_sdhi: Add r8a7743/5 support
>
>
> >    Below is the number clocks for each supported SoC:
> > -   1: SH73A0, R8A73A4, R8A7740, R8A7778, R8A7779, R8A7790
> > -      R8A7791, R8A7792, R8A7793, R8A7794, R8A7795, R8A7796
> > +   1: SH73A0, R8A73A4, R8A7740, R8A7743, R8A7745, R8A7778,
> R8A7779,
> > +      R8A7790, R8A7791, R8A7792, R8A7793, R8A7794, R8A7795,
> R8A7796
> >     2: R7S72100
>
> Hmm, maybe we should convert this to only listing SoCs with two clocks?
> That will be easier to maintaine since the majority seems to have one.

Ok. I will send v2 with the suggested  changes.





Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, B=
uckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered=
 No. 04586709.
