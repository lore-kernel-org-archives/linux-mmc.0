From: Heiko Schocher <hs@denx.de>
Subject: [Fwd: Re: [PATCH] arm, da8xx, mmc: set second MMC controllers default
 queue]
Date: Wed, 07 Dec 2011 07:22:23 +0100
Message-ID: <4EDF061F.7080302@denx.de>
Reply-To: hs@denx.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from b.relay.invitel.net ([62.77.203.4]:54450 "EHLO
	b.relay.invitel.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751391Ab1LGGWb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 7 Dec 2011 01:22:31 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sekhar Nori <nsekhar@ti.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>

Hello Sekhar,

here the forwarded comment from Ido Yariv to my patch. I tried
with current kernel MMC Controller 2 on my am1808 based board
without my fix, and it works fine, so no need for applying my
patch.

Thanks
bye,
Heiko

here the message from Ido:

Betreff: Re: [PATCH] arm, da8xx, mmc: set second MMC controllers default queue
Datum: Mon, 5 Dec 2011 10:35:10 +0200
Von: Ido Yariv <ido@wizery.com>
An: hs@denx.de
CC: juha.kuikka@gmail.com
Referenzen: <1322991210-20486-1-git-send-email-hs@denx.de>	<20111204102741.GL32400@WorkStation>	<4EDC7C00.30603@denx.de>

Hi Heiko,

On Dec 5, 2011 10:08 AM, "Heiko Schocher" <hs@denx.de> wro
> Ok ... patch not longer needed, but isn't it better to setup here
> immediately the right values? If so, I can sent a v2 with your
> suggested comment change.

These are just default values which will get overwritten later on, so im
not sure if it matters much. I guess it wouldn't hurt to use default_queue
instead of queue 1.

In any case, if you do chose to submit v2, the commit message should also
be changed if it doesnt really fix anything.

Thanks,
Ido.


-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
