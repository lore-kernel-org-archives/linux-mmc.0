From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v4 0/2] add support for the Marvell Dove SDHCI
	controller
Date: Sun, 7 Nov 2010 22:41:16 +0000
Message-ID: <20101107224116.GD13608@void.printf.net>
References: <cover.1288293593.git.mike@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:52887 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751711Ab0KGWlR (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 7 Nov 2010 17:41:17 -0500
Content-Disposition: inline
In-Reply-To: <cover.1288293593.git.mike@compulab.co.il>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mike Rapoport <mike@compulab.co.il>
Cc: linux-mmc@vger.kernel.org, Saeed Bishara <saeed@marvell.com>, linux-arm-kernel@lists.infradead.org

Hi Mike,

On Thu, Oct 28, 2010 at 09:23:51PM +0200, Mike Rapoport wrote:
> These patches add support for the Marvell Dove SDHCI controller.

Thanks, I've pushed these to mmc-next for the 2.6.38 merge now.

(Applied a minor correction: MMC_SDHCI_DOVE is a bool, not a tristate,
so I removed the "say Y or M" line.)

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
