From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [RFC] MMC: Proposals on reworking clock and power management
Date: Wed, 27 Oct 2010 15:32:18 +0100
Message-ID: <20101027153218.04462a45@lxorguk.ukuu.org.uk>
References: <2A3DCF3DA181AD40BDE86A3150B27B6B0356A579AF@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:49990 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933383Ab0J0OdY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Oct 2010 10:33:24 -0400
In-Reply-To: <2A3DCF3DA181AD40BDE86A3150B27B6B0356A579AF@dbde02.ent.ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Ghorai, Sukumar" <s-ghorai@ti.com>
Cc: Chris Ball <cjb@laptop.org>, Linus Walleij <linus.ml.walleij@gmail.com>, Nicolas Pitre <nico@fluxnic.net>, Adrian Hunter <adrian.hunter@nokia.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "Kadiyala, Kishore" <kishore.kadiyala@ti.com>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, "S, Venkatraman" <svenkatr@ti.com>

> 2. Ideally host-driver driver should not tell the core to shut down
>    the upper layers, instead the core should decide when to
>    "disabled clock or cut the power". 

How will the core know ?

I actually think you are simply perpetuating the mess in the existing MMC
driver where everything is driven by a core which as a result is a twisty
maze of exceptions and flags to say "except for this" "except for that".

The core MMC code only knows when the *core* parts are no longer
requiring power. It shouldn't know about anything deeper and if you are
using the runtime PM layer the runtime PM refcounting can do all your
work.

Alan
