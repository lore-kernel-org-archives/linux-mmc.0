From: Chris Brandt <Chris.Brandt@renesas.com>
Subject: RE: [PATCH v2 2/3] mmc: sh_mobile_sdhi: explain clock bindings
Date: Wed, 18 Jan 2017 14:58:53 +0000
Message-ID: <SG2PR06MB1165AD95913FB62D971BCC358A7F0@SG2PR06MB1165.apcprd06.prod.outlook.com>
References: <20170117195940.25092-1-chris.brandt@renesas.com>
 <20170117195940.25092-3-chris.brandt@renesas.com>
 <20170117203340.dx6k4zof2omcbz4y@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relmlor4.renesas.com ([210.160.252.174]:11262 "EHLO
        relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751750AbdARO67 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Jan 2017 09:58:59 -0500
In-Reply-To: <20170117203340.dx6k4zof2omcbz4y@ninjato>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Simon Horman <horms@verge.net.au>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Geert Uytterhoeven <geert@linux-m68k.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>

Hi Wolfram,

On Tuesday, January 17, 2017, Wolfram Sang wrote:
> > +- clocks: Most controllers only have 1 clock source per cahnnel.
> > +However, some
>=20
> channel.
>=20
> > +	  have 2. If 2 clocks are specified, you must name them as "core"
> > +and
>=20
> Maybe "However, some have a second clock dedicated to card detection."?


Thank you for fixing my crappy spelling and grammar ;)



I'm glad C code uses 'if' and 'else' instead of=20

	contemplate (x>y)
		X=3D1;
	alternatively
		y=3D1;


  ...then I'd be screwed!


Chris
