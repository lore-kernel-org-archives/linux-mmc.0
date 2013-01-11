From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH] mmc: mvsdio: Replace IS_ERR_NULL() is with IS_ERR()
Date: Fri, 11 Jan 2013 12:09:09 +0100
Message-ID: <20130111120909.2cee1b8e@skate>
References: <1357849755-8168-1-git-send-email-andrew@lunn.ch>
	<20130111110210.GC30875@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.32.191]:54515 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754998Ab3AKLJO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 11 Jan 2013 06:09:14 -0500
In-Reply-To: <20130111110210.GC30875@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, cjb@laptop.org, linux-mmc@vger.kernel.org, linux ARM <linux-arm-kernel@lists.infradead.org>

Dear Russell King - ARM Linux,

On Fri, 11 Jan 2013 11:02:10 +0000, Russell King - ARM Linux wrote:

> What remains?  The assumption that GPIO0 means "no GPIO" rather than
> testing with gpio_valid() and the IRQ stuff.

Patches that I have written have been merged by Jason Cooper and while
adding the DT binding for this driver, it also converts it to use the
MMC GPIO helpers from drivers/mmc/core/slot-gpio.c, which makes this
whole GPIO initialization/cleanup a lot simpler.

See:

  http://git.infradead.org/users/jcooper/linux.git/commitdiff/c3833fbb117bb1a547d29b27a0de4418fa2d5a5a
  http://git.infradead.org/users/jcooper/linux.git/commitdiff/e60a21ed4edb7f33010ab21cefcb20666a9bc7d7

Also, note that Andrew Lunn has sent a v2 of his patch:

Subject: [PATCH v2] mmc: mvsdio: Replace IS_ERR_OR_NULL() with IS_ERR()
Date: Fri, 11 Jan 2013 08:27:52 +0100

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
