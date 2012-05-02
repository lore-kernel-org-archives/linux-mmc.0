From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/7] mmc: dw_mmc: lookup for optional biu and ciu clocks
Date: Wed, 2 May 2012 10:53:11 +0100
Message-ID: <20120502095311.GZ24211@n2100.arm.linux.org.uk>
References: <1335935266-25289-1-git-send-email-thomas.abraham@linaro.org> <1335935266-25289-2-git-send-email-thomas.abraham@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:45008 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751587Ab2EBJx1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 2 May 2012 05:53:27 -0400
Content-Disposition: inline
In-Reply-To: <1335935266-25289-2-git-send-email-thomas.abraham@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Thomas Abraham <thomas.abraham@linaro.org>
Cc: linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-samsung-soc@vger.kernel.org, patches@linaro.org, linux-kernel@vger.kernel.org, rob.herring@calxeda.com, grant.likely@secretlab.ca, kgene.kim@samsung.com, cjb@laptop.org, linux-arm-kernel@lists.infradead.org

On Tue, May 01, 2012 at 10:07:40PM -0700, Thomas Abraham wrote:
> Some platforms allow for clock gating and control of bus interface unit clock
> and card interface unit clock. Add support for clock lookup of optional biu
> and ciu clocks for clock gating and clock speed determination.

As we're moving progressively towards the common clk API, which requires
the new clk_prepare/clk_unprepare calls, new code should be using the
dated API.  Please update this to do so (eg, by using clk_prepare_enable()
instead of clk_enable() for the simple solution.)  Better solutions
involve decoupling the two and only using clk_enable()/clk_disable() where
you really need the clock to be on.
