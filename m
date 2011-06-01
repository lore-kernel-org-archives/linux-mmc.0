From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 1/2] ARM: OMAP4: MMC: increase delay for pbias
Date: Wed, 1 Jun 2011 04:49:29 -0700
Message-ID: <20110601114929.GB11352@atomide.com>
References: <1306926923-3398-1-git-send-email-balajitk@ti.com>
 <1306926923-3398-2-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:59874 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1162600Ab1FALtd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Jun 2011 07:49:33 -0400
Content-Disposition: inline
In-Reply-To: <1306926923-3398-2-git-send-email-balajitk@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Balaji T K <balajitk@ti.com>
Cc: linux-omap@vger.kernel.org, cjb@laptop.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, madhu.cr@ti.com

* Balaji T K <balajitk@ti.com> [110601 04:13]:
> 4 micro seconds is not enough for PBIAS if MMC regulator is
> enabled from MMC regulator OFF.
> Increase the delay for PBIAS to stabilize.
> Wait for PBIAS and timeout if not.
> 
> Resolves MMC/SD failure on OMAP4
> "Pbias Voltage is not same as LDO"

Thanks for updating this, applying to devel-fixes.

Tony
