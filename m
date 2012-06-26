From: "T Krishnamoorthy, Balaji" <balajitk@ti.com>
Subject: Re: [RFC PATCH] Revert "mmc: omap_hsmmc: Enable Auto CMD12"
Date: Tue, 26 Jun 2012 20:19:05 +0530
Message-ID: <CANrkHUYF-f_jsSu3nNcghXckE-oYTKtSOSbU=m-vQyv=6hWswA@mail.gmail.com>
References: <1340362175-25807-1-git-send-email-ming.lei@canonical.com>
	<CANrkHUacUKPS=hee6=dhcGAjiC1CS88RNrBNy=wFX5y1Oxb05A@mail.gmail.com>
	<87sjdnjykh.fsf@octavius.laptop.org>
	<CANrkHUYGLiO8S-Y1ubWmXQffhVGgex=Q=RH3DhwTqyqkZz6SaQ@mail.gmail.com>
	<CACVXFVPrKr_i9LvU8faamRV7qWUmEOtjbLPys3WvYZ8okun6PA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:43869 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757937Ab2FZOtI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 26 Jun 2012 10:49:08 -0400
Received: by lbbgm6 with SMTP id gm6so222854lbb.33
        for <linux-mmc@vger.kernel.org>; Tue, 26 Jun 2012 07:49:06 -0700 (PDT)
In-Reply-To: <CACVXFVPrKr_i9LvU8faamRV7qWUmEOtjbLPys3WvYZ8okun6PA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ming Lei <ming.lei@canonical.com>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, Venkatraman S <svenkatr@ti.com>

On Fri, Jun 22, 2012 at 9:05 PM, Ming Lei <ming.lei@canonical.com> wrot=
e:
> On Fri, Jun 22, 2012 at 11:13 PM, T Krishnamoorthy, Balaji
> <balajitk@ti.com> wrote:
>
>>
>> I tested autocmd12 to be working on OMAP2,3,4 SDP. With beagle board
>> data corruption is observed with some cards, so it is going to be se=
lectively
>> enabling/disabling for some SoCs via board data or DT until data cor=
ruption
>> due to Autocmd12 is root caused.
>
> It is still not a good idea.
>
> Considered that data ruin is a very serious problem, you need to find
> the root cause, then you may enable autocmd12.
>
> Also you didn't answer my question, will omap3/4 mmc controller
> just support SD card only? =A0The TRM said it clearly that the featur=
e
> is only supported for SD card.
>

Autocmd12 is supported for SD/MMC and not supported for SDIO in OMAP3/4=
=2E

> Thanks
> --
> Ming Lei
