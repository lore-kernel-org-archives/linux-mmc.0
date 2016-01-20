From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 5/5 RFC] DT: sdhci-iproc: add bcm2835 compatible
Date: Wed, 20 Jan 2016 10:50:24 -0600
Message-ID: <20160120165024.GA31174@rob-hp-laptop>
References: <1453042744-16196-1-git-send-email-stefan.wahren@i2se.com>
 <1453042744-16196-6-git-send-email-stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:45069 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934625AbcATQu3 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 20 Jan 2016 11:50:29 -0500
Content-Disposition: inline
In-Reply-To: <1453042744-16196-6-git-send-email-stefan.wahren@i2se.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Scott Branden <sbranden@broadcom.com>, Ray Jui <rjui@broadcom.com>, Jon Mason <jonmason@broadcom.com>, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, Eric Anholt <eric@anholt.net>, Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, Ulf Hansson <ulf.hansson@linaro.org>, kernel@martin.sperl.org, devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com

On Sun, Jan 17, 2016 at 02:59:04PM +0000, Stefan Wahren wrote:
> Since sdhci-iproc can support bcm2835 we need to add the
> compatible string to the binding.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> ---
>  .../devicetree/bindings/mmc/brcm,sdhci-iproc.txt   |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>
