From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: Re: [PATCH v6 0/9] mmc: dw_mmc: add support for device tree based instantiation
Date: Tue, 18 Sep 2012 07:22:51 +0530
Message-ID: <CAJuYYwRcoOv5X=XK8wiVb9fzSAdY_d=+kvJhqMdiT1Fey0JCLw@mail.gmail.com>
References: <1347905803-22742-1-git-send-email-thomas.abraham@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:61960 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753422Ab2IRBwx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Sep 2012 21:52:53 -0400
Received: by lagy9 with SMTP id y9so4621754lag.19
        for <linux-mmc@vger.kernel.org>; Mon, 17 Sep 2012 18:52:52 -0700 (PDT)
In-Reply-To: <1347905803-22742-1-git-send-email-thomas.abraham@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
Cc: will.newton@imgtec.com, cjb@laptop.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, girish.shivananjappa@linaro.org, jh80.chung@samsung.com, tgih.jun@samsung.com, patches@linaro.org

On 17 September 2012 23:46, Thomas Abraham <thomas.abraham@linaro.org> wrote:
> This series add device tree support for Synopsis Designware IP - Mobile Storage
> Host Controller (MSHC). I had addressed all comments for the v5 version of this
> patch series and had reposted only those patches that were modified. The version
> number of those reposted patches was maintained as v5 as the changes did not
> need any major rework.
>
> This is mainly a repost of the v5 patches with all patches marked as v6. The
> only new change in this series is adding a comment about bus_hz in platform
> data structure of the driver as suggested by Seungwon Jeon.
>
> Thomas Abraham (9):
>   mmc: dw_mmc: convert copy of struct device in struct dw_mci to a reference
>   mmc: dw_mmc: Use devm_* functions in dw_mmc platform driver
>   mmc: dw_mmc: allow probe to succeed even if one slot is initialized
>   mmc: dw_mmc: lookup for optional biu and ciu clocks
>   mmc: dw_mmc: add quirk to indicate missing write protect line
>   mmc: dw_mmc: add device tree support
>   mmc: dw_mmc: prepare functions in dw_mmc-pltfm for reuse
>   mmc: dw_mmc: add support for implementation specific callbacks
>   mmc: dw_mmc: add support for exynos specific implementation of dw-mshc
>
>  .../devicetree/bindings/mmc/exynos-dw-mshc.txt     |   87 ++++++
>  .../devicetree/bindings/mmc/synposis-dw-mshc.txt   |   79 +++++
>  drivers/mmc/host/Kconfig                           |    9 +
>  drivers/mmc/host/Makefile                          |    1 +
>  drivers/mmc/host/dw_mmc-exynos.c                   |  253 ++++++++++++++++
>  drivers/mmc/host/dw_mmc-pci.c                      |    2 +-
>  drivers/mmc/host/dw_mmc-pltfm.c                    |   60 +++--
>  drivers/mmc/host/dw_mmc-pltfm.h                    |   20 ++
>  drivers/mmc/host/dw_mmc.c                          |  308 +++++++++++++++++---
>  drivers/mmc/host/dw_mmc.h                          |   24 ++
>  include/linux/mmc/dw_mmc.h                         |   15 +-
>  11 files changed, 782 insertions(+), 76 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
>  create mode 100644 Documentation/devicetree/bindings/mmc/synposis-dw-mshc.txt
>  create mode 100644 drivers/mmc/host/dw_mmc-exynos.c
>  create mode 100644 drivers/mmc/host/dw_mmc-pltfm.h

Hi Jaehoon, Seungwon,

All the changes you have suggested for this patch series has been
completed. If you could ack this series, it would be great.

Thanks,
Thomas.
