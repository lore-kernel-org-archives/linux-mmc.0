From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [GIT PULL] Update DWMMC controller
Date: Tue, 14 Mar 2017 17:20:56 +0100
Message-ID: <CAPDyKFredVu8p96ZVS6BDvDJ25YFz8Swb5QV5=_r9A=_ubC_7w@mail.gmail.com>
References: <CGME20170308095956epcas1p43c9c1eafc3739eef039ac3be59c7d5b1@epcas1p4.samsung.com>
 <e9fc24d7-69e5-6969-68b8-8168f7f1bf9a@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ua0-f179.google.com ([209.85.217.179]:33344 "EHLO
        mail-ua0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752960AbdCNQVI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Mar 2017 12:21:08 -0400
Received: by mail-ua0-f179.google.com with SMTP id u30so174616591uau.0
        for <linux-mmc@vger.kernel.org>; Tue, 14 Mar 2017 09:21:02 -0700 (PDT)
In-Reply-To: <e9fc24d7-69e5-6969-68b8-8168f7f1bf9a@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>

On 8 March 2017 at 10:59, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> Dear Ulf,
>
> Could you pull these patches into your next repository?
>
> The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:
>
>   Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)
>
> are available in the git repository at:
>
>   https://github.com/jh80chung/dw-mmc.git for-ulf
>
> for you to fetch changes up to 3f7f0fe4662f23d34cd741221842a45f253200ef:
>
>   mmc: dw_mmc: improve dw_mci_reset a bit (2017-03-07 17:30:24 +0900)
>
> ----------------------------------------------------------------
> Shawn Lin (7):
>       mmc: dw_mmc: improve the timeout polling code
>       mmc: dw_mmc: move dw_mci_reset forward to avoid declaration
>       mmc: dw_mmc: move dw_mci_ctrl_reset forward to avoid declaration
>       mmc: dw_mmc: move dw_mci_get_cd forward to avoid declaration
>       mmc: dw_mmc: remove declaration of dw_mci_card_busy
>       mmc: dw_mmc: move mci_send_cmd forward to avoid declaration
>       mmc: dw_mmc: improve dw_mci_reset a bit
>
>  drivers/mmc/host/dw_mmc.c | 383 ++++++++++++++++++++++------------------------
>  1 file changed, 182 insertions(+), 201 deletions(-)
>
>
> Best Regards,
> Jaehoon Chung

Thanks, Jaehoon! Pulled into next!

Seems like you forgot to add your sob tag, I did it for you. Please
tell if you are not okay with it.

Kind regards
Uffe
