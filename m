From: Barry Song <21cnbao@gmail.com>
Subject: [PATCH] mmc:sdhci:add support to request/free pins for controllers
 sharing hardware bus
Date: Tue, 26 Apr 2011 11:34:20 +0800
Message-ID: <BANLkTinj4pnDG=cCJY3JGYGXOYoVPHtA9A@mail.gmail.com>
References: <5EB3BFCD089AD643B9BB63439F5FD5E9A127@SHAASIEXM01.ASIA.ROOT.PRI>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:56247 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757935Ab1DZDek convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 25 Apr 2011 23:34:40 -0400
Received: by qwk3 with SMTP id 3so97675qwk.19
        for <linux-mmc@vger.kernel.org>; Mon, 25 Apr 2011 20:34:40 -0700 (PDT)
In-Reply-To: <5EB3BFCD089AD643B9BB63439F5FD5E9A127@SHAASIEXM01.ASIA.ROOT.PRI>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org, linux-mmc@vger.kernel.org
Cc: Binghua.Duan@csr.com, andreiw@motorola.com, prakity@marvell.com

=46rom: Bin Shi <bin.shi@csr.com>

some controllers share data bus or other pins between
multi-controllers and need to switch the functions of shared pins
runtime.
this patch requested those shared pins before actual hardware access
and release them after access

Signed-off-by: Bin Shi <bin.shi@csr.com>
Cc: Binghua Duan <binghua.duan@csr.com>
Cc: Andrei Warkentin <andreiw@motorola.com>
Cc: Philip Rakity <prakity@marvell.com>
Signed-off-by: Barry Song <21cnbao@gmail.com>
---
=C2=A0drivers/mmc/host/sdhci.c | =C2=A0 13 +++++++++++++
=C2=A0drivers/mmc/host/sdhci.h | =C2=A0 =C2=A02 ++
=C2=A02 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index f70e21e..92ae9f7 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1143,6 +1143,13 @@ static void sdhci_request(struct mmc_host *mmc,
struct mmc_request *mrq)

=C2=A0 =C2=A0 =C2=A0 =C2=A0host =3D mmc_priv(mmc);

+ =C2=A0 =C2=A0 =C2=A0 /*
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0* some controllers share data bus or other=
 pins between
multi-controller
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0* and need to switch the function of pins =
runtime
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
+ =C2=A0 =C2=A0 =C2=A0 if (host->ops->get_shared_pins)
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 host->ops->get_share=
d_pins(host);
+
=C2=A0 =C2=A0 =C2=A0 =C2=A0spin_lock_irqsave(&host->lock, flags);

=C2=A0 =C2=A0 =C2=A0 =C2=A0WARN_ON(host->mrq !=3D NULL);
@@ -1417,6 +1424,12 @@ static void sdhci_tasklet_finish(unsigned long p=
aram)
=C2=A0 =C2=A0 =C2=A0 =C2=A0spin_unlock_irqrestore(&host->lock, flags);

=C2=A0 =C2=A0 =C2=A0 =C2=A0mmc_request_done(host->mmc, mrq);
+
+ =C2=A0 =C2=A0 =C2=A0 /*
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0* release shared pins so that other contro=
llers can use them
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
+ =C2=A0 =C2=A0 =C2=A0 if (host->ops->put_shared_pins)
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 host->ops->put_share=
d_pins(host);
=C2=A0}

=C2=A0static void sdhci_timeout_timer(unsigned long data)
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index c6e25a7..5a26cfe 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -231,6 +231,8 @@ struct sdhci_ops {
=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int =C2=A0 =C2=A0(*get_ro)(struct s=
dhci_host *host);
=C2=A0 =C2=A0 =C2=A0 =C2=A0void =C2=A0 =C2=A0(*platform_reset_enter)(st=
ruct sdhci_host *host, u8 mask);
=C2=A0 =C2=A0 =C2=A0 =C2=A0void =C2=A0 =C2=A0(*platform_reset_exit)(str=
uct sdhci_host *host, u8 mask);
+ =C2=A0 =C2=A0 =C2=A0 unsigned int =C2=A0 =C2=A0(*get_shared_pins)(str=
uct sdhci_host *host);
+ =C2=A0 =C2=A0 =C2=A0 unsigned int =C2=A0 =C2=A0(*put_shared_pins)(str=
uct sdhci_host *host);
=C2=A0};

=C2=A0#ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
--
1.7.1
