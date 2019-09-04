From: Avri Altman <Avri.Altman@wdc.com>
Subject: RE: [PATCH 2/2] mmc: block: add CMD13 polling for ioctl() cmd with
 R1B response
Date: Wed, 4 Sep 2019 14:11:58 +0000
Message-ID: <MN2PR04MB6991F51F6DDCA28FC23D02FEFCB80@MN2PR04MB6991.namprd04.prod.outlook.com>
References: <20190904075444.2163-1-chaotian.jing@mediatek.com>
 <20190904075444.2163-3-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190904075444.2163-3-chaotian.jing@mediatek.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Chaotian Jing <chaotian.jing@mediatek.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>, YueHaibing <yuehaibing@huawei.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Ming Lei <ming.lei@redhat.com>, Chris Boot <bootc@bootc.net>, Zachary Hays <zhays@lexmark.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, "srv_heupstream@mediatek.com" <srv_heupstream@mediatek.com>
List-Id: linux-mmc@vger.kernel.org

>  static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct
> mmc_blk_data *md,
>                                struct mmc_blk_ioc_data *idata)
>  {
> @@ -623,6 +675,9 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card
> *card, struct mmc_blk_data *md,
>                                         __func__, status, err);
>         }
>=20
> +       if (!err && (cmd.flags & MMC_RSP_R1B))
> +               err =3D card_busy_detect(card, MMC_BLK_TIMEOUT_MS, NULL);
> +
>         return err;
>  }
You have both the R1B flag check, and status poll (for rpmb) few line above=
.
Maybe you could re-use it.
It will both simplify this patch, and save the tad optimization of your fir=
st patch.

Thanks,
Avri
