From: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Subject: Re: [PATCH 1/7] clk: actions: Fix factor clk struct member access
Date: Mon, 10 Jun 2019 15:36:42 +0200
Message-ID: <29ef33a9-f1f1-fe10-9288-8103714d40fa@suse.de>
References: <20190608195317.6336-1-manivannan.sadhasivam@linaro.org>
 <20190608195317.6336-2-manivannan.sadhasivam@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190608195317.6336-2-manivannan.sadhasivam@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, sboyd@kernel.org
Cc: ulf.hansson@linaro.org, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, thomas.liau@actions-semi.com, linux-actions@lists.infradead.org, linus.walleij@linaro.org, linux-clk@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Mani,

Am 08.06.19 um 21:53 schrieb Manivannan Sadhasivam:
> Since the helper "owl_factor_helper_round_rate" is shared between factor
> and composite clocks, using the factor clk specific helper function
> like "hw_to_owl_factor" to access its members will create issues when
> called from composite clk specific code. Hence, pass the "factor_hw"
> struct pointer directly instead of fetching it using factor clk specific
> helpers.
> 
> This issue has been observed when a composite clock like "sd0_clk" tried
> to call "owl_factor_helper_round_rate" resulting in pointer dereferencing
> error.
> 
> Fixes: 4bb78fc9744a ("clk: actions: Add factor clock support")
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/clk/actions/owl-factor.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/clk/actions/owl-factor.c b/drivers/clk/actions/owl-factor.c
> index 317d4a9e112e..f419dfdd334f 100644
> --- a/drivers/clk/actions/owl-factor.c
> +++ b/drivers/clk/actions/owl-factor.c
> @@ -64,11 +64,10 @@ static unsigned int _get_table_val(const struct clk_factor_table *table,
>  	return val;
>  }
>  
> -static int clk_val_best(struct clk_hw *hw, unsigned long rate,
> +static int clk_val_best(const struct owl_factor_hw *factor_hw,
> +			struct clk_hw *hw, unsigned long rate,
>  			unsigned long *best_parent_rate)
>  {
> -	struct owl_factor *factor = hw_to_owl_factor(hw);
> -	struct owl_factor_hw *factor_hw = &factor->factor_hw;
>  	const struct clk_factor_table *clkt = factor_hw->table;
>  	unsigned long parent_rate, try_parent_rate, best = 0, cur_rate;
>  	unsigned long parent_rate_saved = *best_parent_rate;
> @@ -126,7 +125,7 @@ long owl_factor_helper_round_rate(struct owl_clk_common *common,
>  	const struct clk_factor_table *clkt = factor_hw->table;
>  	unsigned int val, mul = 0, div = 1;
>  
> -	val = clk_val_best(&common->hw, rate, parent_rate);
> +	val = clk_val_best(factor_hw, &common->hw, rate, parent_rate);
>  	_get_table_div_mul(clkt, val, &mul, &div);
>  
>  	return *parent_rate * mul / div;

While at it, I think it would be a good idea to rename it to
owl_clk_val_best. Pretty confusing that you're touching only owl files
for a clk_ refactoring, which sounds like common clk code.

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
