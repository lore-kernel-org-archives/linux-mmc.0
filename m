From: Will Newton <will.newton@gmail.com>
Subject: Re: [PATCH] dw_mmc: fix suspend/resume operation
Date: Thu, 17 Mar 2011 15:33:47 +0000
Message-ID: <AANLkTikprgnox-4JfTXOSqz6jYBg=u+X_H6GAH4QkXg=@mail.gmail.com>
References: <4D81F151.3090300@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:44682 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754501Ab1CQPdr (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Mar 2011 11:33:47 -0400
Received: by yxs7 with SMTP id 7so1161382yxs.19
        for <linux-mmc@vger.kernel.org>; Thu, 17 Mar 2011 08:33:47 -0700 (PDT)
In-Reply-To: <4D81F151.3090300@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, will.newton@imgtec.com, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>

On Thu, Mar 17, 2011 at 11:32 AM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> This patch is applied about re-init processing when suspend/resume.
>
> When card is resuming, some register is reset.
> If card is removable, maybe controller should be rescan for card.
> But if assume card is non-removable, need to restore the old value at registers.
>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

Looks ok to me.

Acked-by: Will Newton <will.newton@imgtec.com>
