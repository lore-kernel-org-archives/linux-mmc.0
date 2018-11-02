From: Oleksandr Natalenko <oleksandr@natalenko.name>
Subject: Re: [PATCH v2] block: BFQ default for single queue devices
Date: Fri, 02 Nov 2018 11:40:42 +0100
Message-ID: <7fff1835bc9a0a95686db27d524e6818@natalenko.name>
References: <20181015141059.26579-1-linus.walleij@linaro.org>
 <d25e02de-e1be-0fb7-237b-3e53d56c6f64@kernel.dk>
 <307F6078-0A77-4AAA-BE1A-55C2ACC328CC@linaro.org>
 <ab70f1dd-6943-9642-aafa-71840fd44f07@kernel.dk>
 <689F28AA-92B5-48B5-BBE7-0B589F163228@linaro.org>
 <7375c004-ac6e-c692-4282-46de554285d5@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <7375c004-ac6e-c692-4282-46de554285d5@kernel.dk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>, Ulf Hansson <ulf.hansson@linaro.org>, Paolo Valente <paolo.valente@linaro.org>, Jan Kara <jack@suse.cz>, Bart Van Assche <bvanassche@acm.org>, Artem Bityutskiy <dedekind1@gmail.com>, Richard Weinberger <richard@nod.at>, Linus Walleij <linus.walleij@linaro.org>, Jonathan Corbet <corbet@lwn.net>, linux-mmc <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, linux-block <linux-block@vger.kernel.org>, Mark Brown <broonie@kernel.org>, linux-mtd@lists.infradead.org, Pavel Machek <pavel@ucw.cz>, Johannes Thumshirn <jthumshirn@suse.de>, Damien Le Moal <Damien.LeMoal@wdc.com>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>
List-Id: linux-mmc@vger.kernel.org

Hi.

On 16.10.2018 19:35, Jens Axboe wrote:
> Do you have anything more recent? All of these predate the current
> code (by a lot), and isn't even mq. I'm mostly just interested in
> plain fast NVMe device, and a big box hardware raid setup with
> a ton of drives.
> 
> I do still think that this should be going through the distros, they
> need to be the ones driving this, as they will ultimately be the
> ones getting customer reports on regressions. The qual/test cycle
> they do is useful for this. In mainline, if we make a change like
> this, we'll figure out if it worked many releases down the line.

Some benchmarks here for a non-RAID setup obtained by S suite. This is 
from Lenovo T460s with SAMSUNG MZNTY256HDHP-000L7 SSD. v4.19 kernel is 
running with all recent BFQ patches applied.

# replayed gnome terminal startup throughput
# Workload                   bfq         mq-deadline
   0r-raw_seq             13.2617             13.4867
   10r-raw_seq            512.507              539.95

# replayed gnome terminal startup time
# Workload                   bfq         mq-deadline
   0r-raw_seq                0.43                 0.4
   10r-raw_seq               0.685             4.1625

# replayed lowriter startup throughput
# Workload                   bfq         mq-deadline
   0r-raw_seq               9.985              10.375
   10r-raw_seq             516.62              539.61

# replayed lowriter startup time
# Workload                   bfq         mq-deadline
   0r-raw_seq                 0.4              0.3875
   10r-raw_seq              0.535              2.3875

# replayed xterm startup throughput
# Workload                   bfq         mq-deadline
   0r-raw_seq             5.93833             6.10834
   10r-raw_seq            524.447             539.991

# replayed xterm startup time
# Workload                   bfq         mq-deadline
   0r-raw_seq                0.23                0.23
   10r-raw_seq               0.38                1.56

# throughput
# Workload                   bfq         mq-deadline
   10r-raw_rand           362.446             363.817
   10r-raw_seq            537.646             540.609
   1r-raw_seq             500.733             502.526

Throughput-wise, BFQ is on-par with mq-deadline. Latency-wise, BFQ is 
much-much better.

-- 
   Oleksandr Natalenko (post-factum)

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
