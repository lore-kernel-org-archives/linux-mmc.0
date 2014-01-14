From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH 1/3] mmc: dw_mmc: use slot-gpio to handle cd pin
Date: Tue, 14 Jan 2014 07:58:13 -0800
Message-ID: <CAGa+x85awFYsrU9Gggirpaip3vggtSqu5GinVzss=nfNcp4nww@mail.gmail.com>
References: <1389278112-7099-1-git-send-email-zhangfei.gao@linaro.org>
	<1389278112-7099-2-git-send-email-zhangfei.gao@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f54.google.com ([209.85.216.54]:60588 "EHLO
	mail-qa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751413AbaANP6O (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Jan 2014 10:58:14 -0500
Received: by mail-qa0-f54.google.com with SMTP id i13so2888782qae.41
        for <linux-mmc@vger.kernel.org>; Tue, 14 Jan 2014 07:58:13 -0800 (PST)
In-Reply-To: <1389278112-7099-2-git-send-email-zhangfei.gao@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zhangfei Gao <zhangfei.gao@linaro.org>
Cc: Chris Ball <cjb@laptop.org>, Arnd Bergmann <arnd@arndb.de>, Mike Turquette <mturquette@linaro.org>, Rob Herring <robherring2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, Kumar Gala <galak@codeaurora.org>, Haojian Zhuang <haojian.zhuang@linaro.org>, linux-mmc@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Patch Tracking <patches@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Olof Johansson <olof@lixom.net>, Tomasz Figa <tomasz.figa@gmail.com>

On Thu, Jan 9, 2014 at 6:35 AM, Zhangfei Gao <zhangfei.gao@linaro.org> wrote:
> Suggested by Jaehoon: Use slot-gpio to handle cd-gpio
> Add function dw_mci_of_get_cd_gpio to check "cd-gpios" from dts.
> mmc_gpio_request_cd and mmc_gpio_get_cd are used to handle cd pin
>
> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Acked-by: Jaehoon Chung <jh80.chung@samsung.com>

The Samsung Arndale board started failing boot from MMC root tests
starting with next-20140113 and I bisected it down to this patch.
Reverting this patch on top of next-20140114 gets Arndale booting
again from MMC.  Is there some supporting DT data that's missing for
Arndale?

Kevin
