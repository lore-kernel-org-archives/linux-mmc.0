From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [RFT 0/2] mmc: renesas_sdhi: small patches for RZ/A1
Date: Mon, 21 Aug 2017 14:33:31 +0200
Message-ID: <CAPDyKFoV33yAVLO3Ke8E5_UTBG4wsDn4qNPiTrQdnQAJqWR2_w@mail.gmail.com>
References: <20170809191452.5254-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20170809191452.5254-1-wsa+renesas@sang-engineering.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Chris Brandt <chris.brandt@renesas.com>
List-Id: linux-mmc@vger.kernel.org

On 9 August 2017 at 21:14, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> Here is a small series to improve RZ support for SDHI. I don't have that
> platform currently, so I hope Chris has some time to check these simple
> patches. It is based on top of the patch just sent out:
> "[PATCH] mmc: renesas_sdhi: use extra flag for CBSY usage"
>
> Regards,
>
>    Wolfram
>
>
> Wolfram Sang (2):
>   mmc: renesas_sdhi: enably CBSY bit for RZ platform
>   mmc: renesas_sdhi: document version of RZ/A1 instance
>
>  drivers/mmc/host/renesas_sdhi_core.c     | 1 +
>  drivers/mmc/host/renesas_sdhi_sys_dmac.c | 3 ++-
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> --

Thanks, applied for next!

Adding tags from Simon and Chris.

Kind regards
Uffe
