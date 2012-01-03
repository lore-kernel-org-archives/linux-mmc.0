From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH V4 0/7] mmc: sdhci/sdhci-pci: prepare for wl12xx/SDIO
Date: Mon, 02 Jan 2012 19:08:25 -0500
Message-ID: <m2d3b1ps06.fsf@bob.laptop.org>
References: <1324993727-7508-1-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:53720 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753468Ab2ACAIg (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 2 Jan 2012 19:08:36 -0500
In-Reply-To: <1324993727-7508-1-git-send-email-adrian.hunter@intel.com>
	(Adrian Hunter's message of "Tue, 27 Dec 2011 15:48:40 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org

Hi Adrian,

On Tue, Dec 27 2011, Adrian Hunter wrote:
> Hi
>
> Here are some changes (V4) to allow wl12xx/SDIO to be set up for sdhci-pci.
> There a a couple of fixes plus a method to get platform data.  The
> changes to the platform files are not included in this patchset.

Thanks, I've pushed all seven patches to mmc-next for 3.3.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
