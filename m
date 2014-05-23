From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 08/14] mmc: mmci: add 8bit bus support in variant data
Date: Fri, 23 May 2014 11:05:59 +0200
Message-ID: <CACRpkdata-mrAsEYrZOgoW0JeZKY0-umqu9s07n=Qxnmt1y94Q@mail.gmail.com>
References: <1400146447-29803-1-git-send-email-srinivas.kandagatla@linaro.org>
	<1400146636-30138-1-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1400146636-30138-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Russell King <linux@arm.linux.org.uk>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, May 15, 2014 at 11:37 AM,  <srinivas.kandagatla@linaro.org> wrote:

> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>
> This patch adds 8bit bus enable to variant structure giving more flexibility
> to the driver to support more SOCs which have different clock register layout.
>
> Without this patch other new SOCs like Qcom will have to add more code
> to special case them.
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
