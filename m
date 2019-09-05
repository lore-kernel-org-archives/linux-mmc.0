From: Avri Altman <Avri.Altman@wdc.com>
Subject: RE: [PATCH v2 1/2] mmc: block: make the card_busy_detect() more
 generic
Date: Thu, 5 Sep 2019 08:43:01 +0000
Message-ID: <MN2PR04MB69916E18CB87074C1189D82CFCBB0@MN2PR04MB6991.namprd04.prod.outlook.com>
References: <20190905075318.15554-1-chaotian.jing@mediatek.com>
 <20190905075318.15554-2-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190905075318.15554-2-chaotian.jing@mediatek.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Chaotian Jing <chaotian.jing@mediatek.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>, YueHaibing <yuehaibing@huawei.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Ming Lei <ming.lei@redhat.com>, Chris Boot <bootc@bootc.net>, Zachary Hays <zhays@lexmark.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, "srv_heupstream@mediatek.com" <srv_heupstream@mediatek.com>
List-Id: linux-mmc@vger.kernel.org

>=20
> to use the card_busy_detect() to wait card levae the programming state,
> there may be do not have the "struct request *" argument.
Maybe reword the commit log to make it more clear:

A tad optimization, removing the "struct request *" argument from card_busy=
_detect().
It's not really needed there, and will prove its worth in the next patch,
Where we'll use it in __mmc_blk_ioctl_cmd where struct request is not avail=
able.

>=20
> Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
Reviewed-by: Avri Altman <avri.altman@wdc.com>
