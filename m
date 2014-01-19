From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: How to support SDIO wifi/bt in DT
Date: Sun, 19 Jan 2014 21:28:53 +0100
Message-ID: <201401192128.54413.arnd@arndb.de>
References: <20140116133649.GV15937@n2100.arm.linux.org.uk> <alpine.LFD.2.10.1401171157340.28907@knanqh.ubzr> <CAOesGMjVpTEku+UJntewi3FXoeEPe9rJP4BBmbSesfFMtY9hnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:56298 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751909AbaASU3C (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 19 Jan 2014 15:29:02 -0500
In-Reply-To: <CAOesGMjVpTEku+UJntewi3FXoeEPe9rJP4BBmbSesfFMtY9hnA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Nicolas Pitre <nico@fluxnic.net>, Rob Herring <robherring2@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Sunday 19 January 2014, Olof Johansson wrote:
> The "multi-slot" concept I was talking about was one host controller
> for several physical slots. Seems like at91 implements and uses this
> but nobody else. However, it seems that they allocate one mmc host per
> slot, so the same model still works.
> 

IIRC dw-mci also has multiple slots, and it's a common host controller
in a number of SoCs. I don't know how many of them actually support
multiple slots rather than a simplified single-slot version of
that controller.

	Arnd
