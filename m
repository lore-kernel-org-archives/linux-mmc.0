From: Maurus Cuelenaere <mcuelenaere@gmail.com>
Subject: [PATCH] S3C64xx: remove SDHCI_QUIRK_NO_MULTIBLOCK
Date: Wed, 25 Nov 2009 16:55:21 +0100
Message-ID: <b2e8f9f70911250755iabbc8a2hd5a0ecec076b13dd@mail.gmail.com>
References: <b2e8f9f70911200404pca38ab6ycdca740ce81a6847@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:34991 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758500AbZKYPzh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 25 Nov 2009 10:55:37 -0500
Received: by bwz27 with SMTP id 27so7034329bwz.21
        for <linux-mmc@vger.kernel.org>; Wed, 25 Nov 2009 07:55:41 -0800 (PST)
In-Reply-To: <b2e8f9f70911200404pca38ab6ycdca740ce81a6847@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

This fixes SDIO as that requires multiblock transfers. This patch depen=
ds on the
following patches:

[PATCH] sdhci: Add new quirk in sdhci driver and update ADMA descriptor=
 build.
[PATCH] S3C: sdhci: Enable ADMA feature in S3C sdhci controller.

Signed-off-by: Maurus Cuelenaere <mcuelenaere@gmail.com>
---
=C2=A0drivers/mmc/host/sdhci-s3c.c | =C2=A0 =C2=A03 ---
=C2=A01 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.=
c
index 0f8ff86..4623876 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -324,9 +324,6 @@ static int __devinit sdhci_s3c_probe(struct
platform_device *pdev)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 * support as well. */
=C2=A0 =C2=A0 =C2=A0 =C2=A0host->quirks |=3D SDHCI_QUIRK_BROKEN_DMA;

- =C2=A0 =C2=A0 =C2=A0 /* PIO currently has problems with multi-block I=
O */
- =C2=A0 =C2=A0 =C2=A0 host->quirks |=3D SDHCI_QUIRK_NO_MULTIBLOCK;
-
=C2=A0#endif /* CONFIG_MMC_SDHCI_S3C_DMA */

=C2=A0 =C2=A0 =C2=A0 =C2=A0/* It seems we do not get an DATA transfer c=
omplete on non-busy
--
1.6.5.3
