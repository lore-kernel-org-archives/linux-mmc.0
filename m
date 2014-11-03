From: Johan Rudholm <johan.rudholm@axis.com>
Subject: Re: [PATCH 2/4] mmc: core: use mmc_power_up in hw_reset
Date: Mon, 3 Nov 2014 11:13:38 +0100
Message-ID: <CA+20K0BQGP8TQiw_HN5pgM1cV7H8Q0Aw689jDjfpipdKJxEOTA@mail.gmail.com>
References: <1414154790-20893-1-git-send-email-johanru@axis.com>
	<1414154790-20893-3-git-send-email-johanru@axis.com>
	<54574901.3020806@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bes.se.axis.com ([195.60.68.10]:44795 "EHLO bes.se.axis.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750969AbaKCKNo (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 3 Nov 2014 05:13:44 -0500
Received: from localhost (localhost [127.0.0.1])
	by bes.se.axis.com (Postfix) with ESMTP id 83AB52E346
	for <linux-mmc@vger.kernel.org>; Mon,  3 Nov 2014 11:13:42 +0100 (CET)
Received: from bes.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bes.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id FczSz9B52MQI for <linux-mmc@vger.kernel.org>;
	Mon,  3 Nov 2014 11:13:40 +0100 (CET)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
	by bes.se.axis.com (Postfix) with ESMTP id 5E4B42E347
	for <linux-mmc@vger.kernel.org>; Mon,  3 Nov 2014 11:13:40 +0100 (CET)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
	by postfix.imss71 (Postfix) with ESMTP id 08960E2B
	for <linux-mmc@vger.kernel.org>; Mon,  3 Nov 2014 11:13:40 +0100 (CET)
Received: from seth.se.axis.com (seth.se.axis.com [10.0.2.172])
	by boulder.se.axis.com (Postfix) with ESMTP id DA7E8A8A
	for <linux-mmc@vger.kernel.org>; Mon,  3 Nov 2014 11:13:39 +0100 (CET)
Received: from xmail2.se.axis.com (xmail2.se.axis.com [10.0.5.74])
	by seth.se.axis.com (Postfix) with ESMTP id D8BB83E247
	for <linux-mmc@vger.kernel.org>; Mon,  3 Nov 2014 11:13:39 +0100 (CET)
Received: by mail-qc0-f176.google.com with SMTP id x3so8883943qcv.35
        for <linux-mmc@vger.kernel.org>; Mon, 03 Nov 2014 02:13:38 -0800 (PST)
In-Reply-To: <54574901.3020806@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Johan Rudholm <johanru@axis.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, =?UTF-8?Q?David_Lanzend=C3=B6rfer?= <david.lanzendoerfer@o2s.ch>, Jesper Nilsson <jespern@axis.com>

2014-11-03 10:21 GMT+01:00 Adrian Hunter <adrian.hunter@intel.com>:
> On 24/10/14 15:46, Johan Rudholm wrote:
>> The steps performed in mmc_do_hw_reset for eMMC:s after the hardware
>> reset are very similar to those performed by mmc_power_up, so do a call
>
> They perform different functions.  mmc_power_up() does nothing if the card
> is powered up.  To share the common code you need to create a function for
> the common functionality which is setting the initial state e.g.
>
> int mmc_set_initial_state(struct mmc_host *host)
> {
>         ...
> }
>
> And call that from mmc_do_hw_reset and mmc_power_up.

Thank you for the comment. What do you think of doing a complete
mmc_power_cycle after having performed a (successful) reset? In this
way we can simplify the SD card reset and we don't have to break out
the common code from mmc_power_up. Naming discussion apart, something
like this:

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 486cda8..941f631 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2236,12 +2236,15 @@ static void mmc_hw_reset_for_init(struct mmc_host *host)
 static int mmc_do_reset(struct mmc_host *host, int check)
 {
        int ret;
+       struct mmc_card *card = host->card;

        if (!host->bus_ops || !host->bus_ops->power_reset ||
                        host->bus_ops->power_reset(host, MMC_POWER_RESET_TEST))
                return -EOPNOTSUPP;

        ret = host->bus_ops->power_reset(host, check);
+       if (!ret && card)
+               mmc_power_cycle(host, card->ocr);

        pr_warning("%s: tried to reset card (%d)\n", mmc_hostname(host), ret);

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index ac5192c..900133a 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1794,8 +1794,6 @@ static int mmc_power_reset(struct mmc_host
*host, int test)
                }
        }

-       mmc_power_up(host, card->ocr);
-
        mmc_host_clk_release(host);

        return 0;
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 9ad46b2..d5b8ee7 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -1187,8 +1187,6 @@ static int mmc_sd_power_reset(struct mmc_host
*host, int test)
        if (test == MMC_POWER_RESET_TEST)
                return 0;

-       mmc_power_cycle(host, card->ocr);
-
        return 0;
 }

//Johan
