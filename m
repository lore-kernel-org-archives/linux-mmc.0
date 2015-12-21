From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2 00/24] MMC/SDHCI fixes
Date: Mon, 21 Dec 2015 12:51:20 +0000
Message-ID: <20151221125120.GZ8644@n2100.arm.linux.org.uk>
References: <20151221113956.GA3712@n2100.arm.linux.org.uk>
 <CAPDyKFogxmczEzXbXACrfn4F2wfM=ZKPVnpK8WSLJA3UT5SKiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:39922 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751145AbbLUMv3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Dec 2015 07:51:29 -0500
Content-Disposition: inline
In-Reply-To: <CAPDyKFogxmczEzXbXACrfn4F2wfM=ZKPVnpK8WSLJA3UT5SKiw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>, linux-mmc <linux-mmc@vger.kernel.org>, Marcin Wojtas <mw@semihalf.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>

On Mon, Dec 21, 2015 at 01:35:36PM +0100, Ulf Hansson wrote:
> I decided to try to apply it for my next branch, to get some good test
> coverage. Although, it failed when reaching patch 8. Would you mind
> posting yet another new re-based version, please.

Given that these are _fixes_ and need to be applied to -rc kernels, they
are based on -rc6.  I don't see the point of rebasing them onto non-rc
kernels to test, because then you're not testing against where they
should be applied.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
