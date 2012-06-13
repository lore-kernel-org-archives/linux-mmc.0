From: "S, Venkatraman" <svenkatr@ti.com>
Subject: Re: [PATCH v1 1/1] mmc: block: fix the data timeout issue with ACMD22
Date: Thu, 14 Jun 2012 00:35:48 +0530
Message-ID: <CANfBPZ81uBVAhC=NWDMfoU_KsoyKQD0a-mpqO7DW+u3s1SpNWA@mail.gmail.com>
References: <1339587643-22115-1-git-send-email-subhashj@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1339587643-22115-1-git-send-email-subhashj@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Subhash Jadavani <subhashj@codeaurora.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Wed, Jun 13, 2012 at 5:10 PM, Subhash Jadavani
<subhashj@codeaurora.org> wrote:
> If multi block write operation fails for SD card, during
> error handling we send the SD_APP_SEND_NUM_WR_BLKS (ACMD22)
> to know how many blocks were already programmed by card.
>
> But mmc_sd_num_wr_blocks() function which sends the ACMD22
> calculates the data timeout value from csd.tacc_ns and
> csd.tacc_clks parameters which will be 0 for block addressed
> (>2GB cards) SD card. This would result in timeout_ns and
> timeout_clks being 0 in the mmc_request passed to host driver.
> This means host controller would program its data timeout timer
> value with 0 which could result in DATA TIMEOUT errors from
> controller.
>
> To fix this issue, mmc_sd_num_wr_blocks() should instead
> just call the mmc_set_data_timeout() to calculate the
> data timeout value. mmc_set_data_timeout() function
> ensures that non zero timeout value is set even for
> block addressed SD cards.
>
> Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>

The patch log could be improvised (Just mention that
set_data_timeout() is reused .. etc")
Even otherwise, its fine.
Reviewed-by: Venkatraman S <svenkatr@ti.com>

> ---
> =A0drivers/mmc/card/block.c | =A0 14 +-------------
> =A01 files changed, 1 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index 7e3f453..f1c84de 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -554,7 +554,6 @@ static u32 mmc_sd_num_wr_blocks(struct mmc_card *=
card)
> =A0 =A0 =A0 =A0struct mmc_request mrq =3D {NULL};
> =A0 =A0 =A0 =A0struct mmc_command cmd =3D {0};
> =A0 =A0 =A0 =A0struct mmc_data data =3D {0};
> - =A0 =A0 =A0 unsigned int timeout_us;
>
> =A0 =A0 =A0 =A0struct scatterlist sg;
>
> @@ -574,23 +573,12 @@ static u32 mmc_sd_num_wr_blocks(struct mmc_card=
 *card)
> =A0 =A0 =A0 =A0cmd.arg =3D 0;
> =A0 =A0 =A0 =A0cmd.flags =3D MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_AD=
TC;
>
> - =A0 =A0 =A0 data.timeout_ns =3D card->csd.tacc_ns * 100;
> - =A0 =A0 =A0 data.timeout_clks =3D card->csd.tacc_clks * 100;
> -
> - =A0 =A0 =A0 timeout_us =3D data.timeout_ns / 1000;
> - =A0 =A0 =A0 timeout_us +=3D data.timeout_clks * 1000 /
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 (card->host->ios.clock / 1000);
> -
> - =A0 =A0 =A0 if (timeout_us > 100000) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 data.timeout_ns =3D 100000000;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 data.timeout_clks =3D 0;
> - =A0 =A0 =A0 }
> -
> =A0 =A0 =A0 =A0data.blksz =3D 4;
> =A0 =A0 =A0 =A0data.blocks =3D 1;
> =A0 =A0 =A0 =A0data.flags =3D MMC_DATA_READ;
> =A0 =A0 =A0 =A0data.sg =3D &sg;
> =A0 =A0 =A0 =A0data.sg_len =3D 1;
> + =A0 =A0 =A0 mmc_set_data_timeout(&data, card);
>
> =A0 =A0 =A0 =A0mrq.cmd =3D &cmd;
> =A0 =A0 =A0 =A0mrq.data =3D &data;
> --
