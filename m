From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 2/5] MMC: mmci: Seperate ARM variants from generic code
Date: Thu, 15 Mar 2012 17:32:56 +0000
Message-ID: <20120315173256.GD15988@n2100.arm.linux.org.uk>
References: <1331734803-17954-1-git-send-email-lee.jones@linaro.org> <1331734803-17954-3-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:39334 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031173Ab2CORdK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 15 Mar 2012 13:33:10 -0400
Content-Disposition: inline
In-Reply-To: <1331734803-17954-3-git-send-email-lee.jones@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, niklas.hernaeus@linaro.org, cjb@laptop.org, linux-mmc@vger.kernel.org, arnd@arndb.de

On Wed, Mar 14, 2012 at 02:20:00PM +0000, Lee Jones wrote:
> This is a step in the right direction for future Device
> Tree support. It will allow variant specific attributes
> to be collected from a Device Tree without overloading
> the MMCI core. It will also provide additional future
> variants a cleaner way to add support.

NAK.  You can't have two driver structures with the same name.  The names
are sysfs object names.
