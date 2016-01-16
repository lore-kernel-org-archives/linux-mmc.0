From: Muni Sekhar <munisekharrms@gmail.com>
Subject: sdhci: SDCLK frequency change
Date: Sat, 16 Jan 2016 16:46:08 +0530
Message-ID: <CAHhAz+h7Q0iGVimg17_SpU=MA+3NSZ+o4WYFA1fRAjA4Di-skg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ig0-f172.google.com ([209.85.213.172]:38204 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751463AbcAPLQJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 16 Jan 2016 06:16:09 -0500
Received: by mail-ig0-f172.google.com with SMTP id mw1so25002455igb.1
        for <linux-mmc@vger.kernel.org>; Sat, 16 Jan 2016 03:16:09 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>

[ Please keep me in CC as I'm not subscribed to the list]

 Hello,

I enabled SDHCI_QUIRK2_PRESET_VALUE_BROKEN and tested the SDCLK
frequency change by running =E2=80=98echo =E2=80=9C<freq>=E2=80=9D >
/sys/kernel/debug/mmc0/clock=E2=80=99.

=46or this scenario, sdhci_set_clock() called twice from
sdhci_do_set_ios(). Why sdhci_set_clock() needs to be called twice,
any explanation?


--=20
Thanks,
Sekhar
