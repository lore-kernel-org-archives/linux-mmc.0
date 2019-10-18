From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] mmc: mxs: fix flags passed to dmaengine_prep_slave_sg
Date: Fri, 18 Oct 2019 12:58:07 -0300
Message-ID: <CAOMZO5DLebwVYJGfT=n+j3T62Ps8eJAZWKCb55Xck=thimubrA@mail.gmail.com>
References: <20191018093934.29695-1-s.hauer@pengutronix.de>
 <CAOMZO5DUoj4xVZQSvk9Juw9z37UgrMn3g24h2_pAMxuTkBjw4g@mail.gmail.com> <20191018133435.oncn7nktihpqyj4z@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20191018133435.oncn7nktihpqyj4z@pengutronix.de>
Sender: stable-owner@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Bruno Thomsen <bruno.thomsen@gmail.com>, stable <stable@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Fri, Oct 18, 2019 at 10:34 AM Sascha Hauer <s.hauer@pengutronix.de> wrote:

> We would probably also have to revert the exec_op conversion of the gpmi
> NAND driver, something which I'd rather not do.

Ok, understood. Thanks for the clarification.

Better go with your patch then.

Thanks
