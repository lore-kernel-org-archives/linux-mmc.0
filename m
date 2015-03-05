From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 0/7] mmc: sdhci: set .remove to sdhci_pltfm_unregister()
Date: Thu, 5 Mar 2015 14:46:09 +0100
Message-ID: <CAPDyKFo6QxS-F0+8vcPH6-23MD-Yqy+cd=yyd+2eSnW_0h5HEw@mail.gmail.com>
References: <1425023251-4544-1-git-send-email-haokexin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f172.google.com ([209.85.216.172]:32831 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752772AbbCENqK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Mar 2015 08:46:10 -0500
Received: by qcxm20 with SMTP id m20so42922445qcx.0
        for <linux-mmc@vger.kernel.org>; Thu, 05 Mar 2015 05:46:09 -0800 (PST)
In-Reply-To: <1425023251-4544-1-git-send-email-haokexin@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kevin Hao <haokexin@gmail.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>

On 27 February 2015 at 08:47, Kevin Hao <haokexin@gmail.com> wrote:
> Hi,
>
> v2:
>   - Update the sdhci-bcm-kona as suggested by Ray Jui.
>   - Also kill the private get_max_clock function in sdhci-sirf.
>
> v1:
> In the current kernel, the specific .remove function in several sdhci platform
> drivers seem pretty similar. Actually we can just set all of them to
> sdhci_pltfm_unregister() with just a bit twist.
>
> Only run test for sdhci-of-esdhc driver. All others just passed the build test.
>
> Kevin Hao (7):
>   mmc: sdhci-dove: remove the unneeded error check
>   mmc: sdhci-dove: kill the driver specific private struct
>   mmc: tegra: use devm help functions to get the clk and gpio
>   mmc: sdhci-sirf: kill the "clk" member in driver private struct
>   mmc: sdhci-bcm-kona: kill the "external_clk" member in driver private
>        struct
>   mmc: sdhci: disable the clock in sdhci_pltfm_unregister()
>   mmc: sdhci: set the .remove to sdhci_pltfm_unregister()
>
>  drivers/mmc/host/sdhci-bcm-kona.c  | 61 ++++++++------------------------------
>  drivers/mmc/host/sdhci-bcm2835.c   |  7 +----
>  drivers/mmc/host/sdhci-cns3xxx.c   |  7 +----
>  drivers/mmc/host/sdhci-dove.c      | 39 ++++--------------------
>  drivers/mmc/host/sdhci-of-arasan.c |  1 -
>  drivers/mmc/host/sdhci-of-esdhc.c  |  7 +----
>  drivers/mmc/host/sdhci-of-hlwd.c   |  7 +----
>  drivers/mmc/host/sdhci-pltfm.c     |  2 ++
>  drivers/mmc/host/sdhci-sirf.c      | 36 +++++-----------------
>  drivers/mmc/host/sdhci-st.c        | 12 +-------
>  drivers/mmc/host/sdhci-tegra.c     | 30 +++----------------
>  11 files changed, 36 insertions(+), 173 deletions(-)
>
> --
> 1.9.3
>

Applied, thanks!

Kind regards
Uffe
