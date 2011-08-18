From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 1/2] mmc: add functions to enable/disable aggressive
 clock gating
Date: Thu, 18 Aug 2011 14:33:27 +0300
Message-ID: <20110818113327.GY16790@intel.com>
References: <e13e177c732ee8ad2d6fe389c9bac21877f60c59.1313400777.git.mika.westerberg@linux.intel.com>
 <CACRpkdZ5oCmRupNn9HjZj534zXJQWD8OpycpMxG4Jhgsvk=kEQ@mail.gmail.com>
 <20110817121914.GW16790@intel.com>
 <20110818103441.GX16790@intel.com>
 <CAHp75VfST5UnPXkCprx5_0UG0tCa2BDCJeAVmkdDi7_7BvQq3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:49781 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755587Ab1HRLcz (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 18 Aug 2011 07:32:55 -0400
Content-Disposition: inline
In-Reply-To: <CAHp75VfST5UnPXkCprx5_0UG0tCa2BDCJeAVmkdDi7_7BvQq3A@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, cjb@laptop.org

On Thu, Aug 18, 2011 at 02:11:23PM +0300, Andy Shevchenko wrote:

> Mika, do the patches to check host->clock in
> (mmc|sdhci)_set_data_timeout() become useless after?
> If so, probably you could revert them as well.

IMHO these functions should work also when the clock is gated, so I suggest
that we leave them as is for now.
