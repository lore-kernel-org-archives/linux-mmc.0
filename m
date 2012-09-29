From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH v5 07/13] mmc: sdhci-pxav3: controller can't get base clock
Date: Sat, 29 Sep 2012 15:44:41 +0800
Message-ID: <CAMj5Bki99AZuEsrj7LjcWguuf7s4gk7Wc_w2sXuD2ouDKeK1-Q@mail.gmail.com>
References: <1348818972-26711-1-git-send-email-keyuan.liu@gmail.com>
	<1348818972-26711-8-git-send-email-keyuan.liu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:63534 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759045Ab2I2Hon (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 29 Sep 2012 03:44:43 -0400
Received: by wibhr7 with SMTP id hr7so673015wib.1
        for <linux-mmc@vger.kernel.org>; Sat, 29 Sep 2012 00:44:42 -0700 (PDT)
In-Reply-To: <1348818972-26711-8-git-send-email-keyuan.liu@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kevin Liu <keyuan.liu@gmail.com>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, pierre@ossman.eu, ulf.hansson@linaro.org, zgao6@marvell.com, hzhuang1@marvell.com, cxie4@marvell.com, prakity@marvell.com, kliu5@marvell.com

On Fri, Sep 28, 2012 at 3:56 PM, Kevin Liu <keyuan.liu@gmail.com> wrote:
> From: Kevin Liu <kliu5@marvell.com>
>
> Enable the quirk SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN since
> SD_CAPABILITIES_1[15:8](BASE_FREQ) can't get correct base
> clock value. It return a fixed pre-set value like 200 on
> some sdhci-pxav3 based platforms like MMP3 while return 0
> on the other sdhci-pxav3 based platforms.
> So we enable the quirk and get the base clock via function
> get_max_clock.
> Also add get_max_clock.
>
> Reported-by: Philip Rakity <prakity@marvell.com>
> Reviewed-by: Philip Rakity <prakity@Marvell.com>
> Signed-off-by: Kevin Liu <kliu5@marvell.com>

Acked-by:  Zhangfei Gao <zhangfei.gao@marvell.com>
