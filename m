From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] mmci: drop superfluous regulator #ifdef
Date: Sun, 19 Dec 2010 16:00:59 +0000
Message-ID: <20101219160059.GP9937@n2100.arm.linux.org.uk>
References: <1291297018-3074-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:43026 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751275Ab0LSQBM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 19 Dec 2010 11:01:12 -0500
Content-Disposition: inline
In-Reply-To: <1291297018-3074-1-git-send-email-linus.walleij@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@stericsson.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, Dec 02, 2010 at 02:36:58PM +0100, Linus Walleij wrote:
> The regulator and MMC frameworks provide the proper stub functions
> for the regulator functions anyway, get rid of this.

I'm dropping this patch - it's wrong, because on platforms without
regulator support, it stamps over the provided platform values:

mmci-pl18x mb:mmci: Provided ocr_mask/setpower will not be used (using regulator instead)

# CONFIG_REGULATOR is not set

So the ifdefs have to stay until some other solution for this is found.
Maybe the:

        if (IS_ERR(host->vcc))
                host->vcc = NULL;
        else {

should be:

        if (IS_ERR(host->vcc) || host->vcc == NULL)
                host->vcc = NULL;
        else {

or maybe:

        if (IS_ERR(host->vcc))
                host->vcc = NULL;
        else if (host->vcc) {
