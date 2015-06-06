From: Suman Tripathi <stripathi@apm.com>
Subject: Re: [PATCH RESEND v7 2/2] mmc: host: sdhci: Add support to disable
 SDR104/SDR50/DDR50 based on capability register 0.
Date: Sat, 6 Jun 2015 19:26:38 +0530
Message-ID: <CAOHikRCXuJryKgo7pjehi-SyosE1Rr2zFjc+9yWJwke_ib=Azw@mail.gmail.com>
References: <1432197817-22110-1-git-send-email-stripathi@apm.com>
	<1432197817-22110-3-git-send-email-stripathi@apm.com>
	<CAPDyKFpxkNF9C8AOJ6+18CEcpZTKycPR0i5OuwPRr1Zc+VPJ5Q@mail.gmail.com>
	<CAOHikRASDmy7PwFjqmX7JAjW52DYR+d3RkE3yd_45NN5sHK7Pg@mail.gmail.com>
	<CAOHikRBB9Uyh4Z34_pFTdmA0A-vnV09zTi8iYEU+01XvmzSr_A@mail.gmail.com>
	<20150605145323.GA15110@shlinux1.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og117.obsmtp.com ([64.18.0.149]:41342 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751909AbbFFN4k (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 6 Jun 2015 09:56:40 -0400
Received: by wibut5 with SMTP id ut5so45535142wib.1
        for <linux-mmc@vger.kernel.org>; Sat, 06 Jun 2015 06:56:38 -0700 (PDT)
In-Reply-To: <20150605145323.GA15110@shlinux1.ap.freescale.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dong Aisheng <b29396@freescale.com>
Cc: aisheng.dong@freescale.com, Chris Ball <chris@printf.net>, Anton Vorontsov <anton@enomsg.org>, Arnd Bergmann <arnd@arndb.de>, Michal Simek <michal.simek@xilinx.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Don Dutile <ddutile@redhat.com>, Jon Masters <jcm@redhat.com>, Mark Langsdorf <mlangsdo@redhat.com>, patches <patches@apm.com>, Ulf Hansson <ulf.hansson@linaro.org>

On Fri, Jun 5, 2015 at 8:23 PM, Dong Aisheng <b29396@freescale.com> wrote:
>
> On Mon, Jun 01, 2015 at 01:38:47PM +0530, Suman Tripathi wrote:
> >    Hi Aisheng,
> >    On Wed, May 27, 2015 at 7:46 PM, Suman Tripathi <[1]stripathi@apm.com>
> >    wrote:
> >
> >      On Tue, May 26, 2015 at 6:06 PM, Ulf Hansson <[2]ulf.hansson@linaro.org>
> >      wrote:
> >
> >        On 21 May 2015 at 10:43, Suman Tripathi <[3]stripathi@apm.com> wrote:
> >        > The sdhci framework disables SDR104/SDR50/DDR50 based on only quirk.
> >        > This patch adds the support to disable SDR104/SDR50/DDR50 based on
> >        > reading the capability register 0.
> >        >
> >        > Signed-off-by: Suman Tripathi <[4]stripathi@apm.com>
> >        > ---
> >        > ---
> >        >  drivers/mmc/host/sdhci.c | 3 ++-
> >        >  1 file changed, 2 insertions(+), 1 deletion(-)
> >        >
> >        > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> >        > index 58c1770..a3d9b8a 100644
> >        > --- a/drivers/mmc/host/sdhci.c
> >        > +++ b/drivers/mmc/host/sdhci.c
> >        > @@ -3118,7 +3118,8 @@ int sdhci_add_host(struct sdhci_host *host)
> >        >                 }
> >        >         }
> >        >
> >        > -       if (host->quirks2 & SDHCI_QUIRK2_NO_1_8_V)
> >        > +       if (host->quirks2 & SDHCI_QUIRK2_NO_1_8_V ||
> >        > +           !(caps[0] & SDHCI_CAN_VDD_180))
> >        >                 caps[1] &= ~(SDHCI_SUPPORT_SDR104 |
> >        SDHCI_SUPPORT_SDR50 |
> >        >                        SDHCI_SUPPORT_DDR50);
> >        >
> >        > --
> >        > 1.8.2.1
> >        >
> >
> >        I have no problem with this patch, except that it would be nice to get
> >        a few "tested by" to make sure it doesn't break UHS support for some
> >        SoCs.
> >
> >        Kind regards
> >        Uffe
> >
> >      Can anyone test this in some other SoC ? Appreciate your help ..
> >
> >    Can you test this patch  on imx SoC ?
> >
>
> (Your email have some format issue.)

Yeah missed to sent in plain text mode.

>
> I have tested this patch and it does not break imx SoC.
> You can add my tag.
> Tested-by: Dong Aisheng <aisheng.dong@freescale.com>

Thanks Dong !!

>
> However, it looks to me SDHCI_CAN_VDD_180 is only indicating the host VDD
> capabiliies, not IO voltage capability.

Are you sure on this ?? If SDHCI host VDD is  1.8V then the cards are
also capable to operate at 1.8V ? Didn't understand what you mean by
IO voltage capability


> SD3.0 cards require 1.8v IO voltage support.
> So should this bit affect SD3.0 support?

The preset value resgister says that  SDR modes requires 1.8V and we
disable the modes based on capability or quirk.

> e.g. some hosts can only work at VDD_330 (most VDD of SD slot on IMX boards
> is using external regulator and is fixed to 3.3v), but it can support 1.8v
> IO voltage, so it can support SD3.0 cards as well.

Same for us but somehow 1.8v is broken in our version.  Yeah so those
host can still use 1.8V by not setting the quirk or not setting the
capability register.
>
> Ulf,
> Can you help confirm it?
>
> Regards
> Dong Aisheng
>
> >      --
> >      Thanks,
> >      with regards,
> >      Suman Tripathi
> >
> >    --
> >    Thanks,
> >    with regards,
> >    Suman Tripathi
> >
> > References
> >
> >    Visible links
> >    1. mailto:stripathi@apm.com
> >    2. mailto:ulf.hansson@linaro.org
> >    3. mailto:stripathi@apm.com
> >    4. mailto:stripathi@apm.com
> > perl: warning: Setting locale failed.
> > perl: warning: Please check that your locale settings:
> >       LANGUAGE = (unset),
> >       LC_ALL = (unset),
> >       LC_TIME = "zh_CN.UTF-8",
> >       LC_MONETARY = "zh_CN.UTF-8",
> >       LC_ADDRESS = "zh_CN.UTF-8",
> >       LC_TELEPHONE = "zh_CN.UTF-8",
> >       LC_NAME = "zh_CN.UTF-8",
> >       LC_MEASUREMENT = "zh_CN.UTF-8",
> >       LC_IDENTIFICATION = "zh_CN.UTF-8",
> >       LC_NUMERIC = "zh_CN.UTF-8",
> >       LC_PAPER = "zh_CN.UTF-8",
> >       LANG = "en_US.UTF-8"
> >     are supported and installed on your system.
> > perl: warning: Falling back to the standard locale ("C").




-- 
Thanks,
with regards,
Suman Tripathi
