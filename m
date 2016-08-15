From: Gary Bisson <gary.bisson@boundarydevices.com>
Subject: Re: [V2, 10/15] mmc: sdhci-esdhc-imx: enable hw auto retuning for
 MAN_TUNING
Date: Mon, 15 Aug 2016 16:59:41 +0200
Message-ID: <20160815145941.GA23663@t450s.lan>
References: <1468309584-3591-11-git-send-email-aisheng.dong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:37016 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753148AbcHOO7s (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 15 Aug 2016 10:59:48 -0400
Received: by mail-wm0-f45.google.com with SMTP id i5so108678559wmg.0
        for <linux-mmc@vger.kernel.org>; Mon, 15 Aug 2016 07:59:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1468309584-3591-11-git-send-email-aisheng.dong@nxp.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dong Aisheng <aisheng.dong@nxp.com>
Cc: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org, dongas86@gmail.com, chris@printf.net, haibo.chen@nxp.com, adrian.hunter@intel.com, shawnguo@kernel.org, linux-arm-kernel@lists.infradead.org

Dong Aisheng, All,

On Tue, Jul 12, 2016 at 03:46:19PM +0800, Dong Aisheng wrote:
> Indicating hw auto retuning support for mx6qdl in the fake caps_1
> register and enable auto retuning in post_tuning process after
> tuning completes.

Have you tried this change with a SDIO3.0 device? I'm asking because a
similar change in latest NXP 4.1.15 kernel broke SDIO3.0 support.
With this tuning, the kernel would report:
mmc2: Got data interrupt 0x00000002 even though no data operation was in
progress.

Doing a 'git bisect' and then reverting this patch fixed the issue.
Although I haven't tested that change on mainline kernel, I wanted you
to know about this observation before it gets merged.

As a FYI, the issue has been reported to NXP community:
https://community.nxp.com/thread/431316

Regards,
Gary
