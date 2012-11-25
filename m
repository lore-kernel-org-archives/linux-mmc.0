From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 0/4] Support for optional MMC PM capabilities
Date: Sun, 25 Nov 2012 15:06:57 -0500
Message-ID: <87a9u58n1a.fsf@octavius.laptop.org>
References: <1353300981-24652-1-git-send-email-a.kesavan@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:48868 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753370Ab2KYUHA (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 25 Nov 2012 15:07:00 -0500
In-Reply-To: <1353300981-24652-1-git-send-email-a.kesavan@samsung.com>
	(Abhilash Kesavan's message of "Mon, 19 Nov 2012 10:26:17 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Abhilash Kesavan <a.kesavan@samsung.com>
Cc: linux-mmc@vger.kernel.org

Hi,

On Sun, Nov 18 2012, Abhilash Kesavan wrote:
> This patchset adds optional PM properties to the core MMC bindings. It also
> makes the appropriate changes in the sdhci platform and dw_mmc driver files.
> Based on git://git.kernel.org/pub/scm/linux/kernel/git/cjb/mmc.git : for-next.
> Note: Patch 3 has only been compile tested.

Perfect, thanks for doing that -- pushed to mmc-next for 3.8.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
