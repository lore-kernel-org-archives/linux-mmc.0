From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH v2 2/2] mmc: use new core function mmc_get_dma_dir
Date: Sun, 26 Mar 2017 20:37:42 +0200
Message-ID: <64902537-a4dc-42dd-3be8-aa0f4acd3de7@gmail.com>
References: <201703262329.HGjB85Id%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36410 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751465AbdCZTJf (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 26 Mar 2017 15:09:35 -0400
Received: by mail-wr0-f194.google.com with SMTP id u1so6988960wra.3
        for <linux-mmc@vger.kernel.org>; Sun, 26 Mar 2017 12:09:34 -0700 (PDT)
In-Reply-To: <201703262329.HGjB85Id%fengguang.wu@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>

Am 26.03.2017 um 17:37 schrieb kbuild test robot:
> Hi Heiner,
> 
> [auto build test ERROR on linus/master]
> [also build test ERROR on v4.11-rc3 next-20170324]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Heiner-Kallweit/mmc-factor-out-getting-dma-direction-from-host-drivers/20170326-215045
> config: arm-at91_dt_defconfig (attached as .config)
> compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
> reproduce:
>         wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=arm 
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/mmc/host/atmel-mci.c: In function 'atmci_prepare_data_pdc':
>>> drivers/mmc/host/atmel-mci.c:1134:6: error: 'dir' undeclared (first use in this function)
>        ((dir == DMA_FROM_DEVICE) ? XFER_RECEIVE : XFER_TRANSMIT));
>          ^~~
I removed dir and missed to change this statement. I will send a fixed version of the patch set.


>    drivers/mmc/host/atmel-mci.c:1134:6: note: each undeclared identifier is reported only once for each function it appears in
> 
> vim +/dir +1134 drivers/mmc/host/atmel-mci.c
> 
> 24011f34 Ludovic Desroches 2012-05-16  1128  			for (i = 0; i < host->data_size; i++)
> 24011f34 Ludovic Desroches 2012-05-16  1129  				host->buffer[i] = swab32(host->buffer[i]);
> 24011f34 Ludovic Desroches 2012-05-16  1130  	}
> 7a90dcc2 Ludovic Desroches 2012-05-16  1131  
> 796211b7 Ludovic Desroches 2011-08-11  1132  	if (host->data_size)
> 796211b7 Ludovic Desroches 2011-08-11  1133  		atmci_pdc_set_both_buf(host,
> 796211b7 Ludovic Desroches 2011-08-11 @1134  			((dir == DMA_FROM_DEVICE) ? XFER_RECEIVE : XFER_TRANSMIT));
> 796211b7 Ludovic Desroches 2011-08-11  1135  
> 796211b7 Ludovic Desroches 2011-08-11  1136  	return iflags;
> 796211b7 Ludovic Desroches 2011-08-11  1137  }
> 
> :::::: The code at line 1134 was first introduced by commit
> :::::: 796211b7953bd1036670359f31cd97f309322107 mmc: atmel-mci: add pdc support and runtime capabilities detection
> 
> :::::: TO: Ludovic Desroches <ludovic.desroches@atmel.com>
> :::::: CC: Chris Ball <cjb@laptop.org>
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 

