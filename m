From: Paolo Valente <paolo.valente@linaro.org>
Subject: Re: [PATCH v2] block: BFQ default for single queue devices
Date: Mon, 15 Oct 2018 20:34:56 +0200
Message-ID: <B1F49414-FD49-49EE-877A-B4C2913ED072@linaro.org>
References: <20181015141059.26579-1-linus.walleij@linaro.org>
 <1539615735.129692.3.camel@acm.org>
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <1539615735.129692.3.camel@acm.org>
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
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>, Ulf Hansson <ulf.hansson@linaro.org>, Jan Kara <jack@suse.cz>, 'Paolo Valente' via bfq-iosched <bfq-iosched@googlegroups.com>, Artem Bityutskiy <dedekind1@gmail.com>, Richard Weinberger <richard@nod.at>, Linus Walleij <linus.walleij@linaro.org>, Jonathan Corbet <corbet@lwn.net>, linux-mmc <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Oleksandr Natalenko <oleksandr@natalenko.name>, linux-block <linux-block@vger.kernel.org>, Mark Brown <broonie@kernel.org>, linux-mtd@lists.infradead.org, Pavel Machek <pavel@ucw.cz>, Johannes Thumshirn <jthumshirn@suse.de>, Damien Le Moal <Damien.LeMoal@wdc.com>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>
List-Id: linux-mmc@vger.kernel.org



> Il giorno 15 ott 2018, alle ore 17:02, Bart Van Assche <bvanassche@acm.org> ha scritto:
> 
> On Mon, 2018-10-15 at 16:10 +0200, Linus Walleij wrote:
>> + * For blk-mq devices, we default to using:
>> + * - "none" for multiqueue devices (nr_hw_queues != 1)
>> + * - "bfq", if available, for single queue devices
>> + * - "mq-deadline" if "bfq" is not available for single queue devices
>> + * - "none" for single queue devices as well as last resort
> 
> For SATA SSDs nr_hw_queues == 1 so this patch will also affect these SSDs.
> Since this patch is an attempt to improve performance, I'd like to see
> measurement data for one or more recent SATA SSDs before a decision is
> taken about what to do with this patch. 
> 

Hi Bart,
as I just wrote to Jens I don't think we need this test any longer.
To save you one hope, I'll paste my reply to Jens below.

Anyway, it is very easy to do the tests you ask:
- take a kernel containing the last bfq commits, such as for-next
- do, e.g.,
git clone https://github.com/Algodev-github/S.git
cd S/run_multiple_benchmarks
sudo ./run_main_benchmarks.sh "throughput replayed-startup" "bfq none"
- compare results

Of course, do not do it for multi-queue devices or single-queues
devices, on steroids, that do 400-500 KIOPS.

I'll see if I can convince someone to repeat these tests with a recent
SSD.

And here is again my reply to Jens, which I think holds for your repeated
objection too.

I tested bfq on virtually every device in the range from few hundred
of IOPS to 50-100KIOPS.  Then, through the public script I already
mentioned, I found the maximum number of IOPS that bfq can handle:
about 400K with a commodity CPU.

In particular, in all my tests with real hardware, bfq performance
- is not even comparable to that of any of the other scheduler, in
 terms of responsiveness, latency for real-time applications, ability
 to provide strong bandwidth guarantees, ability to boost throughput
 while guaranteeing bandwidths;
- is a little worse than the other schedulers for only one test, on
 only some hardware: total throughput with random reads, were it may
 lose up to 10-15% of throughput.  Of course, the schedulers that reach
 a higher throughput leave the machine unusable during the test.

So I really cannot see a reason why bfq could do worse than any of
these other schedulers for some single-queue device (conservatively)
below 300KIOPS.

Finally, since, AFAICT, single-queue devices doing 400+ KIOPS are
probably less than 1% of all the single-queue storage around (USB
drives, HDDs, eMMC, standard SSDs, ...), by sticking to mq-deadline we
are sacrificing 99% of the hardware, to help 1% of the hardware for
one kind of test cases.

Thanks,
Paolo

> Thanks,
> 
> Bart.
> 


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
