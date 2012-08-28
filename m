From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: sdhci-esdhc: break out early if clock is 0
Date: Mon, 27 Aug 2012 20:41:17 -0400
Message-ID: <876283yhjm.fsf@octavius.laptop.org>
References: <1345648201-10746-1-git-send-email-shawn.guo@linaro.org>
	<87txvox7ba.fsf@octavius.laptop.org>
	<CAAQ0ZWSpxAn+F45C_tuW1Co1370-DVb=dXSzDt9GBy9Mq_vLqg@mail.gmail.com>
	<87ehmrykv8.fsf@octavius.laptop.org>
	<CAAQ0ZWS34QtkOGgidi=PyKX3=xHxRYdU+AQgV4kK9pJyeSCtHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:53841 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755123Ab2H1AlW (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 27 Aug 2012 20:41:22 -0400
In-Reply-To: <CAAQ0ZWS34QtkOGgidi=PyKX3=xHxRYdU+AQgV4kK9pJyeSCtHQ@mail.gmail.com>
	(Shawn Guo's message of "Tue, 28 Aug 2012 08:00:51 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-mmc@vger.kernel.org

Hi Shawn,

On Mon, Aug 27 2012, Shawn Guo wrote:
>>> On 28 August 2012 07:07, Chris Ball <cjb@laptop.org> wrote:
>>>> Thanks, pushed to mmc-next for 3.6.  (stable@ shouldn't be CC'd.)
>>>>
>>> I categorised it as a fix for a regression.
>>
> It means not only for stable but also for -rc series rather than -next.

Sure; I've already applied it to mmc-next for 3.6.

> Doing this strictly means people have to keep tracking if the fix hits
> mainline and remember to resubmit it to stable afterwards.  Should
> subsystem maintainer or author be that people?  It's not easy anyway.

No, the stable team look for patches entering mainline with "Cc:
stable@vger.kernel.org" in the commit message, and apply them to
stable@ at that point.  That's the right time to apply them.

So, as I understand it, you did the right thing in having "Cc:
<stable@vger.kernel.org>" inside your commit message, and the
wrong thing in sending the mail to stable@ at the same time.
That's why I removed it from CC.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
