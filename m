From: Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH v6 02/14] clk: qcom: Add rcg ops to return floor value
 closest to the requested rate
Date: Tue, 8 Nov 2016 15:02:17 -0800
Message-ID: <20161108230217.GM16026@codeaurora.org>
References: <1478517877-23733-1-git-send-email-riteshh@codeaurora.org>
 <1478517877-23733-3-git-send-email-riteshh@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1478517877-23733-3-git-send-email-riteshh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ritesh Harjani <riteshh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, david.brown-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, georgi.djakov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, alex.lemberg-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org, mateusz.nowak-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Yuliy.Izrailov-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org, asutoshd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, kdorfman-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, david.griego-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, stummala-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, venkatg-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, rnayak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, pramod.gurav-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On 11/07, Ritesh Harjani wrote:
> diff --git a/drivers/clk/qcom/clk-rcg.h b/drivers/clk/qcom/clk-rcg.h
> index b904c33..1b3e8d2 100644
> --- a/drivers/clk/qcom/clk-rcg.h
> +++ b/drivers/clk/qcom/clk-rcg.h
> @@ -173,6 +173,7 @@ struct clk_rcg2 {
>  #define to_clk_rcg2(_hw) container_of(to_clk_regmap(_hw), struct clk_rcg2, clkr)
>  
>  extern const struct clk_ops clk_rcg2_ops;
> +extern const struct clk_ops clk_rcg2_floor_ops;
>  extern const struct clk_ops clk_rcg2_shared_ops;
>  extern const struct clk_ops clk_edp_pixel_ops;
>  extern const struct clk_ops clk_byte_ops;
> diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
> index a071bba..04433a6 100644
> --- a/drivers/clk/qcom/clk-rcg2.c
> +++ b/drivers/clk/qcom/clk-rcg2.c
> @@ -47,6 +47,11 @@
>  #define N_REG			0xc
>  #define D_REG			0x10
>  
> +enum {
> +	FLOOR,
> +	CEIL,
> +};

Give it a name.

> +
>  static int clk_rcg2_is_enabled(struct clk_hw *hw)
>  {
>  	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
> @@ -176,15 +181,25 @@ static int clk_rcg2_set_parent(struct clk_hw *hw, u8 index)
>  	return calc_rate(parent_rate, m, n, mode, hid_div);
>  }
>  
> -static int _freq_tbl_determine_rate(struct clk_hw *hw,
> -		const struct freq_tbl *f, struct clk_rate_request *req)
> +static int _freq_tbl_determine_rate(struct clk_hw *hw, const struct freq_tbl *f,
> +				    struct clk_rate_request *req, bool match)

Use the enum please. Also name it something besides match.
policy?

>  {
>  	unsigned long clk_flags, rate = req->rate;
>  	struct clk_hw *p;
>  	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
>  	int index;
>  
> -	f = qcom_find_freq(f, rate);
> +	switch (match) {
> +	case FLOOR:
> +		f = qcom_find_freq_floor(f, rate);
> +		break;
> +	case CEIL:
> +		f = qcom_find_freq(f, rate);
> +		break;
> +	default:
> +		return -EINVAL;
> +	};
> +
>  	if (!f)
>  		return -EINVAL;
>  
> diff --git a/drivers/clk/qcom/common.c b/drivers/clk/qcom/common.c
> index fffcbaf..cf6b87f 100644
> --- a/drivers/clk/qcom/common.c
> +++ b/drivers/clk/qcom/common.c
> @@ -46,6 +46,32 @@ struct freq_tbl *qcom_find_freq(const struct freq_tbl *f, unsigned long rate)
>  }
>  EXPORT_SYMBOL_GPL(qcom_find_freq);
>  
> +const
> +struct freq_tbl *qcom_find_freq_floor(const struct freq_tbl *f,

We can't put const and struct on the same line?

> +				      unsigned long rate)
> +{
> +	int size = 0;
> +
> +	if (!f)
> +		return NULL;
> +
> +	/*
> +	 * The freq table has entries in the ascending order of frequencies
> +	 * To find the floor for a given frequency, we need to do a reverse
> +	 * lookup of the table
> +	 */
> +	for (; f->freq; f++, size++)
> +		;
> +
> +	for (f--; size; f--, size--)
> +		if (rate >= f->freq)
> +			return f;

I don't understand why we can't do this while iterating through
the table. We shouldn't need to size up the frequency table first.

	const struct freq_tbl *best = NULL;

	for ( ; f->freq; f++) {
		if (rate >= f->freq)
			best = f->freq;
		else
			break;
	}
	
	return best;

> +
> +	/* could not find any rates lower than *rate* */

> +	return NULL;
> +}
> +EXPORT_SYMBOL_GPL(qcom_find_freq_floor);

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
