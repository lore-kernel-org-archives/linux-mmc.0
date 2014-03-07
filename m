From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v7 1/4] mmc: omap_hsmmc: Enable SDIO IRQ.
Date: Fri, 7 Mar 2014 08:04:42 -0800
Message-ID: <20140307160442.GA3789@atomide.com>
References: <1393331866-28307-1-git-send-email-afenkart@gmail.com>
 <1393331866-28307-2-git-send-email-afenkart@gmail.com>
 <5310C1AC.5060301@ti.com>
 <CALtMJEA9opDbEb1HRbA3CdOc3UigrpeD1bhaNAgyEKehsBDvgg@mail.gmail.com>
 <5319E1C1.9000107@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:44071 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751578AbaCGQEw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 7 Mar 2014 11:04:52 -0500
Content-Disposition: inline
In-Reply-To: <5319E1C1.9000107@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Balaji T K <balajitk@ti.com>
Cc: Andreas Fenkart <afenkart@gmail.com>, Chris Ball <cjb@laptop.org>, Grant Likely <grant.likely@secretlab.ca>, Felipe Balbi <balbi@ti.com>, Daniel Mack <zonque@gmail.com>, Kumar Gala <galak@codeaurora.org>, linux-doc@vger.kernel.org, linux-mmc <linux-mmc@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>

* Balaji T K <balajitk@ti.com> [140307 07:15]:
> On Wednesday 05 March 2014 02:00 PM, Andreas Fenkart wrote:
> >2014-02-28 18:04 GMT+01:00 Balaji T K <balajitk@ti.com>:
> >>
> >>I tried testing this patch series on am335x, I see throughput in the
> >>range of KBs. Will give another try with Tony's version.
> >KB sounds really bad, even with polling I have > 5MBytes/s.
> >
> >Could you pls paste
> ># cat /sys/kernel/debug/mmc0/regs
> >
> Hi,
> 
> Find below debug reg dump
> 
> mmc0:
> sdio irq        enabled
> pinmux config   sdio
> ctx_loss:       1
> 
> regs:
> CON:            0x00000600
> PSTATE:         0x01f70000
> HCTL:           0x00000d06
> SYSCTL:         0x000d0087
> IE:             0x00000100
> ISE:            0x00000100
> CAPA:           0x06e10080

Is this with wl12xx? If so, wl12xx driver is missing calls to
sdio_claim_irq() and sdio_release_irq() so it probably won't
behave properly with the SDIO interrupt until those are added.

Regards,

Tony
