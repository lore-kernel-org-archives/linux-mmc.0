From: Raul Rangel <rrangel@chromium.org>
Subject: Re: [RFC PATCH 1/2] mmc: sdhci: Manually check card status after
 reset
Date: Fri, 3 May 2019 09:12:24 -0600
Message-ID: <20190503151224.GA3650@google.com>
References: <20190501175457.195855-1-rrangel@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190501175457.195855-1-rrangel@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: djkurtz@chromium.org, hongjiefang <hongjiefang@asrmicro.com>, Jennifer Dahm <jennifer.dahm@ni.com>, linux-kernel@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>, Kyle Roeschley <kyle.roeschley@ni.com>, Avri Altman <avri.altman@wdc.com>, Ulf Hansson <ulf.hansson@linaro.org>, Raul Rangel <rrangel@chromium.org>
List-Id: linux-mmc@vger.kernel.org

On Wed, May 01, 2019 at 11:54:56AM -0600, Raul E Rangel wrote:
> I am running into a kernel panic. A task gets stuck for more than 120
> seconds. I keep seeing blkdev_close in the stack trace, so maybe I'm not
> calling something correctly?
> 
> Here is the panic: https://privatebin.net/?8ec48c1547d19975#dq/h189w5jmTlbMKKAwZjUr4bhm7Q2AgvGdRqc5BxAc=
> 
> I sometimes see the following:
> [  547.943974] udevd[144]: seq 2350 '/devices/pci0000:00/0000:00:14.7/mmc_host/mmc0/mmc0:0001/block/mmcblk0/mmcblk0p1' is taking a long time
> 
> I was getting the kernel panic on a 4.14 kernel: https://chromium.googlesource.com/chromiumos/third_party/kernel/+/f3dc032faf4d074f20ada437e2d081a28ac699da/drivers/mmc/host
> So I'm guessing I'm missing an upstream fix.
> 
So I tried these patches on the 5.1 with the memory leak patch applied:
https://patchwork.kernel.org/patch/10927541/

Everything works as expected:
    mmc0: new high speed SDHC card at address 0001
    mmcblk0: mmc0:0001 00000 7.41 GiB
     mmcblk0: p1 p2
    mmc0: card status changed during reset
    mmc0: card was removed during reset
    mmc0: tried to HW reset card, got error -123
    print_req_error: I/O error, dev mmcblk0, sector 2072 flags 80700
    print_req_error: I/O error, dev mmcblk0, sector 2073 flags 80700
    mmc0: card 0001 removed

    mmc0: new high speed SDHC card at address 0001
    mmcblk0: mmc0:0001 00000 7.41 GiB
     mmcblk0: p1 p2
    mmc0: card status changed during reset
    mmc0: card was removed during reset
    mmc0: tried to HW reset card, got error -123
    print_req_error: I/O error, dev mmcblk0, sector 12584832 flags 80700
    print_req_error: I/O error, dev mmcblk0, sector 12584833 flags 80700
    mmc0: card 0001 removed
    Buffer I/O error on dev mmcblk0p2, logical block 369904, async page read

    mmc0: new high speed SDHC card at address 0001
    mmcblk0: mmc0:0001 00000 7.41 GiB
     mmcblk0: p1 p2
    mmc0: card 0001 removed

I also ran another test. Using the DUT with a GPIO to randomly toggle the
CD pin I was able to get 4k+ iterations without any problems. So I think
the patches are good.

    --- Iteration 4506 ----
    Disconnecting card
    [ 7444.370169] mmc0: card 0001 removed
    Connecting Card and sleeping for 0.31476s
    [ 7444.682177] mmc0: new high speed SDHC card at address 0001
    [ 7444.719038] mmcblk0: mmc0:0001 00000 7.41 GiB
    [ 7444.727375]  mmcblk0: p1 p2
    Card Disconnected
    [ 7444.831896] mmc0: Card removed during transfer!
    [ 7444.831914] mmc0: Resetting controller.
    --- Iteration 4507 ----
    Connecting Card and sleeping for 0.30259s
    [ 7445.033649] mmc0: card 0001 removed
    Card Disconnected
    [ 7445.307008] mmc0: error -123 whilst initialising SD card
    --- Iteration 4508 ----
    Connecting Card and sleeping for 0.24827s
    Card Disconnected
    [ 7445.716033] mmc0: Card removed during transfer!
    [ 7445.716052] mmc0: Resetting controller.
    [ 7445.716489] mmc0: error -123 whilst initialising SD card
    --- Iteration 4509 ----
    Connecting Card and sleeping for 0.14132s
    Card Disconnected
    --- Iteration 4510 ----
    Connecting Card and sleeping for 0.26001s
    Card Disconnected
    [ 7446.436079] mmc0: error -123 whilst initialising SD card
    Connecting card to verify if it died
    [ 7446.906804] mmc0: new high speed SDHC card at address 0001
    [ 7446.933631] mmcblk0: mmc0:0001 00000 7.41 GiB
    [ 7446.949224]  mmcblk0: p1 p2
    SDHC still functional

Should I send the patches out again without the RFC tag?

I'll keep trying to track down the hung task I was seeing on 4.14. But I
don't think that's related to these patches. I might just end up
backporting the blk-mq patches to our 4.14 branch since I suspect that
fixes it.

Thanks,
Raul
