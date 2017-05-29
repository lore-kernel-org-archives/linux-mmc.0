From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 4/4] mmc: sdhci-esdhc-imx: Remove the ENGcm07207 workaround
Date: Mon, 29 May 2017 08:14:48 -0300
Message-ID: <CAOMZO5AONaJOeGB4qBEfMtS2LGL45FuhAtGQhME4thyiwaPUvg@mail.gmail.com>
References: <1493805925-3644-1-git-send-email-benoit@wsystem.com> <1493805925-3644-4-git-send-email-benoit@wsystem.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1493805925-3644-4-git-send-email-benoit@wsystem.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Beno=C3=AEt_Th=C3=A9baudeau?= <benoit@wsystem.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Fabio Estevam <fabio.estevam@nxp.com>, joancarles <joancarles@fqingenieria.es>, =?UTF-8?B?RXJpYyBCw6luYXJk?= <eric@eukrea.com>, Wolfram Sang <wsa@the-dreams.de>
List-Id: linux-mmc@vger.kernel.org

On Wed, May 3, 2017 at 7:05 AM, Beno=C3=AEt Th=C3=A9baudeau <benoit@wsystem=
.com> wrote:
> The SDHCI_QUIRK_NO_MULTIBLOCK quirk was used as a workaround for the
> ENGcm07207 erratum. However, it caused excruciatingly slow SD transfers
> (300 kB/s on average), and this erratum actually does not imply that
> multiple-block transfers are not supported, so this was overkill.
>
> The suggested workaround for this erratum is to set SYSCTL.RSTA, but the
> simple DAT line software reset (which resets the DMA circuit among
> others) triggered by sdhci_finish_data() in case of errors seems to be
> sufficient. Indeed, generating errors in a controlled manner on i.MX25
> using the FEVT register right in the middle of read data transfers
> without this quirk shows that nothing is written to the buffer by the
> eSDHC past CMD12, and no extra Auto CMD12 is sent with AC12EN set, so
> the data transfers on AHB are properly aborted. For write data
> transfers, neither extra data nor extra Auto CMD12 is sent, as expected.
> Moreover, after intensive stress tests on i.MX25, removing
> SDHCI_QUIRK_NO_MULTIBLOCK seems to be safe.
>
> Signed-off-by: Beno=C3=AEt Th=C3=A9baudeau <benoit@wsystem.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
