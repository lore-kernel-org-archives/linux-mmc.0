From: Bryan Gurney <bgurney@redhat.com>
Subject: Re: [PATCH v2] block: BFQ default for single queue devices
Date: Wed, 17 Oct 2018 10:59:25 -0400
Message-ID: <CAHhmqcSb45qePdKsidQcEk7bNeZC5h6Oew-qH=LA7dsQL_uhSg@mail.gmail.com>
References: <20181015141059.26579-1-linus.walleij@linaro.org>
 <d25e02de-e1be-0fb7-237b-3e53d56c6f64@kernel.dk>
 <307F6078-0A77-4AAA-BE1A-55C2ACC328CC@linaro.org>
 <ab70f1dd-6943-9642-aafa-71840fd44f07@kernel.dk>
 <689F28AA-92B5-48B5-BBE7-0B589F163228@linaro.org>
 <7375c004-ac6e-c692-4282-46de554285d5@kernel.dk>
 <20181017100526.GB23493@quack2.suse.cz>
 <d1d082f3-d681-02ed-5bbe-5eb011d6b0da@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <d1d082f3-d681-02ed-5bbe-5eb011d6b0da@acm.org>
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
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>, Ulf Hansson <ulf.hansson@linaro.org>, Paolo Valente <paolo.valente@linaro.org>, Jan Kara <jack@suse.cz>, Artem Bityutskiy <dedekind1@gmail.com>, Richard Weinberger <richard@nod.at>, Linus Walleij <linus.walleij@linaro.org>, Jonathan Corbet <corbet@lwn.net>, linux-mmc <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Oleksandr Natalenko <oleksandr@natalenko.name>, linux-block <linux-block@vger.kernel.org>, Mark Brown <broonie@kernel.org>, linux-mtd@lists.infradead.org, Pavel Machek <pavel@ucw.cz>, Johannes Thumshirn <jthumshirn@suse.de>, Damien Le Moal <Damien.LeMoal@wdc.com>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>
List-Id: linux-mmc@vger.kernel.org

On Wed, Oct 17, 2018 at 10:48 AM, Bart Van Assche <bvanassche@acm.org> wrote:
> On 10/17/18 3:05 AM, Jan Kara wrote:
>>
>> Well, the problem with this is that big distro people really don't care
>> much because they already use udev for tuning the IO scheduler. So
>> whatever
>> defaults the kernel is going to pick likely won't be seen by distro
>> customers. Embedded people seem to be driving this effort because they
>> either don't run udev or they feel not all their teams building new
>> products have enough expertise to come up with a proper set of rules...
>
>
> What's missing in this discussion is a definition of "embedded system". Is
> that a system like a streaming player for TV channels that neither has a
> keyboard nor a display or a system that can run multiple apps simultaneously
> like a smartphone? I think the difference matters because some embedded
> devices hardly do any background I/O nor load any executable code from
> storage after boot. So at least for some embedded devices the problem
> discussed in this e-mail thread does not exist.
>
> Bart.

There are high-performance embedded systems on the market (NAS, etc.).

I feel strongly about the prevention of users running into errors
because of an incorrect scheduler default, because I encountered that
situation three times in my testing with zoned block devices.  The
switch to SCSI_MQ would resolve that, since mq-deadline is the
default, but in my case, I was using Fedora 28, which disables
CONFIG_SCSI_MQ_DEFAULT (which is enabled in the 4.18 kernel), so my
default scheduler was cfq.

Hopefully there aren't any other cases where choosing the "wrong
default scheduler" leads to errors.  Ideally the default scheduler
choice should prevent any errors, leaving it up to the distros to
configure a default via other methods, to optimize for performance.


Thanks,

Bryan

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
