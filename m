From: Chris Ball <chris@printf.net>
Subject: Re: [PATCH v2 0/3] mmc: rtsx: fix bug and support nonblocking request
Date: Sat, 22 Feb 2014 18:34:57 +0000
Message-ID: <86y513uhbi.fsf@void.printf.net>
References: <cover.1392626511.git.micky_ching@realsil.com.cn>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:39837 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751470AbaBVSfE (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 22 Feb 2014 13:35:04 -0500
In-Reply-To: <cover.1392626511.git.micky_ching@realsil.com.cn> (micky ching's
	message of "Mon, 17 Feb 2014 16:45:45 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: micky_ching@realsil.com.cn
Cc: sameo@linux.intel.com, lee.jones@linaro.org, gregkh@linuxfoundation.org, dan.carpenter@oracle.com, ulf.hansson@linaro.org, devel@linuxdriverproject.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, rogerable@realtek.com, wei_wang@realsil.com.cn

Hi Micky,

On Mon, Feb 17 2014, micky_ching@realsil.com.cn wrote:
> From: Micky Ching <micky_ching@realsil.com.cn>
>
> First we fix the card poweroff bug: the card power is not shutdown when sd/mmc
> card removed, this will make UHS-card failed to running in high speed mode if we
> insert the card again.
>
> We offer a concise tuning searching method, it is much easier to read.
>
> At last we add support for nonblocking request, which will improve card read
> speed at about 10% write speed about 5% normally.

Thanks, all 3 patches pushed to mmc-next for 3.15.

- Chris.
-- 
Chris Ball   <chris@printf.net>   <http://printf.net/>
