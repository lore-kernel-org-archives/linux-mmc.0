From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RESEND PATCH 1/2] mmc: mmci: Fix incorrect handling of HW
	flow control for SDIO
Date: Fri, 12 Oct 2012 10:13:22 +0100
Message-ID: <20121012091322.GC21164@n2100.arm.linux.org.uk>
References: <1349885000-22887-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:50938 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755867Ab2JLJN3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 12 Oct 2012 05:13:29 -0400
Content-Disposition: inline
In-Reply-To: <1349885000-22887-1-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org, Linus Walleij <linus.walleij@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>

On Wed, Oct 10, 2012 at 06:03:19PM +0200, Ulf Hansson wrote:
> From: Ulf Hansson <ulf.hansson@linaro.org>
> 
> For data writes <= 8 bytes, HW flow control was disabled but
> never re-enabled when the transfer was completed. This meant
> that a following read request would give buffer overrun errors.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Both look fine to me too.  Linus' has already said what needs to happen
with these two.  Thanks.
