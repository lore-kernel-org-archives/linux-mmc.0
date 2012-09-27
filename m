From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH v4 04/15] mmc: sdhci: keep the saved clock var up to date
Date: Thu, 27 Sep 2012 14:46:12 +0800
Message-ID: <CAMj5Bkjyo2UK=hmUvNAgUxdhBiN55du_ETWuABY7LKMoo8F30g@mail.gmail.com>
References: <1348659527-4200-1-git-send-email-keyuan.liu@gmail.com>
	<1348659527-4200-5-git-send-email-keyuan.liu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:50845 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754544Ab2I0GqO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 27 Sep 2012 02:46:14 -0400
Received: by lagh6 with SMTP id h6so300854lag.19
        for <linux-mmc@vger.kernel.org>; Wed, 26 Sep 2012 23:46:13 -0700 (PDT)
In-Reply-To: <1348659527-4200-5-git-send-email-keyuan.liu@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kevin Liu <keyuan.liu@gmail.com>, Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, pierre@ossman.eu, ulf.hansson@linaro.org, zgao6@marvell.com, hzhuang1@marvell.com, cxie4@marvell.com, prakity@marvell.com, kliu5@marvell.com, Bin Wang <binw@marvell.com>

On Wed, Sep 26, 2012 at 7:38 PM, Kevin Liu <keyuan.liu@gmail.com> wrote:
> From: Kevin Liu <kliu5@marvell.com>
>
> The clock rate set to the sdh controller may not exactly as requested
> by the mmc core, this patch make the clock rate saved in the mmc_ios
> and sdhci_host updated with the actual setting as in the controller. Thus
> "/sys/kernel/debug/mmcx/ios" and card detect prints can show the correct
> clock rate.

The patch may not required if only updating debugfs, since
actual_clock already been considered in debugfs.
However, does incorrect ios->clock cause unexpected result, such as powerclass.
If so, how about directly correct ios->clock, and remove actual_clock at all?

/Zhangfei
