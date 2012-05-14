From: Will Newton <will.newton@gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc: Fixed sdio interrupt mask bit setting bug
Date: Mon, 14 May 2012 10:06:41 +0100
Message-ID: <CAFbHwiSwu32cdzQib+TYj9uSt+PXmA1Ltk1mzECRoy1DfdjyNQ@mail.gmail.com>
References: <002901cd31ac$fb410250$f1c306f0$%kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <002901cd31ac$fb410250$f1c306f0$%kim@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Kyoungil Kim <ki0351.kim@samsung.com>
Cc: linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Kukjin Kim <kgene.kim@samsung.com>
List-Id: linux-mmc@vger.kernel.org

On Mon, May 14, 2012 at 9:38 AM, Kyoungil Kim <ki0351.kim@samsung.com> =
wrote:
> The sdio interrupt mask bits are arranged in [31:16].
> (1 << SDMMC_INT_SDIO(slot->id))) does 16 bits left shift twice.
> So this patch changes to do 16 bits left shift only one time.
>
> Signed-off-by: Kyoungil Kim <ki0351.kim@samsung.com>
> ---
> =A0drivers/mmc/host/dw_mmc.c | =A0 =A04 ++--
> =A01 files changed, 2 insertions(+), 2 deletions(-)

Yes, looks correct.

Acked-by: Will Newton <will.newton@imgtec.com>
