From: Sahitya Tummala <stummala@codeaurora.org>
Subject: Re: Fixes for the MSM SDCC driver on msm7200a
Date: Tue, 23 Aug 2011 16:16:37 +0530
Message-ID: <4E53850D.4040301@codeaurora.org>
References: <1313927564-10355-1-git-send-email-alexander.tarasikov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1313927564-10355-1-git-send-email-alexander.tarasikov@gmail.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Alexander Tarasikov <alexander.tarasikov@gmail.com>
Cc: davidb@codeaurora.org, dwalker@fifo99.com, bryanh@codeaurora.org, cjb@laptop.org, linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Alexander,

Both these patches looks good to me.

Acked-by: Sahitya Tummala <stummala@codeaurora.org>

Thanks,
Sahitya.
--
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.

On 8/21/2011 5:22 PM, Alexander Tarasikov wrote:
> These two patches fix issues that prevent the MSM SDCC driver from
> being used on msm7200a boards. First one fixes a NULL pointer when
> the board does not supply gpio config. Second one adds the init_card
> operation instead of the declared but unimplemented embedded_sdio_data
> feature.
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
