From: Will Newton <will.newton@gmail.com>
Subject: Re: mmc: dw_mmc: remove the compiling warning
Date: Fri, 28 Sep 2012 11:42:57 +0100
Message-ID: <CAFbHwiQ0qhA_-oqG_q-fQuem2gODL-51Wed-ERfHjj70yCpaFw@mail.gmail.com>
References: <00ff01cd9d61$dd516520$97f42f60$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:48682 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757109Ab2I1Km7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 28 Sep 2012 06:42:59 -0400
Received: by bkcjk13 with SMTP id jk13so3154746bkc.19
        for <linux-mmc@vger.kernel.org>; Fri, 28 Sep 2012 03:42:58 -0700 (PDT)
In-Reply-To: <00ff01cd9d61$dd516520$97f42f60$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Will Newton <will.newton@imgtec.com>, James Hogan <james.hogan@imgtec.com>

On Fri, Sep 28, 2012 at 11:13 AM, Seungwon Jeon <tgih.jun@samsung.com> wrote:
> This patch removes the following warning.
> drivers/mmc/host/dw_mmc.c:1976: warning: passing argument 1 of
> '_dev_info' from incompatible pointer type
>
> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
> ---
>  drivers/mmc/host/dw_mmc.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Acked-by: Will Newton <will.newton@imgtec.com>
