From: Will Newton <will.newton@gmail.com>
Subject: Re: [PATCH] dw_mmc: support send_auto_stop
Date: Wed, 30 Mar 2011 13:37:28 +0100
Message-ID: <AANLkTikzkX7vYu0h7T6-C5PvykOZAzYGnTmPydizkTU6@mail.gmail.com>
References: <4D92C5D2.2000004@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:40407 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751681Ab1C3Mh3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Mar 2011 08:37:29 -0400
Received: by gxk21 with SMTP id 21so485764gxk.19
        for <linux-mmc@vger.kernel.org>; Wed, 30 Mar 2011 05:37:28 -0700 (PDT)
In-Reply-To: <4D92C5D2.2000004@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>

On Wed, Mar 30, 2011 at 6:55 AM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> This patch is set the send_auto_stop bit in CMD register.
> If use DW_MCI_QUIRK_SEND_AUTO_STOP, helps to send an exact
> number of data bytes.
>
>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

This is something I have been meaning to look into, does it improve
latency or throughput in your experiments?

Is there a reason you have implemented it as a quirk? I would have
thought if it was a win (in performance or code size) it would be
applicable to all instances of this block?

If we implemented it as an unconditional feature then we could
probably remove some of the explicit stop handling code.
