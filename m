From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] mmc: mmci: Use pm_runtime_put_noidle() during ->probe()
Date: Fri, 19 Dec 2014 10:27:58 +0000
Message-ID: <20141219102758.GD11285@n2100.arm.linux.org.uk>
References: <1418982622-8118-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:40087 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751706AbaLSK2I (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 19 Dec 2014 05:28:08 -0500
Content-Disposition: inline
In-Reply-To: <1418982622-8118-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>

On Fri, Dec 19, 2014 at 10:50:22AM +0100, Ulf Hansson wrote:
> Previously the pm_runtime_put() caused the device to be runtime PM
> suspended, but then immediately being resumed when we add the host.
> 
> Prevent this unnecessary runtime PM suspend/resume cycle during
> ->probe() by using the pm_runtime_put_noidle() variant instead.

Better would be to move it below mmc_add_host().  Then we're not depending
on behaviour of other code.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
