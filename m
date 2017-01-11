From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [GIT PULL] Update DWMMC controller
Date: Wed, 11 Jan 2017 13:08:46 +0100
Message-ID: <CAPDyKFpWKBAYDfP3HVn+eTicJW=-MgKc=E8Fy43MhQjS4Bi9NA@mail.gmail.com>
References: <CGME20170111065447epcas1p103bf2619fe6b404ee3b796b46e3e7467@epcas1p1.samsung.com>
 <03053aab-160b-cd09-32ce-64e65ca18b64@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:36493 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934157AbdAKMIs (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 11 Jan 2017 07:08:48 -0500
Received: by mail-wm0-f46.google.com with SMTP id c85so156129976wmi.1
        for <linux-mmc@vger.kernel.org>; Wed, 11 Jan 2017 04:08:48 -0800 (PST)
In-Reply-To: <03053aab-160b-cd09-32ce-64e65ca18b64@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jun Nie <jun.nie@linaro.org>

On 11 January 2017 at 07:54, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> Dear Ulf,
>
> Could you pull these patches for next on your repository?
> If there is an issue, let me know, plz.
>
> The following changes since commit 46579f1ed89f4fffba579ec72cfd216ff6666be0:
>
>   mmc: host: Include interrupt.h in mmc host drivers that depends on it (2017-01-10 16:34:04 +0100)
>
> are available in the git repository at:
>
>   https://github.com/jh80chung/dw-mmc.git for-ulf
>
> for you to fetch changes up to d1a05fd54cf927c2060800ed34286958b6afaf25:
>
>   mmc: dw_mmc: zx: Initial support for ZX mmc controller (2017-01-11 15:47:31 +0900)
>
> ----------------------------------------------------------------
> Jun Nie (5):
>       Documentation: synopsys-dw-mshc: add binding for fifo quirks
>       mmc: dw_mmc: Add fifo address property
>       mmc: dw_mmc: Add fifo watermark alignment property
>       mmc: dt-bindings: add ZTE ZX296718 MMC bindings
>       mmc: dw_mmc: zx: Initial support for ZX mmc controller
>
>  .../devicetree/bindings/mmc/synopsys-dw-mshc.txt   |  13 ++
>  .../devicetree/bindings/mmc/zx-dw-mshc.txt         |  33 +++
>  drivers/mmc/host/Kconfig                           |   9 +
>  drivers/mmc/host/Makefile                          |   1 +
>  drivers/mmc/host/dw_mmc-zx.c                       | 241 +++++++++++++++++++++
>  drivers/mmc/host/dw_mmc-zx.h                       |  31 +++
>  drivers/mmc/host/dw_mmc.c                          |  17 +-
>  drivers/mmc/host/dw_mmc.h                          |   5 +
>  8 files changed, 347 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mmc/zx-dw-mshc.txt
>  create mode 100644 drivers/mmc/host/dw_mmc-zx.c
>  create mode 100644 drivers/mmc/host/dw_mmc-zx.h
>
> Best Regards,
> Jaehoon Chung


Thanks Jaehoon, pulled into my next branch!

Kind regards
Uffe
