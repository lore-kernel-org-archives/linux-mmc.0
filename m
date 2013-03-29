From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/2] mmc: sdhci-spear: add CONFIG_PM_SLEEP to
 suspend/resume functions
Date: Fri, 29 Mar 2013 12:48:40 +0530
Message-ID: <CAOh2x=me7M+pMKQ4O+1BXubfjy4Gq1Pz4EG7-d9nwHoF-vgdzw@mail.gmail.com>
References: <003301ce2c4b$d2864fb0$7792ef10$%han@samsung.com>
	<003401ce2c4c$26048490$720d8db0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ve0-f171.google.com ([209.85.128.171]:36373 "EHLO
	mail-ve0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751247Ab3C2HSl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 29 Mar 2013 03:18:41 -0400
Received: by mail-ve0-f171.google.com with SMTP id b10so300361vea.16
        for <linux-mmc@vger.kernel.org>; Fri, 29 Mar 2013 00:18:41 -0700 (PDT)
In-Reply-To: <003401ce2c4c$26048490$720d8db0$%han@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jingoo Han <jg1.han@samsung.com>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org

On Fri, Mar 29, 2013 at 12:38 PM, Jingoo Han <jg1.han@samsung.com> wrote:
> Add CONFIG_PM_SLEEP to suspend/resume functions to fix the following
> build warning when CONFIG_PM_SLEEP is not selected. This is because
> sleep PM callbacks defined by SIMPLE_DEV_PM_OPS are only used when
> the CONFIG_PM_SLEEP is enabled.
>
> drivers/mmc/host/sdhci-spear.c:295:12: warning: 'sdhci_suspend' defined but not used [-Wunused-function]
> drivers/mmc/host/sdhci-spear.c:308:12: warning: 'sdhci_resume' defined but not used [-Wunused-function]
>
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
>  drivers/mmc/host/sdhci-spear.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
