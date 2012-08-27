From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: sdhci-esdhc: break out early if clock is 0
Date: Mon, 27 Aug 2012 19:29:31 -0400
Message-ID: <87ehmrykv8.fsf@octavius.laptop.org>
References: <1345648201-10746-1-git-send-email-shawn.guo@linaro.org>
	<87txvox7ba.fsf@octavius.laptop.org>
	<CAAQ0ZWSpxAn+F45C_tuW1Co1370-DVb=dXSzDt9GBy9Mq_vLqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:46700 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754853Ab2H0X3f (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 27 Aug 2012 19:29:35 -0400
In-Reply-To: <CAAQ0ZWSpxAn+F45C_tuW1Co1370-DVb=dXSzDt9GBy9Mq_vLqg@mail.gmail.com>
	(Shawn Guo's message of "Tue, 28 Aug 2012 07:14:50 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: linux-mmc@vger.kernel.org

Hi,

On Mon, Aug 27 2012, Shawn Guo wrote:
> On 28 August 2012 07:07, Chris Ball <cjb@laptop.org> wrote:
>> Thanks, pushed to mmc-next for 3.6.  (stable@ shouldn't be CC'd.)
>>
> I categorised it as a fix for a regression.

It is a fix for a regression, but the rules for submitting patches to
stable@ are significantly more strict than "is it a regression?".
>From Documentation/stable-kernel-rules.txt:

==
Rules on what kind of patches are accepted, and which ones are not, into the
"-stable" tree:

 ...
 - It or an equivalent fix must already exist in Linus' tree (upstream).

Procedure for submitting patches to the -stable tree:

 - Send the patch, after verifying that it follows the above rules, to
   stable@vger.kernel.org.  You must note the upstream commit ID in the
   changelog of your submission, as well as the kernel version you wish
   it to be applied to.
==

It doesn't already exist in mainline -- so it shouldn't have been
e-mailed to stable@ -- and even if it were already in mainline, you
shouldn't e-mail stable@ without including the upstream commit ID
and kernel version to apply it to.  (Unless I'm missing something?)

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
