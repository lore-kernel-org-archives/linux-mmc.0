From: Doug Anderson <dianders@chromium.org>
Subject: Re: [ulf.hansson-mmc:next 84/84] drivers/mmc/host/dw_mmc.c:1953:9:
 sparse: incompatible types in comparison expression (different type sizes)
Date: Wed, 1 Nov 2017 18:43:19 -0700
Message-ID: <CAD=FV=Uo+QO2i_F8KFWCDVp8UsuAc1UNypDCw55QrOJWW=R6YQ@mail.gmail.com>
References: <201711020209.Ik9aC6Yo%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ua0-f193.google.com ([209.85.217.193]:56633 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933083AbdKBBnV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Nov 2017 21:43:21 -0400
Received: by mail-ua0-f193.google.com with SMTP id n22so2847936uaj.13
        for <linux-mmc@vger.kernel.org>; Wed, 01 Nov 2017 18:43:21 -0700 (PDT)
In-Reply-To: <201711020209.Ik9aC6Yo%fengguang.wu@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: kbuild-all@01.org, linux-mmc@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>, kbuild test robot <fengguang.wu@intel.com>, Jaehoon Chung <jh80.chung@samsung.com>

Hi,

On Wed, Nov 1, 2017 at 11:19 AM, kbuild test robot
<fengguang.wu@intel.com> wrote:
> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git next
> head:   80a2a5a7745b1f65198fb11da9a8d1d38c3003d5
> commit: 80a2a5a7745b1f65198fb11da9a8d1d38c3003d5 [84/84] mmc: dw_mmc: Cleanup the DTO timer like the CTO one
> reproduce:
>         # apt-get install sparse
>         git checkout 80a2a5a7745b1f65198fb11da9a8d1d38c3003d5
>         make ARCH=x86_64 allmodconfig
>         make C=1 CF=-D__CHECK_ENDIAN__
>
>
> sparse warnings: (new ones prefixed by >>)
>
>
> vim +1953 drivers/mmc/host/dw_mmc.c
>
>   1935
>   1936  static void dw_mci_set_drto(struct dw_mci *host)
>   1937  {
>   1938          unsigned int drto_clks;
>   1939          unsigned int drto_div;
>   1940          unsigned int drto_ms;
>   1941          unsigned int irqflags;

Ulf: this looks like it came from your manual fixup of my patches.
The above should be an "unsigned long", AKA:

  unsigned long irqflags;

Thanks!

-Doug
