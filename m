From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH] mmc: mxs: fix flags passed to dmaengine_prep_slave_sg
Date: Fri, 18 Oct 2019 15:34:35 +0200
Message-ID: <20191018133435.oncn7nktihpqyj4z@pengutronix.de>
References: <20191018093934.29695-1-s.hauer@pengutronix.de>
 <CAOMZO5DUoj4xVZQSvk9Juw9z37UgrMn3g24h2_pAMxuTkBjw4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAOMZO5DUoj4xVZQSvk9Juw9z37UgrMn3g24h2_pAMxuTkBjw4g@mail.gmail.com>
Sender: stable-owner@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Bruno Thomsen <bruno.thomsen@gmail.com>, stable <stable@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Fri, Oct 18, 2019 at 10:25:21AM -0300, Fabio Estevam wrote:
> Hi Sascha,
> 
> On Fri, Oct 18, 2019 at 6:39 AM Sascha Hauer <s.hauer@pengutronix.de> wrote:
> >
> > Since ceeeb99cd821 we no longer abuse the DMA_CTRL_ACK flag for custom
> > driver use and introduced the MXS_DMA_CTRL_WAIT4END instead. We have not
> > changed all users to this flag though. This patch fixes it for the
> > mxs-mmc driver.
> 
> If I read this correctly, this patch is not the complete fix for all users.
> 
> Wouldn't it be better to revert the offending commit instead?

We would probably also have to revert the exec_op conversion of the gpmi
NAND driver, something which I'd rather not do.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
