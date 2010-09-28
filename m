From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v4 2/4] omap4 hsmmc: Fix the init if CONFIG_MMC_OMAP_HS
 is not set
Date: Tue, 28 Sep 2010 14:41:05 -0700
Message-ID: <20100928214105.GQ3117@atomide.com>
References: <9493.10.24.255.18.1285348410.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:62118 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753379Ab0I1VlN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Sep 2010 17:41:13 -0400
Content-Disposition: inline
In-Reply-To: <9493.10.24.255.18.1285348410.squirrel@dbdmail.itg.ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: kishore kadiyala <kishore.kadiyala@ti.com>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org, b-cousson@ti.com, madhu.cr@ti.com, adrian.hunter@nokia.com

* kishore kadiyala <kishore.kadiyala@ti.com> [100924 10:05]:
> From: Benoit Cousson <b-cousson@ti.com>
> 
> Avoid possible crash if CONFIG_MMC_OMAP_HS is not set

Will queue this and patches 3/4 and 4/4 of this series
for the upcoming merge window.

Tony
