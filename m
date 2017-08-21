From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [GIT PULL] Update DWMMC controller
Date: Mon, 21 Aug 2017 14:32:59 +0200
Message-ID: <CAPDyKFqSaBkpbHKkfvOxQU_uhNgh1WQ+=PQXdRRDOnFd6X_Z+Q@mail.gmail.com>
References: <CGME20170818054821epcas2p4dd5a5a393c47c644d09d6b29747aeb0d@epcas2p4.samsung.com>
 <36f44627-123c-d6f3-41e4-f09892895cfa@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f177.google.com ([209.85.220.177]:34476 "EHLO
        mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753524AbdHUMdA (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Aug 2017 08:33:00 -0400
Received: by mail-qk0-f177.google.com with SMTP id u139so81621187qka.1
        for <linux-mmc@vger.kernel.org>; Mon, 21 Aug 2017 05:33:00 -0700 (PDT)
In-Reply-To: <36f44627-123c-d6f3-41e4-f09892895cfa@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 18 August 2017 at 07:48, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>
> Dear Ulf,
>
> Could you pull these patches to next branch?
> If there is any issue, let me know, plz.
>
> The following changes since commit 7bb2a5d1342fcba2e32406fdb1e4c3d501ec6782:
>
>   Merge branch 'fixes' into next (2017-08-09 13:22:47 +0200)
>
> are available in the git repository at:
>
>   https://github.com/jh80chung/dw-mmc.git for-ulf
>
> for you to fetch changes up to 024d4a5a8a89f247d36fd36a2f61f53bf8eae586:
>
>   mmc: dw_mmc: introduce timer for broken command transfer over scheme (2017-08-18 14:44:40 +0900)
>
> ----------------------------------------------------------------
> Addy Ke (1):
>       mmc: dw_mmc: introduce timer for broken command transfer over scheme
>
> liwei (2):
>       mmc: dw_mmc: move controller reset before driver init
>       mmc: dw_mmc-k3: add sd support for hi3660
>
>  drivers/mmc/host/dw_mmc-k3.c | 298 +++++++++++++++++++++++++++++++++++++++++++
>  drivers/mmc/host/dw_mmc.c    |  60 ++++++++-
>  drivers/mmc/host/dw_mmc.h    |   4 +
>  3 files changed, 356 insertions(+), 6 deletions(-)
>
> Best Regards,
> Jaehoon Chung


Thanks, pulled into next!

Kind regards
Uffe
