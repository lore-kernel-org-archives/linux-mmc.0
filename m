From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 09/14] mmc: mmci: add edge support to data and command
 out in variant data.
Date: Fri, 23 May 2014 11:06:57 +0200
Message-ID: <CACRpkdZX9zyc2agXbbAXoODA9c6iLgJxjq7XVBRpfRPtkxvh3g@mail.gmail.com>
References: <1400146447-29803-1-git-send-email-srinivas.kandagatla@linaro.org>
	<1400146643-30179-1-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1400146643-30179-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Russell King <linux@arm.linux.org.uk>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, May 15, 2014 at 11:37 AM,  <srinivas.kandagatla@linaro.org> wrote:

> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>
> This patch adds edge support for data and command out to variant structure
> giving more flexibility to the driver to support more SOCs which have
> different clock register layout.
>
> Without this patch other new SOCs like Qcom will have to add more code to
> special case them
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
