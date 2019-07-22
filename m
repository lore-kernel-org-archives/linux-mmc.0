From: Alan Cooper <alcooperx@gmail.com>
Subject: Issue with sequence to switch to HS400
Date: Mon, 22 Jul 2019 18:31:59 -0400
Message-ID: <CAOGqxeVeEq803rrtGrnubRA8cP3dRCXsU15ss3pS1q6ik+k8Bw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, "cc: Adrian Hunter" <adrian.hunter@intel.com>, linux-mmc <linux-mmc@vger.kernel.org>, ": Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

I'm having a problem with a new SD/MMC controller and PHY in our
latest SoC's. The issue I'm seeing is that I can't switch into HS400
mode. This looks like something the driver is doing that doesn't meet
the JEDEC spec. In the "HS400 timing mode selection" section of the
JEDEC spec , in step 7 it states:

7) Set the =E2=80=9CTiming Interface=E2=80=9D parameter in the HS_TIMING [1=
85] field
of the Extended CSD register to 0x1 to switch to High Speed mode and
then set the clock frequency to a value not greater than 52 MHz.

In the function mmc_select_hs400() in mmc.c, I see that a switch
command is done to set the eMMC device to HS mode and then
mmc_set_timing(card->host, MMC_TIMING_MMC_HS) is used to change the
controller to HS mode. The problem is that the "SD Host Controller
Standard Specification" states that "UHS Mode Select" field of the
"Host Control 2 Register" controls the mode when the "1.8V Signaling
Enable" bit in the same register is set, so mmc_set_timing() is
actually leaving the controller in SDR12 mode and mmc_select_hs400()
will then set the clock to 52MHz. This causes our PHY to detect an
illegal combination and return an error.

I think the easiest fix would be to change mmc_set_timing(card->host,
MMC_TIMING_MMC_HS) to mmc_set_timing(card->host,
MMC_TIMING_UHS_SDR25). The other possibility would be to change
mmc_set_timing to handle the "1.8V Signaling Enable" bit properly.
I'll submit a patch based on the feedback I get.

Thanks
Al Cooper
