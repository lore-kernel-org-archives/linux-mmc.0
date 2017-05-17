From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] mmc: core: Allow fallback to mmc_select_hs()
Date: Wed, 17 May 2017 15:43:55 -0300
Message-ID: <CAOMZO5BW0QmY_+gN_6xDcoj1zT1Jvqt70tnPem0Yp9GJhQbCvw@mail.gmail.com>
References: <1494957607-31956-1-git-send-email-fabio.estevam@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:35180 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752832AbdEQSn4 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 17 May 2017 14:43:56 -0400
Received: by mail-oi0-f67.google.com with SMTP id m17so3581504oik.2
        for <linux-mmc@vger.kernel.org>; Wed, 17 May 2017 11:43:56 -0700 (PDT)
In-Reply-To: <1494957607-31956-1-git-send-email-fabio.estevam@nxp.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Stefan Agner <stefan@agner.ch>, Marcel Ziswiler <marcel.ziswiler@toradex.com>, Dong Aisheng <aisheng.dong@nxp.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Tue, May 16, 2017 at 3:00 PM, Fabio Estevam <fabio.estevam@nxp.com> wrote:
> If mmc_select_hs200() fails there is still a chance that the
> card could operate in high speed mode, so change the logic in
> mmc_select_timing() to allow a fallback to mmc_select_hs().
>
> Tested on a imx7s-warp board.
>
> Before this patch:
>
> mmc1: mmc_select_hs200 failed, error -74
> mmc1: new MMC card at address 0001
> mmcblk1: mmc1:0001 V10008 7.05 GiB
> mmcblk1boot0: mmc1:0001 V10008 partition 1 4.00 MiB
> mmcblk1boot1: mmc1:0001 V10008 partition 2 4.00 MiB
> mmcblk1rpmb: mmc1:0001 V10008 partition 3 4.00 MiB
>
> # cat /sys/kernel/debug/mmc1/ios
> clock:          25000000 Hz
> actual clock:   24545454 Hz
> vdd:            21 (3.3 ~ 3.4 V)
> bus mode:       2 (push-pull)
> chip select:    0 (don't care)
> power mode:     2 (on)
> bus width:      3 (8 bits)
> timing spec:    0 (legacy)
> signal voltage: 0 (3.30 V)
> driver type:    0 (driver type B)
>
> After this patch:
>
> mmc1: mmc_select_hs200 failed, error -74
> mmc1: new DDR MMC card at address 0001
> mmcblk1: mmc1:0001 V10008 7.05 GiB
> mmcblk1boot0: mmc1:0001 V10008 partition 1 4.00 MiB
> mmcblk1boot1: mmc1:0001 V10008 partition 2 4.00 MiB
> mmcblk1rpmb: mmc1:0001 V10008 partition 3 4.00 MiB
>
> # cat /sys/kernel/debug/mmc1/ios
> clock:          52000000 Hz
> actual clock:   49090909 Hz
> vdd:            21 (3.3 ~ 3.4 V)
> bus mode:       2 (push-pull)
> chip select:    0 (don't care)
> power mode:     2 (on)
> bus width:      3 (8 bits)
> timing spec:    8 (mmc DDR52)
> signal voltage: 1 (1.80 V)
> driver type:    0 (driver type B)
>
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Please ignore this patch.

As suggested by Stefan, passing 'no-1-8-v' in the device tree fixes the problem.
