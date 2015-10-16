From: Michael Turquette <mturquette@baylibre.com>
Subject: Re: [PATCH 4/5] clk: berlin: bg2q: remove CLK_IGNORE_UNUSED flag for sdio clk
Date: Fri, 16 Oct 2015 05:47:05 -0700
Message-ID: <20151016124705.20687.51712@quantum>
References: <1444628796-5484-1-git-send-email-jszhang@marvell.com>
 <1444628796-5484-5-git-send-email-jszhang@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1444628796-5484-5-git-send-email-jszhang@marvell.com>
Sender: linux-clk-owner@vger.kernel.org
To: ulf.hansson@linaro.org, sebastian.hesselbarth@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, sboyd@codeaurora.org
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jisheng Zhang <jszhang@marvell.com>
List-Id: linux-mmc@vger.kernel.org

Quoting Jisheng Zhang (2015-10-11 22:46:35)
> Since we have added the necessary axi clk properties in dts, we can
> remove the "sdio" clk's CLK_IGNORE_UNUSED flag now.
> 
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>

Applied to clk-next.

Regards,
Mike

> ---
>  drivers/clk/berlin/bg2q.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/berlin/bg2q.c b/drivers/clk/berlin/bg2q.c
> index 221f40c..243f421 100644
> --- a/drivers/clk/berlin/bg2q.c
> +++ b/drivers/clk/berlin/bg2q.c
> @@ -283,7 +283,7 @@ static const struct berlin2_gate_data bg2q_gates[] __initconst = {
>         { "usb2",       "perif",        13 },
>         { "usb3",       "perif",        14 },
>         { "pbridge",    "perif",        15, CLK_IGNORE_UNUSED },
> -       { "sdio",       "perif",        16, CLK_IGNORE_UNUSED },
> +       { "sdio",       "perif",        16 },
>         { "nfc",        "perif",        18 },
>         { "pcie",       "perif",        22 },
>  };
> -- 
> 2.6.1
> 
