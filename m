From: Doug Anderson <dianders@google.com>
Subject: Re: [PATCH] mmc: dw_mmc: Don't disable vmmc if keeping power in suspend
Date: Mon, 12 Aug 2013 10:31:32 -0700
Message-ID: <CAD=FV=U69UONapHhy+LQ0cNe+G5SWmowvVnAWxcEP+CN_HOXkg@mail.gmail.com>
References: <1375846138-15839-1-git-send-email-dbasehore@chromium.org>
	<000001ce9747$680a9800$381fc800$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f178.google.com ([209.85.216.178]:60324 "EHLO
	mail-qc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750883Ab3HLRbd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 12 Aug 2013 13:31:33 -0400
Received: by mail-qc0-f178.google.com with SMTP id s1so3519308qcw.37
        for <linux-mmc@vger.kernel.org>; Mon, 12 Aug 2013 10:31:32 -0700 (PDT)
In-Reply-To: <000001ce9747$680a9800$381fc800$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: Derek Basehore <dbasehore@chromium.org>, Chris Ball <cjb@laptop.org>, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org

Seungwon and Derek,

On Mon, Aug 12, 2013 at 3:33 AM, Seungwon Jeon <tgih.jun@samsung.com> wrote:
> On Wed, August 07, 2013, Derek Basehore
>> If we keep power for suspend on a host for dw_mmc, don't disable vmmc-supply
>> regulator when suspending the host.
>
> I have a trivial comment.
> It would be better to add some macro for checking MMC_PM_KEEP_POWER.
> And I just wonder how the problem is silent. Origin code has stood up somewhat long.
> Did you see?
>
> Acked-by: Seungwon Jeon <tgih.jun@samsung.com>
>
> Thanks,
> Seungwon Jeon
>
>>
>> Signed-off-by: Derek Basehore <dbasehore@chromium.org>
>> Reviewed-by: Doug Anderson <dianders@chromium.org>
>> ---
>>  drivers/mmc/host/dw_mmc.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)

Though I reviewed this originally, I'd actually propose not landing it.

I've spent more time with the regulator code in dw_mmc and currently
believe that the regulators should be enabled / disabled in
MMC_POWER_UP / MMC_POWER_OFF.  When we do that then the mmc core will
handle MMC_PM_KEEP_POWER.  You can see my current thoughts on this in
<https://gerrit.chromium.org/gerrit/#/c/65263/>.  I will try to post
that upstream before too long, but feel free to let me know any
comments.

-Doug
