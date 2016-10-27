From: Georgi Djakov <georgi.djakov@linaro.org>
Subject: Re: [PATCH -next] mmc: sdhci-msm: Fix error return code in
 sdhci_msm_probe()
Date: Thu, 27 Oct 2016 10:20:14 +0300
Message-ID: <4b5d5b34-b082-34b0-87f3-3391f151f1cc@linaro.org>
References: <1477494281-24246-1-git-send-email-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:35865 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750748AbcJ0HUT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 27 Oct 2016 03:20:19 -0400
Received: by mail-wm0-f52.google.com with SMTP id b80so14639890wme.1
        for <linux-mmc@vger.kernel.org>; Thu, 27 Oct 2016 00:20:19 -0700 (PDT)
In-Reply-To: <1477494281-24246-1-git-send-email-weiyj.lk@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Wei Yongjun <weiyongjun1@huawei.com>, linux-mmc@vger.kernel.org

On 10/26/2016 06:04 PM, Wei Yongjun wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
>
> Fix to return a negative error code from the platform_get_irq_byname()
> error handling case instead of 0, as done elsewhere in this function.
>
> Fixes: ad81d3871004 ("mmc: sdhci-msm: Add support for UHS cards")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Acked-by: Georgi Djakov <georgi.djakov@linaro.org>
