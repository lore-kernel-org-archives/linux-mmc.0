From: Chris Brandt <Chris.Brandt@renesas.com>
Subject: RE: [PATCH] mmc: host: tmio: disable clocks when unbinding
Date: Wed, 18 Jan 2017 17:20:33 +0000
Message-ID: <SG2PR06MB11655E5CF25211A3AE7329FC8A7F0@SG2PR06MB1165.apcprd06.prod.outlook.com>
References: <20170117202601.3742-1-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20170117202601.3742-1-wsa@the-dreams.de>
Content-Language: en-US
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, Simon Horman <horms@verge.net.au>, Geert Uytterhoeven <geert@linux-m68k.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>
List-Id: linux-mmc@vger.kernel.org

Hi Wolfram,

On Tuesday, January 17, 2017, Wolfram Sang wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>=20
> Create a helper function to disable clocks and use it in remove(), too.
> Now, clk_summary in debugfs reports the clocks as disabled and unprepared
> after unbinding.

Just tried it, now sh_mobile_sdhi_clk_disable() is called when unbinding.

Thanks,
Chris
