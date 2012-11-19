From: Kevin Liu <keyuan.liu@gmail.com>
Subject: Re: [PATCH v6 12/14] mmc: sdhci-pxav3: remove set_uhs_signaling function
Date: Mon, 19 Nov 2012 19:23:34 +0800
Message-ID: <CADz5_g+VWWqS6gsmqoD8qhmWxkLBvgt5PjytkCh866Xc58LW3A@mail.gmail.com>
References: <1350471893-29633-1-git-send-email-keyuan.liu@gmail.com>
	<1350471893-29633-13-git-send-email-keyuan.liu@gmail.com>
	<87vcd37t2u.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:64274 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751265Ab2KSLXg (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 19 Nov 2012 06:23:36 -0500
Received: by mail-wg0-f44.google.com with SMTP id dr13so2772115wgb.1
        for <linux-mmc@vger.kernel.org>; Mon, 19 Nov 2012 03:23:34 -0800 (PST)
In-Reply-To: <87vcd37t2u.fsf@octavius.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, pierre@ossman.eu, ulf.hansson@linaro.org, Haojian Zhuang <haojian.zhuang@gmail.com>, cxie4@marvell.com, Philip Rakity <prakity@nvidia.com>, kliu5@marvell.com

2012/11/18 Chris Ball <cjb@laptop.org>:
> Hi,
>
> On Wed, Oct 17 2012, Kevin Liu wrote:
>> From: Kevin Liu <kliu5@marvell.com>
>>
>> Because sdhci can do the same thing so no need to implement this.
>>
>> Acked-by:  Zhangfei Gao <zhangfei.gao@marvell.com>
>> Signed-off-by: Kevin Liu <kliu5@marvell.com>
>
> In that case, we can remove the callbacks from sdhci.c/sdhci.h too --
> sdhci-pxav3 was the only user.
>
updated the patch in v8. thanks!

Kevin
