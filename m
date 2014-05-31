From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v5 02/13] mmc: mmci: convert register bits to use BIT()
	macro.
Date: Sat, 31 May 2014 13:35:02 +0100
Message-ID: <20140531123502.GB20736@n2100.arm.linux.org.uk>
References: <1401469918-26817-1-git-send-email-srinivas.kandagatla@linaro.org> <1401469980-26906-1-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:40496 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755986AbaEaMgd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 31 May 2014 08:36:33 -0400
Content-Disposition: inline
In-Reply-To: <1401469980-26906-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: srinivas.kandagatla@linaro.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linus.walleij@linaro.org

On Fri, May 30, 2014 at 06:13:00PM +0100, srinivas.kandagatla@linaro.org wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> This patch converts the register bits in the header file to use BIT(()
> macro, which looks much neater.
> 
> No functional changes done.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This makes me wonder when we're going to get these definitions in the kernel
source, and have people running around making the conversion:

#define ZERO 0
#define ONE 1
#define TWO 2
#define THREE 3
#define FOUR 4
...

because allegedly it makes it more "readable".  I don't see much benefit
to this patch.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
