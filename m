From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] mmc: mxs-mmc: add support for pre_req and post_req
Date: Thu, 28 Apr 2011 11:10:22 +0100
Message-ID: <20110428101022.GA17290@n2100.arm.linux.org.uk>
References: <1303058010-30256-1-git-send-email-shawn.guo@linaro.org> <20110417164830.GE17935@S2100-06.ap.freescale.net> <BANLkTimwvX633UaUoc4P4DD1xnpLbMTrZA@mail.gmail.com> <20110420140120.GF1965@S2100-06.ap.freescale.net> <BANLkTimzk89VC1Vti4CZ60TTJ20e2YpwNg@mail.gmail.com> <20110421062924.GB4024@S2100-06.ap.freescale.net> <BANLkTimq8_R-CJmryTvRWHZ+-2vqj-Y6cQ@mail.gmail.com> <20110421091115.GH4024@S2100-06.ap.freescale.net> <BANLkTim_5fsJ06CTgxAvPjrb8y5FpW=xRg@mail.gmail.com> <BANLkTikq2mu=rNiRuRPjikkpXuH6DKOsFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:35393 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758588Ab1D1KKh (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 28 Apr 2011 06:10:37 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTikq2mu=rNiRuRPjikkpXuH6DKOsFA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Per Forlin <per.forlin@linaro.org>
Cc: Shawn Guo <shawn.guo@freescale.com>, cjb@laptop.org, patches@linaro.org, linux-mmc@vger.kernel.org, linaro-kernel@lists.linaro.org, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org

On Thu, Apr 28, 2011 at 09:52:17AM +0200, Per Forlin wrote:
> I wanted to test the performance without cache penalty but removing
> dma_map_sg may not work since it produces the physical mapped sg list.
> This is not as simple as I first thought. Make a copy for dma_map_sg
> (call it dma_map_sg_no_cache) and modify it to not clean/inc the
> cache. Replace dma_map_sg with dma_map_sg_no_cache in the mxs-mmc
> driver.
> Removing dma_unmap should be ok for this test case.
> Do you still get very low numbers?

We can live in the hope that this is gathering evidence to illustrate
why having DMA incoherent caches are bad news for performance, and that
one day ARM Ltd will one day give us proper DMA cache coherency for all
devices.
