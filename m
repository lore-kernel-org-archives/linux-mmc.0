From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH V2] OMAP4 ES2:  HSMMC soft reset change
Date: Thu, 30 Sep 2010 13:53:19 -0700
Message-ID: <20100930205319.GN3117@atomide.com>
References: <65452.192.168.10.88.1285721178.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:63389 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756780Ab0I3UxZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 30 Sep 2010 16:53:25 -0400
Content-Disposition: inline
In-Reply-To: <65452.192.168.10.88.1285721178.squirrel@dbdmail.itg.ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Madhusudhan Chikkature <madhu.cr@ti.com>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, cjb@laptop.org

* Madhusudhan Chikkature <madhu.cr@ti.com> [100928 17:37]:
> The omap4 es2 hsmmc has a updated soft reset logic.After the
> reset is issued monitor a 0->1 transition first. The reset of
> CMD or DATA lines is complete only after a 0->1->0 transition
> of SRC or SRD bits.

Thanks for updating this. I'll queue it for the upcoming merge window.

Tony
