From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] mmci: drop superfluous regulator #ifdef
Date: Thu, 2 Dec 2010 14:02:57 +0000
Message-ID: <20101202140257.GD3182@sirena.org.uk>
References: <1291297018-3074-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:47907 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757589Ab0LBOC7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 2 Dec 2010 09:02:59 -0500
Content-Disposition: inline
In-Reply-To: <1291297018-3074-1-git-send-email-linus.walleij@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@stericsson.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, Dec 02, 2010 at 02:36:58PM +0100, Linus Walleij wrote:
> The regulator and MMC frameworks provide the proper stub functions
> for the regulator functions anyway, get rid of this.

It's more that the regulator API stubs have been changed to match what
MMC is doing (there always were stubs) but that doesn't make any
material difference.

> Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>

Reviewed-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
