From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] mmc: core: Fix build warning with !CONFIG_SUSPEND
Date: Sat, 26 May 2012 22:52:40 +0530
Message-ID: <CAMQu2gwkcVXAp1iThQRn3Ff-AH33aM9CayJO6TQ109kdX=a0_w@mail.gmail.com>
References: <1337414319-27719-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog127.obsmtp.com ([74.125.149.107]:42473 "EHLO
	na3sys009aog127.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752967Ab2EZRXD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 26 May 2012 13:23:03 -0400
Received: by qcsu28 with SMTP id u28so1204787qcs.36
        for <linux-mmc@vger.kernel.org>; Sat, 26 May 2012 10:23:01 -0700 (PDT)
In-Reply-To: <1337414319-27719-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-kernel@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-mmc@vger.kernel.org

Chris,

On Sat, May 19, 2012 at 1:28 PM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
> With !CONFIG_SUSPEND, mmc core layer throws below build warnings.
>
> drivers/mmc/core/bus.c:125: warning: 'mmc_bus_suspend' defined but not used
> drivers/mmc/core/bus.c:136: warning: 'mmc_bus_resume' defined but not used
> drivers/mmc/core/sdio_bus.c:197: warning: 'pm_no_operation' defined but not used
>
> Fix is by wrapping suspend hooks under CONFIG_SUSPEND
>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Chris Ball <cjb@laptop.org>
> ---
Ping
