From: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
Subject: Re: [PATCH RFC 2/3] mmc: core: add new cap for 3.3V only DDR MMCs
Date: Sun, 7 Aug 2016 10:09:12 +0200 (CEST)
Message-ID: <520205570.103061.350ab33c-8282-4c97-82e2-90a06202b849.open-xchange@email.1und1.de>
References: <1470488140-10104-1-git-send-email-stefan.wahren@i2se.com>
 <1470488140-10104-3-git-send-email-stefan.wahren@i2se.com>
 <0e38d62a-b3d0-30ca-fca9-bb740ae54d0a@denx.de>
 <16443443.114784.752d0f22-93a7-46e8-bb14-c884787aaea3.open-xchange@email.1und1.de>
 <7284d9a4-164d-dd2d-b9a0-dd1de6c76274@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <7284d9a4-164d-dd2d-b9a0-dd1de6c76274-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Cc: Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Otavio Salvador <otavio-fKevB0iiKLMBZ+LybsDmbA@public.gmane.org>, Holger Schurig <holgerschurig-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dong Aisheng <aisheng.dong-3arQi8VN3Tc@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Hi Shawn,

> Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org> hat am 7. August 2016 um 04:07
> geschrieben:
> 
> 
> 在 2016/8/6 22:18, Stefan Wahren 写道:
> > Hi Marek,
> >
> >> Marek Vasut <marex-ynQEQJNshbs@public.gmane.org> hat am 6. August 2016 um 15:14 geschrieben:
> >>
> >>
> >> On 08/06/2016 02:55 PM, Stefan Wahren wrote:
> >>> This patch based on the work of Fabio Estevam:
> >>> "[PATCH v2] mmc: core: Do not set mmc voltage to 1.8V when
> >>> 'no-1-8-v' is present"
> >>>
> >>> It adds the support for 3.3V only DDR MMC hosts.
> >>
> >> Do such cards even exist ? Do you have a link where I can find some ?
> >
> > i never said anything about SD cards. I mean eMMC modules which usually have
> > 8
> > data pins like this one [1].
> >
> > Please don't blame me if it's not compatible to i.MX28. It's only an
> > example.
> >
> > [1] -
> > http://datasheet.octopart.com/THGBM3G4D1FBAIGH2H-Toshiba-datasheet-20748880.pdf
> 
> 
> I download the datasheet you mentioned, and I explicitly see it
> describe 1V8 everywhere, especially for the section of "ELECTRICAL
> CHARACTERISTICS".
> 
> I never see one eMMC claiming DDR52 capability but doesn't support 1V8
> so far. Could you kindly share me the part number of the eMMC you are
> using? :)

sorry the subject line is misleading. The capability flag is about the host not
about the MMC itself. There are hosts which doesn't support 1.8V. I will clarify
this in the next version.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
