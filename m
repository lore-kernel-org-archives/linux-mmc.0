From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 03/13] mmc: mmci: Add Qualcomm Id to amba id table
Date: Mon, 26 May 2014 11:10:55 +0200
Message-ID: <CAPDyKFqfqhnCKA-dMqAfkhQ+cLLhN0vMtwTxB6t+MUju_04O-g@mail.gmail.com>
References: <1400849362-7007-1-git-send-email-srinivas.kandagatla@linaro.org>
	<1400849474-7177-1-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1400849474-7177-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Russell King <linux@arm.linux.org.uk>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arm-msm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
List-Id: linux-mmc@vger.kernel.org

Hi Srinivas,

>
> +static struct variant_data variant_qcom = {
> +       .fifosize               = 16 * 4,
> +       .fifohalfsize           = 8 * 4,
> +       .clkreg                 = MCI_CLK_ENABLE,
> +       .datalength_bits        = 24,
> +       .blksz_datactrl4        = true,

You get compile error here.

Kind regards
Ulf Hansson
