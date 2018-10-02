From: Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH] block: BFQ default for single queue devices
Date: Tue, 02 Oct 2018 23:28:59 +0200
Message-ID: <12312155.XfG6iRcV51@blindfold>
References: <20181002124329.21248-1-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20181002124329.21248-1-linus.walleij@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Jens Axboe <axboe@kernel.dk>, Ulf Hansson <ulf.hansson@linaro.org>, Paolo Valente <paolo.valente@linaro.org>, Artem Bityutskiy <dedekind1@gmail.com>, linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, linux-block@vger.kernel.org, linux-mtd@lists.infradead.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-mmc@vger.kernel.org

Linus,

Am Dienstag, 2. Oktober 2018, 14:43:29 CEST schrieb Linus Walleij:
> This sets BFQ as the default scheduler for single queue
> block devices (nr_hw_queues == 1) if it is available. This
> affects notably MMC/SD-cards but notably also UBI and
> the loopback device.

did you notice a difference for UBI?
Strictly speaking it affects only ubibock, the read-only
block device on top of an UBI volume.

Thanks,
//richard



______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
