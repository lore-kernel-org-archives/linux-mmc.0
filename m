From: Stefan Roese <sr@denx.de>
Subject: SDIO "SD2" vs. SD-card "SD3" interface on BayTrail
Date: Tue, 4 Jul 2017 14:53:56 +0200
Message-ID: <d7249bf2-b057-0535-334e-71cdc957e9b5@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx2.mailbox.org ([80.241.60.215]:55271 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752518AbdGDMyG (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 4 Jul 2017 08:54:06 -0400
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Hi,

we are currently investigating, if its possible to connect a SDIO
device (WLAN module) to the SD-card interface "SD3" of the BayTrail
SoC instead of the SDIO interface "SD2". The BayTrail manual states, 
that the SDIO interface is capable of connecting SDIO devices. Is
this also possible for the SD-card interface "SD3", even if its not
explicitly mentioned in the manual? If not, why is this not possible?

Any insight on this would be really helpful.

Thanks in advance,
Stefan
