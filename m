From: Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v2] block: BFQ default for single queue devices
Date: Thu, 18 Oct 2018 09:21:10 +0200
Message-ID: <20181018072110.GI23493@quack2.suse.cz>
References: <20181015141059.26579-1-linus.walleij@linaro.org>
 <d25e02de-e1be-0fb7-237b-3e53d56c6f64@kernel.dk>
 <307F6078-0A77-4AAA-BE1A-55C2ACC328CC@linaro.org>
 <ab70f1dd-6943-9642-aafa-71840fd44f07@kernel.dk>
 <689F28AA-92B5-48B5-BBE7-0B589F163228@linaro.org>
 <7375c004-ac6e-c692-4282-46de554285d5@kernel.dk>
 <20181017100526.GB23493@quack2.suse.cz>
 <e54c3943-0335-6db4-1c86-f093432fd84b@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <e54c3943-0335-6db4-1c86-f093432fd84b@kernel.dk>
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
Cc: Christoph Hellwig <hch@infradead.org>, Ulf Hansson <ulf.hansson@linaro.org>, Paolo Valente <paolo.valente@linaro.org>, Jan Kara <jack@suse.cz>, Bart Van Assche <bvanassche@acm.org>, Artem Bityutskiy <dedekind1@gmail.com>, Richard Weinberger <richard@nod.at>, Linus Walleij <linus.walleij@linaro.org>, Jonathan Corbet <corbet@lwn.net>, linux-mmc <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Oleksandr Natalenko <oleksandr@natalenko.name>, linux-block <linux-block@vger.kernel.org>, Mark Brown <broonie@kernel.org>, linux-mtd@lists.infradead.org, Pavel Machek <pavel@ucw.cz>, Johannes Thumshirn <jthumshirn@suse.de>, Damien Le Moal <Damien.LeMoal@wdc.com>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>
List-Id: linux-mmc@vger.kernel.org

On Wed 17-10-18 10:29:22, Jens Axboe wrote:
> On 10/17/18 4:05 AM, Jan Kara wrote:
> > On Tue 16-10-18 11:35:59, Jens Axboe wrote:
> >> On 10/15/18 1:44 PM, Paolo Valente wrote:
> >>> Here are some old results with a very simple configuration:
> >>> http://algo.ing.unimo.it/people/paolo/disk_sched/old-results/4.4.0-v7r11/
> >>> http://algo.ing.unimo.it/people/paolo/disk_sched/old-results/3.14.0-v7r3/
> >>> http://algo.ing.unimo.it/people/paolo/disk_sched/old-results/3.13.0-v7r2/
> >>>
> >>> Then I stopped repeating tests that always yielded the same good results.
> >>>
> >>> As for more professional systems, a well-known company doing
> >>> real-time packet-traffic dumping asked me to modify bfq so as to
> >>> guarantee lossless data writing also during queries.  The involved box
> >>> had a RAID reaching a few Gbps, and everything worked well.
> >>>
> >>> Anyway, if you have specific issues in mind, I can check more deeply.
> >>
> >> Do you have anything more recent? All of these predate the current
> >> code (by a lot), and isn't even mq. I'm mostly just interested in
> >> plain fast NVMe device, and a big box hardware raid setup with
> >> a ton of drives.
> >>
> >> I do still think that this should be going through the distros, they
> >> need to be the ones driving this, as they will ultimately be the
> >> ones getting customer reports on regressions. The qual/test cycle
> >> they do is useful for this. In mainline, if we make a change like
> >> this, we'll figure out if it worked many releases down the line.
> > 
> > Well, the problem with this is that big distro people really don't care
> > much because they already use udev for tuning the IO scheduler. So whatever
> > defaults the kernel is going to pick likely won't be seen by distro
> > customers. Embedded people seem to be driving this effort because they
> > either don't run udev or they feel not all their teams building new
> > products have enough expertise to come up with a proper set of rules...
> 
> Which is also the approach that I've been advocating for here, instead
> of a kernel patch...

I know you've been advocating the use of udev for IO scheduler selection.
But do you want to force everybody to use udev? And for people who build
their own (usually small) systems, do you want to force them to think about
IO scheduler selection and writing appropriate rules? These are the
problems people were mentioning and I'm not sure what is your opinion on
this.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
