From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] sdhci-pxav3: Fix runtime PM initialization
Date: Thu, 27 Jun 2013 11:47:34 -0400
Message-ID: <877ghfo8rt.fsf@octavius.laptop.org>
References: <20130610201618.C08C3FAACC@dev.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:44735 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752654Ab3F0Pri (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 27 Jun 2013 11:47:38 -0400
In-Reply-To: <20130610201618.C08C3FAACC@dev.laptop.org> (Daniel Drake's
	message of "Mon, 10 Jun 2013 16:16:18 -0400 (EDT)")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: linux-mmc@vger.kernel.org, kliu5@marvell.com, jlfu@marvell.com

Hi Daniel,

On Mon, Jun 10 2013, Daniel Drake wrote:
> Commit bb691ae464b77d30e74c66480e98d74e88d6b194 breaks boot on OLPC XO-4,
> it hangs somewhere inside sdhci_add_host.
>
> When pm_runtime_set_autosuspend_delay() was being called, the device's usage
> counter was 0, causing the PM layer to runtime-suspend the device. We then
> went on to call sdhci_add_host() on a suspended device, which hung.
>
> Fix this by making the driver consistent with the omap_hsmmc driver, both
> in terms of runtime PM initialization and error handling. Now the device
> is not runtime-suspended until we exit the probe routine.
>
> Signed-off-by: Daniel Drake <dsd@laptop.org>

Thanks for the fix, pushed to mmc-next for 3.11.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
