From: Dong Aisheng <dongas86@gmail.com>
Subject: Re: [V2, 10/15] mmc: sdhci-esdhc-imx: enable hw auto retuning for
 MAN_TUNING
Date: Tue, 16 Aug 2016 18:18:18 +0800
Message-ID: <20160816101818.GD9211@shlinux2>
References: <1468309584-3591-11-git-send-email-aisheng.dong@nxp.com>
 <20160815145941.GA23663@t450s.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34502 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753133AbcHPK1z (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 16 Aug 2016 06:27:55 -0400
Received: by mail-pf0-f195.google.com with SMTP id g202so5315946pfb.1
        for <linux-mmc@vger.kernel.org>; Tue, 16 Aug 2016 03:27:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160815145941.GA23663@t450s.lan>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Gary Bisson <gary.bisson@boundarydevices.com>
Cc: Dong Aisheng <aisheng.dong@nxp.com>, linux-mmc@vger.kernel.org, ulf.hansson@linaro.org, chris@printf.net, haibo.chen@nxp.com, adrian.hunter@intel.com, shawnguo@kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, Aug 15, 2016 at 04:59:41PM +0200, Gary Bisson wrote:
> Dong Aisheng, All,
> 
> On Tue, Jul 12, 2016 at 03:46:19PM +0800, Dong Aisheng wrote:
> > Indicating hw auto retuning support for mx6qdl in the fake caps_1
> > register and enable auto retuning in post_tuning process after
> > tuning completes.
> 
> Have you tried this change with a SDIO3.0 device? I'm asking because a

Tested with SD3.0 device.
Not really for SDIO3.0 device since there's no SDIO3.0 device on my
available MX6Q/DL boards.

> similar change in latest NXP 4.1.15 kernel broke SDIO3.0 support.
> With this tuning, the kernel would report:
> mmc2: Got data interrupt 0x00000002 even though no data operation was in
> progress.
> 

Can you provide the full enumeration log?

> Doing a 'git bisect' and then reverting this patch fixed the issue.
> Although I haven't tested that change on mainline kernel, I wanted you
> to know about this observation before it gets merged.
> 
> As a FYI, the issue has been reported to NXP community:
> https://community.nxp.com/thread/431316
> 

Thanks for nofity.
I will check it on my side.

Regards
Dong Aisheng

> Regards,
> Gary
