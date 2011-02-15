From: David Brown <davidb@codeaurora.org>
Subject: Re: [RFC] MMC: error handling improvements
Date: Tue, 15 Feb 2011 15:49:04 -0800
Message-ID: <8yaoc6c7tan.fsf@huya.qualcomm.com>
References: <20110215230311.GT4152@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:54546 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752289Ab1BOXtF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Feb 2011 18:49:05 -0500
In-Reply-To: <20110215230311.GT4152@n2100.arm.linux.org.uk> (Russell King's
	message of "Tue, 15 Feb 2011 23:03:11 +0000")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

On Tue, Feb 15 2011, Russell King - ARM Linux wrote:

> This patch is for RFC only; it needs splitting up somewhat.  However, I
> wanted to get it out there for some comment.

Just for kicks, I applied this and ran it on an MSM target (8x50).  It
seems to cause lots of:

  mmc0: Data timeout
  mmc0: Controller has been re-initialized
  ...
  mmc0: Data CRC error

and I can post more if you would find them interesting.  Eventually the
MSM mmc driver derefernces a null pointer in the interrupt code.

It's also possible this is finding problems in our SDCC driver.

David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
