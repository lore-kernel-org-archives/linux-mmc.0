From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v3 13/13] mmc: mmci: Add Qcom specific pio_read function.
Date: Wed, 28 May 2014 10:08:21 +0200
Message-ID: <CACRpkdb+pUn=9UkEVhK_2nL8C2wq_6qOuuRV52TRnj1hJiHvSg@mail.gmail.com>
References: <1400849362-7007-1-git-send-email-srinivas.kandagatla@linaro.org>
	<1400849589-7626-1-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1400849589-7626-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Russell King <linux@arm.linux.org.uk>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Fri, May 23, 2014 at 2:53 PM,  <srinivas.kandagatla@linaro.org> wrote:

> +       if (unlikely(bytes)) {
> +               unsigned char buf[4];
(...)

Please think twice about this.
http://lwn.net/Articles/70473/
http://lwn.net/Articles/420019/
http://lwn.net/Articles/182369/

Yours,
Linus Walleij
