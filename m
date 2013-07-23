From: Grant Grundler <grundler@google.com>
Subject: RFC: clearing clk_old?
Date: Tue, 23 Jul 2013 10:47:39 -0700
Message-ID: <CANEJEGtmqHMvXL7ax=NZ=YXnjq77+rVbO6WbKidxJEQsh=987w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f177.google.com ([209.85.214.177]:37860 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933787Ab3GWRrj (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 23 Jul 2013 13:47:39 -0400
Received: by mail-ob0-f177.google.com with SMTP id ta17so10689709obb.22
        for <linux-mmc@vger.kernel.org>; Tue, 23 Jul 2013 10:47:39 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Doug Anderson <dianders@chromium.org>, Alim Akthar <alim@chromium.org>

I'm trying to see where host->clk_old is cleared in MMC core. Since I
didn't find it, any reason to NOT do one or both of the below patches?

thanks,
grant

ps. This is cut/pasted and white space mangled...hopefully readable though.

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index c9a227c..73c3792 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -787,6 +787,7 @@ void mmc_ungate_clock(struct mmc_host *host)
                BUG_ON(host->ios.clock);
                /* This call will also set host->clk_gated to false */
                __mmc_set_clock(host, host->clk_old);
+               host->clk_old = 0;
        }
 }

@@ -800,6 +801,7 @@ void mmc_set_ungated(struct mmc_host *host)
         */
        spin_lock_irqsave(&host->clk_lock, flags);
        host->clk_gated = false;
+       host->clk_old = 0;
        spin_unlock_irqrestore(&host->clk_lock, flags);
 }



diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index c9a227c..f5ae008 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -800,6 +800,7 @@ void mmc_set_ungated(struct mmc_host *host)
         */
        spin_lock_irqsave(&host->clk_lock, flags);
        host->clk_gated = false;
+       host->clk_old = 0;
        spin_unlock_irqrestore(&host->clk_lock, flags);
 }
