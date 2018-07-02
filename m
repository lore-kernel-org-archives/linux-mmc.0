From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 0/2] mmc: renesas_sdhi_internal_dmac: fix two issues
 for error path
Date: Mon, 2 Jul 2018 16:37:11 +0200
Message-ID: <CAPDyKFoEM4+7waCsWt1QnkkbT-VNPVvqCsT3j+R1LXpAi5Jr7Q@mail.gmail.com>
References: <1530266505-19953-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1530266505-19953-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Sender: stable-owner@vger.kernel.org
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, "# 4.0+" <stable@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 29 June 2018 at 12:01, Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> This patch set is based on the mmc.git / fixes branch.
>
> Changes from v1:
>  - Add Reviewed-by Geert-san.
>  - Add a new goto label for error path.
>
> Yoshihiro Shimoda (2):
>   mmc: renesas_sdhi_internal_dmac: Fix missing unmap in error patch
>   mmc: renesas_sdhi_internal_dmac: Cannot clear the RX_IN_USE in abort
>
>  drivers/mmc/host/renesas_sdhi_internal_dmac.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
>
> --
> 1.9.1
>

Thanks, applied for fixes!

Kind regards
Uffe
