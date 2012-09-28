From: Yuchi Xu <yuchi.xu@gmail.com>
Subject: mmc:block: Some damaged SD card always reports its state is PROGRAMMING
Date: Fri, 28 Sep 2012 03:05:04 +0000 (UTC)
Message-ID: <loom.20120928T034611-225@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:33869 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754916Ab2I1DT7 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 27 Sep 2012 23:19:59 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkm-linux-mmc@m.gmane.org>)
	id 1THR7T-0001v2-9a
	for linux-mmc@vger.kernel.org; Fri, 28 Sep 2012 05:20:03 +0200
Received: from 218.249.47.126 ([218.249.47.126])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Fri, 28 Sep 2012 05:20:03 +0200
Received: from yuchi.xu by 218.249.47.126 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Fri, 28 Sep 2012 05:20:03 +0200
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Dear maintainers
     Some damaged sd card always report its state is PROGRAMMING.
     The code paste below in block.c(linux kernel 3.4) will be a dead loop.
     
     /*
	 * Everything else is either success, or a data error of some
	 * kind.  If it was a write, we may have transitioned to
	 * program mode, which we have to wait for it to complete.
	 */
	if (!mmc_host_is_spi(card->host) && rq_data_dir(req) != READ) {
		u32 status;
		do {
			int err = get_card_status(card, &status, 5);
			if (err) {
				pr_err("%s: error %d requesting status\n",
				       req->rq_disk->disk_name, err);
				return MMC_BLK_CMD_ERR;
			}
			/*
			 * Some cards mishandle the status bits,
			 * so make sure to check both the busy
			 * indication and the card state.
			 */
		} while (!(status & R1_READY_FOR_DATA) ||
			 (R1_CURRENT_STATE(status) == R1_STATE_PRG));
	}

