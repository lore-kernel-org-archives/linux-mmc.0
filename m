From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v6 10/12] mmc: mmci: add explicit clk control
Date: Wed, 11 Jun 2014 14:50:12 +0200
Message-ID: <CACRpkda=ZU2NoTjw1b_h8kv4TYPrmxqv5o-3hN+s1oidNV646Q@mail.gmail.com>
References: <1401699818-11329-1-git-send-email-srinivas.kandagatla@linaro.org>
	<1401700195-11834-1-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1401700195-11834-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Russell King <linux@arm.linux.org.uk>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Mon, Jun 2, 2014 at 11:09 AM,  <srinivas.kandagatla@linaro.org> wrote:

> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>
> On Controllers like Qcom SD card controller where cclk is mclk and mclk should
> be directly controlled by the driver.
>
> This patch adds support to control mclk directly in the driver, and also
> adds explicit_mclk_control flag in variant structure giving more flexibility
> to the driver.
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
