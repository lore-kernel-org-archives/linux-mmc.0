From: Doug Anderson <dianders@google.com>
Subject: Re: [PATCH] mmc: core: Update the ext-csd.rev check for eMMC5.1
Date: Wed, 22 May 2013 17:06:08 -0700
Message-ID: <CAD=FV=UknLh3ud6aQ8mzK8H0mXDR+uVqeeyWF6zgyZTnBuq2bA@mail.gmail.com>
References: <1369129124-31128-1-git-send-email-yuvaraj.cd@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f180.google.com ([209.85.217.180]:40796 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754052Ab3EWAGK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 22 May 2013 20:06:10 -0400
Received: by mail-lb0-f180.google.com with SMTP id r10so2720201lbi.39
        for <linux-mmc@vger.kernel.org>; Wed, 22 May 2013 17:06:09 -0700 (PDT)
In-Reply-To: <1369129124-31128-1-git-send-email-yuvaraj.cd@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yuvaraj Kumar C D <yuvaraj.cd@gmail.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>, Alim Akhtar <alim.akthar@samsung.com>

Yavaraj,

On Tue, May 21, 2013 at 2:38 AM, Yuvaraj Kumar C D <yuvaraj.cd@gmail.com> wrote:
> With the new eMMC5.1 spec,there is a new EXT_CSD register with
> the revision number(EXT_CSD_REV) 7.This patch updates the check
> for ext-csd.rev number as 7.
>
> Signed-off-by: Alim Akhtar <alim.akthar@samsung.com>
> Signed-off-by: Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
> ---
>  drivers/mmc/core/mmc.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Looks reasonable.

Reviewed-by: Doug Anderson <dianders@chromium.org>
