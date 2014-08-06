From: Jean-Michel Hautbois <jean-michel.hautbois@vodalys.com>
Subject: Re: Sandisk MMC I/O errors
Date: Wed, 6 Aug 2014 08:54:59 +0200
Message-ID: <CAL8zT=gS1rwFU1eUcYNpKmygpnmTDXeQRtg6Uxr9FVXRJ6PmeA@mail.gmail.com>
References: <CAL8zT=iinDtm3_77jSDWG1RSjN5CgEtAgPjA_ju3-=ZS2Qco8A@mail.gmail.com>
 <CAOMZO5ABt9kwxdfk-tKMTc76jY==fJtPd7AoPZoGvHvSDM6xXg@mail.gmail.com>
 <CAL8zT=iKKqQeOJk+X4tExA4nSatNHK2VagoaC2Ar+oKjjbWahA@mail.gmail.com>
 <CAOMZO5B36yQx-renFLaPDSY12kmPuPGVOkXT3nJKb2gRhdTdPQ@mail.gmail.com>
 <CAL8zT=jmbvaDpj+Dhww90ah6gzNRGWkgNwWt_xTVfcygxa0Ocw@mail.gmail.com>
 <CAL8zT=itTv9Uy4HreJQdttwhn29sKcNGc6ccynCNcScrFeWYig@mail.gmail.com>
 <CAOMZO5Dbmk3kxwn__o+fB0Wwumq5f+4tvu0m0x3aqOAZC-GWTQ@mail.gmail.com>
 <CAL8zT=iRtmKZyHNYR+-c0KuOaN06Tg60QiWwePvz+auWhpRtPw@mail.gmail.com> <CAC1bqKgct-Hq3+9PZ-6p79qSjf=UNhpLWykJ_e0=1ThGoMPpkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f182.google.com ([209.85.214.182]:51166 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753704AbaHFGzP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 6 Aug 2014 02:55:15 -0400
Received: by mail-ob0-f182.google.com with SMTP id wm4so1489784obc.41
        for <linux-mmc@vger.kernel.org>; Tue, 05 Aug 2014 23:55:14 -0700 (PDT)
In-Reply-To: <CAC1bqKgct-Hq3+9PZ-6p79qSjf=UNhpLWykJ_e0=1ThGoMPpkg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Hsin-Hsiang Tseng <hsinhsiangtseng@gmail.com>
Cc: Fabio Estevam <festevam@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

2014-08-06 3:15 GMT+02:00 Hsin-Hsiang Tseng <hsinhsiangtseng@gmail.com>:
> from your log, maybe you should check the driver use byte mode or
> sector mode to access eMMC.
> Because the capacity of eMMC which you used is less or equal to 2GB.

How can I know that ?
FYI :
$> cat /sys/kernel/debug/mmc1/ios
clock:          52000000 Hz
actual clock:   49500000 Hz
vdd:            21 (3.3 ~ 3.4 V)
bus mode:       2 (push-pull)
chip select:    0 (don't care)
power mode:     2 (on)
bus width:      3 (8 bits)
timing spec:    8 (mmc DDR52)
signal voltage: 0 (3.30 V)
