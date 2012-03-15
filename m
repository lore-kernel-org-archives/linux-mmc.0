From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 5/5] MMC: mmci: Add required documentation for Device
	Tree bindings
Date: Thu, 15 Mar 2012 17:59:19 +0000
Message-ID: <20120315175919.GI15988@n2100.arm.linux.org.uk>
References: <1331734803-17954-1-git-send-email-lee.jones@linaro.org> <1331734803-17954-6-git-send-email-lee.jones@linaro.org> <201203151753.25774.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:54965 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031066Ab2COR7b (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 15 Mar 2012 13:59:31 -0400
Content-Disposition: inline
In-Reply-To: <201203151753.25774.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Lee Jones <lee.jones@linaro.org>, niklas.hernaeus@linaro.org, cjb@laptop.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, Mar 15, 2012 at 05:53:25PM +0000, Arnd Bergmann wrote:
> On Wednesday 14 March 2012, Lee Jones wrote:
> > +
> > +Optional properties:
> > +- ocr_mask               : contains the regulator oscillator mask
> 
> Not sure about this one. If it's for the regulators, we should be
> using the regulator bindings.

It's also nothing to do with oscillators.
