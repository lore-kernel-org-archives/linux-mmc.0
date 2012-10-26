From: Will Newton <will.newton@gmail.com>
Subject: Re: [PATCH] mmc: dw-mmc: relocate the position called dw_mci_setup_bus()
Date: Fri, 26 Oct 2012 14:03:39 +0100
Message-ID: <CAFbHwiQ4-FufvVFrRaCqeczxP8HkQPwWs+PdhNA7GXeXfqmZ6Q@mail.gmail.com>
References: <5089FC09.6090101@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:52515 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751058Ab2JZNDl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 26 Oct 2012 09:03:41 -0400
Received: by mail-lb0-f174.google.com with SMTP id n3so1668071lbo.19
        for <linux-mmc@vger.kernel.org>; Fri, 26 Oct 2012 06:03:39 -0700 (PDT)
In-Reply-To: <5089FC09.6090101@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, James Hogan <James.Hogan@imgtec.com>, Kyungmin Park <kyungmin.park@samsung.com>

On Fri, Oct 26, 2012 at 3:57 AM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> I think right that dw_mci_setup_bus() is called into set_ios().
> Actually clock is enabled at dw_mci_setup_bus() in now.
> Then didn't ensure to wait the 74clock.
> To stable clock is relocated the position into dw_mci_set_ios().
>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  drivers/mmc/host/dw_mmc.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)

This patch looks ok in principle, but I have trouble understanding the
commit message. Would it be possible to try and reword it a bit to
make it clearer?

Thanks,
