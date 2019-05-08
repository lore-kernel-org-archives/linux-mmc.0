From: Raul Rangel <rrangel@chromium.org>
Subject: Re: [RFC PATCH 1/2] mmc: sdhci: Manually check card status after
 reset
Date: Wed, 8 May 2019 13:00:00 -0600
Message-ID: <20190508190000.GA156909@google.com>
References: <20190501175457.195855-1-rrangel@chromium.org>
 <20190503151224.GA3650@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190503151224.GA3650@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: djkurtz@chromium.org, hongjiefang <hongjiefang@asrmicro.com>, Jennifer Dahm <jennifer.dahm@ni.com>, linux-kernel@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>, Kyle Roeschley <kyle.roeschley@ni.com>, Avri Altman <avri.altman@wdc.com>, Ulf Hansson <ulf.hansson@linaro.org>, rrangel@chromium.org
List-Id: linux-mmc@vger.kernel.org

On Fri, May 03, 2019 at 09:12:24AM -0600, Raul Rangel wrote:
> On Wed, May 01, 2019 at 11:54:56AM -0600, Raul E Rangel wrote:
> > I am running into a kernel panic. A task gets stuck for more than 120
> > seconds. I keep seeing blkdev_close in the stack trace, so maybe I'm not
> > calling something correctly?
> > 
> > Here is the panic: https://privatebin.net/?8ec48c1547d19975#dq/h189w5jmTlbMKKAwZjUr4bhm7Q2AgvGdRqc5BxAc=
> > 
> > I sometimes see the following:
> > [  547.943974] udevd[144]: seq 2350 '/devices/pci0000:00/0000:00:14.7/mmc_host/mmc0/mmc0:0001/block/mmcblk0/mmcblk0p1' is taking a long time
> > 
> > I was getting the kernel panic on a 4.14 kernel: https://chromium.googlesource.com/chromiumos/third_party/kernel/+/f3dc032faf4d074f20ada437e2d081a28ac699da/drivers/mmc/host
> > So I'm guessing I'm missing an upstream fix.
> > 
> 
> I'll keep trying to track down the hung task I was seeing on 4.14. But I
> don't think that's related to these patches. I might just end up
> backporting the blk-mq patches to our 4.14 branch since I suspect that
> fixes it.

So I tracked down the hung task in 4.14, it's a resource leak.
mmc_cleanup_queue stops the worker thread. If there were any requests in
the queue they would be holding onto a reference of mmc_blk_data. When
mmc_blk_remove_req calls mmc_blk_put, there are still references to md, so
it never calls blk_cleanup_queue, and the requests stay in the queue
forever.

Fortunately Adrian already has a fix for this: https://lore.kernel.org/patchwork/patch/856512/
I think we should cherry-pick 41e3efd07d5a02c80f503e29d755aa1bbb4245de
into v4.14. I've tried it locally and it fixes the kernel panic I was
seeing.

I've also sent out two more patches for v4.14 that need to be applied
with Adrian's patch:
* https://patchwork.kernel.org/patch/10936439/
* https://patchwork.kernel.org/patch/10936441/

As for this patch, are there any comments? I have a test running that is
doing random connect/disconnects, and it's over 6k iterations now.

Thanks,
Raul
