From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 05/11] mmc: mmci: use NSEC_PER_SEC macro
Date: Tue, 13 May 2014 09:20:48 +0200
Message-ID: <CACRpkdYB+6PeY6HMYe1t2VBPrv1sUtZkEimNPPHor9ziaUAztg@mail.gmail.com>
References: <1398759492-12970-1-git-send-email-srinivas.kandagatla@linaro.org>
	<1398759601-13178-1-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1398759601-13178-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Russell King <linux@arm.linux.org.uk>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, agross@quicinc.com, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Tue, Apr 29, 2014 at 10:20 AM,  <srinivas.kandagatla@linaro.org> wrote:

> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>
> This patch replaces a constant used in calculating timeout with a proper
> macro. This is make code more readable.
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

This can be merged out-of-order just as-is.

Yours,
Linus Walleij
