From: Avri Altman <Avri.Altman@wdc.com>
Subject: RE: [PATCH v1] mmc: core: Verify SD bus width
Date: Tue, 16 Apr 2019 12:18:24 +0000
Message-ID: <SN6PR04MB4925DC8FAFEE4A40ABAF68C8FC240@SN6PR04MB4925.namprd04.prod.outlook.com>
References: <20190415210031.54062-1-rrangel@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190415210031.54062-1-rrangel@chromium.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Raul E Rangel <rrangel@chromium.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: "djkurtz@chromium.org" <djkurtz@chromium.org>, "zwisler@chromium.org" <zwisler@chromium.org>, hongjiefang <hongjiefang@asrmicro.com>, Jennifer Dahm <jennifer.dahm@ni.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Kyle Roeschley <kyle.roeschley@ni.com>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

>=20
> The SD Physical Layer Spec says the following: Since the SD Memory Card
> shall support at least the two bus modes 1-bit or 4-bit width, then any S=
D
> Card shall set at least bits 0 and 2 (SD_BUS_WIDTH=3D"0101").
>=20
> This change verifies the card has specified a bus width.
>=20
> verified it didn't mount.
>=20
> Signed-off-by: Raul E Rangel <rrangel@chromium.org>
Acked-by: Avri Altman <avri.altman@wdc.com>

> ---
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
> Here is an example of a bad trace: https://pastebin.com/TY2cF9n0
> Look for sd_scr and sd_ssr.
>=20
>  drivers/mmc/core/sd.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index 265e1aeeb9d8..f6481f8e9fe7 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -205,6 +205,13 @@ static int mmc_decode_scr(struct mmc_card *card)
>=20
>  	scr->sda_vsn =3D UNSTUFF_BITS(resp, 56, 4);
>  	scr->bus_widths =3D UNSTUFF_BITS(resp, 48, 4);
> +
> +	/* SD Spec says: any SD Card shall set at least bits 0 and 2 */
> +	if (!scr->bus_widths) {
So why not testing that exact mask?
you have SD_SCR_BUS_WIDTH_1 and SD_SCR_BUS_WIDTH_4 already defined...
