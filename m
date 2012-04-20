From: Steve Sakoman <sakoman@gmail.com>
Subject: Possible to trigger card insert/remove event from user space?
Date: Fri, 20 Apr 2012 10:57:49 -0700
Message-ID: <CAGDS+n=Vp1TSBYo0KdzSRSW5=bC0pzLsg62S=FaEH9T0uxyjcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53]:37581 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754804Ab2DTR5t (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 20 Apr 2012 13:57:49 -0400
Received: by qadc11 with SMTP id c11so484617qad.19
        for <linux-mmc@vger.kernel.org>; Fri, 20 Apr 2012 10:57:49 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

I am working with a system that has a wifi module connected via SDIO
(8686 using the libertas_sdio driver).

This is a hard connection, not socketed -- the hw is soldered to the board.

To reduce power I would like to be able to unload the driver module
and power down the wifi hw (via a GPIO control), then sometime later
power up the hw and resume normal operation.

Sadly this doesn't work -- when I power up the module and manually
load the libertas_sdio module the driver throws -110 timeout errors.

I rebuilt my kernel with a CD GPIO enabled for the mmc port the module
is connected to and in turn connected that GPIO to another one that I
can toggle from user space.

Toggling the CD GPIO after powering back up does indeed work properly
-- the module is detected, the driver loaded, and proper function
restored.

So the next step is to get rid of the silly two GPIO external hardware
hack.  Is it possible to trigger a card insertion/removal event via
some standard API?

Best regards,

Steve
