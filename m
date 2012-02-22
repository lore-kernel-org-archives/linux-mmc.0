From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3 0/6] mmc: sdhci-s3c: Rework platform data and add
 device tree support
Date: Wed, 22 Feb 2012 12:58:23 +0000
Message-ID: <20120222125823.GA14463@sirena.org.uk>
References: <1328032576-9269-1-git-send-email-thomas.abraham@linaro.org>
 <003401cce730$baf979a0$30ec6ce0$%kim@samsung.com>
 <m2aa4pkq5g.fsf@bob.laptop.org>
 <4F3CFEED.6060206@samsung.com>
 <m239abgc32.fsf@bob.laptop.org>
 <00b901ccf08d$2fc18b50$8f44a1f0$%kim@samsung.com>
 <m2vcn0496y.fsf@bob.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:54064 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751186Ab2BVM6n (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Feb 2012 07:58:43 -0500
Content-Disposition: inline
In-Reply-To: <m2vcn0496y.fsf@bob.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Kukjin Kim <kgene.kim@samsung.com>, 'Thomas Abraham' <thomas.abraham@linaro.org>, linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, linux-samsung-soc@vger.kernel.org, ben-linux@fluff.org, patches@linaro.org

On Tue, Feb 21, 2012 at 08:17:41AM -0500, Chris Ball wrote:

> Pushed to mmc-next, thanks.  (I'm expecting that you'll do the merge
> to Linus.)

I've been sending patches adding runtime PM support to this driver for a
while with no response - are there any issues with those?
