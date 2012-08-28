From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-esdhc: break out early if clock is 0
Date: Tue, 28 Aug 2012 08:00:51 +0800
Message-ID: <CAAQ0ZWS34QtkOGgidi=PyKX3=xHxRYdU+AQgV4kK9pJyeSCtHQ@mail.gmail.com>
References: <1345648201-10746-1-git-send-email-shawn.guo@linaro.org>
	<87txvox7ba.fsf@octavius.laptop.org>
	<CAAQ0ZWSpxAn+F45C_tuW1Co1370-DVb=dXSzDt9GBy9Mq_vLqg@mail.gmail.com>
	<87ehmrykv8.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:62793 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754963Ab2H1AAw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Aug 2012 20:00:52 -0400
Received: by obbuo13 with SMTP id uo13so9416244obb.19
        for <linux-mmc@vger.kernel.org>; Mon, 27 Aug 2012 17:00:51 -0700 (PDT)
In-Reply-To: <87ehmrykv8.fsf@octavius.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-mmc@vger.kernel.org

On 28 August 2012 07:29, Chris Ball <cjb@laptop.org> wrote:
> Hi,
>
> On Mon, Aug 27 2012, Shawn Guo wrote:
>> On 28 August 2012 07:07, Chris Ball <cjb@laptop.org> wrote:
>>> Thanks, pushed to mmc-next for 3.6.  (stable@ shouldn't be CC'd.)
>>>
>> I categorised it as a fix for a regression.
>
It means not only for stable but also for -rc series rather than -next.

> It is a fix for a regression, but the rules for submitting patches to
> stable@ are significantly more strict than "is it a regression?".
> From Documentation/stable-kernel-rules.txt:
>
> ==
> Rules on what kind of patches are accepted, and which ones are not, into the
> "-stable" tree:
>
>  ...
>  - It or an equivalent fix must already exist in Linus' tree (upstream).
>
> Procedure for submitting patches to the -stable tree:
>
>  - Send the patch, after verifying that it follows the above rules, to
>    stable@vger.kernel.org.  You must note the upstream commit ID in the
>    changelog of your submission, as well as the kernel version you wish
>    it to be applied to.
> ==
>
> It doesn't already exist in mainline -- so it shouldn't have been
> e-mailed to stable@ -- and even if it were already in mainline, you
> shouldn't e-mail stable@ without including the upstream commit ID
> and kernel version to apply it to.  (Unless I'm missing something?)
>
Ok, thanks for pointing it out.  But in practice, the process seems
not so strict.  I have a lot of successful cases with Greg (Cc-ed) by
simply Cc-ing stable when submit a fix that should be applied on
stable kernel.

Doing this strictly means people have to keep tracking if the fix hits
mainline and remember to resubmit it to stable afterwards.  Should
subsystem maintainer or author be that people?  It's not easy anyway.

Regards,
Shawn
