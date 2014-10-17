From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 1/1] mmc: sdhci-bcm2835: added quirk and removed udelay
 in write ops
Date: Thu, 16 Oct 2014 20:50:21 -0600
Message-ID: <544083ED.4090705@wwwdotorg.org>
References: <Scott Branden <sbranden@broadcom.com> <1413338512-14546-1-git-send-email-sbranden@broadcom.com> <1413338512-14546-2-git-send-email-sbranden@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:54892 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752503AbaJQCuY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Oct 2014 22:50:24 -0400
In-Reply-To: <1413338512-14546-2-git-send-email-sbranden@broadcom.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Scott Branden <sbranden@broadcom.com>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Russell King <rmk+kernel@arm.linux.org.uk>, Peter Griffin <peter.griffin@linaro.org>
Cc: Ray Jui <rjui@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org

On 10/14/2014 08:01 PM, Scott Branden wrote:
> Added quirk SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12 present in controller.
> Removed udelay in write ops by using shadow registers for 16 bit
> accesses to 32-bit registers (where necessary).
> Optimized 32-bit operations when doing 8/16 register accesses.

I'm going to assume this is identical to the patch you sent 8/15? So,
I'll ignore this copy...
