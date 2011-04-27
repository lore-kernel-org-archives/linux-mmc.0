From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] plat-pxa: Enable ability to adjust SD/MMC clocks
Date: Wed, 27 Apr 2011 10:33:28 +0100
Message-ID: <20110427093328.GU17290@n2100.arm.linux.org.uk>
References: <59C2B513-EC04-4CA2-818B-9901CAF3E554@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:34210 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755034Ab1D0Jdq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Apr 2011 05:33:46 -0400
Content-Disposition: inline
In-Reply-To: <59C2B513-EC04-4CA2-818B-9901CAF3E554@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Zhangfei Gao <zgao6@marvell.com>

On Fri, Apr 22, 2011 at 01:13:28PM -0700, Philip Rakity wrote:
> The PXA168, PXA910, and MMP2 SoC have the ability to adjust the SD/MMC
> clock.  This feature is useful and required depending on the board
> design.  Add infrastructure to support SD clock tuning.

It just adds fields to a structure which remain unused.  On its own this
patch is useless, and I don't see a patch which makes use of these new
fields in any way.  Did you forget to copy it to the linux-arm-kernel
list?
