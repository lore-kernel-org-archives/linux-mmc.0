From: Muni Sekhar <munisekharrms@gmail.com>
Subject: mmc : sdhci_do_start_signal_voltage_switch
Date: Thu, 24 Sep 2015 17:51:37 +0530
Message-ID: <CAHhAz+jUKPwVFQgkrdkX2gM1fFecZWJJofV49jE+Z3gYEpQimQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ig0-f173.google.com ([209.85.213.173]:38172 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753881AbbIXMVh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Sep 2015 08:21:37 -0400
Received: by igxx6 with SMTP id x6so47391870igx.1
        for <linux-mmc@vger.kernel.org>; Thu, 24 Sep 2015 05:21:37 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hi ,

We planned to use the standard Linux MMC driver for our FPGA based SD
Host controller hardware.

I am having couple of doubts regarding SDIO voltage change
(sdhci_do_start_signal_voltage_switch()), please clarify me on this.

The MMC driver sets and clears bit 3 of the HOST_CONTROL_2 register,
when an IO voltage change is required (1=3D1.8v, 0=3D3.3v).

Our hardware detects a change in this bit value, and generates a new
interrupt when a change is seen.  This interrupt will be controlled by
some new registers, outside of the standard Host Controller register
set.

The interrupt handling routine shall, when seeing this interrupt,
program the desired SDIO IO voltage change.

MMC driver expects the voltage change to complete within 5ms - there
is a fixed 5ms wait in the MMC driver=E2=80=99s
sdhci_do_start_signal_voltage_switch() function. But our hardware is
nowhere near capable of conducting a voltage change in 5ms.  Instead
it=E2=80=99s of the order of ~300ms.  Does it causes any issues later d=
uring
testing? If so what should be the best possible solution?


--
Thanks,
Sekhar
