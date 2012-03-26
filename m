From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v1 1/1] mmc: bus: print bus speed mode of UHS-I card
Date: Sun, 25 Mar 2012 23:25:41 -0700
Message-ID: <4F700BE5.2050101@codeaurora.org>
References: <1332482196-22572-1-git-send-email-subhashj@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1332482196-22572-1-git-send-email-subhashj@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Subhash Jadavani <subhashj@codeaurora.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, arindam.nath@amd.com
List-Id: linux-mmc@vger.kernel.org

On 3/22/2012 10:56 PM, Subhash Jadavani wrote:
> @@ -296,6 +297,28 @@ int mmc_add_card(struct mmc_card *card)
>  		break;
>  	}
>  
> +	if (mmc_sd_card_uhs(card)) {
> +		switch (card->sd_bus_speed) {
> +		case UHS_SDR104_BUS_SPEED:
> +			uhs_bus_speed_mode = "SDR104 ";
> +			break;
> +		case UHS_SDR50_BUS_SPEED:
> +			uhs_bus_speed_mode = "SDR50 ";
> +			break;
> +		case UHS_DDR50_BUS_SPEED:
> +			uhs_bus_speed_mode = "DDR50 ";
> +			break;
> +		case UHS_SDR25_BUS_SPEED:
> +			uhs_bus_speed_mode = "SDR25 ";
> +			break;
> +		case UHS_SDR12_BUS_SPEED:
> +			uhs_bus_speed_mode = "SDR12 ";
> +			break;
> +		default:
> +			uhs_bus_speed_mode = "";
> +			break;
> +		}
>

This could be better code with an array:

static char *speeds[] = {
	[UHS_SDR104_BUS_SPEED] = "SDR104",
 	[UHS_SDR50_BUS_SPEED] = "SDR50",
	[UHS_SDR50_BUS_SPEED] = "DDR50",
	...
};  

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
