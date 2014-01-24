From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH] mxcmmc: Internal error: Oops: 17 [#1] ARM from sg->offset
Date: Fri, 24 Jan 2014 22:52:50 +0100
Message-ID: <20140124215249.GK16215@pengutronix.de>
References: <1390365159-29239-1-git-send-email-chris.ruehl@gtsys.com.hk>
 <20140122064231.GZ16215@pengutronix.de>
 <52DF7114.9070609@gtsys.com.hk>
 <20140122072358.GE16215@pengutronix.de>
 <52E0DA7D.7060309@gtsys.com.hk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:33602 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751633AbaAXVwy (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 24 Jan 2014 16:52:54 -0500
Content-Disposition: inline
In-Reply-To: <52E0DA7D.7060309@gtsys.com.hk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ruehl <chris.ruehl@gtsys.com.hk>
Cc: mpa@pengutronix.de, linux-mmc@vger.kernel.org, linux-arm@lists.infradead.org

On Thu, Jan 23, 2014 at 05:01:49PM +0800, Chris Ruehl wrote:
> On Wednesday, January 22, 2014 03:23 PM, Sascha Hauer wrote:
> >On Wed, Jan 22, 2014 at 03:19:48PM +0800, Chris Ruehl wrote:
> >>On Wednesday, January 22, 2014 02:42 PM, Sascha Hauer wrote:
> >>>On Wed, Jan 22, 2014 at 12:32:39PM +0800, Chris Ruehl wrote:
> >>>>Function mxcmci_request() throw an exception on a imx27 cpu.
> >>>>This patch fix the problem by test the pointer before access it.
> >>>>
> >>>>diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
> >>>>index f7199c8..8645d6a 100644
> >>>>--- a/drivers/mmc/host/mxcmmc.c
> >>>>+++ b/drivers/mmc/host/mxcmmc.c
> >>>>@@ -347,7 +347,7 @@ static int mxcmci_setup_data(struct mxcmci_host *host, struct mmc_data *data)
> >>>>  		return 0;
> >>>>  	for_each_sg(data->sg, sg, data->sg_len, i) {
> >>>>-		if (sg->offset & 3 || sg->length & 3 || sg->length < 512) {
> >>>>+		if (sg && (sg->offset & 3 || sg->length & 3 || sg->length < 512)) {
> >>>The question is why sg is NULL. I think this shouldn't happen.
> >>>
> >>>Sascha
> >>>
> >>Thats was my idea too. But had no time to debug it out.
> >>As for_each_sg() iterate over the sg-list may its not set properly
> >>before - In an earlier post
> >>I ask for help but no-one returned so I quick fixed it.  Maybe now
> >>the bell is loud enough ;-)
> >Please try to track it further down. Does this happen every time you are
> >in this function or does it happen only every once in a while? Does it
> >happen in the first iteration of the loop? is it an SDIO card or regular
> >SD card?
> >
> >Sascha
> >
> Sascha,
> 
> there was a fix for a race condition:
> 
> commit 70aa6109597ea6955a93f16430b588b5ee5ba547
> mmc: mxcmmc: fix race conditions for host->req and host->data access
> 
> do you think its possible that the current oops is kind of race?

Could be, yes. I remember problems that the dma completion interrupt and
the data transfer interrupt came in the wrong (or better: unexpected)
order. Maybe this is not completely solved.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
