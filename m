From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 02/14] mmc: mmci: Fixup handling of MCI_STARTBITERR
Date: Sun, 18 Dec 2011 23:15:35 +0000
Message-ID: <20111218231534.GA14542@n2100.arm.linux.org.uk>
References: <1323106560-5218-1-git-send-email-ulf.hansson@stericsson.com> <1323106560-5218-3-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:36896 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751988Ab1LRXPn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 18 Dec 2011 18:15:43 -0500
Content-Disposition: inline
In-Reply-To: <1323106560-5218-3-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Lee Jones <lee.jones@linaro.org>

On Mon, Dec 05, 2011 at 06:35:48PM +0100, Ulf Hansson wrote:
> The interrupt was previously enabled and then correctly cleared.
> Now we also handle it correctly.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

I've queued this in my 'fixes' branch with a Cc to the stable team for
previous kernel versions.  I believe that to be appropriate.  Please
confirm.
