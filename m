From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [RFC]Do we still need CONFIG_MMC_DEBUG
Date: Tue, 27 Jun 2017 17:32:22 +0800
Message-ID: <ca8f1189-9c85-5cb0-b7e9-24b6154b27f6@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.130]:49154 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751672AbdF0Jcg (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 27 Jun 2017 05:32:36 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: shawn.lin@rock-chips.com, Adrian Hunter <adrian.hunter@intel.com>, Jaehoon Chung <jh80.chung@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>

Hi,

    CONFIG_MMC_DEBUG enables mmc core and driver debugging, and most
people should N. I didn't find any point to keep this for core.c as
it's just for some WARN or BUG detect. And the debug log around it could
be replaced with pr_debug which is easily controlled by system log
level, otherwise we should re-compile the kernel and flash zImage agian
just for debug.

And for some host drivers, it was used to dump registers as well.
For the error cases, I think they could directly output the regs, just
like what sdhci did. Right?

For other cases, for instace, sdhci_add_host uses this macro to dump
registers when adding host. I think we just have changed sdhci_dumpregs
to use pr_debug and check the log depending on the dynamic log level, so
there is no need to still keep it under the context of CONFIG_MMC_DEBUG?

I just really don't like compile-time debug option and I didn't ever try
to enable it frankly. Is it possible for us to get rid of it? :)

