From: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: Re: [RESEND PATCH v5 0/2] Add phy support for arasan,sdhci-5.1
Date: Fri, 4 Mar 2016 09:27:39 +0800
Message-ID: <56D8E48B.1040604@rock-chips.com>
References: <1455848322-2210-1-git-send-email-shawn.lin@rock-chips.com>
 <CAPDyKFojtZamH-xwM9UTyWdeW3SSSS3-uUyVr2R1t9NkwCXvYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAPDyKFojtZamH-xwM9UTyWdeW3SSSS3-uUyVr2R1t9NkwCXvYg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org, Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, =?UTF-8?Q?S=c3=b6ren_Brinkmann?= <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

=E5=9C=A8 2016/2/20 6:23, Ulf Hansson =E5=86=99=E9=81=93:
>
> Den 19 feb 2016 3:24 fm skrev "Shawn Lin" <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org
> <mailto:shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>>:
>  >
>  >
>  > Hello Ulf and Adrian,
>  >
>  > Sorry for delay the new version for this topic. Actually I have no
>  > platform available to test phy stuff since v4. Now, I can rework i=
t.:)
>  > I remove rpm support from v5 because this patchset just need to fo=
cus
>  > on phy stuff, which will make the changes more precise. Another re=
ason
>  > is that phy_power_on take too much time from rpm, however the powe=
r
> profit
>  > gained from phy_power_off is little due to the low power mechanism
> with the
>  > phy itself observed from experiments.
>  >
>  > v4 can be found here:
>  > https://patchwork.kernel.org/patch/7463251/
>  >
>  > Note:
>  > Phy is mandatory requirement for arasan,sdhci-5.1, so we introduce
>  > generic phy support for sdhci-of-arasan.
>  >
>  >
>  > Shawn Lin (2):
>  >   Documentation: bindings: add description of phy for sdhci-of-ara=
san
>  >   mmc: sdhci-of-arasan: add phy support for sdhci-of-arasan
>  >
>  >  .../devicetree/bindings/mmc/arasan,sdhci.txt       | 20 ++++++-
>  >  drivers/mmc/host/sdhci-of-arasan.c                 | 66
> ++++++++++++++++++++--
>  >  2 files changed, 80 insertions(+), 6 deletions(-)
>  >
>  > --
>  > 2.3.7
>  >
>  >
>
> This looks good to me! When acks has been received I am ready to queu=
e
> it for next.
>

Hi Adrian,

	Any chance to look at this patch? I assume Ulf need your ack for
sdhci* patch. :)

> Kind regards
> Uffe
>


--=20
Best Regards
Shawn Lin

--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
