From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH v2 3/3] ARM: tegra: fix Venice2 SD card VQMMC supply
Date: Wed, 16 Apr 2014 17:16:45 -0600
Message-ID: <534F0F5D.3030904@wwwdotorg.org>
References: <1397526163-20126-1-git-send-email-abrestic@chromium.org> <1397689719-28882-1-git-send-email-abrestic@chromium.org> <1397689719-28882-4-git-send-email-abrestic@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1397689719-28882-4-git-send-email-abrestic@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Bresticker <abrestic@chromium.org>, Thierry Reding <thierry.reding@gmail.com>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 04/16/2014 05:08 PM, Andrew Bresticker wrote:
> VDDIO_SDMMC3 is the VQMMC (I/O) supply, not the VMMC (core) supply,
> for the SD slot on Venice2.

I've applied this (one patch) to Tegra's for-3.16/dt branch.
