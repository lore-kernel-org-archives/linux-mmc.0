From: Will Newton <will.newton@gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc: Fix null dma_ops access when use_dma is false
Date: Fri, 15 Jun 2012 14:14:48 +0100
Message-ID: <CAFbHwiRo9J+ZkaK7YUcVvtxN5TkmvxUy-q-EDgngve-t+oJ0CQ@mail.gmail.com>
References: <1339695115-606-1-git-send-email-kliegs@chromium.org>
	<4FDAE34C.1030102@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:45146 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752539Ab2FONOt (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 15 Jun 2012 09:14:49 -0400
Received: by pbbrp8 with SMTP id rp8so5270239pbb.19
        for <linux-mmc@vger.kernel.org>; Fri, 15 Jun 2012 06:14:49 -0700 (PDT)
In-Reply-To: <4FDAE34C.1030102@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Jonathan Kliegman <kliegs@chromium.org>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Will Newton <will.newton@imgtec.com>, James Hogan <james.hogan@imgtec.com>

On Fri, Jun 15, 2012 at 8:25 AM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> It looks good to me.
>
> Acked-by: Jaehoon Chung <jh80.chung@samsung.com>
>
> On 06/15/2012 02:31 AM, Jonathan Kliegman wrote:
>
>> host->dma_ops is not valid if host->usa dma is 0 so protect
>> host->dma_ops reference in dw_mci_resume
>>
>> Signed-off-by: Jonathan Kliegman <kliegs@chromium.org>

Yes, looks good to me too.

Acked-by: Will Newton <will.newton@imgtec.com>
