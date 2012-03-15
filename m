From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 2/5] MMC: mmci: Seperate ARM variants from generic code
Date: Thu, 15 Mar 2012 17:54:43 +0000
Message-ID: <20120315175443.GG15988@n2100.arm.linux.org.uk>
References: <1331734803-17954-1-git-send-email-lee.jones@linaro.org> <4F622884.6060807@linaro.org> <20120315173714.GF15988@n2100.arm.linux.org.uk> <201203151746.56678.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:41565 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161079Ab2CORy6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 15 Mar 2012 13:54:58 -0400
Content-Disposition: inline
In-Reply-To: <201203151746.56678.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Lee Jones <lee.jones@linaro.org>, linux-arm-kernel@lists.infradead.org, niklas.hernaeus@linaro.org, cjb@laptop.org, linux-mmc@vger.kernel.org

On Thu, Mar 15, 2012 at 05:46:56PM +0000, Arnd Bergmann wrote:
> Can you elaborate? I suggested the split in order to keep the ux500
> specific parts local to one file. With the device tree conversion,
> we really want to have them out of the platform code, but sticking them
> into the main driver seems wrong, too.

You're talking about the data structures which describe what quirks to
apply for the ux500 parts, rather than the actual quirks themselves.
That's not a particularly clever thing to do because it separates out
the selection of the works from the rest of the driver, which means
simply searching for the flags to find out what's applied for what has
to span several files.
