From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH] mmc: sdio: reset card during power_restore
Date: Thu, 9 Jun 2011 06:23:59 +0300
Message-ID: <BANLkTimhPWxQ57L0JD_r8wXp6o8FdpqJ8w@mail.gmail.com>
References: <20110605123852.BC6F39D401C@zog.reactivated.net>
 <BANLkTimus7C-=_b2hgdfakU6Dt9=FgzyrQ@mail.gmail.com> <BANLkTin=+QGN=6_YjH8uEyZBbnTjuEXDjA@mail.gmail.com>
 <BANLkTi=-ZRVLqrmriGOV7YGXHHvJHTmkzg@mail.gmail.com> <BANLkTikvdm=RLoY38xrvVAF5Zo9qCSa4hg@mail.gmail.com>
 <BANLkTinbqoPOMuL30ksmDJEtM2RebAhksQ@mail.gmail.com> <BANLkTini3Oz7P3ji9rrnh75bcwf=vdyWkg@mail.gmail.com>
 <BANLkTimngwDzxW04AMFWBNYLvYFXUhMWQQ@mail.gmail.com> <BANLkTikUaKt3ESg0RKGpxCBK1t6fVvvGqx__uGzp_thPyzcmpA@mail.gmail.com>
 <BANLkTin43tZO1s-MFCnNt0q7pKvf1XRC9w@mail.gmail.com> <BANLkTinhRwr+qxujeFhy3C4LBkA5p2+ph_e1sy6vcuCiD_vKUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:50119 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755140Ab1FIDYU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 8 Jun 2011 23:24:20 -0400
Received: by wwa36 with SMTP id 36so1223468wwa.1
        for <linux-mmc@vger.kernel.org>; Wed, 08 Jun 2011 20:24:19 -0700 (PDT)
In-Reply-To: <BANLkTinhRwr+qxujeFhy3C4LBkA5p2+ph_e1sy6vcuCiD_vKUA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: linux-mmc@vger.kernel.org

On Wed, Jun 8, 2011 at 11:58 PM, Daniel Drake <dsd@laptop.org> wrote:
>> Please reboot, and immediately after booting (without insmoding the
>> driver) tell me what's the output of :
>>
>> mount -t debugfs none /sys/kernel/debug
>> cat /sys/kernel/debug/mmc1/ios
>
> Which base kernel setup should I run these tests on?

Vanilla, with your temporary patch below.

Without this patch, mmc1 (I assume this what drives sd8686 in your
setup) should be powered on. With it, it should be powered off.

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 58d5436..ce3e2e2 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2488,7 +2488,7 @@ int sdhci_add_host(struct sdhci_host *host)
 	} else
 		mmc->f_min = host->max_clk / SDHCI_MAX_DIV_SPEC_200;

-	mmc->caps |= MMC_CAP_SDIO_IRQ | MMC_CAP_ERASE | MMC_CAP_CMD23;
+	mmc->caps |= MMC_CAP_SDIO_IRQ | MMC_CAP_ERASE | MMC_CAP_CMD23 |
MMC_CAP_POWER_OFF_CARD;

 	if (host->quirks & SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12)
 		host->flags |= SDHCI_AUTO_CMD12;
