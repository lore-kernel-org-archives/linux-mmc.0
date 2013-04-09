From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v4] mmc: dw_mmc: let device core setup the default pin configuration
Date: Tue, 9 Apr 2013 16:30:09 -0700
Message-ID: <CAD=FV=VJ-ykDNqYKQ=fqxeOD6bRNLW02VT4bjsRHRAuXLcCpQQ@mail.gmail.com>
References: <1365487186-4587-1-git-send-email-thomas.abraham@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1365487186-4587-1-git-send-email-thomas.abraham@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Thomas Abraham <thomas.abraham@linaro.org>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, linux-samsung-soc@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, Girish Shivananjappa <girish.shivananjappa@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Tomasz Figa <t.figa@samsung.com>, =?ISO-8859-1?Q?Heiko_St=FCbner?= <heiko@sntech.de>, Linus Walleij <linus.walleij@linaro.org>, patches@linaro.org
List-Id: linux-mmc@vger.kernel.org

Thomas,

On Mon, Apr 8, 2013 at 10:59 PM, Thomas Abraham
<thomas.abraham@linaro.org> wrote:
> @@ -2002,7 +1994,7 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
>                 if (ret) {
>                         dev_err(host->dev,
>                                 "failed to enable regulator: %d\n", ret);
> -                       goto err_setup_bus;
> +                       return ret;

It seems like you'd need a "mmc_free_host(mmc);" in this case don't
you?  AKA: this should be a goto and not a return.

-Doug
