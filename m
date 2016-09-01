From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v5 11/11] arm64: defconfig: Enable SDHI and GPIO_REGULATOR
Date: Thu, 1 Sep 2016 16:33:06 +0200
Message-ID: <20160901143306.GL14300@verge.net.au>
References: <1472591399-13907-1-git-send-email-horms+renesas@verge.net.au>
 <1472591399-13907-12-git-send-email-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:52913 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754597AbcIAOdN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Sep 2016 10:33:13 -0400
Content-Disposition: inline
In-Reply-To: <1472591399-13907-12-git-send-email-horms+renesas@verge.net.au>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org

On Tue, Aug 30, 2016 at 11:09:59PM +0200, Simon Horman wrote:
> This allows use of the SDHI SD/SDIO controller present on R-Car Gen3 SoCs
> and already enabled in the DT of the r8a7795/salvator-x (H3).
> 
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

I have queued this up.
