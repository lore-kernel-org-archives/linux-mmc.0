From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] mmci: supply per-instance regulator name
Date: Thu, 2 Dec 2010 12:06:08 +0000
Message-ID: <20101202120608.GC3182@sirena.org.uk>
References: <1291289707-5529-1-git-send-email-linus.walleij@stericsson.com> <20101202115700.GF29347@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:48037 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755394Ab0LBMGL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 2 Dec 2010 07:06:11 -0500
Content-Disposition: inline
In-Reply-To: <20101202115700.GF29347@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Linus Walleij <linus.walleij@stericsson.com>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, Dec 02, 2010 at 11:57:00AM +0000, Russell King - ARM Linux wrote:

> It seems that the regulator code is making all the same mistakes that
> historically were made with the clk API code.

It's not...

> Rather than using the struct device, it's trying to use the regulator

...it does exactly this.  Passing names is not good practice.
