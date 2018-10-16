From: Federico Motta <federico@willer.it>
Subject: Re: [PATCH v2] block: BFQ default for single queue devices
Date: Tue, 16 Oct 2018 18:14:26 +0200
Message-ID: <39c65b8e-c13c-5a84-cc28-5b06345dd568@willer.it>
References: <20181015141059.26579-1-linus.walleij@linaro.org>
 <1539615735.129692.3.camel@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <1539615735.129692.3.camel@acm.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: Bart Van Assche <bvanassche@acm.org>, Linus Walleij <linus.walleij@linaro.org>, linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc: Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Ulf Hansson <ulf.hansson@linaro.org>, Paolo Valente <paolo.valente@linaro.org>, Jan Kara <jack@suse.cz>, Artem Bityutskiy <dedekind1@gmail.com>, Richard Weinberger <richard@nod.at>, Jonathan Corbet <corbet@lwn.net>, linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Oleksandr Natalenko <oleksandr@natalenko.name>, Christoph Hellwig <hch@infradead.org>, Mark Brown <broonie@kernel.org>, linux-mtd@lists.infradead.org, Pavel Machek <pavel@ucw.cz>, Johannes Thumshirn <jthumshirn@suse.de>, Damien Le Moal <Damien.LeMoal@wdc.com>
List-Id: linux-mmc@vger.kernel.org

On 10/15/18 5:02 PM, Bart Van Assche wrote:
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
> Thanks,
> 
> Bart.
> 

Hi,
although these tests should be run for single-queue devices, I tried to
run them on an NVMe high-performance device. Imho if results are good
in such a "difficult to deal with" multi-queue device, they should be
good enough also in a "simpler" single-queue storage device..

Testbed specs:
kernel = 4.18.0 (from bfq dev branch [1], where bfq already contains
                 also the commits that will be available from 4.20)
fs     = ext4
drive  = ssd samsung 960 pro NVMe m.2 512gb

Device data sheet specs state that under random IO:
* QD  1 thread 1
  * read  = 14 kIOPS
  * write = 50 kIOPS
* QD 32 thread 4
  * read = write = 330 kIOPS

What follows is a results summary; under requests I can give all
results. The workload notation (e.g. 5r5w-seq) means:
- num_readers                  (5r)
- num_writers                  (5w)
- sequential_io or random_io   (-seq)


# replayed gnome-terminal startup time (lower is better)
workload  bfq-mq [s]  none [s]  % gain
--------  ----------  --------  ------
 10r-seq    0.3725      2.79     86.65
5r5w-seq    0.9725      5.53     82.41

# throughput (higher is better)
workload   bfq-mq [mb/s]  none [mb/s]   % gain
---------  -------------  -----------  -------
 10r-rand       394.806      429.735    -8.128
 10r-seq       1387.63      1431.81     -3.086
  1r-seq        838.13       798.872     4.914
5r5w-rand      1118.12      1297.46    -13.822
5r5w-seq       1187         1313.8      -9.651

Thanks,
Federico

[1] https://github.com/Algodev-github/bfq-mq/commits/bfq-mq

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
