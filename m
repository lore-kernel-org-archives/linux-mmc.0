From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: mmc: sdio: runtime PM and 8686 problems
Date: Wed, 30 Nov 2011 16:29:21 +0200
Message-ID: <CAK=WgbYRvsOur6RmAYMEAf-01e-paGinPU4G_0VesacPGBD5GA@mail.gmail.com>
References: <WC20111118085327.010279@terrafix.co.uk> <CAK=WgbZvcTqmpT0jWT1b-GN1e5091AikAfL88Q8Z66dsOXx6Og@mail.gmail.com>
 <WC20111118100011.2902A2@terrafix.co.uk> <CAK=WgbaJ-q4TqgV5tdPQPm6CT9roceqn6QMxEJgA=Prd52jVEQ@mail.gmail.com>
 <WC20111129111750.470087@terrafix.co.uk> <CAK=Wgbb6s_BGfJYAoH3V77QvWoAXVAchg0ojBx4Mbmgq8bgvWw@mail.gmail.com>
 <CAMLZHHRF2ygqBRyNm21vv0WnCYKPtduGpW7ME25z55v7nTaRnA@mail.gmail.com>
 <CAK=WgbY22BD8WWk71nL3=D3NZfJY92LXUum8yhV3JyHypjOe-g@mail.gmail.com> <CAMLZHHRfitBnmXi=2ndvm5-jm1Mg4+NT83rjuwD9w236E12hQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:56048 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752377Ab1K3O3p (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Nov 2011 09:29:45 -0500
Received: by ggnr5 with SMTP id r5so657439ggn.19
        for <linux-mmc@vger.kernel.org>; Wed, 30 Nov 2011 06:29:44 -0800 (PST)
In-Reply-To: <CAMLZHHRfitBnmXi=2ndvm5-jm1Mg4+NT83rjuwD9w236E12hQw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: Joe Woodward <jw@terrafix.co.uk>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

On Wed, Nov 30, 2011 at 4:12 PM, Daniel Drake <dsd@laptop.org> wrote:
> My patch simply sets a flag to enable a whole load of code written by
> you - code which I understand little about. I am now available to
> help, but given that my understanding of mmc is limited, I didn't
> write the code in question, and I also lack expert insight into 8686
> powerup, I'm not sure how useful I can be.

Let's revert 08da834 then.

When SDIO runtime PM was originally introduced, we immediately faced
two regressions with two different chipsets, and in response decided
not to enable it by default.

With your work on the 8686 we hoped we found all the gotchas, so
08da834 did make sense (at least experimentally).

Unfortunately we now see that some setups out there still refuse to
work when SDIO runtime PM is enabled by default, and obviously we
can't live with these kind of regressions.

commit fd9fec7a00f58a16803e37a99a014ef82543ef6f
Author: Ohad Ben-Cohen <ohad@wizery.com>
Date:   Wed Nov 30 16:22:13 2011 +0200

    Revert "mmc: enable runtime PM by default"

    When SDIO runtime PM was originally introduced, we immediately faced
    two regressions with two different chipsets, and in response decided
    not to enable it by default.

    With the recent work on the 8686 we hoped we found all the gotchas,
    so 08da834 did make sense (at least experimentally).

    Unfortunately we now see that some setups out there still refuse to work
    when SDIO runtime PM is enabled by default (see
    http://www.spinics.net/lists/linux-mmc/msg11161.html), and obviously we
    can't live with these kind of regressions.

    This reverts commit 08da834a24312157f512224691ad1fddd11c1073.

    Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
    Cc: Daniel Drake <dsd@laptop.org>

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index e8a5eb3..d31c78b 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -302,17 +302,6 @@ struct mmc_host *mmc_alloc_host(int extra, struct
device *dev)
 	host->max_blk_size = 512;
 	host->max_blk_count = PAGE_CACHE_SIZE / 512;

-	/*
-	 * Enable runtime power management by default. This flag was added due
-	 * to runtime power management causing disruption for some users, but
-	 * the power on/off code has been improved since then.
-	 *
-	 * We'll enable this flag by default as an experiment, and if no
-	 * problems are reported, we will follow up later and remove the flag
-	 * altogether.
-	 */
-	host->caps = MMC_CAP_POWER_OFF_CARD;
-
 	return host;

 free:
