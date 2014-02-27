From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v7 4/4] mmc: omap_hsmmc: Extend debugfs for SDIO IRQ,
 GPIO and pinmux.
Date: Thu, 27 Feb 2014 13:39:37 -0800
Message-ID: <20140227213936.GM11654@atomide.com>
References: <1393331866-28307-4-git-send-email-afenkart@gmail.com>
 <1393332578-28599-1-git-send-email-afenkart@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:42210 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750979AbaB0Vjv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 27 Feb 2014 16:39:51 -0500
Content-Disposition: inline
In-Reply-To: <1393332578-28599-1-git-send-email-afenkart@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andreas Fenkart <afenkart@gmail.com>
Cc: Chris Ball <cjb@laptop.org>, Grant Likely <grant.likely@secretlab.ca>, Felipe Balbi <balbi@ti.com>, Balaji T K <balajitk@ti.com>, zonque@gmail.com, galak@codeaurora.org, linux-doc@vger.kernel.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org

* Andreas Fenkart <afenkart@gmail.com> [140225 04:57]:
> Add SDIO IRQ entries to debugfs entry. Note that PSTATE shows current
> state of data lines, incl. SDIO IRQ pending
> 
> Signed-off-by: Andreas Fenkart <afenkart@gmail.com>

No changes to this one, so:

Acked-by: Tony Lindgren <tony@atomide.com>
