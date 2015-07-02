From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH] mmc: sdhci: msm: Boost controller core clock
Date: Wed, 01 Jul 2015 17:18:03 -0700
Message-ID: <5594833B.7020602@codeaurora.org>
References: <1435317417-369-1-git-send-email-ivan.ivanov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1435317417-369-1-git-send-email-ivan.ivanov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Ivan T. Ivanov" <ivan.ivanov@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Georgi Djakov <georgi.djakov@linaro.org>, Peter Griffin <peter.griffin@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 06/26/2015 04:16 AM, Ivan T. Ivanov wrote:
> Ensure SDCC is working with maximum clock otherwise card
> detection could be extremely slow, up to 7 seconds.
>
> Signed-off-by: Ivan T. Ivanov <ivan.ivanov@linaro.org>
> ---

With the typo fixed.

Acked-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
