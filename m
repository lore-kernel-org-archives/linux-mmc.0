From: Ming Lei <ming.lei@canonical.com>
Subject: Re: [RFC PATCH] Revert "mmc: omap_hsmmc: Enable Auto CMD12"
Date: Fri, 22 Jun 2012 21:04:04 +0800
Message-ID: <CACVXFVPwxavwpAGx8dfK7sKSWh1DK56B467cGCMoHJyQJ_o_OA@mail.gmail.com>
References: <1340362175-25807-1-git-send-email-ming.lei@canonical.com>
	<CANrkHUacUKPS=hee6=dhcGAjiC1CS88RNrBNy=wFX5y1Oxb05A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:38320 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761968Ab2FVNEJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 22 Jun 2012 09:04:09 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174])
	by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_ARCFOUR_MD5:16)
	(Exim 4.71)
	(envelope-from <ming.lei@canonical.com>)
	id 1Si3Wv-0003zR-Ve
	for linux-mmc@vger.kernel.org; Fri, 22 Jun 2012 13:04:06 +0000
Received: by yenl2 with SMTP id l2so1469621yen.19
        for <linux-mmc@vger.kernel.org>; Fri, 22 Jun 2012 06:04:05 -0700 (PDT)
In-Reply-To: <CANrkHUacUKPS=hee6=dhcGAjiC1CS88RNrBNy=wFX5y1Oxb05A@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "T Krishnamoorthy, Balaji" <balajitk@ti.com>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, Venkatraman S <svenkatr@ti.com>

On Fri, Jun 22, 2012 at 8:29 PM, T Krishnamoorthy, Balaji
<balajitk@ti.com> wrote:

> Hi Ming,
> Rather than reverting the entire commit,
> Can you try with the below change alone, so that AutoCMD12 can be easily
> enabled back when needed.

I don't think it is a good practice to just revert it partially.

I'd like to test your constructive patches for helping to troubleshoot
the problem.

But I has not enough time to test this kind of change just for
choosing reverting it totally or in part.

I have a working filesystem(at least 5G) on the card, after each
tests, I have to copy the original filesystem into the card again
for recovery of my work. The process is very tedious and will
take me some time(it is a slow card.)

Also some sectors in my another card has been damaged
permanently during the tests, but I am not sure if it is caused by
its lifetime or just your patch.


thanks,
--
Ming Lei
