From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: re: mmc: dw_mmc: rework the code related to cmd/data completion
Date: Wed, 6 Nov 2013 19:16:35 +0300
Message-ID: <20131106161635.GJ15603@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:18680 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750841Ab3KFQQq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 6 Nov 2013 11:16:46 -0500
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: tgih.jun@samsung.com
Cc: linux-mmc@vger.kernel.org

Hello Seungwon Jeon,

This is a semi-automatic email about new static checker warnings.

The patch e352c8131100: "mmc: dw_mmc: rework the code related to 
cmd/data completion" from Aug 31, 2013, leads to the following Smatch 
complaint:

drivers/mmc/host/dw_mmc.c:1339 dw_mci_tasklet_func()
	 error: we previously assumed 'data->stop' could be null (see line 1337)

drivers/mmc/host/dw_mmc.c
  1336				if (!err) {
  1337					if (!data->stop || mrq->sbc) {
                                             ^^^^^^^^^^
New check.

  1338						if (mrq->sbc)
  1339							data->stop->error = 0;
                                                        ^^^^^^^^^^
New unchecked dereference.  Should the check be "if (data->stop)"
instead of "if (mrq->sbc)"?

  1340						dw_mci_request_end(host, mrq);
  1341						goto unlock;

regards,
dan carpenter
