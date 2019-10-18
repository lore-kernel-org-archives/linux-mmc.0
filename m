From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] mmc: mxs: fix flags passed to dmaengine_prep_slave_sg
Date: Fri, 18 Oct 2019 10:25:21 -0300
Message-ID: <CAOMZO5DUoj4xVZQSvk9Juw9z37UgrMn3g24h2_pAMxuTkBjw4g@mail.gmail.com>
References: <20191018093934.29695-1-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20191018093934.29695-1-s.hauer@pengutronix.de>
Sender: stable-owner@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Bruno Thomsen <bruno.thomsen@gmail.com>, stable <stable@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi Sascha,

On Fri, Oct 18, 2019 at 6:39 AM Sascha Hauer <s.hauer@pengutronix.de> wrote:
>
> Since ceeeb99cd821 we no longer abuse the DMA_CTRL_ACK flag for custom
> driver use and introduced the MXS_DMA_CTRL_WAIT4END instead. We have not
> changed all users to this flag though. This patch fixes it for the
> mxs-mmc driver.

If I read this correctly, this patch is not the complete fix for all users.

Wouldn't it be better to revert the offending commit instead?
