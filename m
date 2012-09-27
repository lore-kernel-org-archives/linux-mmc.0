From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH v4 01/15] mmc: sdhci: fix transfer mode setting bug for
 cmds w/o data transfer
Date: Thu, 27 Sep 2012 13:13:37 +0800
Message-ID: <CAMj5BkjN3gk02GTkt-AhZHR0MAh0uNhjLsm0mCS_Ms=mvcYrqg@mail.gmail.com>
References: <1348659527-4200-1-git-send-email-keyuan.liu@gmail.com>
	<1348659527-4200-2-git-send-email-keyuan.liu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:45409 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751475Ab2I0FNj (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 27 Sep 2012 01:13:39 -0400
Received: by wibhq12 with SMTP id hq12so5720550wib.1
        for <linux-mmc@vger.kernel.org>; Wed, 26 Sep 2012 22:13:37 -0700 (PDT)
In-Reply-To: <1348659527-4200-2-git-send-email-keyuan.liu@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kevin Liu <keyuan.liu@gmail.com>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, pierre@ossman.eu, ulf.hansson@linaro.org, zgao6@marvell.com, hzhuang1@marvell.com, cxie4@marvell.com, prakity@marvell.com, kliu5@marvell.com, Jialing Fu <jlfu@marvell.com>, Tim Wang <wangtt@marvell.com>

On Wed, Sep 26, 2012 at 7:38 PM, Kevin Liu <keyuan.liu@gmail.com> wrote:
> From: Kevin Liu <kliu5@marvell.com>
>
> Commands without data transfer like cmd5/cmd7 will use previous
> transfer mode setting, which may lead to error since some bits
> may have been set unexpectedly.
> For example, cmd5 following cmd18/cmd25 will have timeout error
> since audo cmd23 has been enabled.
>
> Signed-off-by: Jialing Fu <jlfu@marvell.com>
> Signed-off-by: Tim Wang <wangtt@marvell.com>
> Signed-off-by: Kevin Liu <kliu5@marvell.com>
> ---

Reviewed-by: Zhangfei Gao <zhangfei.gao@marvell.com>
