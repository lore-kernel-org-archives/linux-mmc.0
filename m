From: Alan Cooper <alcooperx@gmail.com>
Subject: Re: Issue with sequence to switch to HS400
Date: Tue, 23 Jul 2019 08:34:21 -0400
Message-ID: <CAOGqxeVR3XzAQ-yTH35hyT3KpL11nTwMY1Ca96ZW=K=PiWMnHA@mail.gmail.com>
References: <CAOGqxeVeEq803rrtGrnubRA8cP3dRCXsU15ss3pS1q6ik+k8Bw@mail.gmail.com>
 <7610bbc9-83d8-ee98-1425-07bb65448541@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7610bbc9-83d8-ee98-1425-07bb65448541@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, ": Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Tue, Jul 23, 2019 at 1:21 AM Adrian Hunter <adrian.hunter@intel.com> wro=
te:
>
> On 23/07/19 1:31 AM, Alan Cooper wrote:
> > I'm having a problem with a new SD/MMC controller and PHY in our
> > latest SoC's. The issue I'm seeing is that I can't switch into HS400
> > mode. This looks like something the driver is doing that doesn't meet
> > the JEDEC spec. In the "HS400 timing mode selection" section of the
> > JEDEC spec , in step 7 it states:
> >
> > 7) Set the =E2=80=9CTiming Interface=E2=80=9D parameter in the HS_TIMIN=
G [185] field
> > of the Extended CSD register to 0x1 to switch to High Speed mode and
> > then set the clock frequency to a value not greater than 52 MHz.
> >
> > In the function mmc_select_hs400() in mmc.c, I see that a switch
> > command is done to set the eMMC device to HS mode and then
> > mmc_set_timing(card->host, MMC_TIMING_MMC_HS) is used to change the
> > controller to HS mode. The problem is that the "SD Host Controller
> > Standard Specification" states that "UHS Mode Select" field of the
> > "Host Control 2 Register" controls the mode when the "1.8V Signaling
> > Enable" bit in the same register is set, so mmc_set_timing() is
> > actually leaving the controller in SDR12 mode and mmc_select_hs400()
> > will then set the clock to 52MHz. This causes our PHY to detect an
> > illegal combination and return an error.
> >
> > I think the easiest fix would be to change mmc_set_timing(card->host,
> > MMC_TIMING_MMC_HS) to mmc_set_timing(card->host,
> > MMC_TIMING_UHS_SDR25). The other possibility would be to change
> > mmc_set_timing to handle the "1.8V Signaling Enable" bit properly.
> > I'll submit a patch based on the feedback I get.
>
> eMMC is governed by JEDEC specs not SD specs.

My understanding is that JEDEC does not have a host controller spec so
this driver uses the "SD Host Controller Standard Specification".

>
> Please consider making a change in your driver instead.  For example, hoo=
k
> ->set_ios() and if 1.8V is enabled and timing is set to MMC_TIMING_MMC_HS
> then change it to MMC_TIMING_UHS_SDR25.

That's an easy fix, but it still leaves all other drivers/systems
temporarily using SDR12 at 52MHz during the switch to HS400.
