From: Mason <slash.tmp@free.fr>
Subject: Arasan timeout clock frequency
Date: Wed, 7 Jun 2017 16:30:11 +0200
Message-ID: <0cf3607b-2806-c9f0-b3cc-1e475251eaee@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp5-g21.free.fr ([212.27.42.5]:50336 "EHLO smtp5-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751561AbdFGOaU (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 7 Jun 2017 10:30:20 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Douglas Anderson <dianders@chromium.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Thibaud Cornic <thibaud_cornic@sigmadesigns.com>

Hello Douglas,

I am once again looking at drivers/mmc/host/sdhci-of-arasan.c
because SDR50 SD cards are malfunctioning on a new board.

The only relevant difference between the two boards is the
"clk_xin" frequency => 48 MHz before, 200 MHz now.

Apparently, simply adding max-frequency = <60000000>; in the
mmc DT node works around the issue, but I'd like to get to
the bottom of it.

sdhci_arasan_get_timeout_clock() returns pltfm_host->clk
but IIUC, it's supposed to be a 6-bit field in the cap
register. So 48 used to fit, but 200 would overflow...
That would explain how capping at 60 MHz is a solution?

Anyway, I'll keep digging, but I'd like to hear your thoughts.

Regards.
