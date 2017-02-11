From: Avri Altman <Avri.Altman@sandisk.com>
Subject: RE: [PATCH 00/16] multiqueue for MMC/SD third try
Date: Sat, 11 Feb 2017 13:03:03 +0000
Message-ID: <9BEFCB713C10BF4B91D714797ECA5EEA117E08F5@ULS-OP-MBXIP04.sdcorp.global.sandisk.com>
References: <20170209153403.9730-1-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-block-owner@vger.kernel.org>
In-Reply-To: <20170209153403.9730-1-linus.walleij@linaro.org>
Content-Language: en-US
Sender: linux-block-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Paolo Valente <paolo.valente@linaro.org>
Cc: Chunyan Zhang <zhang.chunyan@linaro.org>, Baolin Wang <baolin.wang@linaro.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-mmc@vger.kernel.org

> 
> The iozone results seem a bit consistent and all values seem to be noisy and
> not say much. I don't know why really, maybe the test is simply not relevant,
> the tests don't seem to be significantly affected by any of the patches, so
> let's focus on the dd and find tests.

Maybe use a more selective testing mode instead of -az.
Also maybe you want to clear the cache between the sequential and random tests:
#sync 
#echo 3 > /proc/sys/vm/drop_caches 
#sync 
It helps to obtain a more robust results.

> What immediately jumps out at you is that linear read/writes perform just as
> nicely or actually better with MQ than with the old block layer.

How come 22.7MB/s before vs. 22.1MB/s after is better?  or did I misunderstand the output?
Also as dd is probably using the buffer cache, unlike the iozone test  in which you properly used -I
for direct mode to isolate the blk-mq effect - does it really say much?
