From: "Normann Cunz" <nc@wcos.de>
Subject: (unknown)
Date: Fri, 21 Aug 2009 16:56:41 +0200
Message-ID: <004201ca226f$9825d190$c87174b0$@de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:55027 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932303AbZHUO4u (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 21 Aug 2009 10:56:50 -0400
Received: from ncmobile (pd956a62f.dip0.t-ipconnect.de [217.86.166.47])
	by post.strato.de (mrclete mo23) (RZmta 21.0)
	with ESMTP id I0073dl7LEH0as for <linux-mmc@vger.kernel.org>;
	Fri, 21 Aug 2009 16:56:49 +0200 (MEST)
Subject: 
Content-Language: de
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Linux-Mailing-List (mmc)" <linux-mmc@vger.kernel.org>

Hello,

after having a first glance on the MMC/SD driver source, I'm unsure how to
handle the following requirement (System: Kernel 2.6.30 on i386).

I'm trying to integrate a SD card with a 'command system expansion' via
switch-command (see 'sd card association', 'physical layer simplified spec
2.00', chapter 4.3.12). The additional commands are used to communicate with
a specialized controller within the SD card (1), as well as access hidden
memory in a secure way (2). Because of the multi functionality (ordinary SD
+ 2 additional features) and not SDIO, I'd like to get a clue where to
start?
 
The first extension might be handled via ioctrl(), so that a user space
applications could use it. 
The second one should be accessible as a device, which can be mounted to
apply a file system.

So there are some questions:

- Do I have to write a complete new driver?
- Can I rely on the existing driver?
- Is there already something implemented?
- Where to place it?
- Do I need a new major device id (in case of a new driver) or just a minor
one for mounting?

Another problem might be, that a flash access (read/write) could intercept
the extended communication and vice versa?

In the hope to get a little bit of light in the dark,

TIA
Norman


