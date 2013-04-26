From: Luciano Coelho <coelho@ti.com>
Subject: Re: [PATCH] mmc: omap_hsmmc: Fix the DT pbias workaround for MMC
 controllers 2 to 5
Date: Fri, 26 Apr 2013 09:33:45 +0300
Message-ID: <1366958025.4029.18.camel@cumari.coelho.fi>
References: <20130426033853.GK5184@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58157 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751096Ab3DZGfI (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 26 Apr 2013 02:35:08 -0400
In-Reply-To: <20130426033853.GK5184@atomide.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, "Cousson, Benoit" <b-cousson@ti.com>, Rajendra Nayak <rnayak@ti.com>

On Thu, 2013-04-25 at 20:38 -0700, Tony Lindgren wrote:
> Otherwise SDIO cards won't necessarily work when booted with
> device tree as we will never power down the SDIO cards. This
> means the SDIO card reset does not happen which at least some
> WLAN controllers expect to happen with ifconfig wlan0 down.
> 
> The PBIAS voltage is only available for the first controller
> instance, so let's limit the PBIAS workaround to the first
> controller only.
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> ---

Tested-by: Luciano Coelho <coelho@ti.com>

-- 
Luca.

