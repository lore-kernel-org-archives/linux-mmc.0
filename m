From: Otavio Salvador <otavio@ossystems.com.br>
Subject: Re: [PATCH v2] mmc: core: Do not set mmc voltage to 1.8V when
 'no-1-8-v' is present
Date: Mon, 15 Jun 2015 08:44:35 -0300
Message-ID: <CAP9ODKp5c9fq+og8pcYAK0LvZKQVj62e+-xa2seVM+dWTky+SA@mail.gmail.com>
References: <1434227067-9600-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:33379 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753861AbbFOLog (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 15 Jun 2015 07:44:36 -0400
Received: by pdjn11 with SMTP id n11so71396837pdj.0
        for <linux-mmc@vger.kernel.org>; Mon, 15 Jun 2015 04:44:35 -0700 (PDT)
In-Reply-To: <1434227067-9600-1-git-send-email-festevam@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: ulf.hansson@linaro.org, aisheng.dong@freescale.com, Kevin Lemoi <kevin.lemoi@savant.com>, kernel@pengutronix.de, Russell King <linux@arm.linux.org.uk>, chuanxiao.dong@intel.com, linux-mmc@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

On Sat, Jun 13, 2015 at 5:24 PM, Fabio Estevam <festevam@gmail.com> wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>
> Since commit 312449efd16bb06 ("mmc: core: Fix sequence for I/O voltage
> in DDR mode for eMMC") the mmc voltage is set to 1.8V inside
> mmc_select_hs_ddr(), even if 'no-1-8-v' property is present.
>
> This causes the following error on a mx6sl board with the 'no-1-8-v'
> property passed in the device tree:
>
> mmc0: power class selection to bus width 8 ddr 4 failed
> mmc0: error -110 whilst initialising MMC card
>
> Fix this problem by only setting the mmc voltage to 1.8V if the
> 'no-1-8-v' property is absent.
>
> Reported-by: Kevin Lemoi <kevin.lemoi@savant.com>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Acked-by: Otavio Salvador <otavio@ossystems.com.br>

-- 
Otavio Salvador                             O.S. Systems
http://www.ossystems.com.br        http://code.ossystems.com.br
Mobile: +55 (53) 9981-7854            Mobile: +1 (347) 903-9750
