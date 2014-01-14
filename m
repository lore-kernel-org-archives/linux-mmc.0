From: Chao Xu <caesarxuchao@gmail.com>
Subject: wl1271: sdio: is fine-grained runtime_pm possible?
Date: Mon, 13 Jan 2014 20:58:02 -0600
Message-ID: <CAKZq+rdaCivZTFSTGt9_Q+3KFE9Ft0XfmWZ=1Vr7QcDDs9=Muw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qe0-f50.google.com ([209.85.128.50]:39273 "EHLO
	mail-qe0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751384AbaANC6E (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 13 Jan 2014 21:58:04 -0500
Received: by mail-qe0-f50.google.com with SMTP id 1so8025328qec.23
        for <linux-mmc@vger.kernel.org>; Mon, 13 Jan 2014 18:58:02 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Luciano Coelho <luciano.coelho@intel.com>, chris@printf.net, ohad@wizery.com, linux-mmc@vger.kernel.org

Hi,

The patch "SDIO Runtime PM Support" implements the pm for wl12xx
driver this way: the power for sdio is on whenever the WLAN interface
is on, and the power is down only when the interface is down.
Is it possible to do pm in a more fine-grained way, such as only
turning on the power when reading/writing through sdio? An example is
the mmc_blk_issue_rq() in drivers/mmc/card/block.c, where the host is
released when there are no more requests. And in turn the host driver,
such as omap_hsmmc.c, calls pm_runtime_put_autosuspend().
Is there any fundamental argument against doing fine-grained runtime
pm for sdio? Or is it just too much trouble for too little power
saved?
Thank you!
-- 
Regards,
Chao Xu
