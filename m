From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 0/3] RFC/RFT: Powering on MMC Wifi/BT modules in MMC
	core
Date: Thu, 30 Jan 2014 21:49:17 +0000
Message-ID: <20140130214917.GE15937@n2100.arm.linux.org.uk>
References: <1390190215-22700-1-git-send-email-olof@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:53351 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753814AbaA3Vt0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 30 Jan 2014 16:49:26 -0500
Content-Disposition: inline
In-Reply-To: <1390190215-22700-1-git-send-email-olof@lixom.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Olof Johansson <olof@lixom.net>, Chris Ball <chris@printf.net>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org, mark.rutland@arm.com, pawel.moll@arm.com, ijc+devicetree@hellion.org.ok, galak@codeaurora.org

On Sun, Jan 19, 2014 at 07:56:52PM -0800, Olof Johansson wrote:
> This is a small series enhancing the MMC core code to power on modules
> before the host in cases where needed, and the corresponding DT bindings
> changes.
> 
> I've got some other issues to debug on the Chromebook, i.e. the interface
> doens't actually work. So far it seems unrelated to this patch set so
> it's worth posting this and get things going since others need the same
> functionality (i.e Cubox-i).
> 
> As mentioned in the patch in the series, I haven't implemented power-down
> yet, I wanted to make sure that the power-on side will be adequate for
> those who are looking to use it right away.
> 
> Comments/test reports/etc welcome.

So, I thought I'd give this a go on the Cubox-i4, and... it doesn't work
there.  It's not your patches, it's down to sdhci-esdhc-imx.c not using
mmc_of_parse() at all, so those new properties have no way to be used
there.

It doesn't look like it could in its current form use mmc_of_parse(),
as the imx code manually parses some of the generic properties to hand
them into the sdhci layer.  This looks icky, and it looks like something
that should be fixed - why should drivers be parsing the core attributes
themselves?

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
