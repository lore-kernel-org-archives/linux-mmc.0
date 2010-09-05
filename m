From: Matt Fleming <matt@console-pimps.org>
Subject: Re: [PATCH v4] mmc: Make ID freq configurable
Date: Sun, 5 Sep 2010 22:22:18 +0100
Message-ID: <20100905212218.GA23622@console-pimps.org>
References: <4C80187D.9000304@yahoo.es>
 <20100905201448.GA22819@console-pimps.org>
 <20100905204336.GA23574@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arkanian.console-pimps.org ([212.110.184.194]:34223 "EHLO
	arkanian.console-pimps.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753224Ab0IEVWU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 5 Sep 2010 17:22:20 -0400
Content-Disposition: inline
In-Reply-To: <20100905204336.GA23574@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Hein_Tibosch <hein_tibosch@yahoo.es>, Andrew Morton <akpm@linux-foundation.org>, Pierre Ossman <pierre@ossman.eu>, Ben Nizette <bn@niasdigital.com>, Sascha Hauer <s.hauer@pengutronix.de>, Adrian Hunter <adrian.hunter@nokia.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, Sep 05, 2010 at 09:43:36PM +0100, Chris Ball wrote:
> 
> Actually, mmc_attach_{sd,mmc}() both do release the host as part of
> their failure case, so I don't think there's a problem with these two.

Ah, yep you're right, I missed that.
