From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: Re: [PATCH v6 02/14] clk: qcom: Add rcg ops to return floor value
 closest to the requested rate
Date: Wed, 9 Nov 2016 17:23:04 +0530
Message-ID: <723dd8bd-c13c-ebd1-f391-2d9f7d56a852@codeaurora.org>
References: <1478517877-23733-1-git-send-email-riteshh@codeaurora.org>
 <1478517877-23733-3-git-send-email-riteshh@codeaurora.org>
 <20161108230217.GM16026@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:39412 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751498AbcKILxP (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Nov 2016 06:53:15 -0500
In-Reply-To: <20161108230217.GM16026@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, adrian.hunter@intel.com, shawn.lin@rock-chips.com, devicetree@vger.kernel.org, linux-clk@vger.kernel.org, david.brown@linaro.org, andy.gross@linaro.org, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, alex.lemberg@sandisk.com, mateusz.nowak@intel.com, Yuliy.Izrailov@sandisk.com, asutoshd@codeaurora.org, kdorfman@codeaurora.org, david.griego@linaro.org, stummala@codeaurora.org, venkatg@codeaurora.org, rnayak@codeaurora.org, pramod.gurav@linaro.org

Hi Stephen,

Thanks for the review.

On 11/9/2016 4:32 AM, Stephen Boyd wrote:
> On 11/07, Ritesh Harjani wrote:
>> diff --git a/drivers/clk/qcom/clk-rcg.h b/drivers/clk/qcom/clk-rcg.h
>> index b904c33..1b3e8d2 100644
>> --- a/drivers/clk/qcom/clk-rcg.h
>> +++ b/drivers/clk/qcom/clk-rcg.h
>> @@ -173,6 +173,7 @@ struct clk_rcg2 {
>>  #define to_clk_rcg2(_hw) container_of(to_clk_regmap(_hw), struct clk_rcg2, clkr)
>>
>>  extern const struct clk_ops clk_rcg2_ops;
>> +extern const struct clk_ops clk_rcg2_floor_ops;
>>  extern const struct clk_ops clk_rcg2_shared_ops;
>>  extern const struct clk_ops clk_edp_pixel_ops;
>>  extern const struct clk_ops clk_byte_ops;
>> diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
>> index a071bba..04433a6 100644
>> --- a/drivers/clk/qcom/clk-rcg2.c
>> +++ b/drivers/clk/qcom/clk-rcg2.c
>> @@ -47,6 +47,11 @@
>>  #define N_REG			0xc
>>  #define D_REG			0x10
>>
>> +enum {
>> +	FLOOR,
>> +	CEIL,
>> +};
>
> Give it a name.
Yes, sure. I will keep it as freq_policy.

>
>> +
>>  static int clk_rcg2_is_enabled(struct clk_hw *hw)
>>  {
>>  	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
>> @@ -176,15 +181,25 @@ static int clk_rcg2_set_parent(struct clk_hw *hw, u8 index)
>>  	return calc_rate(parent_rate, m, n, mode, hid_div);
>>  }
>>
>> -static int _freq_tbl_determine_rate(struct clk_hw *hw,
>> -		const struct freq_tbl *f, struct clk_rate_request *req)
>> +static int _freq_tbl_determine_rate(struct clk_hw *hw, const struct freq_tbl *f,
>> +				    struct clk_rate_request *req, bool match)
>
> Use the enum please. Also name it something besides match.
> policy?
Sure. (freq_policy)

>
>>  {
>>  	unsigned long clk_flags, rate = req->rate;
>>  	struct clk_hw *p;
>>  	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
>>  	int index;
>>
>> -	f = qcom_find_freq(f, rate);
>> +	switch (match) {
>> +	case FLOOR:
>> +		f = qcom_find_freq_floor(f, rate);
>> +		break;
>> +	case CEIL:
>> +		f = qcom_find_freq(f, rate);
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	};
>> +
>>  	if (!f)
>>  		return -EINVAL;
>>
>> diff --git a/drivers/clk/qcom/common.c b/drivers/clk/qcom/common.c
>> index fffcbaf..cf6b87f 100644
>> --- a/drivers/clk/qcom/common.c
>> +++ b/drivers/clk/qcom/common.c
>> @@ -46,6 +46,32 @@ struct freq_tbl *qcom_find_freq(const struct freq_tbl *f, unsigned long rate)
>>  }
>>  EXPORT_SYMBOL_GPL(qcom_find_freq);
>>
>> +const
>> +struct freq_tbl *qcom_find_freq_floor(const struct freq_tbl *f,
>
> We can't put const and struct on the same line?
Ok sure.

>
>> +				      unsigned long rate)
>> +{
>> +	int size = 0;
>> +
>> +	if (!f)
>> +		return NULL;
>> +
>> +	/*
>> +	 * The freq table has entries in the ascending order of frequencies
>> +	 * To find the floor for a given frequency, we need to do a reverse
>> +	 * lookup of the table
>> +	 */
>> +	for (; f->freq; f++, size++)
>> +		;
>> +
>> +	for (f--; size; f--, size--)
>> +		if (rate >= f->freq)
>> +			return f;
>
> I don't understand why we can't do this while iterating through
> the table. We shouldn't need to size up the frequency table first.
>
> 	const struct freq_tbl *best = NULL;
>
> 	for ( ; f->freq; f++) {
> 		if (rate >= f->freq)
> 			best = f->freq;
> 		else
> 			break;
> 	}
> 	
> 	return best;
>
Yes, will do above change.

>> +
>> +	/* could not find any rates lower than *rate* */
>
>> +	return NULL;
>> +}
>> +EXPORT_SYMBOL_GPL(qcom_find_freq_floor);
>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
