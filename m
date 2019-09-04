From: Chaotian Jing <chaotian.jing@mediatek.com>
Subject: fix device in programming state after ioctl()
Date: Wed, 4 Sep 2019 15:54:42 +0800
Message-ID: <20190904075444.2163-1-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>, Chaotian Jing <chaotian.jing@mediatek.com>, Avri Altman <avri.altman@wdc.com>, YueHaibing <yuehaibing@huawei.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Ming Lei <ming.lei@redhat.com>, Chris Boot <bootc@bootc.net>, Zachary Hays <zhays@lexmark.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com
List-Id: linux-mmc@vger.kernel.org

the user space program may access eMMC by ioctl(), after the ioctl() was
completed, it should ensure that eMMC is in transfer state, or it will
cause other thread which access eMMC got timeout error, as it assume that
card was in transfer state.

this patch add CMD13 polling for R1B command to avoid this issue.

Chaotian Jing (2):
  mmc: block: make the card_busy_detect() more generic
  mmc: block: add CMD13 polling for ioctl() cmd with R1B response

 drivers/mmc/core/block.c | 111 ++++++++++++++++++++-------------------
 1 file changed, 57 insertions(+), 54 deletions(-)

-- 
2.18.0
