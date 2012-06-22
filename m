From: Ming Lei <ming.lei@canonical.com>
Subject: Re: [RFC PATCH] Revert "mmc: omap_hsmmc: Enable Auto CMD12"
Date: Fri, 22 Jun 2012 23:35:07 +0800
Message-ID: <CACVXFVPrKr_i9LvU8faamRV7qWUmEOtjbLPys3WvYZ8okun6PA@mail.gmail.com>
References: <1340362175-25807-1-git-send-email-ming.lei@canonical.com>
	<CANrkHUacUKPS=hee6=dhcGAjiC1CS88RNrBNy=wFX5y1Oxb05A@mail.gmail.com>
	<87sjdnjykh.fsf@octavius.laptop.org>
	<CANrkHUYGLiO8S-Y1ubWmXQffhVGgex=Q=RH3DhwTqyqkZz6SaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:38960 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762327Ab2FVPfJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 22 Jun 2012 11:35:09 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174])
	by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_ARCFOUR_MD5:16)
	(Exim 4.71)
	(envelope-from <ming.lei@canonical.com>)
	id 1Si5t6-0000iV-F5
	for linux-mmc@vger.kernel.org; Fri, 22 Jun 2012 15:35:08 +0000
Received: by yenl2 with SMTP id l2so1628571yen.19
        for <linux-mmc@vger.kernel.org>; Fri, 22 Jun 2012 08:35:07 -0700 (PDT)
In-Reply-To: <CANrkHUYGLiO8S-Y1ubWmXQffhVGgex=Q=RH3DhwTqyqkZz6SaQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "T Krishnamoorthy, Balaji" <balajitk@ti.com>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, Venkatraman S <svenkatr@ti.com>

On Fri, Jun 22, 2012 at 11:13 PM, T Krishnamoorthy, Balaji
<balajitk@ti.com> wrote:

>
> I tested autocmd12 to be working on OMAP2,3,4 SDP. With beagle board
> data corruption is observed with some cards, so it is going to be selectively
> enabling/disabling for some SoCs via board data or DT until data corruption
> due to Autocmd12 is root caused.

It is still not a good idea.

Considered that data ruin is a very serious problem, you need to find
the root cause, then you may enable autocmd12.

Also you didn't answer my question, will omap3/4 mmc controller
just support SD card only?  The TRM said it clearly that the feature
is only supported for SD card.

Thanks
--
Ming Lei
