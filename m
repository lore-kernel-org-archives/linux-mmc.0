From: Alexandre Courbot <acourbot@nvidia.com>
Subject: Re: [PATCH 1/1] mmc: pwrseq: Fix error code propagation in mmc_pwrseq_simple_alloc()
Date: Tue, 14 Apr 2015 11:00:32 +0900
Message-ID: <552C74C0.90000@nvidia.com>
References: <1428934061-29217-1-git-send-email-javier.martinez@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1428934061-29217-1-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Olof Johansson <olof@lixom.net>, Doug Anderson <dianders@chromium.org>, Kevin Hilman <khilman@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 04/13/2015 11:07 PM, Javier Martinez Canillas wrote:
> If the struct mmc_pwrseq_match .alloc function used to allocate a
> struct mmc_pwrseq fails, the error is propagated to mmc_of_parse().
>
> But instead of returning the error code in pwrseq, host->pwrseq is
> returned which will always be 0. So mmc_of_parse() succeeds even if
> the pwrseq .alloc function failed and host->pwrseq is NULL.
>
> This makes the SDIO device to not be powered if the power sequencing
> .alloc functions wants to be deferred due a missing resource because
> the mmc controller driver probe did wrongly succeed.
>
> Fixes: 0f12a0ce4ce4a ("mmc: pwrseq: simplify alloc/free hooks")
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

I obviously overlooked that one. Thanks for fixing it.

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
