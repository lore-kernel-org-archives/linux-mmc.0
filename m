From: Avri Altman <Avri.Altman@wdc.com>
Subject: RE: [PATCH v2 2/2] mmc: block: add CMD13 polling for ioctl() cmd with
 R1B response
Date: Thu, 5 Sep 2019 08:44:35 +0000
Message-ID: <MN2PR04MB6991D9707092B671FB129DC0FCBB0@MN2PR04MB6991.namprd04.prod.outlook.com>
References: <20190905075318.15554-1-chaotian.jing@mediatek.com>
 <20190905075318.15554-3-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190905075318.15554-3-chaotian.jing@mediatek.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Chaotian Jing <chaotian.jing@mediatek.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>, YueHaibing <yuehaibing@huawei.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Ming Lei <ming.lei@redhat.com>, Chris Boot <bootc@bootc.net>, Zachary Hays <zhays@lexmark.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, "srv_heupstream@mediatek.com" <srv_heupstream@mediatek.com>
List-Id: linux-mmc@vger.kernel.org


>=20
>=20
> currently there is no CMD13 polling and other code to wait card
> change to transfer state after R1B command completed. and this
> polling operation cannot do in user space, because other request
> may coming before the CMD13 from user space.
>=20
> Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
Reviewed-by: Avri Altman <avri.altman@wdc.com>
