From: Avri Altman <Avri.Altman@wdc.com>
Subject: RE: [PATCH v2] mmc: core: Verify SD bus width
Date: Thu, 18 Apr 2019 06:20:26 +0000
Message-ID: <SN6PR04MB4925C1C304B992339621808AFC260@SN6PR04MB4925.namprd04.prod.outlook.com>
References: <20190416185705.256369-1-rrangel@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190416185705.256369-1-rrangel@chromium.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Raul E Rangel <rrangel@chromium.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: "djkurtz@chromium.org" <djkurtz@chromium.org>, "zwisler@chromium.org" <zwisler@chromium.org>, hongjiefang <hongjiefang@asrmicro.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>, Kyle Roeschley <kyle.roeschley@ni.com>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

>=20
> The SD Physical Layer Spec says the following: Since the SD Memory Card
> shall support at least the two bus modes 1-bit or 4-bit width, then any S=
D
> Card shall set at least bits 0 and 2 (SD_BUS_WIDTH=3D"0101").
>=20
> This change verifies the card has specified a bus width.
>=20
> AMD SDHC Device 7806 can get into a bad state after a card disconnect
> where anything transferred via the DATA lines will always result in a
> zero filled buffer. Currently the driver will continue without error if
> the HC is in this condition. A block device will be created, but reading
> from it will result in a zero buffer. This makes it seem like the SD
> device has been erased, when in actuality the data is never getting
> copied from the DATA lines to the data buffer.
>=20
> SCR is the first command in the SD initialization sequence that uses the
> DATA lines. By checking that the response was invalid, we can abort
> mounting the card.
>=20
> Acked-by: Avri Altman <avri.altman@wdc.com>
>=20
> Signed-off-by: Raul E Rangel <rrangel@chromium.org>
Reviewed-by: Avri Altman <avri.altman@wdc.com>

Thanks,
Avri
