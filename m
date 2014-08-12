From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH RFC 3/5] mmc: mmci: relax blksz check for SDIO
Date: Tue, 12 Aug 2014 15:12:43 +0100
Message-ID: <20140812141242.GI30401@n2100.arm.linux.org.uk>
References: <1407844950-8072-1-git-send-email-srinivas.kandadgatla@linaro.org> <1407845080-8353-1-git-send-email-srinivas.kandadgatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1407845080-8353-1-git-send-email-srinivas.kandadgatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: linux-mmc@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Tue, Aug 12, 2014 at 01:04:40PM +0100, Srinivas Kandagatla wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> This patch adds condition in mmci_validate_data to skip checking
> blocksize for SDIO card types. SDIO card type can issue blocksizes
> which are not exactly power of 2 so this check always fails, resulting
> in SDIO failures.

Do you understand why this check is there?

Do you realise that the standard MMCI from ARM Ltd can /only/ perform
power-of-2 block transfers?

Hence, NAK on this change as it stands.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
