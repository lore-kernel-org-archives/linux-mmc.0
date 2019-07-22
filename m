From: Paul Burton <paul.burton@mips.com>
Subject: Re: [PATCH 3/3] MIPS: qi_lb60: Move MMC configuration to devicetree
Date: Mon, 22 Jul 2019 22:30:13 +0000
Message-ID: <MWHPR2201MB1277E59D5FC1D9BE944902D7C1C40@MWHPR2201MB1277.namprd22.prod.outlook.com>
References: <20190125200927.21045-3-paul@crapouillou.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190125200927.21045-3-paul@crapouillou.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <pburton@wavecomp.com>, James Hogan <jhogan@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Paul Cercueil <paul@crapouillou.net>"linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hello,

Paul Cercueil wrote:
> Move the MMC configuration from the board C file to devicetree.
>=20
> The 'power' GPIO was removed and instead the vmmc regulator is used,
> to follow the changes introduced in the jz4740-mmc driver.
>=20
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

Applied to mips-next.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]
