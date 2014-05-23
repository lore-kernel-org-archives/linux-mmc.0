From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v3 13/13] mmc: mmci: Add Qcom specific pio_read function.
Date: Fri, 23 May 2014 16:28:39 -0700
Message-ID: <537FD9A7.3010100@codeaurora.org>
References: <1400849362-7007-1-git-send-email-srinivas.kandagatla@linaro.org> <1400849589-7626-1-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1400849589-7626-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: srinivas.kandagatla@linaro.org
Cc: Russell King <linux@arm.linux.org.uk>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linus.walleij@linaro.org
List-Id: linux-mmc@vger.kernel.org

On 05/23/14 05:53, srinivas.kandagatla@linaro.org wrote:
> @@ -1022,6 +1025,40 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
>  	}
>  }
>  
> +static int mmci_qcom_pio_read(struct mmci_host *host, char *buffer,
> +			unsigned int remain)
> +{
> +	u32 *ptr = (u32 *) buffer;
> +	unsigned int count = 0;
> +	unsigned int words, bytes;
> +	unsigned int fsize = host->variant->fifosize;
> +
> +	words = remain >> 2;
> +	bytes = remain % 4;
> +	/* read full words followed by leftover bytes */
> +	if (words) {
> +		while (readl(host->base + MMCISTATUS) & MCI_RXDATAAVLBL) {
> +			*ptr = readl(host->base + MMCIFIFO + (count % fsize));

This doesn't look endianness agnostic. Shouldn't we use ioread32_rep()
to read this fifo?

> +			ptr++;
> +			count += 4;
> +			words--;
> +			if (!words)
> +				break;
> +		}
> +	}
> +
> +	if (unlikely(bytes)) {
> +		unsigned char buf[4];
> +		if (readl(host->base + MMCISTATUS) & MCI_RXDATAAVLBL) {
> +			*buf = readl(host->base + MMCIFIFO + (count % fsize));
> +			memcpy(ptr, buf, bytes);
> +			count += bytes;
> +		}
> +	}
> +
> +	return count;
> +}
> +
>  static int mmci_pio_read(struct mmci_host *host, char *buffer, unsigned int remain)
>  {
>  	void __iomem *base = host->base;
>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
