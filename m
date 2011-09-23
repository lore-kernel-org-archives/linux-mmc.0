From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH V4] mmc: core: eMMC 4.5 Power Class Selection Feature
Date: Fri, 23 Sep 2011 10:39:01 -0400
Message-ID: <m2pqirxr0a.fsf@bob.laptop.org>
References: <1316788353-11411-1-git-send-email-girish.shivananjappa@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1316788353-11411-1-git-send-email-girish.shivananjappa@linaro.org>
	(Girish K. S.'s message of "Fri, 23 Sep 2011 20:02:33 +0530")
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Girish K S <girish.shivananjappa@linaro.org>
Cc: linux-mmc@vger.kernel.org, kgene.kim@samsung.com, patches@linaro.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Girish,

On Fri, Sep 23 2011, Girish K S wrote:
> +	default:
> +		pr_warning("%s: Voltage range not supported "
> +			   "for power class.\n", mmc_hostname(host));
> +		break;
> +	}

I suggested replacing your BUG(); here with a return, but you just have
a break here.  Is having the function continue in this case intentional?

> +
> +	pwrclass_val = ext_csd[index];
> +
> +	if (bus_width & (EXT_CSD_BUS_WIDTH_8 | EXT_CSD_DDR_BUS_WIDTH_8))
> +		pwrclass_val = (pwrclass_val & EXT_CSD_PWR_CL_8BIT_MASK) >>
> +				EXT_CSD_PWR_CL_8BIT_SHIFT;
> +	else
> +		pwrclass_val = (pwrclass_val & EXT_CSD_PWR_CL_4BIT_MASK) >>
> +				EXT_CSD_PWR_CL_4BIT_SHIFT;
> +
> +	/* If the power class is different from the default value */
> +	if (pwrclass_val > 0) {
> +		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> +				 EXT_CSD_POWER_CLASS,
> +				 pwrclass_val,
> +				 0);
> +	}
> +
> +	return err;
> +}

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
