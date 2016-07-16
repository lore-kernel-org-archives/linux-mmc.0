From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 1/2] Documentation: mmc: add description for new
 no-sd* and no-mmc
Date: Sat, 16 Jul 2016 17:49:55 -0500
Message-ID: <20160716224955.GA26627@rob-hp-laptop>
References: <1468484764-32353-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:35897 "EHLO
	mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751571AbcGPWt5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 16 Jul 2016 18:49:57 -0400
Content-Disposition: inline
In-Reply-To: <1468484764-32353-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org

On Thu, Jul 14, 2016 at 04:26:03PM +0800, Shawn Lin wrote:
> This patch adds description for no-sd, no-sdio, no-mmc. We expose
> these to DT as some of the controllers are unable to deal with
> special cmd type due to hw limitation.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> 
> ---
> 
> Changes in v2:
> - amend the description of these properties and the commit msg
> 
>  Documentation/devicetree/bindings/mmc/mmc.txt | 3 +++
>  1 file changed, 3 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
