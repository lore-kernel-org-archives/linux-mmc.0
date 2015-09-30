From: Mirza Krak <mirza.krak@hostmobility.com>
Subject: MMC card removal during suspend
Date: Wed, 30 Sep 2015 08:46:04 +0200
Message-ID: <CAJ=nTsuXgR4Fmjriy32LvbO49Yk_q0RYBV1S2FwHG+hZgG3aRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f54.google.com ([209.85.215.54]:34742 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753909AbbI3GqG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Sep 2015 02:46:06 -0400
Received: by labzv5 with SMTP id zv5so34547687lab.1
        for <linux-mmc@vger.kernel.org>; Tue, 29 Sep 2015 23:46:05 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>

Hi.

I have a questing regard of what happens during suspend with the MMC
card, or even more correctly what does not happen.

I am running the 4.1.5 kernel on a Colibri VF SOM.

What I would like to happen when i suspend my system to memory is that
the MMC card is removed before suspend. The reason is that we will cut
the power rail to the MMC card during suspend on our board, which
means that it will fail on resume if we do not remove the card before
suspending.

=46rom what I read on the "internet", above behavior used to be default=
=2E
It no longer is it seems.

My question is, is there a "correct" way of getting the behavior I woul=
d like?

My hack today is to declare a pre_suspend callback in mmc.c returning -=
ENOSYS.

--=20
Med V=C3=A4nliga H=C3=A4lsningar / Best Regards

*******************************************************************
Mirza Krak
Host Mobility AB
mirza.krak@hostmobility.com
Anders Personsgatan 12, 416 64 G=C3=B6teborg
Sweden
http://www.hostmobility.com
Direct: +46 31 31 32 704
Phone: +46 31 31 32 700
=46ax: +46 31 80 67 51
Mobile: +46 730 28 06 22
*******************************************************************
