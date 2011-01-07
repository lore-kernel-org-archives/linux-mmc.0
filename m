From: Will Newton <will.newton@gmail.com>
Subject: Re: [PATCH] mmc: mshci: Add support Mobile Storage Host Controller Interface
Date: Fri, 7 Jan 2011 16:03:48 +0000
Message-ID: <AANLkTimQSQ2GViH3VFj6Z+beuwRStPGJqzqMpxZkYjMo@mail.gmail.com>
References: <1294399237-5716-1-git-send-email-kgene.kim@samsung.com>
	<20110107115123.GD32436@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20110107115123.GD32436@pengutronix.de>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: Kukjin Kim <kgene.kim@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org, ben-linux@fluff.org, akpm@linux-foundation.org, cjb@laptop.org, Hyunsung Jang <hs79.jang@samsung.com>, Hyuk Lee <hyuk1.lee@samsung.com>
List-Id: linux-mmc@vger.kernel.org

On Fri, Jan 7, 2011 at 11:51 AM, Wolfram Sang <w.sang@pengutronix.de> wrote:
>
>> The 'mshci.c' is based on 'linux/drivers/mmc/host/sdhci.c' and
>> the role is exactly same with that.
>
> Can you sum up the differences why you cannot sdhci.c directly, please?

The driver looks like it is for the same block (or very close) to the
Synopsys DesignWare IP driver I submitted last month called dw_mmc. It
would be interesting to see if that driver might be a suitable
replacement.
