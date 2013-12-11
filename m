From: Zhangfei Gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH 2/2] mmc: dw_mmc: add dw_mmc-k3 for k3 platform
Date: Wed, 11 Dec 2013 13:47:16 +0800
Message-ID: <CAMj5Bkgwzq5+aewF2vOJq3aDMk0yy8WVQOzdboCmMtrx1vi4nQ@mail.gmail.com>
References: <1383889128-12540-1-git-send-email-zhangfei.gao@linaro.org>
	<1383889128-12540-3-git-send-email-zhangfei.gao@linaro.org>
	<001f01cef1c2$6bd0ab70$43720250$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ea0-f176.google.com ([209.85.215.176]:47437 "EHLO
	mail-ea0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750719Ab3LKFrS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 11 Dec 2013 00:47:18 -0500
In-Reply-To: <001f01cef1c2$6bd0ab70$43720250$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: Zhangfei Gao <zhangfei.gao@linaro.org>, Chris Ball <cjb@laptop.org>, Jaehoon Chung <jh80.chung@samsung.com>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

Dear Seungwon

On Thu, Dec 5, 2013 at 10:00 PM, Seungwon Jeon <tgih.jun@samsung.com> wrote:

>> +static DEFINE_SPINLOCK(mmc_tuning_lock);
> Can the above variables be involved in dw_mci_k3_priv_data instead of global declaration?
>
Unfortunately, this can be be put in priv_data, which is different
instance for different controller.
Here need protect register shared by different controllers


>> +static int dw_mci_k3_setup_clock(struct dw_mci *host)
>> +{
>> +     dw_mci_k3_tun(host, MMC_TIMING_LEGACY);
> Is it necessary here?
> When card-init, MMC_TIMING_LEGACY will be passed via dw_mci_k3_set_ios().

Read register will fail if not set these register earlier, and set_ios
is too late.
Same reason for resume.

Thanks
