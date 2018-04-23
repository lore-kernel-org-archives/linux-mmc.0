From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V5 0/2] mmc: sdhci-msm: Configuring IO_PAD support for sdhci-msm
Date: Mon, 23 Apr 2018 11:18:00 +0200
Message-ID: <CAPDyKFp_YErJVM4PR5KSAwuBE2hakQ7Vqzzd8p=eybv02EvFhA@mail.gmail.com>
References: <1524226529-30100-1-git-send-email-vviswana@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1524226529-30100-1-git-send-email-vviswana@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Vijay Viswanath <vviswana@codeaurora.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Georgi Djakov <georgi.djakov@linaro.org>, Asutosh Das <asutoshd@codeaurora.org>, Sahitya Tummala <stummala@codeaurora.org>, Venkat Gopalakrishnan <venkatg@codeaurora.org>, Pramod Gurav <pramod.gurav@linaro.org>, Jeremy McNicoll <jeremymc@redhat.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Harjani Ritesh <riteshh@codeaurora.org>, vbadigan@codeaurora.org
List-Id: linux-mmc@vger.kernel.org

On 20 April 2018 at 14:15, Vijay Viswanath <vviswana@codeaurora.org> wrote:
> From the HPG:
> In some platform, SDCC controller can be connected to either an eMMC devi=
ce or
> an SD card. The PADs for SD card are dual-voltage that support 3v/1.8v. T=
hose
> PADs have a control signal  (io_pad_pwr_switch/mode18 ) that indicates wh=
ether
> the PAD works in 3v or 1.8v.
>
> For SD usage the default value of this signal is =E2=80=980=E2=80=99, and=
 SD driver changes it
> to =E2=80=981=E2=80=99 as a part of voltage switching sequence.
> For eMMC usage, SW should configure this signal to =E2=80=981=E2=80=99 an=
d supply 1.8v to PADs
> before starting any activity on the eMMC BUS.
>
> To set this signal, write the following in the
> SDC1_SDCC_HC_VENDOR_SPECIFIC_FUNC register:
>         HC_IO_PAD_PWR_SWITCH: bit 16
>                 HC_IO_PAD_PWR_SWITCH_EN: bit 15
>

Thanks, applied for next!

Kind regards
Uffe

> Changes since v1:
>         Modified comments on io_pad related changes.
>         Split some read+modify+write commands to multiple lines
>
> Changes since v2:
>         IO_PAD_PWR_SWITCH_EN will be set only if we have info regarding w=
hat
>         voltage is supported by the regulators.
>         Replaced regulator_list_voltage() API with
>         regulator_is_supported_voltage().
>
> Changes since v3:
>         Removed unnecessary prints and extra lines.
>
> Changes since v4:
>         Removed unnecessary mb() within sdhci_msm_handle_pwr_irq() since
>         wakeup calls have implicit write barriers.
>
> Krishna Konda (1):
>   mmc: sdhci-msm: support voltage pad switching
>
> Vijay Viswanath (1):
>   mmc: sdhci-msm: Add support to store supported vdd-io voltages
>
>  drivers/mmc/host/sdhci-msm.c | 99 ++++++++++++++++++++++++++++++++++++++=
+++++-
>  1 file changed, 97 insertions(+), 2 deletions(-)
>
> --
>  Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,=
 Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linu=
x Foundation Collaborative Project.
>
