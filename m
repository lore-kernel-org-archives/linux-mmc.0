From: "Dong, Chuanxiao" <chuanxiao.dong@intel.com>
Subject: RE: mmc_core: question on mmc_do_erase function
Date: Wed, 13 Oct 2010 16:35:10 +0800
Message-ID: <5D8008F58939784290FAB48F549751982DD7F0139C@shsmsx502.ccr.corp.intel.com>
References: <5D8008F58939784290FAB48F549751982DD7F00EDB@shsmsx502.ccr.corp.intel.com>
 <4CB5660A.7070808@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:40071 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753133Ab0JMIfV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Oct 2010 04:35:21 -0400
In-Reply-To: <4CB5660A.7070808@nokia.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@nokia.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "Gao, Yunpeng" <yunpeng.gao@intel.com>

> -----Original Message-----
> From: Adrian Hunter [mailto:adrian.hunter@nokia.com]
> Sent: Wednesday, October 13, 2010 3:56 PM
> To: Dong, Chuanxiao
> Cc: linux-mmc@vger.kernel.org; Gao, Yunpeng
> Subject: Re: mmc_core: question on mmc_do_erase function
> 
> On 12/10/10 16:11, Dong, Chuanxiao wrote:
> > Hi adrian
> >
> > I got some questions about MMC driver erase function. Help you can
> > give me some suggestion. My host controller is a kind of SDHCI host
> > controller. And testing below code by using HD micro SD card.
> > +	memset(&cmd, 0, sizeof(struct mmc_command));
> > +	cmd.opcode = MMC_ERASE;
> > +	cmd.arg = arg;
> > +	cmd.flags = MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_AC;
> > +	mmc_set_erase_timeout(card,&cmd, arg, qty);
> > +	err = mmc_wait_for_cmd(card->host,&cmd, 0);
> > +	if (err) {
> > +		printk(KERN_ERR "mmc_erase: erase error %d, status %#x\n",
> > +		       err, cmd.resp[0]);
> > +		err = -EIO;
> > +		goto out;
> > +	}
> > As MMC 4.4 standard said, CMD38 need R1B response. So when SDHCI host
> > controller got a SDHCI_INT_RESPONSE interrupt, driver will ignore
> > this and keep on waiting for a SDHCI_INT_DATA_END interrupt to finish
> > MMC_ERASE command. Then I got problems....My host controller will got
> > a DATA_TIMEOUT interrupt if host controller cannot generate any
> > interrupt during its waiting time, unfortunately the max waiting time
> > for my SDHCI host controller is 5s.
> 
> I don't know SDHCI.  Can you disable the timeout altogether and use a
> timer?
> 
OK, thanks. If hardware can disable the timeout interrupt, I will try use a timer. But if the host controllers cannot disable the their timeout interrupt, what should they do?

> > So if any ERASE operation need
> > more than 5s seconds to finish, my controller will not finish the
> > ERASE operation and only generate a DATA_TIMEOUT interrupt. The ERASE
> > will be failed. Another, MMC driver also has a 10s timer to keep
> > watch over the interrupt, if ERASE operation need more than 10s to
> > finish, this timer also can report a TIMEOUT error. I think
> > cmd->erase_timeout can help to set the timer expires, but how to deal
> > with this issue for SDHCI host controller? How about split ERASE
> > groups to be smaller ones?
> 
> Where is the erase coming from?  A file system?  The discard ioctl?
Erase command comes from the discard ioctl.

> It is possible to set a maximum size for the discard but it pays
> no attention to alignment, so you can get very sub-optimal erases.

