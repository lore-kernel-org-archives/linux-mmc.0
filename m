From: Will Newton <will.newton@gmail.com>
Subject: Re: [PATCH 4/5] mmc: dw-mmc: add the header file for exynos specific code.
Date: Fri, 24 Aug 2012 10:29:54 +0100
Message-ID: <CAFbHwiRjhRmX3C-KgkC59F7c7EK4ivf4U2oCFfRtV5=EpLtSXw@mail.gmail.com>
References: <503614A7.3050004@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:53388 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758563Ab2HXJ3z (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 24 Aug 2012 05:29:55 -0400
Received: by qaas11 with SMTP id s11so375818qaa.19
        for <linux-mmc@vger.kernel.org>; Fri, 24 Aug 2012 02:29:54 -0700 (PDT)
In-Reply-To: <503614A7.3050004@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, Will Newton <will.newton@imgtec.com>, James Hogan <james.hogan@imgtec.com>

On Thu, Aug 23, 2012 at 12:31 PM, Jaehoon Chung <jh80.chung@samsung.com> wrote:

Hi Jaehoon,

> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  include/linux/mmc/exynos-dw_mmc.h |   55 +++++++++++++++++++++++++++++++++++++
>  1 files changed, 55 insertions(+), 0 deletions(-)
>  create mode 100644 include/linux/mmc/exynos-dw_mmc.h

What is the purpose of adding this header file if it is not included
anywhere? Is there a patch missing from the series?
