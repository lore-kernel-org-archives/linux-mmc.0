Return-Path: <SRS0=xqUN=54=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE16C2BA2B
	for <linux-mmc@archiver.kernel.org>; Sun, 12 Apr 2020 09:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39A1F20575
	for <linux-mmc@archiver.kernel.org>; Sun, 12 Apr 2020 09:04:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725909AbgDLJEj (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 12 Apr 2020 05:04:39 -0400
Received: from mga12.intel.com ([192.55.52.136]:20973 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725832AbgDLJEj (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sun, 12 Apr 2020 05:04:39 -0400
IronPort-SDR: vn0melHGn/GUWwF+NiZp62A0bWx5M3rUjLa2kVuugniCELb7w3R7wC5hBGv6dHlIuUEaiWfP94
 +fQEM3jW9g/A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2020 02:04:38 -0700
IronPort-SDR: cWhgeB0AvGa4ooT1rDH7SKq4toiNo911gth5qqZ1l3lmMYG178vH6hykczhRDbFDLmY5gIKlRE
 X9Z+Tx7Gemeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,374,1580803200"; 
   d="scan'208";a="362835148"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.87])
  by fmsmga001.fm.intel.com with ESMTP; 12 Apr 2020 02:04:37 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Baolin Wang <baolin.wang7@gmail.com>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>
Subject: [PATCH 0/5] mmc: sdhci: Reduce maximum time under spinlock in sdhci_send_command()
Date:   Sun, 12 Apr 2020 12:03:44 +0300
Message-Id: <20200412090349.1607-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi

Here are some patches to reduce maximum time under spinlock in
sdhci_send_command(), but also pave the way for an atomic request
function.

I haven't tried it, but with these patches, something like below
should work.



static int sdhci_atomic_request(struct mmc_host *mmc,
				struct mmc_request *mrq)
{
	struct sdhci_host *host = mmc_priv(mmc);
	struct mmc_command *cmd;
	unsigned long flags;
	int ret = 0;

	spin_lock_irqsave(&host->lock, flags);

	if (sdhci_present_error(host, mrq->cmd, true))
		goto out_finish;

	cmd = sdhci_manual_cmd23(host, mrq) ? mrq->sbc : mrq->cmd;

	if (sdhci_send_command(host, cmd))
		sdhci_led_activate(host);
	else
		ret = -EBUSY;

	spin_unlock_irqrestore(&host->lock, flags);

	return ret;

out_finish:
	sdhci_finish_mrq(host, mrq);
	spin_unlock_irqrestore(&host->lock, flags);
	return 0;
}



Adrian Hunter (5):
      mmc: sdhci: Add helpers for the auto-CMD23 flag
      mmc: sdhci: Stop exporting sdhci_send_command()
      mmc: sdhci: Remove unneeded forward declaration of sdhci_finish_data()
      mmc: sdhci: Tidy sdhci_request() a bit
      mmc: sdhci: Reduce maximum time under spinlock in sdhci_send_command()

 drivers/mmc/host/sdhci.c | 182 +++++++++++++++++++++++++++++++++++------------
 drivers/mmc/host/sdhci.h |   2 +-
 2 files changed, 139 insertions(+), 45 deletions(-)



Regards
Adrian
