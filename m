From: Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH v2] block: BFQ default for single queue devices
Date: Mon, 15 Oct 2018 08:02:15 -0700
Message-ID: <1539615735.129692.3.camel@acm.org>
References: <20181015141059.26579-1-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20181015141059.26579-1-linus.walleij@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: Linus Walleij <linus.walleij@linaro.org>, linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc: Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Ulf Hansson <ulf.hansson@linaro.org>, Paolo Valente <paolo.valente@linaro.org>, Jan Kara <jack@suse.cz>, Artem Bityutskiy <dedekind1@gmail.com>, Richard Weinberger <richard@nod.at>, Jonathan Corbet <corbet@lwn.net>, linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Oleksandr Natalenko <oleksandr@natalenko.name>, Christoph Hellwig <hch@infradead.org>, Mark Brown <broonie@kernel.org>, linux-mtd@lists.infradead.org, Pavel Machek <pavel@ucw.cz>, Johannes Thumshirn <jthumshirn@suse.de>, Damien Le Moal <Damien.LeMoal@wdc.com>
List-Id: linux-mmc@vger.kernel.org

On Mon, 2018-10-15 at 16:10 +0200, Linus Walleij wrote:
> + * For blk-mq devices, we default to using:
> + * - "none" for multiqueue devices (nr_hw_queues != 1)
> + * - "bfq", if available, for single queue devices
> + * - "mq-deadline" if "bfq" is not available for single queue devices
> + * - "none" for single queue devices as well as last resort

For SATA SSDs nr_hw_queues == 1 so this patch will also affect these SSDs.
Since this patch is an attempt to improve performance, I'd like to see
measurement data for one or more recent SATA SSDs before a decision is
taken about what to do with this patch. 

Thanks,

Bart.


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
