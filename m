From: Rob Herring <robh@kernel.org>
Subject: Re: [RFC PATCH 1/4] Documentation: mmc: add description for new caps
Date: Wed, 8 Jun 2016 15:48:48 -0500
Message-ID: <20160608204848.GA3368@rob-hp-laptop>
References: <1465373996-2485-1-git-send-email-shawn.lin@rock-chips.com>
 <1465374021-2526-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oi0-f48.google.com ([209.85.218.48]:36263 "EHLO
	mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1424670AbcFHUsu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 8 Jun 2016 16:48:50 -0400
Content-Disposition: inline
In-Reply-To: <1465374021-2526-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Doug Anderson <dianders@chromium.org>, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org

On Wed, Jun 08, 2016 at 04:20:21PM +0800, Shawn Lin wrote:
> Let's add some basic description for cap-no-sdio,
> cap-no-sd and cap-no-mmc.

This doesn't say why.

If you know what is there, then there's a better way to do this. Look at 
the child nodes because chances are if you have something soldered down 
like SDIO or eMMC, then you have a child node already for resets, 
regulators, etc.

Rob
