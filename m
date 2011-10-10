From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 2/2] mmc: sdhci-pci: add runtime pm support
Date: Mon, 10 Oct 2011 18:07:44 -0400
Message-ID: <m2sjn0lcun.fsf@bob.laptop.org>
References: <1317645214-12316-1-git-send-email-adrian.hunter@intel.com>
	<1317645214-12316-3-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:37821 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752744Ab1JJWHv (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 10 Oct 2011 18:07:51 -0400
In-Reply-To: <1317645214-12316-3-git-send-email-adrian.hunter@intel.com>
	(Adrian Hunter's message of "Mon, 3 Oct 2011 15:33:34 +0300")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

Hi,

On Mon, Oct 03 2011, Adrian Hunter wrote:
> Ths patch allows runtime PM for sdhci-pci, runtime suspending
> after inactivity of 50ms and ensuring runtime resume before
> SDHC registers are accessed.  During runtime suspend, interrupts
> are masked.  The host controller state is restored at runtime
> resume.
>
> For Medfield, the host controller's card detect mechanism
> is supplanted by an always-on GPIO which provides for card
> detect wake-up.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Pushed to mmc-next for 3.2, thanks.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
