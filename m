From: Paul Thomas <pthomas8589@gmail.com>
Subject: mmc: sdhci-of-arasan small issue with clock with 5.2 kernel
Date: Fri, 26 Jul 2019 14:23:28 -0400
Message-ID: <CAD56B7cF3QXQbMmZVehtBEm2Bhfda4GpsHFZyDJE8D82xkgyEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Michal Simek <michal.simek@xilinx.com>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hello,

I'm using the arm64 Zynq Ultrascale+ parts, and I'm running into what
I think is a small issue in sdhci-of-arasan with the handling of the
'clk_xin' which becomes pltfm_host->clk.

If I just use the mainline zynqmp-clk.dtsi file then 'clk_xin' get's
blindly defined as a "fixed-clock" at 200 Mhz and everything seems to
work fine.

However, in this design the clock is actually 50 Mhz [1]. For other
reasons [2] I switched the device-tree clock definitions to actually
use the zynqmp firmware interface for getting the clocks [3] when I do
this the clock is then correctly detected as 50 MHz:
# cat /sys/kernel/debug/clk/clk_summary
...
sdio0_ref       1        1        1    50000000          0     0  50000
...

And this is the frequency that is given to the controller (I put
printk's in to verify that 200 and 50 were the respective values for
mhz):
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/drivers/mmc/host/sdhci-of-arasan.c?h=v5.2.3#n594

At this point the functionality becomes partially broken. Detecting
the chip and some reads seem to work, but then when I go to fdisk
write there are errors such as:
[   56.481985] 002: print_req_error: I/O error, dev mmcblk0, sector 0 flags 1
[   56.481999] 002: Buffer I/O error on dev mmcblk0, logical block 0,
lost async page write

It seems to me that giving the real 'clk_xin' frequency to the
controller should not break anything? For now I'm fine with just using
the incorrect 200 MHz fixed-clock, but I thought someone might be
interested in this.

This controller is connected to an eMMC part.

I did try reducing spi-max-frequency from 10M down to 1M, but that
does not seem to make a difference.

thanks,
Paul

[1] As defined in Vivado in the MPSoC block in Output Clocks -> Low
Power Domain Clocks -> Peripherals/IO Clocks -> SDIO0
[2] To enable the macb driver to properly set the frequency of the GEM
clock so that 100 Mb/s works
[3] The device-tree like this:
https://github.com/Xilinx/linux-xlnx/blob/master/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
and adding "xlnx,zynqmp-clk" clock-controller
