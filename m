From: Lars Segerlund <lars.segerlund@gmail.com>
Subject: SDIO card, newbie question
Date: Fri, 22 Jul 2011 11:49:00 +0200
Message-ID: <CAF-VNapJEoLxPsmgoq8ENV5qZOSOS8o4JkPzB2K4r2hSHnvFqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:37040 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753463Ab1GVJtB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 22 Jul 2011 05:49:01 -0400
Received: by iyb12 with SMTP id 12so1807392iyb.19
        for <linux-mmc@vger.kernel.org>; Fri, 22 Jul 2011 02:49:00 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

=A0Hi all,

=A0I have a question about latency and SDIO, since many laptops don't
have a 'gameport' anymore and I want to do realtime IO, I was thinking
of making a SDIO GPIO card.
=A0I know USB is a no go, if not using buffers for outgoing data ... so
SDIO is a desperate mans hope.
=A0i need a refresh rate of 10 kHz to 100kHz approximately.

=A0Do you think it could handle the latency ? and how much latency woul=
d
be expected ?
=A0Also would it be possible to do sensible interrupts ?

=A0I was planning on running in spi mode, basicly registering it as SDI=
O
and then sending spi to and from some chips with spi support.

=A0I gather this would need a driver, but does this all sound feasible =
?
=A0I gather I would try a simple GPIO interface for starters.

=A0Ie. interface some SPI controlled chips through SDIO ?=A0 and gettin=
g
low latency.

=A0Please CC me as I am not on the list ( yet ) ...
=A0I have looked whats in the kernel tree, but it seem's my purpose is =
a
bit different.

=A0/ best regards, Lars Segerlund.
