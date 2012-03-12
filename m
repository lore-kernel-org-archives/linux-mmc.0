From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] mmc: omap_hsmmc: set dto to 14 for all devices
Date: Mon, 12 Mar 2012 05:10:32 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1203120505590.11332@utopia.booyaka.com>
References: <1330622780-1909-1-git-send-email-Chase.Maupin@ti.com> <m2399iqtgf.fsf@bob.laptop.org> <alpine.DEB.2.00.1203120435200.11332@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:51372 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751125Ab2CLLKd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 12 Mar 2012 07:10:33 -0400
In-Reply-To: <alpine.DEB.2.00.1203120435200.11332@utopia.booyaka.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Chase Maupin <Chase.Maupin@ti.com>, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, sakoman@gmail.com

On Mon, 12 Mar 2012, Paul Walmsley wrote:

> I don't have an SD bus analyzer, but it looks to me think there are some 
> SD cards that are not completing the write within the allotted time 
> window.

Heh, sorry.  This should, of course, read "looks to me _that_".  Sigh...


- Paul
