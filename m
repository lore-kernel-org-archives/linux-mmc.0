From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] Add SDIO and MMC device ID support for CLV
Date: Sat, 26 Oct 2013 22:30:46 -0400
Message-ID: <8761sjla21.fsf@octavius.laptop.org>
References: <1382374481-197092-1-git-send-email-eric.ernst@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:41893 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753653Ab3J0Caw (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 26 Oct 2013 22:30:52 -0400
In-Reply-To: <1382374481-197092-1-git-send-email-eric.ernst@linux.intel.com>
	(Eric Ernst's message of "Mon, 21 Oct 2013 09:54:41 -0700")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Eric Ernst <eric.ernst@linux.intel.com>
Cc: adrian.hunter@intel.com, gregkh@linuxfoundation.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, David Cohen <david.a.cohen@linux.intel.com>

Hi Eric,

On Mon, Oct 21 2013, Eric Ernst wrote:
> This patch adds intel_mid clovertrail SDIO and eMMC device
> IDs to the sdhci-pci driver.
>
> Signed-off-by: Eric Ernst <eric.ernst@linux.intel.com>
> Signed-off-by: David Cohen <david.a.cohen@linux.intel.com>

Thanks, pushed to mmc-next for 3.13.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
