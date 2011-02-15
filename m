From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 02/12] mmc: sd: add support for signal voltage switch
 procedure
Date: Tue, 15 Feb 2011 11:16:27 +0100
Message-ID: <20110215101627.GC13934@pengutronix.de>
References: <1297762510-2696-1-git-send-email-arindam.nath@amd.com>
 <1297762510-2696-3-git-send-email-arindam.nath@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38288 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754174Ab1BOKQc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Feb 2011 05:16:32 -0500
Content-Disposition: inline
In-Reply-To: <1297762510-2696-3-git-send-email-arindam.nath@amd.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arindam Nath <arindam.nath@amd.com>
Cc: cjb@laptop.org, linux-mmc@vger.kernel.org, henry.su@amd.com, aaron.lu@amd.com, anath.amd@gmail.com

On Tue, Feb 15, 2011 at 03:05:00PM +0530, Arindam Nath wrote:

> Host Controller v3.00 adds another Capabilities register. We can
> directly read this register without any version checking since the
> new register bits will be considred as reserved in older controllers,
> and will be read as 0.

I so much wish you were right, but reality is different :(

The i.MX35-processor, for example, has a custom watermark-register there. I
could fix this by intercepting the read using io-accessors, but to minimize
potential regressions on older controllers in general, I'd say the check for v3
might be justified?

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
