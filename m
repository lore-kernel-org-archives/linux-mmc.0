From: Avri Altman <Avri.Altman@wdc.com>
Subject: RE: [PATCH 1/7] mmc-utils: interpret OPTIMAL_*_SIZE fields in extcsd
Date: Wed, 10 Oct 2018 08:40:26 +0000
Message-ID: <SN6PR04MB49256CFEA5B525999B4AAD0BFCE00@SN6PR04MB4925.namprd04.prod.outlook.com>
References: <cover.1539103468.git.jamesnuss@nanometrics.ca>
 <4a016f761d388a989059467507f2bc948ba26c6c.1539103468.git.jamesnuss@nanometrics.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4a016f761d388a989059467507f2bc948ba26c6c.1539103468.git.jamesnuss@nanometrics.ca>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: James Nuss <jamesnuss@nanometrics.ca>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Looks fine.

Thanks,
Avri

> eMMC 5.0 introduced OPTIMAL_READ_SIZE, OPTIMAL_WRITE_SIZE and
> OPTIMAL
> TRIM_UNIT_SIZE fields in the extcsd
>=20
> Interpret these fields when reading out the extcsd with human-readable
> results
>=20
> Signed-off-by: James Nuss <jamesnuss@nanometrics.ca>
Reviewed-by: Avri Altman <avri.altman@wdc.com>
