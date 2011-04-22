From: Paul Parsons <lost.distance@yahoo.com>
Subject: Re: [PATCH] MMC: tmio: fix a recent regression: restore .set_ios(MMC_POWER_UP) handling
Date: Fri, 22 Apr 2011 12:13:02 +0100 (BST)
Message-ID: <57837.39952.qm@web29020.mail.ird.yahoo.com>
References: <504862.26396.qm@web29015.mail.ird.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from nm13.bullet.mail.ird.yahoo.com ([77.238.189.66]:23162 "HELO
	nm13.bullet.mail.ird.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754832Ab1DVLNF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 22 Apr 2011 07:13:05 -0400
In-Reply-To: <504862.26396.qm@web29015.mail.ird.yahoo.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <damm@opensource.se>, Simon Horman <horms@verge.net.au>, Ian Molton <ian@mnementh.co.uk>

--- On Fri, 22/4/11, Paul Parsons <lost.distance@yahoo.com> wrote:
> As far as I can see the expression
> 
> (ios->clock == 0 && ios->power_mode ==
> MMC_POWER_ON)
> 
> will only be true if host->f_init == 0 at the time
> MMC_POWER_ON is invoked in mmc_power_up(). Presumably that
> case is intentional.

Sorry, ignore this; I missed the case where mmc_gate_clock() sets ios->clock = 0 before calling mmc_set_ios().
