From: Chris Brandt <Chris.Brandt@renesas.com>
Subject: RE: [bug report] mmc: tmio-mmc: add support for 32bit data port
Date: Thu, 29 Jun 2017 16:02:11 +0000
Message-ID: <SG2PR06MB1165CBAC1354D2E62C3B3FBE8AD20@SG2PR06MB1165.apcprd06.prod.outlook.com>
References: <20170629125446.2b5ruac5fev7lqp4@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20170629125446.2b5ruac5fev7lqp4@mwanda>
Content-Language: en-US
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hello Dan,


On Thursday, June 29, 2017, Dan Carpenter wrote:
>=20
> Hello Chris Brandt,
>=20
> The patch 8185e51f358a: "mmc: tmio-mmc: add support for 32bit data
> port" from Sep 12, 2016, leads to the following static checker
> warning:
>=20
> 	drivers/mmc/host/tmio_mmc_core.c:415 tmio_mmc_transfer_data()
> 	warn: passing casted pointer 'buf' to 'sd_ctrl_read32_rep()' 16 vs
> 32.
>=20
> drivers/mmc/host/tmio_mmc_core.c
>    401  static void tmio_mmc_transfer_data(struct tmio_mmc_host *host,
>    402                                     unsigned short *buf,
>    403                                     unsigned int count)
>    404  {
>    405          int is_read =3D host->data->flags & MMC_DATA_READ;
>    406          u8  *buf8;
>    407
>    408          /*
>    409           * Transfer the data
>    410           */
>    411          if (host->pdata->flags & TMIO_MMC_32BIT_DATA_PORT) {
>    412                  u8 data[4] =3D { };
>    413
>    414                  if (is_read)
>    415                          sd_ctrl_read32_rep(host, CTL_SD_DATA_PORT=
,
> (u32 *)buf,
>=20
> ^^^^^^^^^^
>    416                                             count >> 2);
>=20
> Of course, it's not invalid to cast pointer parameters, but it's often
> a sign that something is buggy.  In the caller function we take a
> buffer of bytes, and we cast it to u16, and then here we cast it to u32.
> count is in terms of bytes still.

Personally, I think a buffer of raw data should be a 'u8 *', not a=20
'unsigned short *'.
And, the parameter name "count" should really be something like "size"=20
or "length" (but that is still confusing because the passed array 'buf'=20
was designated as an array of "unsigned short *", so what would 'size'=20
really mean??)

Anyway, that is the API that's in place today, so that's what I needed=20
to work with.


>=20
>    417                  else
>    418                          sd_ctrl_write32_rep(host, CTL_SD_DATA_POR=
T,
> (u32 *)buf,
>    419                                              count >> 2);
>    420
>    421                  /* if count was multiple of 4 */
>    422                  if (!(count & 0x3))
>    423                          return;
>    424
>    425                  buf8 =3D (u8 *)(buf + (count >> 2));
>=20
>=20
> And this looks like the bug...  buf is a u16 pointer but we're adding
> "count / sizeof(u32)" when we should be adding "count / (sizeof(*buf))".

I agree this math does not work out to what I wanted because of the=20
differences in data types.

Since I simply wanted to get a pointer to where I left off in the=20
buffer, maybe the most clear thing to do is just cast buf and do simple mat=
h:

   buf8 =3D (u8 *)buf + (count & ~3);


Do you agree?



>    426                  count %=3D 4;
>    427
>    428                  if (is_read) {
>    429                          sd_ctrl_read32_rep(host, CTL_SD_DATA_PORT=
,
>    430                                             (u32 *)data, 1);
>    431                          memcpy(buf8, data, count);
>    432                  } else {
>    433                          memcpy(data, buf8, count);
>    434                          sd_ctrl_write32_rep(host, CTL_SD_DATA_POR=
T,
>    435                                              (u32 *)data, 1);
>    436                  }
>    437
>    438                  return;
>    439          }
>    440
>    441          if (is_read)
>    442                  sd_ctrl_read16_rep(host, CTL_SD_DATA_PORT, buf,
> count >> 1);
>    443          else
>    444                  sd_ctrl_write16_rep(host, CTL_SD_DATA_PORT, buf,
> count >> 1);
>    445
>    446          /* if count was even number */
>    447          if (!(count & 0x1))
>    448                  return;
>    449
>    450          /* if count was odd number */
>    451          buf8 =3D (u8 *)(buf + (count >> 1));
>    452
>    453          /*
>    454           * FIXME
>    455           *
>    456           * driver and this function are assuming that
>    457           * it is used as little endian
>=20
> Indeed.
>=20
>    458           */
>    459          if (is_read)
>    460                  *buf8 =3D sd_ctrl_read16(host, CTL_SD_DATA_PORT) =
&
> 0xff;
>    461          else
>    462                  sd_ctrl_write16(host, CTL_SD_DATA_PORT, *buf8);
>    463  }
>=20
> regards,
> dan carpenter


Chris
