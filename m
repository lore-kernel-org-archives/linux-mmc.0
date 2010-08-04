From: viresh kumar <viresh.linux@gmail.com>
Subject: Query: sdhci - CMD51 fails with SD Cards.
Date: Wed, 4 Aug 2010 14:37:45 +0530
Message-ID: <AANLkTinR=NsqH69XsdmOseHAAW=vE3dwXG0o1V1RK-2-@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:53772 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755031Ab0HDJHq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Aug 2010 05:07:46 -0400
Received: by qwh6 with SMTP id 6so2787340qwh.19
        for <linux-mmc@vger.kernel.org>; Wed, 04 Aug 2010 02:07:46 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Viresh KUMAR <viresh.kumar@st.com>

Hello,

I am using sdhci & sdhci-spear drivers for arasan SDIO controller
present on ST SPEAr platform.
When i use MMC card, everything works fine and i am able to read/write
from card.
But when i use SD or MicroSD cards, then during initialization, CMD51
fails, read scr, i get error. (Data CRC).

Can somebody please guide where could be the issue.

viresh.
ST Microelectronics.
