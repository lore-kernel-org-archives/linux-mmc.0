From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [ulf.hansson-mmc:next 6/19] drivers/mmc/host/sdhci-omap.c:466:8:
 error: implicit declaration of function 'pinctrl_select_state'; did you mean 'node_set_state'?
Date: Thu, 15 Feb 2018 07:46:22 +0100
Message-ID: <CAPDyKFooJneuOG-0B3S1XmcpLoxdiRYNT57HJYUuiiYXm_7zdw@mail.gmail.com>
References: <201802142054.sFImvGeA%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:52652 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752144AbeBOGqX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 15 Feb 2018 01:46:23 -0500
Received: by mail-it0-f66.google.com with SMTP id o13so18106306ito.2
        for <linux-mmc@vger.kernel.org>; Wed, 14 Feb 2018 22:46:23 -0800 (PST)
In-Reply-To: <201802142054.sFImvGeA%fengguang.wu@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 14 February 2018 at 13:22, kbuild test robot <fengguang.wu@intel.com> wrote:
> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git next
> head:   779e209cefc2ef7da86f79894bc1988bc38b048a
> commit: 713190bb14aaa6113fd54416fa909028e550fb08 [6/19] mmc: sdhci_omap: Add support to set IODELAY values
> config: sh-allmodconfig (attached as .config)
> compiler: sh4-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 713190bb14aaa6113fd54416fa909028e550fb08
>         # save the attached .config to linux build tree
>         make.cross ARCH=sh
>
> All error/warnings (new ones prefixed by >>):
>
>    drivers/mmc/host/sdhci-omap.c: In function 'sdhci_omap_set_timing':
>>> drivers/mmc/host/sdhci-omap.c:466:8: error: implicit declaration of function 'pinctrl_select_state'; did you mean 'node_set_state'? [-Werror=implicit-function-declaration]
>      ret = pinctrl_select_state(omap_host->pinctrl, pinctrl_state);
>            ^~~~~~~~~~~~~~~~~~~~
>            node_set_state
>    drivers/mmc/host/sdhci-omap.c: In function 'sdhci_omap_iodelay_pinctrl_state':
>>> drivers/mmc/host/sdhci-omap.c:740:18: error: implicit declaration of function 'pinctrl_lookup_state'; did you mean 'inc_zone_state'? [-Werror=implicit-function-declaration]
>      pinctrl_state = pinctrl_lookup_state(omap_host->pinctrl, mode);
>                      ^~~~~~~~~~~~~~~~~~~~
>                      inc_zone_state
>>> drivers/mmc/host/sdhci-omap.c:740:16: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
>      pinctrl_state = pinctrl_lookup_state(omap_host->pinctrl, mode);
>                    ^
>    drivers/mmc/host/sdhci-omap.c: In function 'sdhci_omap_config_iodelay_pinctrl_state':
>>> drivers/mmc/host/sdhci-omap.c:769:23: error: implicit declaration of function 'devm_pinctrl_get'; did you mean 'devm_clk_get'? [-Werror=implicit-function-declaration]
>      omap_host->pinctrl = devm_pinctrl_get(omap_host->dev);
>                           ^~~~~~~~~~~~~~~~
>                           devm_clk_get
>    drivers/mmc/host/sdhci-omap.c:769:21: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
>      omap_host->pinctrl = devm_pinctrl_get(omap_host->dev);
>                         ^
>    drivers/mmc/host/sdhci-omap.c:775:8: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
>      state = pinctrl_lookup_state(omap_host->pinctrl, "default");
>            ^
>    cc1: some warnings being treated as errors
>
> vim +466 drivers/mmc/host/sdhci-omap.c
>
>    450
>    451  static void sdhci_omap_set_timing(struct sdhci_omap_host *omap_host, u8 timing)
>    452  {
>    453          int ret;
>    454          struct pinctrl_state *pinctrl_state;
>    455          struct device *dev = omap_host->dev;
>    456
>    457          if (!(omap_host->flags & SDHCI_OMAP_REQUIRE_IODELAY))
>    458                  return;
>    459
>    460          if (omap_host->timing == timing)
>    461                  return;
>    462
>    463          sdhci_omap_stop_clock(omap_host);
>    464
>    465          pinctrl_state = omap_host->pinctrl_state[timing];
>  > 466          ret = pinctrl_select_state(omap_host->pinctrl, pinctrl_state);
>    467          if (ret) {
>    468                  dev_err(dev, "failed to select pinctrl state\n");
>    469                  return;
>    470          }
>    471
>    472          sdhci_omap_start_clock(omap_host);
>    473          omap_host->timing = timing;
>    474  }
>    475

Kishon, no actions needed. I amended to offending commit by adding the
missing include file.

Kind regards
Uffe
