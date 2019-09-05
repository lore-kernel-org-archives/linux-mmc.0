From: Chaotian Jing <chaotian.jing@mediatek.com>
Subject: Re: [PATCH 2/2] mmc: block: add CMD13 polling for ioctl() cmd with
 R1B response
Date: Thu, 5 Sep 2019 10:55:36 +0800
Message-ID: <1567652136.11483.1.camel@mhfsdcap03>
References: <20190904075444.2163-1-chaotian.jing@mediatek.com>
         <20190904075444.2163-3-chaotian.jing@mediatek.com>
         <MN2PR04MB6991F51F6DDCA28FC23D02FEFCB80@MN2PR04MB6991.namprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <MN2PR04MB6991F51F6DDCA28FC23D02FEFCB80@MN2PR04MB6991.namprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Avri Altman <Avri.Altman@wdc.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>, YueHaibing <yuehaibing@huawei.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Ming Lei <ming.lei@redhat.com>, Chris Boot <bootc@bootc.net>, Zachary Hays <zhays@lexmark.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, "srv_heupstream@mediatek.com" <srv_heupstream@mediatek.com>
List-Id: linux-mmc@vger.kernel.org

On Wed, 2019-09-04 at 14:11 +0000, Avri Altman wrote:
> >  static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct
> > mmc_blk_data *md,
> >                                struct mmc_blk_ioc_data *idata)
> >  {
> > @@ -623,6 +675,9 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card
> > *card, struct mmc_blk_data *md,
> >                                         __func__, status, err);
> >         }
> > 
> > +       if (!err && (cmd.flags & MMC_RSP_R1B))
> > +               err = card_busy_detect(card, MMC_BLK_TIMEOUT_MS, NULL);
> > +
> >         return err;
> >  }
> You have both the R1B flag check, and status poll (for rpmb) few line above.
> Maybe you could re-use it.
> It will both simplify this patch, and save the tad optimization of your first patch.
> 
> Thanks,
> Avri

So that we can drop the ioctl_rpmb_card_status_poll() as it do almost
the same thing with card_busy_detect().
