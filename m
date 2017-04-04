From: Tim Harvey <tharvey@gateworks.com>
Subject: IMX6 ESDHC mmc with UHS-I occasional failure with DDR50 cards
Date: Tue, 4 Apr 2017 14:26:40 -0700
Message-ID: <CAJ+vNU2S5NubFzKkHKjS2iHPt2_ysC-2e87ghUXPxsVEOKX+4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f51.google.com ([209.85.214.51]:36930 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752798AbdDDV0l (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 4 Apr 2017 17:26:41 -0400
Received: by mail-it0-f51.google.com with SMTP id a140so36446719ita.0
        for <linux-mmc@vger.kernel.org>; Tue, 04 Apr 2017 14:26:41 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linux MMC List <linux-mmc@vger.kernel.org>
Cc: Fabio Estevam <fabio.estevam@nxp.com>, Ulf Hansson <ulf.hansson@linaro.org>

Greetings,

I've been seeing mmc failures with Linux 4.10 on some IMX6 boards with
UHS-I support when used with DDR50 cards (I've got a couple from
different manufacturers). I do not see the same issues when using
SDR104 cards. I can also see the issue on the latest linux-mmc repo.

The issue is easily replicated by ejecting and inserting the DDR50 card

A successful init looks like this:
[  150.514018] mmc0: host does not support reading read-only switch,
assuming write-enable
[  150.578204] mmc0: new ultra high speed DDR50 SDHC card at address aaaa
[  150.592140] mmcblk0: mmc0:aaaa SL08G 7.40 GiB
[  150.611512]  mmcblk0: p1

A failing init (about 1 of every 5 trys) looks like this:
[   49.514082] mmc0: host does not support reading read-only switch,
assuming write-enable
[   49.676112] mmc0: tuning execution failed: -5
[   49.680510] mmc0: ddr50 tuning failed
[   49.684206] mmc0: new ultra high speed DDR50 SDHC card at address aaaa
[   49.696456] mmcblk0: mmc0:aaaa SL08G 7.40 GiB
^^^^ failed to read the partition table and at this point all access fails:
# dd if=/dev/mmcblk0 of=/dev/null bs=1k count=1
[   89.417210] mmcblk0: error -84 transferring data, sector 0, nr 32,
cmd response 0x900, card status 0xb00
1+0 records in
1+0 records out
1024 bytes (1.0 kB, 1.0 KiB) copied, 0.1227 s, 8.3 kB/s

I know the issue started occurring in Linux v4.4 but I also have heard
there are some tuning patches in the queue so before I bisected
between v4.4 and v4.3. Note that v4.3 is missing DDR50 tuning but when
I backport that I found that when ddr tuning failed there it did not
cause the card to not be accessible.

Regards,

Tim
