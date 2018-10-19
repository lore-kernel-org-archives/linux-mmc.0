From: Oleksandr Natalenko <oleksandr@natalenko.name>
Subject: Re: [PATCH v2] block: BFQ default for single queue devices
Date: Fri, 19 Oct 2018 11:26:37 +0200
Message-ID: <42fc6a366e88335b72517ea7d58847fd@natalenko.name>
References: <20181015141059.26579-1-linus.walleij@linaro.org>
 <18744e21b9f5aa4b3ab721a007a3e9a2@natalenko.name>
 <CACRpkdZgethKLu3P4taLfzqjGULyoP-T7bhUUpRKtjDRteNnxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <CACRpkdZgethKLu3P4taLfzqjGULyoP-T7bhUUpRKtjDRteNnxA@mail.gmail.com>
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
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>, Ulf Hansson <ulf.hansson@linaro.org>, Paolo Valente <paolo.valente@linaro.org>, Jan Kara <jack@suse.cz>, Bart Van Assche <bvanassche@acm.org>, Artem Bityutskiy <dedekind1@gmail.com>, Richard Weinberger <richard@nod.at>, Jonathan Corbet <corbet@lwn.net>, linux-mmc <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, linux-block <linux-block@vger.kernel.org>, Mark Brown <broonie@kernel.org>, linux-mtd@lists.infradead.org, Pavel Machek <pavel@ucw.cz>, Johannes Thumshirn <jthumshirn@suse.de>, Damien Le Moal <Damien.LeMoal@wdc.com>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
List-Id: linux-mmc@vger.kernel.org

Hi.

On 19.10.2018 10:33, Linus Walleij wrote:
>> > +     /*
>> > +      * Zoned devices must use a deadline scheduler because currently
>> > +      * that is the only scheduler respecting zoned writes.
>> > +      */
>> > +     if (blk_queue_is_zoned(q))
>> > +             policy = "mq-deadline";
>> > +     else if (IS_ENABLED(CONFIG_IOSCHED_BFQ))
>> > +             policy = "bfq";
>> > +     else
>> > +             policy = "mq-deadline";
>> 
>> If more rules will be needed in the future, shall we just add extra 
>> ifs,
>> or it would be better to craft some struct/table now + policy search
>> helper?
> 
> Let's do it when it happens. Premature optimization is the root
> of all evil ;)

I'd say, this is a matter of code readability, not optimisations. I do 
not strongly object against current approach, though.

-- 
   Oleksandr Natalenko (post-factum)

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
