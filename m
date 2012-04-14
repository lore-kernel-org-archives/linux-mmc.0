From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] mmc: omap_hsmmc: set dto to 14 for all devices
Date: Sat, 14 Apr 2012 03:38:26 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1204140337300.29048@utopia.booyaka.com>
References: <1330622780-1909-1-git-send-email-Chase.Maupin@ti.com> <m2399iqtgf.fsf@bob.laptop.org> <alpine.DEB.2.00.1203120435200.11332@utopia.booyaka.com> <87bonxcjrh.fsf@laptop.org> <20120405220848.GF3785@atomide.com> <87obr57rmh.fsf@laptop.org>
 <alpine.DEB.2.00.1204051743360.10302@utopia.booyaka.com> <87k41t7n13.fsf@laptop.org> <4F86A461.4010006@linaro.org> <alpine.DEB.2.00.1204121130370.29473@utopia.booyaka.com> <87ehrsrexg.fsf@laptop.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:42944 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751211Ab2DNJi1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 14 Apr 2012 05:38:27 -0400
In-Reply-To: <87ehrsrexg.fsf@laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Tushar Behera <tushar.behera@linaro.org>, Tony Lindgren <tony@atomide.com>, Chase Maupin <Chase.Maupin@ti.com>, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, sakoman@gmail.com

Hi Chris,

On Thu, 12 Apr 2012, Chris Ball wrote:

> If I understand correctly, the only problem here is the presence of the
> warning, so I'm leaning towards just removing it (which we've already
> had another request for) or making it pr_debug() instead.  Sound okay?

Sounds okay to me.

We'll probably also need to take a look at the drivers that don't 
range-check their timeouts.


- Paul
