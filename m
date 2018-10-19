From: Paolo Valente <paolo.valente@linaro.org>
Subject: Re: [PATCH v2] block: BFQ default for single queue devices
Date: Fri, 19 Oct 2018 12:59:04 +0200
Message-ID: <E2DDE0B9-F693-4EF3-B90C-C57F787B4DB3@linaro.org>
References: <20181015141059.26579-1-linus.walleij@linaro.org>
 <d25e02de-e1be-0fb7-237b-3e53d56c6f64@kernel.dk>
 <307F6078-0A77-4AAA-BE1A-55C2ACC328CC@linaro.org>
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <307F6078-0A77-4AAA-BE1A-55C2ACC328CC@linaro.org>
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
Cc: Christoph Hellwig <hch@infradead.org>, Ulf Hansson <ulf.hansson@linaro.org>, Jan Kara <jack@suse.cz>, Bart Van Assche <bvanassche@acm.org>, Artem Bityutskiy <dedekind1@gmail.com>, Richard Weinberger <richard@nod.at>, Linus Walleij <linus.walleij@linaro.org>, Jonathan Corbet <corbet@lwn.net>, linux-mmc <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Oleksandr Natalenko <oleksandr@natalenko.name>, linux-block <linux-block@vger.kernel.org>, Mark Brown <broonie@kernel.org>, linux-mtd@lists.infradead.org, Pavel Machek <pavel@ucw.cz>, Johannes Thumshirn <jthumshirn@suse.de>, Damien Le Moal <Damien.LeMoal@wdc.com>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>
List-Id: linux-mmc@vger.kernel.org



> Il giorno 15 ott 2018, alle ore 20:26, Paolo Valente <paolo.valente@linaro.org> ha scritto:
> 
> ...
>> This kind of policy does not belong in the kernel, at least
>> not in the current form. If we had some sort of "enable best
>> options for a desktop" then it could fall under that umbrella.
>> 
> 
> I don't think bfq can be considered a scheduler for only desktops any
> longer.
> 

Hi Jens,
this reply of mine went on bugging me, until I understood my mistake.

The fact that I consider bfq good also for servers *does not* imply
that having bfq in desktops is to be refused.

As for the option that you are hinting at, I also acknowledge that it
would be trivial for an admin/developer to know whether a given kernel
is meant for a desktop/personal system, while it is more difficult to
choose explicitly among the various I/O schedulers available.

So, I apologize for my shortsighted, initial reply, and ask you if can
elaborate a little more on this.  I'm willing to help, if I can.

Thanks,
Paolo

> Thanks,
> Paolo
> 
>> -- 
>> Jens Axboe


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
