From: Fabio Estevam <festevam@gmail.com>
Subject: Re: imx7: mmc_select_hs200 failed, error -74
Date: Tue, 16 May 2017 12:37:08 -0300
Message-ID: <CAOMZO5AXb3-YGc7hGRP_OY8C-Go0pBECbDoQo1SUB1i=t1Xi4w@mail.gmail.com>
References: <CAOMZO5ByTR1C4qUdc+hBcGTFVf-NH2gS5PmH3=w5-TrAoDQVUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oi0-f54.google.com ([209.85.218.54]:34724 "EHLO
        mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751569AbdEPPhK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 16 May 2017 11:37:10 -0400
Received: by mail-oi0-f54.google.com with SMTP id b204so30134994oii.1
        for <linux-mmc@vger.kernel.org>; Tue, 16 May 2017 08:37:09 -0700 (PDT)
In-Reply-To: <CAOMZO5ByTR1C4qUdc+hBcGTFVf-NH2gS5PmH3=w5-TrAoDQVUA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dong Aisheng <aisheng.dong@nxp.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Stefan Agner <stefan@agner.ch>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Tue, May 16, 2017 at 10:58 AM, Fabio Estevam <festevam@gmail.com> wrote:
> Hi,
>
> On a imx7s-warp board (sdhci-esdhc-imx.c driver) running 4.12-rc1 the
> following mmc1 error message is seen:
>
> [    1.796192] mmc1: mmc_select_hs200 failed, error -74
> [    1.810220] mmc1: new MMC card at address 0001
> [    1.823066] mmcblk1: mmc1:0001 V10008 7.05 GiB
> [    1.834155] mmcblk1boot0: mmc1:0001 V10008 partition 1 4.00 MiB
> [    1.841608] mmcblk1boot1: mmc1:0001 V10008 partition 2 4.00 MiB
> [    1.848971] mmcblk1rpmb: mmc1:0001 V10008 partition 3 4.00 MiB
> [    1.859576]  mmcblk1: p1 p2
>
> The rootfs can be mounted correctly from eMMC though.
>
> What is the proper way to fix the 'mmc_select_hs200 failed' error message?

with the following changes:

--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1454,7 +1454,7 @@ static int mmc_select_hs200(struct mmc_card *card)
                if (mmc_set_signal_voltage(host, old_signal_voltage))
                        err = -EIO;

-               pr_err("%s: %s failed, error %d\n", mmc_hostname(card->host),
+               pr_debug("%s: %s failed, error %d\n", mmc_hostname(card->host),
                       __func__, err);
        }
        return err;
@@ -1474,7 +1474,7 @@ static int mmc_select_timing(struct mmc_card *card)
                err = mmc_select_hs400es(card);
        else if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS200)
                err = mmc_select_hs200(card);
-       else if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS)
+       if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS)
                err = mmc_select_hs(card);

        if (err && err != -EBADMSG)

the card is probed as DDR MMC and the error message is gone:

# dmesg | grep mmc1
[    1.702797] mmc1: SDHCI controller on 30b60000.usdhc [30b60000.usdhc] using A
[    1.811211] mmc1: new DDR MMC card at address 0001
[    1.820786] mmcblk1: mmc1:0001 V10008 7.05 GiB
[    1.833340] mmcblk1boot0: mmc1:0001 V10008 partition 1 4.00 MiB
[    1.840518] mmcblk1boot1: mmc1:0001 V10008 partition 2 4.00 MiB
[    1.847812] mmcblk1rpmb: mmc1:0001 V10008 partition 3 4.00 MiB

Is this a correct fix?

Thanks
