From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 08/14] mmc: mmci: Fixup error handling for dma
Date: Sun, 18 Dec 2011 23:16:14 +0000
Message-ID: <20111218231614.GB14542@n2100.arm.linux.org.uk>
References: <1323106560-5218-1-git-send-email-ulf.hansson@stericsson.com> <1323106560-5218-9-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:36900 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751945Ab1LRXQW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 18 Dec 2011 18:16:22 -0500
Content-Disposition: inline
In-Reply-To: <1323106560-5218-9-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Per Forlin <per.forlin@stericsson.com>, Lee Jones <lee.jones@linaro.org>

On Mon, Dec 05, 2011 at 06:35:54PM +0100, Ulf Hansson wrote:
> When getting a cmd irq during an ongoing data transfer
> with dma, the dma job were never terminated. This is now
> corrected.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
> Signed-off-by: Per Forlin <per.forlin@stericsson.com>

I've queued this up in my 'fixes' branch with a Cc to the stable team
for previous kernels.  I believe this to be appropriate.  Please confirm.
