From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 3/4] mmc: sdhci-esdhc-imx: Allow all supported prescaler values
Date: Mon, 29 May 2017 08:14:11 -0300
Message-ID: <CAOMZO5BnTHce4Dn=ppvd5hV3ShrcTHZvv_DwkeUC9qtWrMv8Rw@mail.gmail.com>
References: <1493805925-3644-1-git-send-email-benoit@wsystem.com> <1493805925-3644-3-git-send-email-benoit@wsystem.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oi0-f43.google.com ([209.85.218.43]:32817 "EHLO
        mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750871AbdE2LOM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 29 May 2017 07:14:12 -0400
In-Reply-To: <1493805925-3644-3-git-send-email-benoit@wsystem.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?UTF-8?Q?Beno=C3=AEt_Th=C3=A9baudeau?= <benoit@wsystem.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Fabio Estevam <fabio.estevam@nxp.com>, =?UTF-8?B?RXJpYyBCw6luYXJk?= <eric@eukrea.com>, Wolfram Sang <wsa@the-dreams.de>, Dong Aisheng <aisheng.dong@nxp.com>

On Wed, May 3, 2017 at 7:05 AM, Beno=C3=AEt Th=C3=A9baudeau <benoit@wsystem=
.com> wrote:
> On i.MX, SYSCTL.SDCLKFS may always be set to 0 in order to make the SD
> clock frequency prescaler divide by 1 in SDR mode, even with the eSDHC.
> The previous minimum prescaler value of 2 in SDR mode with the eSDHC was
> a code remnant from PowerPC, which actually has this limitation on
> earlier revisions.
>
> In DDR mode, the prescaler can divide by up to 512.
>
> The maximum SD clock frequency in High Speed mode is 50 MHz. On i.MX25,
> this change makes it possible to get 48 MHz from the USB PLL
> (240 MHz / 5 / 1) instead of only 40 MHz from the USB PLL
> (240 MHz / 3 / 2) or 33.25 MHz from the AHB clock (133 MHz / 2 / 2).
>
> Signed-off-by: Beno=C3=AEt Th=C3=A9baudeau <benoit@wsystem.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
