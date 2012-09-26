From: Anton Vorontsov <anton.vorontsov@linaro.org>
Subject: Re: [PATCH] mmc: remove MMC_CAP_NEEDS_POLL setting in sdhci_add_host
Date: Wed, 26 Sep 2012 16:49:36 -0700
Message-ID: <20120926234936.GB7203@lizard>
References: <1348554847-14190-1-git-send-email-yongd@marvell.com>
 <20120925070401.GA32230@lizard>
 <89813612683626448B837EE5A0B6A7CB30384F5CAD@SC-VEXCH4.marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:47808 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751054Ab2IZXwf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 26 Sep 2012 19:52:35 -0400
Received: by yenm12 with SMTP id m12so353245yen.19
        for <linux-mmc@vger.kernel.org>; Wed, 26 Sep 2012 16:52:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <89813612683626448B837EE5A0B6A7CB30384F5CAD@SC-VEXCH4.marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yong Ding <yongd@marvell.com>
Cc: Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Daniel Drake <dsd@laptop.org>, Zhangfei Gao <zgao6@marvell.com>

On Tue, Sep 25, 2012 at 02:13:10AM -0700, Yong Ding wrote:
[...]
> So, in all, u are right if with my current patch, some host drivers need
> some improvement to add MMC_CAP_NEEDS_POLL when it is actually needed.
> But I think this shall be the right way to follow. Or, we might enable
> polling for some cases in which it is unnecessary, and maybe this is a
> potential issue-bomb. How do u think?

I think if you carefully review and fixup all the drivers, it will be
fine.

But you'd have to add MMC_CAP_NEEDS_POLL into drivers' code (while w/ the
quirk it's less lines of code for drivers).

So, here is another idea: how about something like this

#define SDHCI_QUIRK_NEEDS_POLL \
	(SDHCI_QUIRK_BROKEN_CARD_DETECTION | (1 << NN))

And changing the logic to:

	if ((host->quirks & SDHCI_QUIRK_NEEDS_POLL) &&
	    !(host->mmc->caps & MMC_CAP_NONREMOVABLE))
		mmc->caps |= MMC_CAP_NEEDS_POLL;

And then, you'd just convert all the current drivers to
SDHCI_QUIRK_NEEDS_POLL (which would be 100% safe), and for your driver,
you'd only set SDHCI_QUIRK_BROKEN_CARD_DETECTION.

Thanks,
Anton.
