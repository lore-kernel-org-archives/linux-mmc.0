From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: [RFC v2 07/13] power: pwrseq: simple: Add support for toggling
 regulator
Date: Thu, 5 May 2016 15:31:03 -0400
Message-ID: <d27c30c1-f205-973e-71f1-f5b410418d04@osg.samsung.com>
References: <1462451666-17945-1-git-send-email-k.kozlowski@samsung.com>
 <1462451666-17945-8-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1462451666-17945-8-git-send-email-k.kozlowski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Brown <broonie@kernel.org>
Cc: tjakobi@math.uni-bielefeld.de, m.szyprowski@samsung.com, hverkuil@xs4all.nl, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-mmc@vger.kernel.org

Hello Krzysztof,

On 05/05/2016 08:34 AM, Krzysztof Kozlowski wrote:
> Some devices need real hard-reset by cutting the power.  During power
> sequence turn off and on the regulator, if it is provided.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---

[snip]

>  
>  #define to_pwrseq_simple(p) container_of(p, struct mmc_pwrseq_simple, pwrseq)
> @@ -62,6 +65,13 @@ static void mmc_pwrseq_simple_post_power_on(struct pwrseq *_pwrseq)
>  {
>  	struct mmc_pwrseq_simple *pwrseq = to_pwrseq_simple(_pwrseq);
>  
> +	if (pwrseq->ext_reg) {
> +		int err;
> +
> +		err = regulator_enable(pwrseq->ext_reg);
> +		WARN_ON_ONCE(err);
> +	}
> +

Shouldn't this be in mmc_pwrseq_simple_pre_power_on() instead?

For example, a chip may need to be powered on before attempting to
toggle its reset or power pins using some GPIO lines.

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
