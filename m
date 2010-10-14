From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH] sdio: fix suspend/resume regression
Date: Thu, 14 Oct 2010 17:28:12 +0200
Message-ID: <AANLkTikex9BvozcfY8EDJ0EHepKR+gSOEyYyppZVCLx_@mail.gmail.com>
References: <1286788315.3101.11.camel@sven> <1286955116-22793-1-git-send-email-ohad@wizery.com>
 <alpine.LFD.2.00.1010131602590.2764@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:51856 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754491Ab0JNP2i (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Oct 2010 11:28:38 -0400
In-Reply-To: <alpine.LFD.2.00.1010131602590.2764@xanadu.home>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
Cc: linux-mmc@vger.kernel.org, Sven Neumann <s.neumann@raumfeld.com>, Chris Ball <cjb@laptop.org>, libertas-dev@lists.infradead.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Daniel Mack <daniel@caiaq.de>, Colin Cross <ccross@android.com>, Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Maxim Levitsky <maximlevitsky@gmail.com>, stable@kernel.org

On Wed, Oct 13, 2010 at 10:08 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
> It could, but then there has to be extra code in the resume handler to
> cope with the fact that the card was powered off.

Good point.

It's much better the way it is now.

Thanks,
Ohad.
