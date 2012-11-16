From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH] mmc,sdio: Fix the panic due to devname NULL when calling pm_runtime_set_active()
Date: Fri, 16 Nov 2012 21:33:18 +0200
Message-ID: <CAK=WgbYiKFpSeyKZU3OWvbq4VDKRMFQvxwPbyxsBbEYJGQU1sA@mail.gmail.com>
References: <1353070447.15558.1681.camel@cliu38-desktop-build>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:49737 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752562Ab2KPTdi (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 16 Nov 2012 14:33:38 -0500
Received: by mail-ie0-f174.google.com with SMTP id k13so4138818iea.19
        for <linux-mmc@vger.kernel.org>; Fri, 16 Nov 2012 11:33:38 -0800 (PST)
In-Reply-To: <1353070447.15558.1681.camel@cliu38-desktop-build>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chuansheng Liu <chuansheng.liu@intel.com>
Cc: Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Liu,

On Fri, Nov 16, 2012 at 2:54 PM, Chuansheng Liu
<chuansheng.liu@intel.com> wrote:
> So when calling pm_runtime_set_active(), it will hit the strlen(devname==0)
> which trigger the panic.

Can you please point to the exact line of code that triggers this panic ?

> Here before calling pm_runtime_set_active(), set the dev name, although
> it is duplicated with mmc_add_card(), but it do not break the original
> design(commit 81968561b).

Normally we'd like to avoid such a solution, so let's first make sure
we understand the problem.

Have you tried thinking how come this shows up only now - has any of
the relevant code been changed lately ? Are you using a vanilla Linux
tree ?

Thanks,
Ohad.
