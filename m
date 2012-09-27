From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH v4 06/15] mmc: sdhci-pxav3: controller can't get base clock
Date: Thu, 27 Sep 2012 15:08:52 +0800
Message-ID: <CAMj5BkhJuoBNtFDgAm-=TwxZFeZ-xakNaQx_s5B+7ARUUkPnnw@mail.gmail.com>
References: <1348659527-4200-1-git-send-email-keyuan.liu@gmail.com>
	<1348659527-4200-7-git-send-email-keyuan.liu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:63108 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751511Ab2I0HIx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 27 Sep 2012 03:08:53 -0400
Received: by bkcjk13 with SMTP id jk13so1225189bkc.19
        for <linux-mmc@vger.kernel.org>; Thu, 27 Sep 2012 00:08:52 -0700 (PDT)
In-Reply-To: <1348659527-4200-7-git-send-email-keyuan.liu@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kevin Liu <keyuan.liu@gmail.com>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, pierre@ossman.eu, ulf.hansson@linaro.org, zgao6@marvell.com, hzhuang1@marvell.com, cxie4@marvell.com, prakity@marvell.com, kliu5@marvell.com

On Wed, Sep 26, 2012 at 7:38 PM, Kevin Liu <keyuan.liu@gmail.com> wrote:
> From: Kevin Liu <kliu5@marvell.com>
>
> Enable the quirk SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN since
> SD_CAPABILITIES_1[15:8](BASE_FREQ) can't get correct base
> clock value. It return a fixed pre-set value like 200 on
> some sdhci-pxav3 based platforms like MMP3 while return 0
> on the other sdhci-pxav3 based platforms.
> So we enable the quirk and get the base clock via function
> get_max_clock.

Could you provide get_max_clock as well.
