From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/4] dt-bindings: Add binding for brcm,bcm2835-sdhost.
Date: Thu, 3 Mar 2016 16:02:13 -0600
Message-ID: <20160303220213.GA26008@rob-hp-laptop>
References: <1456527942-3045-1-git-send-email-eric@anholt.net>
 <1456527942-3045-2-git-send-email-eric@anholt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:39268 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751334AbcCCWCS (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 3 Mar 2016 17:02:18 -0500
Content-Disposition: inline
In-Reply-To: <1456527942-3045-2-git-send-email-eric@anholt.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Eric Anholt <eric@anholt.net>
Cc: linux-rpi-kernel@lists.infradead.org, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Ian Campbell <ijc+devicetree@hellion.org.uk>, Florian Fainelli <f.fainelli@gmail.com>, Pawel Moll <pawel.moll@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Kumar Gala <galak@codeaurora.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-arm-kernel@lists.infradead.org

On Fri, Feb 26, 2016 at 03:05:39PM -0800, Eric Anholt wrote:
> This is the other SD controller on the platform, which can be swapped
> to the role of SD card host using pin muxing.
> 
> Signed-off-by: Eric Anholt <eric@anholt.net>

Acked-by: Rob Herring <robh@kernel.org>
