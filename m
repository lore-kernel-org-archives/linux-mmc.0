From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCHv2 2/5] mmc: sdhci-bcm2835: make shift calculations consistent
Date: Tue, 04 Nov 2014 21:48:12 -0700
Message-ID: <5459AC0C.8080703@wwwdotorg.org>
References: <Scott Branden <sbranden@broadcom.com> <1414651017-3545-1-git-send-email-sbranden@broadcom.com> <1414651017-3545-3-git-send-email-sbranden@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:53672 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752850AbaKEEsP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 4 Nov 2014 23:48:15 -0500
In-Reply-To: <1414651017-3545-3-git-send-email-sbranden@broadcom.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Scott Branden <sbranden@broadcom.com>, Ulf Hansson <ulf.hansson@linaro.org>, Russell King <rmk+kernel@arm.linux.org.uk>, Peter Griffin <peter.griffin@linaro.org>, Chris Ball <chris@printf.net>, Piotr Krol <pietrushnic@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>, linux-rpi-kernel@lists.infradead.org, Ray Jui <rjui@broadcom.com>, bcm-kernel-feedback-list@broadcom.com

On 10/30/2014 12:36 AM, Scott Branden wrote:
> Make the shift calculations consistent rather than having different
> implementations to calculate the same thing.

> diff --git a/drivers/mmc/host/sdhci-bcm2835.c b/drivers/mmc/host/sdhci-bcm2835.c

> +#define REG_OFFSET_IN_BITS(reg) ((reg) << 3 & 0x18)

This should really be the following so people don't have to memorize
operator precedence:

#define REG_OFFSET_IN_BITS(reg) (((reg) << 3) & 0x18)

(I've been bit by people mis-remembering precedence in very similar code...)
