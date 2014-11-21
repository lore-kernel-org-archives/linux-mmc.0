From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH] mmc: dw_mmc: fix card read threshold for PIO mode
Date: Fri, 21 Nov 2014 19:48:16 +0800
Message-ID: <20141121114813.GA11253@dragon>
References: <1416551950-8277-1-git-send-email-shawn.guo@linaro.org>
 <546F145A.9050900@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <546F145A.9050900@samsung.com>
Sender: stable-owner@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc@vger.kernel.org, Seungwon Jeon <tgih.jun@samsung.com>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Jaehoon,

On Fri, Nov 21, 2014 at 07:30:50PM +0900, Jaehoon Chung wrote:
> Hi, Shawn.
> 
> On 11/21/2014 03:39 PM, Shawn Guo wrote:
> > Commit f1d2736c8156 ("mmc: dw_mmc: control card read threshold")
> > introduces a regression for use case where PIO mode is used, i.e.
> > CONFIG_MMC_DW_IDMAC is not disabled.  It stops kernel from booting
> > like below.
> > 
> > dw_mmc 9408000.dwmmc: fifo-depth property not found, using value of FIFOTH register as default
> > dw_mmc 9408000.dwmmc: Using PIO mode.
> > dw_mmc 9408000.dwmmc: Version ID is 210a
> > dw_mmc 9408000.dwmmc: DW MMC controller at irq 72, 32 bit host data width, 32 deep fifo
> > dw_mmc 9408000.dwmmc: 1 slots initialized
> > ...
> > Waiting for root device /dev/mmcblk0p2...
> > mmc_host mmc0: Bus speed (slot 0) = 52000000Hz (slot req 50000000Hz, actual 26000000HZ div = 1)
> > mmc0: new high speed SDHC card at address b368
> > mmcblk0: mmc0:b368 AF UD 3.84 GiB
> 
> Stopping at here? I didn't know what's difference before applied your patch.
> Clearing Card-read threshold value at every time would be caused that stop kernel?
> Just wonder it.

With my patch, the kernel will continue to mount the rootfs on SD card
as below.

mmcblk0: mmc0:b368 AF UD 3.84 GiB 
 mmcblk0: p1 p2
EXT4-fs (mmcblk0p2): couldn't mount as ext3 due to feature incompatibilities
EXT4-fs (mmcblk0p2): couldn't mount as ext2 due to feature incompatibilities
EXT4-fs (mmcblk0p2): INFO: recovery required on readonly filesystem
EXT4-fs (mmcblk0p2): write access will be enabled during recovery
random: nonblocking pool is initialized
EXT4-fs (mmcblk0p2): recovery complete
EXT4-fs (mmcblk0p2): mounted filesystem with ordered data mode. Opts: (null)
VFS: Mounted root (ext4 filesystem) readonly on device 179:2.

> 
> > 
> > Rather than clearing read threshold bits, the best thing that function
> > dw_mci_ctrl_rd_thld() should do is leaving the bits untouched, in case
> > that card read threshold setup is not needed.
> > 
> > The patch fixes the regression by changing dw_mci_ctrl_rd_thld() a bit
> > to do nothing in case card read threshold bits setup is not needed.
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > Fixes: f1d2736c8156 ("mmc: dw_mmc: control card read threshold")
> > Cc: <stable@vger.kernel.org> # 3.13+
> > ---
> >  drivers/mmc/host/dw_mmc.c | 7 ++-----
> >  1 file changed, 2 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> > index 69f0cc68d5b2..52c04ba69970 100644
> > --- a/drivers/mmc/host/dw_mmc.c
> > +++ b/drivers/mmc/host/dw_mmc.c
> > @@ -628,13 +628,13 @@ static void dw_mci_ctrl_rd_thld(struct dw_mci *host, struct mmc_data *data)
> >  
> >  	if (host->timing != MMC_TIMING_MMC_HS200 &&
> >  	    host->timing != MMC_TIMING_UHS_SDR104)
> > -		goto disable;
> > +		return;
> >  
> >  	blksz_depth = blksz / (1 << host->data_shift);
> >  	fifo_depth = host->fifo_depth;
> >  
> >  	if (blksz_depth > fifo_depth)
> > -		goto disable;
> > +		return;
> >  
> >  	/*
> >  	 * If (blksz_depth) >= (fifo_depth >> 1), should be 'thld_size <= blksz'
> > @@ -644,9 +644,6 @@ static void dw_mci_ctrl_rd_thld(struct dw_mci *host, struct mmc_data *data)
> >  	thld_size = blksz;
> >  	mci_writel(host, CDTHRCTL, SDMMC_SET_RD_THLD(thld_size, 1));
> >  	return;
> 
> Then "return" could be also removed.

You're right.  Will remove it in v2.

Shawn
