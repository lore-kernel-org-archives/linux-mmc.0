From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v3 1/2] mmc: mmci.c: Defer probe() in case of yet
	uninitialized GPIOs
Date: Sun, 17 Jun 2012 17:21:42 +0100
Message-ID: <20120617162142.GA26446@n2100.arm.linux.org.uk>
References: <1339927893-8842-1-git-send-email-stigge@antcom.de> <1339927893-8842-2-git-send-email-stigge@antcom.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:57452 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757519Ab2FQQXU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 17 Jun 2012 12:23:20 -0400
Content-Disposition: inline
In-Reply-To: <1339927893-8842-2-git-send-email-stigge@antcom.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Roland Stigge <stigge@antcom.de>
Cc: cjb@laptop.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, ulf.hansson@stericsson.com, linus.walleij@linaro.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, aletes.xgr@gmail.com, linux-arm-kernel@lists.infradead.org

On Sun, Jun 17, 2012 at 12:11:32PM +0200, Roland Stigge wrote:
> If the GPIOs used by the MMCI driver are not registered yet when the driver is
> probe()d, they can't be used. This happens if the mmci driver is probed before
> the respective GPIO controller (e.g. on the LPC32xx EA3250 board, the PCA9532
> GPIO controller would be initialized via DT after mmci). Therefore, we defer
> mmci in this case.

I'm much happier with this.  Provided the change to the GPIO OF stuff is
fine.
