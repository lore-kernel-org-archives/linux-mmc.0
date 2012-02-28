From: Dongjin Kim <dongjin.kim@agreeyamobility.net>
Subject: Re: mmc: =?utf-8?b?ZHdfbW1jOg==?= release hardware lock error
Date: Tue, 28 Feb 2012 07:31:55 +0000 (UTC)
Message-ID: <loom.20120228T083128-699@post.gmane.org>
References: <loom.20120228T060529-421@post.gmane.org> <4F4C7745.9090202@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:34912 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755026Ab2B1HcI (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 28 Feb 2012 02:32:08 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkm-linux-mmc@m.gmane.org>)
	id 1S2HXa-0005CH-Qo
	for linux-mmc@vger.kernel.org; Tue, 28 Feb 2012 08:32:07 +0100
Received: from 210.113.108.23 ([210.113.108.23])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Tue, 28 Feb 2012 08:32:06 +0100
Received: from dongjin.kim by 210.113.108.23 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Tue, 28 Feb 2012 08:32:06 +0100
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Jaehoon Chung <jh80.chung <at> samsung.com> writes:

> 
> On 02/28/2012 02:32 PM, Dongjin Kim wrote:
> 
> > Hello,
> > 
> > I encountered the problem that my hardware is frozen while switching clock 
from 
> > 400kHz to others. This is caused that hardware locked error was triggered 
when 
> > CMD register was written and interrupt was pended. Tested IP version is 
2.10a
> > 
> 
> Hi Dongjin.
> 
> It seems like this problem. Can you check this patch?
> http://www.spinics.net/lists/linux-mmc/msg09895.html
> 
> Best Regards,
> Jaehoon Chung
> 
Hi Jaehoon,

Thank you for your feedback.
I had tested the patch from the link but the result is same on my hardware.

This is the log message what I had before, the hardware hanged after this log 
when mmc card is inserted.

[   62.450000] end_request: I/O error, dev mmcblk0, sector 7585
[   62.460000] mmcblk0: error -123 sending read/write command, response 0x0, 
card status 0x0
[   62.470000] end_request: I/O error, dev mmcblk0, sector 7586
[   62.470000] mmcblk0: error -123 sending read/write command, response 0x0, 
card status 0x0
[   62.480000] end_request: I/O error, dev mmcblk0, sector 7587
[   62.490000] mmcblk0: error -123 sending read/write command, response 0x0, 
card status 0x0
[   62.490000] end_request: I/O error, dev mmcblk0, sector 7588
[   62.500000] mmcblk0: error -123 sending read/write command, response 0x0, 
card status 0x0
[   62.510000] end_request: I/O error, dev mmcblk0, sector 7589
[   62.510000] Buffer I/O error on device mmcblk0p1, logical block 940
[   63.770000] mmc_host mmc1: Bus speed (slot 0) = 50000000Hz (slot req 
400000Hz, actual 403225HZ div = 62)
[   64.270000] mmc_host mmc1: Timeout sending command (cmd 0x202000 arg 0x0 
status 0x80202000)

In normal case, the log message have to go through as below and usually it is, 
except on certain case.

[   80.620000] mmcblk0: error -123 sending read/write command, response 0x0, 
card status 0x0
[   80.620000] mmcblk0: error -123 requesting status
[   80.620000] end_request: I/O error, dev mmcblk0, sector 7614
[   82.930000] mmc_host mmc1: Bus speed (slot 0) = 50000000Hz (slot req 
400000Hz, actual 403225HZ div = 62)
[   83.730000] mmc_host mmc1: Bus speed (slot 0) = 50000000Hz (slot req 
50000000Hz, actual 25000000HZ div = 1)
[   83.750000] mmc1: new high speed SD card at address 0007
[   83.760000] mmcblk0: mmc1:0007 SD02G 1.84 GiB 
[   83.780000]  mmcblk0: p1

Below is the log message with my change to reset the bit, Hardware Locked Error.
This error is not happening always, I was testing the driver removing mmc card 
without unmount.

[  118.310000] end_request: I/O error, dev mmcblk1, sector 1108
[  118.310000] mmcblk1: error -123 sending read/write command, response 0x0, 
card status 0x0
[  118.310000] end_request: I/O error, dev mmcblk1, sector 1109
[  124.190000] mmc_host mmc1: Bus speed (slot 0) = 50000000Hz (slot req 
400000Hz, actual 403225HZ div = 62)
[  124.690000] mmc_host mmc1: Timeout sending command (cmd 0x202000 arg 0x0 
status 0x80202000)
[  124.690000] mmc_host mmc1: Hardware locked error (cmd 0x202000 arg 0x0)
[  125.550000] mmc_host mmc1: Bus speed (slot 0) = 50000000Hz (slot req 
50000000Hz, actual 25000000HZ div = 1)
[  125.560000] mmc1: new high speed SD card at address 0007
[  125.560000] mmcblk0: mmc1:0007 SD02G 1.84 GiB 
[  125.570000]  mmcblk0: p1

Cheers,
Dongjin.

> > Cheers,
> > Dongjin.
> > 
> > diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> > index 2f7f5ee..05ccee8 100644
> > --- a/drivers/mmc/host/dw_mmc.c
> > +++ b/drivers/mmc/host/dw_mmc.c
> > @@ -520,15 +520,33 @@ static void mci_send_cmd(struct dw_mci_slot *slot, u32 
> > cmd, u32 arg)
> >  	struct dw_mci *host = slot->host;
> >  	unsigned long timeout = jiffies + msecs_to_jiffies(500);
> >  	unsigned int cmd_status = 0;
> > +	u32 ctrl;
> >  
> > +resend:
> >  	mci_writel(host, CMDARG, arg);
> >  	wmb();
> >  	mci_writel(host, CMD, SDMMC_CMD_START | cmd);
> > +
> >  	while (time_before(jiffies, timeout)) {
> >  		cmd_status = mci_readl(host, CMD);
> >  		if (!(cmd_status & SDMMC_CMD_START))
> >  			return;
> > +
> > +		if (host->cmd_status & SDMMC_INT_HLE) {
> > +			dev_err(&slot->mmc->class_dev,
> > +				"Hardware locked error (cmd %#x arg %#x)\n",
> > +				cmd, arg);
> > +
> > +			ctrl = mci_readl(host, CTRL);
> > +			ctrl |= SDMMC_CTRL_RESET;
> > +			mci_writel(host, CTRL, ctrl);
> > +
> > +			host->cmd_status &= ~SDMMC_INT_HLE;
> > +
> > +			goto resend;
> > +		}
> >  	}
> > +
> >  	dev_err(&slot->mmc->class_dev,
> >  		"Timeout sending command (cmd %#x arg %#x status %#x)\n",
> >  		cmd, arg, cmd_status);
> > @@ -1429,6 +1447,12 @@ static irqreturn_t dw_mci_interrupt(int irq, void 
> > *dev_id)
> >  		if (!pending)
> >  			break;
> >  
> > +		if (pending & SDMMC_INT_HLE) {
> > +			mci_writel(host, RINTSTS, SDMMC_INT_HLE);
> > +			host->cmd_status = status;
> > +			smp_wmb();
> > +		}
> > +
> >  		if (pending & DW_MCI_CMD_ERROR_FLAGS) {
> >  			mci_writel(host, RINTSTS, DW_MCI_CMD_ERROR_FLAGS);
> >  			host->cmd_status = status;
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> > the body of a message to majordomo <at> vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo <at> vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 




