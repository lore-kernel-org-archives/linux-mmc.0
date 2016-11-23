From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v2 0/7] mmc: core: Re-work CMD13 polling method for CMD6
 for mmc
Date: Wed, 23 Nov 2016 11:28:14 +0200
Message-ID: <1e966e76-5953-eca2-7115-5159a5c82095@intel.com>
References: <1479848173-20881-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:7120 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752253AbcKWJpg (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 23 Nov 2016 04:45:36 -0500
In-Reply-To: <1479848173-20881-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Linus Walleij <linus.walleij@linaro.org>, Chaotian Jing <chaotian.jing@mediatek.com>, Stephen Boyd <sboyd@codeaurora.org>, Michael Walle <michael@walle.cc>, Yong Mao <yong.mao@mediatek.com>, Shawn Lin <shawn.lin@rock-chips.com>

On 22/11/16 22:56, Ulf Hansson wrote:
> Changes in v2:
> 
> 	- From discussions around the difficulties for how to support CMD13
> 	polling for HS200, HS400 HS400ES, I decided to drop those patches for
> 	now. It's is particularly due to the need for tuning, after a speed mode
> 	switch, that makes it hard to rely on CMD13 polling for these cases.
> 	Perhaps we can allow CMD13 polling when switching to the intermediate
> 	speed modes, but let's deal with that outside of this series.
> 
> 	- Folded in a new patch, which checks the SWITCH_ERROR bit in each
> 	  CMD13 response when polling with CMD13. Patch v2 4/7.
> 
> 	- No other changes made to the rest of the series.
> 

For the whole series:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

