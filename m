From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [RFC] dw_mmc: didn't support multiple blocks of weird length?
Date: Fri, 25 Feb 2011 16:35:00 +0900
Message-ID: <4D675BA4.4040006@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:20150 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755290Ab1BYHfD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 25 Feb 2011 02:35:03 -0500
Received: from epmmp1 (mailout2.samsung.com [203.254.224.25])
 by mailout2.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LH500MR4X2D7500@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 25 Feb 2011 16:35:01 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LH50024VX2DHK@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 25 Feb 2011 16:35:01 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: will.newton@imgtec.com, Kyungmin Park <kyungmin.park@samsung.com>, Chris Ball <cjb@laptop.org>

Hi..

I didn't understand this point..
Plz let me explain this code..
why need this function (dw_mci_queue_request(host, slot, mrq)?


static void dw_mci_queue_request(struct dw_mci *host, struct dw_mci_slot *slot,
				 struct mmc_request *mrq)
{
	dev_vdbg(&slot->mmc->class_dev, "queue request: state=%d\n",
		 host->state);

	spin_lock_bh(&host->lock);
	slot->mrq = mrq;

	if (host->state == STATE_IDLE) {
		host->state = STATE_SENDING_CMD;
		dw_mci_start_request(host, slot);
	} else {
		list_add_tail(&slot->queue_node, &host->queue);
	}

	spin_unlock_bh(&host->lock);
}

static void dw_mci_request(struct mmc_host *mmc, struct mmc_request *mrq)
{
	struct dw_mci_slot *slot = mmc_priv(mmc);
	struct dw_mci *host = slot->host;

	WARN_ON(slot->mrq);

	if (!test_bit(DW_MMC_CARD_PRESENT, &slot->flags)) {
		mrq->cmd->error = -ENOMEDIUM;
		mmc_request_done(mmc, mrq);
		return;
	}

	/* We don't support multiple blocks of weird lengths. */
	dw_mci_queue_request(host, slot, mrq);
}
