From: Linus Walleij <linus.ml.walleij@gmail.com>
Subject: Re: [PATCH 1/2] mmc: agressive clocking framework v8
Date: Wed, 22 Dec 2010 09:12:16 +0100
Message-ID: <AANLkTikdA5Pbiwx+VdhtgShhMGcLkJLV0B5O_Yi+_aCx@mail.gmail.com>
References: <1288776170-10141-1-git-send-email-linus.walleij@stericsson.com>
	<20101221202408.GA12006@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:38280 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752285Ab0LVIMQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Dec 2010 03:12:16 -0500
Received: by pva4 with SMTP id 4so978592pva.19
        for <linux-mmc@vger.kernel.org>; Wed, 22 Dec 2010 00:12:16 -0800 (PST)
In-Reply-To: <20101221202408.GA12006@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Ghorai Sukumar <s-ghorai@ti.com>, Nicolas Pitre <nico@fluxnic.net>, Adrian Hunter <adrian.hunter@nokia.com>, David Vrabel <david.vrabel@csr.com>, Kyungmin Park <kmpark@infradead.org>, jh80.chung@samsung.com

2010/12/21 Chris Ball <cjb@laptop.org>:

> Hi Linus,
>
> On Wed, Nov 03, 2010 at 10:22:50AM +0100, Linus Walleij wrote:
>> +/*
>> + * =A0 mmc_host_clk_exit - shut down clock gating code
>> + * =A0 @host: host with potential clock to control
>> + */
>> +static inline void mmc_host_clk_exit(struct mmc_host *host)
>> +{
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* Wait for any outstanding gate and then make sure we'r=
e
>> + =A0 =A0 =A0* ungated before exiting.
>> + =A0 =A0 =A0*/
>> + =A0 =A0 if (cancel_work_sync(&host->clk_disable_work))
>> + =A0 =A0 =A0 =A0 =A0 =A0 mmc_host_clk_gate_delayed(host);
>> + =A0 =A0 if (host->clk_gated)
>> + =A0 =A0 =A0 =A0 =A0 =A0 mmc_host_clk_ungate(host);
>> + =A0 =A0 BUG_ON(host->clk_requests > 0);
>> +}
>
> I just hit the BUG_ON() above, when doing "rmmod sdhci-pci" on my x86
> laptop running today's linux-next. =A0There was *no* SD card inserted=
,
> and hadn't been one inserted all boot.

Hm, it's a plain bug...

We make sure it's ungated the line above so clk_requests is always
=3D=3D 1.

It should be BUG_ON(host->clk_requests > 1)

Can you try the below:

=46rom: Linus Walleij <linus.walleij@stericsson.com>
Date: Wed, 22 Dec 2010 09:10:04 +0100
Subject: [PATCH] mmc: check for > 1 clk_requests

Since we make sure the clock is enabled in the mmc_host_clk_exit()
function we should expect a reference counter of 1, not 0.

Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 drivers/mmc/core/host.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 92e3370..072d29c 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -235,7 +235,7 @@ static inline void mmc_host_clk_exit(struct mmc_hos=
t *host)
 		mmc_host_clk_gate_delayed(host);
 	if (host->clk_gated)
 		mmc_host_clk_ungate(host);
-	BUG_ON(host->clk_requests > 0);
+	BUG_ON(host->clk_requests > 1);
 }

 #else
--=20
1.7.3.3

Yours,
Linus Walleij
