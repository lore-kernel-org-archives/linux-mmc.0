From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] pxamci: remove an ifdef about CONFIG_REGULATOR
Date: Mon, 9 May 2011 22:36:12 +0200
Message-ID: <20110509203612.GC21323@opensource.wolfsonmicro.com>
References: <1304971869-20161-1-git-send-email-ospite@studenti.unina.it>
 <20110509202325.GD16919@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:42543 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754624Ab1EIUgI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 9 May 2011 16:36:08 -0400
Content-Disposition: inline
In-Reply-To: <20110509202325.GD16919@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Antonio Ospite <ospite@studenti.unina.it>, linux-mmc@vger.kernel.org, openezx-devel@lists.openezx.org, Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org

On Mon, May 09, 2011 at 09:23:25PM +0100, Russell King - ARM Linux wrote:

> NAK.  This has been proposed before, and rejected.  See the comments
> against the original proposal:

> http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=6525/1

Hrm, this looks like the bodge we're doing for !REGULATOR isn't actually
helping here unless we do a NULL || IS_ERR() in the error check.  The
ifdefs are certainly fail.
