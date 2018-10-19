From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2] block: BFQ default for single queue devices
Date: Fri, 19 Oct 2018 10:33:47 +0200
Message-ID: <CACRpkdZgethKLu3P4taLfzqjGULyoP-T7bhUUpRKtjDRteNnxA@mail.gmail.com>
References: <20181015141059.26579-1-linus.walleij@linaro.org>
 <18744e21b9f5aa4b3ab721a007a3e9a2@natalenko.name>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <18744e21b9f5aa4b3ab721a007a3e9a2@natalenko.name>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: Oleksandr Natalenko <oleksandr@natalenko.name>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>, Ulf Hansson <ulf.hansson@linaro.org>, Paolo Valente <paolo.valente@linaro.org>, Jan Kara <jack@suse.cz>, Bart Van Assche <bvanassche@acm.org>, Artem Bityutskiy <dedekind1@gmail.com>, Richard Weinberger <richard@nod.at>, Jonathan Corbet <corbet@lwn.net>, linux-mmc <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, linux-block <linux-block@vger.kernel.org>, Mark Brown <broonie@kernel.org>, linux-mtd@lists.infradead.org, Pavel Machek <pavel@ucw.cz>, Johannes Thumshirn <jthumshirn@suse.de>, Damien Le Moal <Damien.LeMoal@wdc.com>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
List-Id: linux-mmc@vger.kernel.org

On Mon, Oct 15, 2018 at 4:32 PM Oleksandr Natalenko
<oleksandr@natalenko.name> wrote:
> On 15.10.2018 16:10, Linus Walleij wrote:

> > +     /*
> > +      * Zoned devices must use a deadline scheduler because currently
> > +      * that is the only scheduler respecting zoned writes.
> > +      */
> > +     if (blk_queue_is_zoned(q))
> > +             policy = "mq-deadline";
> > +     else if (IS_ENABLED(CONFIG_IOSCHED_BFQ))
> > +             policy = "bfq";
> > +     else
> > +             policy = "mq-deadline";
>
> If more rules will be needed in the future, shall we just add extra ifs,
> or it would be better to craft some struct/table now + policy search
> helper?

Let's do it when it happens. Premature optimization is the root
of all evil ;)

Yours,
Linus Walleij

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
