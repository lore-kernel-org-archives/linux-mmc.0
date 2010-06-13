From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: [PATCH v4] mmc: make sdhci work with ricoh mmc controller
Date: Sun, 13 Jun 2010 14:29:28 +0300
Message-ID: <1276428568.16701.2.camel@maxim-laptop>
References: <1276283286.8557.28.camel@maxim-laptop>
	 <4c128b3a.51a3cc0a.3161.30ab@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.156]:34515 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753283Ab0FML3d (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 13 Jun 2010 07:29:33 -0400
In-Reply-To: <4c128b3a.51a3cc0a.3161.30ab@mx.google.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Langdale <philipl@overt.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, Andrew de Quincey <adq_dvb@lidskialf.net>

On Fri, 2010-06-11 at 22:15 +0300, maximlevitsky@gmail.com wrote: 
> From: Maxim Levitsky <maximlevitsky@gmail.com>
> 
> The current way of disabling it is not well tested by vendor
> and has all kinds of bugs that show up on resume from ram/disk.
> 
> Old way of disabling is still supported by
> continuing to use CONFIG_MMC_RICOH_MMC.
> 
> Based on 'http://list.drzeus.cx/pipermail/sdhci-devel/2007-December/002085.html'
> Most of the credit for this goes to Andrew de Quincey
> 
> 
> Signed-off-by: Maxim Levitsky <maximlevitsky@gmail.com>
> CC: Andrew de Quincey <adq_dvb@lidskialf.net>
> CC: linux-mmc@vger.kernel.org <linux-mmc@vger.kernel.org>

Also, I did a lot of testing and no problems (even minor) were observed.
I think this is ready for merge.


Best regards,
Maxim Levitsky

