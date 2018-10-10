From: Avri Altman <Avri.Altman@wdc.com>
Subject: RE: [PATCH 2/7] mmc-utils: treat FIRMWARE_VERSION as binary field
 instead of string
Date: Wed, 10 Oct 2018 08:43:24 +0000
Message-ID: <SN6PR04MB4925CB991DADD39F28A31D13FCE00@SN6PR04MB4925.namprd04.prod.outlook.com>
References: <cover.1539103468.git.jamesnuss@nanometrics.ca>
 <e2b6431104a6a822840d4e7b984d7aa23048a0af.1539103468.git.jamesnuss@nanometrics.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <e2b6431104a6a822840d4e7b984d7aa23048a0af.1539103468.git.jamesnuss@nanometrics.ca>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: James Nuss <jamesnuss@nanometrics.ca>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org


> +++ b/mmc_cmds.c
> @@ -1758,8 +1758,15 @@ int do_read_extcsd(int nargs, char **argv)
>  	}
>=20
>  	if (ext_csd_rev >=3D 7) {
> -		printf("eMMC Firmware Version: %s\n",
> -			(char*)&ext_csd[EXT_CSD_FIRMWARE_VERSION]);
> +		printf("Firmware Version:
> 0x%02x%02x%02x%02x%02x%02x%02x%02x\n",
> +			ext_csd[EXT_CSD_FIRMWARE_VERSION_7],
> +			ext_csd[EXT_CSD_FIRMWARE_VERSION_6],
> +			ext_csd[EXT_CSD_FIRMWARE_VERSION_5],
> +			ext_csd[EXT_CSD_FIRMWARE_VERSION_4],
> +			ext_csd[EXT_CSD_FIRMWARE_VERSION_3],
> +			ext_csd[EXT_CSD_FIRMWARE_VERSION_2],
> +			ext_csd[EXT_CSD_FIRMWARE_VERSION_1],
> +			ext_csd[EXT_CSD_FIRMWARE_VERSION_0]);
ExtCSD[261:254] is an ASCII string, just add a terminating null.

Thanks,
Avri
