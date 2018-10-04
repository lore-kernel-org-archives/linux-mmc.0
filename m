From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] block: BFQ default for single queue devices
Date: Thu, 4 Oct 2018 20:25:53 +0100
Message-ID: <20181004202553.71c2599c@alans-desktop>
References: <20181002124329.21248-1-linus.walleij@linaro.org>
 <05fdbe23-ec01-895f-e67e-abff85c1ece2@kernel.dk>
 <B5321A64-8A1A-42FF-A337-F4524BDA179B@linaro.org>
 <1538582091.205649.20.camel@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <1538582091.205649.20.camel@acm.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, Andreas Herrmann <aherrmann@suse.com>, Ulf Hansson <ulf.hansson@linaro.org>, Paolo Valente <paolo.valente@linaro.org>, Jan Kara <jack@suse.cz>, Mel Gorman <mgorman@suse.com>, Artem Bityutskiy <dedekind1@gmail.com>, Richard Weinberger <richard@nod.at>, Linus Walleij <linus.walleij@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Chunyan Zhang <zhang.chunyan@linaro.org>, linux-block <linux-block@vger.kernel.org>, "'Paolo Valente' via bfq-iosched\"        
 <bfq-iosched@googlegroups.com>, Oleksandr Natalenko
 <oleksandr@natalenko.name>, Mark Brown <broonie@kernel.org>"@fuzix.org, linux-mtd@lists.infradead.org, Pavel Machek <pavel@ucw.cz>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

> I agree with Jens that it's best to leave it to the Linux distributors to
> select a default I/O scheduler.

That assumes such a thing exists. The kernel knows what devices it is
dealing with. The kernel 'default' ought to be 'whatever is usually best
for this device'. A distro cannot just pick a correct single default
because NVME and USB sticks are both normal and rather different in needs.

Alan

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
