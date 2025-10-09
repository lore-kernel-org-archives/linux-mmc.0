Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7AE34BA2C;
	Thu,  9 Oct 2025 01:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759972876; cv=none; b=duc2KoPLSNbFrRoG1M71AH8kbWedhyaRKas1W7hMPGUFGYTlHkuVv0qJyif7Fgd1pH9UYnrRjOwP6lDpaeyox4kFU18EAS0ocUpPt/opUXOI9JNa+oNbNOhauQ58AwUFxHF2bSMPnS5b6tgRs7x+XY1ho6Q0gWBSfOGox71j3Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759972876; c=relaxed/simple;
	bh=3h6ol3ZzDH1E1qxmL3ot9UELxZkAEjrYptDva8tkH2A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=im3frTJON4FDszmpqDn8ydnnvLrQ2FEVrLoQsIJhFw3GHZ/KKtc5ag2iJ2lAHtcMVdtyMObWvJePQPgGaiGLmXZ0T4b4Vn/jAi2CYgG2SXisY55yRJiZ8od/bMI+3/KJwFYhishkjPlNCOZXWT+HrNzZw+pD8UXfwAm02xeCqSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.198])
	by gateway (Coremail) with SMTP id _____8Cx6tEBDudoiRcUAA--.43127S3;
	Thu, 09 Oct 2025 09:21:05 +0800 (CST)
Received: from [10.161.0.102] (unknown [223.64.68.198])
	by front1 (Coremail) with SMTP id qMiowJBx38P9DedoUuTVAA--.63724S2;
	Thu, 09 Oct 2025 09:21:02 +0800 (CST)
Message-ID: <b97cc38f-c00b-469f-97e4-decbb2ba96c7@loongson.cn>
Date: Thu, 9 Oct 2025 09:21:01 +0800
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: pxamci: Fix passing NULL to PTR_ERR() in
 pxamci_probe()
To: Rakuram Eswaran <rakuram.e96@gmail.com>, ulf.hansson@linaro.org
Cc: u.kleine-koenig@baylibre.com, chenhuacai@kernel.org,
 david.hunter.linux@gmail.com, skhan@linuxfoundation.org, khalid@kernel.org,
 linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev, kernel test robot <lkp@intel.com>,
 Dan Carpenter <dan.carpenter@linaro.org>
References: <20251007161948.12442-1-rakuram.e96@gmail.com>
From: Binbin Zhou <zhoubinbin@loongson.cn>
In-Reply-To: <20251007161948.12442-1-rakuram.e96@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:qMiowJBx38P9DedoUuTVAA--.63724S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/1tbiAQEKCGjl-SoR1AAAsd
X-Coremail-Antispam: 1Uk129KBj93XoW7Ar15uF1ftryxXF4xAryfZrc_yoW5JFy8pa
	95JFWqka4UtF4xK39rGw47J3W5Xry3tay2gryrX3s3ua4jkF4kWr93uayFqF4UAFWFqr1F
	qF1UXF1UCFyDX3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Eb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
	6F4UJVW0owAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
	Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_
	Jw1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrw
	CY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8
	JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14
	v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY
	67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2
	IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_
	Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8Dl1DUUUUU==


On 2025/10/8 00:17, Rakuram Eswaran wrote:
> Smatch reported:
> drivers/mmc/host/pxamci.c:709 pxamci_probe() warn: passing zero to 'PTR_ERR'
>
> Case 1:
> When dma_request_chan() fails, host->dma_chan_rx is an ERR_PTR(),
> but it is reset to NULL before using PTR_ERR(), resulting in PTR_ERR(0).
> This mistakenly returns 0 instead of the real error code.
>
> Case 2:
> When devm_clk_get() fails, host->clk is an ERR_PTR() resulting in the similar
> issue like case 1.
>
> Store the error code before nullifying the pointers in both the cases.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/r/202510041841.pRlunIfl-lkp@intel.com/
> Fixes: 58c40f3faf742c ("mmc: pxamci: Use devm_mmc_alloc_host() helper")
> Signed-off-by: Rakuram Eswaran <rakuram.e96@gmail.com>
LGTM.

Reviewed-by: Binbin Zhou <zhoubinbin@loongson.cn>

> ---
>
> Build and Analysis:
> This patch was compiled against the configuration file reported by
> 0day CI in the above link (config: s390-randconfig-r071-20251004) using
> `s390x-linux-gnu-gcc (Ubuntu 14.2.0-19ubuntu2) 14.2.0`.
>
> Static analysis was performed with Smatch to ensure the reported warning
> no longer reproduces after applying this fix.
>
> Command used for verification:
>    ARCH=s390 CROSS_COMPILE=s390x-linux-gnu- \
>    ~/project/smatch/smatch_scripts/kchecker ./drivers/mmc/host/pxamci.c
>
>   drivers/mmc/host/pxamci.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
> index 26d03352af63..4fab693d3b32 100644
> --- a/drivers/mmc/host/pxamci.c
> +++ b/drivers/mmc/host/pxamci.c
> @@ -653,8 +653,9 @@ static int pxamci_probe(struct platform_device *pdev)
>   
>   	host->clk = devm_clk_get(dev, NULL);
>   	if (IS_ERR(host->clk)) {
> +		ret = PTR_ERR(host->clk);
>   		host->clk = NULL;
> -		return PTR_ERR(host->clk);
> +		return ret;
>   	}
>   
>   	host->clkrate = clk_get_rate(host->clk);
> @@ -705,8 +706,9 @@ static int pxamci_probe(struct platform_device *pdev)
>   
>   	host->dma_chan_rx = dma_request_chan(dev, "rx");
>   	if (IS_ERR(host->dma_chan_rx)) {
> +		ret = PTR_ERR(host->dma_chan_rx);
>   		host->dma_chan_rx = NULL;
> -		return dev_err_probe(dev, PTR_ERR(host->dma_chan_rx),
> +		return dev_err_probe(dev, ret,
>   				     "unable to request rx dma channel\n");
>   	}
>   
Thanks.
Binbin

