From: Jan Glauber <jglauber@cavium.com>
Subject: mmc_card_blockaddr() now private
Date: Mon, 30 Jan 2017 14:52:19 +0100
Message-ID: <20170130135219.GA10099@wintermute>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33353 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753508AbdA3NwX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 30 Jan 2017 08:52:23 -0500
Received: by mail-wm0-f67.google.com with SMTP id v77so16303417wmv.0
        for <linux-mmc@vger.kernel.org>; Mon, 30 Jan 2017 05:52:22 -0800 (PST)
Received: from wintermute (HSI-KBW-109-193-044-188.hsi7.kabel-badenwuerttemberg.de. [109.193.44.188])
        by smtp.gmail.com with ESMTPSA id l10sm23024882wrb.44.2017.01.30.05.52.20
        for <linux-mmc@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 30 Jan 2017 05:52:20 -0800 (PST)
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hi,

preparing mmc patches against linux-next I noticed that
mmc_card_blockaddr is now private to the mmc core.

We've been using that in the (not yet upstream) Cavium mmc driver like this:

static void prepare_ext_dma(struct mmc_host *mmc, ...
	...
	emm_dma->s.sector = mmc_card_blockaddr(mmc->card) ? 1 : 0;
	

So the hardware controller needs to know if we use 512 byte blocks
or not which seems to be dependent on the medium size.

Any ideas on how I can implement this without mmc_card_blockaddr() ?

thanks,
Jan
